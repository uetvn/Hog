--------------------------------------------------------------------------------
-- Project name   : Multiplier
-- File name      : AdderN
-- Created date   :
-- Author         : Huy Hung Ho
-- Last modified  : !!DATE
-- Desc           :
--------------------------------------------------------------------------------

Library IEEE;
Use IEEE.std_logic_1164.all;
Use IEEE.numeric_std.all;

Entity AdderN is
	Generic (N:	integer := 4);
	Port(	A:	IN std_logic_vector(N-1 downto 0);
		B:	IN std_logic_vector(N-1 downto 0);
		S:	OUT std_logic_vector(N downto 0)
	    );
End AdderN;

Architecture Behavioral of AdderN is
Begin

	S <= std_logic_vector (('0' & UNSIGNED(A)) + UNSIGNED(B));

End Behavioral;
