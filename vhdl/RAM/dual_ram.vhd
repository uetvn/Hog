--------------------------------------------------------------------------------
-- Project name   : LSI Contest 2017
-- File name      : dual_ram.vhd
-- Created date   : Mon 13 Mar 2017
-- Author         : Huy Hung Ho
-- Last modified  : Mon 13 Mar 2017
-- Desc           :
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

Entity dual_ram is
	Generic (
		DATA_WIDTH :integer := 8;
		ADDR_WIDTH :integer := 8
	);
	Port (
		address_0 :in    std_logic_vector (ADDR_WIDTH-1 downto 0); -- address_0 Input
		data_0    :inout std_logic_vector (DATA_WIDTH-1 downto 0); -- data_0 bi-directional
		cs_0      :in    std_logic;                                -- Chip Select
		we_0      :in    std_logic;                                -- Write Enable/Read Enable
		oe_0      :in    std_logic;                                -- Output Enable
		address_1 :in    std_logic_vector (ADDR_WIDTH-1 downto 0); -- address_1 Input
		data_1    :inout std_logic_vector (DATA_WIDTH-1 downto 0); -- data_1 bi-directional
		cs_1      :in    std_logic;                                -- Chip Select
		we_1      :in    std_logic;                                -- Write Enable/Read Enable
		oe_1      :in    std_logic                                 -- Output Enable
	);
End entity;

Architecture rtl of dual_ram is
	----------------Internal variables----------------
	Constant RAM_DEPTH :integer := 2**ADDR_WIDTH;

	Signal data_0_out :std_logic_vector (DATA_WIDTH-1 downto 0);
	Signal data_1_out :std_logic_vector (DATA_WIDTH-1 downto 0);

	Type RAM is array (integer range <>)of std_logic_vector (DATA_WIDTH-1 downto 0);
	Signal mem : RAM (0 to RAM_DEPTH-1);
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
