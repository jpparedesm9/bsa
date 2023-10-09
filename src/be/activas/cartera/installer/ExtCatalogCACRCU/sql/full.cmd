@echo off
rem ***********************************************************************
rem *    ARCHIVO:         full.cmd
rem *    NOMBRE LOGICO:   full.cmd
rem *    PRODUCTO:        ePointManager             
rem ***********************************************************************
rem *                     PROPOSITO
rem *   
rem ***********************************************************************
rem *                     MODIFICACIONES
rem *   FECHA        AUTOR      RAZON
rem *  DIC/22/2016   jbaque    Emision Inicial
rem *  
rem ***********************************************************************

echo off
if "%1"=="" goto ayuda
if "%2"=="" goto ayuda
if "%3"=="" goto ayuda
if "%4"=="" goto ayuda
if "%5"=="" goto ayuda

if not exist %4\log ( 
md %4\log
)
echo ------ EJECUTANDO catalogo_out.sql ... ------
echo catalogo_out.sql
sqlcmd -U%1 -P%2 -S%3 -i %4\catalogo_out.sql  -o %5\catalogo_out.out

echo ------ EJECUTANDO catalogo_in.sql ... ------
echo catalogo_in.sql
sqlcmd -U%1 -P%2 -S%3 -i %4\catalogo_in.sql  -o %5\catalogo_in.out

echo Fin del Proceso.....

goto fin

:ayuda
echo full.cmd [parametro 1] [parametro 2] [parametro 3] [parametro 4] [parametro 5] 
echo [parametro 1]: usuario de SQLServer
echo [parametro 2]: password del usuario de SQLServer
echo [parametro 3]: nombre del servidor SQLServer
echo [parametro 4]: directorio de los fuentes
echo [parametro 5]: directorio del log de instalacion
:fin
