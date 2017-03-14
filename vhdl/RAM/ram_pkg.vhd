
-- Project name   : LSI Contest 2017
-- File name      : ram_pkg.vhd
-- Created date   : Mon 13 Mar 2017
-- Author         : Huy Hung Ho
-- Last modified  : Mon 13 Mar 2017
-- Desc           :
--------------------------------------------------------------------------------
Library IEEE;
Use IEEE.std_logic_1164.all;
Use IEEE.std_logic_unsigned.all;

Package ram_pkg is
	Component  dual_ram is
		Generic (
			DATA_WIDTH :integer := 8;
			ADDR_WIDTH :integer := 10
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
	End component;

	Component single_ram is
		Generic (
			DATA_WIDTH :integer := 8;
			ADDR_WIDTH :integer := 10
		);
		Port (
			address :in    std_logic_vector (ADDR_WIDTH-1 downto 0); -- address Input

			data1    :inout std_logic_vector (DATA_WIDTH-1 downto 0); -- data bi-directional
			data2    :inout std_logic_vector (DATA_WIDTH-1 downto 0); -- data bi-directional
			data3    :inout std_logic_vector (DATA_WIDTH-1 downto 0); -- data bi-directional
			cs      :in    std_logic;                                -- Chip Select
			we      :in    std_logic;                                -- Write Enable/Read Enable
			oe      :in    std_logic                                -- Output Enable
		);
	End component;
End package;
