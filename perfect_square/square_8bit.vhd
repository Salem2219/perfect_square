library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity square_8bit is
    port (x: in std_logic_vector (7 downto 0);
          y: out std_logic_vector (15 downto 0));
end entity;
    
architecture rtl of square_8bit is
    signal y_temp: std_logic_vector (15 downto 0);
begin
    y_temp <= unsigned(x) * unsigned(x);
    y <= std_logic_vector(y_temp);
end rtl;