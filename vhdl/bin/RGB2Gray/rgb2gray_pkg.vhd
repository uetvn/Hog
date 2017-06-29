--------------------------------------------------------------------------------
-- Project name   : LSI Contest 2017
-- File name      : rgb2gray_components.vhd
-- Created date   : Thứ sáu, 24 Tháng hai Năm 2017 13:52:30 ICT
-- Author         : Huy Hung Ho
-- Last modified  : Thứ sáu, 24 Tháng hai Năm 2017 16:00:06 ICT
-- Desc           :
--------------------------------------------------------------------------------

Library IEEE;
Use IEEE.std_logic_1164.all;

Package rgb2gray_components is
	Component AdderNbit is
		Generic (N:	integer := 32);
    		Port (	a, b:   IN STD_LOGIC_VECTOR (N - 1 downto 0);
                	Cin:    IN STD_LOGIC;
                	S:      OUT STD_LOGIC_VECTOR (N - 1 downto 0);
                	Cout:   OUT STD_LOGIC);
	End component;

	Component MultRed is
        	Port (  Clk:    IN std_logic;
                	Data:   IN std_logic_vector(7 downto 0);
                	Result: OUT std_logic_vector(31 downto 0)
        	);
	End component;

	Component MultGreen is
        	Port (  Clk:    IN std_logic;
                	Data:   IN std_logic_vector(7 downto 0);
                	Result: OUT std_logic_vector(31 downto 0)
        	);
	End component;

	Component MultBlue is
        	Port (  Clk:    IN std_logic;
                	Data:   IN std_logic_vector(7 downto 0);
                	Result: OUT std_logic_vector(31 downto 0)
        	);
	End component;
End package;
