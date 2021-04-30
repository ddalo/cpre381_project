@echo off
setlocal enabledelayedexpansion
cls
@pushd %~dp0
start SynthesisFramework.exe



::Pause so students can see final output if they are not using the command line
:: use > nul to hide the pause output so we can print our own message
echo Press any key to close . . .
pause > nul

@popd
