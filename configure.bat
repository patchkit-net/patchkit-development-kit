@echo off
call %~dp0config/config.bat

:: Validate arguments
if [%1]==[] goto usage

:: Check if help has been requested
if %1==--help (
  goto usage
)

if %1==-h (
  goto usage
)

:: Set argument variables
set _PDK_ARG_PLATFORM=%1

:: Check <platform>
if not %_PDK_ARG_PLATFORM%==win32 if not %_PDK_ARG_PLATFORM%==win64 (
  echo Error: unavailable ^<platform^> %_PDK_ARG_PLATFORM%
  echo.
  goto usage
)

:: Set platform directory path
set _PDK_PLATFORM_DIR_PATH=%~dp0%_PDK_ARG_PLATFORM%

:: Check platform directory
if not exist %_PDK_PLATFORM_DIR_PATH% (
  echo Error: couldn't find platform directory %_PDK_PLATFORM_DIR_PATH%
  goto :no_setup
)

:: Check configure scripts

if not exist %_PDK_PLATFORM_DIR_PATH%/%PDK_CFG_CPP_COMPILER_CONFIGURE_SCRIPT_NAME% (
  echo Error: couldn't find C++ compiler configure script %PDK_CFG_CPP_COMPILER_CONFIGURE_SCRIPT_NAME%
  goto :no_setup
)

if not exist %_PDK_PLATFORM_DIR_PATH%/%PDK_CFG_CMAKE_CONFIGURE_SCRIPT_NAME% (
  echo Error: couldn't find CMake configure script %PDK_CFG_CMAKE_CONFIGURE_SCRIPT_NAME%
  goto :no_setup
)

:: Call configure scripts
call %_PDK_PLATFORM_DIR_PATH%/configure_cpp_compiler.bat
call %_PDK_PLATFORM_DIR_PATH%/configure_cmake.bat
call %_PDK_PLATFORM_DIR_PATH%/configure_boost.bat

:: Set platform name
set PDK_PLATFORM_NAME=%_PDK_ARG_PLATFORM%

echo.
echo Platform %_PDK_ARG_PLATFORM% configuration done!

goto:eof

:usage
echo.
echo Usage:
echo     %0 ^<platform^>
echo.
echo Example:
echo     %0 win32
echo.
echo Available platforms:
echo     * win32
echo     * win64
goto:eof

:no_setup
echo Probably you haven't run setup_platform
goto :eof