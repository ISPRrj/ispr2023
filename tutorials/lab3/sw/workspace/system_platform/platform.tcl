platform generate -domains 
platform generate
platform generate
platform active {system_platform}
bsp reload
bsp config enable_sw_intrusive_profiling "true"
bsp config extra_compiler_flags "-mcpu=cortex-a9 -mfpu=vfpv3 -mfloat-abi=hard -nostartfiles -g -Wall -Wextra -fno-tree-loop-distribute-patterns"
bsp config extra_compiler_flags "-mcpu=cortex-a9 -mfpu=vfpv3 -mfloat-abi=hard -nostartfiles -g -Wall -Wextra -fno-tree-loop-distribute-patterns"
bsp config extra_compiler_flags "-mcpu=cortex-a9 -mfpu=vfpv3 -mfloat-abi=hard -nostartfiles -pg -g -Wall -Wextra -fno-tree-loop-distribute-patterns"
bsp write
bsp reload
catch {bsp regenerate}
platform generate
