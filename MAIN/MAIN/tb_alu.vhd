-------------------------------------------------------------------------
-- Bruce Bitwayiki
-- CPR E 381 Spring 21
-- Iowa State University
-------------------------------------------------------------------------
-- tb_alu.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a testbench for a Register file .
--  
--Notes            
-- 03/17/2021 by Bruce Bitwayiki::Design created.
-------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;  -- For logic types I/O
library std;
use std.env.all;                -- For hierarchical/external signals
use std.textio.all;             -- For basic I/O

entity tb_alu is
  generic(gCLK_HPER   : time := 10 ns);   -- Generic for half of the clock cycle period
end tb_alu;


architecture arch of tb_alu is

 --define the total clock period time
  constant cCLK_PER : time := gCLK_HPER * 2;
  
  component alu is
	port (
		  CLK			: in std_logic;
		  i_Data1		: in std_logic_vector(31 downto 0);
		  i_Data2		: in std_logic_vector(31 downto 0);
		  i_ALU_CTRL	: in std_logic_vector(8 downto 0);
		  o_Zero		: out std_logic;
		  o_ALURslt		: out std_logic_vector(31 downto 0));
  end component;
  
 -- Create signals for all of the inputs and outputs of the file that you are testing
signal iCLK, reset : std_logic := '0';

signal s_Data1		: std_logic_vector(31 downto 0);
signal s_Data2		: std_logic_vector(31 downto 0);
signal s_ALU_CTRL	: std_logic_vector(8 downto 0);
signal s_Zero		: std_logic;
signal s_ALURslt	: std_logic_vector(31 downto 0);

begin 

DUT0: alu
	port map(
			  CLK			=>iCLK,
			  i_Data1		=> s_Data1,
			  i_Data2		=> s_Data2,
			  i_ALU_CTRL	=> s_ALU_CTRL,
			  o_Zero		=> s_Zero,
			  o_ALURslt		=> s_ALURslt);
			  
  --This first process is to setup the clock for the test bench
  P_CLK: process
  begin
    iCLK <= '1';         -- clock starts at 1
    wait for gCLK_HPER; -- after half a cycle
    iCLK <= '0';         -- clock becomes a 0 (negative edge)
    wait for gCLK_HPER; -- after half a cycle, process begins evaluation again
  end process;
  
			   
  -- This process resets the sequential components of the design.
  -- It is held to be 1 across both the negative and positive edges of the clock
  -- so it works regardless of whether the design uses synchronous (pos or neg edge)
  -- or asynchronous resets.
  P_RST: process
  begin
  	reset <= '0';   
    wait for gCLK_HPER/2;
	reset <= '1';
    wait for gCLK_HPER*2;
	reset <= '0';
	wait;
  end process;
  
  -- Assign inputs for each test case.
  P_TEST_CASES: process
  begin
    wait for gCLK_HPER/2; -- for waveform clarity, NOT changing inputs on clk edges
	
	--Test case 1: add the two values from data1 and data2
	s_Data1		<= x"0000a000";
	s_Data2		<= x"000000a0";
	s_ALU_CTRL	<= "000000000";
	wait for gCLK_HPER*2;
	wait for gCLK_HPER*2;
	
	--Test case 2: subtract value 2 from value 1
	s_Data1		<= x"0000a000";
	s_Data2		<= x"000000a0";
	s_ALU_CTRL	<= "000000001";
	wait for gCLK_HPER*2;
	wait for gCLK_HPER*2;
	
	--Test case 3 :shift left logical (sll) of data2 by 5
	s_Data1		<= x"0000a000";
	s_Data2		<= x"000000a0";
	s_ALU_CTRL	<= "100001010";
	wait for gCLK_HPER*2;
	wait for gCLK_HPER*2;
	
	--Test case 4 :shift right logical (srl) of data2 by 1
	s_Data1		<= x"0000a000";
	s_Data2		<= x"000000a0";
	s_ALU_CTRL	<= "110000010";
	wait for gCLK_HPER*2;
	wait for gCLK_HPER*2;
	end process;
	
end arch;