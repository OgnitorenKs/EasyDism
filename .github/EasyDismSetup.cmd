echo off
chcp 65001 > NUL
setlocal enabledelayedexpansion
title EasyDism Setup │ OgnitorenKs
mode con cols=80 lines=30
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do (set R=%%b)
cd /d "%~dp0"
for /f %%a in ('"cd"') do set Konum=%%a

:: -------------------------------------------------------------
RD /S /Q "C:\EasyDism" > NUL 2>&1
MD "C:\EasyDism" > NUL 2>&1

:: =============================================================
:: Güncelleme dosyası indirilir
cls&Call :Panel "[■■■■■■■■■■■■                                    ]" "%R%[92m       Installing EasyDism...       %R%[0m"
Call :Powershell "& { iwr https://raw.githubusercontent.com/OgnitorenKs/EasyDism/main/.github/EasyDism.zip -OutFile %temp%\EasyDism.zip }"

:: İndirilen güncelleme zip dosyası klasörü çıkarılır.
cls&Call :Panel "[■■■■■■■■■■■■■■■■■■■■■■■■                        ]" "%R%[92m       Installing EasyDism...       %R%[0m"
Call :Powershell "Expand-Archive -Force '%temp%\EasyDism.zip' 'C:\EasyDism'"

:: Güncelleme zip dosyası silinir.
cls&Call :Panel "[■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■            ]" "%R%[92m       Installing EasyDism...       %R%[0m"
DEL /F /Q /A "%temp%\EasyDism.zip" > NUL 2>&1

(
echo Set oWS = WScript.CreateObject^("WScript.Shell"^)
echo sLinkFile = "C:\Users\%username%\Desktop\EasyDism.lnk"
echo Set oLink = oWS.CreateShortcut^(sLinkFile^)
echo oLink.TargetPath = "C:\EasyDism\EasyDism.cmd"
echo oLink.WorkingDirectory = "C:\EasyDism"
echo oLink.Description = "EasyDism"
echo oLink.IconLocation = "C:\EasyDism\Bin\Icon\Ogni.ico"
echo oLink.Save
) > %Temp%\OgnitorenKs.Shortcut.vbs
cscript "%Temp%\OgnitorenKs.Shortcut.vbs" > NUL 2>&1
DEL /F /Q /A "%Temp%\OgnitorenKs.Shortcut.vbs" > NUL 2>&1

:: Settings.ini içine güncelleme tarihi yazılır.
cls&Call :Panel "[■■■■■■■■■■■■■■■■■■■■COMPLETE■■■■■■■■■■■■■■■■■■■■]" "%R%[92m       Installing EasyDism...       %R%[0m"
:: Güncel Toolbox açılır.
Call :Powershell "Start-Process 'C:\EasyDism\EasyDism.cmd' -Verb Runas"
exit
:: =============================================================
:: ██████████████████████████████████████████████████████████████████████████████████████████████████
:: ██████████████████████████████████████████████████████████████████████████████████████████████████
:: ██████████████████████████████████████████████████████████████████████████████████████████████████
:Panel
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo                     %~2
echo.            
echo               %~1
echo.
echo             %R%[33m████ ████ █   █ █ █████ ████ ████ ███ █   █ █  █ ████%R%[0m
echo             %R%[33m█  █ █    ██  █ █   █   █  █ █  █ █   ██  █ █ █  █   %R%[0m
echo             %R%[33m█  █ █ ██ █ █ █ █   █   █  █ ████ ██  █ █ █ ██   ████%R%[0m
echo             %R%[33m█  █ █  █ █  ██ █   █   █  █ █ █  █   █  ██ █ █     █%R%[0m
echo             %R%[33m████ ████ █   █ █   █   ████ █  █ ███ █   █ █  █ ████%R%[0m
goto :eof

:: -------------------------------------------------------------
:Powershell
chcp 437 > NUL 2>&1
Powershell -command %*
chcp 65001 > NUL 2>&1
goto :eof


