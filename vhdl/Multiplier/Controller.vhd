--------------------------------------------------------------------------------
-- Project name   : Multiplier
-- File name      : Controller.vhd
-- Created date   :
-- Author         : Huy Hung Ho
-- Last modified  : !!DATE
-- Desc           :
--------------------------------------------------------------------------------

Library IEEE;
Use IEEE.std_logic_1164.all;
Use IEEE.numeric_std.all;

Entity Controller is
	Generic (N:	integer := 2);
	Port(	Clk:	IN std_logic;
		Q0:	IN std_logic;
		Start:	IN std_logic;
		Load:	OUT std_logic;
		Shift:	OUT std_logic;
		AddA:	OUT std_logic;
		Done:	OUT std_logic
	    );
End Controller;

Architecture Behavioral of Controller is
	Type	states is (HaltS, InitS, QtempS, AddS, ShiftS);
	Signal	state:	states	:= HaltS;
	Signal	CNT:	UNSIGNED(N-1 downto 0);
Begin
	Done <= '1' when state = HaltS else '0';
	Load <= '1' when state = InitS else '0';
	AddA <= '1' when state = AddS else '0';
	Shift <= '1' when state = ShiftS else '0';

	Process(Clk)
	Begin
		If rising_edge(Clk) then
			Case state is
				when HaltS	=> if Start = '1' then
							state <= InitS;
						end if;
				when InitS	=> state <= QtempS;
				when QtempS	=> if (Q0 = '1') then
							state <= AddS;
						else
							state <= ShiftS;
						end if;
				when AddS	=> state <= ShiftS;
				when ShiftS	=> if (CNT = 2**N - 1) then
							state <= HaltS;
						else
							state <= QtempS;
						end if;
			End case;
		End if;
	End process;

	Process(Clk)
	Begin
		If rising_edge(Clk) then
			if state = InitS then
				CNT <= to_unsigned(0, N);
			elsif state = ShiftS then
				CNT <= CNT + 1;
			end if;
		End if;
	End process;
End Behavioral;
