TARGET = libAL.a
OBJS =  src/alut.o src/buffer.o src/context.o src/core.o src/listener.o
OBJS += src/math.o src/platform.o src/source.o

KOS_CFLAGS += -Iinclude -ffast-math -O3

include ${KOS_PORTS}/scripts/lib.mk
