library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity tb_ALU is
end entity tb_ALU;

architecture testbench of tb_ALU is
  signal clk, rst: std_logic := '0';
  signal A, B, C: std_logic_vector(15 downto 0);
  signal Oper: std_logic_vector(3 downto 0);
  signal Z: std_logic;
  
  component ALU
    port(
      A, B: in STD_LOGIC_VECTOR(15 downto 0);
      Oper: in STD_LOGIC_VECTOR(3 downto 0);
      Z: out STD_LOGIC;
      C: out STD_LOGIC_VECTOR(15 downto 0)
    );
  end component;

begin

  -- Clock process
  clk_process : process
  begin
    while now < 1000 ns loop
      clk <= not clk;
      wait for 5 ns;
    end loop;
    wait;
  end process clk_process;

  -- Reset process
  rst_process: process
  begin
    rst <= '1';
    wait for 20 ns;
    rst <= '0';
    wait;
  end process rst_process;

  -- Stimulus process
  stimulus: process
  begin
    wait until rising_edge(clk);
    
    -- Test ADD operation
    A <= "0000000000000011";
    B <= "0000000000000010";
    Oper <= "0000";
    wait until rising_edge(clk);
    assert Z = '0' and C = "0000000000000101" report "Test ADD failed" severity error;

    -- Test SUB operation
    A <= "0000000000000101";
    B <= "0000000000000010";
    Oper <= "0010";
    wait until rising_edge(clk);
    assert Z = '0' and C = "0000000000000011" report "Test SUB failed" severity error;

    -- Test MULT operation
    A <= "0000000000000111";
    B <= "0000000000001100";
    Oper <= "0011";
    wait until rising_edge(clk);
    assert Z = '0' and C = "0000000001010100" report "Test MULT failed" severity error;

    -- Test BIT AND operation
    A <= "0000000000001010";
    B <= "0000000000001100";
    Oper <= "0100";
    wait until rising_edge(clk);
    assert Z = '0' and C = "0000000000001000" report "Test AND failed" severity error;

    -- Test BIT OR operation
    A <= "0000000000001010";
    B <= "0000000000001100";
    Oper <= "0101";
    wait until rising_edge(clk);
    assert Z = '0' and C = "0000000000001110" report "Test OR failed" severity error;

    -- Test BIT IMPLIES operation
    A <= "0000000000001010";
    B <= "0000000000001100";
    Oper <= "0110";
    wait until rising_edge(clk);
    assert Z = '0' and C = "1111111111111101" report "Test IMPLIES failed" severity error;
	 report "All tests passed successfully!" severity note;
    wait;
  end process stimulus;

  dut: ALU port map(
    A => A,
    B => B,
    Oper => Oper,
    Z => Z,
    C => C
  );

end architecture testbench;
