--------------------------- Decodificador(UC) ---------------------------
library ieee;
use ieee.std_logic_1164.all;

entity decodificador is
    port(
        DEC_instr_in  : in std_logic_vector(7 downto 0);
        DEC_instr_out : out std_logic_vector(10 downto 0)
    );
end entity;

architecture decode of decodificador is

begin

    DEC_instr_out(10) <= '1' when DEC_instr_in = "00000000" else '0';
    DEC_instr_out(9) <= '1' when DEC_instr_in = "00010000" else '0';
    DEC_instr_out(8) <= '1' when DEC_instr_in = "00100000" else '0';
    DEC_instr_out(7) <= '1' when DEC_instr_in = "00110000" else '0';
    DEC_instr_out(6) <= '1' when DEC_instr_in = "01000000" else '0';
    DEC_instr_out(5) <= '1' when DEC_instr_in = "01010000" else '0';
    DEC_instr_out(4) <= '1' when DEC_instr_in = "01100000" else '0';
    DEC_instr_out(3) <= '1' when DEC_instr_in = "10000000" else '0';
    DEC_instr_out(2) <= '1' when DEC_instr_in = "10010000" else '0';
    DEC_instr_out(1) <= '1' when DEC_instr_in = "10100000" else '0';
    DEC_instr_out(0) <= '1' when DEC_instr_in = "11110000" else '0';

end architecture;

--------------------------- Módulo de Controle ---------------------------
library ieee;
use ieee.std_logic_1164.all;

entity modulo_controle is
    port(
        cl, clk   : in std_logic;
        barr_inc  : in std_logic_vector(7 downto 0);
        r_w       : in std_logic;
        nz        : in std_logic_vector(1 downto 0);
        CTRL_barr : out std_logic_vector(10 downto 0)
    );
end entity;

architecture controlar of modulo_controle is
    component registradorRI is
        port(
            instr_in     : in std_logic_vector(7 downto 0);
            clk          : in std_logic;
            pr, cl       : in std_logic;
            nrw          : in std_logic;
            instr_out    : out std_logic_vector(7 downto 0)
        );
    end component;

    component decodificador is
        port(
            DEC_instr_in  : in std_logic_vector(7 downto 0);
            DEC_instr_out : out std_logic_vector(10 downto 0)
        );
    end component;

    component unidade_controle is
        port(
            UC_rst, UC_clk  : in std_logic;
            dec2uc          : in std_logic_vector(10 downto 0);
            nz_in           : in std_logic_vector(1 downto 0);
            barr_CTRL       : out std_logic_vector(10 downto 0)
        );
    end component;

    signal ri2dec : std_logic_vector(7 downto 0);
    signal decode2uc : std_logic_vector(10 downto 0);

begin

    -- Registrador RI
    u_RI : registradorRI port map(barr_inc, clk, '1', cl, r_w, ri2dec);

    -- Decodificador
    u_DEC : decodificador port map(ri2dec, decode2uc);

    -- Unidade de controle
    u_UC : unidade_controle port map(cl, clk, decode2uc, nz, CTRL_barr);

end architecture;