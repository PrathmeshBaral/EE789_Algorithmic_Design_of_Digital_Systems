# build software version of testbench (to check the "desired behaviour")
AHIR_INCLUDE=$(AHIR_RELEASE)/include
AHIR_LIB=$(AHIR_RELEASE)/lib
VHDL_LIB=$(AHIR_RELEASE)/vhdl
VHDL_VHPI_LIB=$(AHIR_RELEASE)/CtestBench/vhdl
FUNCTIONLIB=$(AHIR_RELEASE)/functionLibrary/
SRC=./Aa
TB=./tb
all: HW 
TOVC:aalink aa2vc 
VC2VHDL: vc2vhdl  vhdlsim
AA2VHDLSIM: aa2vc  vc2vhdl  vhdlsim
TOVHDL:TOVC vc2vhdl


TOPMODULES=-t mmul  -t init_A_entry -t init_B_entry -t get_A_entry -t get_B_entry -t get_result_entry  -T counter_daemon 



# five steps from C to vhdl simulator.
HW: aalink aa2vc  vc2vhdl  vhdltb ghdlsim

AA2VHDL: aa2vc vc2vhdl vhdlsim

# Aa to vC
aalink: $(SRC)/sample.aa 
	AaLinkExtMem $(SRC)/sample.aa | vcFormat > prog.linked.aa
	AaOpt -B prog.linked.aa | vcFormat > prog.linked.opt.aa

aa2vc: prog.linked.opt.aa
	Aa2VC -O -C prog.linked.opt.aa | vcFormat > prog.vc

# vC to VHDL
vc2vhdl: prog.vc
	vc2vhdl -U -O -v -a -C -e ahir_system -w -s ghdl $(TOPMODULES) -f prog.vc
	vhdlFormat < ahir_system_global_package.unformatted_vhdl > ahir_system_global_package.vhdl
	vhdlFormat < ahir_system.unformatted_vhdl > ahir_system.vhdl
	vhdlFormat < ahir_system_test_bench.unformatted_vhdl > ahir_system_test_bench.vhdl

# build testbench and ghdl executable
# note the use of libVhpi in building the testbench.
vhdltb: ahir_system.vhdl ahir_system_test_bench.vhdl $(TB)/testbench.c vhdlCStubs.h vhdlCStubs.c
	gcc -g -c vhdlCStubs.c  -I$(TB) -I./ -I$(AHIR_INCLUDE)
	gcc -g -c $(TB)/testbench.c -I$(AHIR_INCLUDE) -I$(SRC) -I./
	gcc -g -o testbench_hw testbench.o vhdlCStubs.o  -L$(AHIR_LIB) -lSocketLibPipeHandler -lpthread

ghdlsim: ahir_system.vhdl ahir_system_test_bench.vhdl $(TB)/testbench.c vhdlCStubs.h vhdlCStubs.c
	ghdl --clean
	ghdl --remove
	ghdl -i --work=GhdlLink  $(VHDL_LIB)/GhdlLink.vhdl
	ghdl -i --work=aHiR_ieee_proposed  $(VHDL_LIB)/aHiR_ieee_proposed.vhdl
	ghdl -i --work=ahir  $(VHDL_LIB)/ahir.vhdl
	ghdl -i --work=work ahir_system_global_package.vhdl
	ghdl -i --work=work ahir_system.vhdl
	ghdl -i --work=work ahir_system_test_bench.vhdl
	ghdl -m --work=work -Wl,-L$(AHIR_LIB) -Wl,-lVhpi ahir_system_test_bench 

clean:
	rm -rf *.o* *.cf *.*vhdl vhdlCStubs.* *.vcd in_data* out_data* testbench_sw testbench_hw ahir_system_test_bench vhpi.log *.aa *.vc *.lso xst *.ngc *_xmsgs *.xrpt pipeHandler.log *.srp *.ghw *.dot

PHONY: all clean	
