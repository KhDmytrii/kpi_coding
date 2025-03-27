#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

#define buffer_size 1024

void mix_with_random_bytes(FILE *input, FILE *output, FILE *key_output) {
    unsigned char buffer[buffer_size];
    size_t bytesRead;
    
    srand(time(NULL));

    while ((bytesRead = fread(buffer, 1, buffer_size, input)) > 0) {
        for (size_t i = 0; i < bytesRead; i++) {
            unsigned char randomByte = rand();
            buffer[i] ^= randomByte;
            fprintf(key_output, "%02x", randomByte);
        }
    }
    fprintf(key_output, "\n");
    fwrite(buffer, 1, bytesRead, output);
}

int main(int argc, char *argv[]) {
    if (argc != 2) {
        fprintf(stderr, "Usage: %s <key_output_file>\n", argv[0]);
        return 1;
    }

    FILE *key_output = fopen(argv[1], "a");
    if (key_output == NULL) {
        perror("Failed to open key output file");
        return 1;
    }

    mix_with_random_bytes(stdin, stdout, key_output);
    fclose(key_output);
    return 0;
}
