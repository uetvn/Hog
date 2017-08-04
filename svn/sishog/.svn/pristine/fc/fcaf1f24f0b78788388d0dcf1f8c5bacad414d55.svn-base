--------------------------------------------------------------------------------
-- Project name   :
-- File name      : cell_bin_comp.vhd
-- Created date   : Fri 07 Jul 2017 01:51:35 PM +07
-- Author         : Ngoc-Sinh Nguyen
-- Last modified  : Fri 07 Jul 2017 01:51:35 PM +07
-- Desc           :
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

-- ---------------------------------------------------------------------------- 
-- \brief  Caculate 9-bins of a Cell 8x8
--
-- \returns 9-bins
-- 
-- ---------------------------------------------------------------------------- 
entity cell_bin_comp is
    generic (
        BIN_WIDTH : integer := 8;
        PIX_WIDTH : integer := 8;
        PIXS_PER_LOAD : integer := 1 -- pixel per each load, equal to interface
    );
    port (
	    clk     : in std_logic;
	    rst     : in std_logic;
	    
        grays	: in  unsigned (PIX_WIDTH * PIX_PER_LOAD - 1 downto 0); --! 
        
        din_vld	: out std_logic; --! data in valid
        dou_vld	: out std_logic; --! data out vlid
        bin	    : out std_logic_vector(BIN_WIDTH - 1 downto 0) --! cmt
    );
end entity cell_bin_comp;


architecture behav of cell_bin_comp is
    type BinState is (
        IDLE,
        LOAD_2ROW_OF_PIX_PLUS_1, -- 21 pix then 
        LOAD_1PIX_COMPUTE_1PIX, -- compute bin of row, then move SHIFT_MEM_AND_LOAD_1PIX 
        -- shift one row, and load 1 pixe, then go to LOAD_1PIX_COMPUTE_1PIX (7 times)
        SHIFT_MEM_AND_LOAD_1PIX
    );

    constant PIXs_PER_ROW : integer := 10;
    subtype pix_t    is unsigned (PIX_WIDTH - 1 downto 0);
    type pix_row_t   is pix_t (PIXs_PER_ROW - 1 downto 0); -- 10 elements/row
    type bin_angle_t is std_logic(3 downto 0);


    signal state            : BinState;
    signal three_pix_rows   : pix_row_t (2 downto 0);
    --      + COMP_BIN stage : number of computed bin ( upto 64 pixels)      
    constant MAX_PIX        : integer := 64;


begin

    LOAD: process (rst, clk)
        -- Counter:
        --      + LOAD_PIX stage : number of loaded pixel ( upto 22 pixels)      
        variable counter : integer := 0;
    begin

        if rst = '1' then
            state <= IDLE;
        elsif rising_edge(clk) then
            case state is
                when IDLE => --reset all data;
                    three_pix_rows <= (others => '0');
                when LOAD_PIX => --load pixel
                    three_pix_rows(counter) <= grays;
                    counter := counter + 1;
                    if counter < 21 then
                        state <= LOAD_PIX;
                    else
                        state <= COMP_BIN;
                    end if;
                when COMP_BIN => -- load 1 pix, compute  bin of 1 pix
                    three_pix_rows(counter) <= grays;
                    --compute bin

                    

            end case;
             
        end if;
    end process;


end behav;



