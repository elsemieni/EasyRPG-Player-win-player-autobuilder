@echo off

echo ======================================================
echo EasyRPG Player autobuilder v1.0
echo 2020 Marbleen Hyperware
echo marbleen.cl
echo ======================================================
echo.

PUSHD
echo STEP 3: Building EasyRPG Player
echo.

if NOT EXIST Player (
	echo Player folder does not exist! Did you executed the previous step^?
	goto end
)

echo This configuration will made this following EasyRPG Config^:
echo EXE x86 Release, FMMIDI

SET /P AREYOUSURE=Do you want to continue (Y/[N])?
IF /I "%AREYOUSURE%" NEQ "Y" GOTO end
echo.

if EXIST Player.exe (
	del /F /Q Player.exe
)

if EXIST Player\MinSizeRel\Player.exe (
	del /F /Q Player\MinSizeRel\Player.exe
)

echo Generating project from CMake files ^.^.^.
cd Player
cmake . -DSHARED_RUNTIME=OFF -DVCPKG_TARGET_TRIPLET=x86-windows-static -G "Visual Studio 16 2019" -A Win32 -DCMAKE_TOOLCHAIN_FILE="..\buildscripts\windows\vcpkg\scripts\buildsystems\vcpkg.cmake" -DCMAKE_BUILD_TYPE=Release -DPLAYER_ENABLE_FMMIDI=ON -DPLAYER_WITH_WILDMIDI=OFF -DPLAYER_BUILD_LIBLCF=ON -DPLAYER_WITH_FLUIDSYNTH=OFF

echo.
echo Compiling Player ^.^.^.
for /f "tokens=*" %%f in ('wmic cpu get NumberOfCores /value ^| find "="') do set %%f
echo Using %NumberOfCores% threads^.
echo.
cmake --build . --target EasyRPG_Player_exe --config MinSizeRel --parallel %NumberOfCores%

echo.
echo Seems it's finished^. Checking if there's an executable output out there.

if EXIST MinSizeRel\Player.exe (
	echo Found! Copying to the main folder^.
	copy MinSizeRel\Player.exe ..
	goto done
) else (
	echo Oops, no Player found^. Perhaps some sort of error in the compilation process^? 
	goto end
)

:done
cd ..
echo.
echo ======================================================
echo DONE^! Your fresh out-of-the-oven EasyRPG Player is awaiting you in this folder. Handle with care while it's hot^! ^:^)
:end
POPD
echo ======================================================
pause