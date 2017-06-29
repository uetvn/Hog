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

Entity DLatch is
	Generic (	N:	integer	:= 8);
	Port (	Clk:	IN std_logic;
		En:	IN std_logic;
		Din:	IN std_logic_vector(N - 1 downto 0);
		Dout:	OUT std_logic_vector(N - 1 downto 0)
	);
End DLatch;

Architecture Behavioral of DLatch is
	Signal Data:	std_logic_vector(N - 1 downto 0);
Begin
	Data <= Din when (En = '1')
		else Data;
	Dout <= Data;
End Behavioral;
