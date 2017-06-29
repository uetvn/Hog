--------------------------------------------------------------------------------
-- Project name   : Human detection by HOG
-- File name      : bit_buffer.vhd
-- Created date   : Mon 08 May 2017
-- Author         : Huy Hung Ho
-- Last modified  : Mon 08 May 2017
-- Desc           :
--------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity bit_buf is
	port (
		clk, clr: in std_logic;
		bit_in : in std_logic;
		bit_out: out std_logic
	);
end bit_buf;

architecture arch_buf of bit_buf is
begin
	process(clk,clr)
	begin
		if (clr = '1') then
			bit_out <= '0';
		else
			if rising_edge(clk) then
				bit_out <= bit_in;
			end if;
		end if;
	end process;
end architecture;
