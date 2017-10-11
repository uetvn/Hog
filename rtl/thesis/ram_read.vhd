--------------------------------------------------------------------------------
-- Project name   : Human detection by HOG
-- File name      : ram_read.vhd
-- Created date   : Fri 05 May 2017
-- Author         : Huy Hung Ho
-- Last modified  : Fri 05 May 2017
-- Desc           :
    -- h_det_bl = w_cell
    -- v_det_bl = h_cell
    -- H_bl_size = w_bl
    -- V_bl_size = h_bl
    -- h_bl_bits = w_win_bits
    -- v_bl_bits = h_win_bits
    -- No_cols = w_win
    -- No_lines = h_win
--------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;

entity read_mem is
    generic (
        w_cell:     integer := 3;   -- width detect window in block: 8
        h_cell:     integer := 5;   -- height detect window in block: 8
        w_bl:       integer := 8;   -- width block: 16
        h_bl:       integer := 12;  -- height block: 16
        counter_8:  integer := 3;
        counter_60: integer := 6;
        counter_80: integer := 7;
        w_win_bits: integer := 10;  -- number of bit for 624 (640)
        w_win_bits: integer := 9:   -- number of bit for 464 (480)
        bits_rom_cnt:   integer := 7;
        bias:       integer := 20;
        threshold:  integer := -2000;
        w_win:      integer := 96;  -- column: 128
        h_win:     integer := 64:  -- line: 64
        lines_cut:  integer := 8;   -- contour
        pixel_width:    integer := 8
    )
	port (
        clk:        in std_logic;
        start_stop: in std_logic;
        rd_memory:  in std_logic;
        mem_clas:   out std_logic_vector(12 downto 0)
	);
end read_mem;

architecture behav of read_mem is
    signal  X_bl:       std_logic_vector(2 downto 0);   -- count to 8 - 1
    signal  Y_bl:       std_logic_vector(3 downto 0);   -- count to 8 - 1
    signal  w_count:    std_logic_vector(5 downto 0);   -- count to 16 - 8
    signal  h_count:    std_logic_vector(5 downto 0);   -- count to 16 - 8
    signal  shift:      std_logic;
    signal  columns:    std_logic_vector(5 downto 0);   -- ver_block
    signal  rows:       std_logic_vector(6 downto 0);   -- hor_block
begin
    class_mem_pointer:
    process (clk, X_bl, Y_bl, w_count, h_count, shift, start_stop)
    begin
        if start_stop = '1' then
            X_bl    <= (others => '0');     -- (0 -> 7)
            Y_bl    <= (others => '0');     -- (0 -> 7)
            w_count  <= (others => '0');    -- (0 -> 7)
        else
            if rising_edge(clk) then
                if rd_memory = '1' then
                    if X_bl = conv_std_logic_vector(w_cell - 1, 3) then
                        X_bl <= (others => '0');
                        if Y_bl = conv_std_logic_vector(h_cell - 1, 4) then
                            Y_bl <= (others => '0');
                            if w_count = conv_std_logic_vector(w_bl - w_cell,
                            6) then
                                if h_count = conv_std_logic_vector(h_bl - w_cell,
                                6) then
                                    h_count <= (others => '0');
                                else
                                    h_count <= h_count + 1;
                                end if;

                                w_count <= (others => '0');
                            else
                                w_count <= w_count + 1;
                            end if;
                        else
                            Y_bl <= Y_bl + 1;
                        end if;
                    else
                        X_bl <= X_bl + 1;
                    end if;
                end if;
            end if;
        end if;
    end process;

    mem_clas <= ((h_count) * conv_std_logic_vector(w_bl, 7)) + Y_bl *
                conv_std_logic_vector(w_bl, 7) + (w_count + X_bl);
end behav;

