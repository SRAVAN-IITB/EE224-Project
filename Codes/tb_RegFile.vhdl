library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_Regfile is
end entity tb_Regfile;

architecture TB_ARCH of tb_Regfile is
    -- Constants
    constant CLOCK_PERIOD : time := 10 ns;

    -- Signals
    signal clk, reset : std_logic := '0';
    signal Address_Read1, Address_Read2, Address_Write : std_logic_vector(2 downto 0);
    signal data_Write : std_logic_vector(15 downto 0);
    signal data_Read1, data_Read2 : std_logic_vector(15 downto 0);

    -- Component instantiation
    component Reg_File
        port (
            Address_Read1, Address_Read2, Address_Write  : in std_logic_vector(2 downto 0);
            data_Write 												: in std_logic_vector(15 downto 0);
            Clk, Reset 												: in std_logic;
            data_Read1, data_Read2 								: out std_logic_vector(15 downto 0)
        );
    end component;

begin
    -- Instantiate the Register File
    DUT: Reg_File
        port map (
            Address_Read1  => Address_Read1,
            Address_Read2  => Address_Read2,
            Address_Write  => Address_Write,
            data_Write 		=> data_Write,
				Clk				=> Clk,
            Reset 			=> reset,
            data_Read1 		=> data_Read1,
            data_Read2 		=> data_Read2
        );

    -- Clock process
    clk_process: process
    begin
        while now < 500 ns loop  -- Simulate for 500 ns
            clk <= '1';
            wait for CLOCK_PERIOD / 2;
            clk <= '0';
            wait for CLOCK_PERIOD / 2;
        end loop;
        wait;
    end process;

    -- Stimulus process
    stimulus_process: process
    begin
        -- Initialize signals
        reset <= '1';
        wait for CLOCK_PERIOD * 2;
        reset <= '0';

        -- Test scenario 1: Write to Register 0, Read from Register 1 and Register 2
        Address_Write <= "000";
        data_Write <= "1111000011110000";
        wait for CLOCK_PERIOD * 2;

        Address_Read1 <= "001";
        Address_Read2 <= "010";
        wait for CLOCK_PERIOD * 2;

        -- Test scenario 2: Write to Register 5, Read from Register 6 and Register 7
        Address_Write <= "101";
        data_Write <= "0101010101010101";
        wait for CLOCK_PERIOD * 2;

        Address_Read1 <= "110";
        Address_Read2 <= "111";
        wait for CLOCK_PERIOD * 2;

        -- Add more test scenarios as needed

        wait;
    end process;

end TB_ARCH;
