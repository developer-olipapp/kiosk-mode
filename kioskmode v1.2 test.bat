@echo off
:: ==========================================================================
:: VVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVV

set "HTML_FILE=C:\Users\Papp Olivér János\My projects\Kiosk Mode\MTI_Agenda_Konverter.html"

:: AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
:: ==========================================================================


:: INNENTOL NE MODOSITS SEMMIT! A KOD AUTOMATIKUSAN MEGOLDJA A FORMATUMOT:
for %%I in ("%HTML_FILE%") do set "FULL_PATH=%%~fI"
set "FULL_PATH=%FULL_PATH:\=/%"

:: Egy különálló ideiglenes profilt használunk, hogy a futó böngésző ne zavarjon be,
:: és garantáltan menük nélküli "App" ablakként nyíljon meg!
start "" msedge.exe --app="file:///%FULL_PATH%" --user-data-dir="%TEMP%\Sajat_HTML_Programom"

exit