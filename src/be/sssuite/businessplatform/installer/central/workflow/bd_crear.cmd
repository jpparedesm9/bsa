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

rem Parametros:
rem %1 - Usuario de Base de Datos
rem %2 - Clave Usuario de Base de Datos
rem %3 - Servidor de SYBASE
rem %4 - Ruta Directorio Log

if '%1'=='' goto ayuda
if '%2'=='' goto ayuda
if '%3'=='' goto ayuda
if '%4'=='' goto ayuda
if '%5'=='' goto ayuda


echo Creando Bases de Datos de Productos COBIS
sqlcmd -U%1 -P%2 -S%3  -i %5\sql\bd_dtype.sql -o %6\bd_dtype.out
sqlcmd -U%1 -P%2 -S%3  -i %5\sql\bd_param.sql -o %6\bd_param.out
sqlcmd -U%1 -P%2 -S%3  -i %5\sql\bd_script.sql -o %6\bd_script.out
echo Fin Creacion Base Datos

echo '===> archivo: bp_tables.sql'
sqlcmd -U%1 -P%2 -S%3 -i %5\sql\bp_tables.sql -o %6\bp_tables.out
echo '==> DUMP DE LA BASE '
sqlcmd -U%1 -P%2 -S%3 -i %5\sql\wf_dump.sql -o %6\wf_dump.out
echo '============================ FIN DEL DUMP '

echo '==> DUMP DE LA BASE '
sqlcmd -U%1 -P%2 -S%3 -i %5\sql\wf_dump.sql -o %6\wf_dump.out
echo '============================ FIN DEL DUMP '

echo ' Creacion de objetos de la bdd '
echo '===> archivo: wf_produ.sql'
sqlcmd -U%1 -P%2 -S%3 -i %5\sql\wf_produ.sql -o %6\wf_produ.out
echo '==> DUMP DE LA BASE '
sqlcmd -U%1 -P%2 -S%3 -i %5\sql\wf_dump.sql -o %6\wf_dump.out
echo '============================ FIN DEL DUMP '

echo ' Creacion de objetos de la bdd '
echo '===> archivo: wf_error.sql'
sqlcmd -U%1 -P%2 -S%3 -i %5\sql\wf_error.sql -o %6\wf_error.out
echo '==> DUMP DE LA BASE '
sqlcmd -U%1 -P%2 -S%3 -i %5\sql\wf_dump.sql -o %6\wf_dump.out
echo '============================ FIN DEL DUMP '

echo '===> archivo: wf_dtype.sql'
sqlcmd -U%1 -P%2 -S%3 -i %5\sql\wf_dtype.sql  -o %6\wf_dtype.out
echo '==> DUMP DE LA BASE '
sqlcmd -U%1 -P%2 -S%3 -i %5\sql\wf_dump.sql -o %6\wf_dump.out
echo '============================ FIN DEL DUMP '

echo '===> archivo: wf_type.sql'
sqlcmd -U%1 -P%2 -S%3 -i %5\sql\wf_type.sql  -o %6\wf_type.out
echo '==> DUMP DE LA BASE '
sqlcmd -U%1 -P%2 -S%3 -i %5\sql\wf_dump.sql -o %6\wf_dump.out
echo '============================ FIN DEL DUMP '

echo '===> archivo: wf_dtable.sql'
sqlcmd -U%1 -P%2 -S%3 -i %5\sql\wf_dtable.sql  -o %6\wf_dtable.out
echo '==> DUMP DE LA BASE '
sqlcmd -U%1 -P%2 -S%3 -i %5\sql\wf_dump.sql -o %6\wf_dump.out
echo '============================ FIN DEL DUMP '

echo '===> archivo: wf_table.sql'
sqlcmd -U%1 -P%2 -S%3 -i %5\sql\wf_table.sql  -o %6\wf_table.out
echo '==> DUMP DE LA BASE '
sqlcmd -U%1 -P%2 -S%3 -i %5\sql\wf_dump.sql -o %6\wf_dump.out
echo '============================ FIN DEL DUMP '

echo '===> archivo: wf_index.sql'
sqlcmd -U%1 -P%2 -S%3 -i %5\sql\wf_index.sql  -o  %6\wf_index.out
echo '==> DUMP DE LA BASE '
sqlcmd -U%1 -P%2 -S%3 -i %5\sql\wf_dump.sql -o %6\wf_dump.out
echo '============================ FIN DEL DUMP '

echo '===> archivo: wf_seqno.sql'
sqlcmd -U%1 -P%2 -S%3 -i %5\sql\wf_seqno.sql  -o %6\wf_seqno.out
echo '==> DUMP DE LA BASE '
sqlcmd -U%1 -P%2 -S%3 -i %5\sql\wf_dump.sql -o %6\wf_dump.out
echo '============================ FIN DEL DUMP '

echo ' Creacion de transacciones de servicio'
echo '===> archivo: wf_rol.sql'
sqlcmd -U%1 -P%2 -S%3 -i %5\sql\wf_rol.sql  -o %6\wf_rol.out
echo '==> DUMP DE LA BASE '
sqlcmd -U%1 -P%2 -S%3 -i %5\sql\wf_dump.sql -o %6\wf_dump.out
echo '============================ FIN DEL DUMP '

echo ' Creacion de parametros del sistema'
echo '===> archivo: wf_segur.sql'
sqlcmd -U%1 -P%2 -S%3 -i %5\sql\wf_segur.sql  -o %6\wf_segur.out
echo '==> DUMP DE LA BASE '
sqlcmd -U%1 -P%2 -S%3 -i %5\sql\wf_dump.sql -o %6\wf_dump.out
echo '============================ FIN DEL DUMP '

rem *echo ' Parametros COBIS Explorer NET'
rem *echo '===> archivo: wf_segcenwf.sql'
rem *sqlcmd -U%1 -P%2 -S%3 -i %5\sql\wf_segcenwf.sql  -o %6\wf_segcenwf.out
rem *echo '==> DUMP DE LA BASE '
rem *sqlcmd -U%1 -P%2 -S%3 -i %5\sql\wf_dump.sql -o %6\wf_dump.out
rem *echo '============================ FIN DEL DUMP '

echo ' Creacion de informacion basica del WF'
echo '===> archivo: wf_ins.sql'
sqlcmd -U%1 -P%2 -S%3 -i %5\sql\wf_ins.sql  -o  %6\wf_ins.out
echo '==> DUMP DE LA BASE '
sqlcmd -U%1 -P%2 -S%3 -i %5\sql\wf_dump.sql -o %6\wf_dump.out
echo '============================ FIN DEL DUMP '

echo ' Transacciones para dll de funcionarios'
echo '===> archivo: wf_auto_func.sql'
sqlcmd -U%1 -P%2 -S%3 -i %5\sql\wf_auto_func.sql  %6\>  wf_auto_func.out
echo '==> DUMP DE LA BASE '
sqlcmd -U%1 -P%2 -S%3 -i %5\sql\wf_dump.sql -o %6\wf_dump.out
echo '============================ FIN DEL DUMP '

echo ' Actualizacion para estandar menu CEN'
echo '===> archivo: wf_update_segcen.sql'
sqlcmd -U%1 -P%2 -S%3 -i %5\sql\wf_update_segcen.sql  %6\>  wf_update_segcen.out
echo '==> DUMP DE LA BASE '
sqlcmd -U%1 -P%2 -S%3 -i %5\sql\wf_dump.sql -o %6\wf_dump.out
echo '============================ FIN DEL DUMP '
rem echo ' Creacion del Alias para la base cob_workflow '
rem echo '===> archivo:  wf_aplalias.sql'
rem sqlcmd -U%1 -P%2 -S%3 -i %5\sql\wf_aplalias.sql  -o %6\wf_aplalias.out

echo ' Creacion de tablas para Scheduler'
echo '===> archivo: sch_tables.sql'
sqlcmd -U%1 -P%2 -S%3 -i %5\sql\sch_tables.sql  -o %6\sch_tables.out
echo '==> DUMP DE LA BASE '
sqlcmd -U%1 -P%2 -S%3 -i %5\sql\wf_dump.sql -o %6\wf_dump.out
echo '============================ FIN DEL DUMP '

echo ' Registro de Servicios para Scheduler'
echo '===> archivo: sch_servicios.sql'
sqlcmd -U%1 -P%2 -S%3 -i %5\sql\sch_servicios.sql  -o %6\sch_servicios.out
echo '==> DUMP DE LA BASE '
sqlcmd -U%1 -P%2 -S%3 -i %5\sql\wf_dump.sql -o %6\wf_dump.out
echo '============================ FIN DEL DUMP '

echo ' Relacion de Confianza para Scheduler'
echo '===> archivo: sch_relacion_confianza.sql'
sqlcmd -U%1 -P%2 -S%3 -i %5\sql\sch_relacion_confianza.sql  -o %6\sch_relacion_confianza.out
echo '==> DUMP DE LA BASE '
sqlcmd -U%1 -P%2 -S%3 -i %5\sql\wf_dump.sql -o %6\wf_dump.out
echo '============================ FIN DEL DUMP '


echo ' Ejecución bp_rules_dependencies.sql'
echo '===> archivo: bp_rules_dependencies.sql'
sqlcmd -U%1 -P%2 -S%3 -i %5\sql\bp_rules_dependencies.sql  -o  %6\bp_rules_dependencies.out
echo '==> DUMP DE LA BASE '
sqlcmd -U%1 -P%2 -S%3 -i %5\sql\bp_dump.sql >> %6\bp_dump.out
echo '============================ FIN DEL DUMP '


echo ' Ejecución bp_rules_admin_security_rol.sql'
echo '===> archivo: bp_rules_admin_security_rol.sql'
sqlcmd -U%1 -P%2 -S%3 -i %5\sql\bp_rules_admin_security_rol.sql  -o  %6\bp_rules_admin_security_rol.out
echo '==> DUMP DE LA BASE '
sqlcmd -U%1 -P%2 -S%3 -i %5\sql\bp_dump.sql >> %6\bp_dump.out
echo '============================ FIN DEL DUMP '

echo ' Seguridad Rules'
echo '===> archivo: bp_segur.sql'
sqlcmd -U%1 -P%2 -S%3 -i %5\sql\bp_segur.sql  -o %6\bp_segur.out
echo '==> DUMP DE LA BASE '
sqlcmd -U%1 -P%2 -S%3 -i %5\sql\wf_dump.sql -o %6\wf_dump.out
echo '============================ FIN DEL DUMP '

echo ' Recursos'
echo '===> archivo: wf_authorization_resources.sql'
sqlcmd -U%1 -P%2 -S%3 -i %5\sql\wf_authorization_resources.sql  -o %6\wf_authorization_resources.out
echo '==> DUMP DE LA BASE '
sqlcmd -U%1 -P%2 -S%3 -i %5\sql\wf_dump.sql -o %6\wf_dump.out
echo '============================ FIN DEL DUMP '


echo ' Servicios Admin WF'
echo '===> archivo: wf_authorization_services.sql'
sqlcmd -U%1 -P%2 -S%3 -i %5\sql\wf_authorization_services.sql  -o %6\wf_authorization_services.out
echo '==> DUMP DE LA BASE '
sqlcmd -U%1 -P%2 -S%3 -i %5\sql\wf_dump.sql -o %6\wf_dump.out
echo '============================ FIN DEL DUMP '


echo ' Transacciones'
echo '===> archivo: wf_seguridad.sql'
sqlcmd -U%1 -P%2 -S%3 -i %5\sql\wf_seguridad.sql  -o %6\wf_seguridad.out
echo '==> DUMP DE LA BASE '
sqlcmd -U%1 -P%2 -S%3 -i %5\sql\wf_dump.sql -o %6\wf_dump.out
echo '============================ FIN DEL DUMP '

echo ' Transacciones'
echo '===> archivo: wf_view.sql'
sqlcmd -U%1 -P%2 -S%3 -i %5\sql\wf_view.sql  -o %6\wf_view.out
echo '==> DUMP DE LA BASE '
sqlcmd -U%1 -P%2 -S%3 -i %5\sql\wf_dump.sql -o %6\wf_dump.out
echo '============================ FIN DEL DUMP '


echo ' Menu plataforma contenedor cobis 5'
echo '===> archivo: sc_mnuPlatform_consolidated.sql'
sqlcmd -U%1 -P%2 -S%3 -i %5\sql\sc_mnuPlatform_consolidated.sql  -o %6\sc_mnuPlatform_consolidated.out
echo '==> DUMP DE LA BASE '
sqlcmd -U%1 -P%2 -S%3 -i %5\sql\wf_dump.sql -o %6\wf_dump.out
echo '============================ FIN DEL DUMP '

echo ' Catalogo Business Rules'
echo '===> archivo: bp_catalog.sql'
sqlcmd -U%1 -P%2 -S%3 -i %5\sql\bp_catalog.sql  -o %6\bp_catalog.out
echo '============================ FIN DEL DUMP '

echo =========================================================
echo LOS PROCEDURE DE WORKFLOW
echo =========================================================
echo INICIO - AUTORIZACION PROCEDURE DE WORKFLOW
echo =========================================================
sqlcmd -U%1 -P%2 -S%3  -i %5\sql\wf_authorization_procedure.sql -o %6\wf_authorization_procedure.sql.out
echo =========================================================
echo FIN - AUTORIZACION PROCEDURE DE WORKFLOW
echo =========================================================

echo 'Instalador de jar en la bdd'

echo =========================================================
echo INICIO - ADMINISTRADOR WEB DE MENU
echo =========================================================
echo AdminWeb Menu:
echo SERVICES:
echo Executing script cew_menu_service_BussinessPlatform_Workflow.sql
sqlcmd -U%1 -P%2 -S%3   -i %5\sql\cew_menu_service_BussinessPlatform_Workflow.sql -o %6\cew_menu_service_BussinessPlatform_Workflow.out

echo Resources and Descriptions for AdminWeb Menu:
echo Executing script cew_menu_resourcesGeneral.sql
sqlcmd -U%1 -P%2 -S%3   -i %5\sql\cew_menu_resourcesGeneral.sql -o %6\cew_menu_resourcesGeneral.out
echo =========================================================
echo FIN  - ADMINISTRADOR WEB DE MENU
echo =========================================================
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