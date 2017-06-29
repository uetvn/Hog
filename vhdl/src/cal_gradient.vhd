--------------------------------------------------------------------------------
-- Project name   : Human detection by HOG
-- File name      : cal_gradient.vhd
-- Created date   : Mon 15 May 2017
-- Author         : Huy Hung Ho
-- Last modified  : Mon 15 May 2017
-- Desc           : Calculate gradient vector
--------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity cal_gradient is
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
        data_in:    IN std_logic_vector(79 downto 0);
        Gx_row:     OUT std_logic_vector(63 downto 0);
        Gy_row:     OUT std_logic_vector(63 downto 0)
	);
end cal_gradient;

architecture behav of cal_gradient is
    	component RegN is
        	generic (N: integer := 8);
			port (
				clk:    IN std_logic;
		    		enable:	IN std_logic;
				Din:	IN std_logic_vector(N - 1 downto 0);
				Dout:	OUT std_logic_vector(N - 1 downto 0)
			);
	end component;

	component n_bits_sub is
		port (
			A, B:	IN std_logic_vector(pixel_width-1 downto 0);
		    	sub:	OUT std_logic_vector(pixel_width-1 downto 0)
		);
	end component;

    	subtype byte is std_logic_vector(pixel_width-1 downto 0);
    	type    row_extend_type is array(cell_w + 1 downto 0) of byte;
    	type    row_type 	is array(cell_w - 1 downto 0) of byte;

	signal	row0, row1, row2:    	row_extend_type;
	signal  Gx_row_tmp, Gy_row_tmp:	row_type;
	signal  en, en1, en2:       	std_logic := '1';
begin
	transfer23: for i in 0 to cell_w + 1 generate
		transfer23_i: RegN generic map (pixel_width)
			    port map (clk, en2, row1(i), row2(i));
	end generate;

	transfer12: for i in 0 to cell_w + 1 generate
		transfer12_i: RegN generic map (pixel_width)
			    port map (clk, en1, row0(i), row1(i));
	end generate;

	-- control points
	row0(0) <= data_in(7 downto 0);
	row0(1) <= data_in(15 downto 8);
	row0(2) <= data_in(23 downto 16);
	row0(3) <= data_in(31 downto 24);
	row0(4) <= data_in(39 downto 32);
	row0(5) <= data_in(47 downto 40);
	row0(6) <= data_in(55 downto 48);
	row0(7) <= data_in(63 downto 56);
	row0(8) <= data_in(71 downto 64);
	row0(9) <= data_in(79 downto 72);

	sub_1: for i in 0 to cell_w-1 generate
		sub1_i: n_bits_sub
		    port map(row1(i+2), row1(i), Gx_row_tmp(i));
	end generate;

	sub_2: for i in 0 to cell_w-1 generate
		sub1_i: n_bits_sub
		    port map(row0(i+1), row2(i+1), Gy_row_tmp(i));
	end generate;

	Gx_rowy_out: for i in 0 to cell_w-1 generate
		Gx_row_i: RegN generic map(pixel_width)
		    port map (clk, en, Gx_row_tmp(i), Gx_row(8*i+7 downto 8*i));
		Gy_row_i: RegN generic map(pixel_width)
		    port map (clk, en, Gy_row_tmp(i), Gy_row(8*i+7 downto 8*i));
	end generate;

	controller: process(clk, clr)
	begin
		if clr = '1' then
		    en  <= '0';
		    en1 <= '0';
		    en2 <= '0';
		else
		    if rising_edge(clk) then
			en  <= '1';
			en1 <= '1';
			en2 <= '1';
		    end if;
		end if;
	end process;
end behav;
