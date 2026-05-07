AHIR_LIB=$AHIR_RELEASE/lib
VHDL_LIB=$AHIR_RELEASE/vhdl
ghdl --clean
ghdl --remove
ghdl -i --work=GhdlLink  $VHDL_LIB/GhdlLink.vhdl
ghdl -i --work=aHiR_ieee_proposed  $VHDL_LIB/aHiR_ieee_proposed.vhdl
ghdl -i --work=ahir  $VHDL_LIB/ahir.vhdl
ghdl -i --work=work vhdl_tb/switch_2x2_global_package.vhdl
ghdl -i --work=work vhdl/switch_2x2.vhdl
ghdl -i --work=work vhdl_tb/switch_2x2_test_bench.vhdl
ghdl -m --work=work -Wl,-L$AHIR_LIB -Wl,-lVhpi switch_2x2_test_bench 
