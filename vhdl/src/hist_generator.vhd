--------------------------------------------------------------------------------
-- Project name   : Human detection by HOG
-- File name      : hist_generator.vhd
-- Created date   : Wed 24 May 2017
-- Author         : Huy Hung Ho
-- Last modified  : Wed 24 May 2017
-- Desc           :
--------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity hist_generator is
    generic (
        cell_w:         integer := 8;
        cell_h:         integer := 8;
        cell_width:     integer := 3;
        window_w:       integer := 64;
        window_h:       integer := 128;
        columns:        integer := 15;
        rows:           integer := 7;
        pixel_width:    integer := 8
    );
	port (
        clk, clr:   IN std_logic;
        enable:     IN std_logic;
        Gx_row:     IN std_logic_vector(63 downto 0);
        Gy_row:     IN std_logic_vector(63 downto 0);

        hist_out:   OUT std_logic_vector()
	);
end hist_generator;

architecture behav of hist_generator is

begin
end behav;

