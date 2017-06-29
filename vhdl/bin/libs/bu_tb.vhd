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

Entity tb is
End tb;

Architecture Behavioral of tb is
	Component RGBtoGrayTop is
		Port (
			Clk:	IN std_logic;
			Start:	IN std_logic;
			Done:	OUT std_logic
		);
	End component;

	Signal	Clk, Start, Done:	std_logic;
	Signal	period:			time := 1 ns;
Begin
	uut:	RGBtoGrayTop
		port map (Clk, Start, Done);

	-- Clock process definitions
	Clock: Process
	Begin
		Clk <= '0';
		wait for period/2;
		Clk <= '1';
		wait for period/2;
	End process;

	-- Read output
	Read: process
	Begin
		wait for period * 5;
		Start <= '1';
		wait until Done = '1';
	end process;
End Behavioral;
