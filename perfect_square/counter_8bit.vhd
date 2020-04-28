library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity counter_8bit is
    port (clk, rst, ld, en: in std_logic;
          d: in std_logic_vector(7 downto 0);
          count: out std_logic_vector(7 downto 0));
end entity;

architecture rtl of counter_8bit is
    signal count_temp: unsigned(7 downto 0);
begin
    process(clk, rst)
    begin
        if (rst = '1') then
            count_temp <= (others => '0');
        elsif(rising_edge (clk)) then
            if (ld = '1') then
                count_temp <= unsigned(d);
            elsif (en = '1') then
                count_temp <= count_temp + 1;
            end if;
        end if;
    end process;		
    count<= std_logic_vector(count_temp);
end rtl;