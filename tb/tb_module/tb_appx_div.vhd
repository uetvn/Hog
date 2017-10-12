--------------------------------------------------------------------------------
-- Project name   :
-- File name      : tb_appx_div.vhd
-- Created date   : Fri 22 Sep 2017 10:24:04 AM ICT
-- Author         : Huy-Hung Ho
-- Last modified  : Fri 22 Sep 2017 10:24:04 AM ICT
-- Desc           :
--------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;
use ieee.std_logic_textio.all;
use work.config_pkg.all;

entity tb_appx_div is
end tb_appx_div;

architecture tb of tb_appx_div is

    component appx_div
        port (
            clk     : in std_logic;
            num      : in unsigned (BIN_WIDTH- 1 downto 0);
            den      : in unsigned (CB_WIDTH - 1 downto 0);
            data_out : out unsigned (HIST_WIDTH - 1 downto 0)
        );
    end component;

    signal num      : unsigned (BIN_WIDTH - 1 downto 0);
    signal den      : unsigned (CB_WIDTH - 1 downto 0);
    signal data_out : unsigned (HIST_WIDTH - 1 downto 0);

    constant PERIOD : time := 100 ps;
    signal clk      : std_logic := '1';
    signal reset    : std_logic := '1';

begin

    dut : appx_div
    port map (clk      => clk,
              num      => num,
              den      => den,
              data_out => data_out);

    -- Clock generation
    clk <= not clk after PERIOD/2;
    reset <= '0' after 3 * PERIOD;

    READIO : process
        variable iline          : line;
        variable oline          : line;
        variable aSpace         : character;
        variable v_num          : integer;
        variable v_den          : integer;
        variable v_data_out     : integer;

        file inf : text;
        file ouf : text;
    begin
        file_open(inf, "/home/Working/Project/hog/cpp/text/inf.txt", read_mode);
        file_open(ouf, "/home/Working/Project/hog/cpp/text/ouf.txt", write_mode);

        wait until reset = '0';

        while not endfile(inf) loop
            readline(inf, iline);
            read(iline, v_num);
            read(iline, aSpace);
            read(iline, v_den);
            num <= to_unsigned(v_num, BIN_WIDTH);
            den <= to_unsigned(v_den, CB_WIDTH);

            -- Wait for next input
            wait until rising_edge(clk);
            wait for PERIOD / 5.0;

            -- Write odata
            write(oline, to_integer(num), right, 10);
            write(oline, aSpace);
            write(oline, to_integer(den), right, 10);
            write(oline, aSpace);
            write(oline, to_integer(data_out), right, 10);
            writeline(ouf, oline);
        end loop;
        file_close(inf);
        file_close(ouf);

        wait;
    end process READIO;
end tb;
