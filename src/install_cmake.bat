:: install_cmake <platform> <path-to-cmake> <cmake-generator>
@echo off
call %~dp0install_base %1

echo Installing CMake...

:: Save configure script
set _PDK_CMAKE_CONFIGURE_SCRIPT=%PDK_INSTALL_PLATFORM_DIR%\configure_cmake.bat

echo set PATH=%%PATH%%;%2 > %_PDK_CMAKE_CONFIGURE_SCRIPT% || goto :error
echo set PDK_CMAKE_GENERATOR=%3 >> %_PDK_CMAKE_CONFIGURE_SCRIPT% || goto :error

echo Done!

exit

:error
exit %errorlevel%
