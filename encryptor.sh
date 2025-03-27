#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 TARGET_FOLDER"
    exit 1
fi

target_folder="$1"

if [ ! -d "$target_folder" ]; then
    echo "Directory '$target_folder' does not exist."
    exit 1
fi

encrypted_folder="${target_folder}_encrypted"
keys_folder="${target_folder}_keys"

mkdir -p "$encrypted_folder"
mkdir -p "$keys_folder"

find "$target_folder" -type f | while read -r clean_file; do
    relative_path="${clean_file#$target_folder/}"
    encrypted_file="$encrypted_folder/${relative_path%.txt}_encrypted.txt"
    keys_file="$keys_folder/${relative_path%.txt}_keys.txt"

    mkdir -p "$(dirname "$encrypted_file")"
    mkdir -p "$(dirname "$keys_file")"

    ./mixer "$keys_file" < "$clean_file" > "$encrypted_file"
done
