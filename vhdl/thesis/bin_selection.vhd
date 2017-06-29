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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity bin_sel is
	generic (n : integer := 8);
	port (
		Gx:     in std_logic_vector (n - 1 downto 0);
        Gy:	    in std_logic_vector (n - 1 downto 0);
		bin:	out std_logic_vector (3 downto 0);
		clk:	in std_logic
	);
end entity;

architecture beh_bin_sel of bin_sel is
    signal  bin_lim1, bin_lim2, bin_lim3, bin_lim4: std_logic_vector (8 downto 0);
    signal  Bin1_Gx, Bin2_Gx, Bin3_Gx, Bin4_Gx:     std_logic_vector (15 downto 0);
    signal  abs_Gx, abs_Gy: std_logic_vector (n-2 downto 0);
    signal  Gy_shifted:     std_logic_vector (15 downto 0);
    signal  zeros:          std_logic_vector (n-2 downto 0); -- zero vector for compasisons
    signal  sign_x, sign_y: std_logic;
begin
    zeros <= (others => '0');

    -- Making the boundaries (cac bien) to bin interger * 64
    bin_lim1 <= "000010111"; -- tan(20) * 64 = 2
    bin_lim2 <= "000110101"; -- tan(40) * 64 = 53
    bin_lim3 <= "001101110"; -- tan(60) * 64 = 110
    bin_lim4 <= "101101011"; -- tan(80) * 64 = 363

    Bin1_Gx <= bin_lim1 * abs_Gx ;
    Bin2_Gx <= bin_lim2 * abs_Gx ;
    Bin3_Gx <= bin_lim3 * abs_Gx ;
    Bin4_Gx <= bin_lim4 * abs_Gx ;

    Gy_shifted <= "000" & abs_Gy & "000000";

    process (clk,Gy_shifted, abs_Gx, abs_Gy)
    begin
        if rising_edge(clk) then
            abs_Gx <= Gx (n-2 downto 0);
            abs_Gy <= Gy (n-2 downto 0);
            sign_x <= Gx (n-1);
            sign_y <= Gy (n-1);

            if ((abs_Gy = zeros) and (abs_Gx /=zeros) and (sign_x='0')) then
                bin<= "0001";   -- 1
            elsif ((abs_Gy = zeros) and (abs_Gx /=zeros) and (sign_x='1')) then
                bin<= "1001";   -- 9
            elsif ((abs_Gy /= zeros) and (abs_Gx = zeros)) then
                bin<= "0101";   -- 5
            elsif ((abs_Gy = zeros) and (abs_Gx = zeros)) then
                bin<= "1010";   -- 10

            elsif ((abs_Gy /= zeros) and (abs_Gx /= zeros) and (sign_x =sign_y)) then
                if Gy_shifted < bin1_Gx then
                    bin<="0001";    -- 1
                elsif ((bin1_Gx <=Gy_shifted) and (Gy_shifted < bin2_gx)) then
                    bin<="0010";    -- 2
                elsif ((bin2_Gx <= Gy_shifted) and (Gy_shifted < bin3_gx)) then
                    bin<="0011";    -- 3
                elsif ((bin3_Gx <= Gy_shifted) and (Gy_shifted < bin4_gx)) then
                    bin<="0100";    -- 4
                else bin<="0101";   -- 5
            end if;

            elsif ((abs_Gx /= zeros) and (abs_Gy /= zeros) and (sign_x/=sign_y)) then
                if Gy_shifted < bin1_Gx then
                    bin<="1001";    -- 9
                elsif (( bin1_Gx<= Gy_shifted) and (Gy_shifted < bin2_gx)) then
                    bin<="1000";    -- 8
                elsif (( bin2_Gx <= Gy_shifted) and (Gy_shifted < bin3_gx)) then
                    bin<="0111";    -- 7
                elsif (( bin3_Gx <= Gy_shifted) and (Gy_shifted < bin4_gx)) then
                    bin<="0110";    -- 6
                else
                    bin<="0101";    -- 5
                end if;
            end if;
        end if;
    end process;
end beh_bin_sel;
