:: install_json <platform>
@echo off
call %~dp0install_base %1

echo Installing JSON...

:: Create install dir
if not exist %PDK_INSTALL_PLATFORM_DIR%\json mkdir %PDK_INSTALL_PLATFORM_DIR%\json

:: Copy header file
copy %~dp0json\src\json.hpp %PDK_INSTALL_PLATFORM_DIR%\json\json.hpp

:: Save configure script
set _PDK_JSON_CONFIGURE_SCRIPT=%PDK_INSTALL_PLATFORM_DIR%\configure_json.bat

echo set PDK_JSON_INCLUDEDIR=%PDK_INSTALL_PLATFORM_DIR%\json>%_PDK_JSON_CONFIGURE_SCRIPT%||goto :error
echo exit /b ^0>>%_PDK_JSON_CONFIGURE_SCRIPT%||goto :error

echo Done!

exit

:error
exit %errorlevel%
