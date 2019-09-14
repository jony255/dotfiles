#!/usr/bin/env sh

pkgname=stow
version=2.3.1
distfiles="http://ftp.gnu.org/gnu/${pkgname}/${pkgname}-${version}.tar.gz"
PREFIX="$HOME/.local"

# fetch
# -L follow the redirection if it exists
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
mkdir -p $PREFIX
make install

echo "Make sure ${PREFIX}/bin is in your path!"
echo 'If it isn't, append it to your path'
