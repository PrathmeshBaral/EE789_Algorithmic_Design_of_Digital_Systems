#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <pthread.h>
#include <pthreadUtils.h>
#include <Pipes.h>
#include <pipeHandler.h>
#ifndef SW
#include "vhdlCStubs.h"
#endif

#define N 8

int main(int argc, char* argv[])
{
	int I, J;
	int8_t V;

	for(I = 0; I <  N; I++)
	{
		for(J = 0; J <  N; J++)
		{
			init_A_entry (I, J, (int8_t) I);
			fprintf(stderr, " A[%d][%d]=%d\n", I, J, (int8_t) I);

			init_B_entry (I, J, (int8_t) J);
			fprintf(stderr, " B[%d][%d]=%d\n", I, J, (int8_t) J);
		}
	}

	uint32_t nticks = mmul ();
	fprintf(stderr,"Info: mmul took %d ticks\n", nticks);

	for(I = 0; I <  N; I++)
	{
		for(J = 0; J <  N; J++)
		{
			int8_t v = get_result_entry (I, J);
			fprintf(stderr,"RESULT[%d][%d] = %d\n", I,J, v);
		}
	}

	return(0);
}
