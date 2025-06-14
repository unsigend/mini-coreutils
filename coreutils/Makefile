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

# Directories definitions
BUILD_DIR	:=		build
SRC_DIR		:=		src
INC_DIR		:=		include
OBJ_DIR		:=		$(BUILD_DIR)/obj
DEP_DIR		:=		$(BUILD_DIR)/dep

# Source files
COREUTILS_SRC_FILES	:=	$(wildcard $(SRC_DIR)/*.c)
# Object files
COREUTILS_OBJ_FILES	:=	$(patsubst $(SRC_DIR)/%.c, $(OBJ_DIR)/%.o, $(COREUTILS_SRC_FILES))
# Dependency files
COREUTILS_DEP_FILES	:=	$(patsubst $(SRC_DIR)/%.c, $(DEP_DIR)/%.d, $(COREUTILS_SRC_FILES))

# CC flags
CC_WARN_FLAGS 	:=	-Wall -Wextra -Werror

CC_DEBUG_FLAGS 	:=
ifeq ($(DEBUG_MODE), 1)
	CC_DEBUG_FLAGS +=	-g
endif

CC_STD_FLAGS 		:=	-std=c11
CC_DEP_FLAGS 		:=	-MMD -MP -MF
CC_INCLUDE_FLAGS 	:=	-I$(INC_DIR)

CC_FLAGS :=	$(CC_WARN_FLAGS) $(CC_DEBUG_FLAGS) $(CC_STD_FLAGS) $(CC_INCLUDE_FLAGS)

# Rules
$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c
	@$(CC) $(CC_FLAGS) $(CC_DEP_FLAGS) $(DEP_DIR)/$*.d -c $< -o $@


.DEFAULT_GOAL := all
.PHONY: all test clean _check_dir

all: _check_dir $(COREUTILS_OBJ_FILES)

test:
	@:

clean:
	@rm -rf $(BUILD_DIR)

_check_dir:
	@mkdir -p $(BUILD_DIR)
	@mkdir -p $(OBJ_DIR)
	@mkdir -p $(DEP_DIR)
