--------------------------- JN ---------------------------
library ieee;
use ieee.std_logic_1164.all;

entity jn is
    port(
        ciclo : in std_logic_vector(2 downto 0);
       	sJN   : out std_logic_vector(10 downto 0)
    );
end entity;

architecture SeN of jn is 

begin

    sJN(10) <= '1';
    sJN(9) <= '1';
    sJN(8 downto 6) <= "000";
    sJN(5) <= not(ciclo(2)) and ciclo(0);
    sJN(4) <= '0';
    sJN(3) <= '0';
    sJN(2) <= not(ciclo(2)) and not(ciclo(1)) and not(ciclo(0));
    sJN(1) <= not(ciclo(2)) and not(ciclo(1)) and ciclo(0);
    sJN(0) <= not(ciclo(2)) and ciclo(1) and not(ciclo(0));

end architecture;

--------------------------- JZ ---------------------------
library ieee;
use ieee.std_logic_1164.all;

entity jz is
    port(
        ciclo : in std_logic_vector(2 downto 0);
        sJZ   : out std_logic_vector(10 downto 0)
    );
end entity;

architecture SeZ of jz is 

begin

    sJZ(10) <= '1';
    sJZ(9) <= '1';
    sJZ(8 downto 6) <= "000";
    sJZ(5) <= not(ciclo(2)) and ciclo(0);
    sJZ(4) <= '0';
    sJZ(3) <= '0';
    sJZ(2) <= not(ciclo(2)) and not(ciclo(1)) and not(ciclo(0));
    sJZ(1) <= not(ciclo(2)) and not(ciclo(1)) and ciclo(0);
    sJZ(0) <= not(ciclo(2)) and ciclo(1) and not(ciclo(0));

end architecture;

--------------------------- Instruções ---------------------------

--------------------------- instr_NOP ---------------------------
library ieee;
use ieee.std_logic_1164.all;

entity instr_NOP is
    port(
        ciclo : in std_logic_vector(2 downto 0);
        sNOP  : out std_logic_vector(10 downto 0)
    );
end entity;

architecture NOP of instr_NOP is 

begin

    sNOP(10) <= '1';
    sNOP(9) <= '1';
    sNOP(8 downto 6) <= "000";
    sNOP(5) <= not(ciclo(2)) and not(ciclo(1)) and ciclo(0);
    sNOP(4) <= '0';
    sNOP(3) <= '0';
    sNOP(2) <= not(ciclo(2)) and not(ciclo(1)) and not(ciclo(0));
    sNOP(1) <= not(ciclo(2)) and not(ciclo(1)) and ciclo(0);
    sNOP(0) <= not(ciclo(2)) and ciclo(1) and not(ciclo(0));

end architecture;

--------------------------- instr_STA ---------------------------
library ieee;
use ieee.std_logic_1164.all;

entity instr_STA is
    port(
        ciclo : in std_logic_vector(2 downto 0);
       	sSTA  : out std_logic_vector(10 downto 0)
    );
end entity;

architecture STA of instr_STA is 

begin
    
    sSTA(10) <= '1';
    sSTA(9) <= not(ciclo(2)) or ciclo(1) or not(ciclo(0));
    sSTA(8 downto 6) <= "000";
    sSTA(5) <= not(ciclo(1)) and (ciclo(2) xor ciclo(0));
    sSTA(4) <= '0';
    sSTA(3) <= ciclo(2) and ciclo(1) and not(ciclo(0));
    sSTA(2) <= (not(ciclo(1)) and (ciclo(2) xnor ciclo(0))) or (not(ciclo(2)) and ciclo(1) and ciclo(0));
    sSTA(1) <= not(ciclo(1)) and (ciclo(2) xor ciclo(0));
    sSTA(0) <= not(ciclo(2)) and ciclo(1) and not(ciclo(0));    	

end architecture;

--------------------------- instr_LDA ---------------------------
library ieee;
use ieee.std_logic_1164.all;

entity instr_LDA is
    port(
        ciclo : in std_logic_vector(2 downto 0);
       	sLDA  : out std_logic_vector(10 downto 0)
    );
end entity;

architecture LDA of instr_LDA is 

begin

    sLDA(10) <= '1';
    sLDA(9) <= not(ciclo(2)) or ciclo(1) or not(ciclo(0));
    sLDA(8 downto 6) <= "000";
    sLDA(5) <= not(ciclo(1)) and (ciclo(2) xor ciclo(0));
    sLDA(4) <= ciclo(2) and ciclo(1) and ciclo(0);
    sLDA(3) <= '0';
    sLDA(2) <= (not(ciclo(1)) and (ciclo(2) xnor ciclo(0))) or (not(ciclo(2)) and ciclo(1) and ciclo(0));
    sLDA(1) <= (ciclo(2) and not(ciclo(0))) or (not(ciclo(2)) and not(ciclo(1)) and ciclo(0));
    sLDA(0) <= not(ciclo(2)) and ciclo(1) and not(ciclo(0)); 	

end architecture;

--------------------------- instr_ADD ---------------------------
library ieee;
use ieee.std_logic_1164.all;

entity instr_ADD is
    port(
        ciclo : in std_logic_vector(2 downto 0);
       	sADD  : out std_logic_vector(10 downto 0)
    );
end entity;

architecture ADD of instr_ADD is 

begin

    sADD(10) <= '1';
    sADD(9) <= not(ciclo(2)) or ciclo(1) or not(ciclo(0));
    sADD(8 downto 6) <= "001";
    sADD(5) <= not(ciclo(1)) and (ciclo(2) xor ciclo(0));
    sADD(4) <= ciclo(2) and ciclo(1) and ciclo(0);
    sADD(3) <= '0';
    sADD(2) <= (not(ciclo(1)) and (ciclo(2) xnor ciclo(0))) or (not(ciclo(2)) and ciclo(1) and ciclo(0));
    sADD(1) <= (ciclo(2) and not(ciclo(0))) or (not(ciclo(2)) and not(ciclo(1)) and ciclo(0));
    sADD(0) <= not(ciclo(2)) and ciclo(1) and not(ciclo(0)); 	

end architecture;

--------------------------- instr_AND ---------------------------
library ieee;
use ieee.std_logic_1164.all;

entity instr_AND is
    port(
        ciclo : in std_logic_vector(2 downto 0);
       	sAND  : out std_logic_vector(10 downto 0)
    );
end entity;

architecture AND_E of instr_AND is 

begin

    sAND(10) <= '1';
    sAND(9) <= not(ciclo(2)) or ciclo(1) or not(ciclo(0));
    sAND(8 downto 6) <= "011";
    sAND(5) <= not(ciclo(1)) and (ciclo(2) xor ciclo(0));
    sAND(4) <= ciclo(2) and ciclo(1) and ciclo(0);
    sAND(3) <= '0';
    sAND(2) <= (not(ciclo(1)) and (ciclo(2) xnor ciclo(0))) or (not(ciclo(2)) and ciclo(1) and ciclo(0));
    sAND(1) <= (ciclo(2) and not(ciclo(0))) or (not(ciclo(2)) and not(ciclo(1)) and ciclo(0));
    sAND(0) <= not(ciclo(2)) and ciclo(1) and not(ciclo(0));	

end architecture;

--------------------------- instr_OR ---------------------------
library ieee;
use ieee.std_logic_1164.all;

entity instr_OR is
    port(
        ciclo : in std_logic_vector(2 downto 0);
       	sOR   : out std_logic_vector(10 downto 0)
    );
end entity;

architecture OR_OU of instr_OR is 

begin

    sOR(10) <= '1';
    sOR(9) <= not(ciclo(2)) or ciclo(1) or not(ciclo(0));
    sOR(8 downto 6) <= "010";
    sOR(5) <= not(ciclo(1)) and (ciclo(2) xor ciclo(0));
    sOR(4) <= ciclo(2) and ciclo(1) and ciclo(0);
    sOR(3) <= '0';
    sOR(2) <= (not(ciclo(1)) and (ciclo(2) xnor ciclo(0))) or (not(ciclo(2)) and ciclo(1) and ciclo(0));
    sOR(1) <= (ciclo(2) and not(ciclo(0))) or (not(ciclo(2)) and not(ciclo(1)) and ciclo(0));
    sOR(0) <= not(ciclo(2)) and ciclo(1) and not(ciclo(0));	

end architecture;

--------------------------- instr_NOT ---------------------------
library ieee;
use ieee.std_logic_1164.all;

entity instr_NOT is
    port(
        ciclo : in std_logic_vector(2 downto 0);
       	sNOT  : out std_logic_vector(10 downto 0)
    );
end entity;

architecture NOT_N of instr_NOT is 

begin

    sNOT(10) <= '1';
    sNOT(9) <= '1';
    sNOT(8 downto 6) <= "100";
    sNOT(5) <= not(ciclo(2)) and not(ciclo(1)) and ciclo(0);
    sNOT(4) <= ciclo(2) and ciclo(1) and ciclo(0);
    sNOT(3) <= '0';
    sNOT(2) <= not(ciclo(2)) and not(ciclo(1)) and not(ciclo(0));
    sNOT(1) <= not(ciclo(2)) and not(ciclo(1)) and ciclo(0);
    sNOT(0) <= not(ciclo(2)) and ciclo(1) and not(ciclo(0)); 	

end architecture;

--------------------------- instr_JMP ---------------------------
library ieee;
use ieee.std_logic_1164.all;

entity instr_JMP is
    port(
        ciclo : in std_logic_vector(2 downto 0);
       	sJMP  : out std_logic_vector(10 downto 0)
    );
end entity;

architecture JMP of instr_JMP is 

begin

    sJMP(10) <= not(ciclo(2)) or ciclo(1) or not(ciclo(0));
    sJMP(9) <= '1';
    sJMP(8 downto 6) <= "000";
    sJMP(5) <= not(ciclo(1)) and ciclo(0);
    sJMP(4) <= '0';
    sJMP(3) <= '0';
    sJMP(2) <= not(ciclo(2)) and (ciclo(1) xnor ciclo(0));
    sJMP(1) <= not(ciclo(1)) and (ciclo(2) xor ciclo(0));
    sJMP(0) <= not(ciclo(2)) and ciclo(1) and not(ciclo(0));  	

end architecture;

--------------------------- instr_JN ---------------------------
library ieee;
use ieee.std_logic_1164.all;

entity instr_JN is
	port(        
        ciclo : in  std_logic_vector(2 downto 0);               
        n     : in std_logic;
        sJN   : out std_logic_vector(10 downto 0)
    );
end entity;

architecture Se_N of instr_JN is
	component jn is
	    port(
		    ciclo : in std_logic_vector(2 downto 0);
	       	sJN   : out std_logic_vector(10 downto 0)
	    );
	end component;
	
	component instr_JMP is
	    port(
		    ciclo : in std_logic_vector(2 downto 0);
	       	sJMP  : out std_logic_vector(10 downto 0)
	    );
	end component;
	
	component mux2x11jn is
	    port(
	    	c0  : in std_logic_vector(10 downto 0);
	    	c1  : in std_logic_vector(10 downto 0);
            sel : in std_logic;
            s   : out std_logic_vector(10 downto 0)
	    );
	end component;
	
signal jn2mux : std_logic_vector(10 downto 0);
signal jmp2mux : std_logic_vector(10 downto 0);

begin

	u_jn : jn port map(ciclo, jn2mux);
	u_jmp : instr_JMP port map(ciclo, jmp2mux);
	u_mux2x11 : mux2x11jn port map(jn2mux, jmp2mux, n, sJN);

end architecture;

--------------------------- instr_JZ ---------------------------
library ieee;
use ieee.std_logic_1164.all;

entity instr_JZ is
	port(        
        ciclo : in  std_logic_vector(2 downto 0);               
        z     : in std_logic;
        sJZ   : out std_logic_vector(10 downto 0)
	);
end entity;

architecture Se_Z of instr_JZ is
	component jz is
	    port(
		    ciclo : in std_logic_vector(2 downto 0);
	       	sJZ   : out std_logic_vector(10 downto 0)
	    );
	end component;
	
	component instr_JMP is
	    port(
		    ciclo : in std_logic_vector(2 downto 0);
	       	sJMP  : out std_logic_vector(10 downto 0)
	    );
	end component;
	
	component mux2x11jz is
	    port(
	    	c0  : in std_logic_vector(10 downto 0);
	    	c1  : in std_logic_vector(10 downto 0);
            sel : in std_logic;
            s   : out std_logic_vector(10 downto 0)
	    );
	end component;
	
signal jz2mux : std_logic_vector(10 downto 0);
signal jmp2mux : std_logic_vector(10 downto 0);

begin

	u_jz : jz port map(ciclo, jz2mux);
	u_jmp : instr_JMP port map(ciclo, jmp2mux);
	u_mux2x11 : mux2x11jz port map(jz2mux, jmp2mux, z, sJZ);

end architecture;

--------------------------- instr_HLT ---------------------------
library ieee;
use ieee.std_logic_1164.all;

entity instr_HLT is
    port(
        ciclo : in std_logic_vector(2 downto 0);
       	sHLT  : out std_logic_vector(10 downto 0)
    );
end entity;

architecture HLT of instr_HLT is 

begin

    sHLT(10) <= '0';
    sHLT(9) <= '0';
    sHLT(8 downto 6) <= "000";
    sHLT(5) <= '0';
    sHLT(4) <= '0';
    sHLT(3) <= '0';
    sHLT(2) <= '0';
    sHLT(1) <= '0';
    sHLT(0) <= '0';

end architecture;