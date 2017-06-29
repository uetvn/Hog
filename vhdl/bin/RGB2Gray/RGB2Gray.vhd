--------------------------------------------------------------------------------
-- Project name   : LSI contest 2017
-- File name      : rgb2y.vhd
-- Created date   : Wed 22 Feb 2017
-- Author         : Huy Hung Ho
-- Last modified  : Mon 27 Feb 2017
-- Desc           :
--	YR:	19595:	0100110010001011
--	YB:	7471:	0001110100101111
--	YG:	38470:	1001011001000110
--
--  Red:    14 + 11 + 10 + 7 + 4 - 3 - 0
--  Green:  15 + 12 + 10 + 9 + 6 + 2 + 1
--  Blue:   13 -  9 -  8 + 5 + 4 - 1
--  YCC:    11059 = 13 + 11 + 9 + 8 + 5 + 4 + 2 + 1
--------------------------------------------------------------------------------

Library IEEE;
Use IEEE.std_logic_1164.all;
Use IEEE.numeric_std.all;

Entity rgb2y is
	Port (
		r:		IN std_logic_vector(7 downto 0);
		g:		IN std_logic_vector(7 downto 0);
		b:		IN std_logic_vector(7 downto 0);
		y:      OUT std_logic_vector(7 downto 0)
	);
End rgb2y;

Architecture behav of rgb2y is
	Signal	sr: std_logic_vector(7 downto 0)    := (others => '0');
	Signal	sg: std_logic_vector(7 downto 0)    := (others => '0');
	Signal	sb: std_logic_vector(7 downto 0)    := (others => '0');
Begin
    sr  <= r;
    sg  <= g;
    sb  <= b;

    --RGB2Y
    rgb2y:  process(sr, sg, sb)
        variable vr:    signed(7 downto 0);
        variable vg:    signed(7 downto 0);
        variable vb:    signed(7 downto 0);
        variable vy:    signed(31 downto 0);
    begin
        vr  <= signed(sr);
        vg  <= signed(sg);
        vb  <= signed(sb);

        vy  := (9 downto 0 => '0') & vr & (13 downto 0 => '0')
             + (12 downto 0 => '0') & vr & (10 downto 0 => '0')
             + (13 downto 0 => '0') & vr & (9 downto 0 => '0')
             + (16 downto 0 => '0') & vr & (6 downto 0 => '0')
             + (19 downto 0 => '0') & vr & (3 downto 0 => '0')
             - (20 downto 0 => '0') & vr & (2 downto 0 => '0')
	         - X"000000" & vr;
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
    end process rgb2y;
End behav;
