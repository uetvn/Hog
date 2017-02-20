--------------------------------------------------------------------------------
-- Project name   : Multiplier
-- File name      : tb.vhd
-- Created date   : !!DATE
-- Author         : Huy Hung Ho
-- Last modified  : !!DATE
-- Desc           :
--------------------------------------------------------------------------------

Library IEEE;
Use IEEE.std_logic_1164.all;
Use IEEE.numeric_std.all;
Use IEEE.std_logic_unsigned.all;

Entity Tb is
End Tb;

Architecture Behavioral of Tb is
	Component MultTop is
		Port(   Multiplier:     IN std_logic_vector(3 downto 0);
			Multiplicand:   IN std_logic_vector(3 downto 0);
		        Product:        OUT std_logic_vector(7 downto 0);
		        Start:          IN std_logic;
		        Clk:            IN std_logic;
		        Done:           OUT std_logic
		);
	End component;

	Signal	Multiplier:	std_logic_vector(3 downto 0) := (others => '0');
	Signal	Multiplicand:	std_logic_vector(3 downto 0) := (others => '0');
	Signal	Product:	std_logic_vector(7 downto 0) := (others => '0');
	Signal	Start:		std_logic := '0';
	Signal	Clk:		std_logic := '0';
	Signal	Done:		std_logic := '0';
	Constant	Clk_period:	time := 10 ns;
Begin
	Test: MultTop
		Port map (	Multiplier	=> Multiplier,
			 	Multiplicand	=> Multiplicand,
				Product		=> Product,
				Start		=> Start,
				Clk		=> Clk,
				Done		=> Done
		);

	Clk_process: Process
	Begin
		Clk <= '0';
		Wait for Clk_period/2;
		Clk <= '1';
		Wait for Clk_period/2;
	End process;


	Main_process: Process
	Begin
		For i in 15 downto 0 loop
			Multiplier <= std_logic_vector(to_unsigned(i, 4));
			for j in 15 downto 0 loop
				Multiplicand <= std_logic_vector(to_unsigned(j,
						4));
				Start <= '0', '1' after 5 ns, '0' after 40 ns;
				Wait for 50 ns;
				Wait until Done = '1';
				Assert (to_integer(UNSIGNED(Product)) = (i * j))
					report "Incorrect product" severity NOTE;
				Wait for 50 ns;
			end loop;
		End loop;
	End process;
End Behavioral;
