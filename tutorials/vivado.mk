prj: $(PRJ_DIR)/$(FPGA_TOP).xpr
xsa: $(FPGA_TOP).bit system_wrapper.xsa

PLATFORM_NAME=system_platform
DOMAIN_NAME=standalone_ps7_cortexa9_0
APP_NAME=$(FPGA_TOP)

clean:
	rm -rf $(PRJ_DIR)
	rm -rf NA/
	rm -rf *.bit *.log *.jou
	rm -rf run_synth.tcl run_impl.tcl generate_bit.tcl generate_xsa.tcl

$(PRJ_DIR)/$(FPGA_TOP).xpr: create_project.tcl
	vivado -nojournal -nolog -mode batch -source create_project.tcl -tclargs --project_name $(FPGA_TOP)

# synthesis run
$(PRJ_DIR)/%.runs/synth_1/%.dcp: $(PRJ_DIR)/%.xpr
	echo "open_project $(PRJ_DIR)/$*.xpr" > run_synth.tcl
	echo "reset_run synth_1" >> run_synth.tcl
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
	echo "write_bitstream -force $(PRJ_DIR)/$*.runs/impl_1/system_wrapper.bit" >> generate_bit.tcl
	vivado -nojournal -nolog -mode batch -source generate_bit.tcl
	cp $(PRJ_DIR)/$*.runs/impl_1/system_wrapper.bit $@
	mkdir -p rev
	EXT=bit; COUNT=100; 
	while [ -e rev/$*_rev$$COUNT.$$EXT ]; \
	do COUNT=$$((COUNT+1)); done; \
	cp $@ rev/$*_rev$$COUNT.$$EXT; \
	echo "Output: rev/$*_rev$$COUNT.$$EXT";

%.xsa: $(PRJ_DIR)/$(FPGA_TOP).runs/impl_1/%.bit
	echo "open_project $(PRJ_DIR)/$(FPGA_TOP).xpr" > generate_xsa.tcl
	echo "write_hw_platform -fixed -include_bit -force -file $@" >> generate_xsa.tcl
	vivado -nojournal -nolog -mode batch -source generate_xsa.tcl

app:
	xsct -eval "setws "workspace"; \
		platform create -name {$(PLATFORM_NAME)} -hw {../hw/system_wrapper.xsa} -no-boot-bsp; \
		domain create -name {$(DOMAIN_NAME)} -os standalone -proc {ps7_cortexa9_0}; \
		app create -name {$(APP_NAME)} -platform {$(PLATFORM_NAME)} -domain {$(DOMAIN_NAME)} -template {Hello World}; \
		platform active {$(PLATFORM_NAME)}; \
		platform generate; \
		app build {$(APP_NAME)}"
