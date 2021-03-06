library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity shiftleft is
	generic(N : integer := 32);
	port(iA : in std_logic_vector(N-1 downto 0);
	     oA : out std_logic_vector(N-1 downto 0));
end shiftleft;

architecture shiftleft of shiftleft is
begin
	
	oA <= std_logic_vector(unsigned(iA) sll 2);
	
end shiftleft;
