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

Entity Comparator is
	Generic (	N:	integer := 8);
	Port (	Reset:	IN std_logic;
		Din1:	IN std_logic_vector(N - 1 downto 0);
	     	Din2:	IN std_logic_vector(N - 1 downto 0);
		Dout:	OUT std_logic
	);
End Comparator;

Architecture Behavioral of Comparator is
Begin
	Dout <= '1' when (Din1 = Din2) and Reset = '0'
		else '0';
End Behavioral;
