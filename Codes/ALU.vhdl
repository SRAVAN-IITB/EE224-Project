library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity ALU is
	port(A,B: in STD_LOGIC_VECTOR(15 downto 0);
	     Oper:in STD_LOGIC_VECTOR(3 downto 0);
		  Z: 	out STD_LOGIC;
		  C: 	out STD_LOGIC_VECTOR(15 downto 0));
end entity ALU;

architecture BHV of ALU is
	signal DATA1_temp: STD_LOGIC_VECTOR(15 downto 0);

	function Add(A, B: in STD_LOGIC_VECTOR(15 downto 0))
		return STD_LOGIC_VECTOR is
		-- declaring and initializing variables using aggregates
		variable carry : STD_LOGIC := '0';
		variable sum : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
			begin
				for i in 0 to 15 LOOP
					sum(i) := (A(i) xor B(i)) xor carry;
					carry := ((A(i) and B(i)) or ((A(i) xor B(i)) and carry));
				end LOOP;
		return sum;
	end Add;

	function sub(A, B: in STD_LOGIC_VECTOR(15 downto 0))
		return STD_LOGIC_VECTOR is
		-- declaring and initializing variables using aggregates
		variable borrow : STD_LOGIC := '0';
		variable diff : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
			begin
				for i in 0 to 15 LOOP
					diff(i) := (A(i) xor B(i)) xor borrow;
					borrow := ((not A(i)) and B(i)) or (((not A(i)) or B(i)) and borrow);
				end LOOP;
		return diff;
	end sub;

	function Mult(A, B: in STD_LOGIC_VECTOR(15 downto 0)) 
		return STD_LOGIC_VECTOR is
		variable product : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
		variable temp_product : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
	begin
		for i in 0 to 15 LOOP
			for j in 0 to 15 LOOP
				if (i + j) < 16 then
					temp_product(i + j) := temp_product(i + j) xor (A(i) and B(j));
				end if;
			end LOOP;
		 end LOOP;

		for k in 0 to 15 LOOP
			product(k) := temp_product(k);
		end LOOP;
		
		return product(15 downto 0);
	end Mult;

	function bit_AND(A, B: in STD_LOGIC_VECTOR(15 downto 0))
		return STD_LOGIC_VECTOR is
		-- declaring and initializing variables using aggregates
		variable bit_AND1 : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
	begin
		for i in 0 to 15 LOOP
			bit_AND1(i) := A(i) and B(i);
		end LOOP;
		return bit_AND1;
	end bit_AND;

	function bit_OR(A, B: in STD_LOGIC_VECTOR(15 downto 0))
		return STD_LOGIC_VECTOR is
		-- declaring and initializing variables using aggregates
		variable bit_OR1 : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
	begin
		for i in 0 to 15 LOOP
			bit_OR1(i) := A(i) or B(i);
		end LOOP;
		return bit_OR1;
	end bit_OR;

	function bit_IMPLIES(A, B: in STD_LOGIC_VECTOR(15 downto 0))
		return STD_LOGIC_VECTOR is
		variable bit_IMPLIES1 : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
	begin
		for i in 0 to 15 LOOP
			bit_IMPLIES1(i) := (not A(i)) or B(i);
		end LOOP;
		return bit_IMPLIES1;
	end bit_IMPLIES;

	begin
	Decide_Oper: process(Oper, DATA1_temp, A, B)
	begin
		 case Oper is
			  when "0000" => 
					DATA1_temp <= Add(A, B);
			  when "0010" => 
					DATA1_temp <= sub(A, B);
			  when "0011" => 
					DATA1_temp <= Mult(A, B);  
			  when "0100" => 
					DATA1_temp <= bit_AND(A, B);
			  when "0101" => 
					DATA1_temp <= bit_OR(A, B);
			  when "0110" => 
					DATA1_temp <= bit_IMPLIES(A, B);
			  when others => 
					-- Adding a default assignment to avoid latches
					DATA1_temp <= (others => '0');
		 end case;
	end process Decide_Oper;
	Z <= NOT(data1_temp(0) OR data1_temp(1) OR data1_temp(2) OR data1_temp(3) 
			OR data1_temp(4) OR data1_temp(5) OR data1_temp(6) OR data1_temp(7) 
			OR data1_temp(8) OR data1_temp(9) OR data1_temp(10) OR data1_temp(11) 
			OR data1_temp(12) OR data1_temp(13) OR data1_temp(14) OR data1_temp(15));
	c <= DATA1_temp;

end architecture BHV;