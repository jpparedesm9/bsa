ECHO OFF
rem ********************************************************
rem *    ARCHIVO:         full.cmd
rem *    NOMBRE LOGICO:   full.cmd
rem *    PRODUCTO:        MobileIntegration
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
rem *   Compilacion de estructuras MobileIntegration
rem ********************************************************
rem *                     MODIFICACIONES
rem *   FECHA        AUTOR           RAZON
rem *   02/08/2017   Paúl Ortiz      Emision Inicial
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

echo ====== CREACION DE TIPOS DE DATOS
    sqlcmd -U%1 -P%2 -S%3  -i %5\si_type.sql   -o %6\si_type.out

echo ====== INSTALACION DE LOS SERVICIOS
    sqlcmd -U%1 -P%2 -S%3  -i %5\ch_serviceinstallers_cobiscloudsynchronization.sql  -o %6\ch_serviceinstallers_cobiscloudsynchronization.out

echo ====== CREACION DE PARAMETROS
    sqlcmd -U%1 -P%2 -S%3  -i %5\cl_parametro.sql   -o %6\cl_parametro.out

echo ====== INSERCION CATALOGOS
    sqlcmd -U%1 -P%2 -S%3 -i %5\si_catalogo.sql  -o %6\si_catalogo.out

echo ====== INSERCION DE CEW MENU
    sqlcmd -U%1 -P%2 -S%3 -i %5\si_cew_menu.sql -o %6\si_cew_menu.out

echo ====== INSERCION DE CEW MENU RESOURCE
    sqlcmd -U%1 -P%2 -S%3 -i %5\si_cew_resource.sql -o %6\si_cew_resource.out	

echo ====== INSERCION DE CODIGOS DE ERRORES
    sqlcmd -U%1 -P%2 -S%3 -i %5\si_errores.sql  -o %6\si_errores.out

echo ====== INSERCION DE SECUENCIALES SEQNOS
    sqlcmd -U%1 -P%2 -S%3 -i %5\si_seqnos.sql -o %6\si_seqnos.out

echo ====== INSERCION DE SERVICIOS AUTORIZADOS
    sqlcmd -U%1 -P%2 -S%3 -i %5\si_services_authorization.sql -o %6\si_services_authorization.out

echo ====== CREACION DE TABLAS
    sqlcmd -U%1 -P%2 -S%3  -i %5\si_table.sql  -o %6\si_table.out

echo ====== INSERCION DE TRANSACCIONES Y SPs AUTORIZADAS
    sqlcmd -U%1 -P%2 -S%3 -i %5\si_transac.sql  -o %6\si_transac.out


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