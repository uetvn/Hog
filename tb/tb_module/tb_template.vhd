
--------------------------------------------------------------------------------
-- Project name   :
-- File name      : tb_.vhd
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

entity tb_ is
end tb_;

architecture arch of tb_ is
    signal data_in      : unsigned(DATA_WIDTH - 1 downto 0) := (others => '0');
    signal data_out     : unsigned(DATA_WIDTH - 1 downto 0) := (others => '0');

    constant PERIOD : time := 100 ps;
    signal clk      : std_logic := '1';
    signal reset    : std_logic := '1';
    signal enable   : std_logic := '0';

begin

    READIO : process
        variable iline          : line;
        variable oline          : line;
        variable aSpace         : character;
        variable v_data_in      : integer;
        variable v_data_out     : integer;

        file inf : text;
        file ouf : text;
    begin
        --file_open(inf, "tb_inf.txt", read_mode);
        --file_open(ouf, "tb_ouf.txt", write_mode);

        wait until reset = '0';
        enable <= '1';
        wait for PERIOD;

        <F6>

        --while not endfile(inf) loop
        --    readline(inf, iline);
        --    read(iline, v_data_in);
        --    data_in <= to_unsigned(v_data_in, DATA_WIDTH);

        --    -- Wait for next input
        --    wait until rising_edge(clk);
        --    wait for PERIOD / 5.0;

        --    -- Write odata
        --    write(oline, to_integer(data_out), right, 10);
        --    writeline(ouf, oline);
        --end loop;
        --file_close(inf);
        --file_close(ouf);

        wait;
    end process READIO;
end tb;