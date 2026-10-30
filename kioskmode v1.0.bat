@echo off
set "BROWSER=msedge.exe"

:: Ha inkább Chrome-ot használnál, töröld a fenti sort, és vedd ki a "::" jelet az alsó sor elől:
:: set "BROWSER=chrome.exe"

start "" %BROWSER% --app="XXXXX"

exit