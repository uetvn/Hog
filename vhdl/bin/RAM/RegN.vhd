--------------------------------------------------------------------------------
-- Project name   : LSI Contest 2017
-- File name      : Reg_RGB.vhd
-- Created date   : Fri 17 Mar 2017
-- Author         : Huy Hung Ho
-- Last modified  : Fri 17 Mar 2017
-- Desc           :
--------------------------------------------------------------------------------

Library IEEE;
Use IEEE.std_logic_1164.all;
Use work.include.all;

Entity RegN is
	generic (N: integer := 4);
	Port (
		Din:	IN std_logic_vector(N - 1 downto 0);
		Dout:	OUT std_logic_vector(N - 1 downto 0);
		Clk:	IN std_logic;
		Enable:	IN std_logic
	);
End RegN;

Architecture Behavioral of RegN is
	Signal	Dinternal:	std_logic_vector(N-1 downto 0);
Begin
	Process(Clk)
	Begin
		if rising_edge(Clk) then
			if (Enable = '1') then
				Dinternal <= Din;
			end if;
		end if;
	end process;

	Dout <= Dinternal;
End Behavioral;

