--------------------------------------------------------------------------------
-- Project name   :
-- File name      : !!FILE
-- Created date   : !!DATE
-- Author         : Huy Hung Ho
-- Last modified  : !!DATE
-- Desc           :
--------------------------------------------------------------------------------

Library IEEE;
Use IEEE.std_logic_1164.all;
Use IEEE.std_logic_unsigned.all;

Entity Regis is
	Generic(	N:	integer := 8);
	Port(	Clk:	IN std_logic;
		Din:	IN std_logic_vector(N - 1 downto 0);
		Add:	IN std_logic;
		Dout:	OUT std_logic_vector(N - 1 downto 0)
	    );
End Regis;

Architecture Behavioral of Regis is
	Signal Dinternal:	std_logic_vector(N - 1 downto 0);
Begin
	Process(Clk)
	Begin
		if (rising_edge(Clk)) then
			if (Add = '1') then
				Dinternal <= Dinternal + '1';
			else
				Dinternal <= Din;
			end if;
		end if;
	End process;

	Dout <= Dinternal;
End Behavioral;
