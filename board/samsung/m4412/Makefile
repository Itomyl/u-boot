

#================================================================
#   Copyright (C) 2019 Sangfor Ltd. All rights reserved.
#   
#   文件名称：Makefile
#   创 建 者：yutao : yutao@126.com
#   创建日期：2019年07月21日
#   描    述：
#
#================================================================

# SPDX-License-Identifier: GPL-2.0+
#
# Copyright (C) 2011 Samsung Electronics

ifdef CONFIG_SPL_BUILD
# necessary to create built-in.o
obj- := __dummy__.o

hostprogs-y := tools/mkm4412spl
always := $(hostprogs-y)

# omit -O2 option to suppress
#   warning: dereferencing type-punned pointer will break strict-aliasing rules
#
# TODO:
# Fix the root cause in tools/mkorigenspl.c and delete the following work-around
$(obj)/tools/mkorigenspl: HOSTCFLAGS:=$(filter-out -O2,$(HOSTCFLAGS))
else
obj-y	+= m4412.o
endif
