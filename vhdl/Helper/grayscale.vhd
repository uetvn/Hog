library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.pack.all;

entity grayscale is
	port(
		start      : in  std_logic;
		clk        : in  std_logic;
		din        : in  byte;          -- Data read from RAM
		read_oe    : out std_logic;     -- Output enable to RAM
		read_we    : out std_logic;     -- Write/Read
		read_cs    : out std_logic;     -- Chip select
		read_addr  : out addr;          -- Address for reading data from RAM
		write_oe   : out std_logic;
		write_we   : out std_logic;
		write_cs   : out std_logic;
		write_addr : out addr;
		dout       : out byte;
		biData     : out std_logic;     -- Binary data
		done       : out std_logic
	);
end entity grayscale;

architecture beh of grayscale is
	signal raddr : addr := INIT_ADDR;
	signal waddr : addr := GS_WRITE_ADDR;

	type histogram is array (0 to 255) of integer;
	type pixel is array (0 to 2) of byte;

	function gray_scale(a : pixel) return std_logic_vector is
		variable gs  : unsigned(29 downto 0);
		variable int : integer;
		constant yr  : integer := 19595;
		constant yg  : integer := 38470;
		constant yb  : integer := 74741;
		variable res : std_logic_vector(29 downto 0);
	begin
		int := to_integer(unsigned(a(0))) * yr + to_integer(unsigned(a(1))) * yg + to_integer(unsigned(a(2))) * yb;
		gs  := to_unsigned(int, 30) srl 16;
		if (gs > x"FF") then
			return x"FF";
		end if;
		res := std_logic_vector(gs);
		return res(7 downto 0);
	end function gray_scale;

begin
	read_cs   <= '1';
	read_oe   <= '1';
	read_we   <= '0';
	read_addr <= raddr;

	write_oe   <= '0';
	write_we   <= '1';
	write_cs   <= '1';
	write_addr <= waddr;

	gs : process
		variable histogram    : histogram;
		variable his_freq     : integer := 0;
		variable binary_thres : integer := 0;
		variable pix          : pixel;
		variable gsData       : byte;
		variable intGs        : integer;
	begin
		wait until start = '1';

		for i in 0 to 255 loop
			histogram(i) := 0;
		end loop;

		-- read image
		for i in 0 to imgw * imgh - 1 loop
			for j in 0 to 2 loop
				wait until rising_edge(clk);
				pix(j) := din;
				raddr  <= std_logic_vector(unsigned(raddr) + 1);
			end loop;
			gsData := gray_scale(pix);
			dout   <= gsData;
			waddr  <= std_logic_vector(unsigned(waddr) + 1);
			wait for 0 ns;
			histogram(to_integer(unsigned(gsData))) := histogram(to_integer(unsigned(gsData))) + 1;
		end loop;

		-- find binary threshold
		while (his_freq < imgw * imgh / 2) loop
			his_freq     := his_freq + histogram(binary_thres);
			binary_thres := binary_thres + 1;
		end loop;

		done <= '1';
		wait for 0 ns;

		-- read template image
		for i in 0 to tmpw * tmph - 1 loop
			for j in 0 to 2 loop
				wait until rising_edge(clk);
				pix(j) := din;
				raddr  <= std_logic_vector(unsigned(raddr) + 1);
			end loop;
			gsData := gray_scale(pix);
			intGs  := to_integer(unsigned(gsData));
			if intGs - binary_thres <= 0 then
				biData <= '0';
			else
				biData <= '1';
			end if;
		end loop;

		-- Binarize image
		for i in 1 to imgw * imgh loop
			wait until rising_edge(clk);
			intGs := to_integer(unsigned(din));
			if intGs - binary_thres <= 0 then
				biData <= '0';
			else
				biData <= '1';
			end if;
			raddr <= std_logic_vector(unsigned(raddr) + 1);
		end loop;
	end process;
end architecture beh;
