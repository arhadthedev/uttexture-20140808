#include <stdio.h>
#include <stdlib.h>

main(int argc, char *argv[]) {
	float range;
	int randint;
	range = strtol(argv[1], NULL, 10);
	srand(time (NULL));
	randint = 1+(int) (range*rand()/(RAND_MAX+1.0));
	printf("%d", randint);
	return 0;
}
