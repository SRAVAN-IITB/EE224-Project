library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity Memory is
	port(Address:in STD_LOGIC_VECTOR(15 downto 0);
	     Input:in STD_LOGIC_VECTOR(15 downto 0);
		  data_write: in STD_LOGIC_VECTOR(15 downto 0);
		  data_out: out STD_LOGIC_VECTOR(15 downto 0);
		  Output:out STD_LOGIC_VECTOR(15 downto 0);
		  clock, MeM_R,MeM_W: in STD_LOGIC
		  );
end entity Memory;

architecture BHV of Memory is

	type array_of_vectors is ARRAY (4095 downto 0) of STD_LOGIC_VECTOR(7 downto 0);

signal memory_storage: array_of_vectors := ( 1 => "00000001",
                                             2 => Input (15 downto 8),
															3 => Input(7 downto 0),
															5 => "00000001",
															7 => "00000001",
															9 => "00000001",
															11 => "00000001",
															13 => "00000001",
															15 => "00000001",
															17 => "00000001",
															19 => "00000001",
															21 => "00000001",
															23 => "00000001",
															25 => "00000001",
															27 => "00000001",
															29 => "00000001",
															31 => "00000001",
															33 => "00000001",
															35 => "00000001",
															37 => "00000001",
															39 => "00000001",
															41 => "00000001",
															43 => "00000001",
															45 => "00000001",
															47 => "00000001",
															49 => "00000001",
															51 => "00000001",
															53 => "00000001",
															55 => "00000001",
															57 => "00000001",
															59 => "00000001",
															61 => "00000001",
															63 => "00000001",
															65 => "00000001",
															67 => "00000001",
															69 => "00000001",
															71 => "00000001",
															73 => "00000001",
															75 => "00000001",
															77 => "00000001",
															79 => "00000001",
															81 => "00000001",
															83 => "00000001",
															85 => "00000001",
															87 => "00000001",
															89 => "00000001",
															91 => "00000001",
															93 => "00000001",
															95 => "00000001",
															97 => "00000001",
															99 => "00000001",
															101 => "00000001",
															103 => "00000001",
															105 => "00000001",
															107 => "00000001",
															109 => "00000001",
															111 => "00000001",
															113 => "00000001",
															115 => "00000001",
															117 => "00000001",
															119 => "00000001",
															121 => "00000001",
															123 => "00000001",
--														124 => "00010000", 
--														125 => "01001100", 
--														126 => "00010010", 
--														127 => "00111011", 
--														128 => "00110000", 
--														129 => "01010000",
--														130 => "00010000", 
--														131 => "01001100", 
--														132 => "00010010", 
--														133 => "00111011", 
--														134 => "00110000", 
--														135 => "01010000",
--														136 => "00010000", 
--														137 => "01001100", 
--														138 => "00010010", 
--														139 => "00111011", 
--														140 => "00110000", 
--														141 => "01010000",   
														others => "00000000");
															
	begin
	
	-- Process to write data into the memory storage
	memory_write: PROCESS(clock, MeM_W, data_write, Address)
		begin
			if(clock' event and clock = '1') then
				if (MeM_W = '1') then
					memory_storage(to_integer(unsigned(Address))) <= data_write(15 downto 8);
					memory_storage(to_integer(unsigned(Address)) + 1) <= data_write(7 downto 0);
				else 
					NULL;
				end if;
			else
				NULL;
			end if;
		end PROCESS;

	-- Process to read data from the memory storage
	memory_read: PROCESS(MeM_R, Address, memory_storage)
	begin
		if (MeM_R = '1') then
			if (unsigned(Address) < 4096) then
					data_out(15 downto 8) <= memory_storage(to_integer(unsigned(Address)));
					data_out(7 downto 0) <= memory_storage(to_integer(unsigned(Address)) + 1);
			else
				data_out <= (others => '0');  -- Default assignment for invalid address
			end if;
		end if;
	end PROCESS;


	-- unsigned(Address) converts the Address signal to an unsigned integer to make sure that 
	-- the range of values for Address is non-negative and falls within the valid range (0 to 4095), 
	-- and to_integer then converts that unsigned integer to a standard integer. 
	-- This resulting integer is used as an index to access the memory_storage array.
	
					Output(15 downto 8) <= memory_storage(520);
					Output(7 downto 0) <= memory_storage(521);
	
end architecture BHV;
