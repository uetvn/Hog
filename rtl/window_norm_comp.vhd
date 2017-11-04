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
    port (
        clk         : in std_logic;
        reset       : in std_logic;
        enable      : in std_logic;
        mode        : in std_logic_vector(1 downto 0);
        data_in     : in unsigned(DATA_WIDTH - 1 downto 0);

        wr          : out std_logic;
        data_out_0  : out unsigned(HIST_WIDTH - 1 downto 0);
        data_out_1  : out unsigned(HIST_WIDTH - 1 downto 0);
        data_out_2  : out unsigned(HIST_WIDTH - 1 downto 0);
        data_out_3  : out unsigned(HIST_WIDTH - 1 downto 0)
    );
end entity;

architecture behavior of window_norm_comp is
    component appx_div is
        port (
            clk         : in std_logic;
            num         : in unsigned(BIN_WIDTH- 1 downto 0);
            den         : in unsigned(CB_WIDTH - 1 downto 0);
            data_out    : out unsigned(HIST_WIDTH - 1 downto 0)
        );
    end component;

    component sqrt32
        port (  data_in     : in  unsigned(31 downto 0);
                data_out    : out unsigned(15 downto 0)
            );
    end component;

   type BIN_CELL_TYPE is array (9 downto 0) of unsigned(BIN_WIDTH - 1 downto 0);
    signal bin_cell_0   : BIN_CELL_TYPE;
    signal bin_cell_1   : BIN_CELL_TYPE;
    signal bin_cell_2   : BIN_CELL_TYPE;
    signal bin_cell_3   : BIN_CELL_TYPE;

    constant BUFFER_SIZE    : integer := 4;
    type HEADER_TYPE is array(BUFFER_SIZE - 1 downto 0)
                        of unsigned(BIN_WIDTH - 1 downto 0);
    signal buffer_1         : HEADER_TYPE;
    signal buffer_2         : HEADER_TYPE;

    constant BIN_CNT_W  : integer := 4;
    signal bin_counter  : unsigned(BIN_CNT_W - 1 downto 0);

    constant BLOCK_CNT_W    : integer := 7;
    signal block_counter    : unsigned(BLOCK_CNT_W - 1 downto 0);
    signal end_w_counter    : unsigned(BLOCK_CNT_W - 1 downto 0);

    type CB_BLOCK_TYPE is array (3 downto 0) of unsigned(DATA_WIDTH - 1 downto 0);
    signal cb_block         : CB_BLOCK_TYPE;
    signal cb_sum           : unsigned(DATA_WIDTH - 1 downto 0);
    signal cb_sum_sqrt_tmp  : unsigned(CB_WIDTH - 1 downto 0);
    signal cb_sum_sqrt      : unsigned(CB_WIDTH - 1 downto 0);
    signal read_cb_enb      : std_logic;

    signal wr_enb           : std_logic;
    type HISTOGRAM_TYPE is array (3 downto 0) of unsigned(HIST_WIDTH - 1 downto 0);
    signal histogram        : HISTOGRAM_TYPE;
begin

    -- Case of DATA_WIDTH =  2 * CELL_WITH
    shift_bin_row: process(clk, reset)
    begin
        if (reset = '1') then
            bin_cell_0 <= (others => (others => '0'));
            bin_cell_1 <= (others => (others => '0'));
            bin_cell_2 <= (others => (others => '0'));
            bin_cell_3 <= (others => (others => '0'));
            cb_block   <= (others => (others => '0'));
            buffer_1   <= (others => (others => '0'));
            buffer_2   <= (others => (others => '0'));
        elsif rising_edge(clk) then
            if (enable = '1') then
                if (read_cb_enb = '0') then
                    bin_cell_0(9) <= data_in(DATA_WIDTH / 2 + BIN_WIDTH - 1
                                               downto DATA_WIDTH / 2);
                    bin_cell_1(9) <= bin_cell_0(1);
                    bin_cell_2(9) <= bin_cell_1(1);
                    bin_cell_3(9) <= bin_cell_2(1);

                    bin_cell_0(8) <= data_in(BIN_WIDTH - 1 downto 0);
                    bin_cell_1(8) <= bin_cell_0(0);
                    bin_cell_2(8) <= bin_cell_1(0);
                    bin_cell_3(8) <= bin_cell_2(0);

                    bin_cell_0(7) <= bin_cell_0(9);
                    bin_cell_1(7) <= bin_cell_1(9);
                    bin_cell_2(7) <= bin_cell_2(9);
                    bin_cell_3(7) <= bin_cell_3(9);

                    for i in 0 to 6 loop
                        bin_cell_0(i) <= bin_cell_0(i + 2);
                        bin_cell_1(i) <= bin_cell_1(i + 2);
                        bin_cell_2(i) <= bin_cell_2(i + 2);
                        bin_cell_3(i) <= bin_cell_3(i + 2);
                    end loop;

                    buffer_1(1 downto 0) <= bin_cell_3(1 downto 0);
                    buffer_2(1 downto 0) <= bin_cell_1(1 downto 0);
                else
                    cb_block(0) <= data_in;
                    cb_block(1) <= cb_block(0);
                    cb_block(2) <= cb_block(1);
                    cb_block(3) <= cb_block(2);
                end if;
            end if;
        end if;
    end process;

    -- NOTE: reset, enable, mode, addr_rom, addr_bin, wr_enb
    ouput_ctrl: process(clk, reset)
    begin
        if (reset = '1') then
            end_w_counter       <= (others => '0');
            wr_enb              <= '0';
        elsif rising_edge(clk) then
            if (enable = '1') then
                case mode is
                    when "00"   => end_w_counter <= "1101001";
                    when "01"   => end_w_counter <= "0000111";
                    when "10"   => end_w_counter <= "0001111";
                    when others => end_w_counter <= (others => '0');
                end case;

                if (block_counter = to_unsigned(2, BLOCK_CNT_W)
                    and bin_counter = to_unsigned(2, BIN_CNT_W)) then
                    wr_enb <= '1';
                elsif (block_counter = end_w_counter) then
                    wr_enb <= '0';
                end if;
            end if;
        end if;
    end process;

    counter: process(clk, reset)
    begin
        if (reset = '1') then
            bin_counter         <= (others => '0');
            block_counter       <= (others => '0');
        elsif rising_edge(clk) then
            if (enable = '1') then
                if (bin_counter = to_unsigned(12, BIN_CNT_W)) then
                    bin_counter <= to_unsigned(1, BIN_CNT_W);
                else
                    bin_counter <= bin_counter + 1;
                end if;

                if (bin_counter = to_unsigned(12, BIN_CNT_W)) then
                    block_counter <= block_counter + 1;
                else
                    block_counter <= block_counter;
                end if;
            end if;
        end if;
    end process;

    read_cb_enb <= '1' when (bin_counter = to_unsigned(6, BIN_CNT_W)
                          or bin_counter = to_unsigned(12, BIN_CNT_W)) else '0';

    cb_sum <= (cb_block(0) + cb_block(1)) + (cb_block(2) + cb_block(3));

    sqrt: sqrt32
        port map(data_in  => cb_sum,
                 data_out => cb_sum_sqrt_tmp);

    -- Calculate sum of cb (denominator)
    reg: process(reset, clk)
    begin
        if (reset = '1') then
            cb_sum_sqrt          <= (others => '0');
        elsif rising_edge(clk) then
            if (bin_counter = to_unsigned(1, BIN_CNT_W)) then
                cb_sum_sqrt      <= cb_sum_sqrt_tmp;
            end if;
        end if;
    end process;

    -- Calculate histogram by division between bin and sum of cb
    div0: appx_div port map (clk, buffer_1(0), cb_sum_sqrt, histogram(0));
    div1: appx_div port map (clk, buffer_1(1), cb_sum_sqrt, histogram(1));

    div2: appx_div port map (clk, buffer_2(0), cb_sum_sqrt, histogram(2));
    div3: appx_div port map (clk, buffer_2(1), cb_sum_sqrt, histogram(3));

    out_enable: process(reset, clk)
    begin
        if (reset = '1') then
            wr             <= '0';
            data_out_0     <= (others => '0');
            data_out_1     <= (others => '0');
            data_out_2     <= (others => '0');
            data_out_3     <= (others => '0');
        elsif rising_edge(clk) then
            wr  <= wr_enb;

            if (wr_enb = '1') then
                data_out_0 <= histogram(0);
                data_out_1 <= histogram(1);
                data_out_2 <= histogram(2);
                data_out_3 <= histogram(3);
            end if;
        end if;
    end process;
end behavior;
