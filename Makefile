
# Defaults for installation directories. No trailing slash.
prefix              ?= /usr/local
sbindir             ?= $(prefix)/sbin
plugindir           ?= $(prefix)/lib/nagios/plugins
confdir             ?= /etc
confdir_nrpe        ?= $(confdir)/nagios/nrpe.d
confdir_apt         ?= $(confdir)/apt/apt.conf.d

# $(builddir) is passed to send-cache's Makefile and, thus, must contain full
# path.
ifeq ($(MAKELEVEL), 0)
    builddir        := $(CURDIR)/build
    # I build send-cache only, if this is top-level project.  Otherwise,
    # parent project should include send-cache explicitly.
    data            := send-cache
else
    builddir        ?= build
    builddir        := $(builddir)/$(notdir $(CURDIR))
endif
export builddir
srcdir              := src

project_top         := $(plugindir)/check_debian_restart
project_bin         := $(sbindir)/checkrestart
project_nrpe        := $(confdir_nrpe)/check-debian-restart.cfg
project_apt         := $(confdir_apt)/99checkrestart

# send-cache is dependency and is included here as 'git subtree'.
programs            := top bin
data                := $(data) apt nrpe

include ./src/common-build/Makefile.common

