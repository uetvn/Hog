--------------------------------------------------------------------------------
-- Project name   : Multiplier
-- File name      : MultTop
-- Created date   :
-- Author         : Huy Hung Ho
-- Last modified  : !!DATE
-- Desc           :
--------------------------------------------------------------------------------

Library IEEE;
Use IEEE.std_logic_1164.all;

Entity MultTop is
	Port(	Multiplier:	IN std_logic_vector(3 downto 0);
		Multiplicand:	IN std_logic_vector(3 downto 0);
		Product:	OUT std_logic_vector(7 downto 0);
		Start:		IN std_logic;
		Clk:		IN std_logic;
		Done:		OUT std_logic
	);
End MultTop;

Architecture Behavioral of MultTop is
	Use work.mult_components.all;

	Signal Mout, Qout:	std_logic_vector(3 downto 0);
	Signal Dout, Aout:	std_logic_vector(4 downto 0);
	Signal Load, Shift, AddA:	std_logic;
Begin
	C: Controller	generic map (2)
		Port map (Clk, Qout(0), Start, Load, Shift, AddA, Done);
	A: AdderN	generic map (4)
		Port map (Aout(3 downto 0), Mout, Dout);
	M: RegN		generic map (4)
		Port map (Multiplicand, Mout, Clk, Load, '0', '0', '0');
	Q: RegN		generic map (4)
		Port map (Multiplier, Qout, Clk, Load, Shift, '0', Aout(0));
	ACC: RegN	generic map (5)
		Port map (Dout, Aout, Clk, AddA, Shift, Load, '0');

	Product <= Aout(3 downto 0) & Qout;
End Behavioral;
