:: install_cpp_compiler <platform> <path-to-msvc>
@echo off
call %~dp0install_base %1

echo Installing C++ compiler...

:: Select compiler environment basing on current platform
if %1==win32 set _PDK_CPP_COMPILER_ENV=x86
if %1==win64 set _PDK_CPP_COMPILER_ENV=x64

:: Save configure script
set _PDK_CPP_COMPILER_CONFIGURE_SCRIPT=%PDK_INSTALL_PLATFORM_DIR%\configure_cpp_compiler.bat

echo call %2\VC\vcvarsall.bat %_PDK_CPP_COMPILER_ENV% > %_PDK_CPP_COMPILER_CONFIGURE_SCRIPT% || goto :error

echo Done!

exit

:error
exit %errorlevel%
