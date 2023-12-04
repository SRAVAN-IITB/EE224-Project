transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {C:/Users/ASUS/OneDrive - Indian Institute of Technology Bombay/ACADS/SEMESTER-3/EE-224/PROJECT/Codes_Sravmay/Reg_File.vhdl}
vcom -93 -work work {C:/Users/ASUS/OneDrive - Indian Institute of Technology Bombay/ACADS/SEMESTER-3/EE-224/PROJECT/Codes_Sravmay/Reg_16BIT.vhdl}
vcom -93 -work work {C:/Users/ASUS/OneDrive - Indian Institute of Technology Bombay/ACADS/SEMESTER-3/EE-224/PROJECT/Codes_Sravmay/MUX_2.vhdl}
vcom -93 -work work {C:/Users/ASUS/OneDrive - Indian Institute of Technology Bombay/ACADS/SEMESTER-3/EE-224/PROJECT/Codes_Sravmay/Memory.vhdl}
vcom -93 -work work {C:/Users/ASUS/OneDrive - Indian Institute of Technology Bombay/ACADS/SEMESTER-3/EE-224/PROJECT/Codes_Sravmay/CPU.vhdl}
vcom -93 -work work {C:/Users/ASUS/OneDrive - Indian Institute of Technology Bombay/ACADS/SEMESTER-3/EE-224/PROJECT/Codes_Sravmay/ALU.vhdl}

vcom -93 -work work {C:/Users/ASUS/OneDrive - Indian Institute of Technology Bombay/ACADS/SEMESTER-3/EE-224/PROJECT/Codes_Sravmay/tb_CPU.vhdl}
vcom -93 -work work {C:/Users/ASUS/OneDrive - Indian Institute of Technology Bombay/ACADS/SEMESTER-3/EE-224/PROJECT/Codes_Sravmay/CPU.vhdl}

vsim -t 1ps -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L fiftyfivenm -L rtl_work -L work -voptargs="+acc"  tb_CPU

add wave *
view structure
view signals
run -all
