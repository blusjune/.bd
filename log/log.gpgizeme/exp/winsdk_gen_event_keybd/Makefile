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
BUILDINFO = blusjune_buildinfo
BUILDTIME = $(shell ..ts)

_DEPS = config.h
DEPS = $(patsubst %,$(IDIR)/%,$(_DEPS))




OBJS = $(OBJS_COMMON) $(OBJS_010)

_OBJS_COMMON = $(BUILDINFO).o
OBJS_COMMON = $(patsubst %,$(ODIR)/%,$(_OBJS_COMMON))

_OBJS_010 = gen_km_event.o
OBJS_010 = $(patsubst %,$(ODIR)/%,$(_OBJS_010))




$(ODIR)/%.o: %.c $(DEPS)
	$(CC) -c -o $@ $< $(CFLAGS)

all: target_bin

target_bin: preproc gen_km_event.exe
	
preproc: $(BUILDINFO) build_objs

build_objs: $(OBJS_COMMON) $(OBJS_010)

$(BUILDINFO):
	rm -f $@.c
	echo "char * blusjune_buildinfo_$(BUILDTIME) = \"gen_km_event (c) 2014 // Author: Brian M. JUNG // Build#: $(BUILDTIME)\";" > $@.c;

gen_km_event.exe: $(OBJS_010) $(OBJS_COMMON)
	$(CC) -o $@ $^ $(CFLAGS) $(LIBS)
	mv $@ $(BDIR)

install:
	cp -pr bin $(INSTALL_DESTINATION_DIR)

clean:
	rm -f $(ODIR)/*.o
	rm -f $(BDIR)/*.exe

showdir:
	ls -alF $(ODIR) $(BDIR) $(LDIR) $(IDIR) $(INSTALL_DESTINATION_DIR)/




