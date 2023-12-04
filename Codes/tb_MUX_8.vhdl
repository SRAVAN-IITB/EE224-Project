library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity tb_MUX_8 is
end entity;

architecture tb of tb_MUX_8 is
    component MUX_8 is
        Port ( S : in STD_LOGIC_VECTOR (2 downto 0);
               I : in STD_LOGIC_VECTOR (7 downto 0);
               Y : out STD_LOGIC);
    end component;

    signal S : STD_LOGIC_VECTOR(2 downto 0);
    signal I : STD_LOGIC_VECTOR(7 downto 0);
    signal Y : STD_LOGIC;

begin 
    uut : MUX_8 port map(
        S => S,
        I => I,
        Y => Y
    );

    stim : process
    begin
        I(0) <= '0';
        I(1) <= '1';
        I(2) <= '0';
        I(3) <= '1';
        I(4) <= '1';
        I(5) <= '0';
        I(6) <= '1';
        I(7) <= '0';

        S <= "000"; wait for 10 ns;
        S <= "001"; wait for 10 ns;
        S <= "010"; wait for 10 ns;
        S <= "011"; wait for 10 ns;
        S <= "100"; wait for 10 ns;
        S <= "101"; wait for 10 ns;
        S <= "110"; wait for 10 ns;
        S <= "111"; wait for 10 ns;

        wait;
    end process;
end tb;
