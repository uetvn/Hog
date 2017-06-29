--------------------------------------------------------------------------------
-- Project name   : Human detection by HOG
-- File name      : bin_selection.vhd
-- Created date   : Mon 08 May 2017
-- Author         : Huy Hung Ho
-- Last modified  : Mon 08 May 2017
-- Desc           :
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity bin_sel is
	generic (pixel_width : integer := 8);
	port (
		clk:	IN std_logic;
		Gx:     IN std_logic_vector (pixel_width - 1 downto 0);
        Gy:	    IN std_logic_vector (pixel_width - 1 downto 0);
		bin:	    OUT std_logic_vector (3 downto 0);
        magnit1:    OUT std_logic_vector (15 downto 0);
        magnit2:    OUT std_logic_vector (15 downto 0)
	);
end entity;

architecture beh_bin_sel of bin_sel is
    signal  bin_lim1, bin_lim2, bin_lim3, bin_lim4: std_logic_vector (8 downto 0);
    signal  bin1_Gx, bin2_Gx, bin3_Gx, bin4_Gx:     std_logic_vector (15 downto 0);
    signal  bin_tmp:        std_logic_vector (3 downto 0);
    signal  abs_Gx, abs_Gy: std_logic_vector (pixel_width-2 downto 0);
    signal  Gy_shifted:     std_logic_vector (15 downto 0);
    signal  zeros:          std_logic_vector (pixel_width-2 downto 0); -- zero vector for compasisons
    signal  sign_x, sign_y: std_logic;

    signal  square_Gx, square_Gy: std_logic_vector(13 downto 0);
    signal  square_Gxy_shift:     std_logic_vector(31 downto 0);
    signal  magnit:               std_logic_vector(15 downto 0);
begin
    zeros <= (others => '0');

    square_Gx  <= abs_Gx * abs_Gx;
    square_Gy  <= abs_Gy * abs_Gy;

    -- Making the boundaries (cac bien) to bin interger * 64 (9 bits)
    bin_lim1 <= "000010111"; -- tan(20) * 64 = 23
    bin_lim2 <= "000110101"; -- tan(40) * 64 = 53
    bin_lim3 <= "001101110"; -- tan(60) * 64 = 110
    bin_lim4 <= "101101011"; -- tan(80) * 64 = 363

    bin1_Gx <= bin_lim1 * abs_Gx;   -- 15 bits = (9 bits * 7 bits)
    bin2_Gx <= bin_lim2 * abs_Gx;
    bin3_Gx <= bin_lim3 * abs_Gx;
    bin4_Gx <= bin_lim4 * abs_Gx;

    Gy_shifted <= "000" & abs_Gy & "000000";

    process (clk, Gy_shifted, bin_lim1, bin1_Gx, bin2_Gx, bin3_Gx, bin4_Gx)
    begin
        if rising_edge(clk) then
            abs_Gx <= Gx (pixel_width-2 downto 0);
            abs_Gy <= Gy (pixel_width-2 downto 0);
            sign_x <= Gx (pixel_width-1);
            sign_y <= Gy (pixel_width-1);

            square_Gxy_shift <= ('0' & square_Gx + '0' & square_Gx) & (16 downto 0 => '0');

            if ((abs_Gy = zeros) and (abs_Gx /= zeros) and (sign_x = '0')) then
                bin_tmp <= "0001";   -- 1
                report "one" severity note;
            elsif ((abs_Gy = zeros) and (abs_Gx /= zeros) and (sign_x = '1')) then
                bin_tmp <= "1001";   -- 9
            elsif ((abs_Gy /= zeros) and (abs_Gx = zeros)) then
                bin_tmp <= "0101";   -- 5
                report "two" severity note;
            elsif ((abs_Gy = zeros) and (abs_Gx = zeros)) then
                bin_tmp <= "1010";   -- 10

            elsif ((abs_Gy /= zeros) and (abs_Gx /= zeros) and (sign_x = sign_y)) then
                if Gy_shifted < bin1_Gx then
                    bin_tmp <= "0001";    -- 1
                    report "three" severity note;
                elsif ((bin1_Gx <= Gy_shifted) and (Gy_shifted < bin2_gx)) then
                    bin_tmp <= "0010";    -- 2
                elsif ((bin2_Gx <= Gy_shifted) and (Gy_shifted < bin3_gx)) then
                    bin_tmp <= "0011";    -- 3
                elsif ((bin3_Gx <= Gy_shifted) and (Gy_shifted < bin4_gx)) then
                    bin_tmp <= "0100";    -- 4
                else
                    bin_tmp <="0101";   -- 5
                    report "four" severity note;
                end if;

            elsif ((abs_Gx /= zeros) and (abs_Gy /= zeros) and (sign_x /= sign_y)) then
                if Gy_shifted < bin1_Gx then
                    bin_tmp <= "1001";    -- 9
                elsif (( bin1_Gx <= Gy_shifted) and (Gy_shifted < bin2_gx)) then
                    bin_tmp <= "1000";    -- 8
                elsif (( bin2_Gx <= Gy_shifted) and (Gy_shifted < bin3_gx)) then
                    bin_tmp <= "0111";    -- 7
                elsif (( bin3_Gx <= Gy_shifted) and (Gy_shifted < bin4_gx)) then
                    bin_tmp <= "0110";    -- 6
                else
                    bin_tmp <= "0101";    -- 5
                    report "five" severity note;
                end if;
            end if;

            --case bin_tmp is
            --    when "0001"          => rate <= Gy_shifted;
            --    when "0010" | "1001" => rate <= Gy_shifted - bin1_Gx;
            --    when "0011" | "1000" => rate <= Gy_shifted - bin2_Gx;
            --    when "0100" | "0111" => rate <= Gy_shifted - bin3_Gx;
            --    when others          => rate <= Gy_shifted - bin4_Gx;
            --end case;
        end if;
    end process;

    -- output
    bin <= bin_tmp;
end beh_bin_sel;
