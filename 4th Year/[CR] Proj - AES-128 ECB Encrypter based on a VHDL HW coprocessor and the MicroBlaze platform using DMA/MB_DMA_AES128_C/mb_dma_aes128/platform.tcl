# 
# Usage: To re-create this platform project launch xsct with below options.
# xsct C:\Users\euric\Vitis_Workspace\mb_dma_aes128\platform.tcl
# 
# OR launch xsct and run below command.
# source C:\Users\euric\Vitis_Workspace\mb_dma_aes128\platform.tcl
# 
# To create the platform in a different location, modify the -out option of "platform create" command.
# -out option specifies the output directory of the platform project.

platform create -name {mb_dma_aes128}\
-hw {C:\Xilinx\projects\mb_dma_aes128.xsa}\
-fsbl-target {psu_cortexa53_0} -out {C:/Users/euric/Vitis_Workspace}

platform write
domain create -name {standalone_microblaze_0} -display-name {standalone_microblaze_0} -os {standalone} -proc {microblaze_0} -runtime {cpp} -arch {32-bit} -support-app {hello_world}
platform generate -domains 
platform active {mb_dma_aes128}
platform generate -quick
platform generate
platform clean
platform generate
platform clean
platform generate
platform clean
platform generate
platform clean
platform generate
platform clean
platform generate
platform clean
platform generate
platform clean
platform generate
platform clean
platform generate
platform config -updatehw {C:/Xilinx/projects/mb_dma_aes128_0307.xsa}
platform clean
platform generate
platform config -updatehw {C:/Xilinx/projects/mb_dma_aes128_0329.xsa}
platform clean
platform generate
platform config -updatehw {C:/Xilinx/projects/mb_dma_aes128_0342.xsa}
platform clean
platform generate
platform config -updatehw {C:/Users/euric/Downloads/mb_design_wrapper.xsa}
platform clean
platform generate
platform clean
platform generate
platform clean
platform clean
platform generate
platform clean
platform generate
platform clean
platform clean
platform generate
platform clean
platform clean
platform generate
platform clean
platform clean
platform generate
platform clean
platform generate
platform write
platform clean
platform generate
platform clean
platform generate
platform clean
platform generate
platform clean
platform generate
platform clean
platform generate
platform clean
platform generate
platform active {mb_dma_aes128}
platform config -updatehw {C:/Xilinx/projects/mb_dma_aes128_0342.xsa}
platform clean
platform generate
platform config -updatehw {C:/Xilinx/projects/mb_dma_aes128_0454.xsa}
platform clean
platform generate
platform config -updatehw {C:/Xilinx/projects/mb_0510.xsa}
platform clean
platform generate
platform config -updatehw {C:/Xilinx/projects/MB_basePlatform_old/MB_DMA_Base/0530.xsa}
platform clean
platform generate
platform config -updatehw {C:/Xilinx/projects/0549.xsa}
platform clean
platform generate
platform config -updatehw {C:/Xilinx/projects/MB_basePlatform_old/MB_DMA_Base/0606.xsa}
platform clean
platform generate
platform config -updatehw {C:/Xilinx/projects/mb_design_wrapper.xsa}
platform clean
platform generate
platform active {mb_dma_aes128}
platform config -updatehw {C:/Xilinx/projects/mb_design_wrapper.xsa}
platform clean
platform generate
platform config -updatehw {C:/Xilinx/projects/mb_design_wrapper.xsa}
platform clean
platform generate
platform config -updatehw {C:/Xilinx/projects/mb_design_wrapper.xsa}
platform config -updatehw {C:/Xilinx/projects/mb_design_wrapper.xsa}
platform clean
platform generate
platform config -updatehw {C:/Xilinx/projects/mb_design_wrapper.xsa}
platform clean
platform generate
platform config -updatehw {C:/Xilinx/projects/mb_design_wrapper.xsa}
platform clean
platform generate
platform config -updatehw {C:/Xilinx/projects/mb_design_wrapper.xsa}
platform clean
platform generate
platform config -updatehw {C:/Xilinx/projects/mb_design_wrapper.xsa}
platform clean
platform generate
platform config -updatehw {C:/Xilinx/projects/mb_design_wrapper.xsa}
platform clean
platform generate
platform config -updatehw {C:/Xilinx/projects/mb_design_wrapper.xsa}
platform clean
platform generate
platform config -updatehw {C:/Xilinx/projects/mb_design_wrapper.xsa}
platform clean
platform generate
platform config -updatehw {C:/Xilinx/projects/mb_design_wrapper.xsa}
platform clean
platform generate
platform config -updatehw {C:/Xilinx/projects/mb_design_wrapper.xsa}
platform generate -domains 
platform clean
platform clean
platform generate
platform config -updatehw {C:/Xilinx/projects/mb_design_wrapper.xsa}
platform clean
platform generate
platform config -updatehw {C:/Xilinx/projects/mb_design_wrapper.xsa}
platform clean
platform generate
platform clean
platform generate
platform clean
platform generate
platform config -updatehw {C:/Xilinx/projects/mb_design_wrapper.xsa}
platform clean
platform generate
platform config -updatehw {C:/Xilinx/projects/mb_design_wrapper.xsa}
platform clean
platform generate
platform config -updatehw {C:/Xilinx/projects/mb_design_wrapper.xsa}
platform clean
platform generate
platform config -updatehw {C:/Xilinx/projects/mb_design_wrapper.xsa}
platform clean
platform generate
platform config -updatehw {C:/Xilinx/projects/mb_design_wrapper.xsa}
platform clean
platform generate
platform config -updatehw {C:/Xilinx/projects/mb_design_wrapper.xsa}
platform clean
platform generate
platform config -updatehw {C:/Xilinx/projects/mb_design_wrapper.xsa}
platform clean
platform generate
platform config -updatehw {C:/Xilinx/projects/mb_design_wrapper.xsa}
platform clean
platform generate
platform config -updatehw {C:/Xilinx/projects/mb_design_wrapper.xsa}
platform clean
platform generate
platform config -updatehw {C:/Xilinx/projects/mb_design_wrapper.xsa}
platform clean
platform generate
platform config -updatehw {C:/Xilinx/projects/mb_design_wrapper.xsa}
platform clean
platform generate
platform config -updatehw {C:/Xilinx/projects/mb_design_wrapper.xsa}
platform clean
platform generate
platform clean
platform generate
platform clean
platform generate
platform config -updatehw {C:/Xilinx/projects/mb_design_wrapper.xsa}
platform clean
platform generate
platform config -updatehw {C:/Xilinx/projects/mb_design_wrapper.xsa}
platform clean
platform generate
platform config -updatehw {C:/Xilinx/projects/mb_design_wrapper.xsa}
platform clean
platform generate
platform config -updatehw {C:/Xilinx/projects/mb_design_wrapper.xsa}
platform clean
platform generate
platform clean
platform generate
platform clean
platform generate
platform config -updatehw {C:/Xilinx/projects/mb_design_wrapper.xsa}
platform clean
platform generate
platform config -updatehw {C:/Xilinx/projects/mb_design_wrapper.xsa}
platform clean
platform generate
platform clean
platform config -updatehw {C:/Xilinx/projects/mb_design_wrapper.xsa}
platform generate
platform clean
platform config -updatehw {C:/Xilinx/projects/mb_design_wrapper.xsa}
platform generate
platform clean
platform config -updatehw {C:/Xilinx/projects/mb_design_wrapper.xsa}
platform generate
platform clean
platform config -updatehw {C:/Xilinx/projects/mb_design_wrapper.xsa}
platform generate
platform clean
platform generate
platform clean
platform config -updatehw {C:/Xilinx/projects/mb_design_wrapper.xsa}
platform generate
platform clean
platform config -updatehw {C:/Xilinx/projects/mb_design_wrapper.xsa}
platform config -updatehw {C:/Xilinx/projects/mb_design_wrapper.xsa}
platform generate
platform clean
platform config -updatehw {C:/Xilinx/projects/mb_design_wrapper.xsa}
platform generate
platform clean
platform config -updatehw {C:/Xilinx/projects/mb_design_wrapper.xsa}
platform generate
platform clean
platform clean
platform config -updatehw {C:/Xilinx/projects/mb_design_wrapper.xsa}
platform generate
platform clean
platform config -updatehw {C:/Xilinx/projects/mb_design_wrapper.xsa}
platform generate
platform clean
platform config -updatehw {C:/Xilinx/projects/mb_design_wrapper.xsa}
platform generate
platform clean
platform config -updatehw {C:/Xilinx/projects/mb_design_wrapper.xsa}
platform generate
platform clean
platform config -updatehw {C:/Xilinx/projects/mb_design_wrapper.xsa}
platform generate
platform clean
platform clean
platform config -updatehw {C:/Xilinx/projects/mb_design_wrapper.xsa}
platform generate
platform clean
platform config -updatehw {C:/Xilinx/projects/mb_design_wrapper.xsa}
platform generate
platform clean
platform config -updatehw {C:/Xilinx/projects/mb_design_wrapper.xsa}
platform generate
platform clean
platform config -updatehw {C:/Xilinx/projects/mb_design_wrapper.xsa}
platform generate
platform config -updatehw {C:/Xilinx/projects/mb_design_wrapper.xsa}
platform clean
platform generate
platform config -updatehw {C:/Xilinx/projects/mb_design_wrapper.xsa}
platform clean
platform generate
platform clean
platform clean
platform config -updatehw {C:/Xilinx/projects/mb_design_wrapper.xsa}
platform generate
platform clean
platform config -updatehw {C:/Xilinx/projects/mb_design_wrapper.xsa}
platform generate
platform clean
platform config -updatehw {C:/Xilinx/projects/mb_design_wrapper.xsa}
platform generate
platform clean
platform config -updatehw {C:/Xilinx/projects/mb_design_wrapper.xsa}
platform generate
platform clean
platform config -updatehw {C:/Xilinx/projects/mb_design_wrapper.xsa}
platform generate
platform clean
platform config -updatehw {C:/Xilinx/projects/mb_design_wrapper.xsa}
platform generate
platform clean
platform config -updatehw {C:/Xilinx/projects/mb_design_wrapper.xsa}
platform generate
platform clean
platform config -updatehw {C:/Xilinx/projects/mb_design_wrapper.xsa}
platform generate
platform clean
platform generate
platform config -updatehw {C:/Xilinx/projects/mb_design_wrapper.xsa}
platform clean
platform generate
platform clean
platform config -updatehw {C:/Xilinx/projects/mb_design_wrapper.xsa}
platform generate
platform clean
platform config -updatehw {C:/Xilinx/projects/mb_design_wrapper.xsa}
platform generate
platform clean
platform config -updatehw {C:/Xilinx/projects/mb_design_wrapper.xsa}
platform generate
platform clean
platform config -updatehw {C:/Xilinx/projects/mb_design_wrapper.xsa}
platform generate
platform config -updatehw {C:/Xilinx/projects/mb_design_wrapper.xsa}
platform clean
platform generate
platform clean
platform config -updatehw {C:/Xilinx/projects/mb_design_wrapper.xsa}
platform generate
platform clean
platform generate
platform clean
platform config -updatehw {C:/Xilinx/projects/mb_design_wrapper.xsa}
platform generate
platform clean
platform active {mb_dma_aes128}
platform config -updatehw {C:/Xilinx/projects/mb_design_wrapper.xsa}
platform generate
platform clean
platform config -updatehw {C:/Xilinx/projects/mb_design_wrapper.xsa}
platform generate
platform clean
platform config -updatehw {C:/Xilinx/projects/mb_design_wrapper.xsa}
platform generate
platform clean
platform clean
platform config -updatehw {C:/Xilinx/projects/mb_design_wrapper.xsa}
platform generate
platform clean
platform config -updatehw {C:/Xilinx/projects/mb_design_wrapper.xsa}
platform generate
platform clean
platform config -updatehw {C:/Xilinx/projects/mb_design_wrapper.xsa}
platform generate
platform clean
platform config -updatehw {C:/Xilinx/projects/mb_design_wrapper.xsa}
platform generate
platform clean
platform config -updatehw {C:/Xilinx/projects/mb_design_wrapper.xsa}
platform generate
platform clean
platform generate
platform clean
platform generate
platform config -updatehw {C:/Xilinx/projects/mb_design_wrapper.xsa}
platform clean
platform generate
platform clean
platform config -updatehw {C:/Xilinx/projects/mb_design_wrapper.xsa}
platform generate
platform config -updatehw {C:/Xilinx/projects/mb_design_wrapper.xsa}
platform clean
platform generate
platform clean
platform config -updatehw {C:/Xilinx/projects/mb_design_wrapper.xsa}
platform clean
platform config -updatehw {C:/Xilinx/projects/mb_design_wrapper.xsa}
platform generate
platform config -updatehw {C:/Xilinx/projects/mb_design_wrapper.xsa}
platform clean
platform generate
platform clean
platform generate
platform clean
platform generate
platform clean
platform config -updatehw {C:/Xilinx/projects/mb_design_wrapper.xsa}
platform generate
platform clean
platform generate
platform config -updatehw {C:/Xilinx/projects/mb_design_wrapper.xsa}
platform clean
platform generate
platform config -updatehw {C:/Xilinx/projects/mb_design_wrapper.xsa}
platform clean
platform generate
platform clean
platform generate
platform config -updatehw {C:/Xilinx/projects/mb_design_wrapper.xsa}
platform clean
platform clean
platform generate
platform config -updatehw {C:/Xilinx/projects/mb_design_wrapper.xsa}
platform clean
platform generate
platform config -updatehw {C:/Xilinx/projects/mb_design_wrapper.xsa}
platform clean
platform generate
platform config -updatehw {C:/Xilinx/projects/mb_design_wrapper.xsa}
platform clean
platform generate
platform config -updatehw {C:/Xilinx/projects/mb_design_wrapper.xsa}
platform clean
platform generate
platform clean
platform generate
platform clean
platform generate
platform config -updatehw {C:/Xilinx/projects/mb_design_wrapper.xsa}
platform clean
platform generate
platform clean
platform generate
platform clean
platform generate
platform clean
platform generate
platform clean
platform clean
platform generate
platform clean
platform generate
platform clean
platform clean
platform config -updatehw {C:/Xilinx/projects/mb_design_wrapper.xsa}
platform generate
platform clean
platform config -updatehw {C:/Xilinx/projects/mb_design_wrapper.xsa}
platform generate
platform clean
platform generate
platform clean
platform generate
platform clean
platform config -updatehw {C:/Xilinx/projects/mb_design_wrapper.xsa}
platform generate
platform clean
platform config -updatehw {C:/Xilinx/projects/mb_design_wrapper.xsa}
platform generate
platform config -updatehw {C:/Xilinx/projects/mb_design_wrapper.xsa}
platform clean
platform generate
platform clean
platform generate
platform config -updatehw {C:/Xilinx/projects/mb_design_wrapper.xsa}
platform clean
platform generate
platform clean
platform config -updatehw {C:/Xilinx/projects/mb_design_wrapper.xsa}
platform generate
platform config -updatehw {C:/Xilinx/projects/mb_design_wrapper.xsa}
platform clean
platform generate
platform clean
platform clean
platform generate
platform config -updatehw {C:/Xilinx/projects/mb_design_wrapper.xsa}
platform clean
platform config -updatehw {C:/Xilinx/projects/mb_design_wrapper.xsa}
platform generate
platform config -updatehw {C:/Xilinx/projects/mb_design_wrapper.xsa}
platform clean
platform generate
platform clean
platform clean
platform config -updatehw {C:/Xilinx/projects/mb_design_wrapper.xsa}
platform generate
platform clean
platform config -updatehw {C:/Xilinx/projects/mb_design_wrapper.xsa}
platform generate
platform config -updatehw {C:/Xilinx/projects/mb_design_wrapper.xsa}
platform clean
platform generate
platform config -updatehw {C:/Xilinx/projects/mb_design_wrapper.xsa}
platform clean
platform clean
platform generate
platform config -updatehw {C:/Xilinx/projects/mb_design_wrapper.xsa}
platform clean
platform generate
platform config -updatehw {C:/Xilinx/projects/mb_design_wrapper.xsa}
platform clean
platform generate
platform clean
platform config -updatehw {C:/Xilinx/projects/mb_design_wrapper.xsa}
platform generate
platform clean
platform config -updatehw {C:/Xilinx/projects/mb_design_wrapper.xsa}
platform generate
platform config -updatehw {C:/Xilinx/projects/mb_design_wrapper.xsa}
platform clean
platform generate
platform clean
platform config -updatehw {C:/Xilinx/projects/mb_design_wrapper.xsa}
platform generate
platform clean
platform generate
platform clean
platform clean
platform config -updatehw {C:/Xilinx/projects/mb_design_wrapper.xsa}
platform generate
platform clean
platform config -updatehw {C:/Xilinx/projects/mb_design_wrapper.xsa}
platform clean
platform config -updatehw {C:/Xilinx/projects/mb_design_wrapper.xsa}
platform clean
platform generate
platform clean
platform generate
platform clean
platform generate
platform config -updatehw {C:/Xilinx/projects/mb_design_wrapper.xsa}
platform clean
platform generate
platform clean
platform config -updatehw {C:/Xilinx/projects/mb_design_wrapper.xsa}
platform generate
platform config -updatehw {C:/Xilinx/projects/mb_design_wrapper.xsa}
platform clean
platform generate
platform clean
platform generate
platform clean
platform generate
platform clean
platform generate
platform clean
platform clean
platform generate
platform config -updatehw {C:/Xilinx/projects/mb_design_wrapper.xsa}
platform clean
platform generate
platform config -updatehw {C:/Xilinx/projects/mb_design_wrapper.xsa}
platform clean
platform generate
platform clean
platform config -updatehw {C:/Xilinx/projects/mb_design_wrapper.xsa}
platform generate
platform config -updatehw {C:/Xilinx/projects/mb_design_wrapper.xsa}
platform clean
platform generate
platform clean
platform config -updatehw {C:/Xilinx/projects/mb_design_wrapper.xsa}
platform generate
platform clean
platform generate
platform clean
platform generate
platform clean
platform generate
platform clean
platform generate
platform clean
platform generate
platform clean
platform generate
platform clean
platform generate
platform clean
platform generate
platform clean
platform generate
platform clean
platform generate
platform clean
platform generate
platform clean
platform generate
platform clean
platform generate
platform clean
platform generate
platform clean
platform generate
platform clean
platform generate
platform clean
platform generate
platform clean
platform generate
platform clean
platform generate
platform clean
platform generate
platform clean
platform generate
platform clean
platform generate
platform clean
platform generate
platform clean
platform generate
platform clean
platform generate
platform clean
platform generate
platform clean
platform generate
platform clean
platform generate
platform clean
platform generate
platform clean
platform generate
platform clean
platform generate
platform clean
platform generate
platform clean
platform generate
platform clean
platform generate
platform clean
platform generate
platform clean
platform generate
platform clean
platform generate
platform clean
platform generate
platform clean
platform generate
platform clean
platform generate
platform clean
platform generate
platform clean
platform generate
platform clean
platform generate
platform clean
platform clean
platform config -updatehw {C:/Xilinx/projects/mb_design_wrapper.xsa}
platform generate
platform clean
platform generate
platform clean
platform generate
platform clean
platform clean
platform generate
platform clean
platform generate
platform clean
platform generate
platform clean
platform generate
platform clean
platform generate
platform clean
platform generate
platform clean
