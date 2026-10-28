#!/bin/bash

set -e

BUILDDIR="$(pwd)/build"
OUTDIR="$(pwd)/out"

NEWLIB="$(pwd)/newlib"

git submodule update --init --recursive

CC=$DEVKITPPC/bin/powerpc-eabi-gcc

rm -rf $BUILDDIR $OUTDIR
mkdir -p $BUILDDIR/newlib
cd $BUILDDIR/newlib

CFLAGS_FOR_TARGET="-O2 -ffunction-sections -fdata-sections -DMALLOC_PROVIDED" \
$NEWLIB/configure \
	--target=powerpc-eabi \
	--prefix=$OUTDIR \
	--enable-newlib-register-fini \
	--enable-newlib-mb \
	--enable-newlib-reent-binary-compat \
	--disable-newlib-wide-orient \
	--enable-target-optspace \
	--disable-newlib-supplied-syscalls
make
make install
