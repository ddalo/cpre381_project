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
	
	component invg32 is
  	port(   i_A          : in std_logic_vector(31 downto 0);
      		o_F          : out std_logic_vector(31 downto 0));

	end component;
	
	
	component mux2t1 is
	
  	port(   i_S	    : in std_logic;
       		i_D0	    : in std_logic;
       		i_D1	    : in std_logic;
       		o_O	    : out std_logic);

	end component;


	component xorg32 is

  	port(   i_A          : in std_logic_vector(31 downto 0);
       		i_B          : in std_logic_vector(31 downto 0);
       		o_F          : out std_logic_vector(31 downto 0));

	end component;
	

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


	component AddSub is
	generic(N : integer := 32);
	port(   A1          : in std_logic_vector(N-1 downto 0);
    		B1       : in std_logic_vector(N-1 downto 0);
     		nAS   : in std_logic;
     		o_F        : out std_logic_vector(N-1 downto 0);
     		o_C        : out std_logic);

	end component;


	component slt is
 	 generic(N : integer := 32);
  	port(       
       		iB               : in std_logic;
       		oC               : out std_logic_vector(N-1 downto 0));

	end component;


	component shifter is
		port(
			i_Input		: in std_logic_vector(31 downto 0);
			i_ShiftAmt	: in std_logic_vector (4 downto 0);
			i_Arithmetic	: in std_logic;						-- 0 == logical and 1 == arithmetic shift
			i_LeftRight	: in std_logic;						-- 0 == left shift and 1 == right shift
			o_Output	: out std_logic_vector(31 downto 0));
	end component;
	

	component aluMux is 
		port(   add,sub,slt,or1,and1,xor1,shift,beq,bne 	: in std_logic_vector(31 downto 0);
			s		: in std_logic_vector(4 downto 0);
			aluRes		: out std_logic_vector(31 downto 0));
	end component;

signal s_nA :std_logic_vector(31 downto 0);
signal s_nB :std_logic_vector(31 downto 0);
signal s_Asel :std_logic_vector(31 downto 0);
signal s_Bsel :std_logic_vector(31 downto 0);
signal s_XOR :std_logic_vector(31 downto 0);
signal s_OR :std_logic_vector(31 downto 0);
signal s_AND :std_logic_vector(31 downto 0);
signal s_Shifter :std_logic_vector(31 downto 0);
signal s_ASresult :std_logic_vector(31 downto 0);
signal s_carry :std_logic;
signal s_SLT :std_logic_vector(31 downto 0);

begin
g_Asel: 
	invg32
	port MAP(i_A => OP_A,
		 o_F => s_nA);
  	mux2t1
	port MAP(i_S => ,  --parse alu_ctrl
       		 i_D0 => OP_A,
       		 i_D1 => s_nA,
       		 o_O => s_Asel);
g_Bsel: 
	invg32
	port MAP(i_A => OP_B,
		 o_F => s_nB);
  	mux2t1
	port MAP(i_S => , --parse alu_ctrl
       		 i_D0 => OP_B,
       		 i_D1 => s_nB,
       		 o_O => s_Bsel);
g_Shifter: 
	Shifter
	port MAP(i_Input => OP_B, 
		 i_ShiftAmt => , --parse alu_ctrl
		 i_Arithmetic => , --parse alu_ctrl
		 i_LeftRight => , --parse alu_ctrl
		 o_Output => s_Shifter); 	
g_AddSub: 
	AddSub
	port MAP(A1 => s_Asel,
		 B1 => s_Bsel,
		 nAS => , --parse alu_ctrl
		 o_F => s_ASresult,
		 o_C => s_carry);
g_OR: 
	org32
	port MAP(i_A => s_Asel,
		 i_B => s_Bsel,
		 o_F => s_OR);

g_AND: 
	andg32
	port MAP(i_A => s_Asel,
		 i_B => s_Bsel,
		 o_F => s_AND);
g_SLT: 
	slt
	port MAP(iB => s_ASresult(31),
		 oC => s_SLT);
g_XOR: 
	xorg32
	port MAP(i_A => OP_A,
		 i_B => OP_B,
		 o_F => s_XOR);
g_MUX: 
	aluMux
	port MAP(add => ,
		 sub => ,
		 slt => ,
		 or1 => ,
		 and1 => s_AND,
		 xor1 => s_XOR,
		 shift => ,
		 beq => ,
		 bne => ,
		 s => ,
		 aluRes => result_F);
 
	