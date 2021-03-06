library IEEE;
use IEEE.std_logic_1164.all;

entity ALU_main is

  port(
        OP_A          	  : in std_logic_vector(31 downto 0);
	OP_B          	  : in std_logic_vector(31 downto 0);
	ALUOP          	  : in std_logic_vector(10 downto 0);
	Carryout          : out std_logic;
	Overflow          : out std_logic;
	Zero              : out std_logic;
        result_F          : out std_logic_vector(31 downto 0));

end ALU_main;



architecture mixed of ALU_main is
	

	component org32 is

  	port(   i_A          : in std_logic_vector(31 downto 0);
       		i_B          : in std_logic_vector(31 downto 0);
       		o_F          : out std_logic_vector(31 downto 0));

	end component;

	component andg32 is

  	port(i_A          : in std_logic_vector(31 downto 0);
       	     i_B          : in std_logic_vector(31 downto 0);
       	     o_F          : out std_logic_vector(31 downto 0));

	end component;


	component add_sub is 
	generic(N : integer := 32);
	port(
		 CLK 		: in std_logic;
		 i_A		: in std_logic_vector(N-1 downto 0);
		 i_B		: in std_logic_vector(N-1 downto 0);
		 nAdd_Sub	: in std_logic;
		 o_Sum		: out std_logic_vector(N-1 downto 0);
		 o_over		: out std_logic);
	end component;

	component shifter is
		port(
			CLK		: in std_logic;
			i_Input		: in std_logic_vector(31 downto 0);
			i_ShiftAmt	: in std_logic_vector (4 downto 0);
			i_Arithmetic	: in std_logic;						-- 0 == logical and 1 == arithmetic shift
			i_LeftRight	: in std_logic;						-- 0 == left shift and 1 == right shift
			o_Output	: out std_logic_vector(31 downto 0));
	end component;
	

begin
 	
	Zero <= not(or_reduce(result_F));