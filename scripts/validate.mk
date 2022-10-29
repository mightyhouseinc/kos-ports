# kos-ports ##version##
#
# scripts/validate.mk
# Copyright (C) 2015 Lawrence Sebald
#

validate-dist:
ifeq (${VALIDATE_DISTFILES},true)
	@[ "${PYTHON_CMD}" ] || ( echo "PYTHON_CMD is not set in config.mk"; exit 1 )
	@if [ -f "distinfo" ] ; then \
		${PYTHON_CMD} ${KOS_PORTS}/scripts/validate_dist.py || exit 1 ; \
	fi
endif
