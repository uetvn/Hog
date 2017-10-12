
--------------------------------------------------------------------------------
-- Project name   :
-- File name      : appx_div.vhd
-- Created date   : Fri 15 Sep 2017 09:35:08 AM ICT
-- Author         : Huy-Hung Ho
-- Last modified  : Fri 22 Sep 2017 09:38:21 AM ICT
-- Desc           : 4 mode
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.config_pkg.all;

entity appx_div is
    port (
        clk         : in std_logic;
        num         : in unsigned(BIN_WIDTH - 1 downto 0);
        den         : in unsigned(CB_WIDTH - 1 downto 0);
        data_out    : out unsigned(HIST_WIDTH - 1 downto 0)
    );
end entity;

architecture behavior of appx_div is
    signal data_out_tmp     : unsigned(CB_WIDTH - 1 downto 0);
    signal select_condition : std_logic_vector(3 downto 0);
    signal num_mul_hist_bit : unsigned(CB_WIDTH - 1 downto 0);
    signal leftMostBit      : integer := 0;

    signal nearest_smaller_power_of_2        : unsigned (CB_WIDTH - 1 downto 0);
    signal nearest_smaller_add_one_quarter   : unsigned (CB_WIDTH - 1 downto 0);
    signal nearest_smaller_add_two_quarters  : unsigned (CB_WIDTH - 1 downto 0);
    signal nearest_smaller_add_three_quarters: unsigned (CB_WIDTH - 1 downto 0);
begin
    num_mul_hist_bit <= (to_unsigned(0, CB_WIDTH - BIN_WIDTH) & num)
                            sll HIST_WIDTH;

    leftMostBit <= mostLeftBit(den);

    process (num, den, leftMostBit)
    begin
            nearest_smaller_power_of_2          <= (others => '0');
            nearest_smaller_add_one_quarter     <= (others => '0');
            nearest_smaller_add_two_quarters    <= (others => '0');
            nearest_smaller_add_three_quarters  <= (others => '0');
        if (leftMostBit > 0) then
            nearest_smaller_power_of_2(leftMostBit - 1)         <= '1';
            nearest_smaller_add_one_quarter(leftMostBit - 1)    <= '1';
            nearest_smaller_add_two_quarters(leftMostBit - 1)   <= '1';
            nearest_smaller_add_three_quarters(leftMostBit - 1) <= '1';
        end if;
        if (leftMostBit > 1) then
            nearest_smaller_add_two_quarters(leftMostBit - 2)   <= '1';
            nearest_smaller_add_three_quarters(leftMostBit - 2) <= '1';
        end if;
        if (leftMostBit > 2) then
            nearest_smaller_add_one_quarter(leftMostBit - 3)    <= '1';
            nearest_smaller_add_three_quarters(leftMostBit - 3) <= '1';
        end if;
    end process;

    select_condition(0) <= '1'
        when (den >= nearest_smaller_power_of_2) else '0';
    select_condition(1) <= '1'
        when (den > nearest_smaller_add_one_quarter) else '0';
    select_condition(2) <= '1'
        when (den > nearest_smaller_add_two_quarters) else '0';
    select_condition(3) <= '1'
        when (den > nearest_smaller_add_three_quarters) else '0';

    with select_condition select
        data_out_tmp <= (num_mul_hist_bit srl leftMostBit)
                        + (num_mul_hist_bit srl (leftMostBit + 1))
                        + (num_mul_hist_bit srl (leftMostBit + 2)) when "0001",
                          (num_mul_hist_bit srl leftMostBit)
                        + (num_mul_hist_bit srl (leftMostBit + 1)) when "0011",
                          (num_mul_hist_bit srl leftMostBit)
                        + (num_mul_hist_bit srl (leftMostBit + 2)) when "0111",
                          (num_mul_hist_bit srl leftMostBit)       when "1111",
                          (num_mul_hist_bit)                       when others;

    output: process(clk)
    begin
        if rising_edge(clk) then
            if (den = to_unsigned(0, CB_WIDTH)) then
                data_out <= (others => '0');
            else
                data_out <= data_out_tmp(HIST_WIDTH - 1 downto 0);
            end if;
        end if;
    end process;
end behavior;

