--------------------------------------------------------------------------------
-- Project name   : Human detection by HOG
-- File name      : n_bit_sub.vhd
-- Created date   : Mon 08 May 2017
-- Author         : Huy Hung Ho
-- Last modified  : Mon 08 May 2017
-- Desc           :
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;
use ieee.numeric_std.all;

entity n_bits_sub IS
	generic (n : integer := 8);
	port(
		A,B: in std_logic_vector (n-1 downto 0);
		sub: out std_logic_vector (n downto 0);
		clk: in std_logic
	);
end entity;

architecture n_bits of n_bits_sub is
	signal As, Bs, temp: std_logic_vector (n-1 downto 0);
	signal temp_sub:	 std_logic_vector (n-1 downto 0);
begin
	As <= '0' & A;
	Bs <= '0' & B;
	temp <= abs(As - Bs);
	temp_sub <= As - Bs;

	process(clk)
	begin
		if(rising_edge(clk)) then
			sub (n-2 downto 0) <= temp(n-2 downto 0);
			sub (n-1) <= temp_sub (n-1);
		end if;
	end process;
end n_bits;
