
# Defaults for installation directories. No trailing slash.
prefix              ?= /usr/local
sbindir             ?= $(prefix)/sbin
plugindir           ?= $(prefix)/lib/nagios/plugins
confdir             ?= /etc
confdir_nrpe        ?= $(confdir)/nagios/nrpe.d
confdir_apt         ?= $(confdir)/apt/apt.conf.d
confdir_sudoers     ?= $(confdir)/sudoers.d

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

hostname            := $(shell hostname -f)

project_top         := $(plugindir)/check_debian_restart
project_bin         := $(sbindir)/checkrestart
project_nrpe        := $(confdir_nrpe)/check-debian-restart.cfg
project_apt         := $(confdir_apt)/99checkrestart
project_sudoers     := $(confdir_sudoers)/check-debian-restart
project_etc         := $(confdir)/checkrestart.excludes $(confdir)/default/checkrestart

# send-cache is dependency and is included here as 'git subtree'.
programs            := top bin
data                := $(data) apt nrpe sudoers etc

include ./src/common-build/Makefile.common

$(builddir)/sudoers/check-debian-restart : 
	$(mkdir) $$(dirname "$@")
	echo "nagios  $(hostname) = NOPASSWD: /usr/sbin/checkrestart -b /etc/checkrestart.excludes" > "$@"

$(confdir_sudoers)/check-debian-restart : $(builddir)/sudoers/check-debian-restart
	install -v -m 0440 $< $@
