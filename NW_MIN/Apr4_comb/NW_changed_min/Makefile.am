SUBDIRS = src tests 
EXTRA_DIST = \
	BSD_license \
	tests/*_args \
	tests/*.exp \
	tests/*.nw \
	tests/*.sh \
	tests/*.map \
	tests/*.cmap \
	src/*.sh \
	src/newick_utils.py \
	src/nw_info.py \
	doc/nwutils_tutorial.pdf \
	data/*

doc/nwutils_tutorial.pdf:
	$(MAKE) -C doc

# Make a binary distribution
# set PLATFORM=<your current platform>. Also, this should be done with
# static libraries - pass option '--disable-shared' to ./configure.

PLATFORM = $(shell uname -s)-$(shell uname -m)

show:
	echo $(PLATFORM)

bin-dist: distdir
	cp src/nw_* $(distdir)/src
	tardir=$(distdir) && $(am__tar) | GZIP=$(GZIP_ENV) gzip -c >$(distdir)-$(PLATFORM).tar.gz
	$(am__remove_distdir)

#ACLOCAL_AMFLAGS = -I m4
