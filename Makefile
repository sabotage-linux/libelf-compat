prefix=/usr/local
bindir=$(prefix)/bin
includedir=$(prefix)/include
libdir=$(prefix)/lib
sysconfdir=$(prefix)/etc

LIBSRC = $(sort $(wildcard src/*.c))

SRCS = $(LIBSRC)
OBJS = $(SRCS:.c=.o)
LIBOBJS = $(LIBSRC:.c=.o)

HEADERS = src/libelf.h
ALL_INCLUDES = $(HEADERS)

ALL_LIBS=libelf.a

CFLAGS=-O3 -std=gnu99 -D_GNU_SOURCE

CC      = $(CROSS_COMPILE)gcc
AR      = $(CROSS_COMPILE)ar
RANLIB  = $(CROSS_COMPILE)ranlib


-include config.mak

BUILDCFLAGS=$(CFLAGS)

all: $(ALL_LIBS)

install: $(ALL_LIBS:lib/%=$(DESTDIR)$(libdir)/%) $(ALL_INCLUDES:include/%=$(DESTDIR)$(includedir)/%)

clean:
	rm -f $(ALL_LIBS)
	rm -f $(OBJS)

%.o: %.c
	$(CC) $(BUILDCFLAGS) -c -o $@ $<

libelf.a: $(LIBOBJS)
	rm -f $@
	$(AR) rc $@ $(LIBOBJS)
	$(RANLIB) $@

$(DESTDIR)$(libdir)/%.a: %.a
	install -D -m 755 $< $@

$(DESTDIR)$(includedir)/%: include/%
	install -D -m 644 $< $@

.PHONY: all clean install



