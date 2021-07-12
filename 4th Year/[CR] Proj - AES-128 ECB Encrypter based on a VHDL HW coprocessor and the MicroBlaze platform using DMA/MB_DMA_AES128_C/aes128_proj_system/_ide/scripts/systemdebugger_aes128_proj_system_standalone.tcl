# Usage with Vitis IDE:
# In Vitis IDE create a Single Application Debug launch configuration,
# change the debug type to 'Attach to running target' and provide this 
# tcl script in 'Execute Script' option.
# Path of this script: C:\Xilinx\projects\CR_AES128_Proj\MB_DMA_AES128_C\aes128_proj_system\_ide\scripts\systemdebugger_aes128_proj_system_standalone.tcl
# 
# 
# Usage with xsct:
# To debug using xsct, launch xsct and run below command
# source C:\Xilinx\projects\CR_AES128_Proj\MB_DMA_AES128_C\aes128_proj_system\_ide\scripts\systemdebugger_aes128_proj_system_standalone.tcl
# 
connect -url tcp:127.0.0.1:3121
targets -set -filter {jtag_cable_name =~ "Digilent Nexys4 210274504963A" && level==0 && jtag_device_ctx=="jsn-Nexys4-210274504963A-13631093-0"}
fpga -file C:/Xilinx/projects/CR_AES128_Proj/MB_DMA_AES128_C/aes128_proj/_ide/bitstream/mb_design_wrapper.bit
targets -set -nocase -filter {name =~ "*microblaze*#0" && bscan=="USER2" }
loadhw -hw C:/Users/euric/Vitis_Workspace/mb_dma_aes128/export/mb_dma_aes128/hw/mb_design_wrapper.xsa -regs
configparams mdm-detect-bscan-mask 2
targets -set -nocase -filter {name =~ "*microblaze*#0" && bscan=="USER2" }
rst -system
after 3000
targets -set -nocase -filter {name =~ "*microblaze*#0" && bscan=="USER2" }
dow C:/Xilinx/projects/CR_AES128_Proj/MB_DMA_AES128_C/aes128_proj/Debug/aes128_proj.elf
targets -set -nocase -filter {name =~ "*microblaze*#0" && bscan=="USER2" }
con
