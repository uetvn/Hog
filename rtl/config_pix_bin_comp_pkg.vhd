--------------------------------------------------------------------------------
-- Project name   :
-- File name      : config_pix_bin_comp_pkg.vhd
-- Created date   : Thu 13 Jul 2017 11:48:55 AM +07
-- Author         : Ngoc-Sinh Nguyen
-- Last modified  : Thu 13 Jul 2017 11:48:55 AM +07
-- Desc           :
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;

package angle_config_pkg is
    constant MAGNI_BIN_WIDTH : integer := 32;
    constant ANGLE_WIDTH : integer := 4;
    constant PIX_WIDTH : integer := 8;
 
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
end;
