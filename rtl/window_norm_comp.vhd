--------------------------------------------------------------------------------
-- Project name   :
-- File name      : window_norm_comp.vhd
-- Created date   : Fri 15 Sep 2017 09:35:08 AM ICT
-- Author         : Huy-Hung Ho
-- Last modified  : Thu 28 Sep 2017 05:21:14 PM ICT
-- Desc           : 4 mode
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.config_pkg.all;

entity window_norm_comp is
    generic (
        BIN_WIDTH       : integer := 16;
        DATA_WIDTH      : integer := 32
    );
    port (
        clk         : in std_logic;
        reset       : in std_logic;
        mode        : in std_logic_vector(1 downto 0);
        data_in     : in unsigned(DATA_WIDTH - 1 downto 0);
        push_data   : out std_logic;
        data_out_1  : out unsigned(DATA_WIDTH - 1 downto 0);
        data_out_2  : out unsigned(DATA_WIDTH - 1 downto 0)
    );
end entity;

architecture behavior of window_norm_comp is
    component approximatedDivision is
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
    end component;

    -- 5 byte for 9 bin & 1 byte for cb
    constant CELL_WIDTH : integer := 192;
    signal cell_bin_1   : unsigned(CELL_WIDTH - 1 downto 0);
    signal cell_bin_2   : unsigned(CELL_WIDTH - 1 downto 0);
    signal cell_bin_3   : unsigned(CELL_WIDTH - 1 downto 0);
    signal cell_bin_4   : unsigned(CELL_WIDTH - 1 downto 0);

    constant COUNTER_W  : integer := 5;
    constant COUNTER_B_W: integer := 5;
    signal sum_enable   : std_logic := '0';
    signal push_data_tmp: std_logic;
    signal counter      : unsigned(COUNTER_W - 1 downto 0);
    signal counter_block: unsigned(COUNTER_B_W - 1 downto 0);
    signal cb_tmp_1     : unsigned(DATA_WIDTH - 1 downto 0);
    signal cb_tmp_2     : unsigned(DATA_WIDTH - 1 downto 0);
    signal cb_sum_tmp   : unsigned(DATA_WIDTH - 1 downto 0);
    signal cb_sum       : unsigned(DATA_WIDTH - 1 downto 0);

    signal header_upper_cells   : unsigned(DATA_WIDTH - 1 downto 0);
    signal header_lower_cells   : unsigned(DATA_WIDTH - 1 downto 0);
    signal bin_head_upper_cells     : unsigned(DATA_WIDTH - 1 downto 0);
    signal bin_tail_upper_cells     : unsigned(DATA_WIDTH - 1 downto 0);
    signal bin_head_lower_cells     : unsigned(DATA_WIDTH - 1 downto 0);
    signal bin_tail_lower_cells     : unsigned(DATA_WIDTH - 1 downto 0);
    signal hog_bin_head_upper_cells    : unsigned(DATA_WIDTH - 1 downto 0);
    signal hog_bin_tail_upper_cells    : unsigned(DATA_WIDTH - 1 downto 0);
    signal hog_bin_head_lower_cells    : unsigned(DATA_WIDTH - 1 downto 0);
    signal hog_bin_tail_lower_cells    : unsigned(DATA_WIDTH - 1 downto 0);
begin

    count: process(clk, reset)
    begin
        if (reset = '1') then
            counter <= (others => '0');
        elsif rising_edge(clk) then
            if (mode /= "00") then
                if (sum_enable = '1') then
                    counter <= to_unsigned(14, COUNTER_W);
                else
                    counter <= counter + 1;
                end if;
            end if;
        end if;
    end process;

    sum_enable <= '1' when counter = to_unsigned(25, COUNTER_W) else '0';

    end_process: process(clk, reset)
    begin
        if (reset = '1') then
            push_data_tmp   <= '0';
            counter_block   <= (others => '0');
        elsif rising_edge(clk) then
            if (sum_enable = '1') then
                counter_block   <= counter_block + 1;
            end if;
            if (counter_block = to_unsigned(1, COUNTER_B_W)) then
                push_data_tmp <= '1';
            elsif (mode = "01" AND counter_block = to_unsigned(105, COUNTER_B_W)) then
                push_data_tmp <= '0';
            elsif (mode = "10" AND counter_block = to_unsigned(15, COUNTER_B_W)) then
                push_data_tmp <= '0';
            elsif (mode = "11" AND counter_block = to_unsigned(7, COUNTER_B_W)) then
                push_data_tmp <= '0';
            else
                push_data_tmp <= push_data_tmp;
            end if;
        end if;
    end process;

    shift_regs: process(clk, reset)
    begin
        if (reset = '1') then
            header_upper_cells <= (others => '0');
            header_lower_cells <= (others => '0');
            cell_bin_1 <= (others => '0');
            cell_bin_2 <= (others => '0');
            cell_bin_3 <= (others => '0');
            cell_bin_4 <= (others => '0');
        elsif rising_edge(clk) then
            if (mode /= "00") then
                header_upper_cells <= cell_bin_2(DATA_WIDTH - 1 downto 0);
                header_lower_cells <= cell_bin_4(DATA_WIDTH - 1 downto 0);

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


    reg: process(reset, clk)
    begin
        if (reset = '1') then
            cb_sum   <= to_unsigned(1, DATA_WIDTH);
        elsif rising_edge(clk) then
            if (sum_enable = '1') then
                cb_sum  <= cb_sum_tmp;
            end if;
        end if;
    end process;

    -- Two upper cells

    bin_head_upper_cells <= X"0000" & header_upper_cells(2 * BIN_WIDTH - 1 downto BIN_WIDTH);
    bin_tail_upper_cells <= X"0000" & header_upper_cells(BIN_WIDTH - 1 downto 0);

    divsion_upper_cell_1: approximatedDivision
    generic map (DATA_WIDTH => DATA_WIDTH)
    port map (clk       => clk,
              reset     => reset,
              num       => bin_head_upper_cells,
              den       => cb_sum,
              data_out  => hog_bin_head_upper_cells);

    division_upper_cell_2: approximatedDivision
    generic map (DATA_WIDTH => DATA_WIDTH)
    port map (clk       => clk,
              reset     => reset,
              num       => bin_tail_upper_cells,
              den       => cb_sum,
              data_out  => hog_bin_tail_upper_cells);

    data_out_1 <= hog_bin_head_upper_cells(BIN_WIDTH - 1 downto 0)
                  & hog_bin_tail_upper_cells(BIN_WIDTH - 1 downto 0)
              when push_data_tmp = '1' else (others => '0');

    -- Two lower cells
    bin_head_lower_cells <= X"0000" & header_lower_cells(2 * BIN_WIDTH - 1 downto BIN_WIDTH);
    bin_tail_lower_cells <= X"0000" & header_lower_cells(BIN_WIDTH - 1 downto 0);

    division_lower_cell_1: approximatedDivision
    generic map (DATA_WIDTH => DATA_WIDTH)
    port map (clk       => clk,
              reset     => reset,
              num       => bin_head_lower_cells,
              den       => cb_sum,
              data_out  => hog_bin_head_lower_cells);

    division_lower_cell_2: approximatedDivision
    generic map (DATA_WIDTH => DATA_WIDTH)
    port map (clk       => clk,
              reset     => reset,
              num       => bin_tail_lower_cells,
              den       => cb_sum,
              data_out  => hog_bin_tail_lower_cells);

    data_out_2 <= hog_bin_head_lower_cells(BIN_WIDTH - 1 downto 0)
                          & hog_bin_tail_lower_cells(BIN_WIDTH - 1 downto 0)
              when push_data_tmp = '1' else (others => '0');
    push_data <= push_data_tmp;
end behavior;
