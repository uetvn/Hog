--------------------------------------------------------------------------------
-- Project name   : Human detection by HOG
-- File name      : histogram_generator.vhd
-- Created date   : Mon 08 May 2017
-- Author         : Huy Hung Ho
-- Last modified  : Mon 08 May 2017
-- Desc           :
--------------------------------------------------------------------------------

library ieee ;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity hist_gen is
    generic (
        --rows:	    integer := 32;
        --columns:	integer := 24;
        --w_win_bits:	integer := 10;
        --h_win_bits:	integer := 9;
        pixel_width: integer := 8
    );
    port (
        clk:	    in std_logic;
        clr:	    in std_logic;
        bin:        in std_logic_vector (3 downto 0);
        Gx, Gy:     in std_logic_vector (pixel_width-1 downto 0);
        sl:         in std_logic;
        wr_init:    in std_logic;

        mem_wr:		in std_logic;
        addwr:		in std_logic_vector (12 downto 0);
        addrd:		in std_logic_vector (12 downto 0);
        sl_in:		in std_logic_vector (1 downto 0)
        memory_out:	out std_logic_vector (125 downto 0)
    );
end entity;

architecture hist_beh of hist_gen is
    component ram
        port(
                clk:	in std_logic;
                wr:		in std_logic;
                address_wr:	in std_logic_vector (12 downto 0);
                address_rd:	in std_logic_vector (12 downto 0);
                mem_wr:	in std_logic_vector (125 downto 0);
                mem_rd:	out std_logic_vector (125 downto 0)
            );
    end component;

    type hist_calc is array (8 downto 0) of std_logic_vector (13 downto 0);

    signal hist_calc1, hist_calc2:	hist_calc;  -- 2 arrays for count bin register
    signal hist_i1, hist_i2:		hist_calc;
    signal hist_init1, hist_init2:	hist_calc;
    signal sl_q:                std_logic;
    signal hist_i1r, hist_i2r:	std_logic_vector(13 downto 0);
    signal sum_abs:				std_logic_vector (pixel_width -1 downto 0); -- |Gx| + |Gy|
    signal sum:					std_logic_vector(13 downto 0); -- "000000" & |Gx|+|Gy|
    signal wr:					std_logic_vector (8 downto 0); -- DEMUX: bin -> reg enable
    signal hist_o1, hist_o2:	std_logic_vector (13 downto 0); -- output reg1, reg2
    signal add_val:				std_logic_vector (13 downto 0);
    signal wr1, wr2:			std_logic_vector (8 downto 0); -- ... counter
    signal ram_in:				std_logic_vector (125 downto 0);
    signal ram_out:				std_logic_vector (125 downto 0);

    --temp signals for memory
    signal reg0:    std_logic_vector (13 downto 0);
    signal reg1:    std_logic_vector (13 downto 0);
    signal reg2:    std_logic_vector (13 downto 0);
    signal reg3:    std_logic_vector (13 downto 0);
    signal reg4:    std_logic_vector (13 downto 0);
    signal reg5:    std_logic_vector (13 downto 0);
    signal reg6:    std_logic_vector (13 downto 0);
    signal reg7:    std_logic_vector (13 downto 0);
    signal reg8:    std_logic_vector (13 downto 0);
begin
    memory_out <= ram_out;

    memory : ram
    port map (clk, mem_wr, addwr, addrd, ram_out, ram_in);

    ---MUX exit hist_gen at mux
    hist_o1 <=	hist_calc1 (0) when bin= "0001" else
               hist_calc1 (1) when bin= "0010" else
               hist_calc1 (2) when bin= "0011" else
               hist_calc1 (3) when bin= "0100" else
               hist_calc1 (4) when bin= "0101" else
               hist_calc1 (5) when bin= "0110" else
               hist_calc1 (6) when bin= "0111" else
               hist_calc1 (7) when bin= "1000" else
               hist_calc1 (8);

    hist_o2 <=	hist_calc2 (0) when bin= "0001" else
               hist_calc2 (1) when bin= "0010" else
               hist_calc2 (2) when bin= "0011" else
               hist_calc2 (3) when bin= "0100" else
               hist_calc2 (4) when bin= "0101" else
               hist_calc2 (5) when bin= "0110" else
               hist_calc2 (6) when bin= "0111" else
               hist_calc2 (7) when bin= "1000" else
               hist_calc2 (8);

    add_val <=	hist_o1 when sl ='0' else
               hist_o2;

    sum_abs <= ('0' & Gx(pixel_width -2 downto 0)) + ('0' & Gy(pixel_width -2 downto 0));
    sum     <= add_val + ("000000" & sum_abs);


    -- control points
    reg0 <= ram_in(13 downto 0);
    reg1 <= ram_in(27 downto 14);
    reg2 <= ram_in(41 downto 28);
    reg3 <= ram_in(55 downto 42);
    reg4 <= ram_in(69 downto 56);
    reg5 <= ram_in(83 downto 70);
    reg6 <= ram_in(97 downto 84);
    reg7 <= ram_in(111 downto 98);
    reg8 <= ram_in(125 downto 112);
    --
    ---DEMUX bin ->
    wr <=  "000000001" when bin= "0001" else
           "000000010" when bin= "0010" else
           "000000100" when bin= "0011" else
           "000001000" when bin= "0100" else
           "000010000" when bin= "0101" else
           "000100000" when bin= "0110" else
           "001000000" when bin= "0111" else
           "010000000" when bin= "1000" else
           "100000000";

    wr_gen : for i in 0 to 8 generate
    begin
        wr1(i) <= (wr_init and sl) or (not (sl) and wr(i));
        wr2(i) <= (wr_init and not (sl)) or (sl and wr(i));
    end generate wr_gen;

    dff: process(clk,clr,sl)
    begin
        if clr='1' then
            sl_q<='0';
        else
            if rising_edge(clk) then
                sl_q <= sl;
            end if;
        end if;
    end process dff;


    sel_gen1: for i in 0 to 8 generate
        mux_sel1: process (sl_in, hist_i1r, hist_i2r, ram_in)
        begin
            case sl_in(0) is
                when '0' =>
                    hist_init1(i) <= ram_in (14 * (i + 1) - 1 downto 14 * i);
                    hist_init2(i) <= (others => '0');
                when others =>
                    hist_init1(i) <= (others => '0');
                    hist_init2(i) <= ram_in (14 * (i + 1) - 1 downto 14 * i);
            end case;
        end process mux_sel1;
    end generate sel_gen1;


    sl_gen : for i in 0 to 8 generate
    begin
        mux_sl: process (sl_in, sum, ram_in, hist_init2, hist_init1)
        begin
            case sl_in(1) is
                when '0' =>
                    hist_i1(i) <= hist_init1(i);
                    hist_i2(i) <= sum;
                when others =>
                    hist_i1(i) <= sum;
                    hist_i2(i) <= hist_init2(i);
            end case;
        end process mux_sl;
    end generate sl_gen;

    reg_gen : for i in 0 to 8 generate
    begin
        reg: process (clk, clr, wr1, wr2, hist_i1, hist_i2 )
        begin
            if clr='1' then
                hist_calc1(i) <= (others=>'0');
                hist_calc2(i) <= (others=>'0');
            else
                if rising_edge(clk) then
                    if wr1(i)='1' then
                        hist_calc1(i) <= hist_i1(i);
                    else
                        hist_calc1(i) <= hist_calc1(i);
                    end if;
                    if wr2(i)='1' then
                        hist_calc2(i) <= hist_i2(i);
                    else
                        hist_calc2(i) <= hist_calc2(i);
                    end if;
                end if;
            end if;
        end process reg;
    end generate reg_gen;


    mux_gen : for i in 0 to 8 generate
    begin
        mux: process (sl_q, hist_calc1, hist_calc2)
        begin
            case sl_q is
                when '0' =>
                    ram_out (14*(i+1)-1 downto 14*i) <= hist_calc1(i);
                when others =>
                    ram_out (14*(i+1)-1 downto 14*i) <= hist_calc2(i);
            end case;
        end process mux;
    end generate mux_gen;
end architecture;
