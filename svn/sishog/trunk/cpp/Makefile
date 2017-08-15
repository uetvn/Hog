################################################################################
# Project name   :
# File name      : Makefile
# Created date   : Fri 14 Jul 2017 11:08:37 AM +07
# Author         : Ngoc-Sinh Nguyen
# Last modified  : Fri 14 Jul 2017 11:08:37 AM +07
# Guide          :
###############################################################################

CC := g++
FLAGS += -g
INC += -I ./src
LD_LIB += -lm
#VPATH := inc src

BUILD := build
OBJ_DIR := build/obj
SUBDIRS := build $(OBJ_DIR)
CREATE_SUBDIRS := $(shell mkdir -p $(SUBDIRS))

vpath %.h src
vpath %.cpp src tests
vpath %.o $(OBJ_DIR)

pix_bin_comp_SRCS := src/pix_bin_comp.cpp tests/main_pix_bin_comp.cpp
pix_bin_comp_OBJS := $(addprefix $(OBJ_DIR)/,$(notdir $(pix_bin_comp_SRCS:.cpp=.o)))

pix_bin_comp: $(pix_bin_comp_OBJS)
	@echo "pix_bin_comp_OBJS: $(pix_bin_comp_OBJS)"
	@echo "pix_bin_comp_SRCS: $(pix_bin_comp_SRCS)"
	    $(CC) $(FLAGS) $(INC) $^ -o build/$@ $(LD_LIB)

$(OBJ_DIR)/%.o : %.cpp
	    $(CC) -c  $(FLAGS) $(INC) $< -o $@

cleanobj:
	rm -rf $(OBJ_DIR)
clean:
	rm -rf $(SUBDIRS)
