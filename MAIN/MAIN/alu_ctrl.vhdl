library IEEE;
use IEEE.std_logic_1164.all;

entity alu_ctrl is
	port(	alu_op 		: in std_logic_vector(5 downto 0);
		funct		: in std_logic_vector(5 downto 0);
		i_shamt		: in std_logic_vector(4 downto 0);
		o_aluctrl	: out std_logic_vector(8 downto 0));
end alu_ctrl;

architecture behavior of alu_ctrl is
begin
process(funct)
begin
	if (funct = "000000") then --sll
		o_aluctrl <=  "100" & i_shamt & '0';
	elsif (funct = "000010") then --srl
		o_aluctrl <=  "110" & i_shamt & '0';
	elsif (funct = "000011") then --sra
		o_aluctrl <=  "111" & i_shamt & '0';
	elsif (funct = "100000") then --add
		o_aluctrl <=  "000" & i_shamt & '0';
	elsif (funct = "100010") then --sub
		o_aluctrl <=  "000" & i_shamt & '1';
	else
	end if;

end process;
end behavior;