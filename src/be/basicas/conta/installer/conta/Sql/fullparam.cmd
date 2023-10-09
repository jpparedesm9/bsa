rem fullparam.cmd
cls
echo off
echo ------------------------------------------------
echo                                  COBISCORP      
echo                          SCRIPTS DE INSTALACION 
echo                              COBIS - SCRIPTS      
echo                             SQL Server 2012      
date /T
time /T
echo ------------------------------------------------


rem set  /P abr_pais=Introduce abreviatura del pais:
rem set 4=cb_param_%abr_pais%.sql

if "%1"=="" goto ayuda
if "%2"=="" goto ayuda
if "%3"=="" goto ayuda
if "%4"=="" goto ayuda

set archivo=cb_param_%4%.sql

:verifica
if exist %archivo% (goto existe) ELSE (goto noexiste)

:existe
if exist Salida_param.out del Salida_param.out
echo ----------------- EJECUTANDO %archivo% ----- >> Salida_param.out
echo -------------------------------------- %archivo% >> Salida_param.out
echo %archivo%
sqlcmd -U%1 -P%2 -S%3 -i %archivo% >> Salida_param.out
echo ----------------- Fin de ejecucion de %archivo% -----
pause
exit


:noexiste
echo El %archivo% NO EXISTE
pause
exit

:ayuda
echo fullparam.cmd [parametro 1] [parametro 2] [parametro 3] [parametro 4] 
echo [parametro 1]: usuario de Sybase
echo [parametro 2]: password del usuario de Sybase
echo [parametro 3]: nombre del servidor Sybase
echo [parametro 4]: Nombre del Archivo
goto verifica