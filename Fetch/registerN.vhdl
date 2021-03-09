library IEEE;
use IEEE.std_logic_1164.all;

entity registerN is
  generic (N : integer := 32);
  port (iRST, iLD, iCLK : in std_logic;
        iA : in std_logic_vector(N-1 downto 0);
        oA : out std_logic_vector(N-1 downto 0));
end registerN;

architecture structural of registerN is

component dff is
  port(i_CLK        : in std_logic;     -- Clock input
       i_RST        : in std_logic;     -- Reset input
       i_WE         : in std_logic;     -- Write enable input
       i_D          : in std_logic;     -- Data value input
       o_Q          : out std_logic);   -- Data value output
end component;

begin

G1: for i in N-1 downto 0 generate
begin
reg : dff
  port map(i_CLK => iCLK,
   	   i_RST => iRST,
           i_WE => iLD,
           i_D => iA(i),
           o_Q => oA(i));
end generate;

end structural;