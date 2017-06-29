--------------------------------------------------------------------------------
-- Project name   : LSI Contest 2017
-- File name      : include.vhd
-- Created date   : Mon 13 Mar 2017
-- Author         : Huy Hung Ho
-- Last modified  : Mon 13 Mar 2017
-- Desc           :
--------------------------------------------------------------------------------

Library IEEE;
Use IEEE.std_logic_1164.all;
Use IEEE.numeric_std.all;

Package include is
	Constant	cell_extend_width:	integer := 100;
	Constant	data_width:		integer := 8;
	Constant	addr_width:		integer := 9;

	Subtype		byte is std_logic_vector(data_width-1 downto 0);
	Subtype		addr_type is std_logic_vector(addr_width-1 downto 0);

	Component	RegN is
		generic (N: integer := 8);
		Port (
			Din:	IN std_logic_vector(N-1 downto 0);
			Dout:	OUT std_logic_vector(N-1 downto 0);
			Clk:	IN std_logic;
			Enable:	IN std_logic
		);
	End component;
End package;
