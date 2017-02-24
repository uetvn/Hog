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

Entity Multiplexer is
	Generic (	N:	integer := 8);
	Port (	Clk:	IN std_logic;
		Sel:	IN std_logic;
		Din1:	IN std_logic_vector(N - 1 downto 0);
		Din2:	IN std_logic_vector(N - 1 downto 0);
		Dout:	OUT std_logic_vector(N - 1 downto 0)
	);
End Multiplexer;

Architecture Behavioral of Multiplexer is
Begin
	Dout <= Din1 when (Sel = '1') else
		Din2;
End Behavioral;
