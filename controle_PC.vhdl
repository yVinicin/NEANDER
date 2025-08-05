--------------------------- ADD(add_PC) ---------------------------
library ieee;
use ieee.std_logic_1164.all;

entity add_PC is
    port(
        x, y : in std_logic_vector(7 downto 0);
        cin  : in std_logic;
        cout : out std_logic;
        sadd : out std_logic_vector(7 downto 0)
    );
end entity;

architecture SOMAR of add_PC is 

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

--------------------------- Módulo PC (Program Counter) ---------------------------
library ieee;
use ieee.std_logic_1164.all;

entity controle_PC is
    port(
        PC_cl, PC_clk   : in std_logic;
        PC_barr_inc     : in std_logic;
        PC_rw           : in std_logic;
        PC_barramento   : in std_logic_vector(7 downto 0);
        PC_s            : out std_logic_vector(7 downto 0)
    );
end entity;

architecture programcounter of controle_PC is
	component add_PC is
	    port(
            x, y : in std_logic_vector(7 downto 0);
            cin  : in std_logic;
            cout : out std_logic;
            sadd : out std_logic_vector(7 downto 0)
	    );
	end component;
	
	component mux2x8pc is
	    port(
            c0  : in std_logic_vector(7 downto 0);
            c1  : in std_logic_vector(7 downto 0);
            sel : in std_logic;
            z   : out std_logic_vector(7 downto 0)
	    );
	end component;
	
	component registradorPC is
        port(
            end_in     : in std_logic_vector(7 downto 0);
            clk        : in std_logic;
            pr, cl     : in std_logic;
            nrw        : in std_logic;
            end_out    : out std_logic_vector(7 downto 0)
        );
    end component;
	
    signal s_add : std_logic_vector(7 downto 0);
    signal s_mux2pc : std_logic_vector(7 downto 0);
    signal s_PCatual : std_logic_vector(7 downto 0);
    signal s_cout : std_logic;

begin
    -- Add_PC
	u_AddPC : add_PC port map("00000001", s_PCatual, '0', s_cout, s_add);
    
    -- Mux2x8
	u_Mux2x8 : mux2x8pc port map(PC_barramento, s_add, PC_barr_inc, s_mux2pc);

    -- Registrador PC
	u_regPC : registradorPC port map(s_mux2pc, PC_clk, '1', PC_cl, PC_rw, s_PCatual);
	PC_s <= s_PCatual;

end architecture programcounter;