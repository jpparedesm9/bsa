ECHO OFF
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

if "%1"=="" goto ayuda
if "%2"=="" goto ayuda
if "%3"=="" goto ayuda
if "%4"=="" goto ayuda
if "%5"=="" goto ayuda

echo Creando Tabla de Parametros de Instalacion
isql -U%1 -P%2 -S%3  < %5\sql\table_installer.sql > %6\table_installer.out
echo Fin Tabla de Parametros de Instalacion

echo Vista Consolidada tablas
isql -U%1 -P%2 -S%3  < %5\sql\pac_admin_tables.sql > %6\pac_admin_tables.out
echo Fin Vista Consolidada tablas

echo Creando Bases de Datos de Productos COBIS
isql -U%1 -P%2 -S%3  < %5\sql\bd_param.sql > %6\bd_param.out
isql -U%1 -P%2 -S%3  < %5\sql\bd_script.sql > %6\bd_script.out
isql -U%1 -P%2 -S%3  < %5\sql\bd_dtype.sql > %6\bd_dtype.out
echo Fin Creacion Base Datos

echo Insertando parches para tablas
isql -U%1 -P%2 -S%3  < %5\sql\pac_parches.sql > %6\pac_parches.out
echo Fin insertando parches para tablas

echo Creando Base de Datos 'cob_pac'
isql -U%1 -P%2 -S%3  < %5\sql\bpl_tables.sql > %6\bpl_tables.out
echo Fin creaciÃ³n base de datos 'cob_pac'

echo Insertando valores iniciales en 'cob_pac'
isql -U%1 -P%2 -S%3  < %5\sql\pac_initial_values.sql > %6\pac_initial_values.out
echo Fin insertando valores iniciales en 'cob_pac'

echo Insertando valores para menus contextuales
isql -U%1 -P%2 -S%3  < %5\sql\pac_menu_vista360.sql > %6\pac_menu_vista360.out
echo Fin insertando valores para menus contextuales

echo Insertando datos de catálogo para la ejecución de servicios
isql -U%1 -P%2 -S%3  < %5\sql\pac_cts_serv_catalog.sql > %6\pac_cts_serv_catalog.out
echo Fin insertando datos de catálogo para la ejecución de servicios

echo Insertando las opciones para vista 360 en menu de CEN
isql -U%1 -P%2 -S%3  < %5\sql\pac_menu_cen.sql > %6\pac_menu_cen.out
echo Fin insertando las opciones para vista 360 en menu de CEN

echo Insertando producto 'Plataforma Comercial' 
isql -U%1 -P%2 -S%3  < %5\sql\pac_producto.sql > %6\pac_producto.out
echo Fin insertando producto 'Plataforma Comercial'

echo Insertando roles autorizados
isql -U%1 -P%2 -S%3  < %5\sql\pac_rol.sql > %6\pac_rol.out
echo Fin insertando roles autorizados

echo Insertando transacciones de la 'Plataforma Comercial'
isql -U%1 -P%2 -S%3  < %5\sql\pac_seguridad.sql > %6\pac_seguridad.out
echo Fin insertando transacciones de la 'Plataforma Comercial'

echo Insertando secuenciales
isql -U%1 -P%2 -S%3  < %5\sql\pac_seqnos.sql > %6\pac_seqnos.out
echo Fin insertando secuenciales

echo Insertando seqnos
isql -U%1 -P%2 -S%3  < %5\sql\seqnos.sql > %6\seqnos.out
echo Fin insertando seqnos

echo Seguridades
isql -U%1 -P%2 -S%3  < %5\sql\menu_cobis5_cen_V2.sql > %6\menu_cobis5_cen_V2.out
echo Fin insertando secuenciales

echo Actualizando menus
isql -U%1 -P%2 -S%3  < %5\sql\pac_update_segcen.sql > %6\pac_update_segcen.out
echo Fin Actualizando menus

echo Vista Consolidada VIEW Asfi
isql -U%1 -P%2 -S%3  < %5\sql\pac_vcc_fie_dml.sql > %6\pac_vcc_fie_dml.sql.out
echo Fin Vista Consolidada VIEW Asfi

echo Autorizando servicios dinámicos
isql -U%1 -P%2 -S%3  < %5\sql\pac_scriptAutorizacionServicios.sql > %6\pac_scriptAutorizacionServicios.out
echo Fin Autorizando servicios dinámicos

echo Ingresando datos para construcción dinámica
isql -U%1 -P%2 -S%3  < %5\sql\pac_scriptServicioDinamico.sql > %6\pac_scriptServicioDinamico.out
echo Fin Ingresando datos para construcción dinámica

echo Ingresando datos para cl_parametro
isql -U%1 -P%2 -S%3  < %5\sql\cl_parametro.sql > %6\cl_parametro.out
echo Fin Ingresando datos para cl_parametro

echo Ingresando datos para vcc_pro_admin
isql -U%1 -P%2 -S%3  < %5\sql\vcc_pro_admin.sql > %6\vcc_pro_admin.out
echo Fin Ingresando datos para vcc_pro_admin

echo Ingresando datos para pac_wf_seguridad
isql -U%1 -P%2 -S%3  < %5\sql\pac_wf_seguridad.sql > %6\pac_wf_seguridad.out
echo Fin Ingresando datos para pac_wf_seguridad

echo Ingresando datos para insertcontainerAndSecurity
isql -U%1 -P%2 -S%3  < %5\sql\insertcontainerAndSecurity.sql> %6\insertcontainerAndSecurity.out
echo Fin Ingresando datos para insertcontainerAndSecurity.sql

echo Ingresando datos para ScriptServicios
isql -U%1 -P%2 -S%3  < %5\sql\ScriptServicios.sql> %6\ScriptServicios.out
echo Fin Ingresando datos para ScriptServicios.sql

echo AdminWeb Menu:
echo SERVICES:
echo Ingresando datos para cew_menu_service_VCC
isql -U%1 -P%2 -S%3  < %5\sql\cew_menu_service_VCC.sql> %6\cew_menu_service_VCC.out
echo TRANSACTIONS:
echo Executing script cew_menu_transaccion_VCC.sql
isql -U%1 -P%2 -S%3  -i %5\sql\cew_menu_transaccion_VCC.sql -o %6\cew_menu_transaccion_VCC.out


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