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

#define N 64

int main(int argc, char* argv[])
{
	int I, J;
	int A[N][N], B[N][N], R[N][N];

	fprintf(stderr, "\n================ MATRIX MULTIPLICATION TEST ================\n");

	// ---------------- Initialization
	fprintf(stderr, "\n[INFO] Initializing matrices A and B...\n");

    for(I = 0; I < N; I++)
    {
        for(J = 0; J < N; J++)
        {
            A[I][J] = I%4;
            B[I][J] = I%4;
        }
    }

	// ---------------- Loading inputs
	fprintf(stderr, "\n[INFO] Loading matrices into hardware...\n");

	for(I = 0; I < N; I++)
	{
		for(J = 0; J < N; J++)
		{
			init_A_entry (I, J, (int8_t) A[I][J]);
			fprintf(stderr, " A[%d][%d]=%d\n", I, J, (int8_t) A[I][J]);
			init_B_entry (I, J, (int8_t) B[I][J]);
			fprintf(stderr, " B[%d][%d]=%d\n", I, J, (int8_t) B[I][J]);
		}
	}

	fprintf(stderr, "[INFO] Input loading complete.\n");

	// ---------------- Run computation
	fprintf(stderr, "\n[INFO] Starting matrix multiplication...\n");

	uint32_t nticks = mmul ();

	// ---------------- Fetch results
	fprintf(stderr, "\n[INFO] Fetching results...\n");

	for(I = 0; I < N; I++)
	{
		for(J = 0; J < N; J++)
		{
			R[I][J] = get_result_entry (I, J);
			fprintf(stderr,"RESULT[%d][%d] = %d\n", I,J, R[I][J]);
		}
	}

	fprintf(stderr, "[INFO] Results fetched successfully.\n");

	fprintf(stderr, "[INFO] Computation finished. Ticks = %d\n", nticks);

	// ---------------- Print matrices nicely
	fprintf(stderr, "\n---------------- MATRIX A ----------------\n");
    for(I = 0; I < N; I++)
	{
		for(J = 0; J < N; J++)
			fprintf(stderr,"%4d", A[I][J]);
		fprintf(stderr,"\n");
	}

	fprintf(stderr, "\n---------------- MATRIX B ----------------\n");
    for(I = 0; I < N; I++)
	{
		for(J = 0; J < N; J++)
			fprintf(stderr,"%4d", B[I][J]);
		fprintf(stderr,"\n");
	}

	fprintf(stderr, "\n-------------- RESULT MATRIX --------------\n");
    for(I = 0; I < N; I++)
	{
		for(J = 0; J < N; J++)
			fprintf(stderr,"%4d", R[I][J]);
		fprintf(stderr,"\n");
	}

	fprintf(stderr, "\n===================== DONE =====================\n\n");

	return 0;
}
