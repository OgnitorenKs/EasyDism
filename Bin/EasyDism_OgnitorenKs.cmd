(
echo :: ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
echo ::
echo ::       ██████   ██████   ██    ██ ████ ████████  ██████  ████████  ████████ ██    ██ ██    ██  ██████
echo ::      ██    ██ ██    ██  ███   ██  ██     ██    ██    ██ ██     ██ ██       ███   ██ ██   ██  ██    █
echo ::      ██    ██ ██        ████  ██  ██     ██    ██    ██ ██     ██ ██       ████  ██ ██  ██   ██
echo ::      ██    ██ ██   ████ ██ ██ ██  ██     ██    ██    ██ ████████  ██████   ██ ██ ██ █████      ██████ 
echo ::      ██    ██ ██    ██  ██  ████  ██     ██    ██    ██ ██   ██   ██       ██  ████ ██  ██         ██
echo ::      ██    ██ ██    ██  ██   ███  ██     ██    ██    ██ ██    ██  ██       ██   ███ ██   ██  ██    ██
echo ::       ██████   ██████   ██    ██ ████    ██     ██████  ██     ██ ████████ ██    ██ ██    ██  ██████ 
echo ::
echo ::  ► Hazırlayan: Hüseyin UZUNYAYLA / OgnitorenKs
echo ::
echo ::  ► İletişim - Contact;
echo ::  --------------------------------------
echo ::  • Discord: https://discord.gg/7hbzSGTYeZ
echo ::  •    Site: https://ognitorenks.blogspot.com/
echo ::
echo :: ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
echo echo off
echo chcp 65001
echo setlocal enabledelayedexpansion
echo title EasyDism │ OgnitorenKs
echo cls
echo.
echo FOR /F "tokens=1,2 delims=#" %%%%a in ^('"prompt #$H#$E# & echo on & for %%%%b in (1) do rem"'^) do ^(set R=%%%%b^)
echo.
echo cd /d "%%~dp0"
echo FOR /F %%%%a in ^('cd'^) do ^(set Konum=%%%%a^)
echo.
echo reg query "HKU\S-1-5-19" ^> NUL 2^>^&1
echo 	if %%errorlevel%% NEQ 0 ^(Call :Powershell "Start-Process '%Konum%\EasyDism_OgnitorenKs' -Verb Runas"&exit^)

:: ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
:: Powershell scipt engeli kaldırılır
Call :Powershell "Set-ExecutionPolicy Unrestricted"

cls&echo %R%[33m Masaüstü dosyaları çıkartılıyor...%R%[0m
:: Ziplenen masaüstü dosyaları masaüstüne çıkarılır.
Call :Powershell "Expand-Archive -Force '%Konum%\Desktop.zip' 'C:\Users\%username%\Desktop\EasyDism_OgnitorenKs'"
:: Çıkarma işlemi sonrası Masaustu.zip dosyası silinir
DEL /F /Q /A "%Konum%\Desktop.zip" > NUL 2>&1

:: -------------------------------------------------------------
cls&echo %R%[33m Komut dosyaları çalıştırılıyor...%R%[0m
:: Bat klasörünün içinde yer alan dosyalar çalıştırılır.
FOR %%a in (bat cmd) do (
	FOR /R %Konum%\EasyDism_OgnitorenKs\Setup\ %%b in (*.%%a) do (
		echo %R%[37m "%%~nb" komut dosyası bekleniyor...
		"%Konum%\NSudo.exe" -U:C -P:E -Wait cmd /c "%%b"
	)
)
FOR /R %Konum%\EasyDism_OgnitorenKs\Setup\ %%a in (*.vbs) do (
	echo %R%[37m "%%~na" vbs dosyası bekleniyor...
	"%Konum%\NSudo.exe" -U:C -P:E -Wait cmd /c "%%a"
)
FOR /R %Konum%\EasyDism_OgnitorenKs\Setup\ %%a in (*.ps1) do (
	echo %R%[37m "%%~na" ps1 dosyası bekleniyor...
	"%Konum%\NSudo.exe" -U:C -P:E -Wait Powershell -file "%%a"
)

:: -------------------------------------------------------------
cls&echo %R%[33m Regedit kayıtları yükleniyor...%R%[0m
:: Regedit klasörü içerisinde yer alan .reg dosyalarını sisteme entegre eder.
FOR /R %Konum%\EasyDism_OgnitorenKs\Setup\ %%a in (*.reg) do (
	echo %R%[37m "%%~na" regedit kaydı uygulanıyor...
	"%Konum%\NSudo.exe" -U:T -P:E -Wait -ShowWindowMode:hide cmd /c Reg import "%%a"
)
timeout /t 1 /nobreak > NUL
cls

:: -------------------------------------------------------------
echo %R%[33m Programlar yükleniyor...%R%[0m
:: Programlar klasörü içerisinde yer alan programları yükler. Yalnızca katılımsız setuplar içindir.
FOR /R %Konum%\EasyDism_OgnitorenKs\Setup\ %%a in (*.exe) do (
	echo %R%[37m "%%~na" yükleniyor...
	"%%a" > NUL 2>&1
)
timeout /t 1 /nobreak > NUL
cls

:: -------------------------------------------------------------
:: Powershell script engeli aktifleştirilir
Call :Powershell "Set-ExecutionPolicy restricted"
cls
echo.
echo %R%[92m İŞLEMLER TAMAMLANDI %R%[0m
echo.
echo %R%[33m DeliPetro %R%[0m
(
echo echo off
echo cls
echo reg query "HKU\S-1-5-19" ^> NUL 2^>^&1
echo	if %%errorlevel%% NEQ 0 ^(Powershell -Command "Start-Process '%%temp%%\DeliPetro2.cmd' -Verb Runas"^&exit^)
echo RD /S /Q "%Konum%" ^> NUL 2^>^&1
echo reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "DeliPetro" /f ^> NUL 2^>^&1
echo reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "DeliPetro2" /f ^> NUL 2^>^&1
echo RD /S /Q %%temp%%\* ^> NUL 2^>^&1
echo DEL /F /Q /A %%temp%%\* ^> NUL 2^>^&1
echo exit
) > %temp%\DeliPetro2.cmd
:: Builder ile eklediğimiz regedit kaydını tekrara girmemesi için kaldırıyoruz.
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "DeliPetro" /f > NUL 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "DeliPetro2" /t REG_SZ /d "%temp%\Delipetro2.cmd" /f > NUL 2>&1
shutdown -r -f -t 5
timeout /t 4 /nobreak > NUL
exit

:: ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
:Powershell
:: Powershell komutları kullanıldığında komut istemi compact moda girmektedir. Bunu önlemek için karakter takımları arasında geçiş yapıyoruz.
chcp 437 > NUL 2>&1
Powershell -command %*
chcp 65001 > NUL 2>&1
goto :eof

:TT
title  EasyDism │ OgnitorenKs
goto :eof
