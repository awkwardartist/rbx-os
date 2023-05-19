#!/bin/bash

KERNEL=sources/kernel
KERNEL_OUT=$KERNEL/out/kernel.elf

BITS=64
FORMAT=elf64

# compilation flags 
OBJFLAG=
KERNEL_FLAG_GCC="
    -ffreestanding -fno-stack-protector 
    -m$BITS -T $KERNEL/link.ld
"

com_gcc_obj() {
    local obj="$1.o"
    local src="$1"

    gcc -m$BITS -I$INCLUDE \
        -c -w $src -o$obj

    if [ -f "$obj" ]
        then echo "$obj"; fi
}

com_gcc_dir() {
    local dir="$1"
    local srcs=""
    local objs="" o=

    if [ ! -d "$dir" ]
        then return
    fi

    srcs="$(find "$dir" -name '*.c')"
    for src in $srcs; do 
        o="$(com_gcc_obj "$src")"
        if [ -z "$o" ] || [ ! -f "$o" ]
            echo "compilation error."
            return
        fi 

        objs="$o $objs"
    done 

    echo $objs
}

build_kernel() {
    local src="$KERNEL/src"
    local objs="$(com_gcc_dir "$src")"

    gcc $KERNEL_FLAG_GCC -o $KERNEL_OUT $objs
}