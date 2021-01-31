@echo off

echo ======================================================
echo EasyRPG Player autobuilder v1.0
echo 2020 Marbleen Hyperware
echo marbleen.cl
echo ======================================================
echo.

PUSHD
echo STEP 3.x: Apply patches to EasyRPG source code
echo.

if NOT EXIST Player (
	echo Player folder does not exist! Did you executed the previous step^?
	goto end
)

set CREDENTIALS_FOUND=0
ECHO %CREDENTIALS_FOUND%
echo Checking if you have configured your name and email in git
git config --list | findstr "user.email"
	if %ERRORLEVEL% == 0 (
		SET CREDENTIALS_FOUND=1
	)

if %CREDENTIALS_FOUND% == 0 (
  echo Not set^. You must set it^.
  goto set_credentials
) ELSE (
  echo Fine, these are already set^!
  goto credentials_ok
)

:set_credentials
echo Enter your name or username or nick or whathever ^(or github username, if you have one^)^:
set /P GITNAME=
git config --global user.name "%GITNAME%"
echo Enter your mail address ^(the one associated with github, if you have one^) ^(not used for mail sending^)^: 
set /P GITMAIL=
git config --global user.email "%GITMAIL%"
echo Fine, credentials are set to %GITNAME% ^<%GITMAIL%^> ^!
goto credentials_ok


:credentials_ok
cd Player

echo Searching and applying patches ^.^.^.
for /r %%v in (..\patches_enabled\*.patch) do (
	echo Applying %%v ^. Applying ^.^.^.
	git am < %%v
	if %ERRORLEVEL% GEQ 1 goto patch_error
)
goto done

:patch_error
echo Seems there's an error when applying the patch. ^:^(
goto end

:done
cd ..
echo.
echo ======================================================
echo Please check if there some errors. If not, then the setup is okay, and you can continue to the next step! :)
:end
POPD
echo ======================================================
pause