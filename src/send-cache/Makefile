
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
libdir		    ?= $(prefix)/lib/nagios/plugins
confdir 	    ?= $(prefix)/etc
confdir_nrpe 	    ?= $(confdir)/nagios/nrpe.d

# Use build directory in current directory, if invoked manually, and in
# central build directory otherwise.
ifeq ($(MAKELEVEL), 0)
    builddir	    := $(CURDIR)/build
else
    builddir	    ?= build
    builddir	    := $(builddir)/$(notdir $(CURDIR))
endif

srcdir		    := .
sources		    := send-cache.sh
binaries	    := $(basename $(sources))
installed	    := $(addprefix $(libdir)/, $(binaries))
binaries	    := $(addprefix $(builddir)/, $(basename $(sources)))

all : $(binaries)
	

build : all
	

remove : delete
	

$(binaries) : $(builddir)/% : %.sh
	mkdir -pv $(builddir)
	cp $< $@

.PHONY: clean
clean : 
	$(rm) $(binaries)
	$(rmdir) $(builddir) || true

$(installed) : $(libdir)/% : $(builddir)/%
	$(install_program) -t $(libdir) $<

.PHONY: install
install : $(installed)
	

.PHONY: delete
delete : 
	$(rm) $(installed)

