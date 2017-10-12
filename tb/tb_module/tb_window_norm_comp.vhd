--------------------------------------------------------------------------------
-- Project name   :
-- File name      : tb_window_norm_comp.vhd
-- Created date   : Fri 22 Sep 2017 10:24:04 AM ICT
-- Author         : Huy-Hung Ho
-- Last modified  : Fri 29 Sep 2017 10:37:20 AM ICT
-- Desc           :
--------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;
use ieee.std_logic_textio.all;
use work.config_pkg.all;

entity tb_window_norm_comp is
end tb_window_norm_comp;

architecture tb of tb_window_norm_comp is
    component window_norm_comp is
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
    end component;

    constant PERIOD : time := 100 ps;
    signal clk      : std_logic := '1';
    signal reset    : std_logic := '1';
    signal enable   : std_logic := '0';
    signal mode     : std_logic_vector(1 downto 0) := "00";
    signal data_in  : unsigned(DATA_WIDTH - 1 downto 0) := (others => '0');

    signal wr           : std_logic := '0';
    signal data_out_0   : unsigned(HIST_WIDTH - 1 downto 0) := (others => '0');
    signal data_out_1   : unsigned(HIST_WIDTH - 1 downto 0) := (others => '0');
    signal data_out_2   : unsigned(HIST_WIDTH - 1 downto 0) := (others => '0');
    signal data_out_3   : unsigned(HIST_WIDTH - 1 downto 0) := (others => '0');
begin
    dut: window_norm_comp
    port map (clk       => clk,
              reset     => reset,
              enable    => enable,
              mode      => mode,
              data_in   => data_in,
              wr        => wr,
              data_out_0 => data_out_0,
              data_out_1 => data_out_1,
              data_out_2 => data_out_2,
              data_out_3 => data_out_3);

    -- Clock generation
    clk <= not clk after PERIOD/2;
    reset <= '0' after PERIOD;

    --testbench: process
    --begin
    --    wait until reset = '0';

    --    -- Main simulation
    --    enable <= '1';
    --    wait for PERIOD;
    --    for i in 1 to 100 loop
    --        data_in <= to_unsigned(i*100, DATA_WIDTH);
    --        wait for PERIOD;
    --    end loop;

    --    wait for PERIOD;
    --    wait;
    --end process;

    READIO : process
        variable iline          : line;
        variable oline          : line;
        variable aSpace         : character;
        variable v_data_in      : integer;
        variable v_data_out_1   : integer;
        variable v_data_out_2   : integer;
        variable counter        : integer := 0;

        file inf : text;
        file ouf : text;
    begin
        file_open(inf, "../cpp/text/window_inf.txt", read_mode);
        file_open(ouf, "../cpp/text/window_ouf_rtl.txt", write_mode);

        wait until reset = '0';
        enable  <= '1';
        mode    <= "00";
        counter := 0;
        wait for PERIOD;

        while not endfile(inf) loop
            readline(inf, iline);
            read(iline, v_data_in);
            data_in <= to_unsigned(v_data_in, DATA_WIDTH);

            -- Wait for next input
            wait until rising_edge(clk);
            --wait for PERIOD / 5.0;

            -- Write odata
            if (counter > 26 and counter mod 6 /= 1) then
                write(oline, to_integer(data_out_0), right, 10);
                write(oline, to_integer(data_out_1), right, 10);
                write(oline, to_integer(data_out_2), right, 10);
                write(oline, to_integer(data_out_3), right, 10);
                writeline(ouf, oline);
            end if;
            counter := counter + 1;
        end loop;
        file_close(inf);
        file_close(ouf);

        wait;
    end process READIO;
end tb;
