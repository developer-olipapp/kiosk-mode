Option Explicit
Dim htmlFilePath

' ==============================================================================
' VVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVV

htmlFilePath = "============================= IDE_IRD_A_HTML_FILE_ELERESI_UTJAT.html ============================="

' AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
' ==============================================================================

Dim objShell, fso, appUrl, profilePath, runCommand
Set objShell = CreateObject("WScript.Shell")
Set fso = CreateObject("Scripting.FileSystemObject")

' 1. Ellenőrizzük, hogy a megadott fájl tényleg létezik-e
If Not fso.FileExists(htmlFilePath) Then
    MsgBox "Hiba! A HTML fájl nem található ezen az útvonalon:" & vbCrLf & vbCrLf & htmlFilePath & vbCrLf & vbCrLf & "Kérlek, ellenőrizd a kódot, hogy pontosan adtad-e meg az elérési utat!", 16, "Fájl nem található"
    WScript.Quit
End If

' 2. A Windows útvonal átalakítása tökéletes böngésző formátumra (URL)
appUrl = Replace(htmlFilePath, "\", "/")
appUrl = "file:///" & appUrl

' 3. Egy elkülönített háttérprofil, hogy egyedi Program ablakként nyíljon meg
profilePath = objShell.ExpandEnvironmentStrings("%TEMP%") & "\Sajat_HTML_Program_Profil"

' 4. A Chrome parancs összeállítása (App mód, fülek és menük nélkül)
runCommand = "chrome.exe --app=""" & appUrl & """ --user-data-dir=""" & profilePath & """"

' 5. Futtatás (A '0' jelenti azt, hogy teljesen némán, fekete ablak nélkül indul)
On Error Resume Next
objShell.Run runCommand, 0, False

' 6. Ha a Chrome parancs hibára futna (mert pl. nincs telepítve), automatikusan Edge-re váltunk
If Err.Number <> 0 Then
    Err.Clear
    runCommand = "msedge.exe --app=""" & appUrl & """ --user-data-dir=""" & profilePath & """"
    objShell.Run runCommand, 0, False
End If