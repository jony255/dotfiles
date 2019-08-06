#!/usr/bin/env sh

pkgname=stow
version=2.3.1
distfiles="http://ftp.gnu.org/gnu"
PREFIX=$HOME/.local

# fetch
# -L follow the redirection if it exists
# -o makes the downloaded file's name = ${pkgname}-${version}
curl -L ${distfiles}/${pkgname}/${pkgname}-${version}.tar.gz -o ${pkgname}-${Version}.tar.gz

# extract
tar -xzf ${pkgname}-${version}.tar.gz

# configure
cd ${pkgname}-${version}
./configure --prefix=$PREFIX

# build
make -j8

# install
make install

echo "Make sure ${PREFIX}/bin is in your path!"
echo 'If it isn't, append it to your path'