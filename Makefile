.PHONY: all build run clean headers iso bye

.SILENT:

all: clean headers build iso run bye

headers:
	scripts/headers.sh

build:
	scripts/build.sh

run:
	scripts/qemu.sh

iso:
	scripts/iso.sh

bye:
	@echo "=> Successfully Completed Compilation."

clean:
	scripts/clean.sh
