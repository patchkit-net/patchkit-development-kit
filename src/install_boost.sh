#!/bin/bash
# install_boost <platform>
SRC_INSTALL_BOOST_SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $SRC_INSTALL_BOOST_SCRIPT_DIR/install_base.sh $1

function error()
{
  echo Error: $?
  exit $?
}

echo Installing Boost...

# Select address model basing on current platform
if [ "$1" == "osx64" ]; then
  _PDK_BOOST_ADDRESS_MODEL=64
fi
if [ "$1" == "linux32" ]; then
  _PDK_BOOST_ADDRESS_MODEL=32
fi
if [ "$1" == "linux64" ]; then
  _PDK_BOOST_ADDRESS_MODEL=64
fi

pushd $SRC_INSTALL_BOOST_SCRIPT_DIR/boost/tools/build/

# Install Boost.Build
./bootstrap.sh
./b2 install --prefix=$PDK_INSTALL_PLATFORM_DIR/boost/build || error

popd

pushd $SRC_INSTALL_BOOST_SCRIPT_DIR/boost/

# Prepare headers
$PDK_INSTALL_PLATFORM_DIR/boost/build/bin/b2 headers

# Install Release
$PDK_INSTALL_PLATFORM_DIR/boost/build/bin/b2 \
  --build-dir=$PDK_INSTALL_TEMP_DIR/boost_release \
  --libdir=$PDK_INSTALL_PLATFORM_DIR/boost/lib \
  --includedir=$PDK_INSTALL_PLATFORM_DIR/boost/include \
  --layout=tagged \
  address-model=$_PDK_BOOST_ADDRESS_MODEL \
  link=static \
  threading=multi \
  runtime-link=static \
  variant=release \
  install

# Install Debug
$PDK_INSTALL_PLATFORM_DIR/boost/build/bin/b2 \
  --build-dir=$PDK_INSTALL_TEMP_DIR/boost_debug \
  --libdir=$PDK_INSTALL_PLATFORM_DIR/boost/libd \
  --includedir=$PDK_INSTALL_PLATFORM_DIR/boost/include \
  --layout=tagged \
  address-model=$_PDK_BOOST_ADDRESS_MODEL \
  link=static \
  threading=multi \
  runtime-link=static \
  variant=debug \
  install

popd

# Save configure script
_PDK_BOOST_CONFIGURE_SCRIPT=$PDK_INSTALL_PLATFORM_DIR/configure_boost.sh
echo export PDK_BOOST_INCLUDEDIR=$PDK_INSTALL_PLATFORM_DIR/boost/include>$_PDK_BOOST_CONFIGURE_SCRIPT||error
echo export PDK_BOOST_LIBRARYDIR_RELEASE=$PDK_INSTALL_PLATFORM_DIR/boost/lib>>$_PDK_BOOST_CONFIGURE_SCRIPT||error
echo export PDK_BOOST_LIBRARYDIR_DEBUG=$PDK_INSTALL_PLATFORM_DIR/boost/libd>>$_PDK_BOOST_CONFIGURE_SCRIPT||error

echo Done!