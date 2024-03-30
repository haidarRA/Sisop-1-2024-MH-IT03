# Sisop-1-2024-MH-IT03


## ***KELOMPOK IT 03***
| Nama      | NRP         |
  |-----------|-------------|
  | Haidar Rafi Aqyla | 5027231029   |
  | Hasan | 5027231073  |  
  | Muhammad kenas Galeno Putra  | 5027231069  |

# Praktikum Sisop modul 1 (IT03)


# soal 1

**soal :**

Cipung dan abe ingin mendirikan sebuah toko bernama “SandBox”, sedangkan kamu adalah manajer penjualan yang ditunjuk oleh Cipung dan Abe untuk melakukan pelaporan penjualan dan strategi penjualan kedepannya yang akan dilakukan.

Setiap tahun Cipung dan Abe akan mengadakan rapat dengan kamu untuk mengetahui laporan dan strategi penjualan dari “SandBox”. Buatlah beberapa kesimpulan dari data penjualan “Sandbox.csv” untuk diberikan ke cipung dan abe 

Karena Cipung dan Abe baik hati, mereka ingin memberikan hadiah kepada customer yang telah belanja banyak. Tampilkan nama pembeli dengan total sales paling tinggi
Karena karena Cipung dan Abe ingin mengefisienkan penjualannya, mereka ingin merencanakan strategi penjualan untuk customer segment yang memiliki profit paling kecil. Tampilkan customer segment yang memiliki profit paling kecil
Cipung dan Abe hanya akan membeli stok barang yang menghasilkan profit paling tinggi agar efisien. Tampilkan 3 category yang memiliki total profit paling tinggi 
Karena ada seseorang yang lapor kepada Cipung dan Abe bahwa pesanannya tidak kunjung sampai, maka mereka ingin mengecek apakah pesanan itu ada. Cari purchase date dan amount (quantity) dari nama adriaens


**STEP**

1. Mkdir bebas (untuk membuat direktori)
 ```
2. curl -L -o sandbox.csv 'https://drive.google.com/uc?id=1cC6MYBI3wRwDgqlFQE1OQUN83JAreId0&export=download' | awk -F'/' '/filename/{print $NF}' RS='&'
 ```
(download sandbox.csv, disini kita pake curl supaya lebih fleksibel) 
  
3. Touch sandbox.sh (untuk membuat file sandbox.sh)
 
4. Chmod +x sandbox.sh (memberikan permission terhadap file)
 
5. nano sandbox.sh (edit dulu!!!)

Isi Script sandbox.sh
```
#!/bin/bash

   penjualan_tergede=$(awk -F',' 'NR>1 {penjualan[$6] += $17} END {for (customer in penjualan) print penjualan[customer], customer}' sandbox.csv | sort -nr | head -1)
   echo "penjualan Tertinggi:"
   echo "$penjualan_tergede"

   profit_tercilik=$(awk -F',' 'NR>1 {profit[$7] += $20} END {for (segment in profit) print profit[segment], segment}' sandbox.csv | sort -t',' -k1,1n | head -1)
   echo "Total Profit terendah:"
   echo "$profit_tercilik"

   profit_tergede=$(awk -F',' 'NR>1 {profit[$14] += $20} END {for (category in profit) print profit[category], category}' sandbox.csv | sort -t',' -k1,1nr | head -3)
   echo "3 Kategori dengan Profit Most High: "
   echo "$profit_tergede"

   pesanan=$(awk -F',' 'NR>1 && $6=="Adriaens Grayland" {print $2 "," $17}' sandbox.csv)
   echo "Detail Pesanan Adriaens:"
   echo "$pesanan"
   ```
6. bash sandbox.sh

   ![Screenshot 2024-03-30 164808](https://github.com/haidarRA/Sisop-1-2024-MH-IT03/assets/150374973/b76d17d8-60ef-469b-99aa-9ef6f52551ec)

**Pengerjaan**
![Screenshot 2024-03-30 165735](https://github.com/haidarRA/Sisop-1-2024-MH-IT03/assets/150374973/8c9e1377-fc06-4778-9ef0-232f8b12779f)

**Kendala yang saya alami** 
1. Saat pengerjaan ubuntu di laptop saya eror yang mana tidak bisa membaca file OS
2. Tidak bisa upload github dan saya menggunakan laptop hasan


# soal 2

**soal :**

Oppie merupakan seorang peneliti bom atom, ia ingin merekrut banyak peneliti lain untuk mengerjakan proyek bom atom nya, Oppie memiliki racikan bom atom rahasia yang hanya bisa diakses penelitinya yang akan diidentifikasi sebagai user, Oppie juga memiliki admin yang bertugas untuk memanajemen peneliti,  bantulah oppie untuk membuat program yang akan memudahkan tugasnya 
Buatlah 2 program yaitu login.sh dan register.sh
Setiap admin maupun user harus melakukan register terlebih dahulu menggunakan email, username, pertanyaan keamanan dan jawaban, dan password

Username yang dibuat bebas, namun email bersifat unique. setiap email yang mengandung kata admin akan dikategorikan menjadi admin 
Karena resep bom atom ini sangat rahasia Oppie ingin password nya memuat keamanan tingkat tinggi
Password tersebut harus di encrypt menggunakan base64
Password yang dibuat harus lebih dari 8 karakter
Harus terdapat paling sedikit 1 huruf kapital dan 1 huruf kecil
Harus terdapat paling sedikit 1 angka 
Karena Oppie akan memiliki banyak peneliti dan admin ia berniat untuk menyimpan seluruh data register yang ia lakukan ke dalam folder users file users.txt. Di dalam file tersebut, terdapat catatan seluruh email, username, pertanyaan keamanan dan jawaban, dan password hash yang telah ia buat.
Setelah melakukan register, program harus bisa melakukan login. Login hanya perlu dilakukan menggunakan email dan password.
Karena peneliti yang di rekrut oleh Oppie banyak yang sudah tua dan pelupa maka Oppie ingin ketika login akan ada pilihan lupa password dan akan keluar pertanyaan keamanan dan ketika dijawab dengan benar bisa memunculkan password

Setelah user melakukan login akan keluar pesan sukses, namun setelah seorang admin melakukan login Oppie ingin agar admin bisa menambah, mengedit (username, pertanyaan keamanan dan jawaban, dan password), dan menghapus user untuk memudahkan kerjanya sebagai admin. 

Ketika admin ingin melakukan edit atau hapus user, maka akan keluar input email untuk identifikasi user yang akan di hapus atau di edit
Oppie ingin programnya tercatat dengan baik, maka buatlah agar program bisa mencatat seluruh log ke dalam folder users file auth.log, baik login ataupun register.
Format: [date] [type] [message]
Type: REGISTER SUCCESS, REGISTER FAILED, LOGIN SUCCESS, LOGIN FAILED
Ex:
[23/09/17 13:18:02] [REGISTER SUCCESS] user [username] registered successfully
[23/09/17 13:22:41] [LOGIN FAILED] ERROR Failed login attempt on user with email [email]

**STEP**
1. sudo nano register.sh
2. Membuat bash script pada register.sh
```
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

	if grep -q "^$email " users/users.txt; then
		echo "Email already exists. Please use another email."
                echo "[$(date +"%d/%m/%y %H:%M:%S")] [REGISTER FAILED] Email $email failed to register because it already exists." >> users/auth.log
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
			echo "$email $username admin" >> users/users.txt
		else
			echo "$email $username nonadmin" >> users/users.txt
		fi
		echo "$b64" >> users/users.txt
		echo "$sec_question" >> users/users.txt
		echo -e "$sec_answer\n" >> users/users.txt
		echo "User registered successfully"
        	echo "[$(date +"%d/%m/%y %H:%M:%S")] [REGISTER SUCCESS] User $username with email $email registered successfully." >> users/auth.log
	else
		echo "Password doesn't have the right format. Please create another password with the right format."
                echo "[$(date +"%d/%m/%y %H:%M:%S")] [REGISTER FAILED] User $username with email $email failed to register." >> users/auth.log
	fi
else
	echo "Email doesn't have the right format. Please use another email."
	echo "[$(date +"%d/%m/%y %H:%M:%S")] [REGISTER FAILED] Email $email failed to register." >> users/auth.log
fi
```
3. sudo chmod +x register.sh
4. sudo nano login.sh
5. Membuat bash script pada login.sh
```
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
```
6. sudo chmod +x login.sh

**REVISI**
1. Path users/users.txt dan users/auth.log diganti menjadi ~/users/users.txt dan ~/users/auth.log untuk meningkatkan kompatibilitas.

**Kendala yang dialami**
**Sebelum revisi**
1. Script untuk mengecek apakah email sudah ada pada users.txt tidak dapat berjalan dengan baik sehingga script register.sh dapat membuat dua akun berbeda dengan email yang sama.
2. Conditional statement untuk mengecek apakah password yang dibuat sudah sesuai dengan format pada register.sh tidak dapat berjalan dengan baik sehingga password yang dibuat formatnya tetap salah meskipun format dari password tersebut sudah benar.

**Setelah revisi**

Tidak ada kendala.

**Hasil pengerjaan (setelah revisi)**

**1. Register user**

![image](https://github.com/haidarRA/Sisop-1-2024-MH-IT03/assets/149871906/7e2546bc-1b71-4c9d-932b-cb5b5bfe3e27)

**2. Login user (admin)**

![image](https://github.com/haidarRA/Sisop-1-2024-MH-IT03/assets/149871906/1fd481e4-eb2d-4007-8873-84d12ca7141f)

**3. Login user (non admin)**

![image](https://github.com/haidarRA/Sisop-1-2024-MH-IT03/assets/149871906/95e1faed-cd1c-464d-816e-9ff6dd144234)

**4. Forgot password**

![image](https://github.com/haidarRA/Sisop-1-2024-MH-IT03/assets/149871906/08e4a6df-9a24-4846-9878-9910dd478b9f)

**5. Register dengan email sudah ada**

![image](https://github.com/haidarRA/Sisop-1-2024-MH-IT03/assets/149871906/829364a3-ff95-4a23-909d-02279b71973d)

**6. Register dengan email yang formatnya salah**

![image](https://github.com/haidarRA/Sisop-1-2024-MH-IT03/assets/149871906/4fa5d1bd-e497-4cfe-814b-b399539b1981)

**7. Register dengan password yang salah**

![image](https://github.com/haidarRA/Sisop-1-2024-MH-IT03/assets/149871906/2856596e-b4f4-4ec5-b1aa-2f7d73ef5db3)

**8. Login dengan email yang tidak ada di users.txt**

![image](https://github.com/haidarRA/Sisop-1-2024-MH-IT03/assets/149871906/bdc54c16-3d38-4644-85ee-7ed44caa1f94)

**9. Login dengan password yang salah**

![image](https://github.com/haidarRA/Sisop-1-2024-MH-IT03/assets/149871906/5fdb6914-f088-45a2-a15a-73b22e0ee5fe)

**10. Gagal menjawab security question**

![image](https://github.com/haidarRA/Sisop-1-2024-MH-IT03/assets/149871906/bc7bc990-3686-495b-9af2-1037e082a71a)

**11. Tampilan isi file users.txt**

![image](https://github.com/haidarRA/Sisop-1-2024-MH-IT03/assets/149871906/0f41f83f-6958-4398-b5d4-d628a10b3909)

**12. Tampilan isi file auth.log**

![image](https://github.com/haidarRA/Sisop-1-2024-MH-IT03/assets/149871906/03fbf9d5-690b-4923-9960-16dfcc49a0a8)

# soal 3

**soal :**

Alyss adalah seorang gamer yang sangat menyukai bermain game Genshin Impact. Karena hobinya, dia ingin mengoleksi foto-foto karakter Genshin Impact. Suatu saat Yanuar memberikannya sebuah Link yang berisi koleksi kumpulan foto karakter dan sebuah clue yang mengarah ke penemuan gambar rahasia. Ternyata setiap nama file telah dienkripsi dengan menggunakan hexadecimal. Karena penasaran dengan apa yang dikatakan Yanuar, Alyss tidak menyerah dan mencoba untuk mengembalikan nama file tersebut kembali seperti semula.

Alyss membuat script bernama awal.sh, untuk download file yang diberikan oleh Yanuar dan unzip terhadap file yang telah diunduh dan decode setiap nama file yang terenkripsi dengan hex . Karena pada file list_character.csv terdapat data lengkap karakter, Alyss ingin merename setiap file berdasarkan file tersebut. Agar semakin rapi, Alyss mengumpulkan setiap file ke dalam folder berdasarkan region tiap karakter
(Format: Region - Nama - Elemen - Senjata.jpg)

Karena tidak mengetahui jumlah pengguna dari tiap senjata yang ada di folder "genshin_character".Alyss berniat untuk menghitung serta menampilkan jumlah pengguna untuk setiap senjata yang ada
( Format: [Nama Senjata] : [jumlah] )

Untuk menghemat penyimpanan. Alyss menghapus file - file yang tidak ia gunakan, yaitu genshin_character.zip, list_character.csv, dan genshin.zip
Namun sampai titik ini Alyss masih belum menemukan clue dari the secret picture yang disinggung oleh Yanuar. Dia berpikir keras untuk menemukan pesan tersembunyi tersebut. Alyss membuat script baru bernama search.sh untuk melakukan pengecekan terhadap setiap file tiap 1 detik. Pengecekan dilakukan dengan cara meng-ekstrak sebuah value dari setiap gambar dengan menggunakan command steghide. 

Dalam setiap gambar tersebut, terdapat sebuah file txt yang berisi string. Alyss kemudian mulai melakukan dekripsi dengan hex pada tiap file txt dan mendapatkan sebuah url. Setelah mendapatkan url yang ia cari, Alyss akan langsung menghentikan program search.sh serta mendownload file berdasarkan url yang didapatkan.
Dalam prosesnya, setiap kali Alyss melakukan ekstraksi dan ternyata hasil ekstraksi bukan yang ia inginkan, maka ia akan langsung menghapus file txt tersebut. Namun, jika itu merupakan file txt yang dicari, maka ia akan menyimpan hasil dekripsi-nya bukan hasil ekstraksi. Selain itu juga, Alyss melakukan pencatatan log pada file image.log untuk setiap pengecekan gambar ( Format: [date] [type] [image_path] )

Ex:

[24/03/20 17:18:19] [NOT FOUND] [image_path]        

[24/03/20 17:18:20] [FOUND] [image_path]

Hasil akhir:

* genshin_character
* search.sh
* awal.sh
* image.log
* [filename].txt
* [image].txt




  **STEP**


  
STEP SISOP NO 3

1. touch awal.sh (buat awal.sh)

2. chmod + x awal.sh (permission awal.sh)

3. nano awal.sh (edit dulu scriptnya)

ISI SCRIPT awal.sh
```
!/bin/bash

wget -O file.zip 'https://drive.google.com/uc?export=download&id=1oGHdTf4_76_RacfmQIV4i7os4sGwa9vN'

unzip file.zip

mkdir genshin_character
unzip genshin_character.zip
cd genshin_character || exit

# Buat direktori untuk setiap wilayah
mkdir Inazuma Mondstat Liyue Sumeru Fontaine

# Iterasi setiap file dalam direktori
for file in *; do
    # Ambil nama karakter dari file dan sesuaikan dengan data dari file CSV
    originalName=$(echo $file | xxd -r -p)
    editedName=$(awk -F ',' "/$originalName/"'{OFS = " - ";print $2,$1,$3,$4}' /home/kali/Praktikumsisop/modul1/soal_3/list_character.csv | tr -d '\r')
    region=$(awk -F ',' "/$originalName/"'{print $2}' /home/kali/Praktikumsisop/modul1/soal_3/list_character.csv)

    # Ubah nama file menjadi nama yang sudah diedit
    mv "$file" "$editedName".jpg

    # Pindahkan file ke direktori wilayah yang sesuai
    mv "$editedName".jpg "/home/kali/Praktikumsisop/modul1/soal_3/genshin_character/$region"
done

clear

cd ..
echo "Jumlah Weapon!"

tail -n +2 list_character.csv | awk -F ',' '{print $4}' | sed 's/^[[:space:]]*//;s/[[:space:]]*$//' |  sort | uniq -c | while read -r count word; do
        echo "$word : $count"
done

rm file.zip genshin_character.zip list_character.csv

```

4. bash awal.sh (run script awal.sh)

5. Sudo apt install steghide

6. touch search.sh (buat script search.sh)

7. Chmod +x search.sh

8. nano search.sh (edit script lagi)

ISI SCRIPT search.sh
```
#!/bin/bash

log_file="image.log"

extract_value() {
    local image_path="$1"
    local txt_file="${image_path%.*}.txt"

    # Extract value from the image using steghide
    steghide extract -sf "$image_path" -xf "$txt_file" -p "" > /dev/null 2>&1

    if [ -f "$txt_file" ]; then
        # Decode the content of the txt file using base64
        decrypted_value=$(cat "$txt_file" | base64 -d)

           if [[ $decrypted_value == *https:* ]]; then
            echo "$decrypted_value"
            echo "$decrypted_value" >> link_secret.txt

            wget -O secret.jpg "$decrypted_value" > /dev/null 2>&1

            if [ $? -eq 0 ]; then
                echo "[$(date '+%d/%m/%y %H:%M:%S')] [FOUND] [$image_path]" >> "$log_file"
                rm "$txt_file"
                exit 0
            else
                echo "Failed to download file from URL: $decrypted_value"
            fi
        else
            echo "[$(date '+%d/%m/%y %H:%M:%S')] [NOT FOUND] [$image_path]" >> "$log_file"
            rm "$txt_file"
        fi
    else
        echo "[$(date '+%d/%m/%y %H:%M:%S')] [EXTRACTION FAILED] [$image_path]" >> "$log_file"
    fi
}

for region in Mondstat Liyue Fontaine Inazuma Sumeru; do
    pass=""
    for image in "/home/kali/Praktikumsisop/modul1/soal3/genshin_character/$region"/*.jpg; do
        extract_value "$image"
        sleep 1
    done
done
```
# Revisi no 3!

* Revisi pada awal.sh karena format nama (Region - Nama - Elemen - Senjata.jpg) terdapat kesalahan format pada variabel Senjata yang harusnya senjata.jpg malah senjata'$'r"
  maka dari itu saya merubah kode
```
   editedName=$(awk -F ',' "/$originalName/"'{OFS = " - ";print $2,$1,$3,$4}' /home/kali/Praktikumsisop/modul1/soal_3/list_character.csv)
```
dengan kode dibawah
```
editedName=$(awk -F ',' "/$originalName/"'{OFS = " - ";print $2,$1,$3,$4}' /home/kali/Praktikumsisop/modul1/soal_3/list_character.csv | tr -d '\r')
```
yang saya tambahkan ialah:
 ```
| tr -d '\r'
```
command tersebut berfungsi untuk menghapus karakter khusus (CR,Carriage return)



# **DOKUMENTASI NO 3**





**Isi awal.sh**
![image](https://github.com/haidarRA/Sisop-1-2024-MH-IT03/assets/151866048/a08fecd3-9a48-4fc8-bb0e-6e14085a1a32)

**hasil awal.sh**
![image](https://github.com/haidarRA/Sisop-1-2024-MH-IT03/assets/151866048/0b0e9e06-736b-495c-9b23-e25d9fed9546)

![image](https://github.com/haidarRA/Sisop-1-2024-MH-IT03/assets/151866048/af5fae64-457a-4419-a209-25c8cdf9bc09)


**Isi search.sh**
![image](https://github.com/haidarRA/Sisop-1-2024-MH-IT03/assets/151866048/c0a76ba3-b889-4ae9-9a03-f119c5cf577c)



**hasil search.sh**

![image](https://github.com/haidarRA/Sisop-1-2024-MH-IT03/assets/151866048/3086ce26-4fcd-4e26-9183-9b3fe5b56271)


**Isi image.log**
![image](https://github.com/haidarRA/Sisop-1-2024-MH-IT03/assets/151866048/b3b8e512-1fb8-488b-9d72-cedea4d71af2)


**Isi secret_link.txt**

![image](https://github.com/haidarRA/Sisop-1-2024-MH-IT03/assets/151866048/359ba85e-fad0-4b25-92e7-541e954485b0)

**Gambar secret.jpg**
![image](https://github.com/haidarRA/Sisop-1-2024-MH-IT03/assets/151866048/7d401917-af94-4cdb-959d-0c424c979689)



**Hasil akhir**

![image](https://github.com/haidarRA/Sisop-1-2024-MH-IT03/assets/151866048/43fa652b-e477-4ef3-a064-88a12de42565)

# kendala NO 3
* Kendala yang saya alami ialah ketika merun script search.sh memerlukan waktu lama entah kenapa, mungkin problem dari device.
* Dan untuk format nama senjata.jpg ada '$'r/", ternyata adanya kekurangan command pada script
  
  **-setelah revisi aman-**

  
# soal 4
**soal :**
Stitch sangat senang dengan PC di rumahnya. Suatu hari, PC nya secara tiba-tiba nge-freeze 🤯 Tentu saja, Stitch adalah seorang streamer yang harus setiap hari harus bermain game dan streaming.  Akhirnya, dia membawa PC nya ke tukang servis untuk diperbaiki. Setelah selesai diperbaiki, ternyata biaya perbaikan sangat mahal sehingga dia harus menggunakan uang hasil tabungan nya untuk membayarnya. Menurut tukang servis, masalahnya adalah pada CPU dan GPU yang overload karena gaming dan streaming sehingga mengakibatkan freeze pada PC nya. Agar masalah ini tidak terulang kembali, Stitch meminta kamu untuk membuat sebuah program monitoring resource yang tersedia pada komputer.
Buatlah program monitoring resource pada PC kalian. Cukup monitoring ram dan monitoring size suatu directory. Untuk ram gunakan command `free -m`. Untuk disk gunakan command `du -sh <target_path>`. Catat semua metrics yang didapatkan dari hasil `free -m`. Untuk hasil `du -sh <target_path>` catat size dari path directory tersebut. Untuk target_path yang akan dimonitor adalah /home/{user}/. 
Masukkan semua metrics ke dalam suatu file log bernama metrics_{YmdHms}.log. {YmdHms} adalah waktu disaat file script bash kalian dijalankan. Misal dijalankan pada 2024-03-20 15:00:00, maka file log yang akan tergenerate adalah metrics_20240320150000.log. 
Script untuk mencatat metrics diatas diharapkan dapat berjalan otomatis pada setiap menit. 
Kemudian, buat satu script untuk membuat agregasi file log ke satuan jam. Script agregasi akan memiliki info dari file-file yang tergenerate tiap menit. Dalam hasil file agregasi tersebut, terdapat nilai minimum, maximum, dan rata-rata dari tiap-tiap metrics. File agregasi akan ditrigger untuk dijalankan setiap jam secara otomatis. Berikut contoh nama file hasil agregasi metrics_agg_2024032015.log dengan format metrics_agg_{YmdH}.log 
Karena file log bersifat sensitif pastikan semua file log hanya dapat dibaca oleh user pemilik file. 
Note:
Nama file untuk script per menit adalah minute_log.sh
Nama file untuk script agregasi per jam adalah aggregate_minutes_to_hourly_log.sh
Semua file log terletak di /home/{user}/log
Semua konfigurasi cron dapat ditaruh di file skrip .sh nya masing-masing dalam bentuk comment
Berikut adalah contoh isi dari file metrics yang dijalankan tiap menit:
mem_total,mem_used,mem_free,mem_shared,mem_buff,mem_available,swap_total,swap_used,swap_free,path,path_size 15949,10067,308,588,5573,4974,2047,43,2004,/home/user/coba/,74M

Berikut adalah contoh isi dari file aggregasi yang dijalankan tiap jam:
type,mem_total,mem_used,mem_free,mem_shared,mem_buff,mem_available,swap_total,swap_used,swap_free,path,path_size minimum,15949,10067,223,588,5339,4626,2047,43,1995,/home/user/coba/,50M maximum,15949,10387,308,622,5573,4974,2047,52,2004,/home/user/coba/,74M average,15949,10227,265.5,605,5456,4800,2047,47.5,1999.5,/home/user/coba/,62M

**STEP**
1. sudo nano minute_log.sh
2. Membuat bash script pada minute_log.sh
```
#!/bin/bash

# Function to get memory metrics
get_memory_metrics() {
    mem_info=($(grep -E "MemTotal|MemFree|MemAvailable|Buffers|Cached|SwapTotal|SwapFree" /proc/meminfo | awk '{print $2}'))
    mem_total=${mem_info[0]}
    mem_free=$(( ${mem_info[1]} + ${mem_info[2]} + ${mem_info[3]} ))
    mem_shared=0 # Not available in /proc/meminfo
    mem_buff=${mem_info[3]}
    mem_available=${mem_info[5]}
    swap_total=${mem_info[6]}
    swap_free=${mem_info[7]}
    echo "$mem_total,$((mem_total - mem_free)),$mem_free,$mem_shared,$mem_buff,$mem_available,$swap_total,$((swap_total - swap_free)),$swap_free"
}

get_directory_size() {
    du -hs "$1" | awk '{print $1}'
}

directories=($(ls -d ~/[^.]*))

for dir in "${directories[@]}"; do
    memory_metrics=$(get_memory_metrics)
    directory_size=$(get_directory_size "$dir")
    echo "$memory_metrics,$dir,$directory_size"
done

#command cron
#* * * * * umask 077 && /bin/bash /home/admin-haidar/sisop/modul1no4/minute_log.sh >> /home/admin-haidar/log/metrics_$(date +\%Y\%m\%d\%H\%M\%S).log 2>&1
```
3. sudo chmod +x minute_log.sh
4. Menambahkan command "* * * * * umask 077 && /bin/bash /home/admin-haidar/sisop/modul1no4/minute_log.sh >> /home/admin-haidar/log/metrics_$(date +\%Y\%m\%d\%H\%M\%S).log 2>&1" pada crontab -e
5. sudo nano aggregate_minutes_to_hourly_log.sh
6. Membuat bash script pada aggragate_minutes_to_hourly_long.sh
```
#!/bin/bash

date=$(date "+%Y%m%d%H")

#echo "$date"

directories=($(ls -d ~/[^.]*))

for dir in "${directories[@]}"
do
	for file in /home/admin-haidar/log/metrics_"$date"*.log
	do
		if [ -f "$file" ]; then
			#mem_total
            	        min=$((99999999999))
		        max=$((-99999999999))
			mem_total=$(awk -v dir="$dir" 'BEGIN { FS = "," } ; $0 ~ dir {print $1}' "$file")
			if [[ $mem_total -gt $max ]]; then
				max=$mem_total
			fi

			if [[ $mem_total -lt $min ]]; then
				min=$mem_total
			fi
			max_memtotal=$max
			min_memtotal=$min

			#mem_used
                        min=$((99999999999))
                        max=$((-99999999999))
                        mem_used=$(awk -v dir="$dir" 'BEGIN { FS = "," } ; $0 ~ dir {print $2}' "$file")
                        if [[ $mem_used -gt $max ]]; then
                                max=$mem_used
                        fi

                        if [[ $mem_used -lt $min ]]; then
                                min=$mem_used
                        fi
                        max_memused=$max
                        min_memused=$min

			#mem_free
                        min=$((99999999999))
                        max=$((-99999999999))
                        mem_free=$(awk -v dir="$dir" 'BEGIN { FS = "," } ; $0 ~ dir {print $3}' "$file")
                        if [[ $mem_free -gt $max ]]; then
                                max=$mem_free
                        fi

                        if [[ $mem_free -lt $min ]]; then
                                min=$mem_free
                        fi
                        max_memfree=$max
                        min_memfree=$min

			#mem_shared
                        min=$((99999999999))
                        max=$((-99999999999))
                        mem_shared=$(awk -v dir="$dir" 'BEGIN { FS = "," } ; $0 ~ dir {print $4}' "$file")
                        if [[ $mem_shared -gt $max ]]; then
                                max=$mem_shared
                        fi

                        if [[ $mem_shared -lt $min ]]; then
                                min=$mem_shared
                        fi
                        max_memshared=$max
                        min_memshared=$min

                        #mem_buff
                        min=$((99999999999))
                        max=$((-99999999999))
                        mem_buff=$(awk -v dir="$dir" 'BEGIN { FS = "," } ; $0 ~ dir {print $5}' "$file")
                        if [[ $mem_buff -gt $max ]]; then
                                max=$mem_buff
                        fi

                        if [[ $mem_buff -lt $min ]]; then
                                min=$mem_buff
                        fi
                        max_membuff=$max
                        min_membuff=$min

                        #mem_available
                        min=$((99999999999))
                        max=$((-99999999999))
                        mem_available=$(awk -v dir="$dir" 'BEGIN { FS = "," } ; $0 ~ dir {print $6}' "$file")
                        if [[ $mem_available -gt $max ]]; then
                                max=$mem_available  
                        fi

                        if [[ $mem_available -lt $min ]]; then
                                min=$mem_available
                        fi
                        max_memavailable=$max
                        min_memavailable=$min

                        #swap_total
                        min=$((99999999999))
                        max=$((-99999999999))
                        swap_total=$(awk -v dir="$dir" 'BEGIN { FS = "," } ; $0 ~ dir {print $7}' "$file")
                        if [[ $swap_total -gt $max ]]; then
                                max=$swap_total 
                        fi

                        if [[ $swap_total -lt $min ]]; then
                                min=$swap_total
                        fi
                        max_swaptotal=$max
                        min_swaptotal=$min

                        #swap_used
                        min=$((99999999999))
                        max=$((-99999999999))
                        swap_used=$(awk -v dir="$dir" 'BEGIN { FS = "," } ; $0 ~ dir {print $8}' "$file")
                        if [[ $swap_used -gt $max ]]; then
                                max=$swap_used 
                        fi

                        if [[ $swap_used -lt $min ]]; then
                                min=$swap_used
                        fi
                        max_swapused=$max
                        min_swapused=$min

                        #swap_free
                        min=$((99999999999))
                        max=$((-99999999999))
                        swap_free=$(awk -v dir="$dir" 'BEGIN { FS = "," } ; $0 ~ dir {print $9}' "$file")
                        if [[ $swap_free -gt $max ]]; then
                                max=$swap_free
                        fi

                        if [[ $swap_free -lt $min ]]; then
                                min=$swap_free
                        fi
                        max_swapfree=$max
                        min_swapfree=$min

                        #path_size
                        min=$((99999999999))
                        max=$((0))
                        path_size=$(awk -v dir="$dir" 'BEGIN { FS = "," } ; $0 ~ dir {print $11}' "$file")

			interger=$(echo $path_size | sed 's/[^0-9.]//g')
			interger=${interger%.*}
			suffix=${path_size//$interger}

                        if [[ $interger > $max ]]; then
                                max=$interger
                        fi

                        if [[ $interger < $min ]]; then
                                min=$interger
                        fi
                        max_pathsize=$max
                        min_pathsize=$min

        	fi
	done
        avg_memtotal=$(((max_memtotal+min_memtotal)/2))
        avg_memused=$(((max_memused+min_memused)/2))
        avg_memfree=$(((max_memfree+min_memfree)/2))
        avg_memshared=$(((max_memshared+min_memshared)/2))
	avg_membuff=$(((max_membuff+min_membuff)/2))
	avg_memavailable=$(((max_memavailable+min_memavailable)/2))
	avg_swaptotal=$(((max_swaptotal+min_swaptotal)/2))
	avg_swapused=$(((max_swapused+min_swapused)/2))
	avg_swapfree=$(((max_swapfree+min_swapfree)/2))
	avg_pathsize=$(((max_pathsize+min_pathsize)/2))

	echo "minimum,$min_memtotal,$min_memused,$min_memfree,$min_memshared,$min_membuff,$min_memavailable,$min_swaptotal,$min_swapused,$min_swapfree,$dir,$min_pathsize$suffix"
        echo "maximum,$max_memtotal,$max_memused,$max_memfree,$max_memshared,$max_membuff,$max_memavailable,$max_swaptotal,$max_swapused,$max_swapfree,$dir,$max_pathsize$suffix"
        echo "average,$avg_memtotal,$avg_memused,$avg_memfree,$avg_memshared,$avg_membuff,$avg_memavailable,$avg_swaptotal,$avg_swapused,$avg_swapfree,$dir,$avg_pathsize$suffix"
	echo -e "\n"
done

#command cron:
#59 * * * * umask 077 && /bin/bash /home/admin-haidar/sisop/modul1no4/aggregate_minutes_to_hourly_log.sh >> /home/admin-haidar/log/metrics_agg_$(date +\%Y\%m\%d\%H).log 2>&1
```
7. sudo chmod +x aggregate_minutes_to_hourly_login.sh
8. Menambahkan command "59 * * * * umask 077 && /bin/bash /home/admin-haidar/sisop/modul1no4/aggregate_minutes_to_hourly_log.sh >> /home/admin-haidar/log/metrics_agg_$(date +\%Y\%m\%d\%H).log 2>&1" pada crontab -e

**REVISI**
1. Menggunakan free -m pada minute_log.sh
2. Monitoring resource hanya pada /home/{user} (home directory dari user), bukan setiap directory yang ada di /home/{user}.

Dari dua revisi ini, dilakukan revisi total pada minute_log.sh dan aggregate_minutes_to_hourly_log.sh agar script dapat mengeluarkan hasil monitoring resource pada /home/{user} (home directory dari user) dan menggunakan free -m untuk mendapatkan informasi terkait resource dari /home/{user}.
1. minute_log.sh
```
#!/bin/bash

mem_total=$(free -m | awk 'NR == 2 {print $2}')
mem_used=$(free -m | awk 'NR == 2 {print $3}')
mem_free=$(free -m | awk 'NR == 2 {print $4}')
mem_shared=$(free -m | awk 'NR == 2 {print $5}')
mem_buff=$(free -m | awk 'NR == 2 {print $6}')
mem_available=$(free -m | awk 'NR == 2 {print $7}')
swap_total=$(free -m | awk 'NR == 3 {print $2}')
swap_used=$(free -m | awk 'NR == 3 {print $3}')
swap_free=$(free -m | awk 'NR == 3 {print $4}')

path=$(echo "$HOME")
path_size=$(du -sh ~ | awk '{print $1}')

echo "mem_total,mem_used,mem_free,mem_shared,mem_buff,mem_available,swap_total,swap_used,swap_free,path,path_size"
echo "$mem_total,$mem_used,$mem_free,$mem_shared,$mem_buff,$mem_available,$swap_total,$swap_used,$swap_free,$path,$path_size"

#command cron
#* * * * * umask 077 && /bin/bash ~/sisop/modul1/soal_4/minute_log.sh >> ~/log/metrics_$(date +\%Y\%m\%d\%H\%M\%S).log 2>&1
```

2. aggregate_minutes_to_hourly_log.sh
```
#!/bin/bash

date=$(date "+%Y%m%d%H")

#if [ ! -d "$format" ]; then
#    exit 1
#fi

min_mt=$((99999999999))
max_mt=$((0))

min_mu=$((99999999999))
max_mu=$((0))

min_mf=$((99999999999))
max_mf=$((0))

min_ms=$((99999999999))
max_ms=$((0))

min_mb=$((99999999999))
max_mb=$((0))

min_ma=$((99999999999))
max_ma=$((0))

min_st=$((99999999999))
max_st=$((0))

min_su=$((99999999999))
max_su=$((0))

min_sf=$((99999999999))
max_sf=$((0))

min_ps=$((99999999999))
max_ps=$((0))

for file in ~/log/metrics_"$date"*.log; do
	if [ -f "$file" ]; then
		#mem_total
                mem_total=$(awk 'BEGIN { FS = "," } ; NR == 2 {print $1}' "$file")
		if [[ $mem_total -gt $max_mt ]]; then
			max_mt=$mem_total
		fi

		if [[ $mem_total -lt $min_mt ]]; then
			min_mt=$mem_total
		fi

		#mem_used
                mem_used=$(awk 'BEGIN { FS = "," } ; NR == 2 {print $2}' "$file")
		if [[ $mem_used -gt $max_mu ]]; then
			max_mu=$mem_used
		fi

		if [[ $mem_used -lt $min_mu ]]; then
			min_mu=$mem_used
		fi

		#mem_free
                mem_free=$(awk 'BEGIN { FS = "," } ; NR == 2 {print $3}' "$file")
		if [[ $mem_free -gt $max_mf ]]; then
			max_mf=$mem_free
		fi

		if [[ $mem_free -lt $min_mf ]]; then
			min_mf=$mem_free
		fi

		#mem_shared
                mem_shared=$(awk 'BEGIN { FS = "," } ; NR == 2 {print $4}' "$file")
		if [[ $mem_shared -gt $max_ms ]]; then
			max_ms=$mem_shared
		fi

		if [[ $mem_shared -lt $min_ms ]]; then
			min_ms=$mem_shared
		fi

		#mem_buff
                mem_buff=$(awk 'BEGIN { FS = "," } ; NR == 2 {print $5}' "$file")
		if [[ $mem_buff -gt $max_mb ]]; then
			max_mb=$mem_buff
		fi

		if [[ $mem_buff -lt $min_mb ]]; then
			min_mb=$mem_buff
		fi

		#mem_available
                mem_available=$(awk 'BEGIN { FS = "," } ; NR == 2 {print $6}' "$file")
		if [[ $mem_available -gt $max_ma ]]; then
			max_ma=$mem_available
		fi

		if [[ $mem_available -lt $min_ma ]]; then
			min_ma=$mem_available
		fi

		#swap_total
                swap_total=$(awk 'BEGIN { FS = "," } ; NR == 2 {print $7}' "$file")
		if [[ $swap_total -gt $max_st ]]; then
			max_st=$swap_total 
		fi

		if [[ $swap_total -lt $min_st ]]; then
			min_st=$swap_total
		fi

		#swap_used
                swap_used=$(awk 'BEGIN { FS = "," } ; NR == 2 {print $8}' "$file")
		if [[ $swap_used -gt $max_su ]]; then
			max_su=$swap_used 
		fi

		if [[ $swap_used -lt $min_su ]]; then
			min_su=$swap_used
		fi

		#swap_free
                swap_free=$(awk 'BEGIN { FS = "," } ; NR == 2 {print $9}' "$file")
		if [[ $swap_free -gt $max_sf ]]; then
		        max_sf=$swap_free
		fi

		if [[ $swap_free -lt $min_sf ]]; then
		        min_sf=$swap_free
		fi

		#path_size
                path_size=$(awk 'BEGIN { FS = "," } ; NR == 2 {print $11}' "$file")

		interger=$(echo $path_size | sed 's/[^0-9.]//g')
		interger=${interger%.*}
		suffix=${path_size//$interger}

		if [[ $interger > $max_ps ]]; then
		        max_ps=$interger
		fi

		if [[ $interger < $min_ps ]]; then
		        min_ps=$interger
		fi
	fi
done

avg_memtotal=$(((max_mt+min_mt)/2))
avg_memused=$(((max_mu+min_mu)/2))
avg_memfree=$(((max_mf+min_mf)/2))
avg_memshared=$(((max_ms+min_ms)/2))
avg_membuff=$(((max_mb+min_mb)/2))
avg_memavailable=$(((max_ma+min_ma)/2))
avg_swaptotal=$(((max_st+min_st)/2))
avg_swapused=$(((max_su+min_su)/2))
avg_swapfree=$(((max_sf+min_sf)/2))
avg_pathsize=$(((max_ps+min_ps)/2))

path=$(echo "$HOME")

echo "type,mem_total,mem_used,mem_free,mem_shared,mem_buff,mem_available,swap_total,swap_used,swap_free,path,path_size"
echo "minimum,$min_mt,$min_mu,$min_mf,$min_ms,$min_mb,$min_ma,$min_st,$min_su,$min_sf,$path,$min_ps$suffix"
echo "maximum,$max_mt,$max_mu,$max_mf,$max_ms,$max_mb,$max_ma,$max_st,$max_su,$max_sf,$path,$max_ps$suffix"
echo "average,$avg_memtotal,$avg_memused,$avg_memfree,$avg_memshared,$avg_membuff,$avg_memavailable,$avg_swaptotal,$avg_swapused,$avg_swapfree,$path,$avg_pathsize$suffix"
echo -e "\n"

#command cron
#59 * * * * umask 077 && /bin/bash ~/sisop/modul1/soal_4/aggregate_minutes_to_hourly_log.sh >> ~/log/metrics_agg_$(date +\%Y\%m\%d\%H\%M\%S).log 2>&1
```

Tampilan crontab:
![image](https://github.com/haidarRA/Sisop-1-2024-MH-IT03/assets/149871906/a1dae6e8-fb6f-4964-8fbd-3dd3e92b84a9)

**Kendala yang dialami**
**Sebelum revisi**
1. Salah satu metric resource yang didapat (sebelum menggunakan free -m) ada yang bernilai negatif.
2. Script untuk menghitung nilai maksimum dan minimum pada aggregate_minutes_to_hourly_log.sh tidak dapat berjalan dengan baik sehingga nilainya tetap konstan.
3. Terjadi kesalahan perhitungan pada metric resource path_size karena tipe data dari path_size adalah string dan bukan interger.

**Setelah revisi**
1. Loop pada script aggregate_minutes_to_hourly_log.sh menyebabkan sebuah error dan script tidak dapat berjalan.
```
syntax error near unexpected token `done'
`done'
```

**Hasil pengerjaan (setelah revisi)**

**1. Tampilan isi file metrics_{YmdHms}.log**

![image](https://github.com/haidarRA/Sisop-1-2024-MH-IT03/assets/149871906/1f0fe62a-aa3e-4140-85c5-d311459ecb3f)

**2. Tampilan isi file metrics_agg_{YmdH}.log**

![image](https://github.com/haidarRA/Sisop-1-2024-MH-IT03/assets/149871906/c086b962-ffe6-4027-91d0-ff185ca67007)

