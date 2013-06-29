# Makefile
# version = 20130629_135739




CC = i686-w64-mingw32-gcc
IDIR = include
ODIR = obj
LDIR = lib
BDIR = bin
INSTALL_DESTINATION_DIR = /x/t/share/swpkg

CFLAGS = -I. -I$(IDIR)
LIBS =
BUILDINFO = wintrace_buildinfo
BUILDTIME = $(shell ..ts)

_DEPS = wintrace_lib.h
DEPS = $(patsubst %,$(IDIR)/%,$(_DEPS))




OBJS = $(OBJS_COMMON) $(OBJS_010) $(OBJS_020) $(OBJS_030)

_OBJS_COMMON = wintrace_lib.o $(BUILDINFO).o
OBJS_COMMON = $(patsubst %,$(ODIR)/%,$(_OBJS_COMMON))

_OBJS_010 = wintrace_010_install_sdk_wpt.o
OBJS_010 = $(patsubst %,$(ODIR)/%,$(_OBJS_010))

_OBJS_020 = wintrace_020_start.o
OBJS_020 = $(patsubst %,$(ODIR)/%,$(_OBJS_020))

_OBJS_030 = wintrace_030_stop.o
OBJS_030 = $(patsubst %,$(ODIR)/%,$(_OBJS_030))

_OBJS_MISC = misc.o
OBJS_MISC = $(patsubst %,$(ODIR)/%,$(_OBJS_MISC))




$(ODIR)/%.o: %.c $(DEPS)
	$(CC) -c -o $@ $< $(CFLAGS)

all: target_bin

target_bin: preproc wintrace_010_install_sdk_wpt.exe wintrace_020_start.exe wintrace_030_stop.exe
	
preproc: $(BUILDINFO) build_objs

build_objs: $(OBJS_COMMON) $(OBJS_010) $(OBJS_020) $(OBJS_030)

$(BUILDINFO):
	rm -f $@.c
	echo "char * wintrace_buildinfo_$(BUILDTIME) = \"WinTrace (c) 2013 // Author: Brian M. JUNG // Build#: $(BUILDTIME)\";" > $@.c;

wintrace_010_install_sdk_wpt.exe: $(OBJS_010) $(OBJS_COMMON)
	$(CC) -o $@ $^ $(CFLAGS) $(LIBS)
	mv $@ $(BDIR)

wintrace_020_start.exe: $(OBJS_020) $(OBJS_COMMON)
	$(CC) -o $@ $^ $(CFLAGS) $(LIBS)
	mv $@ $(BDIR)

wintrace_030_stop.exe: $(OBJS_030) $(OBJS_COMMON)
	$(CC) -o $@ $^ $(CFLAGS) $(LIBS)
	mv $@ $(BDIR)

misc.exe: $(OBJS_MISC) $(OBJS_COMMON)
	$(CC) -o $@ $^ $(CFLAGS) $(LIBS)
	mv $@ $(BDIR)

install:
	cp -pr bin $(INSTALL_DESTINATION_DIR)/wintrace-$(BUILDTIME)
	(cd tools/; ./afterproc.sh;)

clean:
	rm -f $(ODIR)/*
	rm -f $(BDIR)/*

showdir:
	ls -alF $(ODIR) $(BDIR) $(LDIR) $(IDIR) $(INSTALL_DESTINATION_DIR)/




