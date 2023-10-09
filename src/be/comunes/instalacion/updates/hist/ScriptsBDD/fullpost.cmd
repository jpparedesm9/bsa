@echo off
rem ***********************************************************************
rem *    ARCHIVO:         fullpost.cmd
rem *    NOMBRE LOGICO:   fullpost.cmd
rem *    PRODUCTO:        COBIS
rem ***********************************************************************
rem *                     IMPORTANTE
rem * Esta aplicacion es parte de los paquetes bancarios propiedad       
rem * de COBISCorp.                                                      
rem * Su uso no    autorizado queda  expresamente   prohibido asi como   
rem * cualquier    alteracion o  agregado  hecho por    alguno  de sus   
rem * usuarios sin el debido consentimiento por   escrito de COBISCorp.  
rem * Este programa esta protegido por la ley de   derechos de autor     
rem * y por las    convenciones  internacionales   de  propiedad inte-   
rem * lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para
rem * obtener ordenes  de secuestro o  retencion y para  perseguir       
rem * penalmente a los autores de cualquier   infraccion.                
rem ***********************************************************************
rem *                     PROPOSITO
rem *   Instalacion de data inicial posterior a la instalacion de ADMIN-ADMINCEN
rem ***********************************************************************
rem *                     MODIFICACIONES
rem *   FECHA        AUTOR      RAZON
rem *  05/Sep/2016   AGO        Emision Inicial

echo off
if "%1"=="" goto ayuda
if "%2"=="" goto ayuda
if "%3"=="" goto ayuda
if "%4"=="" goto ayuda
if "%5"=="" goto ayuda

if not exist %4\log ( 
md %4\log
)

echo ------ ACTUALIZANDO LOGINES DE BASES DE DATOS... ------
echo create_login_rol.sql
sqlcmd -U%1 -P%2 -S%3 -i %4\create_login_rol.sql  -o %5\create_login_rol.out

echo datos_ini_admin.sql 
sqlcmd -U%1 -P%2 -S%3 -i %4\datos_ini_admin.sql   -o %5\datos_ini_admin.out

echo oficinas.sql
sqlcmd -U%1 -P%2 -S%3 -i %4\oficinas.sql   -o %5\oficinas.sql.out

echo Fin del Proceso.....

goto fin

:ayuda
echo full.cmd [parametro 1] [parametro 2] [parametro 3] [parametro 4] [parametro 5] 
echo [parametro 1]: usuario de SQLserver
echo [parametro 2]: password del usuario de SQLserver
echo [parametro 3]: nombre del servidor SQLserver
echo [parametro 4]: directorio de los fuentes
echo [parametro 5]: directorio del log de instalacion
:fin
