
REPO=../
BASE=$(REPO)/ribbix
DISK=output/fs/disk_usb_img.iso
USR_SH=$(shell echo $SHELL)

BUILD_BASE=$(BASE)/build
BUILD_SH=$(BUILD_BASE)/scripts

kernel:
    $(USR_SH) build/scripts/kernel.sh

disk:
    $(USR_SH) build/scripts/disk.sh $(DISK)

all:
    make kernel 
    make disk
