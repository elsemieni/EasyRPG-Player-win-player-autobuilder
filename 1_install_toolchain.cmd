@echo off

echo ======================================================
echo EasyRPG Player autobuilder v1.0
echo 2020 Marbleen Hyperware
echo marbleen.cl
echo ======================================================
echo.

PUSHD
echo STEP 1: Installing EasyRPG toolchain
echo.

rem Checking if I have toolchain
net session >nul 2>&1
if EXIST buildscripts (
	echo Seems that buildscripts folder already exists, skipping obtaining step...
	goto execute_buildscripts
) else (
	echo buildscripts folder does not exist. Retrieving from EasyRPG github...
)

git clone https://github.com/EasyRPG/buildscripts.git

if EXIST buildscripts (
	echo Everything OK! Continuing ...
	goto execute_buildscripts
) else (
	echo Something wrong happened when obtaining buildscripts folder. Aborting!
	goto end
)

:execute_buildscripts
echo Enabling MS Visual C++ Build Tools
call "C:\Program Files (x86)\Microsoft Visual Studio\2019\BuildTools\Common7\Tools\VsDevCmd.bat"

echo Building toolchain from buildscripts ... 
cd buildscripts\windows
call build.cmd

echo.
echo ======================================================
echo Please check if there some errors. If not, then the setup is okay, and you can continue to the next step! :)
:end
POPD
echo ======================================================
pause