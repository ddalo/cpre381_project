-------------------------------------------------------------------------
-- Bruce Bitwayiki
-- CPR E 381 Spring 21
-- Iowa State University
-------------------------------------------------------------------------
-- shifter.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of a 32-bit shifter 
--using dataflow.
--  
--Notes            
-- 03/3/2021 by Bruce Bitwayiki::Design created.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity shifter is
	port(
		CLK			: in std_logic;
		i_Input		: in std_logic_vector(31 downto 0);
		i_ShiftAmt	: in std_logic_vector (4 downto 0);
		i_Arithmetic: in std_logic;						-- 0 == logical and 1 == arithmetic shift
		i_LeftRight	: in std_logic;						-- 0 == left shift and 1 == right shift
		
		o_Output	: out std_logic_vector(31 downto 0));
end entity;

architecture arch of shifter is 

	component mux2t1 is
		port(
			iClk			:in std_logic;
			i_D0			:in std_logic;
			i_D1			:in std_logic;
			i_S				:in std_logic;
			o_O				:out std_logic);
	end component;
	
	
begin
shifter: process(clk)
begin
   if rising_edge(CLK) then
		if i_Arithmetic = '1' then	--arithmetic shift
			if i_LeftRight = '1' then	-- right arithmetic shift(sra)
				o_Output <= std_logic_vector(shift_right(signed(i_Input), to_integer(unsigned(i_ShiftAmt))));
			else
				o_Output <= std_logic_vector(shift_left(unsigned(i_Input), to_integer(unsigned(i_ShiftAmt))));
			end if;
		else	-- logical shift
			if i_LeftRight = '1' then	-- shift right logilcal(srl)
				o_Output <= std_logic_vector(shift_right(unsigned(i_Input), to_integer(unsigned(i_ShiftAmt))));
			else	-- shift left logical (sll)
				o_Output <= std_logic_vector(shift_left(unsigned(i_Input), to_integer(unsigned(i_ShiftAmt))));
			end if;
		end if;
	end if;
 end process shifter;
end arch;


		