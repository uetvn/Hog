--------------------------------------------------------------------------------
-- Project name   : Human detection by HOG
-- File name      : cal_lut.vhd
-- Created date   : Friday 06/30/17
-- Author         : Huy Hung Ho
-- Last modified  : Friday 06/30/17
-- Desc           :
--------------------------------------------------------------------------------

Library IEEE;
Use IEEE.std_logic_1164.all;
Use IEEE.math_real.all;
Use IEEE.numeric_std.all;
-- library ieee_proposed;
-- use ieee_proposed.fixed_pkg.all;

Entity cal_lut is
    Generic (pixel_width: integer := 8);
    Port (
            clk:    IN std_logic;
            dx:     IN real;
            dy:     IN real;
            magnit: OUT real;
            angle:  OUT real
         );
End cal_lut;

Architecture Behavioral of cal_lut is
    Component lut_16x16 is
        port(
                clk:        IN std_logic;
                enable:     IN std_logic;
                dx:         IN real;
                dy:         IN real;
                magnit:     OUT real;
                angle:      OUT real
    );
    end component;

    signal enable, enable1: std_logic;
    signal lut_magnit:      real;
    signal lut_angle:       real;
    signal s_magnit:        real range 0.0 to 255.0;
    signal s_angle:         real range 0.0 to 2 * 3.14;
Begin
    select_lut: lut_16x16
    port map(clk, enable, dx, dy, lut_magnit, lut_angle);

    process(clk, enable, dx, dy)
    begin
        if rising_edge(clk) then
            if to_unsigned(integer(dx), 8) < X"0F" and to_unsigned(integer(dy),
            8) < X"0F" then
                enable <= '1';
            else
                enable <= '0';
                if to_unsigned(integer(dx), 8) = X"00" then
                    s_magnit <= dy;
                    s_angle  <= 3.14/2;
                else if to_unsigned(integer(dy), 8) = X"00" then
                    s_magnit <= dx;
                    s_angle  <= 0.0;
                else 
                    s_magnit <= sqrt(dx * dx + dy * dy);
                    s_angle  <= arctan(dy / dx);
                end if;

                    if to_signed(integer(s_angle), 8) < X"00" then
                        s_angle <= s_angle + 3.14;
                    end if;
                end if;
            end if;
        end if;
    end process;

    process (clk, enable, enable1)
    begin
        if rising_edge(clk) then
            if enable = '1' then
                enable1 <= '1';
            else
                enable1 <= '0';
            end if;
        end if;
    end process;

    magnit <= s_magnit when enable1 = '0' else lut_magnit;
    angle  <= s_angle when enable1 = '0' else lut_angle;
End Behavioral;

