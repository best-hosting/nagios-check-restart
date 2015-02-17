
# Defaults for installation directories. No trailing slash.
prefix		    ?= /usr/local
sbindir		    ?= $(prefix)/sbin
plugindir	    ?= $(prefix)/lib/nagios/plugins
confdir 	    ?= /etc
confdir_nrpe 	    ?= $(confdir)/nagios/nrpe.d
confdir_apt 	    ?= $(confdir)/apt/apt.conf.d

# Use build directory in current directory, if invoked manually, and in
# central build directory otherwise.
ifeq ($(MAKELEVEL), 0)
    # FIXME: Why $(CURDIR) ?
    #builddir	    := $(CURDIR)/build
    builddir	    := build
else
    builddir	    ?= build
    builddir	    := $(builddir)/$(notdir $(CURDIR))
endif
srcdir		    := .

project_top	    := $(plugindir)/check_debian_restart
project_bin	    := $(sbindir)/checkrestart
project_nrpe	    := $(confdir_nrpe)/check-debian-restart.cfg
project_apt	    := $(confdir_apt)/99checkrestart

programs	    := top bin
data		    := apt nrpe

include ../Makefile.common

