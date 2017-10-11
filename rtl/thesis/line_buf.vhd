--------------------------------------------------------------------------------
-- Project name   : Human detection by HOG
-- File name      : line_register.vhd
-- Created date   : Mon 08 May 2017
-- Author         : Huy Hung Ho
-- Last modified  : Mon 08 May 2017
-- Desc           :
--------------------------------------------------------------------------------

library ieee ;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity line_buf is
	generic (
		w_cell:	integer := 2;
		h_cell:	integer := 4;
		w_bl:	integer := 10;
		h_bl:	integer := 6;
		counter_8:	integer := 3;
		counter_60: integer := 6;
		counter_80: integer := 7;
		cols_width:     integer := 10;
		lines_width:	integer := 9;
		bits_rom_cnt:	integer := 7;
		bias:		integer := 20;
		threshold:	integer := -2000;
		columns_win:	integer := 32;  -- columns
		rows_win:	integer := 24;  -- rows
		lines_cut:	integer := 8;
		pixel_width:	integer := 8
	);
	port (
		ser_data:	in std_logic_vector (pixel_width-1 downto 0);
		clk, clr:	in std_logic;
		sign_en:	out std_logic;
		init:		buffer std_logic;
		h_sync,w_sync:	in std_logic;
		Gx, Gy:		out std_logic_vector (pixel_width-1 downto 0)
	) ;
end line_buf;

Architecture line_buf of line_buf is
	component byte_buf
		port (
			clk, clr:	in std_logic;
			enable:		in std_logic;
			byte_in:	in std_logic_vector (7 downto 0);
			byte_out:	out std_logic_vector (7 downto 0)
		);
	end component;

	component bit_buf
		port (
			clk, clr:	in std_logic;
			bit_in:		in std_logic;
			bit_out:	out std_logic
		);
	end component;

	component n_bits_sub
		port (
            A,B:	IN std_logic_vector(pixel_width-2 downto 0);
            sub:	OUT std_logic_vector(pixel_width-1 downto 0);
            clk:	IN std_logic
        );
	end component;

	subtype BYTE is std_logic_vector(7 downto 0);
	type	transfer_byte is array (2*columns_win downto 0) of BYTE;

	signal out_sign:		transfer_byte;
	signal first_byte:		std_logic_vector(7 downto 0);
	signal valid, valid2:	std_logic;
	signal valid_en:		std_logic;
	signal delayed_V_sync:	std_logic;
	signal col_cnt:			std_logic_vector (cols_width-1 downto 0);
	signal line_cnt:		std_logic_vector (lines_width-1 downto 0);
	signal Gx_temp, Gy_temp:	std_logic_vector (pixel_width-1 downto 0);
	signal temp_s1, temp_s2:	std_logic;
	signal Gx1, Gx3:		std_logic_vector (pixel_width-1 downto 0);
	signal Gy1, Gy3:		std_logic_vector (pixel_width-1 downto 0);
begin
	init_signal: component bit_buf
		port map (clk, clr, h_sync, delayed_V_sync);

	valid_signal : component bit_buf
		port map (clk, clr, valid, valid2);

	temp_signal2: component bit_buf
		port map (clk, clr, temp_s2, sign_en);

	sub_1: component n_bits_sub
		port map ( Gx3(pixel_width-1 downto 1), Gx1(pixel_width-1 downto 1), Gx_temp, clk); -- ~0 delay

	sub_2: component n_bits_sub
		port map ( Gy3 (pixel_width-1 downto 1), Gy1 (pixel_width-1 downto 1), Gy_temp, clk);

	linebuf: for i in 1 to 2 * columns_win generate
		linebuf_i: component byte_buf
            port map (clk, clr, valid, out_sign(i-1), out_sign(i));
	end generate ;

	process (clr, clk, valid, col_cnt, line_cnt, w_sync, ser_data, out_sign, init)
	begin
		if clr = '1' then
			Gx3 <= (others => '0');
			Gx1 <= (others => '0');
			Gy3 <= (others => '0');
			Gy1 <= (others => '0');
		else
			if rising_edge(clk) then
				init <= (delayed_V_sync OR h_sync) XOR h_sync;
				out_sign(0) <= ser_data;
				if valid2 = '1' then
					if col_cnt > conv_std_logic_vector (1, cols_width) and
                    col_cnt < conv_std_logic_vector (columns_win-2 , cols_width) then
						if line_cnt > conv_std_logic_vector (2,lines_width) and
                        line_cnt < conv_std_logic_vector (rows_win , lines_width) then
							Gx1 <= out_sign(columns_win);
							Gx3 <= out_sign(columns_win-2);
							Gy3 <= ser_data;
							Gy1 <= out_sign(2*columns_win-1);
						end if;
					end if;
				end if;
			end if;
		end if;
	end process;

	process (clr, clk, col_cnt, line_cnt, valid, valid2, init, Gx_temp, Gy_temp)
	begin
		if clr = '1' then
			line_cnt <= (others => '0');
			col_cnt <= (others => '0');
		else
			if rising_edge(clk) then
                valid <= w_sync and h_sync;
                if valid2= '1' then
					if col_cnt > conv_std_logic_vector (lines_cut+1, cols_width) and col_cnt <
					conv_std_logic_vector (columns_win-lines_cut+2 , cols_width) then
						if line_cnt > conv_std_logic_vector (lines_cut+1, lines_width) and line_cnt <
						conv_std_logic_vector (rows_win -lines_cut+2, lines_width) then
							Gx <= Gx_temp;
							Gy <= Gy_temp;
						end if;
					end if;

					if col_cnt > conv_std_logic_vector (lines_cut+1, cols_width) and col_cnt <
					conv_std_logic_vector (columns_win-lines_cut+2, cols_width) then
						if line_cnt > conv_std_logic_vector (lines_cut+1, lines_width) and line_cnt <
						conv_std_logic_vector (rows_win -lines_cut+2, lines_width) then
							temp_s2 <= '1';
						end if;
					else
						temp_s2 <= '0';
					end if;
				else
					Gx <= (others => '0');
					Gy <= (others => '0');
				end if;

				if (w_sync and h_sync)='1' then
					if col_cnt = conv_std_logic_vector(0, cols_width) then
						line_cnt <= line_cnt +1;
					end if;

					if col_cnt = conv_std_logic_vector(columns_win-1, cols_width) then
						col_cnt <=(others => '0');
					else
						col_cnt <= col_cnt +1;
					end if;
				end if;

				if init = '1' then
					line_cnt <= (others => '0');
					col_cnt <= (others => '0');
				end if;
			end if;
		end if;
	end process;
end architecture;
