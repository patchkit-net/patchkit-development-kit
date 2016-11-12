#!/bin/bash
# install_base <platform>
SRC_INSTALL_BASE_SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $SRC_INSTALL_BASE_SCRIPT_DIR/../config/config.sh
source $SRC_INSTALL_BASE_SCRIPT_DIR/install_vars.sh $1
