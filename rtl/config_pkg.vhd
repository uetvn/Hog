--------------------------------------------------------------------------------
-- Project name   :
-- File name      : checkleftMostBit.vhd
-- Created date   : Mon 11 Sep 2017 12:13:54 PM ICT
-- Author         : Huy-Hung Ho
-- Last modified  : Mon 11 Sep 2017 12:13:54 PM ICT
-- Desc           :
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package config_pkg is
    /* Constant */
    constant CB_WIDTH : integer := 30;

    /* Function decralation */
    function checkLeftMostBit (x : unsigned(CB_WIDTH  - 1 downto 0))
                                return  unsigned(CB_WIDTH - 1 downto 0):

end package;

package body config_pkg is
    function checkLeftMostBit (x : unsigned(CB_WIDTH  - 1 downto 0))
                                return  unsigned(CB_WIDTH - 1 downto 0) is
        type TMP_TYPE is array(integer range <>) of unsigned(CB_WIDTH - 1 downto 0);
        variable tmp : TMP_TYPE(4 downto 0);
    begin
        tmp(0) := x OR (x srl 16);
        tmp(1) := tmp(0) OR (tmp(0) srl 8);
        tmp(2) := tmp(1) OR (tmp(1) srl 4);
        tmp(3) := tmp(2) OR (tmp(2) srl 2);
        tmp(4) := tmp(3) OR (tmp(3) srl 1);
        return  tmp(4) XOR (tmp(4) srl 1);
    end checkLeftMostBit;

end package body;
