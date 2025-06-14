# mini-coreutils - A minimal set of core utilities for Unix-like systems
# Copyright (C) 2025 Qiu Yixiang
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.
#

# Coreutils Makefile

# The library will always be built as default
# When the flag for standalone is set, the executable files 
#  will be built for every command
# The library will be exported to the root build directory for qsh to use

# Directories definitions
BUILD_DIR	:=		build
SRC_DIR		:=		src
INC_DIR		:=		include
OBJ_DIR		:=		$(BUILD_DIR)/obj
DEP_DIR		:=		$(BUILD_DIR)/dep
ROOT_DIR	:=		..
LIB_DIR		:=		$(ROOT_DIR)/build/lib
BIN_DIR		:=		$(ROOT_DIR)/build/bin

# Source files
COREUTILS_SRC_FILES	:=	$(wildcard $(SRC_DIR)/*.c)
# Object files
COREUTILS_OBJ_FILES	:=	$(patsubst $(SRC_DIR)/%.c, $(OBJ_DIR)/%.o, $(COREUTILS_SRC_FILES))
# Bin files
COREUTILS_BIN_FILES	:=	$(patsubst $(SRC_DIR)/%.c, $(BIN_DIR)/%, $(COREUTILS_SRC_FILES))
# Dependency files
COREUTILS_DEP_FILES	:=	$(patsubst $(SRC_DIR)/%.c, $(DEP_DIR)/%.d, $(COREUTILS_SRC_FILES))

# CC flags
CC_WARN_FLAGS 	:=	-Wall -Wextra -Werror -Wshadow

CC_DEBUG_FLAGS 	:=
ifeq ($(DEBUG_MODE), 1)
	CC_DEBUG_FLAGS +=	-g
endif

CC_STD_FLAGS 		:=	-std=c11
CC_DEP_FLAGS 		:=	-MMD -MP -MF
CC_INCLUDE_FLAGS 	:=	-I$(INC_DIR)
CC_MACRO_FLAGS 		:=
ifeq ($(STAND_ALONE_MODE), 1)
	CC_MACRO_FLAGS +=	-DCOREUTILS_STAND_ALONE_MODE
endif

CC_FLAGS :=	$(CC_WARN_FLAGS) $(CC_DEBUG_FLAGS) $(CC_STD_FLAGS)
CC_FLAGS +=	$(CC_INCLUDE_FLAGS) $(CC_MACRO_FLAGS) $(CC_DEP_FLAGS)

# Shared library postfix
HOST_OS := $(shell uname -s)
ifeq ($(HOST_OS), Linux)
	SHARED_LIB_POSTFIX :=	.so
else
	SHARED_LIB_POSTFIX :=	.dylib
endif

# Rules
$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c
	@echo " + CC\t$@"
	@$(CC) $(CC_FLAGS) $(CC_DEP_FLAGS) $(DEP_DIR)/$*.d -c $< -o $@

$(BIN_DIR)/%: $(OBJ_DIR)/%.o
	@echo " + CC\t$@"
	@$(CC) -o $@ $<

$(LIB_DIR)/libcoreutils.a: $(COREUTILS_OBJ_FILES)
	@echo " + AR\t$@"
	@$(AR) rcs $@ $^

$(LIB_DIR)/libcoreutils$(SHARED_LIB_POSTFIX): $(COREUTILS_OBJ_FILES)
	@echo " + LD\t$@"
	@$(CC) -shared -o $@ $^

# Targets
TARGETS  :=
ifeq ($(STAND_ALONE_MODE), 1)
TARGETS += $(COREUTILS_BIN_FILES) 
else
TARGETS += $(LIB_DIR)/libcoreutils.a 
TARGETS += $(LIB_DIR)/libcoreutils$(SHARED_LIB_POSTFIX)
endif

.DEFAULT_GOAL := all
.PHONY: all test clean _check_dir

# Include dependency files if they exist
-include $(wildcard $(DEP_DIR)/*.d)

all: _check_dir $(TARGETS)

test:
	@:

clean:
	@rm -rf $(BUILD_DIR)

_check_dir:
	@mkdir -p $(BUILD_DIR)
	@mkdir -p $(OBJ_DIR)
	@mkdir -p $(DEP_DIR)
ifeq ($(STAND_ALONE_MODE), 0)
	@mkdir -p $(LIB_DIR)
else
	@mkdir -p $(BIN_DIR)
endif
