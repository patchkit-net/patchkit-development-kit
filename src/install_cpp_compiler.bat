setlocal EnableDelayedExpansion EnableExtensions

echo Installing C++ compiler...

set _PDK_ARG_PLATFORM=%1
set _PDK_ARG_PATH_TO_MSVC=%2

:: Select compiler environment basing on current platform
if %_PDK_ARG_PLATFORM%==win32 set _PDK_CPP_COMPILER_ENV=x86
if %_PDK_ARG_PLATFORM%==win64 set _PDK_CPP_COMPILER_ENV=x64

:: Save configure script
set _PDK_CPP_COMPILER_CONFIGURE_SCRIPT=%PDK_INSTALL_PLATFORM_DIR%\configure_cpp_compiler.bat

echo call %_PDK_ARG_PATH_TO_MSVC%\VC\vcvarsall.bat %_PDK_CPP_COMPILER_ENV% > %_PDK_CPP_COMPILER_CONFIGURE_SCRIPT% || goto :error

echo Done!

exit /b

:error
exit /b %errorlevel%