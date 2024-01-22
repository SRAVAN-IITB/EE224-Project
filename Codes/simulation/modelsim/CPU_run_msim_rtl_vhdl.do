transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {C:/EE214_2023/Factorial_4/Reg_File.vhdl}
vcom -93 -work work {C:/EE214_2023/Factorial_4/Reg_16BIT.vhdl}
vcom -93 -work work {C:/EE214_2023/Factorial_4/MUX_2.vhdl}
vcom -93 -work work {C:/EE214_2023/Factorial_4/Memory.vhdl}
vcom -93 -work work {C:/EE214_2023/Factorial_4/CPU.vhdl}
vcom -93 -work work {C:/EE214_2023/Factorial_4/ALU.vhdl}

vcom -93 -work work {C:/EE214_2023/Factorial_4/tb_CPU.vhdl}
vcom -93 -work work {C:/EE214_2023/Factorial_4/CPU.vhdl}

vsim -t 1ps -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L fiftyfivenm -L rtl_work -L work -voptargs="+acc"  tb_CPU

add wave *
view structure
view signals
run -all
