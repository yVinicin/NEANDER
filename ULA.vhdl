--------------------------- ULA ---------------------------
library ieee;
use ieee.std_logic_1164.all;

entity ULA is
	port(
        rst, clk    : in    std_logic;
        AC_nrw      : in    std_logic;
        ula_op      : in    std_logic_vector(2 downto 0);
        MEM_nrw     : in    std_logic;
        flags_nz    : out   std_logic_vector(1 downto 0);
        barramento  : inout std_logic_vector(7 downto 0)
	);
end entity;

architecture comportamento of ULA is
	
    component registradorAC is
        port(
            AC_data_in   : in std_logic_vector(7 downto 0);
            AC_clk       : in std_logic;
            AC_pr, AC_cl : in std_logic;
            AC_nrw       : in std_logic;
            AC_data_out  : out std_logic_vector(7 downto 0)
        );
    end component;

    component alu is
	    port(        
            x      : in  std_logic_vector(7 downto 0);            
            y      : in std_logic_vector(7 downto 0);
            alu_op : in std_logic_vector(2 downto 0);
            nz     : out std_logic_vector(1 downto 0);
            s      : out std_logic_vector(7 downto 0)
	    );
    end component;

    component flags is
        port(
            flags_data_in      : in std_logic_vector(1 downto 0);
            flags_clk          : in std_logic;
            flags_pr, flags_cl : in std_logic;
            flags_nrw          : in std_logic;
            flags_data_out     : out std_logic_vector(1 downto 0)
        );
    end component;
	
	signal s_ac2ula   : std_logic_vector(7 downto 0);
	signal s_ula2ac   : std_logic_vector(7 downto 0);
	signal s_ac2flags : std_logic_vector(1 downto 0);

begin

    -- registrador AC
    u_regAC : registradorAC port map(s_ula2ac, clk, '1', rst, AC_nrw, s_ac2ula);

    -- ALU(Modulo ULA)
    u_alu : alu port map(s_ac2ula, barramento, ula_op, s_ac2flags, s_ula2ac);

    -- registrador FLAGS
    u_regFLAGS : flags port map(s_ac2flags, clk, '1', rst, AC_nrw, flags_nz);

    barramento <= s_ac2ula when MEM_nrw = '1' else (others => 'Z');

end architecture;