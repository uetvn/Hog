--------------------------------------------------------------------------------
-- Project name   : LSI Contest 2017
-- File name      : tb.vhd
-- Created date   : Mon 27 Feb 2017
-- Author         : Huy Hung Ho
-- Last modified  : Tue 14 Mar 2017
-- Desc           :
--------------------------------------------------------------------------------

Library IEEE;
Use IEEE.std_logic_1164.all;
Use IEEE.numeric_std.all;
Use work.helper.all;

Entity tb is
End tb;

Architecture Behavioral of tb is
	Use work.ram_pkg.all;

	Component RGBtoGrayTop is
		Port (
			Clk:	IN std_logic;
			Start:	IN std_logic;
			Done:	OUT std_logic
		);
	End component;

	Signal	Clk, Start, Done:	std_logic;
	Signal	period:			time := 1 ns;

	Signal	data1, data2, data3:	byte := (others => '0');
	Signal	data1_next, data2_next, data3_next:	byte := (others => '0');
	Signal	Gray:			byte;
	Signal	address_in, in_next:		addr_load := (others => '0');
	Signal	address_out, out_next:		addr_store := (others => '0');
Begin
	uut:	RGBtoGrayTop
		port map (Clk, Start, Done);

	ram_in:	single_ram generic map (8, 10)
		port map (address_in, data1, data2, data3, '1', '1', '0');

	ram_out: dual_ram generic map (8, 10)
		port map (address_out, gray, '0', '0', '0', address_out, gray,
		'0', '0', '0');


	-- Clock process definitions
	Clock: Process
	Begin
		Clk <= '0';
		wait for period/2;
		Clk <= '1';
		wait for period/2;
	End process Clock;

	Set:	process (Clk)
	Begin
		if rising_edge(Clk) then
			data1_next <= std_logic_vector(unsigned(data1) + 1);
			data2_next <= std_logic_vector(unsigned(data2) + 1);
			data3_next <= std_logic_vector(unsigned(data3) + 1);

			in_next <= std_logic_vector(unsigned(address_in) + 1);
			out_next <= std_logic_vector(unsigned(address_out) + 1);
		end if;
	End process;

	data1 <= data1_next;
	data2 <= data2_next;
	data3 <= data3_next;
	address_in <= in_next;
	address_out <= out_next;

	Main: process
	Begin
		start <= '1';
		wait until Done='1';
	end process;

End Behavioral;
