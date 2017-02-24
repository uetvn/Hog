--------------------------------------------------------------------------------
-- Project name   : LSI Contest 2017
-- File name      : FullAdder.vhd
-- Created date   : Thứ sáu, 24 Tháng hai Năm 2017 13:44:30 ICT
-- Author         : Huy Hung Ho
-- Last modified  : Thứ sáu, 24 Tháng hai Năm 2017 13:44:30 ICT
-- Desc           :
--------------------------------------------------------------------------------
Library IEEE;
Use IEEE.std_logic_1164.all;

Entity FullAdder is
	Port (	a, b, Cin:	IN std_logic;
		S, Cout:	OUT std_logic
	);
End FullAdder;

Architecture Behavioral of FullAdder is
Begin
	S <= a xor b xor Cin;
	Cout <= (a and b) or (Cin and a) or (Cin and b);
end Behavioral;
