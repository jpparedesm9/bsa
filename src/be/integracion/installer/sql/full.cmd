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

echo ====== CREACION DE INTERCEPTORES
    sqlcmd -U%1 -P%2 -S%3  -i %5\interceptores.sql  -o %6\interceptores.out

echo ====== CREACION DE TABLAS
    sqlcmd -U%1 -P%2 -S%3  -i %5\table_amortiza.sql  -o %6\table_amortiza.out
	
echo ====== SECCIONES VCC
    sqlcmd -U%1 -P%2 -S%3  -i %5\pac_solidarity_groups_sections_vcc.sql  -o %6\pac_solidarity_groups_sections_vcc.sql.ou

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