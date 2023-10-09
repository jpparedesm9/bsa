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

echo Ejecutando script 'BusinessRules_menu_cen.sql'
rem echo patch %4
sqlcmd -U%1 -P%2 -S%3  -i %5\sql\BusinessRules_menu_cen.sql -o %6\BusinessRules_menu_cen.sql.out
echo Ejecutando script 'BusinessRules_menu_cen_rol.sql'
sqlcmd -U%1 -P%2 -S%3  -i %5\sql\BusinessRules_menu_cen_rol.sql -o %6\BusinessRules_menu_cen_rol.sql.out
echo Ejecutando script 'catalogo.sql'
sqlcmd -U%1 -P%2 -S%3  -i %5\sql\catalogo.sql -o %6\catalogo.sql.out
echo Ejecutando script 'cts_serv_catalog.sql'
sqlcmd -U%1 -P%2 -S%3  -i %5\sql\cts_serv_catalog.sql -o %6\cts_serv_catalog.sql.out
echo Ejecutando script 'BusinessRules_update_segcen.sql'
sqlcmd -U%1 -P%2 -S%3  -i %5\sql\BusinessRules_update_segcen.sql -o %6\BusinessRules_update_segcen.sql.out
echo Ejecutando script 'bpl_authorization_resources.sql'
sqlcmd -U%1 -P%2 -S%3  -i %5\sql\bpl_authorization_resources.sql -o %6\bpl_authorization_resources.sql.out

echo AdminWeb Menu:
echo SERVICES:
echo Executing script cew_menu_service_BussinessPlatform_BusinessRules.sql
sqlcmd -U%1 -P%2 -S%3  -i %5\sql\cew_menu_service_BussinessPlatform_BusinessRules.sql -o %6\cew_menu_service_BussinessPlatform_BusinessRules.out

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
