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
    -- Constant
    constant CB_WIDTH   : integer := 32;
    constant DATA_WIDTH : integer := 32;
    constant BIN_WIDTH  : integer := 13;
    constant HIST_WIDTH : integer := 13;
    constant ROM_WIDTH  : integer := 9;

    -- Function & procedure decralation
    function checkLeftMostBit (x : unsigned) return unsigned;
    function mostLeftBit (x : unsigned) return integer;


    function int (invec     : bit_vector)                   return integer;
    function mux (databits  : bit_vector; sel : bit_vector) return bit;
    function bin (inint, size   : integer)                  return bit_vector;
    function dcd (bin       : bit_vector)                   return bit_vector;

    procedure inc               (variable invec : inout bit_vector);
    procedure consecutive_data  (signal target : out bit_vector; constant ti :
                                 time; constant n : integer);
    procedure onehot_data       (signal target : out bit_vector;
	                             constant ti : time; constant n : integer);

end package;

package body config_pkg is
    function checkLeftMostBit (x : unsigned) return  unsigned is
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

    function mostLeftBit (x : unsigned) return integer is
        variable tmp : integer := 0;
    begin
        for i in x'length - 1 downto 0 loop
            if x(i) = '1' then
                tmp := i + 1;
                exit;
            end if;
        end loop;
        return tmp;
    end function mostLeftBit;



    function int (invec : bit_vector) return integer is
      variable tmp : integer := 0;
    begin
      for i in invec'length - 1 downto 0 loop
         if invec (i) = '1' then
            tmp := tmp + 2**i;
         end if;
      end loop;
      return tmp;
    end function int;

    function mux (databits : bit_vector; sel : bit_vector) return bit is
    begin
      return databits (int(sel));
    end function mux;

    function dcd (bin : bit_vector) return bit_vector is
      variable tmp : bit_vector(0 to 2**bin'length - 1);
    begin
      tmp := (others => '0');
      tmp (int(bin)) := '1';
      return tmp;
    end function dcd;

    function bin (inint, size : integer) return bit_vector is
      variable tmpi : integer := inint;
      variable tmpb : bit_vector (size - 1 downto 0);
    begin
      tmpb := (others => '0');
      for i in 0 to size - 1 loop
         if ((tmpi mod 2) = 1) then
            tmpb(i) := '1';
         end if;
         tmpi := tmpi / 2;
      end loop;
      return tmpb;
    end function bin;

    procedure inc (variable invec : inout bit_vector) is
      variable sum, carry : bit;
    begin
      carry := '1';
      for j in invec'reverse_range loop
         sum := invec (j) xor carry;
         carry := invec (j) and carry;
         invec (j) := sum;
      end loop;
    end procedure inc;

    procedure consecutive_data (signal target : out bit_vector;
                     constant ti : time; constant n : integer) is
      variable data : bit_vector (target'range);
    begin
      for i in 1 to n loop
         inc (data);
         target <= transport data after ti * i;
      end loop;
    end procedure consecutive_data;

    procedure onehot_data (signal target : out bit_vector;
                     constant ti : time; constant n : integer) is
      variable data : bit_vector (target'range);
      variable i : integer := 0;
    begin
      data (0) := '1';
      while i < n loop
         data := data ror 1;
         target <= transport data after ti * i;
         i := i + 1;
      end loop;
    end procedure onehot_data;

end package body;
