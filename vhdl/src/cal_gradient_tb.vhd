--------------------------------------------------------------------------------
-- Project name   : Human detection by HOG
-- File name      : cal_gradient_tb.vhd
-- Created date   : Fri 19 May 2017
-- Author         : Huy Hung Ho
-- Last modified  : Fri 19 May 2017
-- Desc           :
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.all;
USE ieee.numeric_std.ALL;

ENTITY cal_gradient_tb IS
    generic (
                cell_w:         integer := 8;
                pixel_width:    integer := 8
    );
END cal_gradient_tb;

ARCHITECTURE behavior OF cal_gradient_tb IS
    -- Component Declaration for the Unit Under Test (UUT)
    component cal_gradient is
                port (
            clk, clr:   IN std_logic;
            enable:     IN std_logic;
            data_in:    IN std_logic_vector(79 downto 0);
            Gx, Gy:     OUT std_logic_vector(63 downto 0)
        );
    end component cal_gradient;

    --Inputs
    signal clk:     std_logic := '0';
    signal clr:     std_logic := '1';
    signal enable:  std_logic := '0';
    signal data_in: std_logic_vector(79 downto 0) := (others => '0');

    --Outputs
    signal Gx : std_logic_vector(63 downto 0);
    signal Gy : std_logic_vector(63 downto 0);

    -- Clock period definitions
    constant clk_period : time := 100 ps;

    subtype byte is std_logic_vector(pixel_width-1 downto 0);
    type    row_type is array(cell_w + 1 downto 0) of byte;
	signal	row:   row_type;
BEGIN

	-- Instantiate the Unit Under Test (UUT)
   uut: cal_gradient PORT MAP (
          data_in   => data_in,
          clk       => clk,
          clr       => clr,
          enable    => enable,
          Gx        => Gx,
          Gy        => Gy
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period / 2;
		clk <= '1';
		wait for clk_period / 2;
   end process;

    -- control points
	data_in(7 downto 0)   <= row(0);
	data_in(15 downto 8)  <= row(1);
	data_in(23 downto 16) <= row(2);
	data_in(31 downto 24) <= row(3);
	data_in(39 downto 32) <= row(4);
	data_in(47 downto 40) <= row(5);
	data_in(55 downto 48) <= row(6);
	data_in(63 downto 56) <= row(7);
	data_in(71 downto 64) <= row(8);
    data_in(79 downto 72) <= row(9);

   -- Stimulus process
   stim_proc: process
   begin
      	-- hold reset state for 100 ns.
      	wait for clk_period;

		clr <= '0';
        wait until rising_edge(clk);
        enable  <= '1';
		for i in 0 to cell_w+1 loop
			row(i) <= conv_std_logic_vector(i, 8);
        end loop;
        wait until rising_edge(clk);

		for i in 0 to cell_w+1 loop
			row(i) <= conv_std_logic_vector(2*i+1, 8);
        end loop;
        wait until rising_edge(clk);

		for i in 0 to cell_w+1 loop
			row(i) <= conv_std_logic_vector(3*i+2, 8);
        end loop;
        wait until rising_edge(clk);

		for i in 0 to cell_w+1 loop
			row(i) <= conv_std_logic_vector(4*i+3, 8);
        end loop;
        wait until rising_edge(clk);

		wait for clk_period*10;
      	wait;
   end process;

END;

