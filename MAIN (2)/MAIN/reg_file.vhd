-------------------------------------------------------------------------
-- Bruce Bitwayiki
-- CPR E 381 Spring 21
-- Iowa State University
-------------------------------------------------------------------------
-- reg_file.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of a 32 32-bit register 
--refister file 
--  
--Notes            
-- 03/17/2021 by Bruce Bitwayiki:Design created.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity reg_file is
	port(CLK		: in std_logic;
		 RST		: in std_logic;
		 i_Reg1		: in std_logic_vector(4 downto 0);
		 i_Reg2		: in std_logic_vector(4 downto 0);
		 i_Reg_Wr	: in std_logic;
		 i_Wr_Reg	: in std_logic_vector(4 downto 0);
		 i_Wr_Data	: in std_logic_vector(31 downto 0);
		 o_Data1	: out std_logic_vector(31 downto 0);
		 o_Data2	: out std_logic_vector(31 downto 0));
end reg_file;


architecture arch of reg_file is

	component reg is 
		generic(N : integer := 32);
		port(
		 CLK		: in std_logic;
		 i_In		: in std_logic_vector(N-1 downto 0);
		 w_En		: in std_logic;
		 i_RST		: in std_logic;
		 o_Out		: out std_logic_vector(N-1 downto 0));
	end component;
	
	component andg2 is 
		port(
			  i_A		:in std_logic;
			  i_B		:in std_logic;
			  o_F		:out std_logic);
	end component;	

	component decoder_5t32 is
		port (i_In		: in std_logic_vector(4 downto 0);
			  o_Out		: out std_logic_vector (31 downto 0));
	end component;
	
	component mux_32t1 is
		port(CLK			: in std_logic;
	   i_S          : in std_logic_vector(4 downto 0);
       i_D0         : in std_logic_vector(31 downto 0);
       i_D1         : in std_logic_vector(31 downto 0);
	   i_D2         : in std_logic_vector(31 downto 0);
	   i_D3         : in std_logic_vector(31 downto 0);
	   i_D4         : in std_logic_vector(31 downto 0);
	   i_D5         : in std_logic_vector(31 downto 0);
	   i_D6         : in std_logic_vector(31 downto 0);
	   i_D7         : in std_logic_vector(31 downto 0);
	   i_D8         : in std_logic_vector(31 downto 0);
	   i_D9         : in std_logic_vector(31 downto 0);
	   i_D10         : in std_logic_vector(31 downto 0);
	   i_D11         : in std_logic_vector(31 downto 0);
	   i_D12         : in std_logic_vector(31 downto 0);
	   i_D13         : in std_logic_vector(31 downto 0);
	   i_D14         : in std_logic_vector(31 downto 0);
	   i_D15         : in std_logic_vector(31 downto 0);
	   i_D16         : in std_logic_vector(31 downto 0);
	   i_D17         : in std_logic_vector(31 downto 0);
	   i_D18         : in std_logic_vector(31 downto 0);
	   i_D19         : in std_logic_vector(31 downto 0);
	   i_D20         : in std_logic_vector(31 downto 0);
	   i_D21         : in std_logic_vector(31 downto 0);
	   i_D22         : in std_logic_vector(31 downto 0);
	   i_D23         : in std_logic_vector(31 downto 0);
	   i_D24         : in std_logic_vector(31 downto 0);
	   i_D25         : in std_logic_vector(31 downto 0);
	   i_D26         : in std_logic_vector(31 downto 0);
	   i_D27         : in std_logic_vector(31 downto 0);
	   i_D28         : in std_logic_vector(31 downto 0);
	   i_D29         : in std_logic_vector(31 downto 0);
	   i_D30         : in std_logic_vector(31 downto 0);
	   i_D31         : in std_logic_vector(31 downto 0);
       o_O           : out std_logic_vector(31 downto 0));
	end component;
	
	
	
	signal s_S0		:std_logic_vector(32-1 downto 0);
	signal s_S1		:std_logic_vector(32-1 downto 0);
	signal s_S2		:std_logic_vector(32-1 downto 0);
	signal s_S3		:std_logic_vector(32-1 downto 0);
	signal s_S4		:std_logic_vector(32-1 downto 0);
	signal s_S5		:std_logic_vector(32-1 downto 0);
	signal s_S6		:std_logic_vector(32-1 downto 0);
	signal s_S7		:std_logic_vector(32-1 downto 0);
	signal s_S8		:std_logic_vector(32-1 downto 0);
	signal s_S9		:std_logic_vector(32-1 downto 0);
	signal s_S10	:std_logic_vector(32-1 downto 0);
	signal s_S11	:std_logic_vector(32-1 downto 0);
	signal s_S12	:std_logic_vector(32-1 downto 0);
	signal s_S13	:std_logic_vector(32-1 downto 0);
	signal s_S14	:std_logic_vector(32-1 downto 0);
	signal s_S15	:std_logic_vector(32-1 downto 0);
	signal s_S16	:std_logic_vector(32-1 downto 0);
	signal s_S17	:std_logic_vector(32-1 downto 0);
	signal s_S18	:std_logic_vector(32-1 downto 0);
	signal s_S19	:std_logic_vector(32-1 downto 0);
	signal s_S20	:std_logic_vector(32-1 downto 0);
	signal s_S21	:std_logic_vector(32-1 downto 0);
	signal s_S22	:std_logic_vector(32-1 downto 0);
	signal s_S23	:std_logic_vector(32-1 downto 0);
	signal s_S24	:std_logic_vector(32-1 downto 0);
	signal s_S25	:std_logic_vector(32-1 downto 0);
	signal s_S26	:std_logic_vector(32-1 downto 0);
	signal s_S27	:std_logic_vector(32-1 downto 0);
	signal s_S28	:std_logic_vector(32-1 downto 0);
	signal s_S29	:std_logic_vector(32-1 downto 0);
	signal s_S30	:std_logic_vector(32-1 downto 0);
	signal s_S31	:std_logic_vector(32-1 downto 0);
	signal s_Reg_En	:std_logic_vector(32-1 downto 0);
	
	signal s_and0 : std_logic;
	signal s_and1 : std_logic;
	signal s_and2 : std_logic;
	signal s_and3 : std_logic;
	signal s_and4 : std_logic;
	signal s_and5 : std_logic;
	signal s_and6 : std_logic;
	signal s_and7 : std_logic;
	signal s_and8 : std_logic;
	signal s_and9 : std_logic;
	signal s_and10 : std_logic;
	signal s_and11 : std_logic;
	signal s_and12 : std_logic;
	signal s_and13 : std_logic;
	signal s_and14 : std_logic;
	signal s_and15 : std_logic;
	signal s_and16 : std_logic;
	signal s_and17 : std_logic;
	signal s_and18 : std_logic;
	signal s_and19 : std_logic;
	signal s_and20 : std_logic;
	signal s_and21 : std_logic;
	signal s_and22 : std_logic;
	signal s_and23 : std_logic;
	signal s_and24 : std_logic;
	signal s_and25 : std_logic;
	signal s_and26 : std_logic;
	signal s_and27 : std_logic;
	signal s_and28 : std_logic;
	signal s_and29 : std_logic;
	signal s_and30 : std_logic;
	signal s_and31 : std_logic;
	signal const1  : std_logic;
	--signal s_RST   : std_logic := '0';
	
begin 

   ---------------------------------------------------------------------------
  -- Set constant 1 to be 1 for $0;
  ---------------------------------------------------------------------------
  const1 <= '1';

  ---------------------------------------------------------------------------
  -- Decode i_Wr_Reg to decide which register we would possibly write to
  ---------------------------------------------------------------------------
  Decoder: decoder_5t32
	port map(
			  i_In		=> i_Wr_Reg,
			  o_Out		=> s_Reg_En);
			  
  ---------------------------------------------------------------------------
  -- setup register $0
  ---------------------------------------------------------------------------
  and_zero: andg2
	port map(
			  i_A		=> s_Reg_En(0),
			  i_B		=> i_Reg_Wr,
			  o_F		=> s_and0);
  zero: reg
	generic map(32)
	port map(
			  CLK		=> CLK,
			  i_In		=> i_Wr_Data,
			  w_En		=> s_and0,
			  i_RST		=> const1,
			  o_Out		=> s_S0);
			  
  ---------------------------------------------------------------------------
  -- setup register $1
  ---------------------------------------------------------------------------
  and_one: andg2
	port map(
			  i_A		=> s_Reg_En(1),
			  i_B		=> i_Reg_Wr,
			  o_F		=> s_and1);
  one: reg
	generic map(32)
	port map(
			  CLK		=> CLK,
			  i_In		=> i_Wr_Data,
			  w_En		=> s_and1,
			  i_RST		=> RST,
			  o_Out		=> s_S1);
			  
  ---------------------------------------------------------------------------
  -- setup register $2
  ---------------------------------------------------------------------------
  and_two: andg2
	port map(
			  i_A		=> s_Reg_En(2),
			  i_B		=> i_Reg_Wr,
			  o_F		=> s_and2);
  two: reg
	generic map(32)
	port map(
			  CLK		=> CLK,
			  i_In		=> i_Wr_Data,
			  w_En		=> s_and2,
			  i_RST		=> RST,
			  o_Out		=> s_S2);
			  
  ---------------------------------------------------------------------------
  -- setup register $3
  ---------------------------------------------------------------------------
  and_three: andg2
	port map(
			  i_A		=> s_Reg_En(3),
			  i_B		=> i_Reg_Wr,
			  o_F		=> s_and3);
  three: reg
	generic map(32)
	port map(
			  CLK		=> CLK,
			  i_In		=> i_Wr_Data,
			  w_En		=> s_and3,
			  i_RST		=> RST,
			  o_Out		=> s_S3);
			  
  ---------------------------------------------------------------------------
  -- setup register $4
  ---------------------------------------------------------------------------
  and_four: andg2
	port map(
			  i_A		=> s_Reg_En(4),
			  i_B		=> i_Reg_Wr,
			  o_F		=> s_and4);
  four: reg
	generic map(32)
	port map(
			  CLK		=> CLK,
			  i_In		=> i_Wr_Data,
			  w_En		=> s_and4,
			  i_RST		=> RST,
			  o_Out		=> s_S4);
			  
   ---------------------------------------------------------------------------
  -- setup register $5
  ---------------------------------------------------------------------------
  and_five: andg2
	port map(
			  i_A		=> s_Reg_En(5),
			  i_B		=> i_Reg_Wr,
			  o_F		=> s_and5);
  five: reg
	generic map(32)
	port map(
			  CLK		=> CLK,
			  i_In		=> i_Wr_Data,
			  w_En		=> s_and5,
			  i_RST		=> RST,
			  o_Out		=> s_S5);
  ---------------------------------------------------------------------------
  -- setup register $6
  ---------------------------------------------------------------------------
  and_six: andg2
	port map(
			  i_A		=> s_Reg_En(6),
			  i_B		=> i_Reg_Wr,
			  o_F		=> s_and6);
  six: reg
	generic map(32)
	port map(
			  CLK		=> CLK,
			  i_In		=> i_Wr_Data,
			  w_En		=> s_and6,
			  i_RST		=> RST,
			  o_Out		=> s_S6);
  ---------------------------------------------------------------------------
  -- setup register $7
  ---------------------------------------------------------------------------
  and_seven: andg2
	port map(
			  i_A		=> s_Reg_En(7),
			  i_B		=> i_Reg_Wr,
			  o_F		=> s_and7);
  seven: reg
	generic map(32)
	port map(
			  CLK		=> CLK,
			  i_In		=> i_Wr_Data,
			  w_En		=> s_and7,
			  i_RST		=> RST,
			  o_Out		=> s_S7);
  ---------------------------------------------------------------------------
  -- setup register $8
  ---------------------------------------------------------------------------
  and_eight: andg2
	port map(
			  i_A		=> s_Reg_En(8),
			  i_B		=> i_Reg_Wr,
			  o_F		=> s_and8);
  eight: reg
	generic map(32)
	port map(
			  CLK		=> CLK,
			  i_In		=> i_Wr_Data,
			  w_En		=> s_and8,
			  i_RST		=> RST,
			  o_Out		=> s_S8);
  ---------------------------------------------------------------------------
  -- setup register $9
  ---------------------------------------------------------------------------
  and_nine: andg2
	port map(
			  i_A		=> s_Reg_En(9),
			  i_B		=> i_Reg_Wr,
			  o_F		=> s_and9);
  nine: reg
	generic map(32)
	port map(
			  CLK		=> CLK,
			  i_In		=> i_Wr_Data,
			  w_En		=> s_and9,
			  i_RST		=> RST,
			  o_Out		=> s_S9);
  ---------------------------------------------------------------------------
  -- setup register $10
  ---------------------------------------------------------------------------
  and_ten: andg2
	port map(
			  i_A		=> s_Reg_En(10),
			  i_B		=> i_Reg_Wr,
			  o_F		=> s_and10);
  ten: reg
	generic map(32)
	port map(
			  CLK		=> CLK,
			  i_In		=> i_Wr_Data,
			  w_En		=> s_and10,
			  i_RST		=> RST,
			  o_Out		=> s_S10);
  ---------------------------------------------------------------------------
  -- setup register $11
  ---------------------------------------------------------------------------
  and_eleven: andg2
	port map(
			  i_A		=> s_Reg_En(11),
			  i_B		=> i_Reg_Wr,
			  o_F		=> s_and11);
  eleven: reg
	generic map(32)
	port map(
			  CLK		=> CLK,
			  i_In		=> i_Wr_Data,
			  w_En		=> s_and11,
			  i_RST		=> RST,
			  o_Out		=> s_S11);
  ---------------------------------------------------------------------------
  -- setup register $12
  ---------------------------------------------------------------------------
  and_twelve: andg2
	port map(
			  i_A		=> s_Reg_En(12),
			  i_B		=> i_Reg_Wr,
			  o_F		=> s_and12);
  twelve: reg
	generic map(32)
	port map(
			  CLK		=> CLK,
			  i_In		=> i_Wr_Data,
			  w_En		=> s_and12,
			  i_RST		=> RST,
			  o_Out		=> s_S12);
  ---------------------------------------------------------------------------
  -- setup register $13
  ---------------------------------------------------------------------------
  and_thirteen: andg2
	port map(
			  i_A		=> s_Reg_En(13),
			  i_B		=> i_Reg_Wr,
			  o_F		=> s_and13);
  thirteen: reg
	generic map(32)
	port map(
			  CLK		=> CLK,
			  i_In		=> i_Wr_Data,
			  w_En		=> s_and13,
			  i_RST		=> RST,
			  o_Out		=> s_S13);
  ---------------------------------------------------------------------------
  -- setup register $14
  ---------------------------------------------------------------------------
  and_fourteen: andg2
	port map(
			  i_A		=> s_Reg_En(14),
			  i_B		=> i_Reg_Wr,
			  o_F		=> s_and14);
  fourteen: reg
	generic map(32)
	port map(
			  CLK		=> CLK,
			  i_In		=> i_Wr_Data,
			  w_En		=> s_and14,
			  i_RST		=> RST,
			  o_Out		=> s_S14);
  ---------------------------------------------------------------------------
  -- setup register $15
  ---------------------------------------------------------------------------
  and_fifteen: andg2
	port map(
			  i_A		=> s_Reg_En(15),
			  i_B		=> i_Reg_Wr,
			  o_F		=> s_and15);
  fifteen: reg
	generic map(32)
	port map(
			  CLK		=> CLK,
			  i_In		=> i_Wr_Data,
			  w_En		=> s_and15,
			  i_RST		=> RST,
			  o_Out		=> s_S15);
  ---------------------------------------------------------------------------
  -- setup register $16
  ---------------------------------------------------------------------------
  and_sixteen: andg2
	port map(
			  i_A		=> s_Reg_En(16),
			  i_B		=> i_Reg_Wr,
			  o_F		=> s_and16);
  sixteen: reg
	generic map(32)
	port map(
			  CLK		=> CLK,
			  i_In		=> i_Wr_Data,
			  w_En		=> s_and16,
			  i_RST		=> RST,
			  o_Out		=> s_S16);
  ---------------------------------------------------------------------------
  -- setup register $17
  ---------------------------------------------------------------------------
  and_seventeen: andg2
	port map(
			  i_A		=> s_Reg_En(17),
			  i_B		=> i_Reg_Wr,
			  o_F		=> s_and17);
  seventeen: reg
	generic map(32)
	port map(
			  CLK		=> CLK,
			  i_In		=> i_Wr_Data,
			  w_En		=> s_and17,
			  i_RST		=> RST,
			  o_Out		=> s_S17);
  ---------------------------------------------------------------------------
  -- setup register $18
  ---------------------------------------------------------------------------
  and_eighteen: andg2
	port map(
			  i_A		=> s_Reg_En(18),
			  i_B		=> i_Reg_Wr,
			  o_F		=> s_and18);
  eighteen: reg
	generic map(32)
	port map(
			  CLK		=> CLK,
			  i_In		=> i_Wr_Data,
			  w_En		=> s_and18,
			  i_RST		=> RST,
			  o_Out		=> s_S18);
  ---------------------------------------------------------------------------
  -- setup register $19
  ---------------------------------------------------------------------------
  and_nineteen: andg2
	port map(
			  i_A		=> s_Reg_En(19),
			  i_B		=> i_Reg_Wr,
			  o_F		=> s_and19);
  ninetneen: reg
	generic map(32)
	port map(
			  CLK		=> CLK,
			  i_In		=> i_Wr_Data,
			  w_En		=> s_and19,
			  i_RST		=> RST,
			  o_Out		=> s_S19);
  ---------------------------------------------------------------------------
  -- setup register $20
  ---------------------------------------------------------------------------
  and_twenty: andg2
	port map(
			  i_A		=> s_Reg_En(20),
			  i_B		=> i_Reg_Wr,
			  o_F		=> s_and20);
  twenty: reg
	generic map(32)
	port map(
			  CLK		=> CLK,
			  i_In		=> i_Wr_Data,
			  w_En		=> s_and20,
			  i_RST		=> RST,
			  o_Out		=> s_S20);
  ---------------------------------------------------------------------------
  -- setup register $21
  ---------------------------------------------------------------------------
  and_twenty_one: andg2
	port map(
			  i_A		=> s_Reg_En(21),
			  i_B		=> i_Reg_Wr,
			  o_F		=> s_and21);
  twenty_one: reg
	generic map(32)
	port map(
			  CLK		=> CLK,
			  i_In		=> i_Wr_Data,
			  w_En		=> s_and21,
			  i_RST		=> RST,
			  o_Out		=> s_S21);
  ---------------------------------------------------------------------------
  -- setup register $22
  ---------------------------------------------------------------------------
  and_twenty_two: andg2
	port map(
			  i_A		=> s_Reg_En(22),
			  i_B		=> i_Reg_Wr,
			  o_F		=> s_and22);
  twenty_two: reg
	generic map(32)
	port map(
			  CLK		=> CLK,
			  i_In		=> i_Wr_Data,
			  w_En		=> s_and22,
			  i_RST		=> RST,
			  o_Out		=> s_S22);
  ---------------------------------------------------------------------------
  -- setup register $23
  ---------------------------------------------------------------------------
  and_twenty_three: andg2
	port map(
			  i_A		=> s_Reg_En(23),
			  i_B		=> i_Reg_Wr,
			  o_F		=> s_and23);
  twenty_three: reg
	generic map(32)
	port map(
			  CLK		=> CLK,
			  i_In		=> i_Wr_Data,
			  w_En		=> s_and23,
			  i_RST		=> RST,
			  o_Out		=> s_S23);
  ---------------------------------------------------------------------------
  -- setup register $24
  ---------------------------------------------------------------------------
  and_twenty_four: andg2
	port map(
			  i_A		=> s_Reg_En(24),
			  i_B		=> i_Reg_Wr,
			  o_F		=> s_and24);
  twenty_four: reg
	generic map(32)
	port map(
			  CLK		=> CLK,
			  i_In		=> i_Wr_Data,
			  w_En		=> s_and24,
			  i_RST		=> RST,
			  o_Out		=> s_S24);
			  
  ---------------------------------------------------------------------------
  -- setup register $25
  ---------------------------------------------------------------------------
  and_twenty_five: andg2
	port map(
			  i_A		=> s_Reg_En(25),
			  i_B		=> i_Reg_Wr,
			  o_F		=> s_and25);
  twenty_five: reg
	generic map(32)
	port map(
			  CLK		=> CLK,
			  i_In		=> i_Wr_Data,
			  w_En		=> s_and25,
			  i_RST		=> RST,
			  o_Out		=> s_S25);
			  
  ---------------------------------------------------------------------------
  -- setup register $26
  ---------------------------------------------------------------------------
  and_twenty_six: andg2
	port map(
			  i_A		=> s_Reg_En(26),
			  i_B		=> i_Reg_Wr,
			  o_F		=> s_and26);
  twenty_six: reg
	generic map(32)
	port map(
			  CLK		=> CLK,
			  i_In		=> i_Wr_Data,
			  w_En		=> s_and26,
			  i_RST		=> RST,
			  o_Out		=> s_S26);
		
  ---------------------------------------------------------------------------
  -- setup register $27
  ---------------------------------------------------------------------------
  and_twenty_seven: andg2
	port map(
			  i_A		=> s_Reg_En(27),
			  i_B		=> i_Reg_Wr,
			  o_F		=> s_and27);
  twenty_seven: reg
	generic map(32)
	port map(
			  CLK		=> CLK,
			  i_In		=> i_Wr_Data,
			  w_En		=> s_and27,
			  i_RST		=> RST,
			  o_Out		=> s_S27);
			  
  ---------------------------------------------------------------------------
  -- setup register $28
  ---------------------------------------------------------------------------
  and_twenty_eight: andg2
	port map(
			  i_A		=> s_Reg_En(28),
			  i_B		=> i_Reg_Wr,
			  o_F		=> s_and28);
  twenty_eight: reg
	generic map(32)
	port map(
			  CLK		=> CLK,
			  i_In		=> i_Wr_Data,
			  w_En		=> s_and28,
			  i_RST		=> RST,
			  o_Out		=> s_S28);
			  
  ---------------------------------------------------------------------------
  -- setup register $29
  ---------------------------------------------------------------------------
  and_twenty_nine: andg2
	port map(
			  i_A		=> s_Reg_En(29),
			  i_B		=> i_Reg_Wr,
			  o_F		=> s_and29);
  twenty_nine: reg
	generic map(32)
	port map(
			  CLK		=> CLK,
			  i_In		=> i_Wr_Data,
			  w_En		=> s_and29,
			  i_RST		=> RST,
			  o_Out		=> s_S29);
			  
  ---------------------------------------------------------------------------
  -- setup register $30
  ---------------------------------------------------------------------------
  and_thirty: andg2
	port map(
			  i_A		=> s_Reg_En(30),
			  i_B		=> i_Reg_Wr,
			  o_F		=> s_and30);
  thirty: reg
	generic map(32)
	port map(
			  CLK		=> CLK,
			  i_In		=> i_Wr_Data,
			  w_En		=> s_and30,
			  i_RST		=> RST,
			  o_Out		=> s_S30);
			  
  ---------------------------------------------------------------------------
  -- setup register $31
  ---------------------------------------------------------------------------
  and_thirty_one: andg2
	port map(
			  i_A		=> s_Reg_En(31),
			  i_B		=> i_Reg_Wr,
			  o_F		=> s_and31);
  thirty_one: reg
	generic map(32)
	port map(
			  CLK		=> CLK,
			  i_In		=> i_Wr_Data,
			  w_En		=> s_and31,
			  i_RST		=> RST,
			  o_Out		=> s_S31);

  ---------------------------------------------------------------------------
  -- mux to select the output for data1
  ---------------------------------------------------------------------------
  MUX1 : mux_32t1
	port map(
			  CLK		=> CLK,
			  i_S		=> i_Reg1,
			  i_D0		=> s_S0,
			  i_D1		=> s_S1,
			  i_D2		=> s_S2,
			  i_D3		=> s_S3,
			  i_D4		=> s_S4,
			  i_D5		=> s_S5,
			  i_D6		=> s_S6,
			  i_D7		=> s_S7,
			  i_D8		=> s_S8,
			  i_D9		=> s_S9,
			  i_D10		=> s_S10,
			  i_D11		=> s_S11,
			  i_D12		=> s_S12,
			  i_D13		=> s_S13,
			  i_D14		=> s_S14,
			  i_D15		=> s_S15,
			  i_D16		=> s_S16,
			  i_D17		=> s_S17,
			  i_D18		=> s_S18,
			  i_D19		=> s_S19,
			  i_D20		=> s_S20,
			  i_D21		=> s_S21,
			  i_D22		=> s_S22,
			  i_D23		=> s_S23,
			  i_D24		=> s_S24,
			  i_D25		=> s_S25,
			  i_D26		=> s_S26,
			  i_D27		=> s_S27,
			  i_D28		=> s_S28,
			  i_D29		=> s_S29,
			  i_D30		=> s_S30,
			  i_D31		=> s_S31,
			  o_O		=> o_Data1);
			  
  ---------------------------------------------------------------------------
  -- mux to select the output for data2
  ---------------------------------------------------------------------------
  MUX2 : mux_32t1
	port map(
			  CLK		=> CLK,
			  i_S		=> i_Reg2,
			  i_D0		=> s_S0,
			  i_D1		=> s_S1,
			  i_D2		=> s_S2,
			  i_D3		=> s_S3,
			  i_D4		=> s_S4,
			  i_D5		=> s_S5,
			  i_D6		=> s_S6,
			  i_D7		=> s_S7,
			  i_D8		=> s_S8,
			  i_D9		=> s_S9,
			  i_D10		=> s_S10,
			  i_D11		=> s_S11,
			  i_D12		=> s_S12,
			  i_D13		=> s_S13,
			  i_D14		=> s_S14,
			  i_D15		=> s_S15,
			  i_D16		=> s_S16,
			  i_D17		=> s_S17,
			  i_D18		=> s_S18,
			  i_D19		=> s_S19,
			  i_D20		=> s_S20,
			  i_D21		=> s_S21,
			  i_D22		=> s_S22,
			  i_D23		=> s_S23,
			  i_D24		=> s_S24,
			  i_D25		=> s_S25,
			  i_D26		=> s_S26,
			  i_D27		=> s_S27,
			  i_D28		=> s_S28,
			  i_D29		=> s_S29,
			  i_D30		=> s_S30,
			  i_D31		=> s_S31,
			  o_O		=> o_Data2);
			  
		  
end arch;

