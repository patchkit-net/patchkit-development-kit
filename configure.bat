:: configure <platform>
@echo off
call %~dp0config/config.bat

:: Validate arguments
if [%1]==[] goto usage

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

:: Set platform name
set PDK_PLATFORM_NAME=%1

:: Set platform directory
set PDK_PLATFORM_DIR=%~dp0%PDK_PLATFORM_NAME%

:: Check platform directory
if not exist %PDK_PLATFORM_DIR% (
  echo Error: couldn't find platform directory in %PDK_PLATFORM_DIR%
  goto :no_installation
)

:: Call configure scripts
call %PDK_PLATFORM_DIR%/configure_cpp_compiler.bat || goto :configure_error
call %PDK_PLATFORM_DIR%/configure_cmake.bat || goto :configure_error
call %PDK_PLATFORM_DIR%/configure_boost.bat || goto :configure_error
call %PDK_PLATFORM_DIR%/configure_json.bat || goto :configure_error
call %PDK_PLATFORM_DIR%/configure_libtorrent.bat || goto :configure_error

echo.
echo Platform %1 configuration done!

exit /b 0

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

exit /b

:configure_error:
set PDK_PLATFORM_DIR=
set PDK_PLATFORM_NAME=
echo Error: cannot configure the platform.
echo Make sure that installation has been done correctly.

exit /b 1

:no_installation
set PDK_PLATFORM_DIR=
set PDK_PLATFORM_NAME=
echo Please install platform with ./install

exit /b 1