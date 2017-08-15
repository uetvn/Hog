##############################################################################
# Project name   :
# File name      : Makefile
# Last modified  : Wed 16 Aug 2017 01:06:42 AM ICT
# Guide          :
###############################################################################
.PHONY: all run clean cleanall

CC 		:= gcc
CFLAGS  += -Wall -g -I./inc
LFLAGS 	+= -s
TARGET 	:= hog

vpath %.c src
vpath %.h inc

SUB_DIR := obj
CREATE_SUB_DIR := $(shell mkdir -p $(SUB_DIR))
vpath %.o $(SUB_DIR)
vpath %.d $(SUB_DIR)

SRCS := $(wildcard src/*.c)
INCS := $(wildcard inc/*.h)
OBJS := $(addprefix $(SUB_DIR)/,$(notdir $(SRCS:.c=.o)))
DEPS := $(addprefix $(SUB_DIR)/,$(notdir $(SRCS:.c=.d)))

all : $(TARGET)
$(TARGET) : $(OBJS)
	@$(CC) $(LFLAGS) $(OBJS) -o $@ -lm

$(SUB_DIR)/%.o: %.c
	@$(CC) -c $(CFLAGS) -MMD -MP $< -o $@

run:
	./hog -i TEST.png

clean:
	@-rm -rf $(SUB_DIR)

cleanall:
	@-rm -rf $(SUB_DIR) $(TARGET) detected*

