--------------------------------------------------------
-- Signal vs. Variable (sig_var.vhd)
-- Look at the outputs in simulation waveform
-- for same computation, we get two different results
--
-- by Weijun Zhang, 05/2001
--------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity sig_var is
port(	d1, d2, d3:	in std_logic;
		res1, res2:	out std_logic);
end sig_var;

architecture behv of sig_var is
  signal sig_s1: std_logic;
begin
  proc1: process(d1,d2,d3)
    variable var_s1: std_logic;
  begin
	var_s1 := d1 and d2;
	res1 <= var_s1 xor d3;
  end process;

  proc2: process(d1,d2,d3)
  begin
	sig_s1 <= d1 and d2;
	res2 <= sig_s1 xor d3;
  end process;
end behv;
