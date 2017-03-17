--------------------------------------------------------------------------------
-- Project name   : LSI Contest 2017
-- File name      : RGBtoGray_pkg.vhd
-- Created date   : Mon 13 Mar 2017
-- Author         : Huy Hung Ho
-- Last modified  : Mon 13 Mar 2017
-- Desc           :
--------------------------------------------------------------------------------
Library IEEE;
Use IEEE.std_logic_1164.all;
Use work.helper.all;
Use work.ram_pkg.all;

Package RGBtoGray_pkg is
        Component RGB2Gray is
                Port (
                        Clk:            IN std_logic;
                        Data1:          IN byte;
                        Data2:          IN byte;
                        Data3:          IN byte;
                        Product:        OUT byte
                );
        End component;

	Component Controller is
		Port (
			Clk:    IN std_logic;
			Start:  IN std_logic;
			Done:   OUT std_logic;
			Load:   OUT std_logic;
			Store:  OUT std_logic;
			Shift:  OUT std_logic
			--HOG:    OUT std_logic
		);
	End component;
End package;
