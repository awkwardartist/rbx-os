#!/bin/bash

BITS=64
FORMAT=elf64

KERNEL=sources/kernel
KERNEL_OUT=$KERNEL/out/kernel.elf

# object file flags 
KERNEL_FLAG_GCC="
    -ffreestanding -mcmodel=large -mno-red-zone -mno-mmx
    -mno-sse -mno-sse2 
"

# final linker flags 
KERNEL_FLAG_GCC_FINAL="
    -ffreestanding -fno-stack-protector 
    -m$BITS -nostdlib
"

com_nasm_obj() {
    local obj="$1.o"
    local src="$1"

    nasm -f$FORMAT -o$obj $src 
    if [ -f "$obj" ]
        then echo "$obj"; fi 
}

com_nasm_dir() {
    local dir="$1"
    local srcs=
    local objs= o=

    srcs="$(find "$dir" -name '*.s')"
    for src in $srcs; do 
        o="$(com_nasm_obj "$src")"
        if [ -z "$o" ] || [ ! -f "$o" ]
            then echo "compilation error."
            return 
        fi
    done 
}     
com_gcc_obj() {
    local obj="$1.o"
    local src="$1"

    gcc -m$BITS -I$KERNEL/src \
        -c -w $src -o$obj $KERNEL_FLAG_GCC

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
            then echo "compilation error."
            return
        fi 

        objs="$o $objs"
    done 

    echo $objs
}

build_kernel() {
    local src="$KERNEL/src"
    local objs="$(com_gcc_dir "$src")"

    gcc $KERNEL_FLAG_GCC_FINAL -T $KERNEL/link.ld -o $KERNEL_OUT $objs
    rm $objs
}

build_kernel