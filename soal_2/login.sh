#!/bin/bash

email=""
pass=""
checkpass=""
isadmin=""
choice=0
choicead=0
choiceedit=0
emailedit=""

echo "Welcome to Login System"
echo "1. Login"
echo "2. Forgot password"

read choice
if [[ choice -eq 1 ]]
then
	echo "Login"
	echo "Enter your email:"
	read email
	if grep -q "^$email " users/users.txt; then
		checkpass=$(awk '/'$email'/{getline; print}' users/users.txt | base64 --decode)
	        logusername=$(awk '/'$email'/ {print $2}' users/users.txt)
        	echo "Enter your password:"
        	read -s pass
        	if [[ $pass == $checkpass ]]
        	then
			echo "Login successful"
                        echo "[$(date +"%d/%m/%y %H:%M:%S")] [LOGIN SUCCESS] Successful login attempt on user $logusername with email $email." >> users/auth.log
        	        isadmin=$(awk '/'$email'/ {print $3}' users/users.txt)
			if [[ $isadmin == "admin" ]]
			then
				echo "Admin Menu"
				echo "1. Add User"
				echo "2. Edit User"
				echo "3. Delete User"
				echo "4. Logout"
				read choicead

				case "$choicead" in
					1)
						echo "Add another user"
						echo "Enter the email:"
						read addemail
						if [[ $addemail == *@* ]] && [[ $addemail == *.* ]] && [[ $addemail != *['!''#''$''%''^''&''*''~''?''('')''<''>'':'';''['']''{''}''_''-''+''=']* ]]
						then
        						if [[ $addemail == *"admin"* ]]
        						then
                						addisadmin=1
        						fi

        						if grep -q "^$addemail " users/users.txt; then
                						echo "Email already exists. Please use another email."
                						exit 1
        						fi

        						echo "Enter the username:"
        						read addusername

        						echo "Enter the security question:"
        						read addsec_question

        						echo "Enter the answer to the security question:"
        						read addsec_answer

        						echo "Enter a password (must include at least 8 characters, 1 uppercase letter, 1 lowercase letter, 1 digit, 1 symbol [!, @, #, $, %], and does not contain username):"
        						read -s addpass
                                                        if [[ $addpass == *[abcdefghijklmnopqrstuvwxyz]* ]] && [[ $addpass == *[ABCDEFGHIJKLMNOPQRSTUVWXYZ]* ]] && [[ $addpass == *[0123456789]* ]] && [[ ${#addpass} -gt 8 ]] && [[ $addpass == *['!''@''#''$''%']* ]] && [[ $addpass != *"$addusername"* ]]
        						then
                						addb64=$(echo "$addpass" | base64)
                						if [[ $addisadmin -eq 1 ]]
                						then
                        						echo "$addemail $addusername admin" >> users/users.txt
                						else
                        						echo "$addemail $addusername nonadmin" >> users/users.txt
                						fi
                						echo "$addb64" >> users/users.txt
                						echo "$addsec_question" >> users/users.txt
                						echo -e "$addsec_answer\n" >> users/users.txt
                						echo "User registered successfully"
        						else
                						echo "Password doesn't have the right format. Please create another password with the right format."
        						fi
						else
        						echo "Email doesn't have the right format. Please use another email."
						fi
						;;
					2)
						echo "Enter user email that wants to be edited:"
						read emailedit
						if grep -q "^$email " users/users.txt; then
							echo "1. Edit username"
							echo "2. Edit security question and answer"
							echo "3. Edit password"

							read choiceedit
							case "$choiceedit" in
								1)
									oriname=$(awk '/'$emailedit'/ {print $2}' users/users.txt)
									echo "Original name: $oriname"
									echo "Enter new username:"
									read altname

									awk -v email="$emailedit" -v altname="$altname" '$1 == email { $2 = altname } 1' users/users.txt > temp && mv temp users/users.txt
									echo "Successfully changed the username."
									;;
								2)
									oriquestion=$(awk '/'$emailedit'/{getline; getline; print}' users/users.txt)
                                                                        orianswer=$(awk '/'$emailedit'/{getline; getline; getline; print}' users/users.txt)
									echo -e "Original security question and answer: $oriquestion \n$orianswer"
                                                                        echo "Enter new security question:"
                                                                        read altquestion
									echo "Enter new security answer"
									read altanswer
									orianswer=$(awk '/'$emailedit'/{getline; getline; getline; print}' users/users.txt)

									awk -v question="$oriquestion" -v altq="$altquestion" '$0 == question { $0 = altq } 1' users/users.txt > temp && mv temp users/users.txt
                                                                        awk -v answer="$orianswer" -v altans="$altanswer" '$0 == answer { $0 = altans } 1' users/users.txt > temp && mv temp users/users.txt
									echo "Successfully changed the security question and answer."
									;;
								3)
		                                                        ori64=$(awk '/'$emailedit'/{getline; print}' users/users.txt)
									oripass=$( echo "$ori64" | base64 --decode )
									echo "Enter the old password:"
									read -s testpass
									if [[ $testpass == $oripass ]]
									then
										epuname=$(awk '/'$emailedit'/ {print$2}' users/users.txt)
										echo "Enter the new password:"
										read -s altpass
										if [[ $altpass == *[abcdefghijklmnopqrstuvwxyz]* ]] && [[ $altpass == *[ABCDEFGHIJKLMNOPQRSTUVWXYZ]* ]] && [[ $altpass == *[0123456789]* ]] && [[ ${#altpass} -gt 8 ]] && [[ $altpass == *['!''@''#''$''%']* ]] && [[ $altpass != *"$epuname"* ]]
										then
											alt64=$( echo "$altpass" | base64 )
											awk -v oripass="$ori64" -v altpass="$alt64" '$0 == oripass { $0 = altpass } 1' users/users.txt > temp && mv temp users/users.txt
											echo "Successfully changed the password."
										else
											echo "Password doesn't have the right format. Please create another password with the right format."
										fi
									else
										echo "Verification failed. Please try again."
									fi
									;;
							esac
						else
							echo "Email not found."
						fi
						;;
					3)
						echo "Enter the user email that will be removed:"
						read rememail
						if grep -q "^$email " users/users.txt; then
							awk -v email="$rememail" 'BEGIN { RS="\n\n"; ORS="\n\n" } $1 != email { print $0 }' users/users.txt > temp && mv temp users/users.txt
							echo "Successfully removed the user."
						else
							echo "Email not found."
						fi
						;;
					4)
						echo "Logout successful!"
						exit 1
						;;
				esac
			elif [[ $isadmin == "nonadmin" ]]
			then
				echo "You don't have admin privileges. Welcome!"
			fi
        	else
                	echo "Login failed."
                	echo "[$(date +"%d/%m/%y %H:%M:%S")] [LOGIN FAILED] Failed login attempt on user $logusername with email $email." >> users/auth.log
        	fi
	else
		echo "Email not found."
                echo "[$(date +"%d/%m/%y %H:%M:%S")] [LOGIN FAILED] Email $email failed to login because it doesn't exist." >> users/auth.log
        fi

elif [[ choice -eq 2 ]]
then
	echo "Forgot password?"
	echo "Enter your email:"
	read forgemail
        if grep -q "^$forgemail " users/users.txt; then
		forgquestion=$(awk '/'$forgemail'/{getline; getline; print}' users/users.txt)
		echo "Security question: $forgquestion"
		echo "Your answer:"
		read testans
		forganswer=$(awk '/'$forgemail'/{getline; getline; getline; print}' users/users.txt)
		if [[ $testans == $forganswer ]]
		then
			gift64=$(awk '/'$forgemail'/{getline; print}' users/users.txt)
			giftpass=$( echo "$gift64" | base64 --decode )
			echo "Your password: $giftpass"
		else
			echo "You failed the security question. Please try again."
		fi
	else
		echo "Email not found."
	fi
else
	echo "Invalid option."
fi
