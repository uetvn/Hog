--------------------------------------------------------------------------------
-- Project name   : LSI Contest 2017
-- File name      : RGBtoGrayTop.vhd
-- Created date   : Mon 13 Mar 2017
-- Author         : Huy Hung Ho
-- Last modified  : Mon 13 Mar 2017
-- Desc           :
--------------------------------------------------------------------------------

Library IEEE;
Use IEEE.std_logic_1164.all;
Use IEEE.std_logic_unsigned.all;
Use IEEE.numeric_std.all;
Use work.helper.all;
Use work.ram_pkg.all;

Entity RGBtoGrayTop is
	Port (
		Clk:	IN std_logic;
		Start:	IN std_logic;
		Done:	OUT std_logic
	);
End RGBtoGrayTop;

Architecture Behavioral of RGBtoGrayTop is
	Use work.ram_pkg.all;
	Use work.RGBtoGray_pkg.all;

	Signal	red:	byte;
	Signal	green:	byte;
	Signal	blue:	byte;
	Signal	gray:	byte;
	Signal	address_0:	addr_type := (others => '0');
	Signal	address_1:	addr_type := "100101100";
	Signal	Load, Store, Shift:	std_logic;
Begin
	Main:	RGB2Gray
		port map (Clk, red, green, blue, gray);

	ram:	ram_rgb_gray generic map (addr_width)
		port map (address_0, red, green, blue, Load, '0', '1',
			  address_1, gray, Store, '1', '0');

	Ctrl:	Controller
		port map (Clk, Start, Done, Load, Store, Shift);

	address_0 <= std_logic_vector(unsigned(address_0) + 3) when Shift = '1';
	address_1 <= std_logic_vector(unsigned(address_1) + 1) when Shift = '1';
End Behavioral;
