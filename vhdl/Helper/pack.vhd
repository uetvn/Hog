library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package pack is
	constant ADDR_WIDTH : integer := 21;

	constant RAM_DEPTH : integer := 2 ** ADDR_WIDTH;
--	constant RAM_DEPTH : integer := 50;


	constant thres : integer := 500;    		--threshold
--	constant thres : integer := 1;

	constant imgw : integer := 640;				-- image width
	constant imgh : integer := 480;				-- image height
	constant tmpw : integer := 40;				-- template image width
	constant tmph : integer := 100;				-- template image height
--	constant imgw : integer := 2;
--	constant imgh : integer := 3;
--	constant tmpw : integer := 2;
--	constant tmph : integer := 2;

	constant CLK_CYCLE : time := 10 ns;

	subtype addr is std_logic_vector(ADDR_WIDTH - 1 downto 0);		-- address type
	subtype byte is std_logic_vector(7 downto 0);					-- byte type
	type ram is array (0 to RAM_DEPTH - 1) of byte;					-- ram

	constant INIT_ADDR : addr := std_logic_vector(to_unsigned(0, ADDR_WIDTH)); 				--initial address
	constant GS_WRITE_ADDR : addr := std_logic_vector(to_unsigned(imgw*imgh*3 + tmpw*tmph*3, ADDR_WIDTH));


	-- address at which written the indexes of marked pixels
	-- order: row index then column index, then row index of next marked pixel and so on
	constant MARK_PIXEL_ADDR : addr := std_logic_vector(to_unsigned(1000000, ADDR_WIDTH));
--	constant MARK_PIXEL_ADDR : addr := std_logic_vector(to_unsigned(40, ADDR_WIDTH));

	function intToByte(d : integer) return byte;

end package pack;

package body pack is
	function intToByte(d : integer) return byte is
		variable res : byte;
	begin
		res := std_logic_vector(to_unsigned(d, 8));
		return res;

	end intToByte;

end package body pack;
