-------------------------------------------------------------------------
-- Bruce Bitwayiki
-- CPR E 381 Spring 21
-- Iowa State University
-------------------------------------------------------------------------
-- ripple_carry_adder.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of an N-bit ripple-
--carry-adder
--  
--Notes            
-- 02/05/2021 by Bruce Bitwayiki::Design created.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity ripple_carry_adder is 
	 generic(N : integer := 32);
	 port(i_In0	    :in std_logic_vector(N-1 downto 0);
		  i_In1		:in std_logic_vector(N-1 downto 0);
		  i_Cin		:in std_logic;
		  o_Out		:out std_logic_vector(N-1 downto 0);
		  o_OvFlow	:out std_logic);
		  
		  
end ripple_carry_adder;

architecture arch of ripple_carry_adder is

	component adder is 
		port(i_I0		: in std_logic;
			 i_I1		: in std_logic;
			 i_Cin		: in std_logic;
			 o_Sum		: out std_logic;
			 o_Cout		: out std_logic);
	end component;
	
	component xorg2 is
		port(i_A		: in std_logic;
			 i_B		: in std_logic;
			 o_F		: out std_logic);
	end component;
			 
	signal s_carry		: std_logic_vector(N downto 0);
	
begin

	s_carry (0) <= i_Cin;			--input on first adder
	
	SET_WIDTH : for i in 0 to N-1 generate
	  adder_I: adder
		port map(i_I0		=> i_In0(i),
				 i_I1		=> i_In1(i),
				 i_Cin		=> s_carry(i),
				 o_Sum		=> o_Out(i),
				 o_Cout		=> s_carry(i+1));
	end generate SET_WIDTH;
	
	-- Calculate overflow by XOR C(n) and C(n-1)
	
	xorg2_1 : xorg2
		port map(i_A		=> s_carry(N),
				 i_B		=> s_carry(N-1),
				 o_F		=> o_OvFlow);
	-- <= s_carry(N);
	
	
end arch;
	
	
	
	
	
	
	