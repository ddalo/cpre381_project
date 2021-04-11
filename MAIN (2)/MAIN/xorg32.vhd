

library IEEE;
use IEEE.std_logic_1164.all;

entity xorg32 is

  port(i_A          : in std_logic_vector(31 downto 0);
       i_B          : in std_logic_vector(31 downto 0);
       o_F          : out std_logic_vector(31 downto 0));

end xorg32;

architecture dataflow of xorg32 is
begin

  o_F <= i_A xor i_B;
  
end dataflow;
