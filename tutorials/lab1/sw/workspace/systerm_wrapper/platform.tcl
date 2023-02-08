# 
# Usage: To re-create this platform project launch xsct with below options.
# xsct /home/ispr/ispr/tutorials/lab1/sw/workspace/systerm_wrapper/platform.tcl
# 
# OR launch xsct and run below command.
# source /home/ispr/ispr/tutorials/lab1/sw/workspace/systerm_wrapper/platform.tcl
# 
# To create the platform in a different location, modify the -out option of "platform create" command.
# -out option specifies the output directory of the platform project.

platform create -name {systerm_wrapper}\
-hw {/home/ispr/ispr/tutorials/lab1/hw/systerm_wrapper.xsa}\
-no-boot-bsp -out {/home/ispr/ispr/tutorials/lab1/sw/workspace}

platform write
domain create -name {standalone_ps7_cortexa9_0} -display-name {standalone_ps7_cortexa9_0} -os {standalone} -proc {ps7_cortexa9_0} -runtime {cpp} -arch {32-bit} -support-app {hello_world}
platform generate -domains 
platform active {systerm_wrapper}
platform generate -quick
platform generate
platform generate
platform generate
