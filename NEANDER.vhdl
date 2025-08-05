library ieee;
use ieee.std_logic_1164.all;

entity NEANDER is
    port(
        reset : in std_logic;
        clock : in std_logic
    );
end entity;

architecture maquina of NEANDER is
    component modulo_memoria is
        port(
            MEM_rst, MEM_clk : in std_logic;
            barr_PC          : in std_logic;
            REM_rw           : in std_logic;
            MEM_rw           : in std_logic;
            RDM_rw           : in std_logic;
            end_PC           : in std_logic_vector(7 downto 0);
            end_Barr         : in std_logic_vector(7 downto 0);
            MEM_barramento   : inout std_logic_vector(7 downto 0)
        );
    end component;

    component ULA is
        port(
            rst, clk    : in    std_logic;
            AC_nrw      : in    std_logic;
            ula_op      : in    std_logic_vector(2 downto 0);
            MEM_nrw     : in    std_logic;
            flags_nz    : out   std_logic_vector(1 downto 0);
            barramento  : inout std_logic_vector(7 downto 0)
        );
    end component;

    component controle_PC is
        port(
            PC_cl, PC_clk   : in std_logic;
            PC_barr_inc     : in std_logic;
            PC_rw           : in std_logic;
            PC_barramento   : in std_logic_vector(7 downto 0);
            PC_s            : out std_logic_vector(7 downto 0)
        );
    end component;

    component modulo_controle is
        port(
            cl, clk   : in std_logic;
            barr_inc  : in std_logic_vector(7 downto 0);
            r_w       : in std_logic;
            nz        : in std_logic_vector(1 downto 0);
            CTRL_barr : out std_logic_vector(10 downto 0)
        );
    end component;

    signal barramento_CTRL : std_logic_vector(10 downto 0) := (others => '0');
    signal barramento_DATA_INSTR : std_logic_vector(7 downto 0) := (others => '0');
    signal flags2uc : std_logic_vector(1 downto 0);
    signal pc2mem : std_logic_vector(7 downto 0);
    signal in_ULA_op : std_logic_vector(2 downto 0);

begin

    -- Memória
    u_MEM : modulo_memoria port map(reset, clock, barramento_CTRL(9), barramento_CTRL(2), barramento_CTRL(3), barramento_CTRL(1), pc2mem, barramento_DATA_INSTR, barramento_DATA_INSTR);

    -- ULA
    in_ULA_op(0) <= barramento_CTRL(6);
    in_ULA_op(1) <= barramento_CTRL(7);
    in_ULA_op(2) <= barramento_CTRL(8);
    u_ULA : ULA port map(reset, clock, barramento_CTRL(4), in_ULA_op, barramento_CTRL(3), flags2uc, barramento_DATA_INSTR);

    -- Controle
    u_moduloPC : controle_PC port map(reset, clock, barramento_CTRL(10), barramento_CTRL(5), barramento_DATA_INSTR, pc2mem);
    u_moduloCTRL : modulo_controle port map(reset, clock, barramento_DATA_INSTR, barramento_CTRL(0), flags2uc, barramento_CTRL);

end architecture;