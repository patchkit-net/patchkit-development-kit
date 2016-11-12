#!/bin/bash
# install_libtorrent <platform>
SRC_INSTALL_LIBTORRENT_SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $SRC_INSTALL_LIBTORRENT_SCRIPT_DIR/install_base.sh $1

function error()
{
  echo Error: $?
  exit $?
}

echo Installing libtorrent...

# Configure necessary dependencies
source $PDK_INSTALL_PLATFORM_DIR/configure_cmake.sh
source $PDK_INSTALL_PLATFORM_DIR/configure_boost.sh

# Create directory for release CMake build

if [ ! -d $PDK_INSTALL_TEMP_DIR/libtorrent_release ]; then
  mkdir -p $PDK_INSTALL_TEMP_DIR/libtorrent_release
fi

pushd $PDK_INSTALL_TEMP_DIR/libtorrent_release

# Configure release
cmake \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_INSTALL_PREFIX=$PDK_INSTALL_PLATFORM_DIR/libtorrent/release \
  -Dencryption=off \
  -DBOOST_INCLUDEDIR=$PDK_BOOST_INCLUDEDIR \
  -DBOOST_LIBRARYDIR=$PDK_BOOST_LIBRARYDIR_RELEASE \
  -G "$PDK_CMAKE_GENERATOR" \
  $SRC_INSTALL_LIBTORRENT_SCRIPT_DIR/libtorrent

# Install release
make install

popd

# Create directory for debug CMake build

if [ ! -d $PDK_INSTALL_TEMP_DIR/libtorrent_debug ]; then
  mkdir -p $PDK_INSTALL_TEMP_DIR/libtorrent_debug
fi

pushd $PDK_INSTALL_TEMP_DIR/libtorrent_debug

# Configure debug
cmake \
  -DCMAKE_BUILD_TYPE=Debug \
  -DCMAKE_INSTALL_PREFIX=$PDK_INSTALL_PLATFORM_DIR/libtorrent/debug \
  -Dencryption=off \
  -DBOOST_INCLUDEDIR=$PDK_BOOST_INCLUDEDIR \
  -DBOOST_LIBRARYDIR=$PDK_BOOST_LIBRARYDIR_DEBUG \
  -G "$PDK_CMAKE_GENERATOR" \
  $SRC_INSTALL_LIBTORRENT_SCRIPT_DIR/libtorrent

# Install debug
make install

popd

# Save configure script
_PDK_LIBTORRENT_CONFIGURE_SCRIPT=$PDK_INSTALL_PLATFORM_DIR/configure_libtorrent.sh

echo export PDK_LIBTORRENT_INCLUDEDIR_RELEASE=$PDK_INSTALL_PLATFORM_DIR/libtorrent/release/include > $_PDK_LIBTORRENT_CONFIGURE_SCRIPT ||  error
echo export PDK_LIBTORRENT_LIBRARYDIR_RELEASE=$PDK_INSTALL_PLATFORM_DIR/libtorrent/release/lib >> $_PDK_LIBTORRENT_CONFIGURE_SCRIPT || error
echo export PDK_LIBTORRENT_INCLUDEDIR_DEBUG=$PDK_INSTALL_PLATFORM_DIR/libtorrent/debug/include >> $_PDK_LIBTORRENT_CONFIGURE_SCRIPT || error
echo export PDK_LIBTORRENT_LIBRARYDIR_DEBUG=$PDK_INSTALL_PLATFORM_DIR/libtorrent/debug/lib >> $_PDK_LIBTORRENT_CONFIGURE_SCRIPT || error

echo Done!

