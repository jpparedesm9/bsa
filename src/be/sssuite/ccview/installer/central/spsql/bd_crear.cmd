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

mkdir %4\spsqlOut
echo Compilando procedimiento almacenado 'sp_admin_vcc.sp'
isql -U%1 -P%2 -S%3  < "spsql\sp_admin_vcc.sp" > "%4\spsqlOut\sp_admin_vcc.sp.out"
echo Compilando procedimiento almacenado 'sp_compania_cons_vcc.sp'
isql -U%1 -P%2 -S%3  < "spsql\sp_compania_cons_vcc.sp" > "%4\spsqlOut\sp_compania_cons_vcc.sp.out"
echo Compilando procedimiento almacenado 'sp_persona_cons_vcc.sp'
isql -U%1 -P%2 -S%3  < "spsql\sp_persona_cons_vcc.sp" > "%4\spsqlOut\sp_persona_cons_vcc.sp.out"
echo Compilando procedimiento almacenado 'sp_query_bp_views.sp'
isql -U%1 -P%2 -S%3  < "spsql\sp_query_bp_views.sp" > "%4\spsqlOut\sp_query_bp_views.sp.out"
echo Compilando procedimiento almacenado 'sp_se_ente_vcc.sp'
isql -U%1 -P%2 -S%3  < "spsql\sp_se_ente_vcc.sp" > "%4\spsqlOut\sp_se_ente_vcc.sp.out"

