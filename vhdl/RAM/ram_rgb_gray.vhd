--------------------------------------------------------------------------------
-- Project name   : LSI Contest 2017
-- File name      : ram_rgb_gray.vhd
-- Created date   : Mon 13 Mar 2017
-- Author         : Huy Hung Ho
-- Last modified  : Fri 17 Mar 2017
-- Desc           : RAM for store grb data, gray data, HOG matrix and dectected
--------------------------------------------------------------------------------
library IEEE;
Use IEEE.std_logic_1164.all;
Use IEEE.numeric_std.all;
Use IEEE.std_logic_unsigned.all;
Use work.helper.all;

Entity ram_rgb_gray is
	Generic (
		addr_width:	integer := 8
	);
	Port (
		address_0 :in    addr_type;
		data_01   :inout byte;
		data_02   :inout byte;
		data_03   :inout byte;
		cs_0      :in    std_logic;
		we_0      :in    std_logic;
		oe_0      :in    std_logic;
		address_1 :in    addr_type;
		data_1    :inout byte;
		cs_1      :in    std_logic;
		we_1      :in    std_logic;
		oe_1      :in    std_logic
	);
End entity;

Architecture rtl of ram_rgb_gray is
	----------------Internal variables----------------
	Constant ram_depth	:integer := 2**addr_width;

	Signal	data_01_out:	byte;
	Signal	data_02_out:	byte;
	Signal	data_03_out:	byte;
	Signal	data_1_out:	byte;

	Type	RAM	is array (integer range <>) of byte;
	Signal	mem	: RAM (0 to ram_depth-1)
		:= (	0	=> "11111111",
			1	=> "00000000",
			2	=> "00010001",
			others => (others => '0'));
Begin
	----------------Code Starts Here------------------
	-- Memory Write Block -- Write Operation : When we_0 = 1, cs_0 = 1
	MEM_WRITE:
	process (address_0, cs_0, we_0, data_01, data_02, data_03, address_1, cs_1, we_1, data_1) begin
		if (cs_0 = '1' and we_0 = '1') then
			mem(conv_integer(address_0)) <= data_01;
			mem(conv_integer(address_0) + 1) <= data_02;
			mem(conv_integer(address_0) + 2) <= data_03;
		elsif  (cs_1 = '1' and we_1 = '1') then
			mem(conv_integer(address_1)) <= data_1;
		end if;
	end process;

	-- Tri-State Buffer control
	data_01 <= data_01_out when (cs_0 = '1' and oe_0 = '1' and we_0 = '0') else (others=>'Z');
	data_02 <= data_02_out when (cs_0 = '1' and oe_0 = '1' and we_0 = '0') else (others=>'Z');
	data_03 <= data_03_out when (cs_0 = '1' and oe_0 = '1' and we_0 = '0') else (others=>'Z');

	-- Memory Read Block
	MEM_READ_0:
	process (address_0, cs_0, we_0, oe_0, mem) begin
		if (cs_0 = '1' and we_0 = '0' and oe_0 = '1') then
			data_01_out <= mem(conv_integer(address_0));
			data_02_out <= mem(conv_integer(address_0) + 1);
			data_03_out <= mem(conv_integer(address_0) + 2);
		else
			data_01_out <= (others=>'0');
			data_02_out <= (others=>'0');
			data_03_out <= (others=>'0');
		end if;
	end process;

	-- Second Port of RAM
	-- Tri-State Buffer control
	data_1 <= data_1_out when (cs_1 = '1' and oe_1 = '1' and we_1 = '0') else (others=>'Z');

	-- Memory Read Block 1
	MEM_READ_1:
	process (address_1, cs_1, we_1, oe_1, mem) begin
		if (cs_1 = '1' and we_1 = '0' and oe_1 = '1') then
			data_1_out <= mem(conv_integer(address_1));
		else
			data_1_out <= (others=>'0');
		end if;
	end process;
End architecture;
