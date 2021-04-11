library IEEE;
use IEEE.std_logic_1164.all;

entity aluMux is 
	port( add,sub,slt,or1,and1,xor1,shift,beq,bne 	: in std_logic_vector(31 downto 0);
		s		: in std_logic_vector(4 downto 0);
		aluRes		: out std_logic_vector(31 downto 0));
end aluMux;

architecture behavior of aluMux is
begin
process (s)
begin
	case s is
		WHEN "00001" => aluRes <= or1;
		WHEN "00010" => aluRes <= add;
		WHEN "00110" => aluRes <= sub; 
		WHEN "00111" => aluRes <= slt;
		WHEN "01000" => aluRes <= xor1;
		WHEN "01001" => aluRes <= shift;
		WHEN "10000" => aluRes <= beq;
		WHEN "10001" => aluRes <= bne;
		WHEN "10111" => aluRes <= and1;
		WHEN OTHERS => aluRes <= or1;
	end case;
end process;
end behavior;
