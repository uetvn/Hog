--------------------------------------------------------------------------------
-- Project name   : Multiplier
-- File name      : RegN.vhd
-- Created date   :
-- Author         : Huy Hung Ho
-- Last modified  : !!DATE
-- Desc           :
--------------------------------------------------------------------------------

Library IEEE;
Use IEEE.std_logic_1164.all;

Entity RegN is
	Generic (N:	integer := 4);
	Port(	Din:	IN std_logic_vector(N-1 downto 0);
		Dout:	OUT std_logic_vector(N-1 downto 0);
		Clk:	IN std_logic;
		Load:	IN std_logic;
		Shift:	IN std_logic;
		Clear:	IN std_logic;
		Serln:	IN std_logic
	    );
End RegN;

Architecture Behavioral of RegN is
	Signal Dinternal:	std_logic_vector(N-1 downto 0);
Begin
	Process(Clk)
	Begin
		If (rising_edge(Clk)) then
			if (Clear = '1') then
				Dinternal <= (others => '0');
			elsif (Load = '1') then
				Dinternal <= Din;
			elsif (Shift = '1') then
				Dinternal <= Serln & Dinternal(N-1 downto 1);
			end if;
		End if;
	End process;

	Dout <= Dinternal;
End Behavioral;
