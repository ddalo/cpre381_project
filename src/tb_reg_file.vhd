-------------------------------------------------------------------------
-- Bruce Bitwayiki
-- CPR E 381 Spring 21
-- Iowa State University
-------------------------------------------------------------------------
-- tb_reg_file.vhd
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

entity tb_reg_file is
  generic(gCLK_HPER   : time := 10 ns);   -- Generic for half of the clock cycle period
end tb_reg_file;

architecture arch of tb_reg_file is

  --define the total clock period time
  constant cCLK_PER : time := gCLK_HPER * 2;

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
  
-- Create signals for all of the inputs and outputs of the file that you are testing
signal iCLK, reset : std_logic := '0';

signal s_Reg1		: std_logic_vector(4 downto 0);
signal s_Reg2		: std_logic_vector(4 downto 0);
signal s_Reg_Wr		: std_logic;
signal s_Wr_Reg		: std_logic_vector(4 downto 0);
signal s_Wr_Data	: std_logic_vector(31 downto 0);
signal s_Data1		: std_logic_vector(31 downto 0);
signal s_Data2		: std_logic_vector(31 downto 0);

begin 


  DUT0: reg_file
	port map(
			  CLK		=> iCLK,
			  i_Reg1	=> s_Reg1,
			  i_Reg2	=> s_Reg2,
			  i_Reg_Wr	=> s_Reg_Wr,
			  i_Wr_Reg	=> s_Wr_Reg,
			  i_Wr_Data	=> s_Wr_Data,
			  o_Data1	=> s_Data1,
			  o_Data2	=> s_Data2);
			  
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
	
	--Test case 1:
	--Write to $2 a value of "00000010000010000010000000001010".
	s_Reg_Wr		<= '1';
	s_Wr_Reg		<= "00010";
	s_Wr_Data		<= "00000010000010000010000000001010";
	wait for gCLK_HPER*2;
	wait for gCLK_HPER*2;
	--expect
	
	--Test case 2:
	--Write to $5 a value of "11100010000010000010000000001010".
	s_Reg_Wr		<= '1';
	s_Wr_Reg		<= "00101";
	s_Wr_Data		<= "11100010000010000010000000001010";
	wait for gCLK_HPER*2;
	wait for gCLK_HPER*2;
	--expect
	
	--Test case 3:
	--check the value of reg $2 and reg $5.
	s_Reg1			<= "00010";
	s_Reg2			<= "00101";
	s_Reg_Wr		<= '0';
	s_Wr_Reg		<= "00101";
	s_Wr_Data		<= "00000000000000000000000000000000";
	wait for gCLK_HPER*2;
	wait for gCLK_HPER*2;
	--expect s_data1 to be "00000010000010000010000000001010" and s_data2 
	--to be"11100010000010000010000000001010"
	
	--Test case 4:
	--write to $8 and check it and $5
	s_Reg1			<= "01000";
	s_Reg2			<= "00010";
	s_Reg_Wr		<= '1';
	s_Wr_Reg		<= "01000";
	s_Wr_Data		<= "11111111111111111111111111111111";
	wait for gCLK_HPER*2;
	wait for gCLK_HPER*2;
	--Expect s_data1 to be "11111111111111111111111111111111" and s_data2 
	--to be "11100010000010000010000000001010"
	
	--Test case 5:
	--attempt to overide $8 with Reg_Wr '0' of "11100010000010000010000000001010".
	s_Reg1			<= "01000";
	s_Reg2			<= "00010";
	s_Reg_Wr		<= '0';
	s_Wr_Reg		<= "01000";
	s_Wr_Data		<= "00000000000000000000000000000000";
	wait for gCLK_HPER*2;
	wait for gCLK_HPER*2;
	--expect
	end process;
	
end arch;
