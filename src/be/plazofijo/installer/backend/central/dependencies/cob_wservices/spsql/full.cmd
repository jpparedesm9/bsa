@echo off
rem ********************************************************
rem *    ARCHIVO:         full.cmd             
rem *    NOMBRE LOGICO:   full.cmd             
rem *    PRODUCTO:        COBIS
rem ********************************************************
rem *                     IMPORTANTE           
rem *   Esta aplicacion es parte de los  paquetes bancarios
rem *   propiedad de COBISCORP.                    
rem *   Su uso no autorizado queda  expresamente  prohibido
rem *   asi como cualquier alteracion o agregado hecho  por
rem *   alguno de sus usuarios sin el debido consentimiento
rem *   por escrito de COBISCORP.                 
rem *   Este programa está protegido por la ley de derechos
rem *   de autor y por las convenciones  internacionales de
rem *   propiedad intelectual.  Su uso  no  autorizado dara
rem *   derecho a COBISCORP para obtener ordenes de secuestro
rem *   o  retencion  y  para  perseguir  penalmente a  los
rem *   autores de cualquier infraccion.            
rem ********************************************************
rem *                     PROPOSITO            
rem *   Compilacion de stored procedures modulos   
rem ********************************************************
rem *                     MODIFICACIONES            
rem *   FECHA        AUTOR                  RAZON              
rem *   01/ABR/16    Alfredo Zuluaga        Emision Inicial
rem *                                       VERSION
rem *                                       SQL Server 2012
rem ********************************************************

rem full.cmd
cls
echo off
echo ------------------------------------------------
echo                                  COBISCORP      
echo                          SCRIPTS DE INSTALACION 
echo                              COBIS - SPSQL      
echo                             SQL Server 2012      
date /T
time /T
echo ------------------------------------------------

rem Validacion de Ingreso de Parametros:
rem %1 - Servidor SQL
rem %2 - Login
rem %3 - Password

set ERROR3=%3

if "%ERROR3%" == "" goto ayuda

if "%1" == "" goto ayuda
if "%2" == "" goto ayuda
if "%3" == "" goto ayuda
if "%1" == "?" goto ayuda
if "%2" == "?" goto ayuda
if "%3" == "?" goto ayuda

@echo off
cd .\dependencies\cob_wservices\spsql\
if exist .\log\Salida.out del .\log\Salida.out
if exist .\log\Resultado.out del .\log\Resultado.out

echo ******  COMPILACION DE STORED PROCEDURES W.SERVICES    ******
for /L %%i in (1,1,3) do (
echo Compilacion parte %%i
echo Compilacion parte %%i >> .\log\Resultado.out
if exist .\log\Salida.out del .\log\Salida.out
for %%f in (.\*.sp) do (
     echo Compilando Store Procedure %%f >> .\log\Resultado.out
     echo ----------------------------------------------------- %%f >> .\log\Salida.out           
     osql -U%1 -P%2 -S%3 -n -i %%f >> .\log\Salida.out 
     )
)

echo Fin.
goto fin

:ayuda
echo full.cmd [parametro 1] [parametro 2] [parametro 3]
echo parametro 1: Servidor SQL
echo parametro 2: Login del usuario de la base de datos                        
echo parametro 3: Password del usuario

:fin
