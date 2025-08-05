--------------------------- Controle(contador) ---------------------------
library ieee;
use ieee.std_logic_1164.all;

entity CTRL_contador is
    port(
        Qa   : in std_logic_vector(2 downto 0);
        j, k : out std_logic_vector(2 downto 0)
    );
end entity;

architecture controlar of CTRL_contador is

begin

    j(0) <= '1';
    k(0) <= '1';

    j(1) <= Qa(0);
    k(1) <= Qa(0);

    j(2) <= Qa(1) and Qa(0);
    k(2) <= Qa(1) and Qa(0);

end architecture;



--------------------------- Contador(UC) ---------------------------
library ieee;
use ieee.std_logic_1164.all;

entity contador is
    port(
        CNT_pr, CNT_cl : in std_logic;
        CNT_clk        : in std_logic;
        CNT_s          : out std_logic_vector(2 downto 0)
    );
end entity;

architecture contar of contador is
    component ffjk is
        port(
            j, k   : in std_logic;
            clk    : in std_logic;
            pr, cl : in std_logic;
            q, nq  : out std_logic
        );
    end component;

    component CTRL_contador is
        port(
            Qa   : in std_logic_vector(2 downto 0);
            j, k : out std_logic_vector(2 downto 0)
        );
    end component;

    signal sJ, sK, sFF : std_logic_vector(2 downto 0);

begin

     CNT_s(0) <= sFF(0);
     CNT_s(1) <= sFF(1);
     CNT_s(2) <= sFF(2);

     u_ffJK0 : ffjk port map(sJ(0), sK(0), CNT_clk, CNT_pr, CNT_cl, sFF(0));
     u_ffJK1 : ffjk port map(sJ(1), sK(1), CNT_clk, CNT_pr, CNT_cl, sFF(1));
     u_ffJK2 : ffjk port map(sJ(2), sK(2), CNT_clk, CNT_pr, CNT_cl, sFF(2));

     u_ctrl : CTRL_contador port map(sFF, sJ, sK);

end architecture;

--------------------------- UC(Unidade de Controle) ---------------------------
library ieee;
use ieee.std_logic_1164.all;

entity unidade_controle is
    port(
        UC_rst, UC_clk  : in std_logic;
        dec2uc          : in std_logic_vector(10 downto 0);
        nz_in           : in std_logic_vector(1 downto 0);
        barr_CTRL       : out std_logic_vector(10 downto 0)
    );
end entity;

architecture control_unit of unidade_controle is
    component contador is
        port(
            CNT_pr, CNT_cl : in std_logic;
            CNT_clk        : in std_logic;
            CNT_s          : out std_logic_vector(2 downto 0)
        );
    end component;

    component instr_NOP is
        port(
            ciclo : in std_logic_vector(2 downto 0);
            snop  : out std_logic_vector(10 downto 0)
        );
    end component;

    component instr_STA is
        port(
            ciclo : in std_logic_vector(2 downto 0);
            ssta  : out std_logic_vector(10 downto 0)
        );
    end component;

    component instr_LDA is
        port(
            ciclo : in std_logic_vector(2 downto 0);
            slda  : out std_logic_vector(10 downto 0)
        );
    end component;

    component instr_ADD is
        port(
            ciclo : in std_logic_vector(2 downto 0);
            sadd  : out std_logic_vector(10 downto 0)
        );
    end component;

    component instr_AND is
        port(
            ciclo : in std_logic_vector(2 downto 0);
            sand  : out std_logic_vector(10 downto 0)
        );
    end component;

    component instr_OR is
        port(
            ciclo : in std_logic_vector(2 downto 0);
            sor   : out std_logic_vector(10 downto 0)
        );
    end component;

    component instr_NOT is
        port(
            ciclo : in std_logic_vector(2 downto 0);
            snot  : out std_logic_vector(10 downto 0)
        );
    end component;

    component instr_JMP is
        port(
            ciclo : in std_logic_vector(2 downto 0);
            sjmp  : out std_logic_vector(10 downto 0)
        );
    end component;

    component instr_JN is
        port(        
            ciclo : in  std_logic_vector(2 downto 0);               
            n     : in std_logic;
            sjn   : out std_logic_vector(10 downto 0)
        );
    end component;

    component instr_JZ is
        port(        
            ciclo : in  std_logic_vector(2 downto 0);               
            z     : in std_logic;
            sjz   : out std_logic_vector(10 downto 0)
        );
    end component;

    component instr_HLT is
        port(
            ciclo : in std_logic_vector(2 downto 0);
            shlt  : out std_logic_vector(10 downto 0)
        );
    end component;

    component mux11x11z is
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
    end component;

    signal s_Counter : std_logic_vector(2 downto 0);
    signal s_NOP : std_logic_vector(10 downto 0);
    signal s_STA : std_logic_vector(10 downto 0);
    signal s_LDA : std_logic_vector(10 downto 0);
    signal s_ADD : std_logic_vector(10 downto 0);
    signal s_AND : std_logic_vector(10 downto 0);
    signal s_OR  : std_logic_vector(10 downto 0);
    signal s_NOT : std_logic_vector(10 downto 0);
    signal s_JMP : std_logic_vector(10 downto 0);
    signal s_JN  : std_logic_vector(10 downto 0);
    signal s_JZ  : std_logic_vector(10 downto 0);
    signal s_HLT : std_logic_vector(10 downto 0);

begin

    -- Contador
    u_Counter : contador port map('1', UC_rst, UC_clk, s_Counter);

    -- Operações
    u_NOP : instr_NOP port map(s_Counter, s_NOP);
    u_STA : instr_STA port map(s_Counter, s_STA);
    u_LDA : instr_LDA port map(s_Counter, s_LDA);
    u_ADD : instr_ADD port map(s_Counter, s_ADD);
    u_AND : instr_AND port map(s_Counter, s_AND);
    u_OR : instr_OR port map(s_Counter, s_OR);
    u_NOT : instr_NOT port map(s_Counter, s_NOT);
    u_JMP : instr_JMP port map(s_Counter, s_JMP);
    u_JN : instr_JN port map(s_Counter, nz_in(1), s_JN);
    u_JZ : instr_JZ port map(s_Counter, nz_in(0), s_JZ);
    u_HLT : instr_HLT port map(s_Counter, s_HLT);

    -- Mux especial
    u_MUX11x11z : mux11x11z port map(s_NOP, s_STA, s_LDA, s_ADD, s_AND, s_OR, s_NOT, s_JMP, s_JN, s_JZ, s_HLT, dec2uc, barr_CTRL);

end architecture;