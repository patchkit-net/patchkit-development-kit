#!/bin/bash
# configure <platform>
CONFIGURE_SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $CONFIGURE_SCRIPTDIR/config/config.sh

function usage()
{
  echo
  echo Usage:
  echo \ \ \ \ source configure \<platform\>
  echo
  echo Example:
  echo \ \ \ \ source configure osx64
  echo
  echo Available platforms:
  if [[ "$OSTYPE" == "darwin"* && "$(uname -m)" == "x86_64" ]]; then
    echo \ \ \ \ \* osx64
  fi
  if [[ "$OSTYPE" == "linux"* ]]; then
    if [[ "$(uname -m)" == "x86_64" ]]; then
      echo \ \ \ \ \* linux64
    else
      echo \ \ \ \ \* linux32
    fi
  fi
}

function configure_error()
{
  unset PDK_PLATFORM_NAME
  unset PDK_PLATFORM_NAME
  echo Error: cannot configure the platform.
  echo Make sure that installation has been done correctly.
}

function no_installation()
{
  unset PDK_PLATFORM_NAME
  unset PDK_PLATFORM_NAME
  echo Please install platform with ./install
}

# Validate arguments
if [ -z "$1" ]
  then
    usage
    return 1
fi

# Display usage on -h or --help
if [[ "$1" == "-h" || "$1" == "--help" ]]; then
  usage
  return 0
fi

# Check <platform>
if [[ ( "$1" != "osx64" || "$OSTYPE" != "darwin"* ) \
 && ( "$1" != "linux32" || "$OSTYPE" != "linux"* || "$(uname -m)" == "x86_64" ) \
 && ( "$1" != "linux64" || "$OSTYPE" != "linux"* || "$(uname -m)" != "x86_64" ) ]]; then
  echo Error: unavailable \<platform\> $1
  usage
  return 1
fi

# Set platform name
export PDK_PLATFORM_NAME=$1

# Set platform directory
export PDK_PLATFORM_DIR=$CONFIGURE_SCRIPTDIR/$1

# Check platform directory
if [ ! -d $PDK_PLATFORM_DIR ]; then
  echo Error: couldn\'t find platform directory in $PDK_PLATFORM_DIR
  no_installation
  return 1
fi

# Call configure scripts
source $PDK_PLATFORM_DIR/configure_cmake.sh || ( configure_error && return 1 )
source $PDK_PLATFORM_DIR/configure_boost.sh || ( configure_error && return 1 )
source $PDK_PLATFORM_DIR/configure_json.sh || ( configure_error && return 1 )
source $PDK_PLATFORM_DIR/configure_libtorrent.sh || ( configure_error && return 1 )
source $PDK_PLATFORM_DIR/configure_qt5.sh || ( configure_error && return 1 )

echo
echo Platform $1 configuration done!


