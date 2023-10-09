Cls
@echo off
REM ***********************************************************
REM *       ARCHIVO      : full.cmd
REM *       NOMBRE LOGICO: full.cmd
REM *       PRODUCTO     : ACTIVAS
REM ***********************************************************
REM *                       PROPOSITO
REM *    SE ENCARGA DE LA INSTALACION DEL BACKEND DE CLIENTES
REM ***********************************************************
REM *                     MODIFICACIONES
REM *    FECHA          AUTOR            RAZON
REM *  OCT/10/2016    J. BAQUE      EMISION INICIAL
REM *
REM ***********************************************************
if "%1"=="" goto ayuda
if "%2"=="" goto ayuda
if "%3"=="" goto ayuda


REM ****************************SQL******************************
echo ------ EJECUCION DE SQL PARAMETRIA ... ------
@echo off 
call .\sql\full.cmd %1 %2 %3 .\sql\ .\sql\log\
echo ------ FIN EJECUCION DE SQL ... ------


echo Fin del Proceso.....

goto fin

:ayuda
echo full.cmd [parametro 1] [parametro 2] [parametro 3] [parametro 4] [parametro 5] [parametro 6]
echo donde:
echo [parametro 1]: usuario de SQLServer
echo [parametro 2]: password del usuario de SQLServer
echo [parametro 3]: nombre del servidor SQLServer
:fin

