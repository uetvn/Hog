--------------------------------------------------------------------------------
-- Project name   : LSI contest 2017
-- File name      : RGB2Gray.vhd
-- Created date   : !!DATE
-- Author         : Huy Hung Ho
-- Last modified  : !!DATE
-- Desc           :
--------------------------------------------------------------------------------

Library IEEE;
Use IEEE.std_logic_1164.all;

Entity RGB2Gray is
	Port (
		Data:		IN std_logic_vector(7 downto 0);
		Product:	OUT std_logic_vector(7 downto 0);
		Start:		IN std_logic;
		Clk:		IN std_logic;
		Done:		OUT std_logic;
	);
End RGB2Gray;

Architecture Behavioral of RGB2Gray is
	Use work.rgb2gray_components.all;

	Constant	alpha	integer	:= 77;
	Constant	beta	integer := 150;
	Constant	gamma	integer := 29;
	Signal		factor	integer := 0;

	Signal	RegIn	std_logic_vector(7 downto 0);
	Signal	RegOut	std_logic_vector(7 downto 0);
	Signal	Mout	std_logic_vector(15 downto 0);
	Signal	Sout	std_logic_vector(7 downto 0);
	Signal	Aout	std_logic_vector(7 downto 0);

	Signal	Load	std_logic;
	Signal	Add	std_logic;
	Signal	counter	std_logic_vector(1 downto 0);
	Signal	DoneMul	std_logic;
Begin
	Rin:	Regis
			port map (Clk, Start, Data, RegIn);
	Rout:	Regis
			port map (Clk, Start, Sout, Aout, Add);

	C: Controller
			port map(Clk, Start, factor, counter, Load, Add);

	M:	Multiplexer
			port map (RegIn, factor, Mout, Start, DoneMul);

	S:	Shift
			port map (Clk, Mout, Sout);

	Done <= Aout;
End Behavioral;
