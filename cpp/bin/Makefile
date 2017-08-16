##############################################################################
# Project name   :
# File name      : Makefile
# Last modified  : Wed 16 Aug 2017 01:06:42 AM ICT
# Guide          :
###############################################################################
.PHONY: all run clean cleanall tags syntatic

CC 		:= gcc
CFLAGS  += -Wall -g
INC     := -I./inc
LFLAGS 	+= -s -lm
TARGET 	:= hog

vpath %.c src
vpath %.h inc

SUB_DIR := .obj
CREATE_SUB_DIR := $(shell mkdir -p $(SUB_DIR))
vpath %.o $(SUB_DIR)
vpath %.d $(SUB_DIR)

SRCS := $(wildcard src/*.c)
INCS := $(wildcard inc/*.h)
OBJS := $(addprefix $(SUB_DIR)/,$(notdir $(SRCS:.c=.o)))
DEPS := $(addprefix $(SUB_DIR)/,$(notdir $(SRCS:.c=.d)))

all : $(TARGET)
$(TARGET) : $(OBJS)
	@$(CC) $(LFLAGS) $(INC) $(OBJS) -o $@ -lm

$(SUB_DIR)/%.o: %.c
	@$(CC) -c $(CFLAGS) $(INC) -MMD -MP $< -o $@

run:
	./hog -i TEST.png

clean:
	@-rm -rf $(SUB_DIR)

cleanall:
	@-rm -rf $(SUB_DIR) $(TARGET) detected*

tags : $(SRCS) $(INCS)
	ctags -f ./.tags --c-kinds=+p --fields=+iaS --extra=+fq ./inc

syntatic:
	  echo "$(INC)" > .syntastic_c_config
	  echo "$(CFLAGS)" >> .syntastic_c_config
	  echo "$(LFLAGS)" >> .syntastic_c_config
	  sed -i 's/ -/\n-/g' .syntastic_c_config


