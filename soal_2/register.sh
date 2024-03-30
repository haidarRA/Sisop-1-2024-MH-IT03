#!/bin/bash

email=""
pass=""
username=""
sec_question=""
sec_answer=""
b64=""
isadmin=0

echo "Welcome to Registration System"
echo "Enter your email:"
read email
if [[ $email == *@* ]] && [[ $email == *.* ]] && [[ $email != *['!''#''$''%''^''&''*''~''?''('')''<''>'':'';''['']''{''}''_''-''+''=']* ]]
then
	if [[ $email == *"admin"* ]]
	then
		isadmin=1
	fi

	if grep -q "^$email " ~/users/users.txt; then
		echo "Email already exists. Please use another email."
                echo "[$(date +"%d/%m/%y %H:%M:%S")] [REGISTER FAILED] Email $email failed to register because it already exists." >> ~/users/auth.log
		exit 1
	fi

	echo "Enter your username:"
	read username

	echo "Enter a security question:"
	read sec_question

	echo "Enter the answer to your security question:"
	read sec_answer

	echo "Enter a password (must include at least 8 characters, 1 uppercase letter, 1 lowercase letter, 1 digit, 1 symbol [!, @, #, $, %], and does not contain username):"
	read -s pass
	if [[ $pass == *[abcdefghijklmnopqrstuvwxyz]* ]] && [[ $pass == *[ABCDEFGHIJKLMNOPQRSTUVWXYZ]* ]] && [[ $pass == *[0123456789]* ]] && [[ ${#pass} -gt 8 ]] && [[ $pass == *['!''@''#''$''%']* ]] && [[ $pass != *"$username"* ]]
	then
		b64=$(echo "$pass" | base64)
		if [[ $isadmin -eq 1 ]]
		then
			echo "$email $username admin" >> ~/users/users.txt
		else
			echo "$email $username nonadmin" >> ~/users/users.txt
		fi
		echo "$b64" >> ~/users/users.txt
		echo "$sec_question" >> ~/users/users.txt
		echo -e "$sec_answer\n" >> ~/users/users.txt
		echo "User registered successfully"
        	echo "[$(date +"%d/%m/%y %H:%M:%S")] [REGISTER SUCCESS] User $username with email $email registered successfully." >> ~/users/auth.log
	else
		echo "Password doesn't have the right format. Please create another password with the right format."
                echo "[$(date +"%d/%m/%y %H:%M:%S")] [REGISTER FAILED] User $username with email $email failed to register." >> ~/users/auth.log
	fi
else
	echo "Email doesn't have the right format. Please use another email."
	echo "[$(date +"%d/%m/%y %H:%M:%S")] [REGISTER FAILED] Email $email failed to register." >> ~/users/auth.log
fi
