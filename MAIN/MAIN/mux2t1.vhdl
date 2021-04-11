-------------------------------------------------------------------------
-- David Dalo
-------------------------------------------------------------------------
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of a 2-input AND 
-- gate.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity mux2t1 is
	
  port(i_S	    : in std_logic;
       i_D0	    : in std_logic;
       i_D1	    : in std_logic;
       o_O	    : out std_logic);

end mux2t1;

architecture structure of mux2t1 is

component andg2

  port(i_A          : in std_logic;
       i_B          : in std_logic;
       o_F         : out std_logic);

end component;


component org2
  
  port(i_A          : in std_logic;
       i_B          : in std_logic;
       o_F          : out std_logic);

end component;


component invg

  port(i_A          : in std_logic;
       o_F          : out std_logic);

end component;



signal s_X	: std_logic;
signal s_I	: std_logic;
signal s_Y	: std_logic;

begin

g_And1: andg2
  port MAP(i_A		=> i_D1,
	   i_B		=> i_S,
	   o_F		=> s_X);
g_Inv1: invg
  port MAP(i_A		=> i_S,
	   o_F		=> s_I);
g_And2: andg2
  port MAP(i_A		=> i_D0,
	   i_B		=> s_I,
	   o_F		=> s_Y);
g_Or1: org2
  port MAP(i_A		=> s_X,
	   i_B		=> s_Y,
	   o_F		=> o_O);

end structure;