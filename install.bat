@echo off
call %~dp0config\config.bat

:: Validate arguments
if [%1]==[] goto usage
if [%2]==[] goto usage
if [%3]==[] goto usage
if [%4]==[] goto usage

:: Check if help has been requested
if %1==--help (
  goto usage
)

if %1==-h (
  goto usage
)

set _PDK_ARG_PLATFORM=%1
set _PDK_ARG_PATH_TO_MSVC=%2
set _PDK_ARG_PATH_TO_CMAKE=%3
set _PDK_ARG_CMAKE_GENERATOR=%4

:: Check <platform>
if not %_PDK_ARG_PLATFORM%==win32 if not %_PDK_ARG_PLATFORM%==win64 (
  echo Error: unavailable ^<platform^> %_PDK_ARG_PLATFORM%
  goto usage
)

:: Check <path-to-msvc>
if not exist %_PDK_ARG_PATH_TO_MSVC% (
  echo Error: couldn't find ^<path-to-msvc^> in %_PDK_ARG_PATH_TO_MSVC%
  goto usage
)

:: Check <path-to-cmake>
if not exist %_PDK_ARG_PATH_TO_CMAKE% (
  echo Error: couldn't find ^<path-to-cmake^>
  goto usage
)

:: Set installation temporary directory
set PDK_INSTALL_TEMP_DIR=%~dp0temp%_PDK_ARG_PLATFORM%

:: Delete previous installation temporary directory
if exist %PDK_INSTALL_TEMP_DIR% rmdir %PDK_INSTALL_TEMP_DIR% /s /q || goto :error

:: Create installation temporary directory
mkdir %PDK_INSTALL_TEMP_DIR% || goto :error

:: Set installation platform directory
set PDK_INSTALL_PLATFORM_DIR=%~dp0%_PDK_ARG_PLATFORM%

:: Create platform directory
if not exist %PDK_INSTALL_PLATFORM_DIR% mkdir %PDK_INSTALL_PLATFORM_DIR% || goto :error

:: Install CMake
call %~dp0src\install_cmake %_PDK_ARG_PLATFORM% %_PDK_ARG_PATH_TO_CMAKE% %_PDK_ARG_CMAKE_GENERATOR% || goto :error

:: Install C++ compiler
call %~dp0src\install_cpp_compiler %_PDK_ARG_PLATFORM% %_PDK_ARG_PATH_TO_MSVC% || goto :error

:: Configure CMake
call %PDK_INSTALL_PLATFORM_DIR%\configure_cmake || goto :error

:: Configure C++ compiler
call %PDK_INSTALL_PLATFORM_DIR%\configure_cpp_compiler || goto :error

:: Install Boost
call %~dp0src\install_boost %_PDK_ARG_PLATFORM% || goto :error

:: Install JSON
call %~dp0src\install_json %_PDK_ARG_PLATFORM% || goto :error

:: Delete installation temporary directory
rmdir %PDK_INSTALL_TEMP_DIR% /s /q || goto :error

:: Clear variables
set _PDK_ARG_PLATFORM=
set _PDK_ARG_PATH_TO_MSVC=
set _PDK_ARG_PATH_TO_CMAKE=
set _PDK_ARG_CMAKE_GENERATOR=
set PDK_INSTALL_TEMP_DIR=
set PDK_INSTALL_PLATFORM_DIR=

exit /b

:error
echo Error: #%errorlevel%

exit /b %errorlevel%

:usage
echo.
echo Usage:
echo     %0 ^<platform^> ^<path-to-msvc^> ^<path-to-cmake^> ^<cmake-generator^>
echo     %0 --help
echo     %0 -h
echo.
echo Example:
echo     %0 win32 "C:\Program Files\Microsoft Visual Studio 14.0" "C:\Program Files\CMake\bin" "Visual Studio 14 2015"
echo.
echo Available platforms:
echo     * win32
echo     * win64

exit /b