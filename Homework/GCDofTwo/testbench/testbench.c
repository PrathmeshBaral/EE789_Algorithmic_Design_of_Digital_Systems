#include <pthread.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include "vhdlCStubs.h"

int main(int argc, char* argv[])
{
	if(argc < 3)
	{
		fprintf (stderr,"Error: supply two arguments to be added\n");
		return(1);
	}

	uint32_t c = gcdoftwo (atoi (argv[1]), atoi(argv[2]));
	fprintf(stderr, "Result=%d\n", c);

	return(0);

}


