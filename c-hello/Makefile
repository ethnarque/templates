.PHONY: all install uninstall build check
BUILD_DIR ?= build

all: build

build:
	meson setup $(BUILD_DIR)
	meson compile -C $(BUILD_DIR)

install:
	meson install -C $(BUILD_DIR)

uninstall:
	sudo ninja uninstall -C $(BUILD_DIR)

check:
	ninja test -C $(BUILD_DIR)
