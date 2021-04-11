library IEEE;
use IEEE.std_logic_1164.all;

entity invg32 is

  port(i_A          : in std_logic_vector(31 downto 0);
       o_F          : out std_logic_vector(31 downto 0));

end invg32;

architecture dataflow of invg32 is
begin

  o_F <= not i_A;
  
end dataflow;
