--------------------------------------------------------------------------------
-- Project name   : LSI Contest 2017
-- File name      : RGB2Gray_Top.vhd
-- Created date   :
-- Author         : Huy Hung Ho
-- Last modified  : !!DATE
-- Desc           :
--------------------------------------------------------------------------------

Library IEEE;
Use IEEE.std_logic_1164.all;
Use IEEE.numeric_std.all;
Use IEEE.helper.all;

Entity RGB2Gray is
	Generic(N:	integer	:= 8);
	Generic(2N:	integer := 16);
	Port (	Din:	IN RGB;
		Dout:	OUT Pixel
	);
End RGB2Gray_Top;

Architecture Behavioral of RGB2Gray is
	Constant	const_R_int:	integer := 77;
	Constant	const_G_int:	integer := 150;
	Constant	const_B_int:	integer := 29;
	Signal		const_R:	std_logic_vector(N-1 downto 0) :=
	to_unsigned(const_R_int);
	Signal		const_G:	std_logic_vector(N-1 downto 0) :=
	to_unsigned(const_G_int);
	Signal		cosnt_B:	std_logic_vector(N-1 downto 0) :=
	to_unsigned(const_B_int);

	Component MultTop is
	        Port(	Multiplier:     IN std_logic_vector(7 downto 0);
			Multiplicand:   IN std_logic_vector(7 downto 0);
		        Product:        OUT std_logic_vector(15 downto 0);
		        Start:          IN std_logic;
		        Clk:            IN std_logic;
		        Done:           OUT std_logic
		);
	End component;
	Signal	Dout0:	 std_logic_vector(2N-1 downto 0);
	Signal  Dout1:   std_logic_vector(2N-1 downto 0);
	Signal  Dout2:   std_logic_vector(2N-1 downto 0);
Begin
	Red:	MultTop
		Port map (Din.RGB(0), const_R, Dout0, Start, Clk, Done);
	Green:	MultTop
		Port map (Din.RGB(1), const_G, Dout1, Start, Clk, Done);
	Blue:	MultTop
		Port map (Din.RGB(2), const_B, Dout2, Start, Clk, Done);
	Adder:	AdderN generic map (8)
		Port map (const_R >> 8, const_G >> 8, tmp);
	Adder: AdderN generic map (8)
		Port map (tmp, const_B >> 8, result);
End Behavioral;
