@echo off
chcp 65001 >nul

:: IDE ÍRD A FÁJLOD PONTOS ELÉRÉSI ÚTJÁT (Az idézőjelek maradjanak!):
set "C:\Users\Papp Olivér János\My projects\Kiosk Mode\MTI_Agenda_Konverter.html"


:: -------------------------------------------------------------
:: INNENTŐL KEZDŐDIK A KÓD - NE MÓDOSÍTS SEMMIT!
:: -------------------------------------------------------------
set "URL=file:///%UTVONAL:\=/%"
set "PROFIL=%TEMP%\ChromeProgramApp"

start "" chrome.exe --app="%URL%" --user-data-dir="%PROFIL%"
exit