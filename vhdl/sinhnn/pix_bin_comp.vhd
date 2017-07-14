--------------------------------------------------------------------------------
-- Project name   :
-- File name      : pix_bin_comp.vhd
-- Created date   : Fri 07 Jul 2017 04:12:16 PM +07
-- Author         : Ngoc-Sinh Nguyen
-- Last modified  : Fri 07 Jul 2017 04:12:16 PM +07
-- Desc           :
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;

entity pix_bin_comp is
    generic (
        MAGNI_BIN_WIDTH : integer := 8;
        PIX_WIDTH : integer := 8;
        ANGLE_WIDTH : integer := 4
    );
    port (
        -- 4 grays
        x_plus1      : in unsigned (PIX_WIDTH - 1 downto 0);
        x_minus1     : in unsigned (PIX_WIDTH - 1 downto 0);
        y_plus1      : in unsigned (PIX_WIDTH - 1 downto 0);
        y_minus1     : in unsigned (PIX_WIDTH - 1 downto 0);

        -- mangitues of each angle
        angle_1  : out unsigned(ANGLE_WIDTH - 1 downto 0); -- smaller angle
        angle_2  : out unsigned(ANGLE_WIDTH - 1 downto 0); -- smaller angle

        mag_angle_1 : out unsigned(MAGNI_BIN_WIDTH - 1 downto 0);
        mag_angle_2 : out unsigned(MAGNI_BIN_WIDTH - 1 downto 0)

    );
end entity pix_bin_comp;

architecture behav of pix_bin_comp is

    constant DEGREE_0   : unsigned (ANGLE_WIDTH - 1 downto 0 ) := "0000";
    constant DEGREE_10  : unsigned (ANGLE_WIDTH - 1 downto 0 ) := "0001";
    constant DEGREE_30  : unsigned (ANGLE_WIDTH - 1 downto 0 ) := "0010";
    constant DEGREE_50  : unsigned (ANGLE_WIDTH - 1 downto 0 ) := "0011";
    constant DEGREE_70  : unsigned (ANGLE_WIDTH - 1 downto 0 ) := "0100";
    constant DEGREE_90  : unsigned (ANGLE_WIDTH - 1 downto 0 ) := "0101";
    constant DEGREE_110 : unsigned (ANGLE_WIDTH - 1 downto 0 ) := "0110";
    constant DEGREE_130 : unsigned (ANGLE_WIDTH - 1 downto 0 ) := "0111";
    constant DEGREE_150 : unsigned (ANGLE_WIDTH - 1 downto 0 ) := "1000";
    constant DEGREE_170 : unsigned (ANGLE_WIDTH - 1 downto 0 ) := "1001";
    constant DEGREE_180 : unsigned (ANGLE_WIDTH - 1 downto 0 ) := "1010";

    signal s_dx : signed (PIX_WIDTH downto 0) := (others => '0');
    signal s_dy : signed (PIX_WIDTH downto 0) := (others => '0');

    signal s_abs_dx : unsigned(PIX_WIDTH  - 1 downto 0) := (others => '0');
    signal s_abs_dy : unsigned(PIX_WIDTH  - 1 downto 0) := (others => '0');

    signal s_abs_dx_mult_256 : unsigned(PIX_WIDTH * 2 - 1 downto 0 );
    signal s_abs_dx_mult_128 : unsigned(PIX_WIDTH * 2 - 1 downto 0 );
    signal s_abs_dx_mult_64  : unsigned(PIX_WIDTH * 2 - 1 downto 0 );
    signal s_abs_dx_mult_32  : unsigned(PIX_WIDTH * 2 - 1 downto 0 );
    signal s_abs_dx_mult_16  : unsigned(PIX_WIDTH * 2 - 1 downto 0 );
    signal s_abs_dx_mult_8   : unsigned(PIX_WIDTH * 2 - 1 downto 0 );
    signal s_abs_dx_mult_4   : unsigned(PIX_WIDTH * 2 - 1 downto 0 );
    signal s_abs_dx_mult_2   : unsigned(PIX_WIDTH * 2 - 1 downto 0 );
    signal s_abs_dx_mult_1   : unsigned(PIX_WIDTH * 2 - 1 downto 0 );

    signal s_abs_dy_mult_256 : unsigned(PIX_WIDTH * 2 - 1 downto 0 );
    signal s_abs_dy_mult_128 : unsigned(PIX_WIDTH * 2 - 1 downto 0 );
    signal s_abs_dy_mult_64  : unsigned(PIX_WIDTH * 2 - 1 downto 0 );
    signal s_abs_dy_mult_32  : unsigned(PIX_WIDTH * 2 - 1 downto 0 );
    signal s_abs_dy_mult_16  : unsigned(PIX_WIDTH * 2 - 1 downto 0 );
    signal s_abs_dy_mult_8   : unsigned(PIX_WIDTH * 2 - 1 downto 0 );
    signal s_abs_dy_mult_4   : unsigned(PIX_WIDTH * 2 - 1 downto 0 );
    signal s_abs_dy_mult_2   : unsigned(PIX_WIDTH * 2 - 1 downto 0 );
    signal s_abs_dy_mult_1   : unsigned(PIX_WIDTH * 2 - 1 downto 0 );


    signal s_angle_1     : unsigned(ANGLE_WIDTH - 1 downto 0); -- smaller angle
    signal s_angle_2     : unsigned(ANGLE_WIDTH - 1 downto 0); -- smaller angle
    signal s_mag_angle_1 : unsigned(PIX_WIDTH - 1 downto 0);
    signal s_mag_angle_2 : unsigned(PIX_WIDTH - 1 downto 0);

    signal s_angle_greater_90 : std_logic;

begin
    -- TODO: 00000000 --> need to be change
    s_dx <= signed("0" & x_plus1)  - signed("0" & x_minus1);
    s_dy <= signed("0" & y_plus1)  - signed("0" & y_minus1);
    s_angle_greater_90  <= std_logic(s_dx(8)) xor std_logic(s_dy(8));

    s_abs_dx <= unsigned(abs(s_dx));
    s_abs_dy <= unsigned(abs(s_dy));

    s_abs_dx_mult_256 <= s_abs_dx & "00000000";
    s_abs_dx_mult_128 <= "0" & s_abs_dx & "0000000";
    s_abs_dx_mult_64  <= "00" & s_abs_dx & "000000";
    s_abs_dx_mult_32  <= "000" & s_abs_dx & "00000";
    s_abs_dx_mult_16  <= "0000" & s_abs_dx & "0000";
    s_abs_dx_mult_8   <= "00000" & s_abs_dx & "000";
    s_abs_dx_mult_4   <= "000000" & s_abs_dx & "00";
    s_abs_dx_mult_2   <= "0000000" & s_abs_dx & "0";
    s_abs_dx_mult_1   <= "00000000" & s_abs_dx;

    s_abs_dy_mult_256 <= s_abs_dy & "00000000";
    s_abs_dy_mult_128 <= "0" & s_abs_dy & "0000000";
    s_abs_dy_mult_64  <= "00" & s_abs_dy & "000000";
    s_abs_dy_mult_32  <= "000" & s_abs_dy & "00000";
    s_abs_dy_mult_16  <= "0000" & s_abs_dy & "0000";
    s_abs_dy_mult_8   <= "00000" & s_abs_dy & "000";
    s_abs_dy_mult_4   <= "000000" & s_abs_dy & "00";
    s_abs_dy_mult_2   <= "0000000" & s_abs_dy & "0";
    s_abs_dy_mult_1   <= "00000000" & s_abs_dy;


    ANGLE: process (s_dx, s_dy)
        variable v_abs_dx_mult_49 : unsigned(PIX_WIDTH * 2 - 1 downto 0 );
        variable v_abs_dx_mult_512 : unsigned(PIX_WIDTH * 2 - 1 downto 0 ); -- FIXME
        variable v_angle_1  : unsigned(ANGLE_WIDTH - 1 downto 0); -- smaller angle
        variable v_angle_2  : unsigned(ANGLE_WIDTH - 1 downto 0); -- smaller angle
    begin
        v_abs_dx_mult_512 := s_abs_dx & "00000000";
        v_abs_dx_mult_49  := s_abs_dx_mult_32 + s_abs_dx_mult_16 +
        s_abs_dx_mult_1;

        if s_abs_dy /= 8#00# then
            if s_abs_dx /= 8#00#  then -- abs_dx != 0, abs_dy != 0
                if (s_abs_dy_mult_256 > (v_abs_dx_mult_512 + s_abs_dx_mult_256 - v_abs_dx_mult_49 - s_abs_dx_mult_16 )) then
                    v_angle_1 := DEGREE_70;
                    v_angle_2 := DEGREE_90;
                elsif (s_abs_dy_mult_256 > (( s_abs_dx_mult_256 + v_abs_dx_mult_49) )) then
                    v_angle_1 := DEGREE_50;
                    v_angle_2 := DEGREE_70;
                elsif (s_abs_dy_mult_256 > (( s_abs_dx_mult_128 + s_abs_dx_mult_16 + s_abs_dx_mult_4) )) then
                    v_angle_1 := DEGREE_30;
                    v_angle_2 := DEGREE_50;
                elsif (s_abs_dy_mult_256 > ( v_abs_dx_mult_49 - s_abs_dx_mult_4 ) )  then
                    v_angle_1 := DEGREE_10;
                    v_angle_2 := DEGREE_30;
                else
                    v_angle_1 := DEGREE_170;
                    v_angle_2 := DEGREE_10;
                end if;
            else
                v_angle_1 := DEGREE_90;
                v_angle_2 := DEGREE_110;
           end if;
        else -- Only X direction, both left and right
            -- Only X direction need to convert to 10 and 170
            v_angle_1 := DEGREE_170; --0 = bin 0th
            v_angle_2 := DEGREE_10;
        end if;
        --
        if s_angle_greater_90 = '1' then
            s_angle_1 <= DEGREE_180 - v_angle_2; -- FIXME
            s_angle_2 <= DEGREE_180 - v_angle_1; -- FIXME
        else
            s_angle_1 <= v_angle_1;
            s_angle_2 <= v_angle_2;
        end if;
    end process;

    -- Giai he phuong trinh: angle2 - angle1 = 20, M1, M2 > 0
    --          M1 * |cos(angle1)| + M2 * |cos(angle2)| = |dx|;
    --          M1 * |sin(angle1)| + M2 * |sin(angle2)| = |dy|; (because of upper side in Oxy)
    -- D = |cos(angle1)| * sin(angle2) - |sin(angle1)| *  cos(angle2)
    -- DM(angle1) = |dx| * |sin(angle2)|  - |dy| * |cos(angle2)|
    -- DM(angle2) = |dy| * |cos(angle1)|  - |dx| * |sin(angle1)|
    -- if angle1 < 90,
    --  DM0 = |dx| * sin(angle2)  - |dy| * cos(angle2)
    --  DM1 = |dy| * cos(angle1)  - |dx| * sin(angle1)
    -- if angle1 > 90
    --  DM0 = |dx| * sin(180 - angle2)  - |dy| * cos(180 - angle2)
    --  DM1 = |dy| * cos(180 - angle1)  - |dx| * sin(180 - angle1)

    -- DM(10) = |dx| * sin(30) - |dy| cos (30)
    -- DM(30) = |dy| * cos(10) - |dx| cos (10)
    -- DM(150) = |dx| * sin(170)  - |dy| |cos(170)| = |dx| * sin(10) - |dy| * cos 10 = D(10)
    -- DM(170) = |dx| * sin(170)  - |dy| |cos(170)| = |dx| * sin(10) - |dy| * cos 10 = D(30)

    MAGNITUTE: process (s_abs_dy, s_abs_dx, s_angle_1, s_angle_2)
        --variable Dm2: unsigned(2 * PIX_WIDTH - 1 downto 0);
        variable v_sin10_mult_dx_mult_256 : unsigned(2 * PIX_WIDTH - 1 downto 0);
        variable v_sin30_mult_dx_mult_256 : unsigned(2 * PIX_WIDTH - 1 downto 0);
        variable v_sin50_mult_dx_mult_256 : unsigned(2 * PIX_WIDTH - 1 downto 0);
        variable v_sin70_mult_dx_mult_256 : unsigned(2 * PIX_WIDTH - 1 downto 0);

        variable v_cos10_mult_dy_mult_256 : unsigned(2 * PIX_WIDTH - 1 downto 0);
        variable v_cos30_mult_dy_mult_256 : unsigned(2 * PIX_WIDTH - 1 downto 0);
        variable v_cos50_mult_dy_mult_256 : unsigned(2 * PIX_WIDTH - 1 downto 0);
        variable v_cos70_mult_dy_mult_256 : unsigned(2 * PIX_WIDTH - 1 downto 0);

        type double_pix is array ( natural range  <> ) of unsigned (2 * PIX_WIDTH - 1 downto 0);
        variable v_Dm_mult_256 : double_pix(1 downto 0);
        variable v_Dm : double_pix(1 downto 0);
        variable v_mag : double_pix(1 downto 0);

        variable v_angle_1 : unsigned(3 downto 0);
    begin

        v_sin10_mult_dx_mult_256 := s_abs_dx_mult_32 + s_abs_dx_mult_8 + s_abs_dx_mult_4;
        v_sin30_mult_dx_mult_256 := s_abs_dx_mult_128;
        v_sin50_mult_dx_mult_256 := s_abs_dx_mult_128 + s_abs_dx_mult_64 + s_abs_dx_mult_4;
        v_sin70_mult_dx_mult_256 := s_abs_dy_mult_256 - s_abs_dx_mult_16 - s_abs_dx_mult_1;

        v_cos10_mult_dy_mult_256 := s_abs_dy_mult_256 - s_abs_dy_mult_16;
        v_cos30_mult_dy_mult_256 := s_abs_dy_mult_256 - s_abs_dy_mult_32 - s_abs_dy_mult_2;
        v_cos50_mult_dy_mult_256 := s_abs_dy_mult_128 + s_abs_dy_mult_32 + s_abs_dy_mult_4 + s_abs_dy_mult_2;
        v_cos70_mult_dy_mult_256 := s_abs_dy_mult_64 + s_abs_dy_mult_16 + s_abs_dy_mult_8;

        v_angle_1 := s_angle_1;

        case v_angle_1 is
            when "0001" => -- D(10) & D(30) | D(170) & D(150)
                v_Dm_mult_256(0) := v_sin30_mult_dx_mult_256 - v_cos30_mult_dy_mult_256;
                v_Dm_mult_256(1) := v_cos10_mult_dy_mult_256 - v_sin10_mult_dx_mult_256;
            when "0010" => -- D(30) & D(50) | D(150) & D(130)
                v_Dm_mult_256(0) := v_sin50_mult_dx_mult_256 - v_cos50_mult_dy_mult_256;
                v_Dm_mult_256(1) := v_cos30_mult_dy_mult_256 - v_sin30_mult_dx_mult_256;
            when "0011" => -- D(50) & D(70_ | D(130)  & D(110)
                v_Dm_mult_256(0) := v_sin70_mult_dx_mult_256 - v_cos70_mult_dy_mult_256;
                v_Dm_mult_256(1) := v_cos50_mult_dy_mult_256 - v_sin50_mult_dx_mult_256;
            when "0100" => -- D(70) & D(90) | D(110) & D(90)
                v_Dm_mult_256(0) := s_abs_dx_mult_256; -- - 0;
                v_Dm_mult_256(1) := v_cos70_mult_dy_mult_256 - v_sin70_mult_dx_mult_256;
            when "1001" => -- 170 & 10(190) | 10 & 170(-10)
                v_Dm_mult_256(0) := v_sin10_mult_dx_mult_256 - v_cos10_mult_dy_mult_256;
                v_Dm_mult_256(1) := v_cos10_mult_dy_mult_256 - v_sin10_mult_dx_mult_256;
            when others => --TODO
        end case;

        v_Dm(0) := (v_Dm_mult_256(0) sll 8);
        v_Dm(1) := (v_Dm_mult_256(1) sll 8);

        v_mag(0) := (v_Dm(0) srl 1) + ( ((v_Dm(0) srl 4) - v_Dm(0)) sll 4);
        v_mag(1) := (v_Dm(1) srl 1) + ( ((v_Dm(0) srl 4) - v_Dm(1)) sll 4);


        if s_angle_greater_90 ='1' then
            s_mag_angle_1 <= v_mag(1)(7 downto 0);
            s_mag_angle_2 <= v_mag(0)(7 downto 0);
        else
            s_mag_angle_1 <= v_mag(0)(7 downto 0);
            s_mag_angle_2 <= v_mag(1)(7 downto 0);
        end if;

    end process;

    angle_1 <= s_angle_1;
    angle_2 <= s_angle_2;
    mag_angle_1 <= s_mag_angle_1;
    mag_angle_2 <= s_mag_angle_2;
end behav;

