--------------------------------------------------------------------------------
-- Project name   : LSI contest 2017
-- File name      : RGB2Gray.vhd
-- Created date   : Wed 22 Feb 2017
-- Author         : Huy Hung Ho
-- Last modified  : Mon 27 Feb 2017
-- Desc           :
--------------------------------------------------------------------------------

Library IEEE;
Use IEEE.std_logic_1164.all;
Use IEEE.numeric_std.all;

Entity RGB2Gray is
	Port (
		Clk:		IN std_logic;
		Data1:		IN std_logic_vector(7 downto 0);
		Data2:		IN std_logic_vector(7 downto 0);
		Data3:		IN std_logic_vector(7 downto 0);
		Product:	OUT std_logic_vector(7 downto 0)
	);
End RGB2Gray;

Architecture Behavioral of RGB2Gray is
	Use work.rgb2gray_components.all;
	Constant Bias: std_logic_vector(31 downto 0) :=
	std_logic_vector(to_unsigned(32768, 32));

	Signal	Mout1, Mout2, Mout3:	std_logic_vector(31 downto 0);
	Signal	Temp1, Temp2, Temp3:	std_logic_vector(31 downto 0);
	Signal	C:	std_logic_vector(0 to 2);
Begin
	R: MultRed
		port map (Clk, Data1, Mout1);

	G: MultGreen
		port map (Clk, Data2, Mout2);

	B: MultBlue
		port map (Clk, Data3, Mout3);

	A1: AdderNbit generic map (32)
		port map (Mout1, Mout2, '0', Temp1, C(0));

	A2: AdderNbit generic map (32)
		port map (Mout3, Bias, '0', Temp2, C(1));

	A3: AdderNbit generic map (32)
		port map (Temp1, Temp2, '0', Temp3, C(2));

	Product <= Temp3(23 downto 16);
End Behavioral;
