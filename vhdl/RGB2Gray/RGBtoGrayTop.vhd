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
	Signal	address_in:	addr_load;
	Signal	address_out:	addr_store;
	Signal	address_HOG:	addr_store;

	Signal Load, Store, Shift, HOG:	std_logic;
Begin
	Main:	RGB2Gray
		port map (Clk, red, green, blue, gray);

	GetIn:	single_ram generic map (8, 10)
		port map (address_in, red, green, blue, Load, '0', '1');

	GetOut:	dual_ram generic map (8, 10)
		port map (address_out, gray, Store, '1', '0',
			  	address_HOG, gray, HOG, '0', '1');

	Control: Controller
		port map (Clk, Start, Done, address_in, address_out,
				Load, Store, Shift, HOG);

	address_in <= address_in + const_shift_in when Shift = '1';
	address_out <= address_out + const_shift_out when Shift = '1';
End Behavioral;
