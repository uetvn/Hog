--------------------------------------------------------------------------------
-- Project name   :
-- File name      : rgb2ycc_pix.vhd
-- Created date   : Tue 11 Apr 2017 02:53:35 PM +07
-- Author         : Ngoc-Sinh Nguyen
-- Last modified  : Tue 18 Apr 2017
-- Desc           :

-- JPEG
--Y  =  0.29900 * R + 0.58700 * G + 0.11400 * B
--Cb = -0.16874 * R - 0.33126 * G + 0.50000 * B  + CENTERJSAMPLE
--Cr =  0.50000 * R - 0.41869 * G - 0.08131 * B  + CENTERJSAMPLE
-- More detail at:
-- http://docs.opencv.org/3.1.0/de/d25/imgproc_color_conversions.html

-- In some case
-- Y = (77/256)R + (150/256)G + (29/256)B
-- Cb = ‐(44/256)R ‐ (87/256)G + (131/256)B + 128
-- Cr = (131/256)R ‐ (110/256)G ‐ (21/256)B + 128

--------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity rgb2ycc_pix is
	port(
--		clk : in std_logic;
--		rst : in std_logic;

		r   : in std_logic_vector(7 downto 0);
		g   : in std_logic_vector(7 downto 0);
		b   : in std_logic_vector(7 downto 0);
		y   : out std_logic_vector(7 downto 0);
		cb  : out std_logic_vector(7 downto 0);
		cr  : out std_logic_vector(7 downto 0)
	    );
end rgb2ycc_pix;

architecture rgb2ycc_pix_impl of rgb2ycc_pix is
	signal sr : std_logic_vector(7 downto 0) := (others =>'0');
	signal sg : std_logic_vector(7 downto 0) := (others =>'0');
	signal sb : std_logic_vector(7 downto 0) := (others =>'0');
begin
	sr <= r;
	sg <= g;
	sb <= b;

	-- RGB2Y
	rgb2y:process (sr, sg, sb)
		variable vy : signed (31 downto 0);
		variable vr : signed (7 downto 0);
		variable vb : signed (7 downto 0);
		variable vg : signed (7 downto 0);
	begin
		vr := signed(sr);
		vg := signed(sg);
		vb := signed(sb);
		vy := ((9 downto 0 => '0') & vr & (13 downto 0 => '0'))
			+ ((12 downto 0 =>'0') & vr & (10 downto 0 => '0'))
			+ ((13 downto 0 => '0') & vr & (9 downto 0 => '0'))
			+ ((16 downto 0 => '0') & vr & (6 downto 0 => '0'))
			+ ((19 downto 0 => '0') & vr & (3 downto 0 => '0'))
			- ((20 downto 0 => '0') & vr & (2 downto 0 => '0'))
			- (X"000000"  & vr);
		vy := vy
			+ ((8 downto 0 => '0') & vg & (14 downto 0 => '0'))
			+ ((11 downto 0 => '0') & vg & (11 downto 0 => '0'))
			+ ((13 downto 0 => '0') & vg & (9 downto 0 => '0'))
			+ ((14 downto 0 => '0') & vg & (8 downto 0 => '0'))
			+ ((17 downto 0 => '0') & vg & (5 downto 0 => '0'))
			+ ((21 downto 0 => '0') & vg & (1 downto 0 => '0'))
			+ ((22 downto 0 => '0') & vg & '0');
		vy := vy
			+ ((10 downto 0 => '0') & vb & (12 downto 0 => '0'))
			- ((14 downto 0 => '0') & vb & (8 downto 0 => '0'))
			- ((15 downto 0 => '0') & vb & (7 downto 0 => '0'))
			+ ((18 downto 0 => '0') & vb & (4 downto 0 => '0'))
			+ ((19 downto 0 => '0') & vb & (3 downto 0 => '0'))
			- (X"000000" & vb);
		vy := vy + X"00008000";
		vy := (vy srl 16);
		if (vy > 255 ) then
			y <= X"FF";
		else
			y <= std_logic_vector(vy(7 downto 0));
		end if;

	end process rgb2y;

	-- RGB to CR
	rgb2cb:process (sr,sg,sb)
		variable vcb : signed (31 downto 0) := (others => '0');
		variable vr : signed (7 downto 0);
		variable vb : signed (7 downto 0);
		variable vg : signed (7 downto 0);
	begin
		vr := signed(sr);
		vb := signed(sb);
		vg := signed(sg);
		vcb :=  vcb - (
			((10 downto 0 => '0') & vr & (12 downto 0 => '0'))
			+ ((11 downto 0 =>'0') & vr & (11 downto 0 => '0'))
			+ ((14 downto 0 => '0') & vr & (8 downto 0 => '0'))
			+ ((16 downto 0 => '0') & vr & (6 downto 0 => '0'))
			+ ((17 downto 0 => '0') & vr & (5 downto 0 => '0'))
			+ ((22 downto 0 => '0') & vr & '0' )
			+ (X"000000"  & vr)
			);
		vcb := vcb - (
			((9 downto 0 => '0') & vg & (13 downto 0 => '0'))
			+ ((11 downto 0 => '0') & vg & (11 downto 0 => '0'))
			+ ((13 downto 0 => '0') & vg & (9 downto 0 => '0'))
			+ ((16 downto 0 => '0') & vg & (6 downto 0 => '0'))
			+ ((17 downto 0 => '0') & vg & (5 downto 0 => '0'))
			+ ((20 downto 0 => '0') & vg & (2 downto 0 => '0'))
			+ ((21 downto 0 => '0') & vg & (1 downto 0 => '0'))
			+ (X"000000"  & vr)
			);
		vcb := vcb
			+ ((8 downto 0 => '0') & vb & (14 downto 0 => '0'))
			+ X"00008000";
		vcb := vcb srl 16;
		vcb := vcb + 128;
		if (vcb > 255 ) then
			cb <= X"FF";
		else
			cb <= std_logic_vector(vcb(7 downto 0));
		end if;
	end process rgb2cb;

	-- RGB to CR
	rgb2cr:process (sr,sg,sb)
		variable vcr : signed (31 downto 0);
		variable vr : signed (7 downto 0);
		variable vb : signed (7 downto 0);
		variable vg : signed (7 downto 0);
	begin
		vr := signed(sr);
		vb := signed(sb);
		vg := signed(sg);
		vcr :=  ((8 downto 0 => '0') & vr & (14 downto 0 => '0'))
			+ X"00008000";
		vcr := vcr - (
			((9 downto 0 => '0') & vg & (13 downto 0 => '0'))
			+ ((10 downto 0 => '0') & vg & (12 downto 0 => '0'))
			+ ((12 downto 0 => '0') & vg & (10 downto 0 => '0'))
			+ ((14 downto 0 => '0') & vg & (8 downto 0 => '0'))
			+ ((15 downto 0 => '0') & vg & (7 downto 0 => '0'))
			+ ((18 downto 0 => '0') & vg & (4 downto 0 => '0'))
			+ ((19 downto 0 => '0') & vg & (3 downto 0 => '0'))
			- (X"000000"  & vr)
		);
		vcr := vcr - (
			((11 downto 0 => '0') & vb & (11 downto 0 => '0'))
			+ ((13 downto 0 => '0') & vb & (9 downto 0 => '0'))
			+ ((16 downto 0 => '0') & vb & (6 downto 0 => '0'))
			+ ((19 downto 0 => '0') & vb & (3 downto 0 => '0'))
			+ (X"000000" & vb)
		);
		vcr := vcr srl 16;
		vcr := vcr + 128;
		if (vcr > 255 ) then
			cr <= X"FF";
		else
			cr <= std_logic_vector(vcr(7 downto 0));
		end if;

	end process rgb2cr;

end architecture rgb2ycc_pix_impl;
