--------------------------------------------------------------------------------
-- Project name   :
-- File name      : block_norm_comp.vhd
-- Created date   : Fri 15 Sep 2017 09:35:08 AM ICT
-- Author         : Huy-Hung Ho
-- Last modified  : Thu 28 Sep 2017 05:21:14 PM ICT
-- Desc           : 4 mode
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.config_pkg.all;

entity block_norm_comp is
    port (
        clk         : in std_logic;
        enable      : in std_logic;
        reset       : in std_logic;
        data_in     : in unsigned(DATA_WIDTH - 1 downto 0);
        data_out    : out unsigned(DATA_WIDTH - 1 downto 0)
    );
end entity;

architecture behavior of block_norm_comp is
    component appx_div is
        port (
            clk         : in std_logic;
            num         : in unsigned(DATA_WIDTH - 1 downto 0);
            den         : in unsigned(DATA_WIDTH - 1 downto 0);
            data_out    : out unsigned(DATA_WIDTH - 1 downto 0)
        );
    end component;

    -- 5 byte for 9 bin & 1 byte for cb
    constant CELL_WIDTH : integer := 192;
    --type CELL_BIN_TYPE is array (integer range <>) of unsigned;
    signal cell_bin_1   : unsigned(CELL_WIDTH - 1 downto 0);
    signal cell_bin_2   : unsigned(CELL_WIDTH - 1 downto 0);
    signal cell_bin_3   : unsigned(CELL_WIDTH - 1 downto 0);
    signal cell_bin_4   : unsigned(CELL_WIDTH - 1 downto 0);

    constant COUNTER_W  : integer := 5;
    signal sum_enable   : std_logic := '0';
    signal counter      : unsigned(COUNTER_W - 1 downto 0) := (others => '0');
    signal input_header : unsigned(DATA_WIDTH - 1 downto 0) := (others => '0');
    signal data_out_tmp_1 : unsigned(DATA_WIDTH - 1 downto 0) := (others => '0');
    signal data_out_tmp_2 : unsigned(DATA_WIDTH - 1 downto 0) := (others => '0');
    signal cb_tmp_1     : unsigned(DATA_WIDTH - 1 downto 0) := (others => '0');
    signal cb_tmp_2     : unsigned(DATA_WIDTH - 1 downto 0) := (others => '0');
    signal cb_sum_tmp   : unsigned(DATA_WIDTH - 1 downto 0) := (others => '0');
    signal cb_sum       : unsigned(DATA_WIDTH - 1 downto 0) := (others => '0');

    signal bin_1        : unsigned(DATA_WIDTH - 1 downto 0);
    signal bin_2        : unsigned(DATA_WIDTH - 1 downto 0);
begin

    count: process(clk, reset, enable)
    begin
        if (reset = '1') then
            counter <= (others => '0');
        elsif rising_edge(clk) then
            if (enable = '1') then
                if (sum_enable = '1') then
                    counter <= to_unsigned(2, COUNTER_W);
                else
                    counter <= counter + 1;
                end if;
            end if;
        end if;
    end process;

    sum_enable <= '1' when counter = to_unsigned(25, COUNTER_W) else '0';


    shift_reg: process(clk, reset, enable)
    begin
        if (reset = '1') then
            cell_bin_1 <= (others => '0');
            cell_bin_2 <= (others => '0');
            cell_bin_3 <= (others => '0');
            cell_bin_4 <= (others => '0');
        elsif rising_edge(clk) then
            if (enable = '1') then
                input_header <= cell_bin_4(DATA_WIDTH - 1 downto 0);

                cell_bin_4(CELL_WIDTH - DATA_WIDTH - 1 downto 0)
                    <= cell_bin_4(CELL_WIDTH - 1 downto DATA_WIDTH);
                cell_bin_4(CELL_WIDTH - 1 downto CELL_WIDTH - DATA_WIDTH)
                    <= cell_bin_3(DATA_WIDTH - 1 downto 0);

                cell_bin_3(CELL_WIDTH - DATA_WIDTH - 1 downto 0)
                    <= cell_bin_3(CELL_WIDTH - 1 downto DATA_WIDTH);
                cell_bin_3(CELL_WIDTH - 1 downto CELL_WIDTH - DATA_WIDTH)
                    <= cell_bin_2(DATA_WIDTH - 1 downto 0);

                cell_bin_2(CELL_WIDTH - DATA_WIDTH - 1 downto 0)
                    <= cell_bin_2(CELL_WIDTH - 1 downto DATA_WIDTH);
                cell_bin_2(CELL_WIDTH - 1 downto CELL_WIDTH - DATA_WIDTH)
                    <= cell_bin_1(DATA_WIDTH - 1 downto 0);

                cell_bin_1(CELL_WIDTH - DATA_WIDTH - 1 downto 0)
                    <= cell_bin_1(CELL_WIDTH - 1 downto DATA_WIDTH);
                cell_bin_1(CELL_WIDTH - 1 downto CELL_WIDTH - DATA_WIDTH)
                    <= data_in;
            end if;
        end if;
    end process;

    cb_tmp_1 <= cell_bin_1(CELL_WIDTH - 1 downto CELL_WIDTH - DATA_WIDTH)
              + cell_bin_2(CELL_WIDTH - 1 downto CELL_WIDTH - DATA_WIDTH);
    cb_tmp_2 <= cell_bin_3(CELL_WIDTH - 1 downto CELL_WIDTH - DATA_WIDTH)
              + cell_bin_4(CELL_WIDTH - 1 downto CELL_WIDTH - DATA_WIDTH);
    cb_sum_tmp <= cb_tmp_1 + cb_tmp_2;


    reg: process(reset, enable, clk)
    begin
        if (reset = '1') then
            cb_sum   <= (others => '0');
            data_out <= (others => '0');
        elsif rising_edge(clk) then
            if (enable = '1') then
                data_out <= data_out_tmp_1(BIN_WIDTH - 1 downto 0)
                          & data_out_tmp_2(BIN_WIDTH - 1 downto 0);
                if (sum_enable = '1') then
                    cb_sum <= cb_sum_tmp;
                end if;
            end if;
        end if;
    end process;

    bin_1 <= X"0000" & input_header(2 * BIN_WIDTH - 1 downto BIN_WIDTH);
    bin_2 <= X"0000" & input_header(BIN_WIDTH - 1 downto 0);

    division1: appx_div
    port map (num       => bin_1,
              den       => cb_sum,
              data_out  => data_out_tmp_1);

    division2: appx_div
    port map (num       => bin_2,
              den       => cb_sum,
              data_out  => data_out_tmp_2);

end behavior;
