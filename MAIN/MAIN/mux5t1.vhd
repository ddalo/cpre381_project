library IEEE;
use IEEE.std_logic_1164.all;

entity aluMux is 
	port( add,sub,slt,or1,e 	: in std_logic_vector(31 downto 0);
		s		: in std_logic_vector(3 downto 0);
		aluRes		: out std_logic_vector(31 downto 0));
end aluMux;

architecture behavior of aluMux is
begin
process (s)
begin
	CASE s is
		WHEN "00000" => aluRes <= ;
		WHEN "00001" => aluRes <= or1;
		WHEN "00010" => aluRes <= add;
		WHEN "00011" => aluRes <= ;
		WHEN "00100" => aluRes <= ;
		WHEN "00110" => aluRes <= sub;
		WHEN OTHERS => aluRes <= ;
