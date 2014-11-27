
# Programs.
cp		    ?= cp -av
rm		    ?= rm -f -v
rmdir		    ?= rmdir -v --ignore-fail-on-non-empty
mkdir		    ?= mkdir -pv
install		    ?= install
install_program     ?= $(install) -v -m 0755
install_data	    ?= $(install) -v -m 0644
mkinstalldir	    ?= $(install) -v -d -m 0755

# Installation directories. No trailing slash.
prefix		    ?= /usr/local
libdir		    ?= $(prefix)/lib/nagios/plugins
confdir 	    ?= $(prefix)/etc
confdir_nrpe 	    ?= $(confdir)/nagios/nrpe.d

srcdir		    := src
# builddir is used by plugin Makefile, and, thus, must contain full path.
builddir	    := $(CURDIR)/build
export builddir

# Find names of all directories containing Makefile-s in $(srcdir) and take
# them as plugin names. Variables here mean not real sources, binaries and
# installed files of plugin (this Makefile can't know them), but rather
# plugin's source directory (containing its Makefile), plugin's build
# directory and non-existent 'install/plugin_name' directory to denote
# plugin real 'install' target.
sources		    := $(dir $(wildcard $(srcdir)/*/Makefile))
plugins		    := $(lastword $(subst /, , $(sources)))
binaries	    := $(addprefix $(builddir)/, $(plugins))
installed	    := $(addprefix install/, $(plugins))

all : $(plugins)
	

# Target plugin by names.
$(plugins) : % : $(builddir)/%
	

$(binaries) : $(builddir)/% : $(srcdir)/%/Makefile
	make -C $(srcdir)/$*

.PHONY: $(installed)
$(installed) : install/% : $(builddir)/%
	make -C $(srcdir)/$* install

.PHONY: install
install : $(installed)
	

