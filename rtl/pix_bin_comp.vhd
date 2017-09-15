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
use work.angle_config_pkg.all;

entity pix_bin_comp is
    generic (
        -- FIXME: need a parameter that describe both: integer side and float -- side
        MAGNI_BIN_WIDTH : integer := 17;  -- Need at least 9-bit integer
        PIX_WIDTH : integer := 8;
        ANGLE_WIDTH : integer := 4
    );
    port (
        clk     : in std_logic;
        rst     : in std_logic;
        -- 4 grays
        x_plus1      : in unsigned (PIX_WIDTH - 1 downto 0);
        x_minus1     : in unsigned (PIX_WIDTH - 1 downto 0);
        y_plus1      : in unsigned (PIX_WIDTH - 1 downto 0);
        y_minus1     : in unsigned (PIX_WIDTH - 1 downto 0);

        -- mangitues of each angle
        angle_1  : out unsigned(ANGLE_WIDTH - 1 downto 0);
        angle_2  : out unsigned(ANGLE_WIDTH - 1 downto 0);
        mag_angle_1 : out unsigned(MAGNI_BIN_WIDTH - 1 downto 0); -- magnitute * 256
        mag_angle_2 : out unsigned(MAGNI_BIN_WIDTH - 1 downto 0) -- magnitute * 256
    );
end entity pix_bin_comp;

architecture behav of pix_bin_comp is


    constant ZEROs_1b: unsigned (0 downto 0) := "0";
    constant ZEROs_2b: unsigned (1 downto 0) := (others => '0');
    constant ZEROs_3b: unsigned (2 downto 0) := (others => '0');
    constant ZEROs_4b: unsigned (3 downto 0) := (others => '0');
    constant ZEROs_5b: unsigned (4 downto 0) := (others => '0');
    constant ZEROs_6b: unsigned (5 downto 0) := (others => '0');
    constant ZEROs_7b: unsigned (6 downto 0) := (others => '0');
    constant ZEROs_8b: unsigned (7 downto 0) := (others => '0');

    signal s_angle_1     : unsigned(ANGLE_WIDTH - 1 downto 0);
    signal s_angle_2     : unsigned(ANGLE_WIDTH - 1 downto 0);
    signal s_mag_angle_1 : unsigned(MAGNI_BIN_WIDTH - 1 downto 0);
    signal s_mag_angle_2 : unsigned(MAGNI_BIN_WIDTH - 1 downto 0);

    signal s_angle_greater_90 : std_logic;
    signal v_abs_dx : unsigned (PIX_WIDTH - 1 downto 0);
    signal v_abs_dy : unsigned (PIX_WIDTH - 1 downto 0);

    signal v_abs_dy_mult_4  : unsigned (PIX_WIDTH + 1 downto 0); -- DEGREE 70-90
    signal v_abs_dx_mult_11 : unsigned (PIX_WIDTH + 3 downto 0);
    signal v_abs_dy_mult_73 : unsigned (PIX_WIDTH + 6 downto 0); -- DEGREE 50-70
    signal v_abs_dx_mult_87 : unsigned (PIX_WIDTH + 6 downto 0);
    signal v_abs_dy_mult_168: unsigned (PIX_WIDTH + 7 downto 0); -- DEGREE 30-50
    signal v_abs_dx_mult_97 : unsigned (PIX_WIDTH + 6 downto 0);
    signal v_abs_dy_mult_17 : unsigned (PIX_WIDTH + 4 downto 0); -- DEGREE 10-30
    signal v_abs_dx_mult_3  : unsigned (PIX_WIDTH + 1 downto 0);
    ----  Magnitute cal: sin or cos * 256
    signal v_sin10_mult_dx_mult_256 : unsigned(PIX_WIDTH + 5 downto 0);
    signal v_sin30_mult_dx_mult_256 : unsigned(PIX_WIDTH + 6 downto 0);
    signal v_sin50_mult_dx_mult_256 : unsigned(PIX_WIDTH + 7 downto 0);
    signal v_sin70_mult_dx_mult_256 : unsigned(PIX_WIDTH + 7 downto 0);
    signal v_cos10_mult_dy_mult_256 : unsigned(PIX_WIDTH + 7 downto 0);
    signal v_cos30_mult_dy_mult_256 : unsigned(PIX_WIDTH + 7 downto 0);
    signal v_cos50_mult_dy_mult_256 : unsigned(PIX_WIDTH + 7 downto 0);
    signal v_cos70_mult_dy_mult_256 : unsigned(PIX_WIDTH + 6 downto 0);

    signal s_tmp_sum : unsigned (3 downto 0) := (others => '0') ;


begin
    process(clk, rst) is
    begin
        if rst = '0' then
            angle_1 <= (others =>'0');
            angle_2 <= (others =>'0');
            mag_angle_1 <= (others =>'0');
            mag_angle_2 <= (others =>'0');
        elsif rising_edge(clk) then
                angle_1 <= s_angle_1;
                angle_2 <= s_angle_2;
                mag_angle_1 <= s_mag_angle_1;
                mag_angle_2 <= s_mag_angle_2;
        end if;
    end process;

    -- Stage 1  ----------------------------------------------------------------
    process (x_plus1, x_minus1, y_plus1, y_minus1)
        variable dx : signed (PIX_WIDTH downto 0);
        variable dy : signed (PIX_WIDTH downto 0);
        variable abs_dx : unsigned (PIX_WIDTH downto 0);
        variable abs_dy : unsigned (PIX_WIDTH downto 0);
    begin
        dx := signed ("0" & x_plus1) - signed("0" & x_minus1);
        dy := signed ("0" & y_plus1) - signed("0" & y_minus1);

        abs_dx := unsigned(abs(dx));
        abs_dy := unsigned(abs(dy));

        v_abs_dx <= abs_dx(PIX_WIDTH-1 downto 0);
        v_abs_dy <= abs_dy(PIX_WIDTH-1 downto 0);

        s_angle_greater_90 <= dx(PIX_WIDTH) xor dy(PIX_WIDTH);
    end process;
    ----------------------------------------------------------------------------
    -- Stage 2  ----------------------------------------------------------------
    v_sin10_mult_dx_mult_256 <= (ZEROs_1b & v_abs_dx & ZEROs_5b)
                                + (ZEROs_3b & v_abs_dx & ZEROs_3b)
                                + (ZEROs_4b & v_abs_dx & ZEROs_2b);
    v_sin30_mult_dx_mult_256 <= v_abs_dx & ZEROs_7b;
    -- sin50 * 256 = 196
    v_sin50_mult_dx_mult_256 <= (ZEROs_1b & v_abs_dx & ZEROs_7b)
                                + (ZEROs_2b & v_abs_dx & ZEROs_6b)
                                + (ZEROs_6b & v_abs_dx & ZEROs_2b);
    v_sin70_mult_dx_mult_256 <= (v_abs_dx & ZEROs_8b)
                                - (ZEROs_4b  & v_abs_dx & ZEROs_4b)
                                + (ZEROs_8b & v_abs_dx);

    v_cos10_mult_dy_mult_256 <= (v_abs_dy & ZEROs_8b)
                                - (ZEROs_6b & v_abs_dy & ZEROs_2b);
    v_cos30_mult_dy_mult_256 <= (v_abs_dy & ZEROs_8b)
                                - (ZEROs_3b & v_abs_dy & ZEROs_5b)
                                - (ZEROs_7b & v_abs_dy & ZEROs_1b);
    v_cos50_mult_dy_mult_256 <= (ZEROs_1b & v_abs_dy & ZEROs_7b)
                                + (ZEROs_3b & v_abs_dy & ZEROs_5b)
                                + (ZEROs_6b  & v_abs_dy & ZEROs_2b)
                                + (ZEROs_8b & v_abs_dy);
    v_cos70_mult_dy_mult_256 <= (ZEROs_1b & v_abs_dy & ZEROs_6b)
                                + (ZEROs_3b & v_abs_dy & ZEROs_4b)
                                + (ZEROs_4b & v_abs_dy & ZEROs_3b);

    -- 10-30
    v_abs_dy_mult_17 <= (ZEROs_1b & v_abs_dy & ZEROs_4b) + (ZEROs_5b & v_abs_dy);
    v_abs_dx_mult_3 <= (ZEROs_1b & v_abs_dx & ZEROs_1b) + (ZEROs_2b & v_abs_dx);
    -- 30-50
    v_abs_dy_mult_168 <= (ZEROs_1b & v_abs_dy & ZEROs_7b)
                         + (ZEROs_3b & v_abs_dy & ZEROs_5b)
                         + (ZEROs_5b & v_abs_dy & ZEROs_3b);

    v_abs_dx_mult_97 <= (ZEROs_1b & v_abs_dx & ZEROs_6b)
                        + (ZEROs_2b & v_abs_dx & ZEROs_5b)
                        + (ZEROs_7b & v_abs_dx);
    -- 50 --70
    v_abs_dy_mult_73 <= (ZEROs_1b & v_abs_dy & ZEROs_6b)
                        + (ZEROs_4b & v_abs_dy & ZEROs_3b)
                        + (ZEROs_7b & v_abs_dy);

    v_abs_dx_mult_87 <= (ZEROs_1b & v_abs_dx & ZEROs_6b)
                        + (ZEROs_3b & v_abs_dx & ZEROs_4b)
                        + (ZEROs_4b & v_abs_dx & ZEROs_3b)
                        - (ZEROs_7b & v_abs_dx);
    -- 70 -90
    v_abs_dy_mult_4 <= v_abs_dy & ZEROs_2b;
    v_abs_dx_mult_11 <=  (ZEROs_1b & v_abs_dx & ZEROs_3b)
                         + (ZEROs_3b & v_abs_dx & ZEROs_1b)
                         + (ZEROs_4b & v_abs_dx);

    ----------------------------------------------------------------------------
    --- Stage 3  ---------------------------------------------------------------

    s_tmp_sum(0) <= '1' when (v_abs_dy_mult_17 >= (ZEROs_3b & v_abs_dx_mult_3))
                        else  '0';
    s_tmp_sum(1) <= '1' when (v_abs_dy_mult_168 >= (ZEROs_1b & v_abs_dx_mult_97))
                        else  '0';
    s_tmp_sum(2) <= '1' when (v_abs_dy_mult_73 >= v_abs_dx_mult_87)
                        else  '0';
    s_tmp_sum(3) <= '1' when (v_abs_dy_mult_4 >= v_abs_dx_mult_11)
                        else  '0';
    --s_tmp_90 <= "10000" when (v_abs_dx = X"00")
    --                    else  (others => '0');
    ------------------------------------------------------------------------------

    --ANGLE: process (abs_dx, v_abs_dy, v_angle_greater_90)
    ANGLE: process (v_sin30_mult_dx_mult_256, v_sin10_mult_dx_mult_256,
        v_sin50_mult_dx_mult_256, v_sin70_mult_dx_mult_256,
        v_cos10_mult_dy_mult_256, v_cos30_mult_dy_mult_256,
        v_cos50_mult_dy_mult_256, v_cos70_mult_dy_mult_256,
        s_tmp_sum, s_angle_greater_90
    ) is
        constant TEMP_WIDTH : integer := 2 * PIX_WIDTH;
        constant TEMP_WIDTH_PLUS4 : integer := 2 * PIX_WIDTH + 4;

        --variable v_angle_greater_90 : boolean;
        variable v_angle_1  : unsigned(3 downto 0);
        variable v_angle_2  : unsigned(3 downto 0);

        -- Variables are used only in ANGLE calculation
        variable v_a_1  : signed(TEMP_WIDTH + 1 downto 0);
        variable v_a_2  : signed(TEMP_WIDTH + 1 downto 0);
        variable v_b_1  : signed(TEMP_WIDTH + 1 downto 0);
        variable v_b_2  : signed(TEMP_WIDTH + 1 downto 0);
        variable v_Dm_1 : signed(TEMP_WIDTH + 1 downto 0);
        variable v_Dm_2 : signed(TEMP_WIDTH + 1 downto 0);

        variable v_tDm_1 : unsigned(TEMP_WIDTH + 4 downto 0);
        variable v_tDm_2 : unsigned(TEMP_WIDTH + 4 downto 0);
        variable v_mag_1 : unsigned(TEMP_WIDTH + 4 downto 0);
        variable v_mag_2 : unsigned(TEMP_WIDTH + 4 downto 0);

        --variable s_tmp_sum : unsigned (4 downto 0) := (others => '0') ;
    begin
        -- Angle calculation  --------------------------------------------------

        case s_tmp_sum is
            when "0000" =>
                v_angle_1 := DEGREE_170;
                v_angle_2 := DEGREE_10;
                v_a_1 := signed(ZEROs_4b & v_sin10_mult_dx_mult_256);
                v_b_1 := signed(ZEROs_2b & v_cos10_mult_dy_mult_256);
                v_a_2 := signed(ZEROs_4b & v_sin10_mult_dx_mult_256);
                v_b_2 := -signed(ZEROs_2b & v_cos10_mult_dy_mult_256); --FIXME: optimize
            when "0001" =>
                v_angle_1 := DEGREE_10;
                v_angle_2 := DEGREE_30;
                v_a_1 := signed(ZEROs_3b & v_sin30_mult_dx_mult_256);
                v_b_1 := signed(ZEROs_2b & v_cos30_mult_dy_mult_256);
                v_a_2 := signed(ZEROs_2b & v_cos10_mult_dy_mult_256);
                v_b_2 := signed(ZEROs_4b & v_sin10_mult_dx_mult_256);
            when "0011" =>
                v_angle_1 := DEGREE_30;
                v_angle_2 := DEGREE_50;
                v_a_1 := signed(ZEROs_2b & v_sin50_mult_dx_mult_256);
                v_b_1 := signed(ZEROs_2b & v_cos50_mult_dy_mult_256);
                v_a_2 := signed(ZEROs_2b & v_cos30_mult_dy_mult_256);
                v_b_2 := signed(ZEROs_3b & v_sin30_mult_dx_mult_256);

            when "0111" =>
                v_angle_1 := DEGREE_50;
                v_angle_2 := DEGREE_70;
                v_a_1 := signed(ZEROs_2b & v_sin70_mult_dx_mult_256);
                v_b_1 := signed(ZEROs_3b & v_cos70_mult_dy_mult_256);
                v_a_2 := signed(ZEROs_2b & v_cos50_mult_dy_mult_256);
                v_b_2 := signed(ZEROs_2b & v_sin50_mult_dx_mult_256);
            when "1111" =>
                v_angle_1 := DEGREE_70;
                v_angle_2 := DEGREE_90;
                v_a_1 := signed(ZEROs_2b & v_sin30_mult_dx_mult_256 & "0");
                v_b_1 := to_signed(0, v_b_1'length);
                v_a_2 := signed(ZEROs_3b & v_cos70_mult_dy_mult_256);
                v_b_2 := signed(ZEROs_2b & v_sin70_mult_dx_mult_256);

          when others => -- ERROR --> return 0
                v_angle_1 := DEGREE_90;
                v_angle_2 := DEGREE_90;
                v_a_1 := to_signed(0, v_a_1'length);
                v_b_1 := to_signed(0, v_b_1'length);
                v_a_2 := to_signed(0, v_a_2'length);
                v_b_2 := to_signed(0, v_b_2'length);
        end case;

        v_Dm_1 := (v_a_1 - v_b_1);
        v_Dm_2 := (v_a_2 - v_b_2);

        if v_Dm_1(v_Dm_1'length - 1) = '1' then
            v_Dm_1 := (others => '0');
        end if;
        if v_Dm_2(v_Dm_2'length - 1) = '1' then
            v_Dm_1 := (others => '0');
        end if;

        -- Divide by sin(20)
        v_tDm_1 := "0000" & unsigned(v_Dm_1(v_Dm_1'length - 2 downto 0));
        v_tDm_2 := "0000" & unsigned(v_Dm_2(v_Dm_2'length - 2 downto 0));
        v_mag_1 := (v_tDm_1 sll 1) + (((v_tDm_1 sll 4) - v_tDm_1) srl 4);
        v_mag_2 := (v_tDm_2 sll 1) + (((v_tDm_2 sll 4) - v_tDm_2) srl 4);

        if s_angle_greater_90 = '1' then
            s_angle_1 <= DEGREE_180 - v_angle_1; -- FIXME
            s_angle_2 <= DEGREE_180 - v_angle_2; -- FIXME
        else
            s_angle_1 <= v_angle_1;
            s_angle_2 <= v_angle_2;
        end if;

        s_mag_angle_1 <= v_mag_1(MAGNI_BIN_WIDTH - 1 downto 0);
        s_mag_angle_2 <= v_mag_2(MAGNI_BIN_WIDTH - 1 downto 0);

   end process;

end behav;
