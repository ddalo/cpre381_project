library IEEE;
use IEEE.std_logic_1164.all;

entity addV is
  generic(N : integer := 32);
  port(iCLK             : in std_logic;
       iA               : in std_logic_vector(N-1 downto 0);
       iB               : in std_logic_vector(N-1 downto 0);
       oC               : out std_logic_vector(N-1 downto 0));

end addV;

architecture behavior of addV is
begin

  process(iCLK, iA, iB)
  begin
    if rising_edge(iCLK) then
	   oC <= iA & iB;
    end if;
  end process;
  
end behavior;
