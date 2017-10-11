--------------------------------------------------------------------------------
-- Project name   : Human detection by HOG
-- File name      : rom.vhd
-- Created date   : Fri 05 May 2017
-- Author         : Huy Hung Ho
-- Last modified  : Fri 05 May 2017
-- Desc           :
--------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

library altera_mf;
use altera_mf.all;

entity rom_mem0 is
	port (
        address:    IN std_logic_vector(6 downto 0);
        clock:      IN std_logic;
        q:          OUT std_logic_vector(11 downto 0)
	);
end rom_mem0;

architecture syn of rom_mem0 is
    signal  sub_wire0:  std_logic_vector(11 downto 0);

    component   altsyncram
        generic (
            clock_enable_input_a:   string;
            clock_enable_ouput_a:   string;
            init_file:              string;
            intended_device_family: string;
            lpm_hint:       string;
            lpm_type:       string;
            numword_a:      natural;
            operation_mode: string;
            outdata_aclr_a: string;
            outdata_reg_a:  string;
            widthad_a:      natural;
            width_a:        natural;
            width_byteena_a:    natural
        );
        port (
            clock0:     IN std_logic;
            address_a:  IN std_logic_vector(6 downto 0);
            q_a:        OUT std_logic_vector(11 downto 0)
        );
    end component;
begin
    q <= sub_wire(11 downto 0);

    altsyncram_component: altsyncram
    generic map (
            clock_enable_input_a   => "BYPASS",
            clock_enable_ouput_a   => "BYPASS",
            init_file              => "rom_mem0.mif",
            intended_device_family => "Cyclone II",
            lpm_hint       => "ENABLE_RUNTIME_MOD=NO",
            lpm_type       => "altsyncram",
            numword_a      => 128,
            operation_mode => "ROM",
            outdata_aclr_a => "NONE",
            outdata_reg_a  => "CLOCK0",
            widthad_a      => 7,
            width_a        => 12,
            width_byteena_a   => 1
    )
    port map (
        clock0  => clock,
        address_a   => address,
        q_a     => sub_wire0
    )
end syn;

-- ============================================================
-- CNX file retrieval info
-- ============================================================
-- Retrieval info: PRIVATE: ADDRESSSTALL_A NUMERIC "0"
-- Retrieval info: PRIVATE: AclrAddr NUMERIC "0"
-- Retrieval info: PRIVATE: AclrByte NUMERIC "0"
-- Retrieval info: PRIVATE: AclrOutput NUMERIC "0"
-- Retrieval info: PRIVATE: BYTE_ENABLE NUMERIC "0"
-- Retrieval info: PRIVATE: BYTE_SIZE NUMERIC "8"
-- Retrieval info: PRIVATE: BlankMemory NUMERIC "0"
-- Retrieval info: PRIVATE: CLOCK_ENABLE_INPUT_A NUMERIC "0"
-- Retrieval info: PRIVATE: CLOCK_ENABLE_OUTPUT_A NUMERIC "0"
-- Retrieval info: PRIVATE: Clken NUMERIC "0"
-- Retrieval info: PRIVATE: IMPLEMENT_IN_LES NUMERIC "0"
-- Retrieval info: PRIVATE: INIT_FILE_LAYOUT STRING "PORT_A"
-- Retrieval info: PRIVATE: INIT_TO_SIM_X NUMERIC "0"
-- Retrieval info: PRIVATE: INTENDED_DEVICE_FAMILY STRING "Cyclone II"
-- Retrieval info: PRIVATE: JTAG_ENABLED NUMERIC "0"
-- Retrieval info: PRIVATE: JTAG_ID STRING "NONE"
-- Retrieval info: PRIVATE: MAXIMUM_DEPTH NUMERIC "0"
-- Retrieval info: PRIVATE: MIFfilename STRING "data_file_here"
-- Retrieval info: PRIVATE: NUMWORDS_A NUMERIC "128"
-- Retrieval info: PRIVATE: RAM_BLOCK_TYPE NUMERIC "0"
-- Retrieval info: PRIVATE: RegAddr NUMERIC "1"
-- Retrieval info: PRIVATE: RegOutput NUMERIC "1"
-- Retrieval info: PRIVATE: SYNTH_WRAPPER_GEN_POSTFIX STRING "0"
-- Retrieval info: PRIVATE: SingleClock NUMERIC "1"
-- Retrieval info: PRIVATE: UseDQRAM NUMERIC "0"
-- Retrieval info: PRIVATE: WidthAddr NUMERIC "7"
-- Retrieval info: PRIVATE: WidthData NUMERIC "10"
-- Retrieval info: PRIVATE: rden NUMERIC "0"
-- Retrieval info: CONSTANT: CLOCK_ENABLE_INPUT_A STRING "BYPASS"
-- Retrieval info: CONSTANT: CLOCK_ENABLE_OUTPUT_A STRING "BYPASS"
-- Retrieval info: CONSTANT: INIT_FILE STRING "data_file_here"
-- Retrieval info: CONSTANT: INTENDED_DEVICE_FAMILY STRING "Cyclone II"
-- Retrieval info: CONSTANT: LPM_HINT STRING "ENABLE_RUNTIME_MOD=NO"
-- Retrieval info: CONSTANT: LPM_TYPE STRING "altsyncram"
-- Retrieval info: CONSTANT: NUMWORDS_A NUMERIC "128"
-- Retrieval info: CONSTANT: OPERATION_MODE STRING "ROM"
-- Retrieval info: CONSTANT: OUTDATA_ACLR_A STRING "NONE"
-- Retrieval info: CONSTANT: OUTDATA_REG_A STRING "CLOCK0"
-- Retrieval info: CONSTANT: WIDTHAD_A NUMERIC "7"
-- Retrieval info: CONSTANT: WIDTH_A NUMERIC "10"
-- Retrieval info: CONSTANT: WIDTH_BYTEENA_A NUMERIC "1"
-- Retrieval info: USED_PORT: address 0 0 7 0 INPUT NODEFVAL address[6..0]
-- Retrieval info: USED_PORT: clock 0 0 0 0 INPUT NODEFVAL clock
-- Retrieval info: USED_PORT: q 0 0 10 0 OUTPUT NODEFVAL q[9..0]
-- Retrieval info: CONNECT: @address_a 0 0 7 0 address 0 0 7 0
-- Retrieval info: CONNECT: q 0 0 10 0 @q_a 0 0 10 0
-- Retrieval info: CONNECT: @clock0 0 0 0 0 clock 0 0 0 0
-- Retrieval info: LIBRARY: altera_mf altera_mf.altera_mf_components.all
-- Retrieval info: GEN_FILE: TYPE_NORMAL rom_mem0.vhd TRUE
-- Retrieval info: GEN_FILE: TYPE_NORMAL rom_mem0.inc FALSE
-- Retrieval info: GEN_FILE: TYPE_NORMAL rom_mem0.cmp FALSE
-- Retrieval info: GEN_FILE: TYPE_NORMAL rom_mem0.bsf FALSE
-- Retrieval info: GEN_FILE: TYPE_NORMAL rom_mem0_inst.vhd FALSE
-- Retrieval info: GEN_FILE: TYPE_NORMAL rom_mem0_waveforms.html FALSE
-- Retrieval info: GEN_FILE: TYPE_NORMAL rom_mem0_wave*.jpg FALSE
-- Retrieval info: LIB_FILE: altera_mf
