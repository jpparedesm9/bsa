@echo off
rem ***********************************************************************
rem *    ARCHIVO:         full.cmd
rem *    NOMBRE LOGICO:   full.cmd
rem *    PRODUCTO:        COB_CARTERA
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

echo ------ CREANDO OBJETOS DE CARTERA ... ------

echo ------ COB_CARTERA ------

echo ca_dtable.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\ca_dtable.sql  -o %6\ca_dtable.out

echo ca_dtable_his.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\ca_dtable_his.sql  -o %6\ca_dtable_his.out

rem echo cp_dtable.sql
rem sqlcmd -U%1 -P%2 -S%3 -i %5\cp_dtable.sql  -o %6\cp_dtable.out

echo ca_dtype.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\ca_dtype.sql  -o %6\ca_dtype.out

echo ca_dtype_his.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\ca_dtype_his.sql  -o %6\ca_dtype_his.out


echo ca_type.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\ca_type.sql  -o %6\ca_type.out

echo ca_type_his.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\ca_type_his.sql  -o %6\ca_type_his.out

rem echo cp_type.sql
rem sqlcmd -U%1 -P%2 -S%3 -i %5\cp_type.sql  -o %6\cp_type.out

echo ca_table.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\ca_table.sql  -o %6\ca_table.out

echo ca_table_his.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\ca_table_his.sql  -o %6\ca_table_his.out

rem echo cp_table.sql
rem sqlcmd -U%1 -P%2 -S%3 -i %5\cp_table.sql  -o %6\cp_table.out

echo ca_view.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\ca_view.sql  -o %6\ca_view.out

echo ca_function.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\ca_function.sql  -o %6\ca_function.out

echo ca_triggers.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\ca_triggers.sql  -o %6\ca_triggers.out

echo ca_error.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\ca_error.sql  -o %6\ca_error.out

echo ca_perfiles.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\ca_perfiles.sql  -o %6\ca_perfiles.out

echo perfiles_def.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\perfiles_def.sql  -o %6\perfiles_def.out

echo ca_parametros.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\ca_parametros.sql  -o %6\ca_parametros.out

echo ca_catalogo.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\ca_catalogo.sql  -o %6\ca_catalogo.out

echo ca_producto.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\ca_producto.sql  -o %6\ca_producto.out

echo ca_segur.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\ca_segur.sql  -o %6\ca_segur.out

echo ca_batch.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\ca_batch.sql  -o %6\ca_batch.out

echo ca_matriz.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\ca_matriz.sql  -o %6\ca_matriz.out

echo ca_matriz_valor.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\ca_matriz_valor.sql  -o %6\ca_matriz_valor.out

echo ca_eje.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\ca_eje.sql  -o %6\ca_eje.out

echo ca_eje_rango.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\ca_eje_rango.sql  -o %6\ca_eje_rango.out

echo Insertar_formas_pago.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\Insertar_formas_pago.sql  -o %6\Insertar_formas_pago.out

echo Insertar_conceptos.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\Insertar_conceptos.sql  -o %6\Insertar_conceptos.out

echo ca_param_provision.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\ca_param_provision.sql  -o %6\ca_param_provision.out


echo ca_formas_pago.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\ca_formas_pago.sql  -o %6\ca_formas_pago.out

echo ca_tasas.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\ca_tasas.sql  -o %6\ca_tasas.out

echo ca_estados.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\ca_estados.sql  -o %6\ca_estados.out

echo autorizaciones.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\autorizaciones.sql  -o %6\autorizaciones.out

echo servicios_autorizados.sql.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\servicios_autorizados.sql.sql  -o %6\servicios_autorizados.sql.out

echo ca_equivalencias.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\ca_equivalencias.sql  -o %6\ca_equivalencias.out

echo ca_cew_menu.sql.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\ca_cew_menu.sql  -o %6\ca_cew_menu.out

echo ca_cew_menu_auth.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\assets_cew_menu_auth.sql  -o %6\assets_cew_menu_auth.out

echo ca_seqnos.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\ca_seqnos.sql  -o %6\ca_seqnos.out

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
