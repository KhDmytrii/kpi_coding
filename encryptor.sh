#!/bin/bash

clean_file="clean.txt"
encrypted_file="encrypted.txt"
random_key_file="random_key.txt"

random_key=$(openssl rand -hex 16)
echo $random_key > $random_key_file

cp $clean_file $encrypted_file

./mixer < $clean_file > $encrypted_file 2> $random_key_file