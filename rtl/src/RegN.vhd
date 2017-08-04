--------------------------------------------------------------------------------
-- Project name   : Human detection by HOG
-- File name      : byte_buf.vhd
-- Created date   : Fri 19 May 2017
-- Author         : Huy Hung Ho
-- Last modified  : Fri 19 May 2017
-- Desc           :
--------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity RegN is
    generic (N:     integer := 4);
	port (
		clk:    IN std_logic;
        enable: IN std_logic;
		Din :   IN std_logic_vector(N - 1 downto 0);
		Dout:   OUT std_logic_vector(N - 1 downto 0)
	);
end RegN;

architecture arch_buf of RegN is
    signal Dinternal: std_logic_vector(N - 1 downto 0);
begin
	process(clk, enable)
	begin
		if rising_edge(clk) then
			if enable = '1' then
				Dinternal <= Din;
            else
                Dinternal <= Dinternal;
			end if;
		end if;
	end process;

    Dout <= Dinternal;
end architecture;

