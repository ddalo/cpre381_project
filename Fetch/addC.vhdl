library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity addC is
  generic(N : integer := 32);
  port(
       iA               : in std_logic_vector(N-1 downto 0);
       iB               : in integer;
       oA               : out std_logic_vector(N-1 downto 0));

end addC;

architecture behavior of addC is
begin
  
 	oA <= iA + iB;
 
  
end behavior;