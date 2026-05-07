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
	int I, J, k;
	int A[N][N], B[N][N], R[N][N];

	fprintf(stderr, "\n================ MATRIX MULTIPLICATION TEST ================\n");

	// ---------------- Initialization
	fprintf(stderr, "\n[INFO] Initializing matrices A and B...\n");

    for(I = 0; I < N; I++)
    {
        for(J = 0; J < N; J++)
        {
            A[I][J] = I + J;
            B[I][J] = (I ==J ) ? 1 : 0;
        }
    }

	// ---------------- Loading inputs
	fprintf(stderr, "\n[INFO] Loading A matrices into hardware...\n");

	for(I = 0; I < N; I++)
	{
        for (J = 0; J < N/8; J++)
        {
            uint64_t A_send = 0;

            for (k = 0; k < 8; k++)
            {
                A_send |= ((uint64_t)A[I][J*8 + k]) << (8 * (7 - k));
                fprintf(stderr, "A[%d][%d] = %d ", I, J*8 + k, A[I][J*8 + k]);
            }

            init_A_entry(I, J, (int64_t)A_send);

            fprintf(stderr, "\nA[%d][%d:%d] loaded = %016llx\n", I, J*8, J*8 + 7, A_send);
        }
	}

	fprintf(stderr, "\n[INFO] Loading B matrices into hardware...\n");

	for(I = 0; I < N; I++)
	{
        for (J = 0; J < N/8; J++)
        {
            uint64_t B_send = 0;

            for (k = 0; k < 8; k++)
            {
                B_send |= ((uint64_t)B[J*8 + k][I]) << (8 * (7 - k));
                fprintf(stderr, "B[%d][%d] = %d ", J*8 + k, I, B[J*8 + k][I]);
            }

            init_B_entry(I, J, (int64_t)B_send);
            fprintf(stderr, "\nB[%d:%d][%d] loaded = %016llx\n", J*8, J*8 + 7, I, B_send);
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
