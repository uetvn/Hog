--------------------------------------------------------------------------------
-- Project name   : LSI Contest 2017
-- File name      : AdderNbit.vhd
-- Created date   : Thứ sáu, 24 Tháng hai Năm 2017 13:44:20 ICT
-- Author         : Huy Hung Ho
-- Last modified  : Thứ sáu, 24 Tháng hai Năm 2017 14:48:17 ICT
-- Desc           :
--------------------------------------------------------------------------------

Library IEEE;
Use IEEE.std_logic_1164.all;

entity AdderNbit is
	Generic (N:	integer := 32);
	Port (	a, b:	IN STD_LOGIC_VECTOR (N - 1 downto 0);
		Cin:	IN STD_LOGIC;
		S:	OUT STD_LOGIC_VECTOR (N - 1 downto 0);
		Cout:	OUT STD_LOGIC);
end AdderNbit;

Architecture Behavioral of AdderNbit is
	Component FullAdder is
        Port (  a, b, Cin:      IN std_logic;
                S, Cout:        OUT std_logic
        );
	End component;

	Signal	C:	std_logic_vector(N - 2 downto 0);
Begin
	F1: FullAdder
		port map( a => a(0), b => b(0), Cin => Cin, S => S(0), Cout => C(0));

	FN: For i in 1 to N - 2 generate
		Fi: FullAdder
			port map( a => a(i), b => b(i), Cin => C(i - 1), S => S(i), Cout => C(i));
	End generate;

	FE: FullAdder
		port map( a => a(N - 1), b => b(N - 1), Cin => C(N - 2), S => S(N - 1), Cout => Cout);
End Behavioral;
