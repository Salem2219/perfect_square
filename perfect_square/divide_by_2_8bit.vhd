library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity divide_by_2_8bit is
    port (x: in std_logic_vector (7 downto 0);
          y: out std_logic_vector (7 downto 0));
end entity;
    
architecture rtl of divide_by_2_8bit is
begin
    y <= '0' & x(7 downto 1);
end rtl;