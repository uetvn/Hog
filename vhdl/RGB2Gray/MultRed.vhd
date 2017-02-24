--------------------------------------------------------------------------------
-- Project name   : LSI Contest 2017
-- File name      : MultRed.vhd
-- Created date   : Thứ sáu, 24 Tháng hai Năm 2017 12:05:44 ICT
-- Author         : Huy Hung Ho
-- Last modified  : Thứ sáu, 24 Tháng hai Năm 2017 15:27:35 ICT
-- Desc           :
--	YR:	19595:	0100110010001011
--	YG:	7471:	0001110100101111
--	YB:	38470:	1001011001000110
--	AdderRed
--	= Data<<14 + Data<<11 + Data<<10 + Data<<7 + Data<<3 + Data<<1 + Data;
--------------------------------------------------------------------------------

Library IEEE;
Use IEEE.std_logic_1164.all;

Entity MultRed is
	Port (	Clk:	IN std_logic;
		Data:	IN std_logic_vector(7 downto 0);
		Result:	OUT std_logic_vector(7 downto 0)
	);
End MultRed;

Architecture Behavioral of MultRed is
	Component AdderNbit is
		Generic (N:	integer := 32);
		Port (	a, b:	IN STD_LOGIC_VECTOR (N - 1  downto 0);
			Cin:	IN STD_LOGIC;
			S:      OUT STD_LOGIC_VECTOR (N - 1 downto 0);
			Cout:   OUT STD_LOGIC
		);
	End component;

	Signal	Cin:	std_logic := '0';
	Signal	Cout:	std_logic := '0';
	Signal	In1, In2, In3, In4:	std_logic_vector(31 downto 0);
	Signal	In5, In6, In7:		std_logic_vector(31 downto 0);
	Signal	Out1, Out2, Out3:	std_logic_vector(31 downto 0);
	Signal	Out4, Out5, Out6:	std_logic_vector(31 downto 0);
Begin
	In1 <= "0000000000" & Data & "00000000000000";
	In2 <= "0000000000000" & Data & "00000000000";
	In3 <= "00000000000000" & Data & "0000000000";
	In4 <= "00000000000000000" & Data & "0000000";
	In5 <= "000000000000000000000" & Data & "000";
	In6 <= "00000000000000000000000" & Data & "0";
	In7 <= "000000000000000000000000" & Data     ;

	F1:	AdderNbit generic map(32)
		port map (	a => In1,
			  	b => In2,
				Cin => Cin,
				S => Out1,
				Cout => Cout
		);

	F2:	AdderNbit generic map(32)
		port map (	a => In3,
			  	b => In4,
				Cin => Cin,
				S => Out2,
				Cout => Cout
		);

	F3:	AdderNbit generic map(32)
		port map (	a => In5,
			  	b => In6,
				Cin => Cin,
				S => Out3,
				Cout => Cout
		);

	F4:	AdderNbit generic map(32)
		port map (	a => Out1,
			  	b => Out2,
				Cin => Cin,
				S => Out4,
				Cout => Cout
		);

	F5:	AdderNbit generic map(32)
		port map (	a => In7,
			  	b => Out3,
				Cin => Cin,
				S => Out5,
				Cout => Cout
		);

	F6:	AdderNbit generic map(32)
		port map (	a => Out4,
			  	b => Out5,
				Cin => Cin,
				S => Out6,
				Cout => Cout
		);

	Result <= Out6(23 downto 16);
End Behavioral;

