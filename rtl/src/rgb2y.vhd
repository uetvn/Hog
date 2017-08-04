--------------------------------------------------------------------------------
-- Project name   : LSI Contest 2017
-- File name      : rgb2y.vhd
-- Created date   : Tue 18 Apr 2017
-- Author         : Huy Hung Ho
-- Last modified  : Tue 18 Apr 2017
-- Desc           :
--------------------------------------------------------------------------------
--Y  =  0.29900 * R + 0.58700 * G + 0.11400 * B
--  0.299:  2^(14 + 11 + 10 + 7 + 4 - 3 - 0)
--  0.587:  2^(15 + 12 + 10 + 9 + 6 + 2 + 1)
--  0.114:  2^(13 -  9 -  8 + 5 + 4 - 1)

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity rgb2y is
	port (
        clk:        IN std_logic;
        r, g, b:    IN std_logic_vector(7 downto 0);
        y:  		OUT std_logic_vector(7 downto 0)
	);
end rgb2y;

architecture behav of rgb2y is
    signal  sr: std_logic_vector(7 downto 0);
    signal  sg: std_logic_vector(7 downto 0);
    signal  sb: std_logic_vector(7 downto 0);
begin
    sr  <= r;
    sg  <= g;
    sb  <= b;

    rgb2y: process(clk, sr, sg, sb)
        variable vr: signed(7 downto 0);
        variable vg: signed(7 downto 0);
        variable vb: signed(7 downto 0);
        variable vy: signed(31 downto 0);
    begin
        if rising_edge(clk) then
            vr  := signed(sr);
            vg  := signed(sg);
            vb  := signed(sb);
            vy  := ((9 downto 0 => '0') & vr & (13 downto 0 => '0'))
                 + ((12 downto 0 => '0') & vr & (10 downto 0 => '0'))
                 + ((13 downto 0 => '0') & vr & (9 downto 0 => '0'))
                 + ((16 downto 0 => '0') & vr & (6 downto 0 => '0'))
                 + ((19 downto 0 => '0') & vr & (3 downto 0 => '0'))
                 - ((20 downto 0 => '0') & vr & (2 downto 0 => '0'))
                 - ((23 downto 0 => '0') & vr);
            vy  := vy
                 + ((8 downto 0 => '0') & vg & (14 downto 0 => '0'))
                 + ((11 downto 0 => '0') & vg & (11 downto 0 => '0'))
                 + ((13 downto 0 => '0') & vg & (9 downto 0 => '0'))
                 + ((14 downto 0 => '0') & vg & (8 downto 0 => '0'))
                 + ((17 downto 0 => '0') & vg & (5 downto 0 => '0'))
                 + ((21 downto 0 => '0') & vg & (1 downto 0 => '0'))
                 + ((22 downto 0 => '0') & vg & '0');
            vy  := vy
                 + ((10 downto 0 => '0') & vb & (12 downto 0 => '0'))
                 - ((14 downto 0 => '0') & vb & (8 downto 0 => '0'))
                 - ((15 downto 0 => '0') & vb & (7 downto 0 => '0'))
                 + ((18 downto 0 => '0') & vb & (4 downto 0 => '0'))
                 + ((19 downto 0 => '0') & vb & (3 downto 0 => '0'))
                 - (X"000000" & vb);
            vy  := vy + X"00008000";
            vy  := (vy srl 16);
            if (vy > 255) then
                y <= X"FF";
            else
                y <= std_logic_vector(vy(7 downto 0));
            end if;
        end if;
    end process rgb2y;
end behav;
