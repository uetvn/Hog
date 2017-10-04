
--------------------------------------------------------------------------------
-- Project name   :
-- File name      : approximatedDivision.vhd
-- Created date   : Fri 15 Sep 2017 09:35:08 AM ICT
-- Author         : Huy-Hung Ho
-- Last modified  : Fri 22 Sep 2017 09:38:21 AM ICT
-- Desc           : 4 mode
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.config_pkg.all;

entity approximatedDivision is
    generic (
        DATA_WIDTH: integer := 32
    );
    port (
        clk         : in std_logic;
        reset       : in std_logic;
        num         : in unsigned(DATA_WIDTH - 1 downto 0);
        den         : in unsigned(DATA_WIDTH - 1 downto 0);
        data_out    : out unsigned(DATA_WIDTH - 1 downto 0)
    );
end entity;

architecture behavior of approximatedDivision is
    signal s_condition_selection    : std_logic_vector(3 downto 0);
    signal leftMostBit      : integer := 0;
    signal num_shift_16_bit : unsigned(DATA_WIDTH - 1 downto 0);
    signal s_data_out_tmp   : unsigned(DATA_WIDTH - 1 downto 0);

    signal nearest_smaller_power_of_2       : unsigned (DATA_WIDTH - 1 downto 0);
    signal nearest_smaller_add_one_quarter  : unsigned (DATA_WIDTH - 1 downto 0);
    signal nearest_smaller_add_two_quarters  : unsigned (DATA_WIDTH - 1 downto 0);
    signal nearest_smaller_add_three_quarters: unsigned (DATA_WIDTH - 1 downto 0);
begin
    num_shift_16_bit <= num sll 16;

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

    s_condition_selection(0) <= '1'
        when (den >= nearest_smaller_power_of_2) else '0';
    s_condition_selection(1) <= '1'
        when (den > nearest_smaller_add_one_quarter) else '0';
    s_condition_selection(2) <= '1'
        when (den > nearest_smaller_add_two_quarters) else '0';
    s_condition_selection(3) <= '1'
        when (den > nearest_smaller_add_three_quarters) else '0';

    with s_condition_selection select
        s_data_out_tmp <= (num_shift_16_bit srl leftMostBit)
                        + (num_shift_16_bit srl (leftMostBit + 1))
                        + (num_shift_16_bit srl (leftMostBit + 2)) when "0001",
                          (num_shift_16_bit srl leftMostBit)
                        + (num_shift_16_bit srl (leftMostBit + 1)) when "0011",
                          (num_shift_16_bit srl leftMostBit)
                        + (num_shift_16_bit srl (leftMostBit + 2)) when "0111",
                          (num_shift_16_bit srl leftMostBit)       when "1111",
                          (num_shift_16_bit)                       when others;

    output: process(clk, reset)
    begin
        if (reset = '1') then
            data_out <= (others => '0');
        elsif rising_edge(clk) then
            data_out <= s_data_out_tmp;
        end if;
    end process;
end behavior;

