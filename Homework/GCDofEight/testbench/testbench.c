#include <pthread.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include "vhdlCStubs.h"

int main(int argc, char* argv[])
{
	if(argc < 9)
	{
		fprintf (stderr,"Error: supply eight arguments to be added\n");
		return(1);
	}

	uint32_t c = gcdofeight (atoi (argv[1]), atoi(argv[2]), atoi(argv[3]), atoi(argv[4]), atoi(argv[5]), atoi(argv[6]), atoi(argv[7]), atoi(argv[8]));
	fprintf(stderr, "Result=%d\n", c);

	return(0);

}


