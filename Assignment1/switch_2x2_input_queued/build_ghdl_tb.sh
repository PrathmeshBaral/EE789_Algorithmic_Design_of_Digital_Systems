#
# build ghdl testbench
#
rm -rf obj_vhdl
mkdir obj_vhdl
gcc -g -c tb/testbench.c -I tb/ -I $AHIR_RELEASE/include  -o obj_vhdl/testbench.o 
gcc -g -o bin/testbench_vhdl  obj_vhdl/testbench.o -L$AHIR_RELEASE/lib -lBitVectors -lSockPipes -lSocketLibPipeHandler  -lpthread

