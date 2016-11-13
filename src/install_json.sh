#!/bin/bash
# install_json <platform>
SRC_INSTALL_JSON_SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $SRC_INSTALL_JSON_SCRIPT_DIR/install_base.sh $1

function error()
{
  echo Error: $?
  error $?
}

echo Installing JSON...

# Create install dir
if [ ! -d $PDK_INSTALL_PLATFORM_DIR/json ]; then
  mkdir -p $PDK_INSTALL_PLATFORM_DIR/json
fi

# Copy header file
cp $SRC_INSTALL_JSON_SCRIPT_DIR/json/src/json.hpp $PDK_INSTALL_PLATFORM_DIR/json/json.hpp

# Save configure script
_PDK_JSON_CONFIGURE_SCRIPT=$PDK_INSTALL_PLATFORM_DIR/configure_json.sh

echo export PDK_JSON_INCLUDEDIR=$PDK_INSTALL_PLATFORM_DIR/json>$_PDK_JSON_CONFIGURE_SCRIPT||error

echo Done!
