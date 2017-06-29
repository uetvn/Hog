--------------------------------------------------------------------------------
-- Project name   : Human detection by HOG
-- File name      : square_root.vhd
-- Created date   : Wednesday 06/28/17
-- Author         : Huy Hung Ho
-- Last modified  : Wednesday 06/28/17
-- Desc           :
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity square_root is
    port (
        clk:        IN std_logic;
        data_in:    IN std_logic_vector(31 downto 0);
        data_out:   OUT std_logic_vector(15 downto 0)
    );
end square_root;

architecture behavior of square_root is
    function  sqrt( d : UNSIGNED ) return UNSIGNED is
        variable a: unsigned(31 downto 0) := d;  --original input.
        variable q: unsigned(15 downto 0) := (others => '0');  --result.
        variable left,right,r: unsigned(17 downto 0):=(others => '0');  --input to
        variable i: integer:=0;
    begin
        for i in 0 to 15 loop
            right(0) := '1';
            right(1) := r(17);
            right(17 downto 2) := q;
            left(1 downto 0)   := a(31 downto 30);
            left(17 downto 2)  := r(15 downto 0);
            a(31 downto 2)     := a(29 downto 0);  --shifting by 2 bit.
            if ( r(17) = '1') then
                r := left + right;
            else
                r := left - right;
            end if;
            q(15 downto 1)  := q(14 downto 0);
            q(0)            := not r(17);
        end loop;
        return q;
    end sqrt;

	signal data_in_tmp : unsigned(31 downto 0) := (others => '0');
	signal data_out_tmp: unsigned(15 downto 0) := (others => '0');
begin
    data_in_tmp <= unsigned(data_in);

    process (clk, data_in)
    begin
        if rising_edge(clk) then
            data_out_tmp <= sqrt(data_in_tmp);
        end if;
    end process;

    data_out <= std_logic_vector(data_out_tmp);
end behavior;

