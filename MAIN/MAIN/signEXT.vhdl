library IEEE;
use IEEE.std_logic_1164.all;

entity signEXT is

  port(alu_ctrl		: in std_logic_vector(4 downto 0);
       iEXT             : in std_logic_vector(15 downto 0);
       oEXT             : out std_logic_vector(31 downto 0);
       pcEXT		: out std_logic_vector(31 downto 0));

end signEXT;

architecture behavior of signEXT is
begin
op : process(alu_ctrl)
begin
	case(alu_ctrl) is 

		when "00001" => --ori
				oEXT <= "0000000000000000" & iEXT;
			if (iEXT(15) = '0') then
				pcEXT <= "0000000000000000" & iEXT;
			else
				pcEXT <= "1111111111111111" & iEXT;
			end if;
		when "10111" => --andi
				oEXT <= "0000000000000000" & iEXT;
			if (iEXT(15) = '0') then
				pcEXT <= "0000000000000000" & iEXT;
			else
				pcEXT <= "1111111111111111" & iEXT;
			end if;
		when "01111" => --lui
				oEXT <= iEXT & "0000000000000000";
			if (iEXT(15) = '0') then
				oEXT <= "0000000000000000" & iEXT;
				pcEXT <= "0000000000000000" & iEXT;
			else
				oEXT <= "1111111111111111" & iEXT;
				pcEXT <= "1111111111111111" & iEXT;
			end if;

		when others => -- cases where sign is being extended 
			if (iEXT(15) = '0') then
				oEXT <= "0000000000000000" & iEXT;
				pcEXT <= "0000000000000000" & iEXT;
			else
				oEXT <= "1111111111111111" & iEXT;
				pcEXT <= "1111111111111111" & iEXT;
			end if;

		end case;
	end process;
end behavior;