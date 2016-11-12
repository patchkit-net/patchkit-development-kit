:: install_libtorrent <platform>
@echo off
call %~dp0install_base %1

echo Installing libtorrent...

:: Configure necessary dependencies
call %PDK_INSTALL_PLATFORM_DIR%\configure_cpp_compiler.bat
call %PDK_INSTALL_PLATFORM_DIR%\configure_cmake.bat
call %PDK_INSTALL_PLATFORM_DIR%\configure_boost.bat

:: Create directory for release CMake build
if not exist %PDK_INSTALL_TEMP_DIR%\libtorrent_release mkdir %PDK_INSTALL_TEMP_DIR%\libtorrent_release

pushd %PDK_INSTALL_TEMP_DIR%\libtorrent_release

:: Configure release
call cmake ^
  -DCMAKE_INSTALL_PREFIX=%PDK_INSTALL_PLATFORM_DIR%\libtorrent\release ^
  -Dencryption=off ^
  -DBOOST_INCLUDEDIR=%PDK_BOOST_INCLUDEDIR% ^
  -DBOOST_LIBRARYDIR=%PDK_BOOST_LIBRARYDIR_RELEASE% ^
  -G %PDK_CMAKE_GENERATOR% ^
  %~dp0libtorrent

:: Install release
msbuild INSTALL.vcxproj /p:Configuration=Release /p:WarningLevel=0

popd

:: Create directory for debug CMake build
if not exist %PDK_INSTALL_TEMP_DIR%\libtorrent_debug mkdir %PDK_INSTALL_TEMP_DIR%\libtorrent_debug

pushd %PDK_INSTALL_TEMP_DIR%\libtorrent_debug

:: Configure debug
call cmake ^
  -DCMAKE_INSTALL_PREFIX=%PDK_INSTALL_PLATFORM_DIR%\libtorrent\debug ^
  -Dencryption=off ^
  -DBOOST_INCLUDEDIR=%PDK_BOOST_INCLUDEDIR% ^
  -DBOOST_LIBRARYDIR=%PDK_BOOST_LIBRARYDIR_DEBUG% ^
  -G %PDK_CMAKE_GENERATOR% ^
  %~dp0libtorrent

:: Install debug
msbuild INSTALL.vcxproj /p:Configuration=Debug /p:WarningLevel=0

popd

:: Save configure script
set _PDK_LIBTORRENT_CONFIGURE_SCRIPT=%PDK_INSTALL_PLATFORM_DIR%\configure_libtorrent.bat

echo set PDK_LIBTORRENT_INCLUDEDIR_RELEASE=%PDK_INSTALL_PLATFORM_DIR%\libtorrent\release\include > %_PDK_LIBTORRENT_CONFIGURE_SCRIPT% || goto :error
echo set PDK_LIBTORRENT_LIBRARYDIR_RELEASE=%PDK_INSTALL_PLATFORM_DIR%\libtorrent\release\lib >> %_PDK_LIBTORRENT_CONFIGURE_SCRIPT% || goto :error
echo set PDK_LIBTORRENT_INCLUDEDIR_DEBUG=%PDK_INSTALL_PLATFORM_DIR%\libtorrent\debug\include >> %_PDK_LIBTORRENT_CONFIGURE_SCRIPT% || goto :error
echo set PDK_LIBTORRENT_LIBRARYDIR_DEBUG=%PDK_INSTALL_PLATFORM_DIR%\libtorrent\debug\lib >> %_PDK_LIBTORRENT_CONFIGURE_SCRIPT% || goto :error
echo exit /b 0 >> %_PDK_LIBTORRENT_CONFIGURE_SCRIPT% || goto :error

echo Done!

exit
