--------------------------------------------------------------------------------
-- Project name   : Multiplier
-- File name      : mult_components.vhd
-- Created date   : !!DATE
-- Author         : Huy Hung Ho
-- Last modified  : !!DATE
-- Desc           :
--------------------------------------------------------------------------------

Library IEEE;
Use IEEE.std_logic_1164.all;

Package mult_components is
	Component Controller is
		Generic (N:     integer := 2);
		        Port(   Clk:    IN std_logic;
			        Q0:     IN std_logic;
		                Start:  IN std_logic;
		                Load:   OUT std_logic;
		                Shift:  OUT std_logic;
		                AddA:   OUT std_logic;
		                Done:   OUT std_logic
			);
	End component;

	Component AdderN is
		Generic (N:     integer := 4);
	        Port(   A:      IN std_logic_vector(N-1 downto 0);
		        B:      IN std_logic_vector(N-1 downto 0);
			S:      OUT std_logic_vector(N downto 0)
		);
	End component;

	Component RegN is
		Generic (N:     integer := 4);
		Port(   Din:    IN std_logic_vector(N-1 downto 0);
		        Dout:   OUT std_logic_vector(N-1 downto 0);
		        Clk:    IN std_logic;
		        Load:   IN std_logic;
		        Shift:  IN std_logic;
		        Clear:  IN std_logic;
		        Serln:  IN std_logic
		);
	End component;
End mult_components;

