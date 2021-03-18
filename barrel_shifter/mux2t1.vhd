-------------------------------------------------------------------------
-- Bruce Bitwayiki
-- CPR E 381 Spring 21
-- Iowa State University
-------------------------------------------------------------------------
-- mux2t1.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of a 2 to 1 MUX.
--  
--Notes            
-- 02/05/2021 by Bruce Bitwayiki::Design created.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity mux2t1 is

	port(iClk			:in std_logic;
		 i_D0			:in std_logic;
		 i_D1			:in std_logic;
		 i_S			:in std_logic;
		 o_O			:out std_logic);
		 
end mux2t1;

architecture structure of mux2t1 is


	-- Describe the component entities as defined in invg.vhd, andg2.vhd,
	--org2.vhd
	component invg 
		port(i_A          : in std_logic;
			 o_F          : out std_logic);
	end component;
	
	component andg2
		 port(i_A          : in std_logic;
		 i_B          	   : in std_logic;
		 o_F          	   : out std_logic);
	end component;
	
	component org2 
		 port(i_A          : in std_logic;
		 i_B          	   : in std_logic;
		 o_F          	   : out std_logic);
	end component;
	
	
	--signal to carry NOT S
	signal s_S			:std_logic;
	--signal to carry D0 AND s_S
	signal s_AND1		:std_logic;
	--signal to carry D1 AND i_S
	signal s_AND2		:std_logic;
	
begin

  ---------------------------------------------------------------------------
  -- Level 0: NOT S
  ---------------------------------------------------------------------------
	g_Not1: invg
	  port MAP(i_A          	=> i_S,
			   o_F              => s_S);
			 
	
  ---------------------------------------------------------------------------
  -- Level 1: AND D0 with s_S and D1 with i_S
  ---------------------------------------------------------------------------
  	g_And1: andg2
	  port MAP(i_A              => i_D0,
			   i_B         		=> s_S,
		       o_F          	=> s_AND1);
			   
	g_And2: andg2
	  port MAP(i_A              => i_D1,
			   i_B         		=> i_S,
		       o_F          	=> s_AND2);
			   
	g_Or1: org2
	  port MAP(i_A          	=> s_AND1,
			   i_B          	=> s_AND2,
			   o_F          	=> o_O);
			   
			   
end structure;
	
	