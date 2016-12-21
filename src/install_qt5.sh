#!/bin/bash
# install_qt <platform>
SRC_INSTALL_QT5_SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $SRC_INSTALL_QT5_SCRIPT_DIR/install_base.sh

function error()
{
  echo Error: $?
  exit $?
}

echo Installing Qt5...

pushd $SRC_INSTALL_QT5_SCRIPT_DIR/qt5

# Configure Qt
./configure \
  -prefix $PDK_INSTALL_PLATFORM_DIR/qt5 \
  -debug-and-release \
  -opensource \
  -confirm-license \
  -static \
  -largefile \
  -qt-zlib \
  -no-mtdev \
  -qt-libpng \
  -qt-libjpeg \
  -qt-freetype \
  -qt-harfbuzz \
  -qt-pcre \
  -qt-xcb \
  -qt-xkbcommon-x11 \
  -qpa xcb \
  -nomake examples \
  -nomake tests \
  -silent \
  -fontconfig \
  -opengl \

# Build Qt5
make

# Install Qt5
make install

popd

# Save configure script
_PDK_QT5_CONFIGURE_SCRIPT=$PDK_INSTALL_PLATFORM_DIR/configure_qt5.sh
echo export PDK_QT5_ROOT=$PDK_INSTALL_PLATFORM_DIR/qt\5>$_PDK_QT5_CONFIGURE_SCRIPT||error

echo Done!
