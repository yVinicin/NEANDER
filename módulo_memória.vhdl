--------------------------- neander asynchronous simple ram memory ---------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use STD.textio.all;

entity as_ram is
	port(
		addr  : in    std_logic_vector(7 downto 0);
		data  : inout std_logic_vector(7 downto 0);
		notrw : in    std_logic;
		reset : in    std_logic
	);
end entity as_ram;

architecture behavior of as_ram is
	type ram_type is array (0 to 255) of std_logic_vector(7 downto 0);
	signal ram : ram_type;
	signal data_out : std_logic_vector(7 downto 0);
begin
	
	rampW : process(notrw, reset, addr, data)
	type binary_file is file of character;
	file load_file : binary_file open read_mode is "neanderram.mem";
	variable char : character;
	begin
		if (reset = '0' and reset'event) then
			-- init ram
			read(load_file, char); -- 0x03 '.'
			read(load_file, char); -- 0x4E 'N'
			read(load_file, char); -- 0x44 'D'
			read(load_file, char); -- 0x52 'R'
			for i in 0 to 255 loop
				if not endfile(load_file) then
						read(load_file, char);
						ram(i) <= std_logic_vector(to_unsigned(character'pos(char),8));
						read(load_file, char);	-- 0x00 orindo de alinhamento 16bits	
				end if; -- if not endfile(load_file) then
			end loop; -- for i in 0 to 255
        else
		    if (reset = '1' and notrw = '1') then
			    -- Write
			    ram(to_integer(unsigned(addr))) <= data;
		    end if; -- reset == '1'
		end if; -- reset == '0'
	end process rampW;

	data <= data_out when (reset = '1' and notrw = '0')
		  else (others => 'Z');

	rampR : process(notrw, reset, addr, data)
	begin
		if (reset = '1' and notrw = '0') then
				-- Read
				data_out <= ram(to_integer(unsigned(addr)));
		end if; -- reset = '1' and notrw = '0'
	end process rampR;
end architecture behavior;

--------------------------- Módulo memória ---------------------------
library ieee;
use ieee.std_logic_1164.all;

entity modulo_memoria is
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
end entity;

architecture comportamento of modulo_memoria is
    
    component registradorREM is
        port(
            REM_end_in     : in std_logic_vector(7 downto 0);
            REM_clk        : in std_logic;
            REM_pr, REM_cl : in std_logic;
            REM_nrw        : in std_logic;
            REM_end_out    : out std_logic_vector(7 downto 0)
        );
    end component;

    component as_ram is
        port(
            addr  : in    std_logic_vector(7 downto 0);
            data  : inout std_logic_vector(7 downto 0);
            notrw : in    std_logic;
            reset : in    std_logic
        );
    end component;

    component registradorRDM is
        port(
            RDM_data_in    : in std_logic_vector(7 downto 0);
            RDM_clk        : in std_logic;
            RDM_pr, RDM_cl : in std_logic;
            RDM_nrw        : in std_logic;
            RDM_data_out   : out std_logic_vector(7 downto 0)
        );
    end component;

    signal s_mux2rem : std_logic_vector(7 downto 0) := (others => 'Z');
    signal s_rem2mem : std_logic_vector(7 downto 0) := (others => 'Z');
    signal s_mem2rdm : std_logic_vector(7 downto 0) := (others => 'Z');
    signal s_rdm2barramento : std_logic_vector(7 downto 0) := (others => 'Z');

begin

    -- Mux2x8
    s_mux2rem <= end_PC when barr_PC = '1' else end_Barr;

    -- Registrador REM
    u_regREM : registradorREM port map(s_mux2rem, MEM_clk, '1', MEM_rst, REM_rw, s_rem2mem);

    -- Memória
    u_MEM : as_ram port map(s_rem2mem, s_mem2rdm, MEM_rw, MEM_rst);

    -- Registrador RDM
    u_regRDM : registradorRDM port map(s_mem2rdm, MEM_clk, '1', MEM_rst, RDM_rw, s_rdm2barramento);

    -- Mux2x8z (Mux especial)
    MEM_barramento <= s_rdm2barramento when MEM_rw = '0' else (others => 'Z');
    s_mem2rdm <= MEM_barramento when MEM_rw = '1' else (others => 'Z');

end architecture;