library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity toplevel is
    port (clk, rst, en: in std_logic;
          n: in std_logic_vector (7 downto 0);
          fnsh, returned: out std_logic);
end entity;

architecture rtl of toplevel is
    component datapath is
        port (clk, rst, C_ld, C_en: in std_logic;
              n_temp: in std_logic_vector (7 downto 0);
              fnsh1, returned1: out std_logic);
    end component;

    component controller is
        port (clk, rst, start, fnsh1: in std_logic;
              n: in std_logic_vector (7 downto 0);
              C_ld, C_en, fnsh2: out std_logic;
              n_temp: out std_logic_vector (7 downto 0));
    end component;

    component isEqual_8bit is
        port (x, y: in std_logic_vector (7 downto 0);
              isEqual: out std_logic);
    end component;

    signal R_ld, C_ld, C_en, fnsh0, fnsh1, fnsh2, start, returned1, x3, x3_0, x3_1: std_logic;
    signal n_temp: std_logic_vector (7 downto 0);
begin
    u0: datapath port map (clk, rst, C_ld, C_en, n_temp, fnsh1, returned1);
    u1: controller port map (clk, rst, start, fnsh1, n, C_ld, C_en, fnsh2, n_temp);
    u2: isEqual_8bit port map (n, "00000000", x3_0);
    u3: isEqual_8bit port map (n, "00000001", x3_1);
    x3 <= x3_0 OR x3_1;
    start <= NOT x3 AND en;
    fnsh0 <= x3 AND en;
    fnsh <= fnsh0 OR fnsh2;
    returned <= fnsh0 OR returned1;
    
end rtl;