#include <pthread.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include "vhdlCStubs.h"

int main(int argc, char* argv[])
{
	if(argc < 5)
	{
		fprintf (stderr,"Error: supply four arguments to be added\n");
		return(1);
	}

	uint32_t c = maxoffour (atoi (argv[1]), atoi(argv[2]), atoi(argv[3]), atoi(argv[4]));
	fprintf(stderr, "Result=%d\n", c);

	return(0);

}


