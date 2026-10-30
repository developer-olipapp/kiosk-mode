Option Explicit
On Error Resume Next

Dim htmlEleresiUt
' =========================================================================================
' VVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVV

htmlEleresiUt = "C:\Users\Papp Olivér János\My projects\Kiosk Mode\MTI_Agenda_Konverter.html"

' AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
' =========================================================================================


Dim fso, shell
Set fso = CreateObject("Scripting.FileSystemObject")
Set shell = CreateObject("WScript.Shell")

' 1. ELLENŐRZÉS: Tényleg létezik-e a HTML fájl a megadott helyen?
If Not fso.FileExists(htmlEleresiUt) Then
    MsgBox "HIBA: Nem található a HTML fájl!" & vbCrLf & vbCrLf & "Ezen az útvonalon kerestem, de nincs itt semmi:" & vbCrLf & htmlEleresiUt & vbCrLf & vbCrLf & "Tipp: Ellenőrizd, hogy nincs-e elírva egy betű, vagy nem rejtette-e el a Windows a .html kiterjesztést!", vbCritical, "Fájl hiba"
    WScript.Quit
End If

' 2. CHROME KERESÉSE: Átkutatjuk a gépet a Chrome pontos helyéért
Dim chromePath, paths, p
paths = Array( _
    shell.ExpandEnvironmentStrings("%ProgramFiles%") & "\Google\Chrome\Application\chrome.exe", _
    shell.ExpandEnvironmentStrings("%ProgramFiles(x86)%") & "\Google\Chrome\Application\chrome.exe", _
    shell.ExpandEnvironmentStrings("%LocalAppData%") & "\Google\Chrome\Application\chrome.exe" _
)

chromePath = ""
For Each p In paths
    If fso.FileExists(p) Then
        chromePath = p
        Exit For
    End If
Next

If chromePath = "" Then
    MsgBox "HIBA: Nem találom a Google Chrome-ot a gépen! Kérlek telepítsd fel.", vbCritical, "Chrome hiba"
    WScript.Quit
End If

' 3. ÚTVONAL ÁTALAKÍTÁSA: Biztonságos URL formátum készítése a böngészőnek
Dim biztonsagosUrl
biztonsagosUrl = Replace(htmlEleresiUt, "\", "/")
biztonsagosUrl = "file:///" & biztonsagosUrl

' 4. PROFIL GENERÁLÁS: Különálló, láthatatlan rendszermappa, hogy független programként nyíljon
Dim profilMappa
profilMappa = shell.ExpandEnvironmentStrings("%TEMP%") & "\SajatChromeApp_" & fso.GetFileName(htmlEleresiUt)

' 5. PARANCS ÖSSZEÁLLÍTÁSA (App mód, idézőjelekkel biztosítva a szóközök ellen)
Dim futtatandoParancs
futtatandoParancs = """" & chromePath & """ --app=""" & biztonsagosUrl & """ --user-data-dir=""" & profilMappa & """"

' 6. INDÍTÁS
shell.Run futtatandoParancs, 1, False

' 7. VÉGSŐ HIBAELLENŐRZÉS
If Err.Number <> 0 Then
    MsgBox "Kritikus hiba történt az indításkor: " & Err.Description, vbCritical, "Végzetes Hiba"
End If