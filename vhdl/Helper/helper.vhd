--------------------------------------------------------------------------------
-- Project name   : LSI Contest 2017
-- File name      : helper.vhd
-- Created date   : Mon 13 Mar 2017
-- Author         : Huy Hung Ho
-- Last modified  : Mon 13 Mar 2017
-- Desc           :
--------------------------------------------------------------------------------

Library IEEE;
Use IEEE.std_logic_1164.all;
Use IEEE.numeric_std.all;

Package helper is
	Constant	cell_extend_width:	integer := 100;
	Constant	data_width:		integer := 8;
	Constant	addr_width:		integer := 9;

	Subtype		byte is std_logic_vector(data_width-1 downto 0);
	Subtype		addr_type is std_logic_vector(addr_width-1 downto 0);
	--Constant const_shift_in:	addr_load :=
	--std_logic_vector(to_unsigned(3, addr_width_single_ram));
	--Constant const_shift_out:	addr_store :=
	--std_logic_vector(to_unsigned(1, addr_width_dual_ram));
End package;
