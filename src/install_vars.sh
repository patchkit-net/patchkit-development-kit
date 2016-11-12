#!/bin/bash
# install_vars <platform>
SRC_INSTALL_VARS_SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

export PDK_INSTALL_TEMP_DIR=$SRC_INSTALL_VARS_SCRIPT_DIR/../temp$1
export PDK_INSTALL_PLATFORM_DIR=$SRC_INSTALL_VARS_SCRIPT_DIR/../$1
