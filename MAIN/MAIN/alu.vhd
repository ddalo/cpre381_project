-------------------------------------------------------------------------
-- Bruce Bitwayiki
-- CPR E 381 Spring 21
-- Iowa State University
-------------------------------------------------------------------------
-- alu.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of a
--MIPS ALU  
--Notes            
-- 03/21/2021 by Bruce Bitwayiki::Design created.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_misc.all;
entity alu is
	port (
		  CLK			: in std_logic;
		  i_Data1		: in std_logic_vector(31 downto 0);
		  i_Data2		: in std_logic_vector(31 downto 0);
		  i_ALU_CTRL		: in std_logic_vector(8 downto 0);
		  o_Zero		: out std_logic;
		  o_ALURslt		: out std_logic_vector(31 downto 0));
end alu;


architecture structure of alu is 

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
			CLK			: in std_logic;
			i_Input		: in std_logic_vector(31 downto 0);
			i_ShiftAmt	: in std_logic_vector (4 downto 0);
			i_Arithmetic: in std_logic;						-- 0 == logical and 1 == arithmetic shift
			i_LeftRight	: in std_logic;						-- 0 == left shift and 1 == right shift
			o_Output	: out std_logic_vector(31 downto 0));
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
  
  signal s_AddSub_res	: std_logic_vector(31 downto 0);
  signal s_AddSub_over	: std_logic;
  signal s_shift_res	: std_logic_vector(31 downto 0);
  signal s_Mux_res		: std_logic_vector(31 downto 0);
  
begin

  --Instantiante add_Sub unit
  G_ADD_SUB: add_sub
	port map(
			CLK 		=> CLK,
			i_A			=> i_Data1,
			i_B			=> i_Data2,
			nAdd_Sub	=> i_ALU_CTRL(0),
			o_Sum		=> s_AddSub_res,
			o_over		=> s_AddSub_over);
			
  --Instantiate barrel shifter
  G_SHIFTER: shifter
	port map(
		CLK			=> CLK,
		i_Input		=> i_Data2,
		i_ShiftAmt	=> i_ALU_CTRL(5 downto 1),
		i_Arithmetic    => i_ALU_CTRL(6),						-- 0 == logical and 1 == arithmetic shift
		i_LeftRight	=> i_ALU_CTRL(7),						-- 0 == left shift and 1 == right shift
		o_Output	=> s_shift_res);

  --Initialize MUX to select if it is add/sub or shift op
  G_MUX: mux2t1_N
	generic map(32)
	port map(
		CLK		=> CLK,
		i_S		=> i_ALU_CTRL(8),
		i_D0	        => s_AddSub_res,
		i_D1	        => s_shift_res,
		o_O		=> s_Mux_res);
		
	o_Zero <= '1' when nor s_Mux_res else
			  '0';
		
 
  
  
  
   o_ALURslt		<= s_Mux_res;
  
end structure;
			
	
	

