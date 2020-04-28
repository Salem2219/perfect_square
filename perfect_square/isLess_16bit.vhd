library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity isLess_16bit is
    port (x, y: in std_logic_vector (15 downto 0);
          isLess: out std_logic);
end entity ;

architecture rtl of isLess_16bit is
begin
    process(x, y)
    begin
        if (unsigned(x) < unsigned(y)) then
            isLess <= '1';
        else
            isLess <= '0';
        end if;
    end process;
end rtl;