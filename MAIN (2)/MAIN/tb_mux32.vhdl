library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.array32.all;

entity tb_mux32 is
  generic(gCLK_HPER   : time := 50 ns);
end tb_mux32;

architecture behavior of tb_mux32 is
  -- Calculate the clock period as twice the half-period
  constant cCLK_PER  : time := gCLK_HPER * 2;
  
	
	component mux32
  		generic (N : integer := 32);
  		port(    iD          : array32;
      			 iSEL        : in std_logic_vector(4 downto 0);
       			 oD          : out std_logic_vector(31 downto 0));
	end component;

  -- Temporary signals to connect to the register component.
 signal s_D : array32;
 signal s_SEL : std_logic_vector(4 downto 0);
 signal s_Q : std_logic_vector(31 downto 0);

begin
	
	DUT: mux32

	port map(iD => s_D,
		 iSEL => s_SEL,
		 oD => s_Q);

  -- Testbench process  
  P_TB: process
  begin
    -- SEL register 2  and Value 0 to output 
    s_SEL  <= "00001";
    s_D(2) <= "00000000000000000000000000000000";
    wait for cCLK_PER;
  
  wait;
  end process;
  
end behavior;