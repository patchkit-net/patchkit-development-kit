#!/bin/bash
# install <platform> <path-to-cmake>
INSTALL_SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $INSTALL_SCRIPTDIR/config/config.sh

function usage()
{
	echo
	echo Usage:
	echo  \ \ \ \ $0 \<platform\> \<path-to-cmake\> \<cmake-generator\>
	echo
	echo Examples:
	echo  \ \ \ \ $0 osx64 /Applications/CMake.app/Contents/bin
	echo  \ \ \ \ $0 -h
	echo  \ \ \ \ $0 -help
	echo
	echo Available platforms:
	if [[ "$OSTYPE" == "darwin"* ]]; then
    echo \ \ \ \ \* osx64
  fi
}

function error()
{
	echo Error: $?
	exit $?
}

# Validate arguments
if [ -z "$1" ] || [ -z "$2" ]; then
 	usage
  exit 1
fi

# Display usage on -h or --help
if [[ "$1" == "-h" || "$1" == "--help" ]]; then
	usage
	exit 0
fi

# Check <platform>
if [[ "$1" != "osx64" || "$OSTYPE" != "darwin"* ]]; then
	echo Error: unavailable \<platform\> $1
	usage
	exit 1
fi

# Check <path-to-cmake>
if [ ! -d "$2" ]; then
	echo Error: couldn\'t find \<path-to-cmake\> in $2
	usage
	exit 1
fi

# Set install variables
source $INSTALL_SCRIPTDIR/src/install_vars.sh $1 || error

# Delete previous temp dir
if [ -d "$PDK_INSTALL_TEMP_DIR" ]; then
	rm -rf $PDK_INSTALL_TEMP_DIR || error
fi

# Create temp dir
mkdir -p $PDK_INSTALL_TEMP_DIR

# Create platform dir if not exist
if [ ! -d "$PDK_INSTALL_PLATFORM_DIR" ]; then
	mkdir -p $PDK_INSTALL_PLATFORM_DIR || error
fi

# Install CMake
sh $INSTALL_SCRIPTDIR/src/install_cmake.sh $1 $2 || error

# Install C++ compiler
# Nothing to do

# Install Boost
if [ ! -f $PDK_INSTALL_PLATFORM_DIR/configure_boost.sh ]; then
	sh $INSTALL_SCRIPTDIR/src/install_boost.sh $1 || error
fi

# Install JSON
sh $INSTALL_SCRIPTDIR/src/install_json.sh $1 || error

# Install libtorrent
if [ ! -f $PDK_INSTALL_PLATFORM_DIR/configure_libtorrent.sh ]; then
	sh $INSTALL_SCRIPTDIR/src/install_libtorrent.sh $1 || error
fi

# Delete temp directory
rm -rf $PDK_INSTALL_TEMP_DIR || error
