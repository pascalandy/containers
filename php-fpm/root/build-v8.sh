#!/bin/bash

set -x

# Install build deps
apt-get update
apt-get install -y git python build-essential chrpath

# Install google build tools
cd /tmp
git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git
export PATH=/tmp/depot_tools:"$PATH"
fetch v8

# Get libv8
cd v8
git checkout 5.4.99
gclient sync

# Build v8
export GYPFLAGS="-Dv8_use_external_startup_data=0"
export GYPFLAGS="${GYPFLAGS} -Dlinux_use_bundled_gold=0"
make native library=shared snapshot=on -j8

# Install v8
mkdir -p /usr/lib /usr/include
cp out/native/lib.target/lib*.so /usr/lib/
cp -R include/* /usr/include
chrpath -r '$ORIGIN' /usr/lib/libv8.so
echo -e "create /usr/lib/libv8_libplatform.a\naddlib out/native/obj.target/src/libv8_libplatform.a\nsave\nend" | ar -M

# Get v8js
cd /tmp
git clone https://github.com/phpv8/v8js.git

# Build v8js
cd v8js
phpize
./configure
make

# Install v8js
make install

# Clean up
cd
rm -rf /tmp/*
rm -rf /tmp/.*
apt-get remove -y git python chrpath
apt-get clean
rm -rf /var/lib/apt/lists/*
