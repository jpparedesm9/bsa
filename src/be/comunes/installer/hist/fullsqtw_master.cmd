echo off
rem ********************************************************
rem *    ARCHIVO:         fullsqtw_master.cmd			
rem *    NOMBRE LOGICO:   fullsqtw_master.cmd			
rem *    PRODUCTO:        COBIS	
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
rem *   Maestro de Compilacion de SQR's
rem ********************************************************
rem *                     MODIFICACIONES			
rem *   FECHA        AUTOR           RAZON			
rem ********************************************************

if "%1"=="" goto ayuda
if "%2"=="" goto ayuda
if "%3"=="" goto ayuda
if "%4"=="" goto ayuda
if "%5"=="" goto ayuda
if "%6"=="" goto ayuda
if "%7"=="" goto ayuda
if "%8"=="" goto ayuda

echo Copia temporal de los archivos
echo copy /Y %5\*.sqr %7\
copy /Y %5\*.sqr %7\
echo Copia del archivo log.sqr correspondiente
del %7\log.sqr
if %8==VB (
  copy /Y logVB.sqr %7\log.sqr
)
if %8==SG (
  copy /Y logSG.sqr %7\log.sqr
)

SET /a ii=0
for %%i in (%7\*.sqr) do (
    if !ii!==5 (
      echo Ejecutando el dump
      SET /a ii=0
      sqlcmd -U%1 -P%2 -S%3 -n -i dump -o dump.out
    )
    SET /a ii+=1
    echo Compilando %%~ni.sqr
    sqrw -RS -XI -XMB %7\%%~ni.sqr %1/%2 -V%3 -Mvar -I%7\ -E%6\%%~ni.error
    if exist %6\%%~ni.error (
        echo "----- %%~ni.sqr tiene errores, consultar %%~ni.error"
    )
)
echo Eliminacion archivos temporales
del %7\*.sqr

goto fin

:ayuda
echo fullsqtw_master.cmd [parametro 1] [parametro 2] [parametro 3] [parametro 4] [parametro 5] [parametro 6]
echo donde:
echo [parametro 1]: usuario de Sybase
echo [parametro 2]: password del usuario de Sybase
echo [parametro 3]: nombre del servidor Sybase
echo [parametro 4]: nombre del servidor COBIS Central
echo [parametro 5]: directorio de los fuentes
echo [parametro 6]: directorio del log de instalacion
echo [parametro 7]: directorio de los objetos compilados
echo [parametro 8]: tipo de compilacion: VB - Visual Batch, SG - lotes generados por el script shellgen
:fin
