@echo off
set "BROWSER=msedge.exe"

:: Ha Chrome-ot akarsz: set "BROWSER=chrome.exe"

start "" %BROWSER% --app="file:///XXX"

exit