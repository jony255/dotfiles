#!/usr/bin/env sh

pkgname=fish
version=3.0.2
distfiles="https://github.com/fish-shell/fish-shell/releases/download/${version}/${pkgname}-${version}.tar.gz"
PREFIX=$HOME/.local

# fetch
# -L allows us to be redirected to the aws instance the link points to
# -o makes the downloaded file's name = ${pkgname}-${version}
curl -L ${distfiles} -o ${pkgname}-${version}.tar.gz

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
