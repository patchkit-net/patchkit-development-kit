# PatchKit Development Kit

## Description

**PatchKit Development Kit (PDK)** installs all of the dependency modules required by PatchKit desktop software. **PDK** is split into different *platforms*. Each *platform* has it's own dedicated directory which contains all of the installed modules and configuration scripts.

## Requirements

* **C++ compiler**
  * Windows (*32/64 bits*) - [MSVC](https://www.visualstudio.com/downloads/) - recommended **VS 2015 / MSVC 14.0**
  * Mac OSX (*64 bits*)- [Command Line Tools](http://osxdaily.com/2014/02/12/install-command-line-tools-mac-os-x/)
* [**CMake**](https://cmake.org/download/)

## Scripts Variables

Every variable begins with prefix **PDK_**.

* CMake (prefix **PDK_CMAKE_**)
  * **PDK_CMAKE_GENERATOR** - name of CMake generator
* Boost (prefix **PDK_BOOST_**)
  * **PDK_BOOST_INCLUDEDIR** - directory with Boost headers
  * **PDK_BOOST_LIBRARYDIR_RELEASE** - directory with Boost release libraries
  * **PDK_BOOST_LIBRARYDIR_DEBUG** - directory with Boost debug libraries
* Platform (prefix **PDK_PLATFORM_**)
  * **PDK_PLATFORM_NAME** - name of current platform
* Variables used during installation (prefix **PDK_INSTALL_**)
  * **PDK_INSTALL_TEMP_DIR** - path to current installation temporary directory
  * **PDK_INSTALL_PLATFORM_DIR** - path to current installation platform directory