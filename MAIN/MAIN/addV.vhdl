library IEEE;
use IEEE.std_logic_1164.all;

entity addV is
  generic(N : integer := 32);
  port(
       iA               : in std_logic_vector(27 downto 0);
       iB               : in std_logic_vector(3 downto 0);
       oC               : out std_logic_vector(N-1 downto 0));

end addV;

architecture behavior of addV is
begin
 
	   oC <= iA & iB;

  
end behavior;
