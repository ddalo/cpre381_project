library IEEE;
use IEEE.std_logic_1164.all;

entity AddSub is
generic(N : integer := 32);
port(A1          : in std_logic_vector(N-1 downto 0);
     B1       : in std_logic_vector(N-1 downto 0);
     nAS   : in std_logic;
     o_F        : out std_logic_vector(N-1 downto 0);
     o_C        : out std_logic);

end AddSub;

architecture structural of AddSub is

component mux2t1_N is
  generic(N : integer);
  port(i_D0          : in std_logic_vector(N-1 downto 0);
       i_D1          : in std_logic_vector(N-1 downto 0);
       i_S          : in std_logic;
       o_O          : out std_logic_vector(N-1 downto 0));

end component;

component onecomp is
  generic(N : integer);
  port(i_A  : in std_logic_vector(N-1 downto 0);
       o_F  : out std_logic_vector(N-1 downto 0));

end component;

component fadderN is
  generic(N : integer);
  port(A          : in std_logic_vector(N-1 downto 0);
       B          : in std_logic_vector(N-1 downto 0);
       C          : in std_logic;
       S          : out std_logic_vector(N-1 downto 0);
       E          : out std_logic);

end component;

signal s1 : std_logic_vector(N-1 downto 0);
signal t_a : std_logic_vector(N-1 downto 0);

begin

invert : onecomp
  generic map(N=>N)
  port map(i_A => B1,
           o_F => s1);

mux : mux2t1_N
  generic map(N=>N)
  port map(i_D0 => B1,
           i_D1 => s1,
           i_S => nAS,
           o_O => t_a);

adder : fadderN
  generic map(N=>N)
  port map(A => A1,
           B => t_a,
           C => nAS,
           S => o_F,
           E => o_C);

end structural;