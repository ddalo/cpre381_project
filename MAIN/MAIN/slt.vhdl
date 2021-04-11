library IEEE;
use IEEE.std_logic_1164.all;

entity slt is
  generic(N : integer := 32);
  port(       
       iB               : in std_logic;
       oC               : out std_logic_vector(N-1 downto 0));

end slt;

architecture behavior of slt is
begin
 
	   oC <= "0000000000000000000000000000000" & iB;

  
end behavior;
