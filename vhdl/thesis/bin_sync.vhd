--------------------------------------------------------------------------------
-- Project name   : Human detection by HOG
-- File name      : bin_sync.vhd
-- Created date   : Mon 08 May 2017
-- Author         : Huy Hung Ho
-- Last modified  : Mon 08 May 2017
-- Desc           :
--------------------------------------------------------------------------------

library ieee ;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity bin_sync is
	generic (
		w_cell:		integer := 1;
		h_cell:		integer := 2;
		w_bl:		integer := 4;
		h_bl:		integer := 3;
		counter_8:	integer := 3;
		counter_60:	integer := 6;
		counter_80:	integer := 7;
		w_win_bits:	integer := 10;
		h_win_bits:	integer := 9;
		bits_rom_cnt:	integer := 7;
		bias:		integer := 20;
		threshold:	integer :=-2000;
		columns_win:	integer := 32;
		rows_win:	integer := 22;
		lines_cut:	integer := 8;
		pixel_width:	integer := 8
	);
	port (
		pixel:			in std_logic_vector (pixel_width-1 downto 0);
		clk, clr:		in std_logic;
		h_sync,w_sync:	in std_logic;
		en:				out std_logic;
		bin:			out std_logic_vector(3 downto 0);
		frame_end:		out std_logic;
		Gx, Gy:			out std_logic_vector (pixel_width-1 downto 0)
	);
end entity;

architecture bin_beh of bin_sync is
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
		port(
			A,B:	in std_logic_vector(pixel_width-2 downto 0);
			sub:	out std_logic_vector(pixel_width-1 downto 0);
			clk:	in std_logic
		);
	end component;

	component line_buf
		port(
			ser_data:	in std_logic_vector (pixel_width-1 downto 0);
			clk, clr:	in std_logic;
			sign_en:	out std_logic;
			init:		buffer std_logic;
			h_sync,w_sync:	in std_logic;
			Gx, Gy:		out std_logic_vector (pixel_width-1 downto 0)
		);
	end component;

	component bin_sel
		generic (n : integer := 8);
		Port (
			Gx, Gy:	in std_logic_vector (n-1 downto 0);
			bin:	out std_logic_vector (3 downto 0);
			clk:	in std_logic
		);
	end component;

	signal bin_en1:	std_logic;
	signal bin_en2:	std_logic;
	signal Gytemp:	std_logic_vector (pixel_width-1 downto 0);
	signal GXtemp:	std_logic_vector (pixel_width-1 downto 0);
	signal Gytemp1:	std_logic_vector (pixel_width-1 downto 0);
	signal GXtemp1:	std_logic_vector (pixel_width-1 downto 0);
begin
	Gxy: component line_buf
		port map (pixel, clk, clr, bin_en1, frame_end, h_sync, w_sync, Gxtemp, Gytemp);

	bin_out: component bin_sel
		port map (Gxtemp, Gytemp, bin, clk);

	process (clk, clr)
	begin
		if clr= '1' then
			-- bin_en2 <= '0';
			en <= '0';
		else
			if rising_edge(clk) then
				--bin_en2 <= bin_en1;
				en		<= bin_en1;
				Gxtemp1 <= Gxtemp;
				Gytemp1 <= Gytemp;
				Gx		<= Gxtemp1;
				Gy		<= Gytemp1;
			end if;
		end if;
	end process;
	--ax<=Gxtemp;
	--ay<=Gytemp;
end architecture;
