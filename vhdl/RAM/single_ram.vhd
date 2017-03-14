--------------------------------------------------------------------------------
-- Project name   : LSI Contest 2017
-- File name      : single_ram.vhd
-- Created date   : Mon 13 Mar 2017
-- Author         : Huy Hung Ho
-- Last modified  : Mon 13 Mar 2017
-- Desc           :
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

Entity single_ram is
	Generic (
		DATA_WIDTH :integer := 8;
		ADDR_WIDTH :integer := 8
	);
	Port (
		address :in    std_logic_vector (ADDR_WIDTH-1 downto 0); -- address Input
		data1	:inout std_logic_vector (DATA_WIDTH-1 downto 0); -- data bi-directional
		data2	:inout std_logic_vector (DATA_WIDTH-1 downto 0); -- data bi-directional
		data3	:inout std_logic_vector (DATA_WIDTH-1 downto 0); -- data bi-directional
		cs      :in    std_logic;                                -- Chip Select
		we      :in    std_logic;                                -- Write Enable/Read Enable
		oe      :in    std_logic                                -- Output Enable
	);
End entity;

Architecture rtl of single_ram is
	----------------Internal variables----------------
	Constant RAM_DEPTH :integer := 2**ADDR_WIDTH;

	Signal data_out1 :std_logic_vector (DATA_WIDTH-1 downto 0);
	Signal data_out2 :std_logic_vector (DATA_WIDTH-1 downto 0);
	Signal data_out3 :std_logic_vector (DATA_WIDTH-1 downto 0);

	Type RAM is array (integer range <>)of std_logic_vector (DATA_WIDTH-1 downto 0);
	Signal mem : RAM (0 to RAM_DEPTH-1);
Begin
	----------------Code Starts Here------------------
	-- Memory Write Block
	-- Write Operation : When we = 1, cs = 1
	MEM_WRITE:
	process (address, cs, we, data1, data2, data3)
	begin
		if (cs = '1' and we = '1') then
			mem(conv_integer(address)) <= data1;
			mem(conv_integer(address + 1)) <= data2;
			mem(conv_integer(address + 2)) <= data3;
		end if;
	end process;

	-- Tri-State Buffer control
	data1 <= data_out1 when (cs = '1' and oe = '1' and we = '0') else (others=>'Z');
	data2 <= data_out2 when (cs = '1' and oe = '1' and we = '0') else (others=>'Z');
	data3 <= data_out3 when (cs = '1' and oe = '1' and we = '0') else (others=>'Z');

	-- Memory Read Block
	MEM_READ:
	process (address, cs, we, oe, mem) begin
		if (cs = '1' and we = '0' and oe = '1') then
			data_out1 <= mem(conv_integer(address));
			data_out2 <= mem(conv_integer(address + 1));
			data_out3 <= mem(conv_integer(address + 1));
		else
			data_out1 <= (others=>'0');
			data_out2 <= (others=>'0');
			data_out3 <= (others=>'0');
		end if;
	end process;

End architecture;
