# EE224 Course Project: IITB-CPU
A 16-bit single-cycle CPU described in VHDL and implemented on an FPGA.

This project is part of the course Digital Systems (EE224), at IIT Bombay (2023)

### Team
* [Sravan K Suresh](https://github.com/SRAVAN-IITB)
* [Chinmay Moorjani](https://github.com/krimsonscorpio-manga)
* [Anshu Arora](https://github.com/AroraAnshu26)
* [Sachi Deshmukh](https://github.com/Sachi-Deshmukh)

[Design Document](/DesignReport.pdf)

## Component List

### ARITHEMATIC UNIT
1. `adder16.vhdl`: 16-bit adder
2. `nandbit.vhdl`: 16-bitwise NAND
3. `alu.vhdl`: combination of ADD and NAND with flag registers(C,Z flags)

### MULTIPLEXERS
#### 1-bit Devices
1. `Mux1_2_1.vhdl`: 2-to-1 MUX
2. `Mux1_4_1.vhdl`: 4-to-1 MUX
#### 3-bit Devices
1. `Mux3_2_1.vhdl`: 2-to-1 MUX
2. `Mux3_4_1.vhdl`: 4-to-1 MUX
#### 16-bit Devices
1. `Mux16_2_1.vhdl`: 2-to-1 MUX
2. `Mux16_4_1.vhdl`: 4-to-1 MUX

### REGISTERS
1. `Register1.vhdl`: 1-bit register with synchronous write and ascynchonous read
2. `Register16.vhdl`: 16-bit register with synchronous write and ascynchonous read
3. `Register_file.vhdl`: Set of 8 16-bit registers

### MEMORY UNIT
`Memory_asyncread_syncwrite.vhd`

### FSM
`FSM.vhdl`: Controller FSM (controls signals)

### DUT
`iitb_cpu.vhdl`: Main code
