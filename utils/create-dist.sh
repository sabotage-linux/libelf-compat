#!/bin/sh
if [ -z "$VER" ] ; then
	echo set VER!
	exit
fi
me=`pwd`

proj=libelf-compat
projver=${proj}-${VER}
url=https://github.com/rofl0r/libelf-compat
url=~/cdev/cdev/libelf

tempdir=/tmp/${proj}-0000
rm -rf "$tempdir"
mkdir -p "$tempdir"

cd $tempdir
git clone "$url" "$projver"
rm -rf "$projver"/.git

tar cJf "$proj".tar.xz "$projver"/
mv "$proj".tar.xz "$me"/"$projver".tar.xz
