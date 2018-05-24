# PatchKit Development Kit

## Description

**PatchKit Development Kit (PDK)** installs all of the dependency modules required by PatchKit desktop software. **PDK** is split into different *platforms*. Each *platform* has it's own dedicated directory which contains all of the installed modules and configuration scripts.

## Requirements

* **C++ compiler**
  * Windows (*32/64 bits*) - [MSVC 2015](https://www.visualstudio.com/vs/older-downloads/) - required **VS 2015 / MSVC 14.0** with **Windows SDK** (available during **Visual Studio** installation)
  * Mac OSX (*64 bits*)- XCode (you can download it with App Store)
* [**CMake**](https://cmake.org/download/)

## Downloading the repository

Execute in terminal:
``` bash
git clone https://github.com/patchkit-net/patchkit-development-kit.git && cd patchkit-development-kit/ && git submodule update --init --recursive
```
... and go make yourself a tea :-)

## Installation platform

### Windows
1. Run `install <platform> <path-to-msvc> <path-to-cmake-directory>`

**\<platform\>** could be either *win32* or *win64*.

**Note that you cannot use win64 on 32-bit system.**

### Linux
1. Install Packages `sudo apt-get install build-essential perl python libxi-dev libxfixes-dev libxext-dev libx11-dev "^libxcb.*" libxcb1-dev libx11-xcb-dev libxcb-keysyms1-dev libxcb-image0-dev libxcb-shm0-dev libxcb-icccm4-dev libxcb-sync0-dev libxcb-xfixes0-dev libxcb-shape0-dev libxcb-randr0-dev libxcb-render-util0-dev libglu1-mesa-dev libxrender-dev  libasound2-dev libgstreamer0.10-dev libgstreamer-plugins-base0.10-dev libfontconfig1-dev libfreetype6-dev libssl-dev openssl`
  1. For fedora `@development-tools perl python libXi-devel libXfixes-devel libXext-devel libX11-devel libX11-xcb libxcb-devel mesa-libGL-devel libXrender-devel alsa-lib-devel gstreamer gstreamer-plugins-base-devel fontconfig-devel freetype-devel openssl-devel openssl openssl-lib-compat gcc-c++`
2. Make sure that CMake is installed. If not, install it by `sudo apt-get install cmake`.
3. Search for CMake installation path. `which cmake` will show you the directory that needs to be used in next step. For example in my case it returned `/usr/bin/cmake` so I will use `/usr/bin/`.
4. Run `./install.sh <platform> <path-to-cmake-directory>`

**\<platform\>** could be *linux32*, *linux64* or *osx64* depending on current platform.

### Mac OSX
1. Install [Homebrew](https://brew.sh/).
2. Install Packages `brew install pkg-config`.
3. Make sure that CMake is installed.
4. Run `./install.sh osx64 <path-to-cmake-directory>`

## Configuration for software compilation

### Windows
Run `configure <platform>`

### Unix
Run `source configure.sh <platform>`

## Scripts Variables

Every variable begins with prefix **PDK_**.

* Boost (prefix **PDK_BOOST_**)
  * **PDK_BOOST_INCLUDEDIR** - directory with Boost headers
  * **PDK_BOOST_LIBRARYDIR_RELEASE** - directory with Boost release libraries
  * **PDK_BOOST_LIBRARYDIR_DEBUG** - directory with Boost debug libraries
* libtorrent (prefix **PDK_LIBTORRENT_**)
  * **PDK_LIBTORRENT_INCLUDEDIR_RELEASE** - directory with libtorrent release headers
  * **PDK_LIBTORRENT_LIBRARYDIR_RELEASE** - directory with libtorrent release libraries
  * **PDK_LIBTORRENT_INCLUDEDIR_DEBUG** - directory with libtorrent debug headers
  * **PDK_LIBTORRENT_LIBRARYDIR_DEBUG** - directory with libtorrent debug libraries
* Qt5 (prefix **PDK_QT5_**)
  * **PDK_QT5_ROOT** - root directory of Qt5 installation
* Platform (prefix **PDK_PLATFORM_**)
  * **PDK_PLATFORM_NAME** - name of current platform
  * **PDK_PLATFORM_DIR** - path to current platform directory
* Variables used during installation (prefix **PDK_INSTALL_**)
  * **PDK_INSTALL_TEMP_DIR** - path to current installation temporary directory
  * **PDK_INSTALL_PLATFORM_DIR** - path to current installation platform directory

## How to add new module

1. Add source as Git submodule repository.
2. Create **module install script** in `src` directory for both Windows and Unix shell. Name it `install_{module_name}`. It should build sources and create **module configure script** placed in install platform directory.
3. Add call to **module install script** in **main install script**.
4. Add call to **module configure script** in **main configure script**. 

**Warning** - all of modules added in this way will need to be converted to Ruby scripts after refactor that is scheduled for the future.
