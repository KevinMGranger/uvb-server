PREFIX := /usr/local
CPPFLAGS := -I./include -I/usr/include
CFLAGS := -Wall -Wextra -fPIC -pedantic -pthread -lhttp_parser -llmdb

DEBUGFLAGS := -ggdb3
ifeq ($(CC),clang)
    DEBUGFLAGS := -ggdb
endif

ifeq ($(CC),gcc)
	CFLAGS += -std=c11
endif
ifeq ($(CC),clang)
	CFLAGS += -Weverything
endif

SOURCE := $(wildcard src/*.c)

EXECUTABLE := uvb-server

DB_PREFIX := /var/db
CFLAGS += -D DB_PREFIX=$(DB_PREFIX)

all:
	$(CC) $(CPPFLAGS) $(CFLAGS) -o $(EXECUTABLE) $(SOURCE)

debug:
	$(CC) $(CPPFLAGS) $(CFLAGS) $(DEBUGFLAGS) -o $(EXECUTABLE) $(SOURCE)

profile:
	$(CC) $(CPPFLAGS) $(CFLAGS) -DGPROF $(DEBUGFLAGS) -pg -o $(EXECUTABLE) $(SOURCE)

release:
	$(CC) $(CPPFLAGS) $(CFLAGS) $(DEBUGFLAGS) -O2 -o $(EXECUTABLE) $(SOURCE)


install:
	install -D $(EXECUTABLE) $(PREFIX)/bin/$(EXECUTABLE)

clean:
	$(RM) $(EXECUTABLE) counters.db names.db

uninstall:
	$(RM) $(PREFIX)/bin/$(EXECUTABLE)

