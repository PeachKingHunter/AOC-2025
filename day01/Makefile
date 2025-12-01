all: runP2

runP1: mainP1
	./builds/mainP1

runP2: mainP2
	./builds/mainP2

mainP1: src/mainP1.c
	gcc -Wall -o builds/mainP1 src/mainP1.c

mainP2: src/mainP2.c
	gcc -Wall -o builds/mainP2 src/mainP2.c
