library IEEE;
use IEEE.std_logic_1164.all;

entity ctrl_main is

  port(opcode           : in std_logic_vector(5 downto 0);
       reg_dst 		: out std_logic;
       alu_src 		: out std_logic;
       mem_to_reg 	: out std_logic;
       reg_write        : out std_logic;
       mem_write 	: out std_logic;
       branch 		: out std_logic;
       jump 		: out std_logic;
       halt		: out std_logic;
       alu_ctrl 	: out std_logic_vector(4 downto 0));

end ctrl_main;

architecture instruction of ctrl_main is
begin
op : process(opcode)
begin
	case(opcode) is 
		when "000000" => --"000000" op codes also known as instruction name to binary translation
			reg_dst <= '1';
			alu_src <= '0';
			mem_to_reg <= '0';
			reg_write <= '1';
			mem_write <= '0';
			branch <= '0';
			jump <= '0';
			halt <= '0';
			alu_ctrl <= "00000";
		when "001000" => --addi
			reg_dst <= '0';
			alu_src <= '1';
			mem_to_reg <= '0';
			reg_write <= '1';
			mem_write <= '0';
			branch <= '0';
			jump <= '0';
			halt <= '0';
			alu_ctrl <= "00010";
		when "001001" => --addiu
			reg_dst <= '0';
			alu_src <= '1';
			mem_to_reg <= '0';
			reg_write <= '1';
			mem_write <= '0';
			branch <= '0';
			jump <= '0';
			halt <= '0';
			alu_ctrl <= "00010";
		when "001100" => --andi
			reg_dst <= '0';
			alu_src <= '1';
			mem_to_reg <= '0';
			reg_write <= '1';
			mem_write <= '0';
			branch <= '0';
			jump <= '0';
			halt <= '0';
			alu_ctrl <= "10111";
		when "001111" => --lui
			reg_dst <= '0';
			alu_src <= '1';
			mem_to_reg <= '0';
			reg_write <= '1';
			mem_write <= '0';
			branch <= '0';
			jump <= '0';
			halt <= '0';
			alu_ctrl <= "01111";
		when "100011" => --lw
			reg_dst <= '0';
			alu_src <= '1';
			mem_to_reg <= '1';
			reg_write <= '1';
			mem_write <= '0';
			branch <= '0';
			jump <= '0';
			halt <= '0';
			alu_ctrl <= "00010";
		when "001110" => --xori
			reg_dst <= '0';
			alu_src <= '1';
			mem_to_reg <= '0';
			reg_write <= '1';
			mem_write <= '0';
			branch <= '0';
			jump <= '0';
			halt <= '0';
			alu_ctrl <= "01000";
		when "001101" => --ori
			reg_dst <= '0';
			alu_src <= '1';
			mem_to_reg <= '0';
			reg_write <= '1';
			mem_write <= '0';
			branch <= '0';
			jump <= '0';
			halt <= '0';
			alu_ctrl <= "00001";
		when "001010" => --slti
			reg_dst <= '0';
			alu_src <= '1';
			mem_to_reg <= '0';
			reg_write <= '1';
			mem_write <= '0';
			branch <= '0';
			jump <= '0';
			halt <= '0';
			alu_ctrl <= "00111";
		when "101011" => --sw
			reg_dst <= '0';
			alu_src <= '1';
			mem_to_reg <= '0';
			reg_write <= '0';
			mem_write <= '1';
			branch <= '0';
			jump <= '0';
			halt <= '0';
			alu_ctrl <= "00010";
		when "000100" => --beq
			reg_dst <= '0';
			alu_src <= '0';
			mem_to_reg <= '0';
			reg_write <= '0';
			mem_write <= '0';
			branch <= '1';
			jump <= '0';
			halt <= '0';
			alu_ctrl <= "10000";
		when "000101" => --bne
			reg_dst <= '0';
			alu_src <= '0';
			mem_to_reg <= '0';
			reg_write <= '0';
			mem_write <= '0';
			branch <= '1';
			jump <= '0';
			halt <= '0';
			alu_ctrl <= "10001";
		when "000010" => -- jump
			reg_dst <= '0';
			alu_src <= '0';
			mem_to_reg <= '0';
			reg_write <= '0';
			mem_write <= '0';
			branch <= '0';
			jump <= '1';
			halt <= '0';
			alu_ctrl <= "10010";
		when "000011" => -- jump and link
			reg_dst <= '0';
			alu_src <= '0';
			mem_to_reg <= '0';
			reg_write <= '1';  -- $31 only
			mem_write <= '0';
			branch <= '0';
			jump <= '1';
			halt <= '0';
			alu_ctrl <= "10011";
		when "011111" => -- repl.qb
			reg_dst <= '1';
			alu_src <= '1';
			mem_to_reg <= '0';
			reg_write <= '1';
			mem_write <= '0';
			branch <= '0';
			jump <= '1';
			halt <= '0';
			alu_ctrl <= "10101";
		when "010100" => -- HALT
			reg_dst <= '0';
			alu_src <= '0';
			mem_to_reg <= '0';
			reg_write <= '0';
			mem_write <= '0';
			branch <= '0';
			jump <= '0';
			halt <= '1';
			alu_ctrl <= "00000";
		when others => --  manages all other cases not implemented
			reg_dst <= '0';
			alu_src <= '0';
			mem_to_reg <= '0';
			reg_write <= '0';
			mem_write <= '0';
			branch <= '0';
			jump <= '0';
			halt <= '0';
			alu_ctrl <= "00000";
		end case;
	end process;
end instruction;