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
  signal s_DMemWr       : std_logic; -- TODO: use this signal as the final active high data memory write enable signal
  signal s_DMemAddr     : std_logic_vector(N-1 downto 0); -- TODO: use this signal as the final data memory address input
  signal s_DMemData     : std_logic_vector(N-1 downto 0); -- TODO: use this signal as the final data memory data input
  signal s_DMemOut      : std_logic_vector(N-1 downto 0); -- TODO: use this signal as the data memory output
 
  -- Required register file signals 
  signal s_RegWr        : std_logic; -- TODO: use this signal as the final active high write enable input to the register file
  signal s_RegWrAddr    : std_logic_vector(4 downto 0); -- TODO: use this signal as the final destination register address input
  signal s_RegWrData    : std_logic_vector(N-1 downto 0); -- TODO: use this signal as the final data memory data input

  -- Required instruction memory signals
  signal s_IMemAddr     : std_logic_vector(N-1 downto 0); -- Do not assign this signal, assign to s_NextInstAddr instead
  signal s_NextInstAddr : std_logic_vector(N-1 downto 0); -- TODO: use this signal as your intended final instruction memory address input.
  signal s_Inst         : std_logic_vector(N-1 downto 0); -- TODO: use this signal as the instruction signal 

  -- Required halt signal -- for simulation
  signal s_Halt         : std_logic;  -- TODO: this signal indicates to the simulation that intended program execution has completed. (Opcode: 01 0100)

  -- Required overflow signal -- for overflow exception detection
  signal s_Ovfl         : std_logic;  -- TODO: this signal indicates an overflow exception would have been initiated

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
	
	component reg_file is
		port(CLK		: in std_logic;
			i_Reg1		: in std_logic_vector(4 downto 0);
			i_Reg2		: in std_logic_vector(4 downto 0);
			i_Reg_Wr	: in std_logic;
			i_Wr_Reg	: in std_logic_vector(4 downto 0);
			i_Wr_Data	: in std_logic_vector(31 downto 0);
			o_Data1	: out std_logic_vector(31 downto 0);
			o_Data2	: out std_logic_vector(31 downto 0));
	end component;
	
	component alu is
		port (
		  CLK			: in std_logic;
		  i_Data1		: in std_logic_vector(31 downto 0);
		  i_Data2		: in std_logic_vector(31 downto 0);
		  i_ALU_CTRL	: in std_logic_vector(8 downto 0);
		  o_Zero		: out std_logic;
		  o_ALURslt		: out std_logic_vector(31 downto 0);
		  o_Overflow	: out std_logic);
	end component;
	
	component mux2t1_N is
		generic(N : integer := 16); -- Generic of type integer for input/output data width. Default value is 32.
		port(
			CLK			: in std_logic;
			i_S          : in std_logic;
			i_D0         : in std_logic_vector(N-1 downto 0);
			i_D1         : in std_logic_vector(N-1 downto 0);
			o_O          : out std_logic_vector(N-1 downto 0));
	end component;

  -- TODO: You may add any additional signals or components your implementation 
  --       requires below this comment
  signal s_RegData1		: std_logic_vector(31 downto 0);
  signal s_RegData2		: std_logic_vector(31 downto 0);
  signal s_ALUBMux		: std_logic_vector(31 downto 0);
  signal s_ALUZero		: std_logic;
  signal s_DMem_Rslt	: std_logic_vector(31 downto 0);


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

  --Fetch Stage
  -- Fetch Logic ---
  
  
  
  
  --Decode Stage
  --Mux for register address to select destination as RT or RD
  RDMux: mux2t1_N
	generic map(5)
	port map (
			   CLK			=> iCLK,
			   i_S			=> --RegDst,
			   i_D0			=> s_Inst(20 downto 16),
			   i_D1			=> s_Inst(15 downto 11),
			   o_O			=> s_RegWrAddr);
  -- Register File ---
  Register_File: reg_file
		port map(
				CLK			=> iCLK,
				i_Reg1		=> s_Inst(25 downto 21),
				i_Reg2		=> s_Inst(20 downto 16),
				i_Reg_Wr	=> s_RegWr,
				i_Wr_Reg	=> s_RegWrAddr,
				i_Wr_Data	=> s_RegWrData,
				o_Data1		=> s_RegData1,
				o_Data2		=> s_RegData2);
				
  --Execute stage
  --MUX to select input B of ALU as regData2 or the sign-extended immediate
  ALUB_MUX: mux2t1_N
	generic map(32)
	port map (
			  CLK			=> iCLK,
			  i_S			=> --ALUSrc,
			  i_D0			=> s_RegData2,
			  i_D1			=> -- sign-extended input,
			  o_O			=> s_ALUBMux);
  --ALU--
  g_ALU: alu
	port map(
			  CLK			=> iCLK,
			  i_Data1		=> s_RegData1,
			  i_Data2		=> s_ALUBMux,
			  i_ALU_CTRL	=> --signal from ALU_COntrol module,
			  o_Zero		=> s_ALUZero,
			  o_ALURslt		=> oALUOut,
			  o_Overflow	=> s_Ovfl);
			  
  --Memory Stage--
  s_DMemAddr(11 downto 2)	<= oALUOut(10 downto 0);
  s_DMemData	<= s_RegData2;
  s_DMemWr		<= --memWrite;
  s_DMem_Rslt	<= s_DMemOut;
  
  --Write Back Stage--
  WrBackMUX: mux2t1_N
	generic map(32)
	port map (
			  CLK			=> iCLK,
			  i_S			=> --memToReg,
			  i_D0			=> oALUOut,
			  i_D1			=> s_DMemOut,
			  o_O			=> s_RegWrData);


end structure;
