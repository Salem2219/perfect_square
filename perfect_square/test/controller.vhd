library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity controller is
    port (clk, rst, start, fnsh1: in std_logic;
          R_ld, C_ld, C_en, fnsh2: out std_logic);
end entity;

architecture rtl of controller is
    type state_type is (st0, st1, st2, st3);
    signal current_state, next_state: state_type;
begin 
    process(start, fnsh1, current_state)
    begin
        case current_state is
            when st0 =>
                R_ld <= '0';
                C_ld <= '0';
                C_en <= '0';
                fnsh2 <= '0';
                next_state <= st1;
            when st1 =>
                R_ld <= '1';
                C_ld <= '1';
                C_en <= '0';
                fnsh2 <= '0';
                if (start = '1') then
                    next_state <= st2;
                else
                    next_state <= st1;
                end if;
            when st2 =>
                R_ld <= '0';
                C_ld <= '0';
                C_en <= '0';
                fnsh2 <= '0';
                next_state <= st3;
            when others =>
                R_ld <= '0';
                C_ld <= '0';
                C_en <= '1';
                fnsh2 <= fnsh1;
                if (fnsh1 = '1') then
                    next_state <= st1;
                else
                    next_state <= st3;
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