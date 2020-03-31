onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /MIPS_Processor_TB/clk
add wave -noupdate /MIPS_Processor_TB/reset
add wave -noupdate /MIPS_Processor_TB/PortIn
add wave -noupdate -childformat {{{/MIPS_Processor_TB/ALUResultOut[0]} -radix decimal}} -subitemconfig {{/MIPS_Processor_TB/ALUResultOut[0]} {-height 15 -radix decimal}} /MIPS_Processor_TB/ALUResultOut
add wave -noupdate /MIPS_Processor_TB/PortOut
add wave -noupdate -divider {Torre A}
add wave -noupdate {/MIPS_Processor_TB/DUV/RamMemory/ram[0]}
add wave -noupdate {/MIPS_Processor_TB/DUV/RamMemory/ram[1]}
add wave -noupdate {/MIPS_Processor_TB/DUV/RamMemory/ram[2]}
add wave -noupdate {/MIPS_Processor_TB/DUV/RamMemory/ram[3]}
add wave -noupdate {/MIPS_Processor_TB/DUV/RamMemory/ram[4]}
add wave -noupdate {/MIPS_Processor_TB/DUV/RamMemory/ram[5]}
add wave -noupdate {/MIPS_Processor_TB/DUV/RamMemory/ram[6]}
add wave -noupdate {/MIPS_Processor_TB/DUV/RamMemory/ram[7]}
add wave -noupdate -divider {Torre B}
add wave -noupdate {/MIPS_Processor_TB/DUV/RamMemory/ram[8]}
add wave -noupdate {/MIPS_Processor_TB/DUV/RamMemory/ram[9]}
add wave -noupdate {/MIPS_Processor_TB/DUV/RamMemory/ram[10]}
add wave -noupdate {/MIPS_Processor_TB/DUV/RamMemory/ram[11]}
add wave -noupdate {/MIPS_Processor_TB/DUV/RamMemory/ram[12]}
add wave -noupdate {/MIPS_Processor_TB/DUV/RamMemory/ram[13]}
add wave -noupdate {/MIPS_Processor_TB/DUV/RamMemory/ram[14]}
add wave -noupdate {/MIPS_Processor_TB/DUV/RamMemory/ram[15]}
add wave -noupdate -divider {Torre C}
add wave -noupdate {/MIPS_Processor_TB/DUV/RamMemory/ram[16]}
add wave -noupdate {/MIPS_Processor_TB/DUV/RamMemory/ram[17]}
add wave -noupdate {/MIPS_Processor_TB/DUV/RamMemory/ram[18]}
add wave -noupdate {/MIPS_Processor_TB/DUV/RamMemory/ram[19]}
add wave -noupdate {/MIPS_Processor_TB/DUV/RamMemory/ram[20]}
add wave -noupdate {/MIPS_Processor_TB/DUV/RamMemory/ram[21]}
add wave -noupdate {/MIPS_Processor_TB/DUV/RamMemory/ram[22]}
add wave -noupdate {/MIPS_Processor_TB/DUV/RamMemory/ram[23]}
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {920 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {841 ps} {1313 ps}
