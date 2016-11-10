# PatchKit Development Kit

## Description

**PatchKit Development Kit (PDK)** downloads and compiles all of the dependency modules required by PatchKit desktop software. PDK is split into different platforms. Each platform has got it's own dedicated directory which contains all of the compiled **modules** and platform configuration scripts.

## Requirements

* **C++ compiler**
  * Windows - MSVC 14.0
* **CMake**

## Script Variables

Every variable begins with prefix **PDK_**.

* Config (prefix **PDK_CFG_**)
  * **PDK_CFG_CPP_COMPILER_CONFIGURE_SCRIPT_NAME** - name of the script which configures the C++ compiler
  * **PDK_CFG_CMAKE_CONFIGURE_SCRIPT_NAME** - name of the script which configures the CMake
* Platform specific (prefix **PDK_PLATFORM_**)
  * **PDK_PLATFORM_CMAKE_GENERATOR** - name of CMake generator