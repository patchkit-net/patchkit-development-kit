#!/bin/bash
# install_cmake <platform> <path-to-cmake>
SRC_INSTALL_CMAKE_SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $SRC_INSTALL_CMAKE_SCRIPT_DIR/install_base.sh $1

function error()
{
  echo Error: $?
  error $?
}

echo Installing CMake...

# Save configure script
_PDK_CMAKE_CONFIGURE_SCRIPT=$PDK_INSTALL_PLATFORM_DIR/configure_cmake.sh

echo export PATH=\$PATH:$2 > $_PDK_CMAKE_CONFIGURE_SCRIPT || error
echo export PDK_CMAKE_GENERATOR=\"Unix Makefiles\" >> $_PDK_CMAKE_CONFIGURE_SCRIPT || error

echo Done!
