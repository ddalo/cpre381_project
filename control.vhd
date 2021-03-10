-------------------------------------------------------------------------
-- Kasey Kellogg
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- control.vhd
-------------------------------------------------------------------------

-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;


entity control is

  port(instruct31_26            : in std_logic_vector(5 downto 0);
       reg_dst 		            : out std_logic;
       alu_src 		            : out std_logic;
       mem_to_reg 		        : out std_logic;
       reg_write                : out std_logic;
       mem_read 		        : out std_logic;
	   mem_write 		        : out std_logic;
	   branch 		            : out std_logic;
	   jump 		            : out std_logic;
       alu_op 		            : out std_logic_vector(5 downto 0));

end control;

architecture sel_when of control is
begin
op : process(instruct31_26)
begin
	case(instruct31_26) is 
		when "000000" => --"000000" op codes Instructions: add, addu, and, etc.
			reg_dst <= '1';
			alu_src <= '0';
			mem_to_reg <= '1';
			reg_write <= '1';
			mem_read <= '0';
			mem_write <= '0';
			branch <= '0';
			jump <= '0';
			alu_op <= "000000";
		when "001000" => --addi
			reg_dst <= '0';
			alu_src <= '0';
			mem_to_reg <= '1';
			reg_write <= '1';
			mem_read <= '0';
			mem_write <= '0';
			branch <= '0';
			jump <= '0';
			alu_op <= "001000";
		when "001001" => --addiu 
			reg_dst <= '0';
			alu_src <= '0';
			mem_to_reg <= '1';
			reg_write <= '1';
			mem_read <= '0';
			mem_write <= '0';
			branch <= '0';
			jump <= '0';
			alu_op <= "001001";
		when "001100" => --andi 
			reg_dst <= '0';
			alu_src <= '0';
			mem_to_reg <= '1';
			reg_write <= '1';
			mem_read <= '0';
			mem_write <= '0';
			branch <= '0';
			jump <= '0';
			alu_op <= "001100";
		when "001111" => --lui
			reg_dst <= '0';
			alu_src <= '0';
			mem_to_reg <= '1';
			reg_write <= '1';
			mem_read <= '0';
			mem_write <= '0';
			branch <= '0';
			jump <= '0';
			alu_op <= "001111";
		when "100011" => --lw
			reg_dst <= '0';
			alu_src <= '0';
			mem_to_reg <= '0';
			reg_write <= '1';
			mem_read <= '1';
			mem_write <= '0';
			branch <= '0';
			jump <= '0';
			alu_op <= "100011";
		when "100011" => --xori
			reg_dst <= '0';
			alu_src <= '0';
			mem_to_reg <= '1';
			reg_write <= '1';
			mem_read <= '0';
			mem_write <= '0';
			branch <= '0';
			jump <= '0';
			alu_op <= "100011";
		when "001101" => --ori
			reg_dst <= '0';
			alu_src <= '0';
			mem_to_reg <= '1';
			reg_write <= '1';
			mem_read <= '0';
			mem_write <= '0';
			branch <= '0';
			jump <= '0';
			alu_op <= "001101";
		when "001010" => --slti
			reg_dst <= '0';
			alu_src <= '0';
			mem_to_reg <= '1';
			reg_write <= '1';
			mem_read <= '0';
			mem_write <= '0';
			branch <= '0';
			jump <= '0';
			alu_op <= "001010";
		when "001010" => --sw
			reg_dst <= '0';
			alu_src <= '0';
			mem_to_reg <= '0';
			reg_write <= '0';
			mem_read <= '0';
			mem_write <= '1';
			branch <= '0';
			jump <= '0';
			alu_op <= "001010";
		when "000100" => --beq
			reg_dst <= '0';
			alu_src <= '0';
			mem_to_reg <= '0';
			reg_write <= '0';
			mem_read <= '0';
			mem_write <= '0';
			branch <= '1';
			jump <= '0';
			alu_op <= "000100";
		when "000101" => --bne NOT IMPLEMENTED
			reg_dst <= '0';
			alu_src <= '0';
			mem_to_reg <= '0';
			reg_write <= '0';
			mem_read <= '0';
			mem_write <= '0';
			branch <= '0';
			jump <= '0';
			alu_op <= "000101";
		when "000010" => --j
			reg_dst <= '0';
			alu_src <= '0';
			mem_to_reg <= '0';
			reg_write <= '0';
			mem_read <= '0';
			mem_write <= '0';
			branch <= '0';
			jump <= '1';
			alu_op <= "000010";
		when "000011" => --jal NOT IMPLEMENTED
			reg_dst <= '1';
			alu_src <= '0';
			mem_to_reg <= '0';
			reg_write <= '1';
			mem_read <= '0';
			mem_write <= '0';
			branch <= '0';
			jump <= '1';
			alu_op <= "000011";
		when others => --any other opcode
			reg_dst <= '0';
			alu_src <= '0';
			mem_to_reg <= '0';
			reg_write <= '0';
			mem_read <= '0';
			mem_write <= '0';
			branch <= '0';
			jump <= '0';
			alu_op <= "000000";
	end case;
end process;
end sel_when;
  
