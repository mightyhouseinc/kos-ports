TARGET = libGL.a
OBJS =  containers/aligned_vector.o containers/named_array.o containers/stack.o
OBJS += GL/draw.o GL/error.o GL/flush.o GL/fog.o GL/framebuffer.o GL/glu.o
OBJS += GL/immediate.o GL/lighting.o GL/matrix.o GL/state.o GL/texture.o GL/util.o
OBJS += GL/alloc/alloc.o version.o GL/platforms/sh4.o

KOS_CFLAGS += -DBACKEND_KOSPVR

GLDC_VERSION=$(shell git describe --abbrev=4 --dirty --always --tags)

defaultall: version.c $(OBJS)

# Generate version
version.c:
	@sed "s/@GLDC_VERSION@/${GLDC_VERSION}/g" GL/version.c.in > version.c

include ${KOS_PORTS}/scripts/lib.mk
