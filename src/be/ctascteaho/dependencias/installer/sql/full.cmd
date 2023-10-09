@echo off
rem ***********************************************************************
rem *    ARCHIVO:         full.cmd
rem *    NOMBRE LOGICO:   full.cmd
rem *    PRODUCTO:        COB_AHORROS
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
rem *  30/Jun/2016   wtoledo    Emision Inicial

echo off
if "%1"=="" goto ayuda
if "%2"=="" goto ayuda
if "%3"=="" goto ayuda
if "%4"=="" goto ayuda
if "%5"=="" goto ayuda

if not exist %5\log ( 
md %5\log
)

echo ------ CREANDO OBJETOS DEPENDENCIAS DE CUENTAS DE AHORROS ... ------

echo ------ COB_INTERFACES ------
echo int_dtype.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\int_dtype.sql  -o %6\int_dtype.out

echo ------ CUENTAS DE CORRIENTES ------
echo cc_dtype.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\cc_dtype.sql  -o %6\cc_dtype.out

echo cc_table.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\cc_table.sql  -o %6\cc_table.out

echo cc_view.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\cc_view.sql  -o %6\cc_view.out

echo cc_integrador.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\cc_integrador.sql  -o %6\cc_integrador.out

echo cc_catlgo.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\cc_catlgo.sql  -o %6\cc_catlgo.out

echo cc_param.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\cc_param.sql  -o %6\cc_param.out

echo cc_error.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\cc_error.sql  -o %6\cc_error.out

echo cc_protran.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\cc_protran.sql  -o %6\cc_protran.out

echo cc_traut.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\cc_traut.sql  -o %6\cc_traut.out

echo cc_proc.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\cc_proc.sql  -o %6\cc_proc.out

echo cc_tran.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\cc_tran.sql  -o %6\cc_tran.out

echo cc_seqnos.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\cc_seqnos.sql  -o %6\cc_seqnos.out

echo cc_datosini.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\cc_datosini.sql  -o %6\cc_datosini.out


echo ------ CONTABILIDAD ------
echo cb_dtype.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\cb_dtype.sql  -o %6\cb_dtype.out

echo cb_table.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\cb_table.sql  -o %6\cb_table.out

echo cb_catlgo.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\cb_catlgo.sql  -o %6\cb_catlgo.out

echo cb_protran.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\cb_protran.sql  -o %6\cb_protran.out

echo cb_traut.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\cb_traut.sql  -o %6\cb_traut.out

echo cb_tran.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\cb_tran.sql  -o %6\cb_tran.out

echo cb_proc.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\cb_proc.sql  -o %6\cb_proc.out

echo cb_datosini.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\cb_datosini.sql  -o %6\cb_datosini.out

echo cb_tercero_table.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\cb_tercero_table.sql  -o %6\cb_tercero_table.out

echo cobex_dtype.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\cobex_dtype.sql  -o %6\cobex_dtype.sql.out

echo cobex_table.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\cobex_table.sql  -o %6\cobex_table.sql.out

echo cbccon_dtype.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\cbccon_dtype.sql  -o %6\cbccon_dtype.out

echo cbccon_table.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\cbccon_table.sql  -o %6\cbccon_table.out

echo cbsup_dtype.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\cbsup_dtype.sql  -o %6\cbsup_dtype.out

rem echo cbsup_table.sql
rem sqlcmd -U%1 -P%2 -S%3 -i %5\cbsup_table.sql  -o %6\cbsup_table.out

echo ------ ADMINISTRACION ------
echo adm_catlgo.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\adm_catlgo.sql  -o %6\adm_catlgo.out

echo adm_table.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\adm_table.sql  -o %6\adm_table.out

echo adm_view.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\adm_view.sql  -o %6\adm_view.out

echo adm_param.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\adm_param.sql  -o %6\adm_param.out

echo adm_protran.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\adm_protran.sql  -o %6\adm_protran.out

echo adm_traut.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\adm_traut.sql  -o %6\adm_traut.out

echo adm_proc.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\adm_proc.sql  -o %6\adm_proc.out

echo adm_tran.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\adm_tran.sql  -o %6\adm_tran.out


echo adm_tran.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\adm_datosini.sql  -o %6\adm_datosini.out

echo adm_dtype.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\adm_dtype.sql  -o %6\adm_dtype.out


echo ------ BRANCH ------
echo atx_protran.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\atx_protran.sql  -o %6\atx_protran.out

echo adb_err_dist.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\adb_err_dist.sql  -o %6\adb_err_dist.out

echo ------ FIRMAS ------
echo fi_protran.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\fi_protran.sql  -o %6\fi_protran.out

echo fi_traut.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\fi_traut.sql  -o %6\fi_traut.out


echo ------ MANAGEMENT INFORMATION SYSTEM ------

echo mis_table.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\mis_table.sql  -o %6\mis_table.out

echo mis_catlgo.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\mis_catlgo.sql  -o %6\mis_catlgo.out

echo mis_param.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\mis_param.sql  -o %6\mis_param.out

echo mis_tran.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\mis_tran.sql  -o %6\mis_tran.out

echo mis_proc.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\mis_proc.sql  -o %6\mis_proc.out

echo mis_protran.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\mis_protran.sql  -o %6\mis_protran.out

echo mis_traut.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\mis_traut.sql  -o %6\mis_traut.out


echo cr_catlgo.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\cr_catlgo.sql  -o %6\cr_catlgo.out

echo ------ SERVICIOS BANCARIOS ------
echo sb_proc.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\sb_proc.sql  -o %6\sb_proc.out

echo sb_protran.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\sb_protran.sql  -o %6\sb_protran.out

echo sb_traut.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\sb_traut.sql  -o %6\sb_traut.out


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
