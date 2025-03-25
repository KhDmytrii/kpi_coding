#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 TARGET_FOLDER"
    exit 1
fi

target_folder="$1"
encrypted_folder="${target_folder}_encrypted"
random_key_file="random_key.txt"

mkdir -p "$encrypted_folder"

> "$random_key_file"

find "$target_folder" -type f | while read -r clean_file; do
    random_key=$(openssl rand -hex 16)
    echo "$(basename "$clean_file"): $random_key" >> "$random_key_file"
    encrypted_file="$encrypted_folder/$(basename "$clean_file")"
    cp "$clean_file" "$encrypted_file"
    ./mixer < "$clean_file" > "$encrypted_file" 2>> random_bytes.txt
done
