@echo off
rem ***********************************************************************
rem *    ARCHIVO:         full.cmd
rem *    NOMBRE LOGICO:   full.cmd
rem *    PRODUCTO:        COMUNES
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
rem *   Instalacion de Dependencias de cob_cuentas
rem ***********************************************************************
rem *                     MODIFICACIONES
rem *   FECHA        AUTOR      RAZON

echo off
if "%1"=="" goto ayuda
if "%2"=="" goto ayuda
if "%3"=="" goto ayuda
if "%5"=="" goto ayuda
if "%6"=="" goto ayuda

if not exist %5\log ( 
md %5\log
)

echo ------ CREANDO OBJETOS DE COMUNES ... ------

echo ------ COMUNES ------

echo insert_users_rol.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\insert_users_rol.sql  -o %6\insert_users_rol.out

echo update_menu_web.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\update_menu_web.sql  -o %6\update_menu_web.out

echo update_menu_cen.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\update_menu_cen.sql  -o %6\update_menu_cen.out

echo sp_add_functionality_role.sp
sqlcmd -U%1 -P%2 -S%3 -i %5\sp_add_functionality_role.sp  -o %6\sp_add_functionality_role.sp.out

echo roles_auth.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\roles_auth.sql  -o %6\roles_auth.out

echo batch_trn.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\batch_trn.sql  -o %6\batch_trn.out

echo creacion_ofi_usu.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\creacion_ofi_usu.sql  -o %6\creacion_ofi_usu.sql

echo cb_menu_rep.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\cb_menu_rep.sql  -o %6\cb_menu_rep.out

echo Fin del Proceso.....

goto fin

:ayuda
echo full.cmd [parametro 1] [parametro 2] [parametro 3] [parametro 4] [parametro 5] 
echo [parametro 1]: usuario de Sybase
echo [parametro 2]: password del usuario de Sybase
echo [parametro 3]: nombre del servidor Sybase
echo [parametro 4]: directorio de los fuentes
echo [parametro 5]: directorio del log de instalacion
:fin
