#SingleInstance,Force
#NoEnv

SetWorkingDir, %A_ScriptDir%

applicationname=DecodeAPK
Gui, Add, Picture, x10 y10 w96 h96, APK_format_icon.png
Gui, Add, Text, x116 y10 w275 h13 , Android Application Package(APK) fileName
Gui, Add, Edit, WantCtrlA r1 vApkName x116 y28 w374 h20 ,
Gui, Add, Button, x415 y54 w75 h20 , &Open...
Gui, Add, Text, x116 y84 w275 h13 , Decode Android Application Package to
StringGetPos, pos, A_ScriptDir, %A_Space%
if pos >= 0
Gui, Add, Edit, WantCtrlA r1 vApkDcdFldr x116 y102 w374 h20, c:\output
else
Gui, Add, Edit, WantCtrlA r1 vApkDcdFldr x116 y102 w374 h20, %A_ScriptDir%\output
Gui, Add, Button, x415 y128 w75 h20 , &Browse...
Gui, Add, Button, default WantReturn x207 y168 w75 h23 , &Decode
Gui, Add, Button, x292 y168 w75 h23 , &Close

Gui,Add,Text,x10 y+10,This GUI tool was developed by VinDroidApps. Get VinDroidApps from Google Play
Gui,Font,CBlue Underline
Gui,Add,Text,y+5 GVinDroidApps,https://play.google.com/store/apps/developer?id=Vindroidapps
Gui,Font
Menu,Tray,NoStandard 
Menu,Tray,DeleteAll 
Menu,Tray,Tip,%applicationname%
Menu, Tray, Icon, decode_apk.ico

if strLen(1) > 0
    GuiControl,Text, ApkName, %1%

Gui, Show, AutoSize Center, Decode Android Application Package
Return

ButtonOpen...:
FileSelectFile, SelectedFile, 1, , Select Android Application Package(APK) file to decode, Android Application Package (*.apk)
if StrLen(SelectedFile) > 0
    GuiControl,Text, ApkName, %SelectedFile%
Return

ButtonBrowse...:
FileSelectFolder, OutputVar, , 0, Decode Android Application Package to
if StrLen(OutputVar) > 0
    GuiControl,Text, ApkDcdFldr, %OutputVar%
Return

ButtonDecode:
guiControlGet, ApkNameVal, , ApkName
guiControlGet, ApkDcdFldrVar, , ApkDcdFldr

if strLen(ApkNameVal) = 0 {
    MsgBox ,48, No APK to decode, Error#101: No APK selected.`n`nPlease choose an Android Application Package(APK) to decode.
    Return
}

IfNotExist, %ApkNameVal%
{
    MsgBox, 16, APK not exists, Error#102: %ApkNameVal% not found.`n`nPlease choose an existing Android Application Package(APK) to decode.
    Return
}

if strLen(ApkDcdFldrVar) = 0 {
    MsgBox ,48, No output folder, Error#103: No output folder.`n`nPlease Browse an Output folder into which Android Application Package(APK) will be decoded.
    Return
}

StringGetPos, pos, ApkDcdFldrVar, %A_Space%
if pos >= 0
{
    MsgBox, 48, Invalid Output folder, Error#104: %ApkDcdFldrVar% contains space which is not supported.`n`nPlease Browse a different output folder into which Android Application Package(APK) will be decoded.
    Return
}

Loop
{
    IfNotExist, %ApkDcdFldrVar%
    {
        MsgBox, 534, Output folder not exists, Error#105: %ApkDcdFldrVar% not exists`n`nPlease choose an existing folder to Decode Android Application Package into.`n`nChoose [Continue] to create %ApkDcdFldrVar% folder and proceed.

        IfMsgBox, Cancel
            Return

        IfMsgBox Continue
        {
            FileCreateDir, %ApkDcdFldrVar%
            break
        }
    }
    else
        break
}

SplitPath, ApkNameVal,,,, ApkNameOnlyVal
FileRemoveDir, %ApkDcdFldrVar%\%ApkNameOnlyVal%, 1
FileCopyDir, %A_ScriptDir%\bin, %ApkDcdFldrVar%\%ApkNameOnlyVal%, 1
Run "%A_ScriptDir%\decode_apk.bat" "%ApkNameVal%" "%ApkNameOnlyVal%" "%ApkDcdFldrVar%" "%ApkDcdFldrVar%\%ApkNameOnlyVal%" "%ApkDcdFldrVar%\%ApkNameOnlyVal%\%ApkNameOnlyVal%" "%ApkDcdFldrVar%\%ApkNameOnlyVal%\src"

Return

VinDroidApps:
  Run, https://play.google.com/store/apps/developer?id=Vindroidapps,,UseErrorLevel
Return

GuiEscape:
GuiClose:
ButtonClose:
Gui, Destroy
ExitApp
