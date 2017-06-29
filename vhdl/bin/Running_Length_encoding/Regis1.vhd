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
	Port(	Clk:	IN std_logic;
		Din:	IN std_logic;
		Dout:	OUT std_logic
	    );
End Regis;

Architecture Behavioral of Regis is
	Signal Dinternal:	std_logic;
Begin
	Process(Clk)
	Begin
		if (rising_edge(Clk)) then
			Dinternal <= Din;
		end if;
	End process;

	Dout <= Dinternal;
End Behavioral;
