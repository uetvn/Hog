--------------------------------------------------------------------------------
-- Project name   : LSI Contest 2017
-- File name      : RGBtoGrayTop.vhd
-- Created date   : Mon 13 Mar 2017
-- Author         : Huy Hung Ho
-- Last modified  : Fri 17 Mar 2017
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

	Signal	address_0, address_1:			addr_type;
	Signal	data_0, data_1:				byte;
	Signal	cs_0, cs_1, we_0, we_1, oe_0, oe_1:	std_logic;

	Signal	red:	byte;
	Signal	green:	byte;
	Signal	blue:	byte;
	Signal	gray:	byte;
	Signal	addr_load:	unsigned(addr_width-1 downto 0) := (others =>
		'0');
	Signal	addr_store:	unsigned(addr_width-1 downto 0) :=
		"100101100";
	Signal	LoadR, LoadG:		std_logic;
	Signal	LoadB, StoreY:		std_logic;
	Signal	Move:			std_logic;
Begin
	Main:	RGB2Gray
		port map (Clk, red, green, blue, gray);

	Ram:	Dual_ram generic map (addr_width)
		port map (address_0, data_0, cs_0, we_0, oe_0,
			address_1, data_1, cs_1, we_1, oe_1);

	Reg_R:	RegN generic map (data_width)
		port map (data_0, red, Clk, LoadR);

	Reg_G:	RegN generic map (data_width)
		port map (data_0, green, Clk, LoadG);

	Reg_B:	RegN generic map (data_width)
		port map (data_0, blue, Clk, LoadB);

	Ctrl:	Controller
		port map (Clk, Start, Done, LoadR, LoadG, LoadB, StoreY);

	data_0 <= gray when StoreY = '1' else (others => 'Z');

	cs_0		<= '1' when (LoadR or LoadG or LoadB or StoreY) = '1'
		 else '0';
	we_0		<= '1' when StoreY = '1' else '0';
	oe_0		<= '1' when (LoadR or LoadG or LoadB) = '1' else '0';
	address_0	<= std_logic_vector(addr_load) when LoadR = '1' else
		     	std_logic_vector(addr_load + 1) when LoadG = '1' else
			std_logic_vector(addr_load + 2) when LoadB = '1' else
			std_logic_vector(addr_store) when StoreY = '1';

	Process(Clk)
	Begin
		if rising_edge(Clk) then
			if Start = '0' then
				addr_load	<= to_unsigned(0, addr_width);
				addr_store	<= "100101100";
			elsif  StoreY = '1' then
				addr_load	<= addr_load + 3;
				addr_store	<= addr_store + 1;
			end if;
		end if;
	End process;
End Behavioral;
