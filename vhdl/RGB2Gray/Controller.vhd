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
Use work.helper.all;

Entity Controlller is
	Port (
		Clk:	IN std_logic;
		Start:	IN std_logic;
		Done:	OUT std_logic;
		address_in:	INOUT addr_load;
		address_out:	INOUT addr_store;
		Load:	OUT std_logic;
		Store:	OUT std_logic;
		Shift:	OUT std_logic;
		HOG:	OUT std_logic
	);
End Controlller;

Architecture Behavioral of Controlller is
	Type	states is (HaltS, InitS, LoadS, StoreS, ShiftS, HOGS);
	Signal	state:	states := HaltS;
	Signal	CNT1:	unsigned(addr_width_single_ram-1 downto 0);
	Signal	CNT2:	unsigned(addr_width_dual_ram-1 downto 0);
Begin
	Load	<= '1' when state = LoadS	else '0';
	Store	<= '1' when state = StoreS	else '0';
	Shift	<= '1' when state = ShiftS	else '0';
	HOG	<= '1' when state = HOGS	else '0';

	Process(Clk)
	Begin
		if rising_edge(Clk) then
			Case state is
				when HaltS	=> if Start = '1' then
							state <= InitS;
						   end if;
				When InitS	=> state <= LoadS;
				when LoadS	=> state <= StoreS;
				when StoreS	=> state <= HOGS;
				when HOGS	=> state <= ShiftS;
				when ShiftS	=> if (CNT2 = Length_cell_extend) then
							state <= HaltS;
						   else
							state <= LoadS;
						   end if;
			end case;
		end if;
	End process;

	Process(clk)
	Begin
		if rising_edge(Clk) then
			if state = InitS then
				CNT2 <= to_unsigned(0, addr_width_dual_ram);
			elsif state = ShiftS then
				CNT2 <= CNT2 + 1;
			end if;
		end if;
	End process;
End Behavioral;

