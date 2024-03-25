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
            echo "$decrypted_value" >> secret_link.txt

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
