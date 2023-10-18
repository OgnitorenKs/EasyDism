:: ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
::
::       ██████   ██████   ██    ██ ████ ████████  ██████  ████████  ████████ ██    ██ ██    ██  ██████
::      ██    ██ ██    ██  ███   ██  ██     ██    ██    ██ ██     ██ ██       ███   ██ ██   ██  ██    █
::      ██    ██ ██        ████  ██  ██     ██    ██    ██ ██     ██ ██       ████  ██ ██  ██   ██
::      ██    ██ ██   ████ ██ ██ ██  ██     ██    ██    ██ ████████  ██████   ██ ██ ██ █████      ██████ 
::      ██    ██ ██    ██  ██  ████  ██     ██    ██    ██ ██   ██   ██       ██  ████ ██  ██         ██
::      ██    ██ ██    ██  ██   ███  ██     ██    ██    ██ ██    ██  ██       ██   ███ ██   ██  ██    ██
::       ██████   ██████   ██    ██ ████    ██     ██████  ██     ██ ████████ ██    ██ ██    ██  ██████ 
::
::  ► Hazırlayan: Hüseyin UZUNYAYLA / OgnitorenKs
::
::  ► İletişim - Contact;
::  --------------------------------------
::  • Discord: OgnitorenKs#2737 
::  •    Site: https://ognitorenks.blogspot.com
::
:: ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
:OgnitorenKs.Builder
echo off
chcp 65001 > NUL 2>&1
title  EasyDism │ OgnitorenKs
setlocal enabledelayedexpansion
cls

:: -------------------------------------------------------------
:: Renklendirme
FOR /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E#&echo on&for %%b in (1) do rem"') do (set R=%%b)

:: -------------------------------------------------------------
:: Konum bilgisi
cd /d "%~dp0"
FOR /F %%a in ('"cd"') do set L=%%a

:: -------------------------------------------------------------
Findstr /i "Language_Pack" %L%\Settings.ini > NUL 2>&1
	if !errorlevel! NEQ 0 (FOR /F "tokens=6" %%a in ('Dism /Online /Get-intl ^| Find /I "Default system UI language"') do (
								if %%a EQU tr-TR (echo Language_Pack^>Turkish^> >> %L%\Settings.ini
												  set Lang=%L%\Bin\Language\Turkish.cmd)
								if %%a NEQ tr-TR (echo Language_Pack^>English^> >> %L%\Settings.ini
												  set Lang=%L%\Bin\Language\English.cmd)))
	if !errorlevel! EQU 0 (FOR /F "delims=> tokens=2" %%a in ('Findstr /i "Language_Pack" %L%\Settings.ini') do (set Lang=%L%\Bin\Language\%%a.cmd))

:: -------------------------------------------------------------
:: Değişkenler
set NSudo="%L%\Bin\NSudo.exe" -U:T -P:E -Wait -ShowWindowMode:hide cmd /c
set Mount=%L%\Mount
set Mount_Road=NT

:: -------------------------------------------------------------
:: Admin yetkisini kontrol eder
reg query "HKU\S-1-5-19" > NUL 2>&1
	if %errorlevel% NEQ 0 (Call :Powershell "Start-Process '%L%\EasyDism.cmd' -Verb Runas"&exit)

:: -------------------------------------------------------------
:: x64 sistem kontrolü yapılır.
FOR /F "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v "PROCESSOR_ARCHITECTURE" 2^>NUL') do (
	if %%a NEQ AMD64 (Call :LA 2 Error_3_&cls&echo %R%[31m !LA2! %R%[0m&exit)
)

:: -------------------------------------------------------------
:: Klasör yolunda Türkçe karakter ve boşluk olup olmadığını kontrol etmek için ilgili başlığı çağırıyoruz
Call :Error_Character "%L%"
	if %Error% EQU 1 (Call :LA 2 Y0001&echo.&echo %R%[32m !LA2! %R%[0m&Call :TO 3&exit)
	if %Error% EQU 2 (Call :LA 2 Y0001&echo.&echo %R%[32m !LA2! %R%[0m&Call :TO 3&exit)
	
:: -------------------------------------------------------------
FOR %%a in (Regedit Output Driver Update Bin\Logs) do (
	MD "%L%\%%a" > NUL 2>&1
)

:: -------------------------------------------------------------
:: Yüklü mount yollarını alır ve remount işlemi yapar. Bunun uygulanması olası hataları önlemektedir.
Call :LA 2 Y0023&echo.&echo %R%[92m !LA2! %R%[0m
Dism /Get-Mountedwiminfo > %L%\Bin\Logs\MountInfo.txt
FOR /F "delims=':' tokens=3" %%a in ('Find "Mount Dir" %L%\Bin\Logs\MountInfo.txt 2^>NUL') do (
	FOR /F "skip=2 delims=':' tokens=2" %%b in ('Find "Mount Dir" %L%\Bin\Logs\MountInfo.txt 2^>NUL') do (
		echo %%b | Findstr /i "?" > NUL 2>&1
			if !errorlevel! EQU 0 (FOR /F "delims='\\?\' tokens=2" %%c in ('echo %%b ^>NUL') do (set C=%%c
																								 set C=!C:~1!
																								 Dism /Remount-Image /MountDir:"!C!:%%a" > NUL 2>&1))
			if !errorlevel! NEQ 0 (set B=%%b
								   set B=!B:~1!
								   Dism /Remount-Image /MountDir:"!B!:%%a" > NUL 2>&1)
	)
)

:: ██████████████████████████████████████████████████████████████████
:Menu
mode con cols=100 lines=25
::Call :LA 2 Prepared_By_&Call :LB 3 Prepared_By_&echo %R%[90m !LB3!:%R%[96m  !LA2! %R%[0m
Call :Mount_Check2
	if %Hata% EQU 1 (set Mount_Road=NT)
if !Mount_Road! EQU GO (mode con cols=130 lines=30
						::Call :LA 2 Prepared_By_&Call :LB 3 Prepared_By_&echo %R%[90m !LB3!:%R%[96m  !LA2! %R%[0m
						Call :Menu_Reader)
echo.
Call :LA 2 Y0020&echo %R%[91m► EasyDism !LA2! %R%[0m
echo.
set Count=0
FOR /L %%a in (1,1,14) do (
	Call :LA 2 Menu_%%a_
	set /a Count+=1
	if %%a LSS 10 (set Count= !Count!)
	if %%a LEQ 12 (echo %R%[32m  !Count! %R%[90m-%R%[33m !LA2! %R%[0m)
	if %%a EQU 13 (echo %R%[32m  !Count! %R%[90m-%R%[36m !LA2! %R%[0m)
	if %%a EQU 14 (echo %R%[32m  !Count! %R%[90m-%R%[37m !LA2! %R%[0m)
)
echo.
Call :LA 2 D0001&set /p Menu=►%R%[92m !LA2!: %R%[0m
	if %Menu% EQU 1 (Call :Imaj_WimReader)
	if %Menu% EQU 2 (Call :Imaj_WIM2ESD)
	if %Menu% EQU 3 (Call :Imaj_ESD2WIM)
	if %Menu% EQU 4 (Call :Imaj_Index_Export)
	if %Menu% EQU 5 (Call :Imaj_AIO_Maker)
	if %Menu% EQU 6 (Call :Imaj_WimMount)
	if %Menu% EQU 7 (Call :Mount_Driver_Install)
	if %Menu% EQU 8 (Call :Mount_Regedit_Install)
	if %Menu% EQU 9 (Call :Mount_Update_Install)
	if %Menu% EQU 10 (Call :AfterSetup)
	if %Menu% EQU 11 (Call :Mount_UnMount)
	if %Menu% EQU 12 (Call :Imaj_ISO_Maker)
	if %Menu% EQU 13 (Call :Mount_Reader)
	if %Menu% EQU 14 (Call :Language_Select)
	if %Error% EQU X (goto Menu)
Call :ProcessCompleted
goto Menu

:: ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
:Imaj_WimReader
mode con cols=100 lines=25
Call :LA 2 Menu_1_&echo %R%[91m► !LA2! %R%[0m
echo.&Call :Install_Road
set F_Error=!Error!
set Error=NT
FOR %%a in (!F_Error!) do (
	if %%a EQU X (set Error=X)
)
set F_Error=
if %Error% EQU X (goto :eof)
Call :ModeLong&mode con cols=130 lines=!Mode!
Call :LA 2 Menu_1_&echo %R%[91m► !LA2! %R%[0m
Call :OgnitorenKs.Reader "%MainWim%" echo :: :: :: :: ::
Call :LA 2 Y0002&echo %R%[92m !LA2! %R%[0m
pause > NUL 
goto :eof

:: -------------------------------------------------------------
:Imaj_WIM2ESD
mode con cols=100 lines=25
Call :LA 2 Menu_2_&echo %R%[91m► !LA2! %R%[0m
set Error=NT
cls&Call :LA 2 Menu_2_&echo %R%[91m► !LA2! %R%[0m
echo.&Call :Install_Road
set F_Error=!Error!
set Error=NT
FOR %%a in (!F_Error!) do (
	FOR %%b in (1 2 4 5 6 12) do (
		if %%a EQU X (set Error=X)
		if %%a EQU %%b (Call :LE %%b)
	)
)
set F_Error=
if %Error% EQU X (goto :eof)
Call :ModeLong&mode con cols=130 lines=!Mode!
Call :LA 2 Menu_2_&echo %R%[91m► !LA2! %R%[0m
Call :OgnitorenKs.Reader "%MainWim%" echo :: :: :: :: ::
Call :LA 2 D0002&set /p index=%R%[92m !LA2!%R%[90m x,y%R%[92m : %R%[0m
:: Menü tuşlaması için kontrol eder. İndex kontrol edince hata veriyordu. Findstr ile aratmak zorunda kaldım.
echo %index% | Findstr /i "x" > NUL 2>&1
	if %errorlevel% EQU 0 (set Error=X&goto :eof)
:: Outuput klasöründe install.esd dosyasını kontrol eder.
dir /b %L%\Output\install.esd > NUL 2>&1
	if %errorlevel% EQU 0 (cls&echo.&Call :LA 2 Error_0_&echo %R%[91m !LA2! %R%[0m
						   echo.&Call :LA 2 Y0025&Call :LB 3 Y0025&echo %R%[33m !LA2! install.esd !LB3! %R%[0m
						   Call :LA 2 D0004&echo %R%[33m install.esd !LA2!:%R%[37m Z%R%[0m
						   Call :LA 2 D0005&echo %R%[33m !LA2!:%R%[37m X%R%[0m
						   Call :LA 2 D0001&echo.&set /p Value=►%R%[32m !LA2!: %R%[0m
						   Call :Upper Value "!Value!"
								if !Value! EQU Z (DEL /F /Q /A "%L%\Output\install.esd" > NUL 2>&1)
)
)
:: Wim içeriğini okur, ekrana bilgi verip işlemi yapar.
mode con cols=130 lines=30
Call :LA 2 Y0003
FOR %%a in (%index%) do (
	FOR /F "tokens=3" %%b IN ('Dism /Get-WimInfo /WimFile:%MainWim% /Index:%%a ^| FIND "Architecture"') do (
		FOR /F "tokens=2 delims=:" %%c IN ('Dism /Get-WimInfo /WimFile:%MainWim% /Index:%%a ^| FIND "Name"') do (
			FOR /F "tokens=*" %%d in ('echo %%c') do (
				Call :For_Lang "%%a" "%%d %%b"
				Dism /Export-Image /SourceImageFile:%MainWim% /SourceIndex:%%a /DestinationImageFile:%L%\Output\install.esd /Compress:Recovery /CheckIntegrity
			)
		)
	)
)
cls&echo.&Call :LA 2 Y0004&echo %R%[37m !LA2! %R%[0m
set Value=&echo.&Call :LA 2 D0006&set /p Value=►%R%[32m !LA2!%R%[90m [%R%[96m Y %R%[90m/%R%[96m N %R%[90m]: %R%[0m
Call :Upper Value %Value%
	if %Value% EQU Y (cls&echo.&Call :LA 2 Y0005&echo %R%[92m !LA2! %R%[0m
					  DEL /F /Q /A %MainWim% > NUL 2>&1
					  FOR /F "tokens=*" %%j in ('dir /b /s %L%\Output\install.esd') do (move /y "%%j" "%WimFile%\sources" > NUL 2>&1)
					  goto :eof
)
:: İşlem sonunda WIM_Compress klasörünü açar. Powershell ile bunu yaparak işlemi beklemesini önlüyorum.
Call :Powershell "Start-Process '%L%\Output'"
goto :eof
	
:: -------------------------------------------------------------
:Imaj_ESD2WIM
:: Çerçeve ayarı yapar.
mode con cols=100 lines=25
set Error=NT
Call :LA 2 Menu_3_&echo %R%[91m► !LA2! %R%[0m
:: İmaj yolu almak için ilgili başlığı çağırır.
echo.&Call :Install_Road
set F_Error=!Error!
set Error=NT
FOR %%a in (!F_Error!) do (
	FOR %%b in (1 2 5 6 11 12) do (
		if %%a EQU X (set Error=X)
		if %%a EQU %%b (Call :LE %%b)
	)
)
set F_Error=
if %Error% EQU X (goto :eof)
:: ESD içeriğini okumak için "OgnitorenKs.Reader" başlığı çağırılır.
Call :ModeLong&mode con cols=130 lines=!Mode!
Call :LA 2 Menu_3_&echo %R%[91m► !LA2! %R%[0m
Call :OgnitorenKs.Reader "%MainWim%" "echo" :: :: :: :: ::
:: Dönüştürülecek index numaralarının tuşlanması istenir.
Call :LA 2 D0002&set /p index=%R%[92m  !LA2!%R%[90m x,y%R%[92m : %R%[0m
:: Menü tuşlaması için kontrol eder. İndex kontrol edince hata veriyordu. Findstr ile aratmak zorunda kaldım.
echo %index% | Findstr /i "x" > NUL 2>&1
	if %errorlevel% EQU 0 (set Error=X&goto :eof)
:: Outuput klasöründe install.wim dosyasını kontrol eder.
dir /b %L%\Output\install.wim > NUL 2>&1
	if %errorlevel% EQU 0 (cls&echo.&Call :LA 2 Error_0_&echo %R%[91m !LA2! %R%[0m
						   echo.&Call :LA 2 Y0025&Call :LB 3 Y0025&echo %R%[33m !LA2! install.wim !LB3! %R%[0m
						   Call :LA 2 D0004&echo %R%[33m install.wim !LA2!:%R%[37m Z%R%[0m
						   Call :LA 2 D0005&echo %R%[33m !LA2!:%R%[37m X%R%[0m
						   Call :LA 2 D0001&echo.&set /p Value=►%R%[32m !LA2!: %R%[0m
						   Call :Upper Value "!Value!"
								if !Value! EQU Z (DEL /F /Q /A "%L%\Output\install.wim" > NUL 2>&1)
)
:: Wim içeriğini okur, ekrana bilgi verip işlemi yapar.
mode con cols=130 lines=30
Call :LA 2 Y0003
FOR %%a in (%index%) do (
	FOR /F "tokens=3" %%b IN ('Dism /Get-WimInfo /WimFile:%MainWim% /Index:%%a ^| FIND "Architecture"') do (
		FOR /F "tokens=2 delims=:" %%c IN ('Dism /Get-WimInfo /WimFile:%MainWim% /Index:%%a ^| FIND "Name"') do (
			FOR /F "tokens=*" %%d in ('echo %%c') do (
				Call :For_Lang "%%a" "%%d %%b"
				Dism /Export-Image /SourceImageFile:%MainWim% /SourceIndex:%%a /DestinationImageFile:%L%\Output\install.wim /Compress:max /CheckIntegrity
			)
		)
	)
)
cls&echo.&Call :LA 2 Y0004&echo %R%[37m !LA2! %R%[0m
set Value=&echo.&Call :LA 2 D0006&set /p Value=►%R%[32m !LA2!%R%[90m [%R%[96m Y %R%[90m/%R%[96m N %R%[90m]: %R%[0m
Call :Upper Value %Value%
	if %Value% EQU Y (cls&echo.&Call :LA 2 Y0005&echo %R%[92m !LA2! %R%[0m
					  DEL /F /Q /A %MainWim% > NUL 2>&1
					  move /y "%L%\Output\install.wim" "%WimFile%\sources" > NUL 2>&1
					  goto :eof
)
:: İşlem sonunda ESD2WIM klasörünü açar. Powershell ile bunu yaparak işlemi beklemesini önlüyorum.
Call :Powershell "Start-Process '%L%\Output'"
goto :eof

:: -------------------------------------------------------------
:Imaj_Index_Export
:: Çerçeve ayarı yapar.
mode con cols=100 lines=25
set Error=NT
:: İmaj yolu almak için ilgili başlığı çağırır.
Call :LA 2 Menu_4_&echo %R%[91m► !LA2! %R%[0m
:: İmaj yolu alması için ilgili başlığı çağırır.
echo.&Call :Install_Road
set F_Error=!Error!
set Error=NT
FOR %%a in (!F_Error!) do (
	FOR %%b in (1 2 5 6) do (
		if %%a EQU X (set Error=X)
		if %%a EQU %%b (Call :LE %%b)
	)
)
if %Error% EQU X (goto :eof)
:: Wim içeriğini okumak için "OgnitorenKs.Reader" başlığı çağırılır.
Call :ModeLong&mode con cols=130 lines=!Mode!
Call :LA 2 Menu_4_&echo %R%[91m► !LA2! %R%[0m
Call :OgnitorenKs.Reader "%MainWim%" echo :: :: :: :: ::
:: Silinecek indexleri ister. Çoklu seçim yapılamaz. Her silme işleminden sonra Index numaraları kayacağı için yanlış işlem yapar.
Call :LA 2 D0002&set /p index=%R%[92m !LA2!%R%[90m x,y%R%[92m : %R%[0m
:: Menü tuşlaması için kontrol eder. İndex kontrol edince hata veriyordu. Findstr ile aratmak zorunda kaldım.
echo %index% | Findstr /i "x" > NUL 2>&1
	if %errorlevel% EQU 0 (set Error=X&goto :eof)
:: Outuput klasöründe install.wim dosyasını kontrol eder.
FOR %%a in (!F_Error!) do (
	if %%a EQU 4 (set VN=esd
				  dir /b %L%\Output\install.esd > NUL 2>&1
					if !errorlevel! EQU 0 (cls&echo.&Call :LA 2 Error_0_&echo %R%[91m !LA2! %R%[0m
										   echo.&Call :LA 2 Y0025&Call :LB 3 Y0025&echo %R%[33m !LA2! install.esd !LB3! %R%[0m
										   Call :LA 2 D0004&echo %R%[33m install.esd !LA2!:%R%[37m Z%R%[0m
										   Call :LA 2 D0005&echo %R%[33m !LA2!:%R%[37m X%R%[0m
										   Call :LA 2 D0001&echo.&set /p Value=►%R%[32m !LA2!: %R%[0m
										   Call :Upper Value "!Value!"
												if !Value! EQU Z (DEL /F /Q /A "%L%\Output\install.esd" > NUL 2>&1)
	)
)
	if %%a EQU 11 (set VN=wim
				   dir /b %L%\Output\install.wim > NUL 2>&1
					if !errorlevel! EQU 0 (cls&echo.&Call :LA 2 Error_0_&echo %R%[91m !LA2! %R%[0m
										   echo.&Call :LA 2 Y0025&Call :LB 3 Y0025&echo %R%[33m !LA2! install.wim !LB3! %R%[0m
										   Call :LA 2 D0004&echo %R%[33m install.wim !LA2!:%R%[37m Z%R%[0m
										   Call :LA 2 D0005&echo %R%[33m !LA2!:%R%[37m X%R%[0m
										   Call :LA 2 D0001&echo.&set /p Value=►%R%[32m !LA2!: %R%[0m
										   Call :Upper Value "!Value!"
												if !Value! EQU Z (DEL /F /Q /A "%L%\Output\install.wim" > NUL 2>&1)
		)
	)
)

set F_Error=
:: Wim içeriğini okur, ekrana bilgi verip işlemi yapar.
mode con cols=130 lines=30
Call :LA 2 Y0006
FOR %%a in (%index%) do (
	FOR /F "tokens=3" %%b IN ('Dism /Get-WimInfo /WimFile:%MainWim% /Index:%%a ^| FIND "Architecture"') do (
		FOR /F "tokens=2 delims=:" %%c IN ('Dism /Get-WimInfo /WimFile:%MainWim% /Index:%%a ^| FIND "Name"') do (
			FOR /F "tokens=*" %%d in ('echo %%c') do (
				Call :For_Lang "%%a" "%%d %%b"
				Dism /Export-Image /SourceImageFile:%MainWim% /SourceIndex:%%a /DestinationImageFile:%L%\Output\install.!VN! /Compress:max /CheckIntegrity
			)
		)
	)
)
cls&echo.&Call :LA 2 Y0004&echo %R%[37m !LA2! %R%[0m
set Value=&echo.&Call :LA 2 D0006&set /p Value=►%R%[32m !LA2!%R%[90m [%R%[96m Y %R%[90m/%R%[96m N %R%[90m]: %R%[0m
Call :Upper Value %Value%
	if %Value% EQU Y (cls&echo.&Call :LA 2 Y0005&echo %R%[92m !LA2! %R%[0m
					  DEL /F /Q /A %MainWim% > NUL 2>&1
					  move /y "%L%\Output\install.!VN!" "%WimFile%\sources" > NUL 2>&1
					  set VN=
					  goto :eof
)
set VN=
Call :Powershell "Start-Process '%L%\Output'"
goto :eof

:: -------------------------------------------------------------
:Imaj_AIO_Maker
:: Çerçeve ayarını yapar
mode con cols=100 lines=25
:: Başlık mesajını çağırır
Call :LA 2 Menu_5_&echo %R%[91m !LA2! %R%[0m
echo.&Call :LA 2 Y0007&echo %R%[90m !LA2! %R%[0m
:: İmaj yolunu alması için ilgili başlığı çağırıyoruz.
Call :Install_Road
set BaseWim=!MainWim!
set F_Error=&set F_Error=!Error!
set Error=NT
FOR %%a in (!F_Error!) do (
	FOR %%b in (1 2 4 5 6 7) do (
		if %%a EQU X (set Error=X)
		if %%a EQU %%b (Call :LE %%b)
	)
)
if !Error! EQU X (goto :eof)
echo.&Call :LA 2 Y0008&echo %R%[90m !LA2! %R%[0m
:: WimRoad_3 bölümünden wim yolunu alıyoruz.
Call :Install_Road
set AddWim=!MainWim!
set MainWim=!BaseWim!
set BaseWim=
set F_Error=NT&set F_Error=!Error!
set Error=NT
FOR %%a in (!F_Error!) do (
	FOR %%b in (1 2 4 5 6 7) do (
		if %%a EQU X (set Error=X)
		if %%a EQU %%b (Call :LE %%b)
	)
)
set F_Error=
if !Error! EQU X (goto :eof)
:: Wim dosya içeriğini okumak için OgnitorenKs.Reader bölümüne değerleri gönderiyorum.
Call :ModeLong2
mode con cols=130 lines=!Mode!
Call :LA 2 Y0007&Call :OgnitorenKs.Reader "%MainWim%" :: echo "!LA2!" :: :: ::
Call :LA 2 Y0008&Call :OgnitorenKs.Reader "%AddWim%" :: :: :: echo "!LA2!" echo
:: Eklenecek olan sürümleri burada kullanıcıdan seçmesini istiyoruz.
Call :LA 2 D0002&set /p index=%R%[92m  !LA2!%R%[90m x,y%R%[92m : %R%[0m
:: Menü tuşlaması için kontrol eder. İndex kontrol edince hata veriyordu. Findstr ile aratmak zorunda kaldım.
echo %index% | Findstr /i "x" > NUL 2>&1
	if %errorlevel% EQU 0 (set Error=X&goto :eof)
:: Wim içeriğini okur, ekrana bilgi verip işlemi yapar.
mode con cols=130 lines=30
Call :LA 2 Y0009
FOR %%a in (%index%) do (
	FOR /F "tokens=3" %%b IN ('Dism /Get-WimInfo /WimFile:%AddWim% /Index:%%a ^| FIND "Architecture"') do (
		FOR /F "tokens=2 delims=:" %%c IN ('Dism /Get-WimInfo /WimFile:%AddWim% /Index:%%a ^| FIND "Name"') do (
			FOR /F "tokens=*" %%d in ('echo %%c') do (
				Call :For_Lang "%%a" "%%d %%b"
				Dism /Export-Image /SourceImageFile:%AddWim% /SourceIndex:%%a /DestinationImageFile:%MainWim% /Compress:max /CheckIntegrity
			)
		)
	)
)
:: İşlem bittikten sonra ana dizin içeriğini gösterir.
cls&Call :OgnitorenKs.Reader "%MainWim%" "echo" :: :: :: :: ::
echo.&Call :LA 2 Y0010&echo %R%[92m !LA2! %R%[0m
Call :LA 2 Y0011&echo %R%[96m !LA2! %R%[0m
pause > NUL
goto :eof

:: -------------------------------------------------------------
:Imaj_WimMount
mode con cols=100 lines=25
:: Mount klasöründe yüklü bir sistem olup olmadığını kontrol eder.
set Error=NT
Dism /Get-Mountedwiminfo | Findstr /i "%L%\Mount" > NUL 2>&1
	if %errorlevel% EQU 0 (Call :LE 9)
	if %errorlevel% NEQ 0 (RD /S /Q "%L%\Mount" > NUL 2>&1
						   MD "%L%\Mount" > NUL 2>&1)
Call :RegeditCollect
cls&Call :LA 2 Menu_6_&echo %R%[91m► !LA2! %R%[0m
echo.&Call :Install_Road
set F_Error=!Error!
set Error=NT
FOR %%a in (!F_Error!) do (
	FOR %%b in (1 2 4 6 7) do (
		if %%a EQU X (set Error=X)
		if %%a EQU %%b (Call :LE %%b)
	)
)
set F_Error=
:: Install.wim içeriğini okuması için yönelndirme yapıyorum.
Call :ModeLong&mode con cols=130 lines=!Mode!
Call :LA 2 Menu_6_&echo %R%[91m► !LA2! %R%[0m
Call :OgnitorenKs.Reader "%MainWim%" echo :: :: :: :: ::
:: İşlem yapılacak indexi kullanıcıdan istiyoruz
Call :LA 2 D0001&set /p index= %R%[92m !LA2! : %R%[0m
:: Menü tuşlaması için kontrol eder. İndex kontrol edince hata veriyordu. Findstr ile aratmak zorunda kaldım.
echo %index% | Findstr /i "x" > NUL 2>&1
	if %errorlevel% EQU 0 (set Error=X&goto :eof)
set Mount=%L%\Mount
mode con cols=130 lines=30
Call :LA 2 Y0006
:: Dism ile wim içeriği hakkında bilgi alınır ve yapılan işlem hakkında komut ekranına bilgi verir.
FOR %%a in (%index%) do (
	FOR /F "tokens=3" %%b IN ('Dism /Get-WimInfo /WimFile:%MainWim% /Index:%%a ^| FIND "Architecture"') do (
		FOR /F "tokens=2 delims=:" %%c IN ('Dism /Get-WimInfo /WimFile:%MainWim% /Index:%%a ^| FIND "Name"') do (
			FOR /F "tokens=*" %%d in ('echo %%c') do (
				Call :For_Lang "%%a" "%%d %%b"
				Dism /Mount-Image /ImageFile:%MainWim% /MountDir:"%Mount%" /Index:%%a
			)
		)
	)
)
set Mount_Road=GO
goto :eof

:: -------------------------------------------------------------
:Mount_Driver_Install
mode con cols=130 lines=40
Call :Mount_Check
	if %Error% EQU X (goto :eof)
Call :LA 2 Y0012&echo.&echo %R%[32m !LA2!... %R%[0m
Dism /Image:%Mount% /Add-Driver /Driver:%L%\Driver /Recurse
goto :eof

:: -------------------------------------------------------------
:Mount_Regedit_Install
mode con cols=100 lines=25
Call :Mount_Check
	if %Error% EQU X (goto :eof)
dir /b %L%\Regedit\*.reg > NUL 2>&1
	if %errorlevel% NEQ 0 (set Error=X&goto :eof)
Call :LA 2 Y0026&echo.&echo %R%[32m !LA2! %R%[0m
Call :RegeditCollect
Call :RegeditInstall
set ValueR=0xx1524RtYn97752Hataonlemesistemi
FOR /F "skip=2 delims=\_ tokens=3" %%g in ('Find "[HKEY_USERS\S-1-5-" %L%\Regedit\*.reg 2^>NUL') do (set ValueR=%%g)
FOR /F "tokens=*" %%g in ('dir /b /s %L%\Regedit\*.reg 2^>NUL') do (
	Call :Powershell "(Get-Content %%g) | ForEach-Object { $_ -replace '%ValueR%', '.Default' } | Set-Content '%%g'"
)
set ValueR=0xx1524RtYn97752Hataonlemesistemi
FOR /F "skip=2 delims=\_ tokens=3" %%g in ('Find "[HKU\S-1-5-" %L%\Regedit\*.reg 2^>NUL') do (set ValueR=%%g)
FOR /F "tokens=*" %%g in ('dir /b /s %L%\Regedit\*.reg 2^>NUL') do (
	Call :Powershell "(Get-Content %%g) | ForEach-Object { $_ -replace '%ValueR%', '.Default' } | Set-Content '%%g'"
)
Call :Regedit_Turn "HKLM\\SOFTWARE" "HKEY_LOCAL_MACHINE\OFF_SOFTWARE"
Call :Regedit_Turn "HKEY_LOCAL_MACHINE\\SOFTWARE" "HKEY_LOCAL_MACHINE\OFF_SOFTWARE"
Call :Regedit_Turn "HKLM\\SYSTEM" "HKEY_LOCAL_MACHINE\OFF_SYSTEM"
Call :Regedit_Turn "HKEY_LOCAL_MACHINE\\SYSTEM" "HKEY_LOCAL_MACHINE\OFF_SYSTEM"
Call :Regedit_Turn "HKLM\\SYSTEM\\CurrentControlSet" "HKEY_LOCAL_MACHINE\OFF_SYSTEM\ControlSet001"
Call :Regedit_Turn "HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet" "HKEY_LOCAL_MACHINE\OFF_SYSTEM\ControlSet001"
Call :Regedit_Turn "HKCR" "HKEY_LOCAL_MACHINE\OFF_SOFTWARE\Classes"
Call :Regedit_Turn "HKEY_CLASSES_ROOT" "HKEY_LOCAL_MACHINE\OFF_SOFTWARE\Classes"
Call :Regedit_Turn "HKCU" "HKEY_LOCAL_MACHINE\OFF_HKCU"
Call :Regedit_Turn "HKEY_CURRENT_USER" "HKEY_LOCAL_MACHINE\OFF_HKCU"
Call :Regedit_Turn "HKU\\.Default" "HKEY_LOCAL_MACHINE\OFF_HKU"
Call :Regedit_Turn "HKEY_USERS\\.Default" "HKEY_LOCAL_MACHINE\OFF_HKU"
FOR /F "tokens=*" %%k in ('dir /b /s %L%\Regedit\*.reg 2^>NUL') do (
	%NSudo% Reg import "%%k"
)
Call :Regedit_Turn "HKEY_LOCAL_MACHINE\\OFF_HKU" "HKEY_LOCAL_MACHINE\OFF_HKCU"
FOR /F "tokens=*" %%k in ('dir /b /s %L%\Regedit\*.reg 2^>NUL') do (
	%NSudo% Reg import "%%k"
)
Call :Regedit_Turn "HKEY_LOCAL_MACHINE\\OFF_HKCU" "HKEY_LOCAL_MACHINE\OFF_HKU"
FOR /F "tokens=*" %%k in ('dir /b /s %L%\Regedit\*.reg 2^>NUL') do (
	%NSudo% Reg import "%%k"
)
reg delete "HKLM\OFF_SYSTEM\CurrentControlSet" /f > NUL 2>&1
Call :RegeditCollect
set ValueR=
goto :eof

:Regedit_Turn
FOR /F "tokens=*" %%g in ('dir /b /s %L%\Regedit\*.reg 2^>NUL') do (
	Call :Powershell "(Get-Content %%g) | ForEach-Object { $_ -replace '%~1', '%~2' } | Set-Content '%%g'"
)
goto :eof

:: -------------------------------------------------------------
:Mount_Update_Install
mode con cols=130 lines=40
set Error=NT
Call :Mount_Check
	if %Error% EQU X (goto :eof)
cls&Call :LA 2 Y0021&echo %R%[92m !LA2! %R%[0m
FOR /F %%a in ('dir /b %L%\Update\*.* 2^>NUL') do (
	Dism /Image:%Mount% /Add-Package /Packagepath=%L%\Update\%%a
)
cls&Call :LA 2 Y0028&echo %R%[92m !LA2! %R%[0m
::Dism /Image:%Mount% /Cleanup-Image /RevertPendingActions
Dism /Image:%Mount% /Cleanup-Image /StartComponentCleanup /ResetBase
Dism /Image:%Mount% /Optimize-ProvisionedAppxPackages
goto :eof

:: -------------------------------------------------------------
:Mount_UnMount
:: Dism bazı durumlarda hata verip kapanabiliyor. Bu tarz bir durumda Powershell üzerinden toplama işlemi yapması için önlem aldım.
Call :RegeditCollect
Call :Mount_Reader
Call :LA 2 Y0018&cls&echo.&echo %R%[92m !LA2! %R%[0m
Dism /Unmount-Image /MountDir:%Mount% /commit
	if !errorlevel! NEQ 0 (cls&Call :LA 2 Y0019&echo %R%[31m !LA2! %R%[0m
						   Call :Powershell "Dismount-WindowsImage -Path '%Mount%' -Save")
echo %MainWim% | Findstr /i "boot.wim" > NUL 2>&1
	if %errorlevel% EQU 0 (goto :eof)
Call :Mount_Check2
	if %Hata% EQU 1 (Call :LA 2 Y0024&cls&echo.&echo %R%[32m !LA2! %R%[0m
					 FOR /F "tokens=3" %%a in ('Dism /Get-WimInfo /WimFile:%MainWim% ^| Find "Index"') do (
						Dism /Export-Image /SourceImageFile:%MainWim% /SourceIndex:%%a /DestinationImageFile:%WimFile%\sources\newinstall.wim /Compress:max /CheckIntegrity)
					 DEL /F /Q /A "%MainWim%" > NUL 2>&1
					 Rename "%WimFile%\sources\newinstall.wim" "install.wim" > NUL 2>&1
)
goto :eof

:: -------------------------------------------------------------
:Imaj_ISO_Maker
mode con cols=130 lines=40
:: Dil dosyasından veriyi çeker
Call :LA 2 Menu_12_&echo %R%[91m !LA2! %R%[0m
echo.&Call :LA 2 D0007&set /p WinISO=►%R%[92m !LA2! : %R%[0m
	if %WinISO% EQU x (set Error=X&goto :eof)
	if %WinISO% EQU X (set Error=X&goto :eof)
:: Boşluk ve Türkçe karakter tespiti yapılır. Tespit edilirse menüye döner.
Call :Error_Character "%WinISO%"
set F_Error=!Error!
set Error=NT
FOR %%a in (!F_Error!) do (
	FOR %%b in (1 2) do (
		if %%a EQU X (set Error=X)
		if %%a EQU %%b (Call :LE %%b)
	)
)
set F_Error=
if %Error% EQU X (goto :eof)
Call :LA 2 D0008&echo.&set /p etiket=►%R%[92m !LA2! : %R%[0m
	if %etiket% EQU x (set Error=X&goto :eof)
	if %etiket% EQU X (set Error=X&goto :eof)
Call :LA 2 D0009&echo.&set /p isokayit=►%R%[92m !LA2! : %R%[0m
	if %isokayit% EQU x (set Error=X&goto :eof)
	if %isokayit% EQU X (set Error=X&goto :eof)
:: ISO dosyası kontrol edilr.
dir /b %L%\Output\%isokayit%.iso > NUL 2>&1
	if %errorlevel% EQU 0 (Call :LA 2 D0010&echo.&set /p Value=•%R%[33m '%isokayit%.iso' -%R%[37m !LA2! %R%[90m[%R%[36m Y %R%[90m/%R%[36m N %R%[90m]:%R%[0m
						   Call :Upper Value !Value!
						   if !Value! NEQ Y (set Error=X&goto :eof)
)
:: Dil dosyasından veri alınır.
cls&Call :LA 2 Menu_11_&echo %R%[91m► !LA2! %R%[0m
echo.&Call :LA 2 Y0022&echo %R%[92m !LA2! %R%[0m
:: Oscdimg ile ISO dosyası oluşturulur.
%L%\Bin\oscdimg.exe -m -o -u2 -udfver102 -bootdata:2#p0,e,b%WinISO%\boot\etfsboot.com#pEF,e,b%WinISO%\efi\microsoft\boot\efisys.bin -L%etiket% %WinISO%\ %L%\Output\%isokayit%.iso
:: İşlem bitince Output klasörünü açar. ISO dosyasına ulaşması için.
Call :Powershell "Start-Process '%L%\Output'"
:: Bölüme ait değişkenler sıfırlanır.
For %%a in (etiket isokayit WinISO) do (set %%a=)
goto :eof

:: ██████████████████████████████████████████████████████████████████
:____HANGAR____
:Menu_Reader
Call :LA 2 Y0016&echo %R%[35m► !LA2! %R%[0m
echo.
echo %R%[90m►   Mount =%R%[36m %Mount% %R%[0m
echo %R%[90m►   Image =%R%[36m %MainWim:~1,-1% %R%[90m│%R%[36m %index%%R%[0m
FOR /F "tokens=3" %%a in ('Dism /Get-WimInfo /WimFile:%MainWim% /Index:%index% ^| FIND "Architecture"') do (
	FOR /F "skip=1 delims=. tokens=3" %%b in ('Dism /Get-WimInfo /WimFile:%MainWim% /Index:%index% ^| Find "Version"') do (
		FOR /F "tokens=4" %%c in ('Dism /Get-WimInfo /WimFile:%MainWim% /Index:%index% ^| Find "Build"') do (
			FOR /F "tokens=2 delims=':'" %%d in ('Dism /Get-WimInfo /WimFile:%MainWim% /Index:%index% ^| findstr /C:Name') do (
				echo %R%[90m►  System =%R%[36m%%d %R%[90m│%R%[36m %%a%R%[0m
				echo %R%[90m► Version =%R%[36m %%b.%%c%R%[0m
			)
		)
	)
)
goto :eof

:: -------------------------------------------------------------
:Mount_Reader
mode con cols=130 lines=40
set Mount_Road=GO
DEL /F /Q /A "%L%\Bin\Logs\wiminfo.txt" > NUL 2>&1
Dism /Get-Mountedwiminfo > %L%\Bin\Logs\MountInfo.txt
set Count=0
FOR /F "delims=':' tokens=3" %%a in ('Find "Mount Dir" %L%\Bin\Logs\MountInfo.txt 2^>NUL') do (
	FOR /F "skip=2 delims=':' tokens=2" %%b in ('Find "Mount Dir" %L%\Bin\Logs\MountInfo.txt 2^>NUL') do (
		echo %%b | Findstr /i "?" > NUL 2>&1
			if !errorlevel! EQU 0 (FOR /F "delims='\\?\' tokens=2" %%c in ('echo %%b ^>NUL') do (set /a Count+=1
																								 set C=%%c
																								 set C=!C:~1!
																								 echo =Mount_!Count!_^>!C!:%%a^> >> %L%\Bin\Logs\wiminfo.txt
								  ))
			if !errorlevel! NEQ 0 (set /a Count+=1
								   set B=%%b
								   set B=!B:~1!
								   echo =Mount_!Count!_^>!B!:%%a^> >> %L%\Bin\Logs\wiminfo.txt
								  )
	)
)
set Count=0
FOR /F "delims=':' tokens=3" %%a in ('Find "Image File" %L%\Bin\Logs\MountInfo.txt 2^>NUL') do (
	FOR /F "skip=2 delims=':' tokens=2" %%b in ('Find "Image File" %L%\Bin\Logs\MountInfo.txt 2^>NUL') do (
		echo %%b | Findstr /i "?" > NUL 2>&1
			if !errorlevel! EQU 0 (FOR /F "delims='\\?\' tokens=2" %%c in ('echo %%b ^>NUL') do (set /a Count+=1
																								 set C=%%c
																								 set C=!C:~1!
																								 echo =Wim_!Count!_^>!C!:%%a^> >> %L%\Bin\Logs\wiminfo.txt
								  ))
			if !errorlevel! NEQ 0 (set /a Count+=1
								   set B=%%b
								   set B=!B:~1!
								   echo =Wim_!Count!_^>!B!:%%a^> >> %L%\Bin\Logs\wiminfo.txt
								  )
	)
)
set Count=0
FOR /F "tokens=4" %%g in ('Findstr /C:"Image Index" %L%\Bin\Logs\MountInfo.txt 2^>NUL') do (
	set /a Count+=1
	echo =Index_!Count!_^>%%g^> >> %L%\Bin\Logs\wiminfo.txt
)
:: Menü bölümü
cls&echo.&Call :LA 2 Y0013&echo %R%[35m !LA2! %R%[0m&echo.
set Count=0
FOR /F "delims=> tokens=2" %%g in ('Findstr /i "=Mount" %L%\Bin\Logs\wiminfo.txt 2^>NUL') do (
	set /a Count+=1
	echo  %R%[32m !Count!-%R%[36m %%g %R%[0m
)
:: Mount dizini yoksa uyarı mesajı verir
Findstr /i "=Mount_1_" %L%\Bin\Logs\wiminfo.txt > NUL 2>&1
	if %errorlevel% NEQ 0 (Call :LA 2 Y0014&echo %R%[31m !LA2! %R%[0m)
echo.
Call :LA 2 Y0015&echo  %R%[32m X-%R%[37m !LA2! %R%[0m
FOR %%a in (B C) do (set %%a=)
echo.&Call :LA 2 D0001&set /p Value=%R%[90m►%R%[92m !LA2!= %R%[0m
Call :Upper Value %Value%
:: Offline regedit kayıtlarını kontrol eder. Bulursa kaldırır.
Call :RegeditCollect
if %Value% EQU X (set Error=X&goto Menu)
:: Mount tanımlamamaları için kontrol ve bilgi alma bölümü
FOR /F "delims=> tokens=2" %%g in ('Findstr /i "=Mount_%Value%_" %L%\Bin\Logs\wiminfo.txt 2^>NUL') do (set Mount=%%g)
FOR /F "delims=> tokens=2" %%g in ('Findstr /i "=Wim_%Value%_" %L%\Bin\Logs\wiminfo.txt 2^>NUL') do (set MainWim="%%g")
FOR /F "delims=> tokens=2" %%g in ('Findstr /i "=Index_%Value%_" %L%\Bin\Logs\wiminfo.txt 2^>NUL') do (set index=%%g)
echo %MainWim% | Findstr /i "install.wim" > NUL 2>&1
	if %errorlevel% EQU 0 (set WimFile=%MainWim:~1,-21%)
echo %MainWim% | Findstr /i "boot.wim" > NUL 2>&1
	if %errorlevel% EQU 0 (set WimFile=%MainWim:~1,-18%)
goto :eof

:: -------------------------------------------------------------
:Mount_Check
Dism /Get-Mountedwiminfo | Find "Mount Dir" | Find "%Mount%" > NUL 2>&1
	if %errorlevel% NEQ 0 (Call :LE 10)
goto :eof

:Mount_Check2
set Hata=1
Dism /Get-Mountedwiminfo | Find "Mount Dir" | Find "%Mount%" > NUL 2>&1
	if %errorlevel% EQU 0 (set Hata=0)
goto :eof
:: ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
:RegeditInstall
reg load HKLM\OFF_COMPONENTS "%Mount%\Windows\System32\config\COMPONENTS" > NUL 2>&1
reg load HKLM\OFF_HKU "%Mount%\Windows\System32\config\default" > NUL 2>&1
reg load HKLM\OFF_HKCU "%Mount%\Users\Default\ntuser.dat" > NUL 2>&1
reg load HKLM\OFF_SOFTWARE "%Mount%\Windows\System32\config\SOFTWARE" > NUL 2>&1
reg load HKLM\OFF_SYSTEM "%Mount%\Windows\System32\config\SYSTEM" > NUL 2>&1
goto :eof

:: -------------------------------------------------------------
:RegeditCollect
taskkill /f /im "regedit.exe" > NUL 2>&1
reg delete "HKLM\OFF_SYSTEM\CurrentControlSet" /f > NUL 2>&1
FOR %%g in ({ TK_ OFF_ NLTmp~) do (
	FOR /F "tokens=*" %%k in ('reg query "HKLM" ^| Findstr "%%g"') do (
		reg unload "%%k" > NUL 2>&1
	)
)
goto :eof

:: -------------------------------------------------------------
:Regedit_Turn2
FOR /F "tokens=*" %%g in ('dir /b /s %Mount%\EasyDism_OgnitorenKs\*.reg 2^>NUL') do (
	Call :Powershell "(Get-Content %%g) | ForEach-Object { $_ -replace '%~1', '%~2' } | Set-Content '%%g'"
)
goto :eof

:: ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
:Powershell
:: Powershell komutları kullanıldığında komut istemi compact moda girmektedir. Bunu önlemek için karakter takımları arasında geçiş yapıyoruz.
chcp 437 > NUL 2>&1
Powershell -command %*
chcp 65001 > NUL 2>&1
goto :eof

:: -------------------------------------------------------------
:Powershell_2
:: Powershell komutları kullanıldığında komut istemi compact moda girmektedir. Bunu önlemek için karakter takımları arasında geçiş yapıyoruz.
chcp 437 > NUL 2>&1
Powershell -NoLogo -NoProfile -NonInteractive -ExecutionPolicy Bypass -Command %*
chcp 65001 > NUL 2>&1
goto :eof

:: -------------------------------------------------------------
:Parse
:: Tırnak işaretlerini kaldırır
set %~1=%~2
goto :eof

:: -------------------------------------------------------------
:TO
timeout /t %~1 /nobreak > NUL
goto :eof

:: -------------------------------------------------------------
:Uzunluk
:: %~1: Değişken değeri  %~2: Uzunluğu hesaplanacak olan değer
chcp 437 > NUL
FOR /F "tokens=*" %%z in ('Powershell -C "'%~2'.Length"') do (set Uzunluk%~1=%%z)
chcp 65001 > NUL
goto :eof

:: -------------------------------------------------------------
:ModeLong
FOR /F "tokens=3" %%z in ('Dism /Get-WimInfo /WimFile:!MainWim! ^| Find "Index"') do (set Mode=%%z)
set /a Mode*=2
set /a Mode=6+!Mode!
goto :eof

:: -------------------------------------------------------------
:ModeLong2
FOR /F "tokens=3" %%z in ('Dism /Get-WimInfo /WimFile:!MainWim! ^| Find "Index"') do (set Mode1=%%z)
FOR /F "tokens=3" %%z in ('Dism /Get-WimInfo /WimFile:!AddWim! ^| Find "Index"') do (set Mode2=%%z)
set /a Mode1*=2
set /a Mode2*=2
set /a Mode=11+!Mode1!+!Mode2!
FOR %%z in (Mode1 Mode2) do (set %%z=)
goto :eof

:: -------------------------------------------------------------
:Upper
:: %~1: Değişken adı  | %~2: Girilen Hash Değeri
chcp 437 > NUL 2>&1
FOR /F %%g in ('Powershell -command "'%~2'.ToUpper()"') do (set %~1=%%g)
chcp 65001 > NUL 2>&1
goto :eof


:: ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
:OgnitorenKs.Reader
%~3  %R%[90m┌──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐%R%[0m
%~3  %R%[95m ► %~4 ◄
%~3  %R%[90m├─────┬──────┬────────────┬───────┬────────────┬───────────────────────────────────────────────────────────────────────────────┤%R%[0m
%~5  %R%[90m├─────┴──────┴────────────┴───────┴────────────┴───────────────────────────────────────────────────────────────────────────────┤%R%[0m
%~5  %R%[95m ► %~6 ◄
%~5  %R%[90m├─────┬──────┬────────────┬───────┬────────────┬───────────────────────────────────────────────────────────────────────────────┤%R%[0m
%~2  %R%[90m┌─────┬──────┬────────────┬───────┬────────────┬───────────────────────────────────────────────────────────────────────────────┐%R%[0m
echo  %R%[90m│%R%[32mIndex%R%[90m│%R%[32m Arch %R%[90m│ %R%[32m  Version  %R%[90m│  %R%[32mLang %R%[90m│   %R%[32m Edit    %R%[90m│    %R%[32mName%R%[0m
FOR /F "tokens=3" %%a IN ('Dism /Get-WimInfo /WimFile:%~1 ^| Find "Index"') DO (
	FOR /F "tokens=3" %%b IN ('Dism /Get-WimInfo /WimFile:%~1 /Index:%%a ^| Find "Architecture"') DO (
		FOR /F "skip=1 delims=. tokens=3" %%c in ('Dism /Get-WimInfo /WimFile:%~1  /Index:%%a ^| Find "Version"') do (
				FOR /F "tokens=4" %%d in ('Dism /Get-WimInfo /WimFile:%~1  /Index:%%a ^| Find "Build"') do (
					FOR /F "tokens=1" %%e in ('Dism /Get-WimInfo /WimFile:%~1  /Index:%%a ^| findstr /i Default') do (
						FOR /F "tokens=2 delims=':'" %%f in ('Dism /Get-WimInfo /WimFile:%~1  /Index:%%a ^| findstr /i Name') do (
							FOR /F "tokens=2 delims='-',':' " %%g in ('Dism /Get-WimInfo /WimFile:%~1  /Index:%%a ^| findstr /i Modified') do (
								set Huseyin=%%g
								FOR /F "delims=. tokens=1" %%a in ('echo %%g') do (if %%a LSS 10 (set Huseyin=0%%g))
								Call :Uzunluk 1 %%c
								if %%a LSS 10 (set Marty= %%a)
								if %%a GEQ 10 (set Marty=%%a)
								if !Uzunluk1! EQU 4 (set Ogni= %%c)
								if !Uzunluk1! EQU 5 (set Ogni=%%c)
									echo  %R%[90m├─────┼──────┼────────────┼───────┼────────────┼───────────────────────────────────────────────────────────────────────────────┤%R%[0m
									echo   %R%[92m !Marty!%R%[0m  ► %R%[33m %%b  %R%[36m !Ogni!.%%d  %R%[33m %%e  %R%[36m !Huseyin!  %R%[37m %%f%R%[0m
									)
								)
							)
						)
					)
				)
			)
		)
	)
)
%~2  %R%[90m└─────┴──────┴────────────┴───────┴────────────┴───────────────────────────────────────────────────────────────────────────────┘%R%[0m
%~7  %R%[90m└─────┴──────┴────────────┴───────┴────────────┴───────────────────────────────────────────────────────────────────────────────┘%R%[0m
goto :eof

:: ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
:Error_Character
:: Klasör yolunda Türkçe karakterleri kontrol eder
set Error=NT
set Check=%~1
FOR %%z in (Ö ö Ü ü Ğ ğ Ş ş Ç ç ı İ) do (
	echo %Check% | Find "%%a" > NUL 2>&1
		if !errorlevel! EQU 0 (cls&echo.&Call :LA 2 Error_1_&echo %R%[31m !LA2! %R%[0m&set Error=1)
)
:: Klasör yolunda boşlukları tespit eder.
if "%Check%" NEQ "%Check: =%" (cls&echo.&Call :LA 2 Error_2_&echo %R%[31m !LA2! %R%[0m&set Error=!Error!,2)
set Check=
goto :eof

:: ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
:Install_Road
set Error=NT
Call :LA 2 D0003&set /p MainWim=►%R%[92m !LA2!: %R%[0m
For %%g in (x X) do (
	if %MainWim% EQU %%g (set Error=X&goto :eof)
)
:: Türkçe karakter ve boşluk kontrolü
Call :Error_Character "%MainWim%"
	if %Error% NEQ NT (goto :eof
)
:: ISO kontrolü
echo %MainWim%\ | Find "\\" > NUL 2>&1
	if %errorlevel% EQU 0 (set Error=!Error!,6&set MainWim=%MainWim:~0,-1%
)
:: Verilen yolda boot.wim olarak mı verilmiş onu kontrol ediyorum.
echo %MainWim% | Findstr /i "boot.wim" > NUL 2>&1
	if %errorlevel% EQU 0 (Call :WimRoad "BootWim" !MainWim!&Call :WimFile !BootWim!&Call :Boot_Index&set Error=!Error!,5&goto :eof)
	if %errorlevel% NEQ 0 (dir /b /s %MainWim%\*boot.wim > NUL 2>&1
							   if !errorlevel! NEQ 0 (set Error=!Error!,8)
						       if !errorlevel! EQU 0 (Call :Boot_Road&Call :Boot_Index&Call :WimFile !BootWim!)
)
:: Verilen yol install.wim'in mi onu kontrol ediyorum.
echo %MainWim% | Findstr /i "install.wim" > NUL 2>&1
	if %errorlevel% EQU 0 (set Error=!Error!,11&Call :WimRoad MainWim !MainWim!&Call :WimFile !MainWim!&goto :eof)
	if %errorlevel% NEQ 0 (dir /b /s %MainWim%\*install.wim > NUL 2>&1
							   if !errorlevel! EQU 0 (set Error=!Error!,11
													  FOR /R %MainWim%\ %%g in (*install.wim) do (Call :WimRoad MainWim %%g&Call :WimFile %%g))
							   if !errorlevel! NEQ 0 (set Error=!Error!,7)
)
:: Verilen yol install.esd'nin yolu mu onu kontrol ediyorum.
echo %MainWim% | Findstr /i "install.esd" > NUL 2>&1
	if %errorlevel% EQU 0 (set Error=!Error!,4)
	if %errorlevel% NEQ 0 (dir /b /s %MainWim%\*install.esd > NUL 2>&1
							   if !errorlevel! EQU 0 (set Error=!Error!,4
													  FOR /F "delims=7 tokens=1" %%g in ('echo !Error!') do (set N_Error=%%g)
													  FOR /F "delims=7 tokens=2" %%g in ('echo !Error!') do (set N_Error=!N_Error!%%g)
													  set Error=!N_Error!
													  set N_Error=
													  FOR /R %MainWim%\ %%g in (*install.esd) do (Call :WimRoad MainWim %%g&Call :WimFile %%g))
							   if !errorlevel! NEQ 0 (echo !Error! | Findstr /i "7" > NUL 2>&1
													  if !errorlevel! NEQ 0 (set Error=!Error!,77))
)
goto :eof
:Boot_Road
FOR /R %MainWim%\ %%g in (*boot.wim) do (Call :WimRoad BootWim %%g)
goto :eof
:Boot_Index
Dism /Get-WimInfo /WimFile:%BootWim% /Index:1 | Find "Microsoft Windows Setup" > NUL 2>&1
	if %errorlevel% EQU 0 (set BootIndex=1)
	if %errorlevel% NEQ 0 (set BootIndex=2)
goto :eof
:WimFile
set WimFile=%~dp1
set WimFile=!WimFile:~0,-9!
goto :eof
:WimRoad
set %~1="%~2"
goto :eof

:: ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
:Dil
FOR /F "delims=> tokens=%~2" %%g in ('Findstr /i "%~3" %Lang%') do (set L%~1%~2=%%g)
goto :eof

:LA
FOR /F "delims=> tokens=%~1" %%g in ('Findstr /i "%~2" %Lang%') do (set LA%~1=%%g)
goto :eof

:LB
FOR /F "delims=> tokens=%~1" %%g in ('Findstr /i "%~2" %Lang%') do (set LB%~1=%%g)
goto :eof

:LC
FOR /F "delims=> tokens=%~1" %%g in ('Findstr /i "%~2" %Lang%') do (set LC%~1=%%g)
goto :eof

:LE
cls&echo.&Call :LA 2 Error_%~1_&echo %R%[31m !LA2! %R%[0m&Call :TO 4&set Error=X
goto :eof

:For_Lang
cls
echo.
echo ►%R%[92m Index%R%[33m %~1 - "%~2"%R%[92m !LA2!...%R%[0m
echo.
goto :eof

:: ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
:ProcessCompleted
mode con cols=39 lines=18
echo.
echo            %R%[90m┌───────────────┐%R%[0m
echo            %R%[90m│%R%[32m               %R%[90m│%R%[0m
echo            %R%[90m│%R%[32m          ██   %R%[90m│%R%[0m
echo            %R%[90m│%R%[32m         ██    %R%[90m│%R%[0m
echo            %R%[90m│%R%[32m   ██   ██     %R%[90m│%R%[0m
echo            %R%[90m│%R%[32m    ██ ██      %R%[90m│%R%[0m
echo            %R%[90m│%R%[32m     ███       %R%[90m│%R%[0m
echo            %R%[90m│               %R%[90m│%R%[0m
echo            %R%[90m└───────────────┘%R%[0m
echo.
timeout /t 1 /nobreak > NUL
goto :eof

:: ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
:Language_Select
cls
DEL /F /Q /A %L%\Bing\Logs\Dil > NUL 2>&1
Call :LA 2 Menu_14_&echo.&echo %R%[91m !LA2! %R%[0m&echo.
set Count=0
FOR /F "delims=. tokens=1" %%g in ('dir /b "%L%\Bin\Language\*.cmd" 2^>NUL') do (
	set /a Count+=1
	echo Lang_!Count!_^>%%g^> >> %L%\Bin\Logs\Dil
	echo %R%[32m   !Count! %R%[90m- %R%[33m %%g %R%[0m
)
Call :LA 2 Y0015&echo %R%[32m   X %R%[90m- %R%[37m !LA2! %R%[0m
Call :LA 2 D0001&echo.&set /p Value_M=►%R%[32m !LA2!%R%[90m= %R%[0m
Call :Upper Value_M %Value_M% 
	if %Value_M% EQU X (goto Main_Menu)
FOR /F "delims=> tokens=2" %%g in ('Findstr /i "Lang_!Value_M!_" %L%\Bin\Logs\Dil') do (
	FOR /F "delims=> tokens=2" %%k in ('Findstr /i "Language_Pack" %L%\Settings.ini') do (
		set Lang=%L%\Bin\Language\%%g.cmd
		Call :Powershell "(Get-Content %L%\Settings.ini) | ForEach-Object { $_ -replace '%%k', '%%g' } | Set-Content '%L%\Settings.ini'"
	)
)
goto :eof

:: ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
:AfterSetup
Call :LA 2 Y0027&cls&echo.&echo %R%[92m !LA2! %R%[0m
RD /S /Q "%Mount%\EasyDism_OgnitorenKs" > NUL 2>&1
MD "%Mount%\EasyDism_OgnitorenKs\Setup" > NUL 2>&1
Copy /y "%L%\Bin\NSudo.exe" "%Mount%\EasyDism_OgnitorenKs" > NUL 2>&1
FOR %%g in (bat cmd vbs ps1 exe reg) do (
	FOR /F "tokens=*" %%k in ('dir /b /s %L%\.Script-AfterSetup\*.%%g 2^>NUL') do (
		Copy /y "%%k" "%Mount%\EasyDism_OgnitorenKs\Setup" > NUL 2>&1
	)
)
Call :Regedit_Turn2 "\[HKLM" "[HKEY_LOCAL_MACHINE"
Call :Regedit_Turn2 "\[HKCR" "[HKEY_CLASSES_ROOT"
Call :Regedit_Turn2 "\[HKCU" "[HKEY_CURRENT_USER"
Call :Regedit_Turn2 "\[HKU" "[HKEY_USER"
::
Call :Powershell "Compress-Archive -Path '%L%\.Desktop-AfterSetup\*' -DestinationPath '%Mount%\EasyDism_OgnitorenKs\Desktop.zip'"
::
Call :RegeditInstall
reg add "HKLM\OFF_SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "EasyDism_OgnitorenKs" /t REG_SZ /d "C:\EasyDism_OgnitorenKs\EasyDism.cmd" /f > NUL 2>&1
Call :RegeditCollect
::
Call :Dil A 2 ZZ_1_
Call :Dil B 2 ZZ_2_
Call :Dil B 3 ZZ_2_
Call :Dil C 2 ZZ_3_
Call :Dil C 3 ZZ_3_
Call :Dil D 2 ZZ_4_
Call :Dil D 3 ZZ_4_
Call :Dil E 2 ZZ_5_
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
echo    if %%errorlevel%% NEQ 0 ^(Call :Powershell "Start-Process '%%Konum%%\EasyDism_OgnitorenKs.cmd' -Verb Runas"^&exit^)
echo.
echo Call :Powershell "Set-ExecutionPolicy Unrestricted"
echo :: ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
echo cls^&echo %%R%%[33m !LA2!... %%R%%[0m
echo Call :Powershell "Expand-Archive -Force '%%Konum%%\Desktop.zip' 'C:\Users\%%username%%\Desktop\EasyDism_OgnitorenKs'"
echo DEL /F /Q /A "%%Konum%%\Desktop.zip" ^> NUL 2^>^&1
echo.
echo cls^&echo %%R%%[33m !LB2! %%R%%[0m
echo FOR %%%%a in ^(bat cmd^) do ^(
echo    FOR /R %%Konum%%\EasyDism_OgnitorenKs\Setup\ %%%%b in ^(*.%%%%a^) do ^(
echo        echo %%R%%[37m "%%%%~nxb" !LB3!... %%R%%[0m
echo        "%%Konum%%\NSudo.exe" -U:C -P:E -Wait cmd /c "%%%%b"
echo    ^)
echo ^)
echo FOR /R %%Konum%%\EasyDism_OgnitorenKs\Setup\ %%%%a in ^(*.ps1^) do ^(
echo    echo %%R%%[37m "%%%%~nxa" !LB3!... %%R%%[0m
echo    "%%Konum%%\NSudo.exe" -U:C -P:E -Wait Powershell -file "%%%%a"
echo ^)
echo FOR /R %%Konum%%\EasyDism_OgnitorenKs\Setup\ %%%%a in ^(*.vbs^) do ^(
echo    echo %%R%%[37m "%%%%~nxa" !LB3!... %%R%%[0m
echo    "%%Konum%%\NSudo.exe" -U:C -P:E -Wait cmd /c cscript "%%%%a"
echo ^)
echo cls^&echo %%R%%[33m !LC2! %%R%%[0m
echo FOR /R %%Konum%%\EasyDism_OgnitorenKs\Setup\ %%%%a in ^(*.reg^) do ^(
echo    echo %%R%%[37m "%%%%~nxa" !LC3!
echo    "%%Konum%%\NSudo.exe" -U:T -P:E -Wait -ShowWindowMode:hide cmd /c Reg import "%%%%a"
echo ^)
echo cls^&echo %%R%%[33m !LD2! !LD3!... %%R%%[0m
echo FOR /R %%Konum%%\EasyDism_OgnitorenKs\Setup\ %%%%a in ^(*.exe^) do ^(
echo    echo %%R%%[37m "%%%%~na" !LD3!
echo    "%%%%a" ^> NUL 2^>^&1
echo ^)
echo :: ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
echo Call :Powershell "Set-ExecutionPolicy restricted"
echo cls^&echo.^&echo %%R%%[92m !LE2! %%R%%[0m
echo.
echo ^(
echo echo echo off
echo echo cls
echo echo reg query "HKU\S-1-5-19" ^> NUL 2^>^&1
echo echo   if %%errorlevel%% NEQ 0 ^(Powershell -Command "Start-Process '%%temp%%\EasyDismClear.cmd' -Verb Runas"^&exit^)
echo echo RD /S /Q "%%Konum%%" ^> NUL 2^>^&1
echo echo reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "EasyDism_OgnitorenKs" /f ^> NUL 2^>^&1
echo echo reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "EasyDism_OgnitorenKs_Clear" /f ^> NUL 2^>^&1
echo echo DEL /F /Q /A "%%temp%%\EasyDismClear.cmd" ^> NUL 2^>^&1
echo echo exit
echo ^) ^> %%temp%%\EasyDismClear.cmd
echo.
echo reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "EasyDism_OgnitorenKs" /f ^> NUL 2^>^&1
echo reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "EasyDism_OgnitorenKs_Clear" /t REG_SZ /d "%%temp%%\EasyDismClear.cmd" /f ^> NUL 2^>^&1
echo shutdown -r -f -t 4
echo timeout /t 3 /nobreak ^> NUL
echo exit
) > %Mount%\EasyDism_OgnitorenKs\EasyDism.cmd
goto :eof