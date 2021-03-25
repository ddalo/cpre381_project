-------------------------------------------------------------------------
-- Bruce Bitwayiki
-- CPR E 381 Spring 21
-- Iowa State University
-------------------------------------------------------------------------
-- fetch.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of a
--MIPS basic fetch (pc+4) 
--Notes            
-- 03/21/2021 by Bruce Bitwayiki::Design created.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity fetch is 
	port (
		  CLK			: in std_logic;
		  i_Input		: in std_logic_vector(31 downto 0);		--Input address into PC
		  o_Out			: out std_logic_vector(31 downto 0));	--Output address from program counter
end entity;		  

architecture structure of fetch is 

	component reg is
		generic(N : integer := 32);
		port(CLK		: in std_logic;
			 i_In		: in std_logic_vector(N-1 downto 0);
			 w_En		: in std_logic;
			 i_RST		: in std_logic;
			 o_Out		: out std_logic_vector(N-1 downto 0));
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
	
	signal constant4		: std_logic_vector(31 downto 0) := x"00000004";
	signal const1			: std_logic := '1';
	signal reset			: std_logic := '0';
	
	signal update			: std_logic_vector(31 downto 0) := x"00000000";

begin	
  --Instantiate the register
  PC: reg
	generic map(32)
	port map(
			  CLK		=> CLK,
			  i_In		=> update,
			  w_En		=> const1,
			  i_RST		=> reset,
			  o_Out		=> o_Out);
			  
	update	<= std_logic_vector(unsigned(o_Out) + unsigned(constant4));
	  
  
end structure;



		  