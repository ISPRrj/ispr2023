# Usage with Vitis IDE:
# In Vitis IDE create a Single Application Debug launch configuration,
# change the debug type to 'Attach to running target' and provide this 
# tcl script in 'Execute Script' option.
# Path of this script: /home/ispr/ispr/tutorials/lab2/sw/workspace/lab2_system/_ide/scripts/debugger_lab2-default.tcl
# 
# 
# Usage with xsct:
# To debug using xsct, launch xsct and run below command
# source /home/ispr/ispr/tutorials/lab2/sw/workspace/lab2_system/_ide/scripts/debugger_lab2-default.tcl
# 
connect -url tcp:127.0.0.1:3121
set bp_41_5_0 [bpadd -target-id all -ct-input {0} -ct-output {24 25 26 27} -skip-on-step 0]
set bp_41_5_1 [bpadd -target-id all -ct-input {24 25 26 27} -ct-output {0}]
targets -set -nocase -filter {name =~"APU*"}
loadhw -hw /home/ispr/ispr/tutorials/lab2/sw/workspace/system_platform/export/system_platform/hw/system_wrapper.xsa -mem-ranges [list {0x40000000 0xbfffffff}] -regs
configparams force-mem-access 1
targets -set -nocase -filter {name =~"APU*"}
stop
source /home/ispr/ispr/tutorials/lab2/sw/workspace/lab2/_ide/psinit/ps7_init.tcl
ps7_init
ps7_post_config
targets -set -nocase -filter {name =~ "*A9*#0"}
rst -processor
targets -set -nocase -filter {name =~ "*A9*#0"}
dow /home/ispr/ispr/tutorials/lab2/sw/workspace/lab2/Debug/lab2.elf
configparams force-mem-access 0
bpadd -addr &main
