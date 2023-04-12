@set @_cmd=1 /*
@echo off
setlocal EnableExtensions
title mosdns

whoami /groups | findstr "S-1-16-12288" >nul && goto :admin
if "%~1"=="RunAsAdmin" goto :error

echo Requesting privileges elevation for managing the dnscrypt-proxy service . . .
cscript /nologo /e:javascript "%~f0" || goto :error
exit /b

:error
echo.
echo Error: Administrator privileges elevation failed,
echo        please manually run this script as administrator.
echo.
goto :end

:admin
pushd "%~dp0"
mosdns service install -c config.yaml
mosdns service start
popd
echo.
echo Thank you for using mosdns!

:end
set /p =Press [Enter] to exit . . .
exit /b */

// JScript, restart batch script as administrator
var objShell = WScript.CreateObject('Shell.Application');
var ComSpec = WScript.CreateObject('WScript.Shell').ExpandEnvironmentStrings('%ComSpec%');
objShell.ShellExecute(ComSpec, '/c ""' + WScript.ScriptFullName + '" RunAsAdmin"', '', 'runas', 1);
