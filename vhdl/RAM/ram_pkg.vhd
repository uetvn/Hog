-------------------------------------------------------------------------------
-- Project name   : LSI Contest 2017
-- File name      : ram_pkg.vhd
-- Created date   : Mon 13 Mar 2017
-- Author         : Huy Hung Ho
-- Last modified  : Fri 17 Mar 2017
-- Desc           :
--------------------------------------------------------------------------------
Library IEEE;
Use IEEE.std_logic_1164.all;
Use IEEE.std_logic_unsigned.all;
Use work.helper.all;

Package ram_pkg is
	Component Dual_Ram is
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
	End component;
End package;
