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
	generic (width : integer := 8);
	port(
		A, B:   IN std_logic_vector (width-1 downto 0);
		sub:    OUT std_logic_vector (width-1 downto 0)
	);
end entity;

architecture behav of n_bits_sub is
    signal As, Bs:          std_logic_vector(width downto 0);
    signal unsigned_sub:    std_logic_vector(width downto 0);
    signal signed_sub:      std_logic_vector(width downto 0);
begin
    As <= '0' & A;
    Bs <= '0' & B;

    unsigned_sub <= abs(As - Bs);
    sub(width-2 downto 0) <= "1111111" when unsigned_sub(width-1) = '1' else
                    unsigned_sub(width-2 downto 0);

    signed_sub <= As - Bs;

    sub(width - 1) <= signed_sub(width);
end behav;
