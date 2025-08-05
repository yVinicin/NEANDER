--------------------------- LDA ---------------------------
library ieee;
use ieee.std_logic_1164.all;

entity lda8 is
	port(
	    y     : in std_logic_vector(7 downto 0);
	    slda  : out std_logic_vector(7 downto 0)
	);
end entity;

architecture comportamento of lda8 is
begin

	slda <= y;
	
end architecture;

--------------------------- ADD ---------------------------
library ieee;
use ieee.std_logic_1164.all;

entity add8 is
    port(
        x, y : in std_logic_vector(7 downto 0);
        cin  : in std_logic;
        cout : out std_logic;
        sadd : out std_logic_vector(7 downto 0)
    );
end entity;

architecture comutar of add8 is 

signal carry : std_logic_vector(7 downto 0);

begin

    sadd(0) <= (x(0) xor y(0)) xor cin;
    carry(0) <= (x(0) and y(0)) or (x(0) and cin) or (y(0) and cin);
    
    sadd(1) <= (x(1) xor y(1)) xor carry(0);
    carry(1) <= (x(1) and y(1)) or (x(1) and carry(0)) or (y(1) and carry(0));
    
    sadd(2) <= (x(2) xor y(2)) xor carry(1);
    carry(2) <= (x(2) and y(2)) or (x(2) and carry(1)) or (y(2) and carry(1));
    
    sadd(3) <= (x(3) xor y(3)) xor carry(2);
    carry(3) <= (x(3) and y(3)) or (x(3) and carry(2)) or (y(3) and carry(2));
    
    sadd(4) <= (x(4) xor y(4)) xor carry(3);
    carry(4) <= (x(4) and y(4)) or (x(4) and carry(3)) or (y(4) and carry(3));
    
    sadd(5) <= (x(5) xor y(5)) xor carry(4);
    carry(5) <= (x(5) and y(5)) or (x(5) and carry(4)) or (y(5) and carry(4));
    
    sadd(6) <= (x(6) xor y(6)) xor carry(5);
    carry(6) <= (x(6) and y(6)) or (x(6) and carry(5)) or (y(6) and carry(5));
    
    sadd(7) <= (x(7) xor y(7)) xor carry(6);
    carry(7) <= (x(7) and y(7)) or (x(7) and carry(6)) or (y(7) and carry(6));
   
    cout <= carry(7);

end architecture;

--------------------------- OR ---------------------------
library ieee;
use ieee.std_logic_1164.all;

entity or8 is
	port(
	    x   : in std_logic_vector(7 downto 0);
	    y   : in std_logic_vector(7 downto 0);
	    sor : out std_logic_vector(7 downto 0)
	);
end entity;

architecture comportamento of or8 is
begin

    sor <= x or y;
	
end architecture;

--------------------------- AND ---------------------------
library ieee;
use ieee.std_logic_1164.all;

entity and8 is
	port(
		x    : in std_logic_vector(7 downto 0);
	    y    : in std_logic_vector(7 downto 0);
	    sand : out std_logic_vector(7 downto 0)
	);
end entity;

architecture comportamento of and8 is
begin

	sand <= x and y;

end architecture;

--------------------------- NOT ---------------------------
library ieee;
use ieee.std_logic_1164.all;

entity not8 is
	port(
	    x    : in std_logic_vector(7 downto 0);
	    snot : out std_logic_vector(7 downto 0)
	);
end entity;

architecture comportamento of not8 is
begin

	snot <= not(x);
	
end architecture;