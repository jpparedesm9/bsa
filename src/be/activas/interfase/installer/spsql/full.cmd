@echo off
rem ********************************************************
rem *    ARCHIVO:         full.cmd			
rem *    NOMBRE LOGICO:   full.cmd			
rem *    PRODUCTO:        Prueba deposito
rem ********************************************************
rem *                     IMPORTANTE			
rem *   Esta aplicacion es parte de los  paquetes bancarios
rem *   propiedad de MACOSA S.A.				
rem *   Su uso no autorizado queda  expresamente  prohibido
rem *   asi como cualquier alteracion o agregado hecho  por
rem *   alguno de sus usuarios sin el debido consentimiento
rem *   por escrito de MACOSA. 				
rem *   Este programa esta protegido por la ley de derechos
rem *   de autor y por las convenciones  internacionales de
rem *   propiedad intelectual.  Su uso  no  autorizado dara
rem *   derecho a MACOSA para obtener ordenes  de secuestro
rem *   o  retencion  y  para  perseguir  penalmente a  los
rem *   autores de cualquier infraccion.			
rem ********************************************************
rem *                     PROPOSITO			
rem *   Compilacion de stored procedures de Admin Branch   
rem ********************************************************
rem *                     MODIFICACIONES			
rem *   FECHA        AUTOR                  RAZON			
rem *   03/ENE/01    Roberth Minga Vallejo  Emision Inicial
rem *   04/Abr/08    A. Correa		    Version SQL2005
rem *   20/feb/09    M.Bernal               Actualizacion
rem ********************************************************

rem Validacion de Ingreso de Parametros:
rem %1 - Servidor SQL
rem %2 - Login
rem %3 - Password

echo off

if "%1"=="" goto ayuda
if "%2"=="" goto ayuda
if "%3"=="" goto ayuda
if "%4"=="" goto ayuda
if "%5"=="" goto ayuda
echo off
if exist %5\*.error (
  del %5\*.error
)
if not exist %4\log ( 
md %4\log
)
set contador=0
for %%i in (%4\*.sp) do (
  echo iniciando > %5\%%~ni.error
  set /a contador+=1
)
for %%j in (1 2 3) do (
    for %%k in (%5\*.error) do (
        echo Ejecutando %%~nk.sp
        del %5\%%~nk.error
        sqlcmd -U%1 -P%2 -S%3 -n -i %4\%%~nk.sp -o %5\%%~nk.error
        for /F %%l in (%5\%%~nk.error) do (
            echo ERROR ... > %5\%%~nk.error2
        )
        if not exist %5\%%~nk.error2 (
            del %5\%%~nk.error
        ) else (
            echo ----- %%~nk.sp tiene errores
            del %5\%%~nk.error2
        )
    )
)
goto fin

:ayuda
echo full.cmd [parametro 1] [parametro 2] [parametro 3]  [parametro 5] [parametro 6]
echo donde:
echo [parametro 1]: usuario de Sybase
echo [parametro 2]: password del usuario de Sybase
echo [parametro 3]: nombre del servidor Sybase
echo [parametro 4]: directorio de los fuentes
echo [parametro 5]: directorio del log de instalacion
:fin
