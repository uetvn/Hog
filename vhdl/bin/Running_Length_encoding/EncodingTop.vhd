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

Entity Encoding is
	Generic(	N:	integer := 8);
	Port (	Reset: 		IN std_logic;
		Clk:		IN std_logic;
		endData:	IN std_logic;
		Data:		IN std_logic_vector (N - 1 downto 0);
		Result:		OUT std_logic_vector (N - 1 downto 0);
		Done:		OUT std_logic
	);
End Encoding;

Architecture Behavioral of Encoding is
	Use work.encoding_components.all;
	Signal	Data1, Data2:	std_logic_vector (N - 1 downto 0);
	Signal	Count:		std_logic_vector (N - 1 downto 0);
	Signal	Muxin1, Muxin2:	std_logic_vector (N - 1 downto 0);
	Signal	isEqual:	std_logic;
	Signal	ctreg:		std_logic;
	Signal	ctCounter:	std_logic;
	Signal	Sel:		std_logic;
Begin
	Regis1:	Regis	generic map (N)
			port map (Clk, Data, '0', Data1);

	Regis2: Regis	generic map (N)
			port map (Clk, Data1, '0', Data2);

	Regis_1b: Regis1
			port map(Clk, ctreg, Sel);

	Counter: Regis	generic map (N)
			port map (Clk, ctCounter, '1', Count);

	Com: Comparator	generic map (N)
			port map (Reset, Data1, Data2, isEqual);

	C: Controller	generic map (N)
			port map (Reset, Clk, endData, isEqual, ctCounter, ctreg)

	L1: Latch	generic map (N)
			port map (Clk, ctreg, Data2, Muxin1);

	L2: Latch	generic map (N)
			port map (Clk, ctreg, Count, Muxin2);

	M: Multiplexer	generic map (N)
			port map (Clk, Sel, Muxin1, Muxin2, Result);
End Behavioral;
