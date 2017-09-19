:: install_openssl <platform>
@echo off
call %~dp0install_base %1

echo Installing OpenSSL...

:: Save configure script
set _PDK_OPENSSL_CONFIGURE_SCRIPT=%PDK_INSTALL_PLATFORM_DIR%\configure_openssl.bat

if %1==win32 echo set PDK_OPENSSL_INCLUDEDIR="%~dp0..\bin\win\openssl\include">%_PDK_OPENSSL_CONFIGURE_SCRIPT%||goto :error
if %1==win64 echo set PDK_OPENSSL_INCLUDEDIR="%~dp0..\bin\win\openssl\include64">>%_PDK_OPENSSL_CONFIGURE_SCRIPT%||goto :error
if %1==win32 echo set PDK_OPENSSL_LIBRARYDIR="%~dp0..\bin\win\openssl\lib">>%_PDK_OPENSSL_CONFIGURE_SCRIPT%||goto :error
if %1==win64 echo set PDK_OPENSSL_LIBRARYDIR="%~dp0..\bin\win\openssl\lib64">>%_PDK_OPENSSL_CONFIGURE_SCRIPT%||goto :error
echo exit /b ^0>>%_PDK_OPENSSL_CONFIGURE_SCRIPT%||goto :error

echo Done!

exit

:error
exit %errorlevel%
