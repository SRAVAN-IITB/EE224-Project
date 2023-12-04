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
	
	-- Russian peasant multiplication algorithm
	function Mult(A, B: in std_logic_vector(15 downto 0)) 
	return std_logic_vector is
		 variable result : std_logic_vector(15 downto 0) := (others => '0');
		 variable C : std_logic_vector(15 downto 0) := (others => '0');
		 variable D : std_logic_vector(15 downto 0) := (others => '0');
		 variable E : std_logic_vector(15 downto 0) := (others => '0');
		 variable F : std_logic_vector(15 downto 0) := (others => '0');
		 variable intermediate1 : std_logic_vector(15 downto 0) := (others => '0');
		 variable intermediate2 : std_logic_vector(15 downto 0) := (others => '0');
	begin
		C(0) := A(0) AND B(0);
		C(1) := A(1) AND B(0);
		C(2) := A(2) AND B(0);
		C(3) := A(3) AND B(0);
		D(1) := A(0) AND B(1);
		D(2) := A(1) AND B(1);
		D(3) := A(2) AND B(1);
		D(4) := A(3) AND B(1);
		E(2) := A(0) AND B(2);
		E(3) := A(1) AND B(2);
		E(4) := A(2) AND B(2);
		E(5) := A(3) AND B(2);
		F(3) := A(0) AND B(3);
		F(4) := A(1) AND B(3);
		F(5) := A(2) AND B(3);
		F(6) := A(3) AND B(3);
		intermediate1 := Add(C,D);
		intermediate2 := Add(E,F);
		result := Add(intermediate1,intermediate2);	
		 return result;
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