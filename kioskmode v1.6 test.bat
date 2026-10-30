@echo off
chcp 65001 >nul

:: =========================================================================
:: IDE IRD A HTML FAJLOD NEVET (Ne az eleresi utat, CSAK A NEVET!)
:: Ha atnevezted index.html-re, akkor ezen a soron NEM KELL MODOSITANOD SEMMIT!
set "FAJLNEV=MTI_Agenda_Konverter.html"
:: =========================================================================

:: A script automatikusan megkeresi a pontos eleresi utat
set "TELJES_UTVONAL=%~dp0%FAJLNEV%"

:: Ellenőrizzük, hogy tényleg ott van-e a fájl
if not exist "%TELJES_UTVONAL%" (
    echo.
    echo ---------------------------------------------------------
    echo HIBA: Nem talalhato a(z) "%FAJLNEV%" nevu fajl!
    echo.
    echo Kereslek ellenorizd, hogy ez a .bat fajl es a HTML fajl
    echo PONTOSAN UGYANABBAN A MAPPABAN van-e egymás mellett!
    echo ---------------------------------------------------------
    echo.
    pause
    exit
)

:: Futtatas Chrome App modban
set "URL=file:///%TELJES_UTVONAL:\=/%"
set "PROFIL=%TEMP%\ChromeAppProfil"

start "" chrome.exe --app="%URL%" --user-data-dir="%PROFIL%"
exit