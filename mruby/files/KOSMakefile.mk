# Windows specific
ifeq ($(OS),Windows_NT)
	EXECUTABLEEXTENSION = .exe
endif

TARGET = libmruby.a

MRUBY_COMPILER = mrbc$(EXECUTABLEEXTENSION)
MRUBY_INSTALL_DIR = $(KOS_CC_BASE)/../bin

defaultall: | generatemruby copylib installmrbc

# Generate mruby
#generatemp: export MICROPYTHON_TOP = $(CURDIR)
generatemruby:
#	$(MAKE) MRUBY_CONFIG=dreamcast_shelf	
	@/C/Program\ Files/7-Zip/7z.exe x ../../build.7z -r -o.

copylib:
	@cp $(CURDIR)/build/$(KOS_ARCH)/lib/$(TARGET) $(CURDIR)

# Install mruby compiler executable (mrbc)
installmrbc:
	@cp $(CURDIR)/build/host/bin/$(MRUBY_COMPILER) $(MRUBY_INSTALL_DIR)
	@strip $(MRUBY_INSTALL_DIR)/$(MRUBY_COMPILER)

# Alter header files and replace #include "{variable}" with #include <micropython/{variable}>
# This will fixes some other headers as well.
fixincludes:
	@echo "Updating includes before installation..."
	@for _file in $(MP_PORT_DIR)/*.h $(MP_PY_DIR)/*.h $(MP_RT_DIR)/*.h; do \
		sed -ri -e 's/#include "([^[:space:]]+)"/#include <micropython\/\1>/g' $$_file $(SED_FLAGS); \
	done
	@sed -i -e 's/<port\/mpconfigport_common.h>/<micropython\/port\/mpconfigport_common.h>/' mpconfigport.h $(SED_FLAGS)
	@sed -i -e 's/<mpconfigport.h>/<micropython\/mpconfigport.h>/' $(MP_PY_DIR)/mpconfig.h $(SED_FLAGS)
