library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity tb_Memory is
end entity tb_Memory;

architecture TB_ARCH of tb_Memory is
  signal clock, MeM_R, MeM_W : STD_LOGIC := '0';
  signal Address, data_write, data_out : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
  signal pass : BOOLEAN := TRUE;

  component Memory
    port(
      Address    : in  STD_LOGIC_VECTOR(15 downto 0);
      data_write : in  STD_LOGIC_VECTOR(15 downto 0);
      data_out   : out STD_LOGIC_VECTOR(15 downto 0);
      clock, MeM_R, MeM_W : in  STD_LOGIC
    );
  end component Memory;

  begin
    -- Instantiate the Memory entity
    UUT: Memory port map (Address => Address,
                          data_write => data_write,
                          data_out => data_out,
                          clock => clock,
                          MeM_R => MeM_R,
                          MeM_W => MeM_W);

    -- Clock process
    process
    begin
      while now < 1000 ns loop
        clock <= not clock;
        wait for 5 ns;
      end loop;
      wait;
    end process;

    -- Stimulus process
    process
    begin
      MeM_R <= '0';
      MeM_W <= '0';

      -- Write data to memory
      Address <= "0000000000000010";
      data_write <= "0000000011011011";
      MeM_W <= '1';
      wait for 10 ns;

      -- Read data from memory
      Address <= "0000000000000010";
      MeM_R <= '1';
      wait for 10 ns;

      -- Check if the read data matches the expected value
      if data_out /= "0000000011011011" then
        pass <= FALSE;
      end if;

      wait;
    end process;

		-- Assertion process
		process
		begin
		  wait for 1000 ns;
		  if pass then
			 assert false report "Testbench passed successfully!" severity NOTE;
		  else
			 assert false report "Testbench failed!" severity FAILURE;
		  end if;
		  wait;
		end process;


  end architecture TB_ARCH;
