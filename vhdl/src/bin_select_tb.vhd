library ieee;
use ieee.std_logic_1164.all;

entity bin_select_tb is
end bin_select_tb;

architecture behavior of bin_select_tb is

    -- component declaration for the unit under test (uut)
    component bin_sel
    port(
         clk : in  std_logic;
         Gx : in  std_logic_vector(7 downto 0);
         Gy : in  std_logic_vector(7 downto 0);
         bin : out  std_logic_vector(3 downto 0);
         rate : out  std_logic_vector(15 downto 0)
        );
    end component;

   --inputs
   signal clk : std_logic := '0';
   signal Gx : std_logic_vector(7 downto 0) := (others => '0');
   signal Gy : std_logic_vector(7 downto 0) := (others => '0');

 	--outputs
   signal bin : std_logic_vector(3 downto 0);
   signal rate : std_logic_vector(15 downto 0);

   -- clock period definitions
   constant clk_period : time := 100 ps;

begin

	-- instantiate the unit under test (uut)
   uut: bin_sel port map (
          clk => clk,
          Gx => Gx,
          Gy => Gy,
          bin => bin,
          rate => rate
        );

   -- clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;


    -- stimulus process
    stim_proc: process
    begin
        wait for clk_period;
        wait;
    end process;

end;
