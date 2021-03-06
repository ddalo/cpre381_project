library IEEE;
use IEEE.std_logic_1164.all;

entity signE is

  port(
       iEXT          : in std_logic_vector(15 downto 0);
       oEXT          : out std_logic_vector(31 downto 0));

end signE;

architecture behavior of signE is
begin
process (iEXT)
begin	
	if (iEXT(15) = '0') then
		oEXT <= "0000000000000000" & iEXT;
	else
		oEXT <= "1111111111111111" & iEXT;
	end if;

end process;
end behavior;