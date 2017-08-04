--------------------------------------------------------------------------------
-- Project name   : Human detection by HOG
-- File name      : cal_gardient.vhd
-- Created date   : Friday 06/30/17
-- Author         : Huy Hung Ho
-- Last modified  : Friday 06/30/17
-- Desc           :
--------------------------------------------------------------------------------

Library IEEE;
Use IEEE.std_logic_1164.all;
Use IEEE.math_real.all;
Use IEEE.numeric_std.all;

Entity cal_gradient is
    Generic (pixel_width: integer := 8);
	Port (
        clk:    IN std_logic;
        enable: IN std_logic;
        dx:     IN std_logic_vector(pixel_width-1 downto 0);
        dy:     IN std_logic_vector(pixel_width-1 downto 0);
        magnit: OUT std_logic_vector(x downto 0);
        angle:  OUT std_logic_vector(x downto 0)
	);
End cal_gradient;

Architecture Behavioral of cal_gradient is
Begin
    process(clk, enable, Gx, Gy)
        variable  dx_tmp, dy_tmp := real;
        variable  magnit_tmp, angle_tmp := real;
    begin
        dx_tmp := real(dx);
        dy_tmp := real(dy);
        if enable = '0' then
            magnit <= (others => '0');
            angle  <= (others => '0');
        else if rising_edge(clk) then
            if (unsigned(Gx) < X"0F" && unsigned(Gx) < X"0F") then
                Gx <= LUT_magnit(dx, dy);
                Gy = LUT_angle(dx, dy);
            else


End Behavioral;

