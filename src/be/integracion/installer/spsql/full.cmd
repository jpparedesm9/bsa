ECHO OFF
rem ********************************************************
rem *    ARCHIVO:         full.cmd
rem *    NOMBRE LOGICO:   full.cmd
rem *    PRODUCTO:        Clientes
rem ********************************************************
rem *                     IMPORTANTE
rem *   Esta  aplicacion  es parte de los paquetes bancarios
rem *   propiedad de COBISCorp.
rem *   Su  uso  no autorizado queda  expresamente prohibido 
rem *   asi  como  cualquier alteracion o agregado hecho por  
rem *   alguno  de sus usuarios sin el debido consentimiento 
rem *   por escrito de COBISCorp.
rem *   Este  programa esta protegido por la ley de derechos 
rem *   de  autor  y por las convenciones internacionales de 
rem *   propiedad intelectual. Su uso no autorizado dara de-
rem *   recho a COBISCorp para obtener ordenes de  secuestro
rem *   o retencion y para perseguir penalmente a los autores 
rem *   de cualquier infraccion.
rem ********************************************************
rem *                     PROPOSITO
rem *   Compilacion de estructuras Clientes
rem ********************************************************
rem *                     MODIFICACIONES
rem *   FECHA        AUTOR           RAZON
rem *   06/08/2016   Mta             Emision Inicial
rem ********************************************************

echo off
if "%1"=="" goto ayuda
if "%2"=="" goto ayuda
if "%3"=="" goto ayuda
if "%5"=="" goto ayuda
if "%6"=="" goto ayuda

if not exist %5\log ( 
md %5\log
)

echo ====== sp_deudores_busin
    sqlcmd -U%1 -P%2 -S%3  -i %5\sp_deudores_busin.sp   -o %6\sp_deudores_busin.out

echo ====== sp_divisas_credito_busin
    sqlcmd -U%1 -P%2 -S%3  -i %5\sp_divisas_credito_busin.sp  -o %6\sp_divisas_credito_busin.out

echo ====== sp_in_tramite_busin
    sqlcmd -U%1 -P%2 -S%3 -i %5\sp_in_tramite_busin.sp    -o %6\sp_in_tramite_busin.out

	
echo Fin.

goto fin

:ayuda
echo full.cmd [parametro 1] [parametro 2] [parametro 3] [parametro 4] [parametro 5]
echo donde:
echo [parametro 1]: Login del usuario de la base de datos
echo [parametro 2]: password del usuario de Sybase
echo [parametro 3]: Servidor SQL
echo [parametro 4]: directorio de los fuentes
echo [parametro 5]: directorio del log de instalacion
:fin