
library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;
use std.textio.all;
use ieee.std_logic_textio.all;
use std.env.all;
use ieee.math_real.all;

entity tb_pix_bin_comp is
end entity tb_pix_bin_comp;

architecture tb_pix_bin_comp_impl of tb_pix_bin_comp is
    component pix_bin_comp
        generic (
            MAGNI_BIN_WIDTH : integer := 24;
            PIX_WIDTH : integer := 8;
            ANGLE_WIDTH : integer := 4
        );
        port (
            clk         : in std_logic;
            rst         : in std_logic;
            x_plus1     : in unsigned (PIX_WIDTH - 1 downto 0);
            x_minus1    : in unsigned (PIX_WIDTH - 1 downto 0);
            y_plus1     : in unsigned (PIX_WIDTH - 1 downto 0);
            y_minus1    : in unsigned (PIX_WIDTH - 1 downto 0);
            angle_1     : out unsigned(ANGLE_WIDTH - 1 downto 0);
            angle_2     : out unsigned(ANGLE_WIDTH - 1 downto 0);
            mag_angle_1 : out unsigned(MAGNI_BIN_WIDTH - 1 downto 0);
            mag_angle_2 : out unsigned(MAGNI_BIN_WIDTH - 1 downto 0)
        );
    end component pix_bin_comp;

    constant PIX_WIDTH       : integer := 8;
    constant ANGLE_WIDTH     : integer := 4;
    constant MAGNI_BIN_WIDTH : integer := 17;

    signal s_x_plus1     : unsigned (PIX_WIDTH - 1 downto 0)       := (others => '0');
    signal s_x_minus1    : unsigned (PIX_WIDTH - 1 downto 0)       := (others => '0');
    signal s_y_plus1     : unsigned (PIX_WIDTH - 1 downto 0)       := (others => '0');
    signal s_y_minus1    : unsigned (PIX_WIDTH - 1 downto 0)       := (others => '0');
    signal s_angle_1     : unsigned(ANGLE_WIDTH - 1 downto 0);
    signal s_angle_2     : unsigned(ANGLE_WIDTH - 1 downto 0);
    signal s_mag_angle_1 : unsigned(MAGNI_BIN_WIDTH - 1 downto 0);
    signal s_mag_angle_2 : unsigned(MAGNI_BIN_WIDTH - 1 downto 0);

    constant PERIOD : time      := 10 ns;
    signal s_clk    : std_logic := '1';
    signal s_rst    : std_logic := '0';

begin
    s_clk <= not s_clk after PERIOD/2;
    s_rst <= '1' after 3 * PERIOD;

    DUT_pix_bin_comp: pix_bin_comp
        generic map (
            MAGNI_BIN_WIDTH => 17 ,
            PIX_WIDTH       => 8 ,
            ANGLE_WIDTH     => 4
        )
        port map (
            clk             => s_clk,
            rst             => s_rst,
            x_plus1         => s_x_plus1,
            x_minus1        => s_x_minus1,
            y_plus1         => s_y_plus1,
            y_minus1        => s_y_minus1,
            angle_1         => s_angle_1,
            angle_2         => s_angle_2,
            mag_angle_1     => s_mag_angle_1 ,
            mag_angle_2     => s_mag_angle_2
        );

    READIO : process
        variable iline             : line;
        variable oline             : line;
        variable aSpace            : character;
        variable v_x_plus1         : integer;
        variable v_x_minus1        : integer;
        variable v_y_plus1         : integer;
        variable v_y_minus1        : integer;

        variable v_angle_1         : integer;
        variable v_angle_2         : integer;
        variable v_mag_1           : real;
        variable v_mag_2           : real;
        variable v_dx              : real;
        variable v_dy              : real;
        variable v_diff_dx         : real;
        variable v_diff_dy         : real;
        variable v_percent_diff_dx : real;
        variable v_percent_diff_dy : real;

        file inf : text;
        file ouf : text;
    begin
        file_open(inf, "inf.txt",read_mode);
        file_open(ouf, "ouf.txt",write_mode);
	
	wait until s_rst = '1';

        while not endfile(inf) loop
            readline(inf,iline);
            read(iline, v_x_plus1); read(iline,aSpace);
            read(iline, v_x_minus1); read(iline,aSpace);
            read(iline, v_y_plus1); read(iline,aSpace);
            read(iline, v_y_minus1); read(iline,aSpace);
            -- Variable to signal
            s_x_plus1 <= to_unsigned(v_x_plus1, PIX_WIDTH);
            s_x_minus1 <= to_unsigned(v_x_minus1, PIX_WIDTH);
            s_y_plus1 <= to_unsigned(v_y_plus1, PIX_WIDTH);
            s_y_minus1 <= to_unsigned(v_y_minus1, PIX_WIDTH);
            -- Wait for next input
            wait until rising_edge(s_clk);
	    wait for PERIOD/5.0;
            -- Write odata
            write(oline, to_integer((s_x_plus1)));
            write(oline,aSpace);
            write(oline, to_integer((s_x_minus1)));
            write(oline,aSpace);
            write(oline, to_integer((s_y_plus1)));
            write(oline,aSpace);
            write(oline, to_integer((s_y_minus1)));
            write(oline,aSpace);

            -- Check the Magnitute of Results  ---------------------------------
            case s_angle_1 is
                when "0001" =>
                    v_angle_1 := 10;
                when "0010" =>
                    v_angle_1 := 30;
                when "0011" =>
                    v_angle_1 := 50;
                when "0100" =>
                    v_angle_1 := 70;
                when "0101" =>
                    v_angle_1 := 90;
                when "0110" =>
                    v_angle_1 := 110;
                when "0111" =>
                    v_angle_1 := 130;
                when "1000" =>
                    v_angle_1 := 150;
                when "1001" =>
                    v_angle_1 := 170;
                when others =>
                    v_angle_1 := 0;
            end case;
            case s_angle_2 is
                when "0001" =>
                    v_angle_2 := 10;
                when "0010" =>
                    v_angle_2 := 30;
                when "0011" =>
                    v_angle_2 := 50;
                when "0100" =>
                    v_angle_2 := 70;
                when "0101" =>
                    v_angle_2 := 90;
                when "0110" =>
                    v_angle_2 := 110;
                when "0111" =>
                    v_angle_2 := 130;
                when "1000" =>
                    v_angle_2 := 150;
                when "1001" =>
                    v_angle_2 := 170;
                when others =>
                    v_angle_2 := 0;
            end case;
            write(oline, v_angle_1);
            write(oline,aSpace);
            write(oline, v_angle_2);
            write(oline,aSpace);
            v_mag_1 :=  real(to_integer((s_mag_angle_1))) / real(256);
            write(oline, v_mag_1, right, 8, 3);
            write(oline,aSpace);
            v_mag_2 :=  real(to_integer((s_mag_angle_2))) / real(256);
            write(oline, v_mag_2, right,  8, 3);
            write(oline,aSpace);
            --Write back dx, dy
            if ( (v_angle_2 = 170) and (v_angle_1 = 10) ) or (( v_angle_2 = 10) and (v_angle_1 = 170) ) then
                v_dx := v_mag_1 * cos(real(10) * MATH_DEG_TO_RAD)
                        + v_mag_2 * cos(real(10) * MATH_DEG_TO_RAD);
                v_dy := v_mag_1 * sin(real(10) * MATH_DEG_TO_RAD)
                        + v_mag_2 * sin(real(-10) * MATH_DEG_TO_RAD);

            else
                v_dx := v_mag_1 * cos(real(v_angle_1) * MATH_DEG_TO_RAD)
                        + v_mag_2 * cos(real(v_angle_2) * MATH_DEG_TO_RAD);
                v_dy := v_mag_1 * sin(real(v_angle_1) * MATH_DEG_TO_RAD)
                        + v_mag_2 * sin(real(v_angle_2) * MATH_DEG_TO_RAD);

            end if;
            v_diff_dx := abs(v_dx) - abs(real( to_integer(s_x_plus1) - to_integer(s_x_minus1)));
            v_diff_dy := abs(v_dy) - abs(real( to_integer(s_y_plus1) - to_integer(s_y_minus1)));
            write(oline, v_dx, right,  8, 3);
            write(oline,aSpace);
            write(oline, v_dy, right,  8, 3);
            write(oline,aSpace);
            write(oline, v_diff_dx, right,  8, 3);
            write(oline,aSpace);
            write(oline, v_diff_dy, right,  8, 3);
            write(oline,aSpace);
            writeline(ouf,oline);

            -- Tinh % sai so, diff/dx or diff/dy
            -- Neu sai so lon, kiem tra lai cong thuc tinh va cach tinh xap xi
            if s_x_plus1 /= s_x_minus1 then
                v_percent_diff_dx := abs(v_diff_dx) / abs(real(to_integer(s_x_plus1) - to_integer(s_x_minus1)));
                assert ( v_percent_diff_dx < real(0.02)) report "v_diff_dx > 2%";
            else
                v_percent_diff_dx := real(0);
            end if;

            if s_y_plus1 /= s_y_minus1 then
                v_percent_diff_dy := abs(v_diff_dy) / abs(real(to_integer(s_y_plus1) - to_integer(s_y_minus1)));
                assert ( v_percent_diff_dy < real(0.02)) report "v_diff_dy > 2%";
            else
                v_percent_diff_dy := real(0);
            end if;
        end loop;
        file_close(inf);
        file_close(ouf);
        finish(0);
    end process READIO;
end architecture tb_pix_bin_comp_impl;
