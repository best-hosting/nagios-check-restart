
# Defaults for programs.
cp		    ?= cp -av
rm		    ?= rm -f -v
rmdir		    ?= rmdir -v --ignore-fail-on-non-empty
mkdir		    ?= mkdir -pv
install		    ?= install
install_program     ?= $(install) -v -m 0755
install_data	    ?= $(install) -v -m 0644
mkinstalldir	    ?= $(install) -v -d -m 0755

# Defaults for installation directories. No trailing slash.
prefix		    ?= /usr/local
sbindir		    ?= $(prefix)/sbin
libdir		    ?= $(prefix)/lib/nagios/plugins
confdir 	    ?= /etc
confdir_nrpe 	    ?= $(confdir)/nagios/nrpe.d
confdir_apt 	    ?= $(confdir)/apt/apt.conf.d

# Use build directory in current directory, if invoked manually, and in
# central build directory otherwise.
ifeq ($(MAKELEVEL), 0)
    builddir	    := $(CURDIR)/build
else
    builddir	    ?= build
    builddir	    := $(builddir)/$(notdir $(CURDIR))
endif

srcdir		    := .
sources		    := checkrestart
configs_nrpe	    := check-debian-restart.cfg
configs_apt	    := 99checkrestart
binaries	    := $(sources)
configs		    := $(configs_apt) $(configs_nrpe)
installed	    := $(installed) $(addprefix $(sbindir)/, $(binaries))
installed	    := $(installed) $(addprefix $(confdir_apt)/, $(configs_apt))
installed	    := $(installed) $(addprefix $(confdir_nrpe)/, $(configs_nrpe))
binaries	    := $(addprefix $(builddir)/, $(binaries))
configs		    := $(addprefix $(builddir)/, $(configs))


all : $(binaries) $(configs)
	

$(binaries) $(configs) : $(builddir)/% : %
	@mkdir -pv $(builddir)
	@cp -v $< $@

# Install per-destination targets.
$(sbindir)/% : $(builddir)/%
	$(install_program) -t $(sbindir) $<

$(confdir_apt)/% : $(builddir)/%
	$(install_data) -t $(confdir_apt) $<

$(confdir_nrpe)/% : $(builddir)/%
	$(install_data) -t $(confdir_nrpe) $<

.PHONY: install
install : $(installed)
	

.PHONY: delete
delete : 
	$(rm) $(binaries) $(configs)
	$(rm) $(installed)
	$(rmdir) $(builddir)

