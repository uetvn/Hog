--------------------------------------------------------------------------------
-- Project name   :
-- File name      : tb_approximatedDivision.vhd
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

entity tb_approximatedDivision is
        generic (DATA_WIDTH : integer := 32);
end tb_approximatedDivision;

architecture tb of tb_approximatedDivision is

    component approximatedDivision
        generic (DATA_WIDTH : integer := 32);
        port (num      : in unsigned (DATA_WIDTH - 1 downto 0);
              den      : in unsigned (DATA_WIDTH - 1 downto 0);
              data_out : out unsigned (DATA_WIDTH - 1 downto 0));
    end component;

    signal num      : unsigned (DATA_WIDTH - 1 downto 0);
    signal den      : unsigned (DATA_WIDTH - 1 downto 0);
    signal data_out : unsigned (DATA_WIDTH - 1 downto 0);

    constant PERIOD : time := 100 ps;
    signal clk      : std_logic := '1';
    signal reset    : std_logic := '1';

begin

    dut : approximatedDivision
    generic map (DATA_WIDTH => 32)
    port map (num      => num,
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
        file_open(inf, "/home/Working/Project/hog/cpp/inf.txt", read_mode);
        file_open(ouf, "/home/Working/Project/hog/cpp/ouf.txt", write_mode);

        wait until reset = '0';

        while not endfile(inf) loop
            readline(inf, iline);
            read(iline, v_num);
            read(iline, aSpace);
            read(iline, v_den);
            num <= to_unsigned(v_num, DATA_WIDTH);
            den <= to_unsigned(v_den, DATA_WIDTH);

            -- Wait for next input
            wait until rising_edge(clk);
            wait for PERIOD / 5.0;

            -- Write odata
            write(oline, to_integer(num), right, 10);
            write(oline, aSpace);
            write(oline, to_integer(den), right, 10);
            write(oline, aSpace);
            write(oline, to_integer(data_out), right, 10);
            write(oline, aSpace);
            writeline(ouf, oline);
        end loop;
        file_close(inf);
        file_close(ouf);

        wait;
    end process READIO;
end tb;
