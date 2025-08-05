--------------------------- Detector NZ ---------------------------
library ieee;
use ieee.std_logic_1164.all;

entity dnz is
	port(        
		datain : in std_logic_vector(7 downto 0);
		nz : out std_logic_vector(1 downto 0)
	);
end entity;

architecture comportamento of dnz is 
begin

	nz(0) <= not(datain(7) or datain(6) or datain(5) or datain(4) or datain(3) or datain(2) or datain(1) or datain(0));
	nz(1) <= datain(7);
	
end architecture;

--------------------------- ALU(Modulo ula) ---------------------------
library ieee;
use ieee.std_logic_1164.all;

entity alu is
	port(        
		x      : in  std_logic_vector(7 downto 0);
		y      : in std_logic_vector(7 downto 0);
		alu_op : in std_logic_vector(2 downto 0);
		nz     : out std_logic_vector(1 downto 0);
		s      : out std_logic_vector(7 downto 0)
	);
end entity;

architecture alu of alu is
	component not8 is
		port(
			x    : in std_logic_vector(7 downto 0);
			snot : out std_logic_vector(7 downto 0)
		);
	end component;


	component and8 is
		port(
			x    : in std_logic_vector(7 downto 0);
			y    : in std_logic_vector(7 downto 0);
			sand : out std_logic_vector(7 downto 0)
		);
	end component;

	component or8 is
		port(
			x   : in std_logic_vector(7 downto 0);
			y   : in std_logic_vector(7 downto 0);
			sor : out std_logic_vector(7 downto 0)
		);
	end component;

    component add8 is
        port(
            x, y : in std_logic_vector(7 downto 0);
            cin  : in std_logic;
            cout : out std_logic;
            sadd : out std_logic_vector(7 downto 0)
        );
    end component;

	component lda8 is
		port(
			y     : in std_logic_vector(7 downto 0);
			slda  : out std_logic_vector(7 downto 0)
		);
	end component;

	component mux5x8 is
		port(
			c0    : in std_logic_vector(7 downto 0);
			c1    : in std_logic_vector(7 downto 0);
			c2    : in std_logic_vector(7 downto 0);
			c3    : in std_logic_vector(7 downto 0);
			c4    : in std_logic_vector(7 downto 0);
			sel   : in std_logic_vector(2 downto 0);    
			sMUX  : out std_logic_vector(7 downto 0)
		);
    end component;

    component dnz is
	    port(        
			datain : in std_logic_vector(7 downto 0);
			nz     : out std_logic_vector(1 downto 0)        
	    );
    end component;
	
	signal s_resultado : std_logic_vector(7 downto 0);
	signal s_not       : std_logic_vector(7 downto 0);
	signal s_and       : std_logic_vector(7 downto 0);
	signal s_or        : std_logic_vector(7 downto 0);
	signal s_add       : std_logic_vector(7 downto 0);
	signal s_lda       : std_logic_vector(7 downto 0);
	signal s_cout      : std_logic;
	signal s_nz        : std_logic_vector(1 downto 0);
	
begin

	u_not : not8 port map(x, s_not);
	u_and : and8 port map(x, y, s_and);
	u_or  : or8 port map(x, y, s_or);
	u_add : add8 port map(x, y, '0', s_cout, s_add);
	u_lda : lda8 port map(y, s_lda);
	u_mux : mux5x8 port map(s_lda, s_add, s_or, s_and, s_not, alu_op, s_resultado);
	u_det : dnz port map(s_resultado, nz);
	s <= s_resultado;

end architecture;