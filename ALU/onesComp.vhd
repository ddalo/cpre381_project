-------------------------------------------------------------------------
-- Bruce Bitwayiki
-- CPR E 381 Spring 21
-- Iowa State University
-------------------------------------------------------------------------
-- mux2t1_dataflow.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of N-bit one’s 
--complementor 
--  
--Notes            
-- 02/05/2021 by Bruce Bitwayiki::Design created.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity onesComp is 
	generic(N : integer := 32);
	port(
		 i_In		:in std_logic_vector(N-1 downto 0);
		 o_Out		:out std_logic_vector(N-1 downto 0));
end onesComp;


architecture arch of onesComp is

	component invg is
		port(i_A          : in std_logic;
			 o_F          : out std_logic);
	end component;
	
begin

	-- Instantiate N invg instances.
	G_Ninvg: for i in 0 to N-1 generate
	  INVI: invg 
		port map(i_A		=> i_In(i),		--ith instance's data input is hooked to the ith input bit 
				 o_F		=> o_Out(i));		--ith instance's data output is hooked to the ith ouput bit
	end generate G_Ninvg;
	
end arch;
		
		
		
		
		
		
		
		
		