--------------------------------------------------------------------------------
-- Project name   : LSI Contest 2017
-- File name      : Controller.vhd
-- Created date   : Mon 13 Mar 2017
-- Author         : Huy Hung Ho
-- Last modified  : Mon 13 Mar 2017
-- Desc           :
--------------------------------------------------------------------------------

Library IEEE;
Use IEEE.std_logic_1164.all;
Use IEEE.numeric_std.all;
Use work.ram_pkg.all;
Use work.include.all;

Entity Controller is
	Port (
		Clk:	IN std_logic;
		Start:	IN std_logic;
		Done:	OUT std_logic;
		LoadR:	OUT std_logic;
		LoadG:	OUT std_logic;
		LoadB:	OUT std_logic;
		StoreY: OUT std_logic;
		Move:	OUT std_logic
	);
End Controller;

Architecture Behavioral of Controller is
	Type	states is (HaltS, LoadRS, LoadGS, LoadBS, StoreS);
	Signal	state:	states := HaltS;
	Signal	CNT:	unsigned(addr_width-1 downto 0);
Begin
	Done	<= '1' when state = HaltS	else '0';
	LoadR	<= '1' when state = LoadRS	else '0';
	LoadG	<= '1' when state = LoadGS	else '0';
	LoadB	<= '1' when state = LoadBS	else '0';
	StoreY	<= '1' when state = StoreS	else '0';

	Process(Clk)
	Begin
		if rising_edge(Clk) then
			Case state is
				when HaltS	=> if Start = '1' then
							state <= LoadRS;
						   end if;
				when LoadRS	=> state <= LoadGS;
				when LoadGS	=> state <= LoadBS;
				when LoadBS	=> state <= StoreS;
				when StoreS	=> if (CNT = Cell_extend_width)
						then
							state <= HaltS;
						else
							state <= LoadRS;
						end if;
			end case;
		end if;
	End process;

	Process(clk)
	Begin
		if rising_edge(Clk) then
			if state = HaltS then
				CNT <= to_unsigned(0, addr_width);
			elsif state = StoreS then
				CNT <= CNT + 1;
			end if;
		end if;
	End process;
End Behavioral;

