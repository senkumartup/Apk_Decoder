@echo off
Echo.
Echo Apk Decoder 1.0
Echo Copyright © 2013 VinDroidApps, All Rights Reserved.
Echo.
Echo Feedback to vindroidapps@gmail.com
Echo.
Echo.
REM
REM %1 Apk fileName including path
REM %2 Filename without ext
REM %3 Output Folder
REM
Echo Decoding %2.apk into %3
Echo Decoding %2.apk into %3 1>&2
Echo.
Echo.
cd %3
if Not EXIST %2 mkdir %2
cd %2
copy %1 . 1>&2
Echo.
Echo. 1>&2
Echo.
Echo. 1>&2
call apk2java %2.apk
Echo.
Echo. 1>&2
Echo.
Echo. 1>&2
call apktool d %2.apk
CD %3
cd %2
del apktool.bat
del apk2java.bat
rmdir /S /Q lib
xcopy %5 %4 /S
rmdir /S /Q %5
Echo.
Echo. 1>&2
Echo.
Echo. 1>&2
Echo Decoding %2.apk into %3...Done
Echo Decoding %2.apk into %3...Done 1>&2
Echo.
Echo. 1>&2
explorer /select,%6
