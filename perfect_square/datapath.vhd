library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity datapath is
    port (clk, rst, C_ld, C_en: in std_logic;
          n_temp: in std_logic_vector (7 downto 0);
          fnsh1, returned1: out std_logic);
end entity;

architecture rtl of datapath is
    component counter_8bit is
        port (clk, rst, ld, en: in std_logic;
              d: in std_logic_vector(7 downto 0);
              count: out std_logic_vector(7 downto 0));
    end component;

    component square_8bit is
        port (x: in std_logic_vector (7 downto 0);
              y: out std_logic_vector (15 downto 0));
    end component;

    component divide_by_2_8bit is
        port (x: in std_logic_vector (7 downto 0);
              y: out std_logic_vector (7 downto 0));
    end component;
    
    component  isEqual_16bit is
        port (x, y: in std_logic_vector (15 downto 0);
              isEqual: out std_logic);
    end component;

    component  isLess_8bit is
        port (x, y: in std_logic_vector (7 downto 0);
              isLess: out std_logic);
    end component;

    component isLess_16bit is
        port (x, y: in std_logic_vector (15 downto 0);
              isLess: out std_logic);
    end component;

    signal x0, x1, x2: std_logic;
    signal n_over2, i: std_logic_vector (7 downto 0);
    signal x, n_temp_ex: std_logic_vector (15 downto 0);
begin
    u1: counter_8bit port map (clk, rst, C_ld, C_en, "00000010", i);
    u2: square_8bit port map (i, x);
    u3: divide_by_2_8bit port map (n_temp, n_over2);
    u7: isEqual_16bit port map (x, n_temp_ex, x1);
    u8: isLess_8bit port map (n_over2, i, x2);
    u9: isLess_16bit port map (n_temp_ex, x, x0);
    n_temp_ex <= "00000000" & n_temp;
    fnsh1 <= x0 OR x1 OR x2;
    returned1 <= NOT x2 AND x1;
end rtl;