    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    #include <time.h>

    #define buffer_size 1024

    void mix_with_random_bytes(FILE *input, FILE *output) {
        unsigned char buffer[buffer_size];
        size_t bytesRead;
        
        srand(time(NULL));

        while ((bytesRead = fread(buffer, 1, buffer_size, input)) > 0) {
            for (size_t i = 0; i < bytesRead; i++) {
                unsigned char randomByte = rand() % 256;
                buffer[i] ^= randomByte;
                fprintf(stderr, "%02x", randomByte);
            }
            fwrite(buffer, 1, bytesRead, output);
        }
    }

    int main() {
        mix_with_random_bytes(stdin, stdout);
        return 0;
    }
