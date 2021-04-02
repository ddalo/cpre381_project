-------------------------------------------------------------------------
-- Bruce Bitwayiki
-- CPR E 381 Spring 21
-- Iowa State University
-------------------------------------------------------------------------
-- adder.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of a a full adder
--  
--Notes            
-- 02/05/2021 by Bruce Bitwayiki::Design created.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity adder is 

	port(
		 i_I0		: in std_logic;
		 i_I1		: in std_logic;
		 i_Cin		: in std_logic;
		 o_Sum		: out std_logic;
		 o_Cout		: out std_logic);
		 
end adder;

architecture structure of adder is

	-- Describe the component entities
	component andg2
		port(i_A          : in std_logic;
			 i_B          : in std_logic;
			 o_F          : out std_logic);
	end component;
	
	component org2
		port(i_A          : in std_logic;
			 i_B          : in std_logic;
			 o_F          : out std_logic);
	end component;
	
	component xorg2
		port(i_A          : in std_logic;
			 i_B          : in std_logic;
			 o_F          : out std_logic);
	end component;
	
	--Signal to carry I0 XOR I1
	signal s_xor1		:std_logic;
	signal s_and1		:std_logic;
	signal s_and2		:std_logic;
	
begin

  ---------------------------------------------------------------------------
  -- XOR the two input bits
  ---------------------------------------------------------------------------
	
  g_xor1: xorg2
	port map(i_A		  => i_I0,
			 i_B		  => i_I1,
			 o_F		  => s_xor1);
			   
  ---------------------------------------------------------------------------
  -- AND the XOR bit and Cin
  ---------------------------------------------------------------------------
  g_and1: andg2
	port map(i_A          => s_xor1,
			 i_B          => i_Cin,
			 o_F          =>s_and1);
			   
  
  ---------------------------------------------------------------------------
  -- AND the two input bits
  ---------------------------------------------------------------------------
  g_and2: andg2
	port map(i_A          => i_I0,
			 i_B          => i_I1,
			 o_F          =>s_and2);
			 
  ---------------------------------------------------------------------------
  -- Calculate the sum bit by XOR the previous xor signal and Cin 
  ---------------------------------------------------------------------------
  g_xor2: xorg2
	port map(i_A		  => s_xor1,
			 i_B		  => i_Cin,
			 o_F		  => o_Sum);
	
  ---------------------------------------------------------------------------
  -- Calculate the Cout bit
  ---------------------------------------------------------------------------
		
  g_or1: org2
	port map(i_A          => s_and1,
			 i_B          => s_and2,
			 o_F          => o_Cout);
			 
			 
  end structure;
