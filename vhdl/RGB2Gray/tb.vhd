--------------------------------------------------------------------------------
-- Project name   : LSI Contest 2017
-- File name      : tb.vhd
-- Created date   : Mon 27 Feb 2017
-- Author         : Huy Hung Ho
-- Last modified  : Mon 27 Feb 2017
-- Desc           :
--------------------------------------------------------------------------------

Library IEEE;
Use IEEE.std_logic_1164.all;
Use IEEE.numeric_std.all;

Entity tb is
End tb;

Architecture Behavioral of tb is
	Component RGB2Gray is
        Port (
                Clk:            IN std_logic;
                Data1:          IN std_logic_vector(7 downto 0);
                Data2:          IN std_logic_vector(7 downto 0);
                Data3:          IN std_logic_vector(7 downto 0);
                Product:        OUT std_logic_vector(7 downto 0)
        );
	End component;

	Signal	Clk:	std_logic;
	Signal period:	time := 1 ns;
	Signal	Data1, Data2, Data3:	std_logic_vector(7 downto 0);
	Signal	Product:		std_logic_vector(7 downto 0);
Begin
	uut:	RGB2Gray
		port map (	Clk => Clk,
				Data1 => Data1,
				Data2 => Data2,
				Data3 => Data3,
				Product => Product
		);

	-- Clock process definitions
	Clock: Process
	Begin
		Clk <= '0';
		wait for period/2;
		Clk <= '1';
		wait for period/2;
	End process Clock;

	Main:	process
	Begin
		wait for 10 ns;
		Data1 <= std_logic_vector(to_unsigned(0, 8));
		Data2 <= std_logic_vector(to_unsigned(0, 8));
		Data3 <= std_logic_vector(to_unsigned(0, 8));

		wait for 10 ns;
		Data1 <= std_logic_vector(to_unsigned(255, 8));
		Data2 <= std_logic_vector(to_unsigned(255, 8));
		Data3 <= std_logic_vector(to_unsigned(255, 8));

		wait for 10 ns;
		Data1 <= std_logic_vector(to_unsigned(50, 8));
		Data2 <= std_logic_vector(to_unsigned(10, 8));
		Data3 <= std_logic_vector(to_unsigned(240, 8));

		wait for 10 ns;
		Data1 <= std_logic_vector(to_unsigned(200, 8));
		Data2 <= std_logic_vector(to_unsigned(100, 8));
		Data3 <= std_logic_vector(to_unsigned(17, 8));

		wait;
	End process;
End Behavioral;

