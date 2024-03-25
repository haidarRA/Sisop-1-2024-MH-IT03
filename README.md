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



# soal 2



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


  
DOKUMENTASI SISOP NO 3

1. touch awal.sh (buat awal.sh)

2. chmod + x awal.sh (permission awal.sh)

3. nano awal.sh (edit dulu scriptnya)

ISI SCRIPT awal.sh
```
 #!/bin/bash

 #Download file ZIP dari Google Drive
wget -O file.zip 'https://drive.google.com/uc?export=download&id=1oGHdTf4_76_RacfmQIV4i7os4sGwa9vN'

#Ekstrak file ZIP
unzip file.zip

 #Buat direktori untuk karakter Genshin Impact
mkdir genshin_character
unzip genshin_character.zip
cd genshin_character || exit

 #Buat direktori untuk setiap wilayah
mkdir Inazuma Mondstat Liyue Sumeru Fontaine

#Iterasi setiap file dalam direktori
for file in *; do
    # Ambil nama karakter dari file dan sesuaikan dengan data dari file CSV
    originalName=$(echo $file | xxd -r -p)
    editedName=$(awk -F ',' "/$originalName/"'{OFS = " - ";print $2,$1,$3,$4}' /home/kali/Praktikumsisop/modul1/soal3/list_character.csv)
    region=$(awk -F ',' "/$originalName/"'{print $2}' /home/kali/Praktikumsisop/modul1/soal3/list_character.csv)```

   # Ubah nama file menjadi nama yang sudah diedit
    mv $file "$editedName".jpg

  # Pindahkan file ke direktori wilayah yang sesuai
  mv "$editedName".jpg "/home/kali/Praktikumsisop/modul1/soal3/genshin_character/$region"
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


# soal 4
