@echo off
rem ********************************************************
rem *    ARCHIVO:         bd_crear.cmd			
rem *    NOMBRE LOGICO:   bd_crear.cmd			
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
rem *   Creacion de Bases de Datos productos COBIS
rem ********************************************************
rem *                     MODIFICACIONES			
rem *   FECHA        AUTOR           RAZON			
rem ********************************************************

if '%1'=='' goto ayuda
if '%2'=='' goto ayuda
if '%3'=='' goto ayuda
if '%4'=='' goto ayuda
if '%5'=='' goto ayuda

echo Ejecutando script 'mon_alter_tables.sql'
sqlcmd -U%1 -P%2 -S%3  -i %5\sql\mon_alter_tables.sql -o %6\mon_alter_tables.sql.out
echo Ejecutando script 'mon_cts_serv_catalog.sql'
sqlcmd -U%1 -P%2 -S%3  -i %5\sql\mon_cts_serv_catalog.sql -o %6\mon_cts_serv_catalog.sql.out
echo Ejecutando script 'mon_menu_cen.sql'
sqlcmd -U%1 -P%2 -S%3  -i %5\sql\mon_menu_cen.sql -o %6\mon_menu_cen.sql.out
echo Ejecutando script 'mon_menu_cen_rol.sql'
sqlcmd -U%1 -P%2 -S%3  -i %5\sql\mon_menu_cen_rol.sql -o %6\mon_menu_cen_rol.sql.out
echo Ejecutando script 'mon_seguridad.sql'
sqlcmd -U%1 -P%2 -S%3  -i %5\sql\mon_seguridad.sql -o %6\mon_seguridad.sql.out
echo Ejecutando script 'mon_rol.sql'
sqlcmd -U%1 -P%2 -S%3  -i %5\sql\mon_rol.sql -o %6\mon_rol.sql.out
echo Ejecutando script 'mon_update_segcen.sql'
sqlcmd -U%1 -P%2 -S%3  -i %5\sql\mon_update_segcen.sql -o %6\mon_update_segcen.out

echo AdminWeb Menu:
echo SERVICES:
echo Executing script cew_menu_service_BussinessPlatform_WorkflowMonitor.sql
sqlcmd -U%1 -P%2 -S%3  -i %5\sql\cew_menu_service_BussinessPlatform_WorkflowMonitor.sql -o %6\cew_menu_service_BussinessPlatform_WorkflowMonitor.out

goto fin

:ayuda
echo Uso bd_crear.cmd [parametro 1] [parametro 2] [parametro 3] [parametro 4] [parametro 5]
echo donde:
echo [parametro 1]: usuario de Sybase
echo [parametro 2]: password del usuario de Sybase
echo [parametro 3]: nombre del servidor Sybase
echo [parametro 4]: directorio de los fuentes
echo [parametro 5]: directorio del log de instalacion
echo ******************************************************************************
:fin
