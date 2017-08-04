library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity squart_tb is
end squart_tb;

architecture behavior of squart_tb is
    function  sqrt( d : UNSIGNED ) return UNSIGNED is
        variable a : unsigned(31 downto 0):=d;  --original input.
        variable q : unsigned(15 downto 0):=(others => '0');  --result.
        variable left,right,r : unsigned(17 downto 0):=(others => '0');  --input to
        variable i : integer:=0;
    begin
        for i in 0 to 15 loop
            right(0):='1';
            right(1):=r(17);
            right(17 downto 2):=q;
            left(1 downto 0):=a(31 downto 30);
            left(17 downto 2):=r(15 downto 0);
            a(31 downto 2):=a(29 downto 0);  --shifting by 2 bit.
            if ( r(17) = '1') then
                r := left + right;
            else
                r := left - right;
            end if;
            q(15 downto 1) := q(14 downto 0);
            q(0) := not r(17);
        end loop;
        return q;
    end sqrt;

	--inputs
	signal clock : std_logic := '0';
	signal data_in_tmp : unsigned(31 downto 0) := (others => '0');
	--outputs
	signal data_out_tmp : unsigned(15 downto 0) := (others => '0');
	-- clock period definitions
	constant clock_period : time := 100 ps;

	signal data_in: std_logic_vector(31 downto 0);
	signal data_out: std_logic_vector(15 downto 0);
begin
	-- clock process definitions
	clock_process :process
	begin
		clock <= '0';
		wait for clock_period/2;
		clock <= '1';
		wait for clock_period/2;
	end process;

    data_in_tmp <= unsigned(data_in);
    data_out <= std_logic_vector(data_out_tmp);
    data_out_tmp <= sqrt(data_in_tmp)
	-- stimulus process
	stim_proc: process
	begin
		wait for clock_period;
        data_in  <= (others => '0');

		wait for 2 * clock_period;
        data_in(10 downto 9) <= (others => '1');

		wait for 2 * clock_period;
        data_in(10 downto 0) <= (others => '1');

        wait for 10*clock_period;
        wait;
	end process;
end behavior;
