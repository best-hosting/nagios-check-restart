
# Defaults for installation directories. No trailing slash.
prefix		    ?= /usr/local

srcdir		    := src
# $(builddir) is passed to plugin's Makefile and, thus, must contain full
# path.
ifeq ($(MAKELEVEL), 0)
    builddir	    := $(CURDIR)/build
else
    builddir	    ?= build
    builddir	    := $(builddir)/$(notdir $(CURDIR))
endif
export builddir

# Find names of all directories containing Makefile-s in $(srcdir) and take
# them as project names for generic build. This projects does not have
# installed files (simply because i don't know them here; this is why i don't
# define project_x variables here), so i rely on sub-make calls made by
# generic build for all phony build_x/clean_x and install_x/remove_x targets.
data	:= $(notdir $(patsubst %/Makefile,%,$(wildcard $(srcdir)/*/Makefile)))

include src/Makefile.common

