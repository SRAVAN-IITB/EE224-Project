-- A DUT entity is used to wrap your design so that we can combine it with testbench.

library IEEE;
use IEEE.std_logic_1164.all;

entity DUT is
    port(input_vector: in std_logic_vector(35 downto 0);
       	output_vector: out std_logic_vector(16 downto 0));
end entity;

architecture DutWrap of DUT is
   component ALU is 
		port(A,B: in STD_LOGIC_VECTOR(15 downto 0);
	     Oper:in STD_LOGIC_VECTOR(3 downto 0);
		  Z: 	out STD_LOGIC;
		  C: 	out STD_LOGIC_VECTOR(15 downto 0));
	end component ALU;
begin

   -- input/output vector element ordering is critical,
   -- and must match the ordering in the trace file!
   add_instance: ALU
			port map (
					-- order of inputs: A, B, Oper
					A => input_vector(35 downto 20),
					B => input_vector(19 downto 4),
					Oper => input_vector(3 downto 0),
               -- order of output: C, Z
					C => output_vector(16 downto 1),
					Z => output_vector(0));
end DutWrap;