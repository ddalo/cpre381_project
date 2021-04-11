library IEEE;	
use IEEE.std_logic_1164.all;

entity fetch_n is		--fetch entity which holds all of the fetch logic blocks
	generic(N : integer := 32); -- Generic of type integer for input/output data width. Default value is 32.
	port(iCLK	: in std_logic;
	     iA		: in std_logic_vector(N-1 downto 0);  --input address to program counter
	     oA		: out std_logic_vector(N-1 downto 0);  --output address from program counter
	     iIns	: in std_logic_vector(N-1 downto 0); --signextended instruction from instruction memory
	     iJ		: in std_logic; 	--jump input 1 or 0 for mux control of address addition
	     iZ		: in std_logic;   --the zero result from the ALU block which outputs a 1 or 0
	     iB		: in std_logic;   --branch control input which outputs 1 or 0
 	     iRST	: in std_logic;   --reset
	     iLD	: in std_logic);   --load
end fetch_n;
		

architecture structural of fetch_n is
	component registerN is
  	generic (N : integer := 32);
  	   port (iRST, iLD, iCLK 	: in std_logic;    -- reset, load=write enable, clock
        	 iA 			: in std_logic_vector(N-1 downto 0); --input address
       		 oA 			: out std_logic_vector(N-1 downto 0)); -- output address
	end component;
	
	component mux2t1_N is
  	generic(N : integer := 32); -- Generic of type integer for input/output data width. Default value is 32.
  	port(i_S          : in std_logic; -- selector
       	     i_D0         : in std_logic_vector(N-1 downto 0);   -- input one
       	     i_D1         : in std_logic_vector(N-1 downto 0);	 -- input two
       	     o_O          : out std_logic_vector(N-1 downto 0)); -- output

	end component;

	
	component fadderN is
	generic(N : integer := 32);
	port(A	: in std_logic_vector(N-1 downto 0);	--first value
	     B	: in std_logic_vector(N-1 downto 0);	--second value
	     C	: in std_logic;				--carry in
	     S	: out std_logic_vector(N-1 downto 0);	--output/sum
	     E	: out std_logic);			--carry out
	end component;

	component addC is
	generic(N : integer := 32);
	    port(
      		 iA               : in std_logic_vector(N-1 downto 0);	--vector to add
       		 iB               : in integer;				--integer constant 
      		 oA               : out std_logic_vector(N-1 downto 0));	--output
	end component;

	component shiftleft is
	generic(N : integer := 32);
	port(iA : in std_logic_vector(N-1 downto 0);	--vector in
	     oA : out std_logic_vector(N-1 downto 0));	--vector out
	end component;
	
	component andg2 is

  	port(i_A          : in std_logic;   --value one
       	i_B          : in std_logic;	--value two
       	o_F          : out std_logic); --output

	end component;
	
	component addV is
  	generic(N : integer := 32);
  	port(
       	iA               : in std_logic_vector(27 downto 0);  --first vector
       	iB               : in std_logic_vector(3 downto 0);	--second vector 
       	oC               : out std_logic_vector(N-1 downto 0)); --concat output

	end component;
signal s_N 	: std_logic_vector(31 downto 0); --the shifted jump address value
signal s_T 	: std_logic_vector(27 downto 0); -- jump SL output 28bits wide
signal s_R	: std_logic_vector(25 downto 0); --instruction memory 25-0
signal s_X	: std_logic_vector(31 downto 0);
signal s_Y	: std_logic_vector(31 downto 0);
signal s_Z	: std_logic_vector(31 downto 0);
signal s_F	: std_logic_vector(31 downto 0);
signal s_E	: std_logic;
signal s_U	: std_logic_vector(31 downto 0);
signal s_O	: std_logic; --the anded signal 
signal s_M	: std_logic_vector(31 downto 0);
constant C : integer := 4;

begin

g_Reg1: registerN --.
	port MAP(iRST => iRST,
		 iLD => iLD,
		 iCLK => iCLK,
		 iA => s_X,
		 oA => s_Y);
g_Add1: addC --.
	port MAP(iA => s_Y,
		 iB => C,
		 oA => s_Z);
g_Shift1: shiftleft --jump address SL  --.
	port MAP(iA => s_R(25 downto 0),
		 oA => s_T);
g_addV: addV --.
	port MAP(iA => s_T,
		 iB => s_Z(31 downto 28),
		 oC => s_N);
g_Shift2: shiftleft --fadder SL --.
	port MAP(iA => iIns,
		 oA => s_F);
g_Add2: fadderN --.
	port MAP(A => s_Z,
		 B => s_F,
		 C => '0',
		 S => s_U,
		 E => s_E);
g_And1: andg2 --.
	port MAP(i_A => iB,
		 i_B => iZ,
		 o_F => s_O);
g_Mux1: mux2t1_N --.
	port MAP(i_S => s_O,
		 i_D0 => s_Z,
		 i_D1 => s_U,
		 o_O => s_M);
g_Mux2: mux2t1_N  --.
	port MAP(i_S => iJ,
		 i_D0 => s_M,
		 i_D1 => s_N,
		 o_O => s_X);

end structural;