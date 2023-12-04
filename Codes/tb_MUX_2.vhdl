library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity tb_MUX_2 is
end entity;

architecture tb of tb_MUX_2 is
    component MUX_2 is 
        Port ( S : in STD_LOGIC;
               I : in STD_LOGIC_VECTOR (1 downto 0);
               Y : out STD_LOGIC);
    end component;

    signal S : STD_LOGIC;
    signal I0, I1, Y : STD_LOGIC;

begin 
    uut : MUX_2 port map(
                            S => S,
                            I(0) => I0,
                            I(1) => I1,
                            Y => Y
                            );
    stim : process
    begin
        I0 <= '0';
        I1 <= '1';

        S <= '0'; wait for 10 ns;
        S <= '1'; wait for 10 ns;

        wait;
    end process;
end tb;
