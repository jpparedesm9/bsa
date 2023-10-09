@echo off
cls
title CEN - Creacion de Triggers
echo   ------------------------------------------------------------
echo                           Cobiscorp                    
echo               CREACION DE TRIGGERS DE ADMIN CEN
echo                          COBIS Explorer .NET
echo   ------------------------------------------------------------
setlocal 

set /p user=Login del usuario : 
set /P pass=Password del usuario %user% : 
set /p sybase=Servidor Base de Datos : 

if "%user%"=="" goto error
if "%pass%"=="" goto error
if "%sybase%"=="" goto error


del *.error 2>nul

for %%f in (*.tg) do (
    echo Compilando Trigger: %%f
    sqlcmd  -U%user% -P%pass% -S%sybase% -i%%f -o%%f.error
) 


endlocal

echo Fin de Compilacion de Triggers, revisar los archivos *.error
echo.


