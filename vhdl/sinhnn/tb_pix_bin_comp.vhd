
library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;
use std.textio.all;
use ieee.std_logic_textio.all;

entity tb_pix_bin_comp is
end entity tb_pix_bin_comp;

architecture tb_pix_bin_comp_impl of tb_pix_bin_comp is
	component pix_bin_comp
	    generic (
	        MAGNI_BIN_WIDTH : integer := 8;
	        PIX_WIDTH : integer := 8;
	        ANGLE_WIDTH : integer := 4
	    );
	    port (
	        x_plus1      : in unsigned (PIX_WIDTH - 1 downto 0);
	        x_minus1     : in unsigned (PIX_WIDTH - 1 downto 0);
	        y_plus1      : in unsigned (PIX_WIDTH - 1 downto 0);
	        y_minus1     : in unsigned (PIX_WIDTH - 1 downto 0);
	        angle_1  : out unsigned(ANGLE_WIDTH - 1 downto 0);
	        angle_2  : out unsigned(ANGLE_WIDTH - 1 downto 0);
	        mag_angle_1 : out unsigned(MAGNI_BIN_WIDTH - 1 downto 0);
	        mag_angle_2 : out unsigned(MAGNI_BIN_WIDTH - 1 downto 0)
	    );
    end component pix_bin_comp;

    constant PIX_WIDTH : integer := 8;
    constant ANGLE_WIDTH : integer := 4;
    constant MAGNI_BIN_WIDTH : integer := 8;

	signal s_x_plus1      : unsigned (PIX_WIDTH - 1 downto 0) := (others => '0');
	signal s_x_minus1     : unsigned (PIX_WIDTH - 1 downto 0) := (others => '0');
	signal s_y_plus1      : unsigned (PIX_WIDTH - 1 downto 0) := (others => '0');
	signal s_y_minus1     : unsigned (PIX_WIDTH - 1 downto 0) := (others => '0');
	signal s_angle_1  : unsigned(ANGLE_WIDTH - 1 downto 0);
	signal s_angle_2  : unsigned(ANGLE_WIDTH - 1 downto 0);
	signal s_mag_angle_1 : unsigned(MAGNI_BIN_WIDTH - 1 downto 0);
	signal s_mag_angle_2 : unsigned(MAGNI_BIN_WIDTH - 1 downto 0);

begin
    DUT_pix_bin_comp: pix_bin_comp
        generic map (
            MAGNI_BIN_WIDTH => 8 ,
            PIX_WIDTH => 8 ,
            ANGLE_WIDTH => 4
        )
        port map (
            x_plus1      => s_x_plus1      ,
            x_minus1     => s_x_minus1     ,
            y_plus1      => s_y_plus1      ,
            y_minus1     => s_y_minus1     ,
            angle_1  => s_angle_1  ,
            angle_2  => s_angle_2  ,
            mag_angle_1 => s_mag_angle_1 ,
            mag_angle_2 => s_mag_angle_2 
        );
    
    READIO : process
        variable iline : line;
        variable oline : line;
        variable aSpace : character;
        variable v_x_plus1      : std_logic_vector (PIX_WIDTH - 1 downto 0);
        variable v_x_minus1     : std_logic_vector (PIX_WIDTH - 1 downto 0);
        variable v_y_plus1      : std_logic_vector (PIX_WIDTH - 1 downto 0);
        variable v_y_minus1     : std_logic_vector (PIX_WIDTH - 1 downto 0);
    
        file inf : text;
        file ouf : text;
    begin
        file_open(inf, "inf.txt",read_mode);
        file_open(ouf, "ouf.txt",write_mode);
    
        while not endfile(inf) loop
            readline(inf,iline);
            read(iline, v_x_plus1); read(iline,aSpace);
            read(iline, v_x_minus1); read(iline,aSpace);
            read(iline, v_y_plus1); read(iline,aSpace);
            read(iline, v_y_minus1); read(iline,aSpace);
            -- Variable to signal
            s_x_plus1 <= unsigned(v_x_plus1);
            s_x_minus1 <= unsigned(v_x_minus1);
            s_y_plus1 <= unsigned(v_y_plus1);
            s_y_minus1 <= unsigned(v_y_minus1);
            -- Wait for next input
            wait for 100 ns;
            -- Write odata
            write(oline, std_logic_vector(s_x_plus1));
            write(oline,aSpace);
            write(oline, std_logic_vector(s_x_minus1));
            write(oline,aSpace);
            write(oline, std_logic_vector(s_y_plus1));
            write(oline,aSpace);
            write(oline, std_logic_vector(s_y_minus1));
            write(oline,aSpace);
            write(oline, std_logic_vector(s_angle_1));
            write(oline,aSpace);
            write(oline, std_logic_vector(s_angle_2));
            write(oline,aSpace);
            write(oline, std_logic_vector(s_mag_angle_1));
            write(oline,aSpace);
            write(oline, std_logic_vector(s_mag_angle_2));
            write(oline,aSpace);

            writeline(ouf,oline);
        end loop;
        file_close(inf);
        file_close(ouf);
    end process READIO;
    
end architecture tb_pix_bin_comp_impl;
