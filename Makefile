ifeq ($(OS), Windows_NT)
PRG_SUFFIX_FLAG := 1
else
PRG_SUFFIX_FLAG := 0
endif

LDFLAGS :=
CFLAGS_INC := -I. -Itests
CFLAGS := -g -Wall $(CFLAGS_INC)

SRCS := $(wildcard tests/*.c)
PRGS := $(patsubst %.c,%,$(SRCS))
PRG_SUFFIX=.exe
BINS := $(patsubst %,%$(PRG_SUFFIX),$(PRGS))
OBJS := $(patsubst %,%.o,$(PRGS))
ifeq ($(PRG_SUFFIX_FLAG),0)
	OUTS = $(PRGS)
else
	OUTS = $(BINS)
endif

default: all

.SECONDEXPANSION:
OBJ = $(patsubst %$(PRG_SUFFIX),%.o,$@)
ifeq ($(PRG_SUFFIX_FLAG),0)
	BIN = $(patsubst %$(PRG_SUFFIX),%,$@)
else
	BIN = $@
endif
%$(PRG_SUFFIX): $(OBJS)
	$(CC) $(OBJ) $(LDFLAGS) -o $(BIN)

clean:
	rm $(OUTS)

run: $(BINS)
	sh test.sh $(OUTS)

all: run clean

.PHONY: default clean run all
