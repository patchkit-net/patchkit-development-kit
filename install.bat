:: install <platform> <path-to-msvc> <path-to-cmake>
@echo off
call %~dp0config\config.bat

:: Validate arguments
if [%1]==[] goto usage
if [%2]==[] goto usage
if [%3]==[] goto usage

:: Display usage on -h or --help
if %1==--help (
  goto usage
)

if %1==-h (
  goto usage
)

:: Check <platform>
if not %1==win32 if not %1==win64 (
  echo Error: unavailable ^<platform^> %1
  goto usage
)

:: Check <path-to-msvc>
if not exist %2 (
  echo Error: couldn't find ^<path-to-msvc^> in %2
  goto usage
)

:: Check <path-to-cmake>
if not exist %3 (
  echo Error: couldn't find ^<path-to-cmake^>
  goto usage
)

:: Set install variables
call %~dp0src/install_vars %1 || goto :error

:: Delete previous temp dir
if exist %PDK_INSTALL_TEMP_DIR% rmdir %PDK_INSTALL_TEMP_DIR% /s /q || goto :error

:: Create temp dir
mkdir %PDK_INSTALL_TEMP_DIR% || goto :error

:: Create platform dir if not exists
if not exist %PDK_INSTALL_PLATFORM_DIR% mkdir %PDK_INSTALL_PLATFORM_DIR% || goto :error

:: Install CMake
start /B /WAIT %~dp0src\install_cmake %1 %3 || goto :error

:: Install C++ compiler
start /B /WAIT %~dp0src\install_cpp_compiler %1 %2 || goto :error

:: Install Boost (if not installed)
if not exist %PDK_INSTALL_PLATFORM_DIR%\configure_boost.bat (
  start /B /WAIT %~dp0src\install_boost %1 || goto :error
)

:: Install JSON
start /B /WAIT %~dp0src\install_json %1 || goto :error

:: Install libtorrent (if not installed)
if not exist %PDK_INSTALL_PLATFORM_DIR%\configure_libtorrent.bat (
  start /B /WAIT %~dp0src\install_libtorrent %1 || goto :errror
)

:: Delete temp directory
rmdir %PDK_INSTALL_TEMP_DIR% /s /q || goto :error

echo Installation of platform %1 completed!

exit /b 0

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
echo Examples:
echo     %0 win32 "C:\Program Files (x86)\Microsoft Visual Studio 14.0" "C:\Program Files\CMake\bin" "Visual Studio 14 2015"
echo     %0 win64 "C:\Program Files (x86)\Microsoft Visual Studio 14.0" "C:\Program Files\CMake\bin" "Visual Studio 14 2015 x64"
echo.
echo Available platforms:
echo     * win32
echo     * win64

exit /b 0
