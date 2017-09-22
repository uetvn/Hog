--------------------------------------------------------------------------------
-- Project name   :
-- File name      : checkLeftMostBit.vhd
-- Created date   : Mon 11 Sep 2017 12:13:54 PM ICT
-- Author         : Huy-Hung Ho
-- Last modified  : Wed 13 Sep 2017 02:32:13 PM ICT
-- Desc           :
--------------------------------------------------------------------------------

use ieee.numeric_std.all;

package
entity checkLeftMostBit is
    generic (
        BIT_WIDTH : integer := 30
    );
    port (
        x       : IN std_logic_vector(BIT_WIDTH - 1 downto 0);
        y       : OUT std_logic_vector(BIT_WIDTH - 1 downto 0)
    );
end entity;

architecture behavior of checkLeftMostBit is
    signal tmp1 : unsigned(BIT_WIDTH - 1 downto 0) := (others => '0');
    signal tmp2 : unsigned(BIT_WIDTH - 1 downto 0) := (others => '0');
    signal tmp3 : unsigned(BIT_WIDTH - 1 downto 0) := (others => '0');
    signal tmp4 : unsigned(BIT_WIDTH - 1 downto 0) := (others => '0');
    signal tmp5 : unsigned(BIT_WIDTH - 1 downto 0) := (others => '0');
    signal tmp6 : unsigned(BIT_WIDTH - 1 downto 0) := (others => '0');
    signal tmp7 : unsigned(BIT_WIDTH - 1 downto 0) := (others => '0');
begin
    tmp1 <= unsigned(x);
    tmp2 <= tmp1 OR (tmp1 srl 16);
    tmp3 <= tmp2 OR (tmp2 srl 8);
    tmp4 <= tmp3 OR (tmp3 srl 4);
    tmp5 <= tmp4 OR (tmp4 srl 2);
    tmp6 <= tmp5 OR (tmp5 srl 1);
    tmp7 <= tmp6 XOR (tmp6 srl 1);
    y <= std_logic_vector(tmp7 sll 1);

end behavior;
