--------------------------- Registrador de 1 bit ---------------------------
library ieee;
use ieee.std_logic_1164.all;

entity registrador_1bit is
    port(
        d      : in std_logic;
        clk    : in std_logic;
        pr, cl : in std_logic;
        nrw    : in std_logic;
        s      : out std_logic
    );
end entity;

architecture reg1bit of registrador_1bit is
    component ffd is
        port(
            d      : in std_logic;
            clk    : in std_logic;
            pr, cl : in std_logic;
            q, nq  : out std_logic
        );
    end component;

    signal datain, dataout : std_logic;

begin

    s <= dataout;

    datain <= d when nrw = '1' else dataout;

    u_reg1BIT : ffd port map(datain, clk, pr, cl, dataout);

end architecture;

--------------------------- Registrador AC ---------------------------
library ieee;
use ieee.std_logic_1164.all;

entity registradorAC is
    port(
        AC_data_in   : in std_logic_vector(7 downto 0);
        AC_clk       : in std_logic;
        AC_pr, AC_cl : in std_logic;
        AC_nrw       : in std_logic;
        AC_data_out  : out std_logic_vector(7 downto 0)
    );
end entity;

architecture regAC of registradorAC is
    component registrador_1bit is
        port(
            d      : in std_logic;
            clk    : in std_logic;
            pr, cl : in std_logic;
            nrw    : in std_logic;
            s      : out std_logic
        );
    end component;

begin

    u_regAC0 : registrador_1bit port map(AC_data_in(0), AC_clk, AC_pr, AC_cl, AC_nrw, AC_data_out(0));
    u_regAC1 : registrador_1bit port map(AC_data_in(1), AC_clk, AC_pr, AC_cl, AC_nrw, AC_data_out(1));
    u_regAC2 : registrador_1bit port map(AC_data_in(2), AC_clk, AC_pr, AC_cl, AC_nrw, AC_data_out(2));
    u_regAC3 : registrador_1bit port map(AC_data_in(3), AC_clk, AC_pr, AC_cl, AC_nrw, AC_data_out(3));
    u_regAC4 : registrador_1bit port map(AC_data_in(4), AC_clk, AC_pr, AC_cl, AC_nrw, AC_data_out(4));
    u_regAC5 : registrador_1bit port map(AC_data_in(5), AC_clk, AC_pr, AC_cl, AC_nrw, AC_data_out(5));
    u_regAC6 : registrador_1bit port map(AC_data_in(6), AC_clk, AC_pr, AC_cl, AC_nrw, AC_data_out(6));
    u_regAC7 : registrador_1bit port map(AC_data_in(7), AC_clk, AC_pr, AC_cl, AC_nrw, AC_data_out(7));

end architecture;

--------------------------- Registrador Flags ---------------------------
library ieee;
use ieee.std_logic_1164.all;

entity flags is
    port(
        flags_data_in      : in std_logic_vector(1 downto 0);
        flags_clk          : in std_logic;
        flags_pr, flags_cl : in std_logic;
        flags_nrw          : in std_logic;
        flags_data_out     : out std_logic_vector(1 downto 0)
    );
end entity;

architecture regFLAGS of flags is
    component registrador_1bit is
        port(
            d      : in std_logic;
            clk    : in std_logic;
            pr, cl : in std_logic;
            nrw    : in std_logic;
            s      : out std_logic
        );
    end component;

begin

    u_regFLAGS0 : registrador_1bit port map(flags_data_in(0), flags_clk, flags_cl, flags_pr, flags_nrw, flags_data_out(0));
    u_regFLAGS1 : registrador_1bit port map(flags_data_in(1), flags_clk, flags_pr, flags_cl, flags_nrw, flags_data_out(1));
    
end architecture;

--------------------------- Registrador REM ---------------------------
library ieee;
use ieee.std_logic_1164.all;

entity registradorREM is
    port(
        REM_end_in     : in std_logic_vector(7 downto 0);
        REM_clk        : in std_logic;
        REM_pr, REM_cl : in std_logic;
        REM_nrw        : in std_logic;
        REM_end_out    : out std_logic_vector(7 downto 0)
    );
end entity;

architecture regREM of registradorREM is
    component registrador_1bit is
        port(
            d      : in std_logic;
            clk    : in std_logic;
            pr, cl : in std_logic;
            nrw    : in std_logic;
            s      : out std_logic
        );
    end component;

begin

    u_regREM0 : registrador_1bit port map(REM_end_in(0), REM_clk, REM_pr, REM_cl, REM_nrw, REM_end_out(0));
    u_regREM1 : registrador_1bit port map(REM_end_in(1), REM_clk, REM_pr, REM_cl, REM_nrw, REM_end_out(1));
    u_regREM2 : registrador_1bit port map(REM_end_in(2), REM_clk, REM_pr, REM_cl, REM_nrw, REM_end_out(2));
    u_regREM3 : registrador_1bit port map(REM_end_in(3), REM_clk, REM_pr, REM_cl, REM_nrw, REM_end_out(3));
    u_regREM4 : registrador_1bit port map(REM_end_in(4), REM_clk, REM_pr, REM_cl, REM_nrw, REM_end_out(4));
    u_regREM5 : registrador_1bit port map(REM_end_in(5), REM_clk, REM_pr, REM_cl, REM_nrw, REM_end_out(5));
    u_regREM6 : registrador_1bit port map(REM_end_in(6), REM_clk, REM_pr, REM_cl, REM_nrw, REM_end_out(6));
    u_regREM7 : registrador_1bit port map(REM_end_in(7), REM_clk, REM_pr, REM_cl, REM_nrw, REM_end_out(7));

end architecture;

--------------------------- Registrador RDM ---------------------------
library ieee;
use ieee.std_logic_1164.all;

entity registradorRDM is
    port(
        RDM_data_in    : in std_logic_vector(7 downto 0);
        RDM_clk        : in std_logic;
        RDM_pr, RDM_cl : in std_logic;
        RDM_nrw        : in std_logic;
        RDM_data_out   : out std_logic_vector(7 downto 0)
    );
end entity;

architecture regRDM of registradorRDM is
    component registrador_1bit is
        port(
            d      : in std_logic;
            clk    : in std_logic;
            pr, cl : in std_logic;
            nrw    : in std_logic;
            s      : out std_logic
        );
    end component;

begin

    u_regRDM0 : registrador_1bit port map(RDM_data_in(0), RDM_clk, RDM_pr, RDM_cl, RDM_nrw, RDM_data_out(0));
    u_regRDM1 : registrador_1bit port map(RDM_data_in(1), RDM_clk, RDM_pr, RDM_cl, RDM_nrw, RDM_data_out(1));
    u_regRDM2 : registrador_1bit port map(RDM_data_in(2), RDM_clk, RDM_pr, RDM_cl, RDM_nrw, RDM_data_out(2));
    u_regRDM3 : registrador_1bit port map(RDM_data_in(3), RDM_clk, RDM_pr, RDM_cl, RDM_nrw, RDM_data_out(3));
    u_regRDM4 : registrador_1bit port map(RDM_data_in(4), RDM_clk, RDM_pr, RDM_cl, RDM_nrw, RDM_data_out(4));
    u_regRDM5 : registrador_1bit port map(RDM_data_in(5), RDM_clk, RDM_pr, RDM_cl, RDM_nrw, RDM_data_out(5));
    u_regRDM6 : registrador_1bit port map(RDM_data_in(6), RDM_clk, RDM_pr, RDM_cl, RDM_nrw, RDM_data_out(6));
    u_regRDM7 : registrador_1bit port map(RDM_data_in(7), RDM_clk, RDM_pr, RDM_cl, RDM_nrw, RDM_data_out(7));
    
end architecture;

--------------------------- Registrador PC ---------------------------
library ieee;
use ieee.std_logic_1164.all;

entity registradorPC is
    port(
        end_in     : in std_logic_vector(7 downto 0);
        clk        : in std_logic;
        pr, cl     : in std_logic;
        nrw        : in std_logic;
        end_out    : out std_logic_vector(7 downto 0)
    );
end entity;

architecture regPC of registradorPC is
    component registrador_1bit is
        port(
            d      : in std_logic;
            clk    : in std_logic;
            pr, cl : in std_logic;
            nrw    : in std_logic;
            s      : out std_logic
        );
    end component;

begin

    u_regPC0 : registrador_1bit port map(end_in(0), clk, pr, cl, nrw, end_out(0));
    u_regPC1 : registrador_1bit port map(end_in(1), clk, pr, cl, nrw, end_out(1));
    u_regPC2 : registrador_1bit port map(end_in(2), clk, pr, cl, nrw, end_out(2));
    u_regPC3 : registrador_1bit port map(end_in(3), clk, pr, cl, nrw, end_out(3));
    u_regPC4 : registrador_1bit port map(end_in(4), clk, pr, cl, nrw, end_out(4));
    u_regPC5 : registrador_1bit port map(end_in(5), clk, pr, cl, nrw, end_out(5));
    u_regPC6 : registrador_1bit port map(end_in(6), clk, pr, cl, nrw, end_out(6));
    u_regPC7 : registrador_1bit port map(end_in(7), clk, pr, cl, nrw, end_out(7));

end architecture;

--------------------------- Registrador RI ---------------------------
library ieee;
use ieee.std_logic_1164.all;

entity registradorRI is
    port(
        instr_in     : in std_logic_vector(7 downto 0);
        clk          : in std_logic;
        pr, cl       : in std_logic;
        nrw          : in std_logic;
        instr_out    : out std_logic_vector(7 downto 0)
    );
end entity;

architecture regRI of registradorRI is
    component registrador_1bit is
        port(
            d      : in std_logic;
            clk    : in std_logic;
            pr, cl : in std_logic;
            nrw    : in std_logic;
            s      : out std_logic
        );
    end component;

begin

    u_regRI0 : registrador_1bit port map(instr_in(0), clk, pr, cl, nrw, instr_out(0));
    u_regRI1 : registrador_1bit port map(instr_in(1), clk, pr, cl, nrw, instr_out(1));
    u_regRI2 : registrador_1bit port map(instr_in(2), clk, pr, cl, nrw, instr_out(2));
    u_regRI3 : registrador_1bit port map(instr_in(3), clk, pr, cl, nrw, instr_out(3));
    u_regRI4 : registrador_1bit port map(instr_in(4), clk, pr, cl, nrw, instr_out(4));
    u_regRI5 : registrador_1bit port map(instr_in(5), clk, pr, cl, nrw, instr_out(5));
    u_regRI6 : registrador_1bit port map(instr_in(6), clk, pr, cl, nrw, instr_out(6));
    u_regRI7 : registrador_1bit port map(instr_in(7), clk, pr, cl, nrw, instr_out(7));

end architecture;