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
    mv "$editedName".jpg "/home/kali/soal_3/genshin_character/$region"
done

clear

cd ..
echo "Jumlah Weapon!"

tail -n +2 list_character.csv | awk -F ',' '{print $4}' | sed 's/^[[:space:]]*//;s/[[:space:]]*$//' |  sort | uniq -c | while read -r count word; do
        echo "$word : $count"
done

rm file.zip genshin_character.zip list_character.csv

