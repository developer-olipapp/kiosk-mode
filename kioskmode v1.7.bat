@echo off
if "%~1"=="" (
    msg * "HIBA! Ne duplan kattints erre a fajlra! Fogd meg az egerrel a HTML fajlodat, es HUZD RA ERRE a fajlra!"
    exit
)

set "FILE_PATH=%~1"
set "FILE_PATH=%FILE_PATH:\=/%"

start "" chrome.exe --app="file:///%FILE_PATH%" --user-data-dir="%TEMP%\SajatApp"
exit