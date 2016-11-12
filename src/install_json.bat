setlocal EnableDelayedExpansion EnableExtensions

echo Installing JSON...

set _PDK_ARG_PLATFORM=%1

:: Install JSON header
if not exist %PDK_INSTALL_PLATFORM_DIR%\json mkdir %PDK_INSTALL_PLATFORM_DIR%\json

copy %~dp0json\src\json.hpp %PDK_INSTALL_PLATFORM_DIR%\json\json.hpp

:: Save configure script
set _PDK_JSON_CONFIGURE_SCRIPT=%PDK_INSTALL_PLATFORM_DIR%\configure_json.bat

echo set PDK_JSON_INCLUDEDIR=%PDK_INSTALL_PLATFORM_DIR%\json > %_PDK_JSON_CONFIGURE_SCRIPT% || goto :error

echo Done!

exit /b

:error
exit /b %errorlevel%