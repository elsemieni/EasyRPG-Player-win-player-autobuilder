@echo off

echo ======================================================
echo EasyRPG Player autobuilder v1.0
echo 2020 Marbleen Hyperware
echo marbleen.cl
echo ======================================================
echo.

echo STEP 0: Installing dependencies
echo.

rem Checking if I have admin rights
net session >nul 2>&1
if %errorLevel% == 0 (
	goto admin_continue
) else (
	goto :common_user
)


:common_user
echo You need to run this program as administrator
goto end

:admin_continue
echo Admin rights OK

rem checking chocolatey
choco >nul 2>&1
if %errorLevel% == 9009 (
	echo Chocolatey not installed
) else (
	echo Chocolatey already installed
	goto choco_end
)



rem Downloading and installing chocolatey
echo Downloading and installing chocolatey...
%systemroot%\System32\WindowsPowerShell\v1.0\powershell.exe -NoProfile -ExecutionPolicy Bypass -Command "& '%DIR%common\chocolatey.ps1' %*"
SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"
echo Checking installation
choco >nul 2>&1
if %errorLevel% == 9009 (
	echo Something wrong happened when installing chocolatey. Aborting...
	goto end
) else (
	echo Chocolatey seems OK.
)

choco feature enable -n=allowGlobalConfirmation

:choco_end
echo Installing dependencies

choco install git -y
choco install cmake --installargs 'ADD_CMAKE_TO_PATH=System' -y
choco install visualstudio2019buildtools --package-parameters "--addProductLang En-us" -y
choco install visualstudio2019-workload-vctools -y
echo.
echo ======================================================
echo All set! You can now continue to the next step! :)

:end
echo ======================================================
pause