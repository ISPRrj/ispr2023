$(PRJ_DIR)/$(FPGA_TOP).xpr: create_project.tcl
vivado -nojournal -nolog -mode batch -source create_project.tcl
# synthesis run
$(PRJ_DIR)/%.runs/synth_1/%.dcp: $(PRJ_DIR)/%.xpr
echo "open_project $(PRJ_DIR)/$*.xpr" > run_synth.tcl
\techo "reset_run synth_1" >> run_synth.tcl
echo "launch_runs -jobs 4 synth_1" >> run_synth.tcl
echo "wait_on_run synth_1" >> run_synth.tcl
vivado -nojournal -nolog -mode batch -source run_synth.tcl
# implementation run
$(PRJ_DIR)/%.runs/impl_1/%_routed.dcp: $(PRJ_DIR)/%.runs/synth_1/%.dcp
echo "open_project $(PRJ_DIR)/$*.xpr" > run_impl.tcl
echo "reset_run impl_1" >> run_impl.tcl
echo "launch_runs -jobs 4 impl_1" >> run_impl.tcl
echo "wait_on_run impl_1" >> run_impl.tcl
vivado -nojournal -nolog -mode batch -source run_impl.tcl
# bit file
%.bit: $(PRJ_DIR)/%.runs/impl_1/%_routed.dcp
echo "open_project $(PRJ_DIR)/$*.xpr" > generate_bit.tcl
echo "open_run impl_1" >> generate_bit.tcl
echo "write_bitstream -force $*.bit" >> generate_bit.tcl
vivado -nojournal -nolog -mode batch -source generate_bit.tcl
mkdir -p rev
EXT=bit; COUNT=100; \
while [ -e rev/$*_rev$$COUNT.$$EXT ]; \
do COUNT=$$((COUNT+1)); done; \
cp $@ rev/$*_rev$$COUNT.$$EXT; \
echo "Output: rev/$*_rev$$COUNT.$$EXT";




