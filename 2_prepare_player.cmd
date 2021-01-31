@echo off

echo ======================================================
echo EasyRPG Player autobuilder v1.0
echo 2020 Marbleen Hyperware
echo marbleen.cl
echo ======================================================
echo.

PUSHD
echo STEP 2: Obtaining EasyRPG Player
echo.

if EXIST Player (
	echo Player folder already exists. Updating it ...
	goto update
)


if EXIST EASYRPG_VERSION (
	for /f "delims=" %%x in (EASYRPG_VERSION) do set EASYRPG_VERSION=%%x
	echo EASYRPG_VERSION file exists. Obtaining Player version %EASYRPG_VERSION% ^.^.^.
	git clone --branch %EASYRPG_VERSION% https://github.com/EasyRPG/Player.git
) else (
	echo EASYRPG_VERSION file does not exists^. Obtaining Player master ^(nightly^) ^.^.^.
	git clone https://github.com/EasyRPG/Player.git
)

if EXIST Player (
	echo Seems things went well! 
) else (
	echo Mmm ... Something went wrong!
	goto end
)

goto after_checkout


:update
cd Player
git pull
cd ..

:after_checkout

echo.
echo ======================================================
echo Please check if there some errors. If not, then the setup is okay, and you can continue to the next step! :)
:end
POPD
echo ======================================================
pause