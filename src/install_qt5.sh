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

mkdir $PDK_INSTALL_TEMP_DIR/qt5

pushd $PDK_INSTALL_TEMP_DIR/qt5

# Configure Qt
if [ "$1" == "osx64" ]; then
  $SRC_INSTALL_QT5_SCRIPT_DIR/qt5/configure \
    -prefix $PDK_INSTALL_PLATFORM_DIR/qt5 \
    -release \
    -no-optimized-tools \
    -opensource \
    -confirm-license \
    -c++std c++11 \
    -static \
    -largefile \
    -accessibility \
    -no-qml-debug \
    -pkg-config \
    -qt-zlib \
    -qt-libpng \
    -qt-libjpeg \
    -qt-xcb \
    -qt-xkbcommon \
    -qt-pcre \
    -qt-doubleconversion \
    -qt-freetype \
    -qt-harfbuzz \
    -nomake examples \
    -nomake tests \
    -gui \
    -widgets \
    -silent \
    -fontconfig \
    -strip
fi
if [ "$1" == "linux32" ]; then
  $SRC_INSTALL_QT5_SCRIPT_DIR/qt5/configure \
    -prefix $PDK_INSTALL_PLATFORM_DIR/qt5 \
    -release \
    -no-optimized-tools \
    -opensource \
    -confirm-license \
    -c++std c++11 \
    -static \
    -largefile \
    -accessibility \
    -no-qml-debug \
    -pkg-config \
    -qt-zlib \
    -qt-libpng \
    -qt-libjpeg \
    -qt-xcb \
    -qt-xkbcommon \
    -qt-pcre \
    -qt-doubleconversion \
    -qt-freetype \
    -qt-harfbuzz \
    -nomake examples \
    -nomake tests \
    -gui \
    -widgets \
    -silent \
    -fontconfig \
    -strip
fi
if [ "$1" == "linux64" ]; then
  $SRC_INSTALL_QT5_SCRIPT_DIR/qt5/configure \
    -prefix $PDK_INSTALL_PLATFORM_DIR/qt5 \
    -release \
    -no-optimized-tools \
    -opensource \
    -confirm-license \
    -c++std c++11 \
    -static \
    -largefile \
    -accessibility \
    -no-qml-debug \
    -pkg-config \
    -qt-zlib \
    -qt-libpng \
    -qt-libjpeg \
    -qt-xcb \
    -qt-xkbcommon \
    -qt-pcre \
    -qt-doubleconversion \
    -qt-freetype \
    -qt-harfbuzz \
    -nomake examples \
    -nomake tests \
    -gui \
    -widgets \
    -silent \
    -fontconfig \
    -strip
fi

# Build Qt5
make

# Install Qt5
make install

popd

# Save configure script
_PDK_QT5_CONFIGURE_SCRIPT=$PDK_INSTALL_PLATFORM_DIR/configure_qt5.sh
echo export PDK_QT5_ROOT=$PDK_INSTALL_PLATFORM_DIR/qt\5>$_PDK_QT5_CONFIGURE_SCRIPT||error

echo Done!
