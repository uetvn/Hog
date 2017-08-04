# author: Duy-Hieu BUI <hieubd@vnu.edu.vn>
# Tools  setups ----------------------------------------------------------------
export PROJECT_DIR=`pwd`
# Environment variable
#	SYNOPSYS_HOME=""
#	MENTOR_HOME=""
#	MODELSIM_HOME="
#	DESIGN_KIT_PATH=""

#Critical ENV
export CLOCK_PERIOD=2
export DESIGN_NAME=pix_bin_comp

# For post synthesis
export DESIGN_NETLIST="${PROJECT_DIR}/syn/results/${DESIGN_NAME}.mapped.v"
export DESIGN_VCD_FILE="${PROJECT_DIR}/sim/${DESIGN_NAME}.vcd.gz"
export DESIGN_INSTANCE_PATH="/aes_fips_tester/aes_i"
export DESIGN_SDF_FILE="${PROJECT_DIR}/syn/results/${DESIGN_NAME}.mapped.sdf"
export DESIGN_CONSTRAINT_FILE="${DESIGN_NAME}.mapped.sdc"
# ------------------------------------------------------------------------------


# CHECK setups/ENV -------------------------------------------------------------
# If a $1 does not exist, set to $2
function env_non_exist_use_default() {
	cmd="if [[ -z \$$1 ]]; then
		echo -e \"\033[0;33mWarn\033[0m: $1: No such environment variable\";
		echo -e \"Setting to default: $1=$2\";
		export $1=$2;
	fi"
	eval $cmd

}
# If ENV does not exist, return error
function envs_non_exist_return_error() {
	for args
	do
		cmd="if [[ -z \$$args ]]; then
			echo -e \"\033[0;31mError\033[0m: $args: No such environment variable\";
		fi"
		eval $cmd
	done
}
function check_file_dir_exist() {
	for args
	do
		if [[ ! -d "${args}" && ! -e "${args}"  ]]; then
			echo -e "\033[0;31mError\033[0m: ${args}: No such file or directory"
		fi
	done
}
# ------------------------------------------------------------------------------

env_non_exist_use_default "SYNOPSYS_HOME" "/home/apps/synopsys"
source ${SYNOPSYS_HOME}/synopsys.sh
env_non_exist_use_default "SYNOPSYS_HOME" "/home/apps/synopsys"
env_non_exist_use_default "MENTOR_HOME" "/home/apps/mentor/Questasim/10.1d/"
export PATH=${PATH}:${MENTOR_HOME}/questasim/bin
env_non_exist_use_default "DESIGN_KIT_PATH" \
	"/home/dkit/FreePDK45/NangateOpenCellLibrary_PDKv1_3_v2010_12"

envs_non_exist_return_error "DESIGN_NAME" "CLOCK_PERIOD"
check_file_dir_exist ${SYNOPSYS_HOME} \
	${MENTOR_HOME} 

# Return result ----------------------------------------------------------------
echo "
-------------------------------------------------------------------------
PROJECT PARAMETERs
-------------------------------------------------------------------------
Project directory    = ${PROJECT_DIR}
SYNOPSYS_HOME        = ${SYNOPSYS_HOME}
DESIGN_KIT_PATH      = ${DESIGN_KIT_PATH}
DESIGN_NAME          = ${DESIGN_NAME}
CLOCK_PERIOD         = ${CLOCK_PERIOD}
-------------------------------------------------------------------------
"
