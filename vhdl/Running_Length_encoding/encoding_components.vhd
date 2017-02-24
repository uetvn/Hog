--------------------------------------------------------------------------------
-- Project name   :
-- File name      : !!FILE
-- Created date   : !!DATE
-- Author         : Huy Hung Ho
-- Last modified  : !!DATE
-- Desc           :
--------------------------------------------------------------------------------

Library IEEE;
Use IEEE.std_logic_1164.all;

Package encoding_components is
	Component Comparator is
		Generic (N:	integer := 8);
		Port (	Reset:	IN std_logic;
			Din1:   IN std_logic_vector(N - 1 downto 0);
			Din2:   IN std_logic_vector(N - 1 downto 0);
		        Dout:   OUT std_logic
		);
	End component;

	Component DLatch is
		Generic (N:	integer := 8);
		Port (  Clk:    IN std_logic;
			En:     IN std_logic;
			Din:    IN std_logic_vector(N - 1 downto 0);
		        Dout:   OUT std_logic_vector(N - 1 downto 0)
		);
	End component;

	Component Multiplexer is
		Generic (N:	integer := 8);
		Port (	Clk:	IN std_logic;
			Sel:    IN std_logic;
			Din1:   IN std_logic_vector(N - 1 downto 0);
		        Din2:   IN std_logic_vector(N - 1 downto 0);
		        Dout:   OUT std_logic_vector(N - 1 downto 0)
		);
	End component;

	Component Regis is
		Generic( N:	integer := 8);
		Port(   Clk:    IN std_logic;
			Din:    IN std_logic_vector(N - 1 downto 0);
			Add:    IN std_logic;
			Dout:   OUT std_logic_vector(N - 1 downto 0)
		);
	End component;
End package encoding_components;
