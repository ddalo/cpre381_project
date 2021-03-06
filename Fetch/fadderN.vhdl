library IEEE;
use IEEE.std_logic_1164.all;

entity fadderN is
	generic(N : integer := 32);
	port(A	: in std_logic_vector(N-1 downto 0);
	     B	: in std_logic_vector(N-1 downto 0);
	     C	: in std_logic;
	     S	: out std_logic_vector(N-1 downto 0);
	     E	: out std_logic);
end fadderN;

architecture structural of fadderN is
	
	component fadder is
		port(A	: in std_logic;
	     		B	: in std_logic;
	     		C	: in std_logic;
	     		S	: out std_logic;
	     		E	: out std_logic);
	end component;

signal iC : std_logic_vector(N-1 downto 0);

begin
	-- Instantiate N fadder instances.
	G_Nbit_fadder: for i in 0 to N-1 generate
	
				IF1: if (i = 0) generate 
		fadderi: fadder port map (A	=> A(i), -- ith instance's data 0 input hooked up to ith data 0 input.
	    				  B	=> B(i),
	    				  C	=> C,
	     				  S	=> S(i),
	     				  E	=> iC(i));
				end generate IF1;

				IF2: if (i = (N-1)) generate
		fadderii: fadder port map (A	=> A(i), -- ith instance's data 0 input hooked up to ith data 0 input.
	    				  B	=> B(i),
	    				  C	=> iC(i-1),
	     				  S	=> S(i),
	     				  E	=> E);
				end generate IF2;
				IF3: if ((i < N-1) and (i > 0)) generate
		fadderiii: fadder port map (A	=> A(i), -- ith instance's data 0 input hooked up to ith data 0 input.
	    				  B	=> B(i),
	    				  C	=> iC(i-1),
	     				  S	=> S(i),
	     				  E	=> iC(i));
				end generate IF3;
	

	end generate G_Nbit_fadder;

end structural;