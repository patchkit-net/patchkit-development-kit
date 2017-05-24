# PatchKit Development Kit

## Description

**PatchKit Development Kit (PDK)** installs all of the dependency modules required by PatchKit desktop software. **PDK** is split into different *platforms*. Each *platform* has it's own dedicated directory which contains all of the installed modules and configuration scripts.

## Requirements

* **C++ compiler**
  * Windows (*32/64 bits*) - [MSVC](https://www.visualstudio.com/downloads/) - required **VS 2015 / MSVC 14.0**
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

### Unix/Linux
1. Run `./install.sh <platform> <path-to-cmake-directory>`

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
