--------------------------- Mux5x8(ULA) ---------------------------
library ieee;
use ieee.std_logic_1164.all;

entity mux5x8 is
    port(
        c0    : in std_logic_vector(7 downto 0);
        c1    : in std_logic_vector(7 downto 0);
        c2    : in std_logic_vector(7 downto 0);
        c3    : in std_logic_vector(7 downto 0);
        c4    : in std_logic_vector(7 downto 0);
        sel   : in std_logic_vector(2 downto 0);    
        sMUX  : out std_logic_vector(7 downto 0)
    );
end entity;

architecture mux of mux5x8 is
begin

    sMUX <= c0 when sel = "000" else
            c1 when sel = "001" else
            c2 when sel = "010" else
            c3 when sel = "011" else
            c4 when sel = "100" else
            (others => 'Z');
            
end architecture;

--------------------------- Mux2x8 - pc(UC) ---------------------------
library ieee;
use ieee.std_logic_1164.all;

entity mux2x8pc is
    port(
        c0  : in std_logic_vector(7 downto 0);
        c1  : in std_logic_vector(7 downto 0);
        sel : in std_logic;
        z   : out std_logic_vector(7 downto 0)
    );
end entity;

architecture comutar of mux2x8pc is 

begin

    z <= c0 when sel = '0' else 
         c1 when sel = '1' else 
         "ZZZZZZZZ";

end architecture;

--------------------------- Mux2x11 - jn(UC) ---------------------------
library ieee;
use ieee.std_logic_1164.all;

entity mux2x11jn is
    port(
        c0  : in std_logic_vector(10 downto 0);
        c1  : in std_logic_vector(10 downto 0);
        sel : in std_logic;
        s   : out std_logic_vector(10 downto 0)
    );
end entity;

architecture selecionar of mux2x11jn is

begin

    s <= c0 when sel = '0' else
         c1 when sel = '1' else
         (others => 'Z');

end architecture;

--------------------------- Mux2x11 - jz(UC) ---------------------------
library ieee;
use ieee.std_logic_1164.all;

entity mux2x11jz is
    port(
        c0  : in std_logic_vector(10 downto 0);
        c1  : in std_logic_vector(10 downto 0);
        sel : in std_logic;
        s   : out std_logic_vector(10 downto 0)
    );
end entity;

architecture selecionar of mux2x11jz is

begin

    s <= c0 when sel = '0' else
         c1 when sel = '1' else
         (others => 'Z');

end architecture;

--------------------------- Mux11x11(UC) ---------------------------
library ieee;
use ieee.std_logic_1164.all;

entity mux11x11z is
    port(
        b_NOP  : in std_logic_vector(10 downto 0);
        b_STA  : in std_logic_vector(10 downto 0);
        b_LDA  : in std_logic_vector(10 downto 0);
        b_ADD  : in std_logic_vector(10 downto 0);
        b_AND  : in std_logic_vector(10 downto 0);
        b_OR   : in std_logic_vector(10 downto 0);
        b_NOT  : in std_logic_vector(10 downto 0);
        b_JMP  : in std_logic_vector(10 downto 0);
        b_JN   : in std_logic_vector(10 downto 0);
        b_JZ   : in std_logic_vector(10 downto 0);
        b_HLT  : in std_logic_vector(10 downto 0);
        sel_op : in std_logic_vector(10 downto 0);
        s      : out std_logic_vector(10 downto 0)
    );
end entity;

architecture selecionar of mux11x11z is

begin

    s <= b_NOP when sel_op = "10000000000" else
         b_STA when sel_op = "01000000000" else
         b_LDA when sel_op = "00100000000" else
         b_ADD when sel_op = "00010000000" else
         b_AND when sel_op = "00001000000" else
         b_OR when sel_op = "00000100000" else
         b_NOT when sel_op = "00000010000" else
         b_JMP when sel_op = "00000001000" else
         b_JN when sel_op = "00000000100" else
         b_JZ when sel_op = "00000000010" else
         b_HLT when sel_op = "00000000001" else
         (others => 'Z');

end architecture;