library IEEE;
use IEEE.std_logic_1164.all;

entity tb_CPU is 
end entity tb_CPU; 

architecture arch of tb_CPU is 
	component CPU is 
		port(Clk, Reset: in std_logic);
	end component CPU;

	signal clk, rst: std_logic;
	
	begin
		rst <= '1', '0' after 10 ns;
		clk1: process
		constant OFF_PERIOD: TIME := 15 ns; 
		constant ON_PERIOD: TIME := 15 ns; 
	begin 
		wait for OFF_PERIOD; 
		clk <= '1'; 
		wait for ON_PERIOD;
		clk <= '0'; 
	end process clk1;

		-- Assertion process
		end_sim : process
		begin
			wait for 1000ns;
			ASSERT False
			REPORT "Simulation ended"
			SEVERITY failure;
		end process end_sim;

EUT: CPU port map (Clk => clk, 
					  Reset => rst);
 
end arch;