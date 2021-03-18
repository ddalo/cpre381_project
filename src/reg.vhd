-------------------------------------------------------------------------
-- Bruce Bitwayiki
-- CPR E 381 Spring 21
-- Iowa State University
-------------------------------------------------------------------------
-- reg.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of an N-bit 
--register using this flip-flop 
--  
--Notes            
-- 02/17/2021 by Bruce Bitwayiki:Design created.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity reg is
	generic(N : integer := 32);
	port(CLK		: in std_logic;
		 i_In		: in std_logic_vector(N-1 downto 0);
		 w_En		: in std_logic;
		 i_RST		: in std_logic;
		 o_Out		: out std_logic_vector(N-1 downto 0));
end reg;

architecture arch of reg is

	component dffg is
		port(i_CLK        : in std_logic;     -- Clock input
			 i_RST        : in std_logic;     -- Reset input
			 i_WE         : in std_logic;     -- Write enable input
			 i_D          : in std_logic;     -- Data value input
			 o_Q          : out std_logic);
	end component;
	
	
begin

  -- Instantiate N flip-flop instances.
  G_NBit_reg: for i in 0 to N-1 generate
    REGI: dffg
	  port map (i_CLK		=> CLK,
				i_D			=> i_In(i),
				i_WE		=> w_En,
				i_RST		=> i_RST,
				o_Q			=> o_Out(i));
  end generate G_NBit_reg;
  
end arch;