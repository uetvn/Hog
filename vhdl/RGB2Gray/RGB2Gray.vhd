--------------------------------------------------------------------------------
-- Project name   : LSI contest 2017
-- File name      : RGB2Gray.vhd
-- Created date   : Thứ sáu, 24 Tháng hai Năm 2017 12:54:48 ICT
-- Author         : Huy Hung Ho
-- Last modified  : Thứ sáu, 24 Tháng hai Năm 2017 13:48:07 ICT
-- Desc           :
--------------------------------------------------------------------------------

Library IEEE;
Use IEEE.std_logic_1164.all;

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

	Signal	Mout1, Mout2, Mout3:	std_logic_vector(7 downto 0);
	Signal	Temp:	std_logic_vector(7 downto 0) := (others => '0');
	Signal	Cin:	std_logic := '0';
	Signal	Cout:	std_logic := '0';
Begin
	R: MultRed
		port map (Clk, Data1, Mout1);

	G: MultGreen
		port map (Clk, Data2, Mout2);

	B: MultBlue
		port map (Clk, Data3, Mout3);

	A1: AdderNbit generic map (8)
		port map (Mout1, Mout2, Cin, Temp, Cout);

	A2: AdderNbit generic map (8)
		port map (Mout3, Temp, Cin, Product, Cout);
End Behavioral;
