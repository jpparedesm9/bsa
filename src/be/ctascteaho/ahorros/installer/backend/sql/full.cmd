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
rem *   Instalacion general de COB_AHORROS BackEnd Central
rem ***********************************************************************
rem *                     MODIFICACIONES
rem *   FECHA        AUTOR      RAZON
rem *  06/May/2016   wtoledo    Emision Inicial

echo off
if "%1"=="" goto ayuda
if "%2"=="" goto ayuda
if "%3"=="" goto ayuda
if "%4"=="" goto ayuda
if "%5"=="" goto ayuda

if not exist %5\log ( 
md %5\log
)

echo ------ CREANDO OBJETOS DE CUENTAS DE AHORROS ... ------
echo ah_dropf.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\ah_dropf.sql  -o %6\ah_dropf.out

echo ah_dropp.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\ah_dropp.sql  -o %6\ah_dropp.out

echo ah_dropv.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\ah_dropv.sql  -o %6\ah_dropv.out

echo ah_dropt.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\ah_dropt.sql  -o %6\ah_dropt.out

echo ah_dtype.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\ah_dtype.sql  -o %6\ah_dtype.out

echo ah_ddefau.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\ah_ddefau.sql -o %6\ah_ddefau.out

echo ah_defau.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\ah_defau.sql  -o %6\ah_defau.out

echo ah_table.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\ah_table.sql  -o %6\ah_table.out

echo ah_his_table.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\ah_his_table.sql  -o %6\ah_his_table.out

echo ah_trmon.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\ah_trmon.sql  -o %6\ah_trmon.out

echo ah_trser.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\ah_trser.sql  -o %6\ah_trser.out

echo ah_pkey.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\ah_pkey.sql  -o %6\ah_pkey.out

echo ah_fkey.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\ah_fkey.sql  -o %6\ah_fkey.out

echo ah_error.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\ah_error.sql  -o %6\ah_error.out

echo ah_conta.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\ah_conta.sql  -o %6\ah_conta.out

echo ah_view.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\ah_view.sql  -o %6\ah_view.out

echo ------ SEGURIDADES DE CUENTAS DE AHORROS ... ------ 

echo ah_catlgo.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\ah_catlgo.sql -o %6\ah_catlgo.out

echo ah_param.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\ah_param.sql -o %6\ah_param.out

echo ah_seqnos.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\ah_seqnos.sql -o %6\ah_seqnos.out

echo ah_producto.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\ah_producto.sql -o %6\ah_producto.out

echo ah_tran.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\ah_tran.sql -o %6\ah_tran.out

echo ah_proc.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\ah_proc.sql -o %6\ah_proc.out

echo ah_protran.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\ah_protran.sql -o %6\ah_protran.out

echo ah_traut.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\ah_traut.sql -o %6\ah_traut.out

echo ah_datosini.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\ah_datosini.sql -o %6\ah_datosini.out

echo ------ BATCH DE CUENTAS DE AHORROS ... ------ 

echo ah_batch.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\ah_batch.sql -o %6\ah_batch.out

echo batch_datosini.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\batch_datosini.sql -o %6\batch_datosini.out

echo borrado_menu_cta.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\borrado_menu_cta.sql -o %6\borrado_menu_cta.out

echo menu_atencionCliente_conrol.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\menu_atencionCliente_conrol.sql -o %6\menu_atencionCliente_conrol.out

echo menu_mantProd_conrol.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\menu_mantProd_conrol.sql -o %6\menu_mantProd_conrol.out

echo menu-backOffice-conrol.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\menu-backOffice-conrol.sql -o %6\menu-backOffice-conrol.out

echo menu_dependencias.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\menu_dependencias.sql -o %6\menu_dependencias.out

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
