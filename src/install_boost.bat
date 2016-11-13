:: install_boost <platform>
@echo off
call %~dp0install_base %1

echo Installing Boost...

:: Select address model basing on current platform
if %1==win32 set _PDK_BOOST_ADDRESS_MODEL=32
if %1==win64 set _PDK_BOOST_ADDRESS_MODEL=64

pushd %~dp0\boost\tools\build\

:: Install Boost.Build
call bootstrap.bat
call b2 install --prefix=%PDK_INSTALL_PLATFORM_DIR%\boost\build || goto :error

popd

pushd %~dp0\boost\

:: Prepare headers
call %PDK_INSTALL_PLATFORM_DIR%\boost\build\bin\b2 headers

:: Install Release
call %PDK_INSTALL_PLATFORM_DIR%\boost\build\bin\b2^
 --build-dir=%PDK_INSTALL_TEMP_DIR%\boost_release^
 --libdir=%PDK_INSTALL_PLATFORM_DIR%\boost\lib^
 --includedir=%PDK_INSTALL_PLATFORM_DIR%\boost\include^
 --layout=system address-model=%_PDK_BOOST_ADDRESS_MODEL%^
   link=shared threading=multi^
   runtime-link=shared^
   variant=release install

:: Install Debug
call %PDK_INSTALL_PLATFORM_DIR%\boost\build\bin\b2^
 --build-dir=%PDK_INSTALL_TEMP_DIR%\boost_debug^
 --libdir=%PDK_INSTALL_PLATFORM_DIR%\boost\libd^
 --includedir=%PDK_INSTALL_PLATFORM_DIR%\boost\include^
 --layout=system address-model=%_PDK_BOOST_ADDRESS_MODEL%^
   link=shared threading=multi^
   runtime-link=shared^
   variant=debug install

popd

:: Save configure script
set _PDK_BOOST_CONFIGURE_SCRIPT=%PDK_INSTALL_PLATFORM_DIR%\configure_boost.bat

echo set PDK_BOOST_INCLUDEDIR=%PDK_INSTALL_PLATFORM_DIR%\boost\include>%_PDK_BOOST_CONFIGURE_SCRIPT%||goto :error
echo set PDK_BOOST_LIBRARYDIR_RELEASE=%PDK_INSTALL_PLATFORM_DIR%\boost\lib>>%_PDK_BOOST_CONFIGURE_SCRIPT%||goto :error
echo set PDK_BOOST_LIBRARYDIR_DEBUG=%PDK_INSTALL_PLATFORM_DIR%\boost\libd>>%_PDK_BOOST_CONFIGURE_SCRIPT%||goto :error
echo exit /b ^0>>%_PDK_BOOST_CONFIGURE_SCRIPT%||goto :error

echo Done!

exit

:error
exit %errorlevel%
