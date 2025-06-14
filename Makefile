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


# Main Makefile for building mini-coreutils and qsh
# Designed for kernel development

# Include config
include config/Makefile

export CC
export CXX
export DEBUG_MODE
export KERNEL_MODE

# Directories definitions
ROOT_DIR  	:=  .
UTIL_DIR	:=	coreutils
SHELL_DIR	:=	qsh

.PHONY: clean all utils qsh help test test-utils test-qsh
.DEFAULT_GOAL := help

# Clean all builds
clean:
	@$(MAKE) -C $(UTIL_DIR) clean
	@$(MAKE) -C $(SHELL_DIR) clean

# Test all including coreutils and qsh
test: test-utils test-qsh

# Build all including coreutils and qsh
all: utils qsh

# Build coreutils
utils:
	@$(MAKE) -C $(UTIL_DIR) all

test-utils:
	@$(MAKE) -C $(UTIL_DIR) test

# Build qsh
qsh:
	@$(MAKE) -C $(SHELL_DIR) all

test-qsh:
	@$(MAKE) -C $(SHELL_DIR) test

# Show help message
help:
	@echo "USAGE: "
	@echo "  make all\t\tbuild all including coreutils and qsh"
	@echo "  make help\t\tshow this help message"
	@echo "  make utils\t\tbuild coreutils"
	@echo "  make qsh\t\tbuild qsh"
	@echo "  make test\t\ttest all including coreutils and qsh"
	@echo "  make test-utils\ttest coreutils"
	@echo "  make test-qsh\t\ttest qsh"
	@echo "  make clean\t\tclean all builds"

