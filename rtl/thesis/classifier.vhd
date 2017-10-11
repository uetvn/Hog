--------------------------------------------------------------------------------
-- Project name   : Human detection by HOG
-- File name      : classifier.vhd
-- Created date   : Mon 08 May 2017
-- Author         : Huy Hung Ho
-- Last modified  : Mon 08 May 2017
-- Desc           :
--------------------------------------------------------------------------------
library ieee ;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;
use ieee.std_logic_arith.all;

entity classifier is
	generic (
		w_cell:     integer := 2;
		h_cell:     integer := 2;
		w_bl:       integer := 10;
		threshold:  integer :=-1000;
		bits_rom_cnt:   integer := 7;
		--bias:       integer:= 20;
		--h_bl:       integer := 6;
		--counter_8:  integer := 3;
		--counter_60: integer := 6;
		--counter_80: integer := 7;
		--w_win_bits: integer := 10;
		--h_win_bits: integer := 9;
		--w_win:      integer := 96;
		--h_win:      integer := 64;
		--lines_cut:  integer := 8;
		--pixel_width:    integer := 8
	);

	port (
		hist:       in signed (125 downto 0)
		clk:        in std_logic;
		init:       in std_logic;
		valid_q:    in std_logic;
		addr_rd:    in std_logic_vector (2 downto 0);

		draw_x:     out std_logic_vector (9 downto 0);
		draw_y:     out std_logic_vector(8 downto 0);
		BOXES:      out std_logic_vector (2 downto 0);
		add_det_x_o:    out std_logic_vector (9 downto 0);
		add_det_y_o:    out std_logic_vector (8 downto 0);
		reg0_o:     out signed (13 downto 0);
		rom0_o:     out signed (11 downto 0);
		--add_wr_o:   out std_logic;
	);
end entity;

architecture arch_class of classifier is
    component rom_mem0 is
		port(
            address:    in std_logic_vector (bits_rom_cnt -1 downto 0);
			clock:      in std_logic ;
			q:          out std_logic_vector (11 downto 0)
		);
	end component;

    component rom_mem1 is
		port(
            address:    in std_logic_vector (bits_rom_cnt -1 downto 0);
			clock:      in std_logic ;
			q:          out std_logic_vector (11 downto 0)
		);
	end component;

	component rom_mem2 is
		port(
            address:    in std_logic_vector (bits_rom_cnt -1 downto 0);
			clock:      in std_logic ;
			q:          out std_logic_vector (11 downto 0)
		);
	end component;

	component rom_mem3 is
		port(
            address:    in std_logic_vector (bits_rom_cnt -1 downto 0);
			clock:      in std_logic ;
			q:          out std_logic_vector (11 downto 0)
		);
	end component;

	component rom_mem4 is
		port(
            address:    in std_logic_vector (bits_rom_cnt -1 downto 0);
			clock:      in std_logic ;
			q:          out std_logic_vector (11 downto 0)
		);
	end component;

	component rom_mem5 is
		port(
            address:    in std_logic_vector (bits_rom_cnt -1 downto 0);
			clock:      in std_logic ;
			q:          out std_logic_vector (11 downto 0)
		);
	end component;

	component rom_mem6 is
		port(
            address:    in std_logic_vector (bits_rom_cnt -1 downto 0);
			clock:      in std_logic ;
			q:          out std_logic_vector (11 downto 0)
		);
	end component;

	component rom_mem7 is
		port(
            address:    in std_logic_vector (bits_rom_cnt -1 downto 0);
			clock:      in std_logic ;
			q:          out std_logic_vector (11 downto 0)
		);
	end component;

	component rom_mem8 is
		port(
            address:    in std_logic_vector (bits_rom_cnt -1 downto 0);
			clock:      in std_logic ;
			q:          out std_logic_vector (11 downto 0)
		);
	end component;

    component ram_x is
        port(
            clk:        in std_logic;
            wr:         in std_logic;
            address_wr: in std_logic_vector (2 downto 0);
            address_rd: in std_logic_vector (2 downto 0);
            mem_wr:     in std_logic_vector (9 downto 0);
            mem_rd:     out std_logic_vector (9 downto 0)
        );
    end component;

    component ram_y is
        port(
            clk:        in std_logic;
            wr:         in std_logic;
            address_wr: in std_logic_vector (2 downto 0);
            address_rd: in std_logic_vector (2 downto 0);
            mem_wr:     in std_logic_vector (8 downto 0);
            mem_rd:     out std_logic_vector (8 downto 0)
        );
    end component;

    signal wr, wr_q, draw_box:  std_logic;
    signal add_wr:              std_logic_vector (2 downto 0);
    signal rom_counter:         std_logic_vector (6 downto 0);

    signal mult_res0, mult_res1, mult_res2, mult_res3, mult_res4:   signed(25 downto 0);
    signal mult_res5, mult_res6, mult_res7, mult_res8: signed(25 downto 0);
    signal mult_res0t, mult_res1t, mult_res2t, mult_res3t, mult_res4t: signed(25 downto 0);
    signal mult_res5t, mult_res6t, mult_res7t, mult_res8t:             signed(25 downto 0);
    signal reg0, reg1, reg2, reg3, reg4: signed(13 downto 0);
    signal reg5, reg6, reg7, reg8:       signed(13 downto 0);
    signal rom0_in, rom1_in, rom2_in, rom3_in, rom4_in:     std_logic_vector(11 downto 0);
    signal rom5_in, rom6_in, rom7_in, rom8_in:              std_logic_vector(11 downto 0);
    signal rom_counter_q, rom_counter_2q, rom_counter_3q:   std_logic_vector(6 downto 0);
    signal rom_counter_4q, rom_counter_5q, rom_counter_6q:  std_logic_vector(6 downto 0);

    signal sum10, sum11, sum12, sum13, sum14:   signed (15 downto 0);
    signal sum20, sum21, sum22:                 signed (15 downto 0);
    signal sum31, sum30:                        signed (15 downto 0);

    signal add_val, temp_sum, res:  signed (15 downto 0);
    signal final_val:               signed (15 downto 0);
    signal det_x, det_x_q:          std_logic_vector (6 downto 0);
    signal det_y, det_y_q:          std_logic_vector (5 downto 0);
    signal add_det_x:               std_logic_vector (9 downto 0);
    signal add_det_y:               std_logic_vector (8 downto 0);
    signal valid_2q, valid:         std_logic;
    signal rom_counter_7q:          std_logic_vector (6 downto 0);
    signal to_thresh:               signed (15 downto 0);
begin
    ROM0: rom_mem0 port map (rom_counter, clk, rom0_in);
    ROM1: rom_mem1 port map (rom_counter, clk, rom1_in);
    ROM2: rom_mem2 port map (rom_counter, clk, rom2_in);
    ROM3: rom_mem3 port map (rom_counter, clk, rom3_in);
    ROM4: rom_mem4 port map (rom_counter, clk, rom4_in);
    ROM5: rom_mem5 port map (rom_counter, clk, rom5_in);
    ROM6: rom_mem6 port map (rom_counter, clk, rom6_in);
    ROM7: rom_mem7 port map (rom_counter, clk, rom7_in);
    ROM8: rom_mem8 port map (rom_counter, clk, rom8_in);

    ramX: ram_x port map (clk, wr, add_wr, addr_rd, add_det_x, draw_x);
    ramY: ram_y port map (clk, wr, add_wr, addr_rd, add_det_y, draw_y);

    add_det_x   <= (det_x_q & "000") + 8;
    add_det_y   <= (det_y_q & "000") + 8;
    add_det_x_o <= add_det_x;
    add_det_y_o <= add_det_y;
    BOXES       <= add_wr;

    process (clk, init, valid_q, hist, rom_counter)
    begin
        if init = '1' then
            reg0 <= (others=>'0');
            reg1 <= (others=>'0');
            reg2 <= (others=>'0');
            reg3 <= (others=>'0');
            reg4 <= (others=>'0');
            reg5 <= (others=>'0');
            reg6 <= (others=>'0');
            reg7 <= (others=>'0');
            reg8 <= (others=>'0');
        else
            if rising_edge(clk) then
                if valid_q= '1' then
                    reg0 <= hist(13 downto 0);
                    reg1 <= hist(27 downto 14);
                    reg2 <= hist(41 downto 28);
                    reg3 <= hist(55 downto 42);
                    reg4 <= hist(69 downto 56);
                    reg5 <= hist(83 downto 70);
                    reg6 <= hist(97 downto 84);
                    reg7 <= hist(111 downto 98);
                    reg8 <= hist(125 downto 112);
                    rom_counter_q <= rom_counter;
                end if;
            end if;
        end if;
    end process;

    temp_sum <= (others=>'0') when rom_counter_6q = conv_std_logic_vector (0, 7) else
                res;

    res <= final_val + add_val;

    final_proc: process (clk, temp_sum, init, valid, rom_counter_5q)
    begin
         if init = '1' then
             final_val <= (others => '0');
         else
             if rising_edge(clk) then
                 if valid = '1' then
                     final_val <= temp_sum;
                 else
                     final_val <= final_val;
                 end if;

                 rom_counter_6q <= rom_counter_5q;
             end if;
         end if;
    end process;

    write_ram: process (clk, wr, init, valid_q, det_x, det_y )
    begin
        if init = '1' then
            wr_q     <= '0';
            valid_2q <= '0';
        else
            if rising_edge(clk) then
                wr_q     <= wr;
                valid    <= valid_2q ;
                valid_2q <= valid_q;
                det_y_q  <= det_y;
                det_x_q  <= det_x;
            end if;
        end if;
    end process;

    coefs: process (clk, init, valid)   -- Go to next pixel (det_x, det_y)
    begin
        if init = '1' then
            det_x <= (others=> '0');
            det_y <= (others=> '0');
        else
            if rising_edge(clk) then
                if valid = '1' then
                    if rom_counter = conv_std_logic_vector ((w_cell * h_cell)-1, 7) then
                        if det_x = conv_std_logic_vector (w_bl - w_cell, 10) then
                            det_y <= det_y + 1;
                            det_x <= (others=> '0');
                        else
                            det_y <= det_y;
                            det_x <= det_x + 1;
                        end if;
                    else
                        det_x <= det_x ;
                        det_y <= det_y;
                    end if;
                end if;
            end if;
        end if;
    end process;

    thres: process (init, clk, wr, add_wr, rom_counter_6q, rom_counter_7q,
        final_val, draw_box)
    begin
        if init = '1' then
            add_wr <= (others => '0');
            wr     <= '0';
        else
            if rising_edge(clk) then
                rom_counter_7q <= rom_counter_6q;
                if rom_counter_7q = conv_std_logic_vector((w_cell * h_cell)-1, 7) then
                    to_thresh <= res;
                    draw_box  <= '1';
                else
                    draw_box  <= '0';
                end if;
                if draw_box = '1' then
                    if to_thresh < conv_signed(threshold, 16) then
                        if add_wr = "111" then
                            wr     <= '0';
                            add_wr <= add_wr;
                        else
                            wr     <= '1';
                            add_wr <= add_wr +1;
                        end if;
                    end if;
                else
                    wr     <= '0';
                    add_wr <= add_wr;
                end if;
            end if;
        end if;
    end process;

    address_cnt: process (clk, init, valid, rom_counter)
    begin
        if init = '1' then
            rom_counter <= (others=> '0');
        else
            if rising_edge(clk) then
                if valid_q = '1' then
                    if rom_counter = conv_std_logic_vector ((w_cell *
                    h_cell) - 1, 7) then
                        rom_counter <= (others => '0');
                    else
                        rom_counter <= rom_counter +1;
                    end if;
                end if;
            end if;
        end if;
    end process;

    reg0_o <= reg0 ;
    rom0_o <= signed(rom0_in);
    mult_res0 <= reg0 * signed(rom0_in);
    mult_res1 <= reg1 * signed(rom1_in);
    mult_res2 <= reg2 * signed(rom2_in);
    mult_res3 <= reg3 * signed(rom3_in);
    mult_res4 <= reg4 * signed(rom4_in);
    mult_res5 <= reg5 * signed(rom5_in);
    mult_res6 <= reg6 * signed(rom6_in);
    mult_res7 <= reg7 * signed(rom7_in);
    mult_res8 <= reg8 * signed(rom8_in);

    mults: process (clk, init, reg0, reg1, reg2, reg3, reg4, reg5, reg6, reg7,
        reg8, valid_2q, rom0_in, rom1_in, rom2_in, rom3_in, rom4_in, rom5_in,
        rom6_in, rom7_in, rom8_in, res)
    begin
        if init = '1' then
            mult_res0t <= (others=> '0');
            mult_res1t <= (others=> '0');
            mult_res2t <= (others=> '0');
            mult_res3t <= (others=> '0');
            mult_res4t <= (others=> '0');
            mult_res5t <= (others=> '0');
            mult_res6t <= (others=> '0');
            mult_res7t <= (others=> '0');
            mult_res8t <= (others=> '0');
        else
            if rising_edge (clk) then
                if valid_2q = '1' then
                    mult_res0t <= mult_res0;
                    mult_res1t <= mult_res1;
                    mult_res2t <= mult_res2;
                    mult_res3t <= mult_res3;
                    mult_res4t <= mult_res4;
                    mult_res5t <= mult_res5;
                    mult_res6t <= mult_res6;
                    mult_res7t <= mult_res7;
                    mult_res8t <= mult_res8;
                end if;
            end if;
        end if;
    end process;

    sums: process (clk, init,sum10, sum11, sum12, sum13, sum14, sum20, sum21,
        sum22, sum30, sum31, rom_counter_q, rom_counter_2q, rom_counter_3q,
        rom_counter_4q, mult_res0, mult_res1, mult_res2, mult_res3, mult_res4,
        mult_res5, mult_res6, mult_res7, mult_res8)
    begin
        if init = '1' then
            sum10 <= (others=> '0');
            sum11 <= (others=> '0');
            sum12 <= (others=> '0');
            sum13 <= (others=> '0');
            sum14 <= (others=> '0');
            sum20 <= (others=> '0');
            sum21 <= (others=> '0');
            sum22 <= (others=> '0');
            sum30 <= (others=> '0');
            sum31 <= (others=> '0');
        else
            if rising_edge (clk) then
                if valid = '1' then
                    sum10 <= mult_res0t (25 downto 10)+ mult_res4t(25 downto
                             10);
                    sum11 <= mult_res1t (25 downto 10)+ mult_res5t(25 downto
                             10);
                    sum12 <= mult_res2t (25 downto 10)+ mult_res6t(25 downto
                             10);
                    sum13 <= mult_res3t (25 downto 10)+ mult_res7t(25 downto
                             10);
                    sum14 <= mult_res8t (25 downto 10);
                    rom_counter_2q <= rom_counter_q;

                    sum20 <= sum10 + sum11;
                    sum21 <= sum12 + sum13;
                    sum22 <= sum14;
                    rom_counter_3q <= rom_counter_2q;

                    sum30 <= sum20 + sum21;
                    sum31 <= sum22;
                    rom_counter_4q <= rom_counter_3q;

                    add_val <= sum30 + sum31;
                    rom_counter_5q <= rom_counter_4q;
                end if;
            end if;
        end if;
    end process;
end architecture;
