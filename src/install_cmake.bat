setlocal EnableDelayedExpansion EnableExtensions

echo Installing CMake...

set _PDK_ARG_PLATFORM=%1
set _PDK_ARG_PATH_TO_CMAKE=%2
set _PDK_ARG_CMAKE_GENERATOR=%3

:: Save configure script
set _PDK_CMAKE_CONFIGURE_SCRIPT=%PDK_INSTALL_PLATFORM_DIR%\configure_cmake.bat

echo set PATH=%%PATH%%;%_PDK_ARG_PATH_TO_CMAKE% > %_PDK_CMAKE_CONFIGURE_SCRIPT% || goto :error
echo set PDK_CMAKE_GENERATOR=%_PDK_ARG_CMAKE_GENERATOR% >> %_PDK_CMAKE_CONFIGURE_SCRIPT% || goto :error

echo Done!

exit /b

:error
exit /b %errorlevel%