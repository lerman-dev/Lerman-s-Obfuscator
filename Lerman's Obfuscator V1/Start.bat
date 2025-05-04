@echo off
color 2
set "LUA_PATH=%CD%\lua\lua54.exe"

if not exist "%LUA_PATH%" (
    echo Error: lua54.exe not found at %LUA_PATH%.
    echo Please ensure the 'lua' folder exists and contains lua54.exe.
    echo You can download Lua 5.4 from http://www.lua.org or https://sourceforge.net/projects/luabinaries/.
    pause
    exit /b 1
)

set "PATH=%PATH%;%CD%\lua"

echo Obfuscating script.lua...
"%LUA_PATH%" obfuscator.lua %1 %2 %3
pause