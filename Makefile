all: mixer

mixer: mixer.c
	gcc -o mixer mixer.c

clean:
	rm -f mixer