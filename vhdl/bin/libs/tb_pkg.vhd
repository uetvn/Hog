--------------------------------------------------------------------------------
-- Project name   : LSI Contest 2017
-- File name      : tb_pkg.vhd
-- Created date   : Mon 13 Mar 2017
-- Author         : Huy Hung Ho
-- Last modified  : Thu 30 Mar 2017
-- Desc           :
--------------------------------------------------------------------------------
Library IEEE;
Use IEEE.std_logic_1164.all;
Use work.include.all;

Package tb_pkg is
        Component rgb2y is
                Port (
                        r:  IN byte;
                        g:  IN byte;
                        b:  IN byte;
                        y:  OUT byte
                );
        End component;

	Component Controller is
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
	End component;
End package;
