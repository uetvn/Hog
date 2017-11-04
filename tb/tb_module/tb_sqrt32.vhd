--------------------------------------------------------------------------------
-- Project name   :
-- File name      : tb_sqrt32.vhd
-- Created date   : Mon 16 Oct 2017 01:06:21 PM ICT
-- Author         : Huy-Hung Ho
-- Last modified  : Mon 16 Oct 2017 01:06:21 PM ICT
-- Desc           :
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sqrt32_tb is
end;

architecture bench of sqrt32_tb is
    component sqrt32
        port (  data_in     : in  unsigned(31 downto 0);
                data_out    : out unsigned(15 downto 0)
            );
    end component;

    signal data_in: unsigned(31 downto 0)   := (others => '0');
    signal data_out: unsigned(15 downto 0)  := (others => '0');
begin
    uut: sqrt32 port map ( data_in => data_in,
                           data_out => data_out);

    stimulus: process
    begin
        wait for 100 ns;

        for i in 0 to 2**16 - 1 loop
            data_in <= to_unsigned(i, 32);
            wait for 100 ns;
        end loop;

        wait;
  end process;
end bench;
