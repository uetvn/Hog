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
        pixel_width:    integer := 8;
        cell_border:    integer := 10
    );
	port (
        clk, clr:   IN std_logic;
        enable:     IN std_logic;
        data_in:    IN std_logic_vector(pixel_width-1 downto 0);
        Gx, Gy:     OUT std_logic_vector(pixel_width-1 downto 0)
	);
end cal_gradient;

architecture behav of cal_gradient is
    component byte_buf is
		port (
			clk, clr:	IN std_logic;
			byte_in:	IN std_logic_vector(pixel_width-1 downto 0);
			byte_out:	OUT std_logic_vector(pixel_width-1 downto 0)
		);
    end component;
    component n_bits_sub is
		port (
            clk:	IN std_logic;
            A, B:	IN std_logic_vector(pixel_width-1 downto 0);
            sub:	OUT std_logic_vector(pixel_width-1 downto 0)
        );
    end component;

    subtype byte is std_logic_vector(pixel_width-1 downto 0);
    type    doub_rows_type is array(2*cell_border-1 downto 0) of
    std_logic_vector(pixel_width-1 downto 0);
	 signal	doub_rows:  doub_rows_type  := (others => (others => '1'));

    signal  Gx_temp, Gy_temp:   std_logic_vector(pixel_width-1 downto 0);
    signal  Gx3, Gx1, Gy3, Gy1: std_logic_vector(pixel_width-1 downto 0);
    signal  col_cnt, row_cnt:   integer := 0;
begin
    sub_1: component n_bits_sub
        port map (clk, Gx3, Gx1, Gx_temp);

    sub_2: component n_bits_sub
        port map (clk, Gy3, Gy1, Gy_temp);

    -- h3_cmt: could I use: double_rows << pixel_width;
    transfer: for i in 2*cell_border-1 downto 1 generate
        transfer_i: byte_buf
		    port map (clk, clr, doub_rows(i-1), doub_rows(i));
    end generate;


    process(clk, clr)
    begin
        if clr = '1' then
            Gx1 <= (others => '0');
            Gx3 <= (others => '0');
            Gy1 <= (others => '0');
            Gy3 <= (others => '0');
        else
            if rising_edge(clk) then
                    if col_cnt >= 0 and col_cnt < cell_h+1 then
                        if row_cnt > 1 and row_cnt < cell_w+1 then
                            Gx1 <= doub_rows(2 * cell_border - 1);
                            Gx3 <= data_in;
                            Gy1 <= doub_rows(cell_border);
                            Gy3 <= doub_rows(cell_border - 2);
					    end if;
                    end if;
            end if;
        end if;
    end process;

    counter: process(clk, clr)
    begin
        if clr = '1' then
            row_cnt <= 0;
            col_cnt <= -1;
        else
            if rising_edge(clk) then
                doub_rows(0) <= data_in;
                if col_cnt >= 0 and col_cnt < cell_h+1 then
                    if row_cnt > 1 and row_cnt < cell_w+1 then
                        Gx  <= Gx_temp;
                        Gy  <= Gy_temp;
                    end if;
                end if;

                if col_cnt = cell_border-1 then
                    col_cnt <= 0;
                    row_cnt <= row_cnt + 1;
                else
                    col_cnt <= col_cnt + 1;
                end if;
            end if;
        end if;
	end process;
end behav;
