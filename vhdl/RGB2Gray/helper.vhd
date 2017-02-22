--------------------------------------------------------------------------------
-- Project name   : LSI Contest 2017
-- File name      : helper.vhd
-- Created date   : !!DATE
-- Author         : Huy Hung Ho
-- Last modified  : !!DATE
-- Desc           :
--------------------------------------------------------------------------------

Library IEEE;
Use IEEE.std_logic_1164.all;

Package helper is
	-- Constant
	constant	Int:		integer	:= 8;
	constant	CellSize_Ex:	integer := 10;
	constant	Length_CellSize_Ex	integer := 100;
	-- Type
	type	Pixel		is array(INT - 1 downto 0) of std_logic;
	type	RGB		is array(2 downto 0) of pixel;
	type	RGB_array	is array(Length_CellSize_Ex)	of RGB;
	type	Gray_array	is array(Length_CellSize_Ex)	of pixel;

	-- Subtype

End package helper;

Package body heper is

End package body helper;
