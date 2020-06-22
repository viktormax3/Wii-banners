@echo off

REM Path to the Layout Binary Converter
set LYTCVTR=%NW4R_ROOT%\CommandLineTools\bin\nw4r_lytcvtr.exe
REM Major version of the Layout Binary Converter
set LYTCVTRVER=2
REM Banner mode option for the Layout Binary Converter
set LYTCVTRBNROPT=--banner

REM Determine which line of the Layout Binary Converter's output contains
REM version information, and extract the major version value.
for /F "skip=1 tokens=1,2" %%i in ('%LYTCVTR% 2^> nul') do if "%%i"  == "Version" for /F "delims=." %%k in ("%%j") do set LYTCVTRVER=%%k

REM Clear the banner mode option when the major version is zero
if "%LYTCVTRVER%" == "0" set LYTCVTRBNROPT=

IF EXIST arc rmdir /s /q arc

mkdir arc
%LYTCVTR% -g %LYTCVTRBNROPT% --omit-samekey banner\layout arc
IF EXIST arc\fnta rmdir /s /q arc\fnta
%REVOLUTION_SDK_ROOT%\X86\bin\darchD.exe -c arc banner.arc
rmdir /s /q arc

mkdir arc
%LYTCVTR% --banner icon\layout arc
IF EXIST arc\fnta rmdir /s /q arc\fnta
%REVOLUTION_SDK_ROOT%\X86\bin\darchD.exe -c arc icon.arc
rmdir /s /q arc

%REVOLUTION_SDK_ROOT%\X86\bin\WiiMakeBanner.exe banner.cfg.txt -o opening.bnr
