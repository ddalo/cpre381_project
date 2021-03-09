library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity addC is
  generic(N : integer := 32);
  port(iCLK             : in std_logic;
       iA               : in std_logic_vector(N-1 downto 0);
       iB               : in integer;
       oA               : out std_logic_vector(N-1 downto 0));

end addC;

architecture behavior of addC is
begin

  process(iCLK, iA, iB)
  begin
    if rising_edge(iCLK) then
	   oA <= iA + iB;
    end if;
  end process;
  
end behavior;