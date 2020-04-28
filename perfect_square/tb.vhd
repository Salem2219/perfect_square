library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity tb is
end entity;

architecture behav of tb is
    component toplevel is
        port (clk, rst, en: in std_logic;
              n: in std_logic_vector (7 downto 0);
              fnsh, returned: out std_logic);
    end component ;

    constant clockperiod: time := 0.1 ns;
    signal clk: std_logic := '1';
    signal rst, en, fnsh, returned : std_logic;
    signal n : std_logic_vector(7 downto 0);
begin
    dut: toplevel port map(clk, rst, en, n, fnsh, returned);
    clk <= not clk after clockperiod /2;
    rst <= '1', '0' after 0.07 ns;
    en <= '0', '1' after 0.17 ns, '0' after 0.27 ns, '1' after 1.17 ns, '0' after 1.27 ns;
    n <= "01010001", "00011110" after 1.07 ns;
end behav;