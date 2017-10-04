--------------------------------------------------------------------------------
-- Project name   :
-- File name      : tb.vhd
-- Created date   : Fri 15 Sep 2017 09:50:15 AM ICT
-- Author         : Huy-Hung Ho
-- Last modified  : Fri 15 Sep 2017 09:50:15 AM ICT
-- Desc           :
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb is
end entity;

architecture behavior of tb is
    use work.config_pkg.all;

    signal s_clk    : std_logic;
    constant PERIOD : time  := 200 ps;

    signal s_x    : unsigned(CB_WIDTH - 1 downto 0) := (others => '0');
    signal s_y    : unsigned(CB_WIDTH - 1 downto 0) := (others => '0');
    signal mBit : integer := 0;
begin
    -- Clock
    s_clk <= NOT s_clk after PERIOD / 2;

    s_y  <= checkLeftMostBit(s_x);
    mBit <= mostLeftBit(s_x);

    main: process
    begin
        wait for 2 * PERIOD;

        wait for PERIOD;
        s_x(4) <=  '1';
        wait for PERIOD;
        s_x(7) <=  '1';
        wait for PERIOD;
        s_x <= (others => '1');
        wait;
    end process;

end behavior;

