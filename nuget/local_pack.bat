@echo off
for /f "tokens=2 delims==" %%a in ('wmic OS Get localdatetime /value') do set "dt=%%a"
set "YY=%dt:~2,2%" & set "YYYY=%dt:~0,4%" & set "MM=%dt:~4,2%" & set "DD=%dt:~6,2%"
set "HH=%dt:~8,2%" & set "Min=%dt:~10,2%" & set "Sec=%dt:~12,2%"

REM set "datestamp=%YYYY%%MM%%DD%" & set "timestamp=%HH%%Min%%Sec%"
set "fullstamp=%YY%%MM%%DD%%HH%%Min%"
REM echo datestamp: "%datestamp%"
REM echo timestamp: "%timestamp%"
REM echo fullstamp: "%fullstamp%"

set "build=build%fullstamp%"
echo build: "%build%"

dotnet restore ..\src\SignalW.Client
dotnet pack ..\src\SignalW.Client -c DEBUG -o C:\tools\LocalNuget --include-symbols --version-suffix "%build%"
rmdir /s /q ..\src\SignalW.Client\obj

dotnet restore ..\src\SignalW
dotnet pack ..\src\SignalW -c DEBUG -o C:\tools\LocalNuget --include-symbols --version-suffix "%build%"
rmdir /s /q ..\src\SignalW\obj


pause