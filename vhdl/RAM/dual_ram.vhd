--------------------------------------------------------------------------------
-- Project name   : LSI Contest 2017
-- File name      : dual_ram.vhd
-- Created date   : Mon 13 Mar 2017
-- Author         : Huy Hung Ho
-- Last modified  : Mon 20 Mar 2017
-- Desc           : RAM for store rgb data, gray data, HOG matrix and dectected
--------------------------------------------------------------------------------
library IEEE;
Use IEEE.std_logic_1164.all;
Use IEEE.numeric_std.all;
Use IEEE.std_logic_unsigned.all;
Use work.helper.all;

Entity Dual_Ram is
	Generic (
		addr_width:	integer := 8
	);
	Port (
		address_0 :in    addr_type;
		data_0    :inout byte;
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

Architecture rtl of Dual_Ram is
	----------------Internal variables----------------
	Constant ram_depth	:integer := 2**addr_width;

	Signal	data_0_out:	byte;
	Signal	data_1_out:	byte;

	Type	RAM	is array (integer range <>) of byte;
	Signal	mem	: RAM (0 to ram_depth-1)
		:= (	0	=> X"FF",
			1	=> X"00",
			2	=> X"11",
			3	=> X"F5",
			4	=> X"FE",
			5	=> X"45",
			6	=> X"06",
			7	=> X"07",
			8	=> X"08",
			9	=> X"09",
			10	=> X"0A",
			11	=> X"0B",
			12	=> X"0C",
			13	=> X"0D",
			14	=> X"0E",
			others => (others => '0'));
Begin
	----------------Code Starts Here------------------
	-- Memory Write Block -- Write Operation : When we_0 = 1, cs_0 = 1
	MEM_WRITE:
	process (address_0, cs_0, we_0, data_0, address_1, cs_1, we_1, data_1) begin
		if (cs_0 = '1' and we_0 = '1') then
			mem(conv_integer(address_0)) <= data_0;
		elsif  (cs_1 = '1' and we_1 = '1') then
			mem(conv_integer(address_1)) <= data_1;
		end if;
	end process;

	-- Tri-State Buffer control
	data_0 <= data_0_out when (cs_0 = '1' and oe_0 = '1' and we_0 = '0') else (others=>'Z');

	-- Memory Read Block
	MEM_READ_0:
	process (address_0, cs_0, we_0, oe_0, mem) begin
		if (cs_0 = '1' and we_0 = '0' and oe_0 = '1') then
			data_0_out <= mem(conv_integer(address_0));
		else
			data_0_out <= (others=>'0');
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
