-------------------------------------------------------------------------
-- Henry Duwe
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- MIPS_Processor.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a skeleton of a MIPS_Processor  
-- implementation.

-- 01/29/2019 by H3::Design created. 
-- 03/29/2021 by Dalo: implemented full processor
-------------------------------------------------------------------------


library IEEE;
use IEEE.std_logic_1164.all;

entity MIPS_Processor is
  generic(N : integer := 32);
  port(iCLK            : in std_logic;
       iRST            : in std_logic;
       iInstLd         : in std_logic;
       iInstAddr       : in std_logic_vector(N-1 downto 0);
       iInstExt        : in std_logic_vector(N-1 downto 0);
       oALUOut         : out std_logic_vector(N-1 downto 0)); -- TODO: Hook this up to the output of the ALU. It is important for synthesis that you have this output that can effectively be impacted by all other components so they are not optimized away.

end  MIPS_Processor;


architecture structure of MIPS_Processor is

  -- Required data memory signals
  signal s_DMemWr       : std_logic; -- $$  TODO: use this signal as the final active high data memory write enable signal
  signal s_DMemAddr     : std_logic_vector(N-1 downto 0); -- $$  TODO: use this signal as the final data memory address input
  signal s_DMemData     : std_logic_vector(N-1 downto 0); -- $$  TODO: use this signal as the final data memory data input
  signal s_DMemOut      : std_logic_vector(N-1 downto 0); -- $$  TODO: use this signal as the data memory output
 
  -- Required register file signals 
  signal s_RegWr        : std_logic; -- $$  TODO: use this signal as the final active high write enable input to the register file
  signal s_RegWrAddr    : std_logic_vector(4 downto 0); -- $$  TODO: use this signal as the final destination register address input
  signal s_RegWrData    : std_logic_vector(N-1 downto 0); -- $$  TODO: use this signal as the final data memory data input

  -- Required instruction memory signals
  signal s_IMemAddr     : std_logic_vector(N-1 downto 0); -- $$  Do not assign this signal, assign to s_NextInstAddr instead
  signal s_NextInstAddr : std_logic_vector(N-1 downto 0); -- $$  TODO: use this signal as your intended final instruction memory address input.
  signal s_Inst         : std_logic_vector(N-1 downto 0); -- $$  TODO: use this signal as the instruction signal 

  -- Required halt signal -- for simulation
  signal s_Halt         : std_logic;  -- TODO: this signal indicates to the simulation that intended program execution has completed. (Opcode: 01 0100)

  -- Required overflow signal -- for overflow exception detection
  signal s_Ovfl         : std_logic;  -- $$  TODO: this signal indicates an overflow exception would have been initiated

signal s_regdst		:std_logic;
signal s_alusrc		:std_logic;
signal s_m2r		:std_logic;
signal s_branch		:std_logic;
signal s_memread	:std_logic;
signal s_jump		:std_logic;
signal s_zero		:std_logic;
signal s_aluop		:std_logic_vector(5 downto 0);
signal s_aluctrl	:std_logic_vector(8 downto 0);
signal s_HIGH		:std_logic := '1';
signal s_temp		:std_logic_vector(N-1 downto 0);
signal s_RegData1	:std_logic_vector(31 downto 0);
signal s_ALUdata2	:std_logic_vector(31 downto 0);
signal s_signEXT	:std_logic_vector(31 downto 0);

  component mem is
    generic(ADDR_WIDTH : integer;
            DATA_WIDTH : integer);
    port(
          clk          : in std_logic;
          addr         : in std_logic_vector((ADDR_WIDTH-1) downto 0);
          data         : in std_logic_vector((DATA_WIDTH-1) downto 0);
          we           : in std_logic := '1';
          q            : out std_logic_vector((DATA_WIDTH -1) downto 0));
    end component;

  -- TODO: You may add any additional signals or components your implementation 
  --       requires below this comment

	component pc_n is		--pc entity which holds all of the pc logic blocks
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
	end component;

	component reg_file is
	port(CLK		: in std_logic;
		 RST		: in std_logic;
		 i_Reg1		: in std_logic_vector(4 downto 0);
		 i_Reg2		: in std_logic_vector(4 downto 0);
		 i_Reg_Wr	: in std_logic;
		 i_Wr_Reg	: in std_logic_vector(4 downto 0);
		 i_Wr_Data	: in std_logic_vector(31 downto 0);
		 o_Data1	: out std_logic_vector(31 downto 0);
		 o_Data2	: out std_logic_vector(31 downto 0));
	end component;

	component control is

  	port(instruct31_26            : in std_logic_vector(5 downto 0);
       		reg_dst 		            : out std_logic;
       		alu_src 		            : out std_logic;
       		mem_to_reg 		        : out std_logic;
       		reg_write                : out std_logic;
       		mem_read 		        : out std_logic;
	        mem_write 		        : out std_logic;
	        branch 		            : out std_logic;
	   	jump 		            : out std_logic;
       		alu_op 		            : out std_logic_vector(5 downto 0));

	end component;
	
	component signE is

  		port(
       			iEXT          : in std_logic_vector(15 downto 0);
       			oEXT          : out std_logic_vector(31 downto 0));

	end component;

	component alu_ctrl is
	port(	alu_op 		: in std_logic_vector(5 downto 0);
		funct		: in std_logic_vector(5 downto 0);
		i_shamt		: in std_logic_vector(4 downto 0);
		o_aluctrl	: out std_logic_vector(8 downto 0));
	end component;
	
	component alu is
	port (
		  CLK			: in std_logic;
		  i_Data1		: in std_logic_vector(31 downto 0);
		  i_Data2		: in std_logic_vector(31 downto 0);
		  i_ALU_CTRL		: in std_logic_vector(8 downto 0);
		  o_Zero		: out std_logic;
		  o_ALURslt		: out std_logic_vector(31 downto 0));
	end component;

	component mux2t1_N is
  	generic(N : integer := 2); -- Generic of type integer for input/output data width. Default value is 32.
  	port(	i_S          : in std_logic;
       		i_D0         : in std_logic_vector(N-1 downto 0);
       		i_D1         : in std_logic_vector(N-1 downto 0);
       		o_O          : out std_logic_vector(N-1 downto 0));

	end component;

	component org32 is

 	 port(  i_A          : in std_logic_vector(31 downto 0);
       		i_B          : in std_logic_vector(31 downto 0);
       		o_F          : out std_logic_vector(31 downto 0));

	end component;
begin

  -- TODO: This is required to be your final input to your instruction memory. This provides a feasible method to externally load the memory module which means that the synthesis tool must assume it knows nothing about the values stored in the instruction memory. If this is not included, much, if not all of the design is optimized out because the synthesis tool will believe the memory to be all zeros.
  with iInstLd select
    s_IMemAddr <= s_NextInstAddr when '0',
      iInstAddr when others;


  IMem: mem
    generic map(ADDR_WIDTH => 10,
                DATA_WIDTH => N)
    port map(clk  => iCLK,
             addr => s_IMemAddr(11 downto 2),
             data => iInstExt,
             we   => iInstLd,
             q    => s_Inst);
  
  DMem: mem
    generic map(ADDR_WIDTH => 10,
                DATA_WIDTH => N)
    port map(clk  => iCLK,
             addr => s_DMemAddr(11 downto 2),
             data => s_DMemData,
             we   => s_DMemWr,
             q    => s_DMemOut);



  -- TODO: Ensure that s_Halt is connected to an output control signal produced from decoding the Halt instruction (Opcode: 01 0100)
  -- TODO: Ensure that s_Ovfl is connected to the overflow output of your ALU

  -- TODO: Implement the rest of your processor below this comment! 



PC: pc_n

	port MAP (iCLK	=> iCLK,
	     	iA	=> s_Inst,	
	     	oA	=> s_NextInstAddr,	
	     	iIns	=> s_signEXT,
	     	iJ	=> s_jump,	
	     	iZ	=> s_zero,
	     	iB	=> s_branch,
 	     	iRST	=> iRST,	
	     	iLD	=> s_HIGH);	
CTRL: control
	port map(instruct31_26  => s_Inst(31 downto 26),          	
       		reg_dst 	=> s_regdst,         
       		alu_src 	=> s_alusrc,
       		mem_to_reg 	=> s_m2r,       
       		reg_write       => s_RegWr,         
       		mem_read 	=> s_memread,	        
	        mem_write 	=> s_DMemWr,	        
	        branch 		=> s_branch,          
	   	jump 		=> s_jump,           
       		alu_op 		=> s_aluop);            

WRmux: mux2t1_N
	port map (	i_S    => s_regdst,
       			i_D0   => s_Inst(20 downto 16),
       			i_D1   => s_Inst(15 downto 11),
       			o_O    => s_RegWrAddr);      
REGfile: reg_file	
	port map(CLK	      => iCLK,
		 RST	      => iRST,
		 i_Reg1	      => s_Inst(25 downto 21),
		 i_Reg2	      => s_Inst(20 downto 16),
		 i_Reg_Wr     => s_RegWr,
		 i_Wr_Reg     => s_RegWrAddr,
		 i_Wr_Data    => s_RegWrData,
		 o_Data1      => s_RegData1,
		 o_Data2      => s_DMemData);

SIGNex: signE

	port map (
       		    iEXT    => s_Inst(15 downto 0),      
       		    oEXT    => s_signEXT); 
ALUctrl: alu_ctrl
	port map(	alu_op 	    => s_aluop,
			funct	    => s_Inst(5 downto 0),
			i_shamt	    => s_Inst(10 downto 6),	
			o_aluctrl   => s_aluctrl);	
ALUmux: mux2t1_N
	port map (	i_S     => s_alusrc,     
       			i_D0    => s_DMemData,     
       			i_D1    => s_signEXT,     
       			o_O     => s_ALUdata2);     

ALU1: alu
	port map (
		  CLK	=> iCLK,
		  i_Data1	=> s_RegData1,	
		  i_Data2	=> s_ALUdata2,	
		  i_ALU_CTRL	=> s_aluctrl,	
		  o_Zero	=> s_zero,
		  o_ALURslt	=> s_DMemAddr);
ALUout: org32
  	port map(   i_A   => s_DMemAddr,        
       		    i_B   => s_DMemAddr,       
       		    o_F   => oALUOut);         
DMEMmux: mux2t1_N
	port map (	i_S     => s_m2r,     
       			i_D0    => s_DMemAddr,     
       			i_D1    => s_DMemOut,     
       			o_O     => s_RegWrData);


end structure;
