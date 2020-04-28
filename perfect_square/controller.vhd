library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity controller is
    port (clk, rst, start, fnsh1: in std_logic;
          n: in std_logic_vector (7 downto 0);
          C_ld, C_en, fnsh2: out std_logic;
          n_temp: out std_logic_vector (7 downto 0));
end entity;

architecture rtl of controller is
    type state_type is (st0, st1, st2);
    signal current_state, next_state : state_type;
begin 
    process(start, fnsh1, current_state)
    begin
        case current_state is
            when st0 =>
                C_ld <= '0';
                C_en <= '0';
                fnsh2 <= '0';
                next_state <= st1;
            when st1 =>
                C_ld <= '1';
                C_en <= '0';
                fnsh2 <= '0';
                if (start = '1') then
                    next_state <= st2;
                    n_temp <= n;
                else
                    next_state <= st1;
                end if;
            when others =>
                C_ld <= '0';
                C_en <= '1';
                fnsh2 <= fnsh1;
                if (fnsh1 = '1') then
                    next_state <= st1;
                else
                    next_state <= st2;
                end if;
        end case;
    end process;
    process (rst, clk)
    begin
        if (rst ='1') then
            current_state <= st0;
        elsif (rising_edge(clk)) then
            current_state <= next_state;
        end if;
    end process;
end rtl;