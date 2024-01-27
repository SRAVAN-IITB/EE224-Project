library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity tb_Memory is
end entity tb_Memory;

architecture testbench of tb_Memory is
    -- Constants for simulation parameters
    constant CLOCK_PERIOD: time := 10 ns; -- Clock period in nanoseconds
    constant MEM_DEPTH: integer := 256;   -- Depth of memory

    -- Signals for the testbench
    signal clock, MeM_R, MeM_W: std_logic := '0';
    signal Address, Input, data_write, data_out, Output: std_logic_vector(15 downto 0);

begin
    -- Instantiate the Memory entity
    uut: entity work.Memory
        port map (
            Address    => Address,
            Input      => Input,
            data_write => data_write,
            data_out   => data_out,
            Output     => Output,
            clock      => clock,
            MeM_R      => MeM_R,
            MeM_W      => MeM_W
        );

    -- Clock generation process
    clk_process: process
    begin
        while now < 1000 ns loop
            clock <= '0';
            wait for CLOCK_PERIOD / 2;
            clock <= '1';
            wait for CLOCK_PERIOD / 2;
        end loop;
        wait;
    end process;

    -- Test scenario
    test_scenario: process
    begin
        -- Initialize inputs
        Address <= (others => '0');
        Input   <= "1100110011001100"; -- Sample input data
        data_write <= "1111000011110000"; -- Sample data to be written

        -- Perform a write operation
        MeM_W <= '1';
        wait for CLOCK_PERIOD; -- Wait for one clock cycle
        MeM_W <= '0';

        -- Perform a read operation
        MeM_R <= '1';
        wait for CLOCK_PERIOD; -- Wait for one clock cycle
        MeM_R <= '0';

        -- Additional test scenarios can be added here

        wait;
    end process;

    -- Monitor process for displaying simulation results
    monitor_process: process
    begin
        wait for 1 ns; -- Wait for a short time to avoid initial conflicts
--        report "Time = " & integer'image(to_integer(unsigned(now))) severity note;
--        report "Address = " & to_string(Address) severity note;
--        report "Input = " & to_string(Input) severity note;
--        report "Data Write = " & to_string(data_write) severity note;
--        report "Data Out = " & to_string(data_out) severity note;
--        report "Output = " & to_string(Output) severity note;

        wait;
    end process;

end architecture testbench;
