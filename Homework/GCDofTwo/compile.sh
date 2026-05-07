rm -rf .Aa
mkdir .Aa

AaLinkExtMem gcdoftwo.aa | vcFormat > .Aa/gcdoftwo.linked.aa 

TOPMODULES=" -t gcdoftwo"

# optimized.
AaOpt -B .Aa/gcdoftwo.linked.aa  | vcFormat > .Aa/gcdoftwo.opt.aa

#
# to virtual circuit.
#
rm -rf .vC
mkdir .vC
Aa2VC -O -C .Aa/gcdoftwo.opt.aa | vcFormat > .vC/gcdoftwo.vc

#
# to VHDL
#
rm -rf vhdl/
mkdir vhdl/
vc2vhdl -U  -O -v -a -C -e gcdoftwo_system -w -s ghdl $TOPMODULES -f .vC/gcdoftwo.vc
vhdlFormat < gcdoftwo_system_global_package.unformatted_vhdl > vhdl/gcdoftwo_system_global_package.vhdl
vhdlFormat < gcdoftwo_system.unformatted_vhdl > vhdl/gcdoftwo_system.vhdl
vhdlFormat < gcdoftwo_system_test_bench.unformatted_vhdl > vhdl/gcdoftwo_system_test_bench.vhdl
rm -f *.unformatted_vhdl

# testbench
rm -rf obj_vhdl
mkdir obj_vhdl
gcc -g -c testbench/testbench.c -I ./ -I $AHIR_RELEASE/include  -o obj_vhdl/testbench.o 
gcc -g -c vhdlCStubs.c -I ./  -I $AHIR_RELEASE/include  -o obj_vhdl/vhdlCStubs.o 
gcc -g -o testbench_vhdl obj_vhdl/vhdlCStubs.o obj_vhdl/testbench.o -L$AHIR_RELEASE/lib -lBitVectors -lSockPipes -lSocketLibPipeHandler  -lpthread

# ghdl simulation model.
AHIR_LIB=$AHIR_RELEASE/lib
VHDL_LIB=$AHIR_RELEASE/vhdl
ghdl --clean
ghdl --remove
ghdl -i --work=GhdlLink  $VHDL_LIB/GhdlLink.vhdl
ghdl -i --work=aHiR_ieee_proposed  $VHDL_LIB/aHiR_ieee_proposed.vhdl
ghdl -i --work=ahir  $VHDL_LIB/ahir.vhdl
ghdl -i --work=work vhdl/gcdoftwo_system_global_package.vhdl
ghdl -i --work=work vhdl/gcdoftwo_system.vhdl
ghdl -i --work=work vhdl/gcdoftwo_system_test_bench.vhdl
ghdl -m --work=work -Wl,-L$AHIR_LIB -Wl,-lVhpi gcdoftwo_system_test_bench 



