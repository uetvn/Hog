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

entity tb_window_norm_comp is
        generic (DATA_WIDTH : integer := 32);
end tb_window_norm_comp;

architecture tb of tb_window_norm_comp is
    component window_norm_comp is
        generic (
            BIN_WIDTH       : integer := 16;
            DATA_WIDTH      : integer := 32
        );
        port (
            clk         : in std_logic;
            reset       : in std_logic;
            mode        : in std_logic_vector(1 downto 0);
            data_in     : in unsigned(DATA_WIDTH - 1 downto 0);
            data_out_1  : out unsigned(DATA_WIDTH - 1 downto 0);
            data_out_2  : out unsigned(DATA_WIDTH - 1 downto 0)
        );
    end component;

    signal data_in      : unsigned(DATA_WIDTH - 1 downto 0) := (others => '0');
    signal data_out_1   : unsigned(DATA_WIDTH - 1 downto 0) := (others => '0');
    signal data_out_2   : unsigned(DATA_WIDTH - 1 downto 0) := (others => '0');

    constant PERIOD : time := 100 ps;
    signal clk      : std_logic := '1';
    signal reset    : std_logic := '1';
    signal mode     : std_logic_vector(1 downto 0) := "00";

begin
    dut: window_norm_comp
    generic map(DATA_WIDTH => 32,
                BIN_WIDTH => 16)
    port map (clk => clk,
              reset => reset,
              mode => mode,
              data_in  => data_in,
              data_out_1 => data_out_1,
              data_out_2 => data_out_2);

    -- Clock generation
    clk <= not clk after PERIOD/2;
    reset <= '0' after PERIOD;

    --testbench: process
    --begin
    --    wait until reset = '0';

    --    -- Main simulation
    --    mode <= '1';
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
        variable oline1         : line;
        variable oline2         : line;
        variable aSpace         : character;
        variable v_data_in      : integer;
        variable v_data_out_1   : integer;
        variable v_data_out_2   : integer;

        file inf  : text;
        file ouf1 : text;
        file ouf2 : text;
    begin
        file_open(inf, "../cpp/cpp_block_inf.txt", read_mode);
        file_open(ouf1, "../cpp/rtl_block_ouf1.txt", write_mode);
        file_open(ouf2, "../cpp/rtl_block_ouf2.txt", write_mode);

        wait until reset = '0';
        mode <= "11";
        wait for PERIOD;

        while not endfile(inf) loop
            readline(inf, iline);
            read(iline, v_data_in);
            data_in <= to_unsigned(v_data_in, DATA_WIDTH);

            -- Wait for next input
            wait until rising_edge(clk);
            wait for PERIOD / 5.0;
            write(iline, string'("a="));

            -- Write odata
            write(oline1, to_integer(data_out_1), right, 10);
            writeline(ouf1, oline1);
            write(oline2, to_integer(data_out_2), right, 10);
            writeline(ouf2, oline2);
        end loop;
        file_close(inf);
        file_close(ouf1);
        file_close(ouf2);

        wait;
    end process READIO;
end tb;


configuration cfg_tb_window_norm_comp of tb_window_norm_comp is
    for tb
    end for;
end cfg_tb_window_norm_comp;

