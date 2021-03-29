library IEEE;
use IEEE.std_logic_1164.all;

entity alu_control is
	port(	alu_ctrl	: in std_logic_vector(4 downto 0);
	    	funct_code	: in std_logic_vector(5 downto 0);
	    	shamt		: in std_logic_vector(4 downto 0);
		o_aluctrl	: out std_logic_vector(9 downto 0)); 
end alu_control;

architecture behavior of alu_control is
begin
OC : process(alu_ctrl)
begin
	case(alu_ctrl) is 
		when "00000" =>
			if funct_code = "100000" then	--add
				o_aluctrl <= shamt & "00010";
			elsif funct_code = "100001" then --addu
				o_aluctrl <= shamt & "00010";
			elsif funct_code = "100100" then  --and
				o_aluctrl <= shamt & "10111";
			elsif funct_code = "100111" then  --nor
				o_aluctrl <= shamt & "01100";
			elsif funct_code = "100110" then --xor
				o_aluctrl <= shamt & "01000";
			elsif funct_code = "100101" then --or
				o_aluctrl <= shamt & "00001";
			elsif funct_code = "101010" then --slt
				o_aluctrl <= shamt & "00111";
			elsif funct_code = "000000" then --sll
				o_aluctrl <= shamt & "01001";
			elsif funct_code = "000010" then --srl
				o_aluctrl <= shamt & "01011";
			elsif funct_code = "000011" then --sra
				o_aluctrl <= shamt & "01110";
			elsif funct_code = "100010" then --sub
				o_aluctrl <= shamt & "00110";
			elsif funct_code = "100011" then --subu
				o_aluctrl <= shamt & "00110";
			elsif funct_code = "001000" then --jump register
				o_aluctrl <= shamt & "10100";
			else
				o_aluctrl <= "0000000000";
			end if;
		when others =>
			o_aluctrl <= shamt & alu_ctrl;


		end case;
	end process;
end behavior;
		