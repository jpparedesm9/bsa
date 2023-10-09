@echo off
rem ***********************************************************************
rem *    ARCHIVO:         full.cmd
rem *    NOMBRE LOGICO:   full.cmd
rem *    PRODUCTO:        COB_CUSTODIA
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
rem *   Instalacion de objetos de cob_custodia
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

echo ------ CREANDO OBJETOS DE GARANTIAS ... ------

echo ------ COB_CUSTODIA ------

echo cu_dtable.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\cu_dtable.sql  -o %6\cu_dtable.out

echo cu_type.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\cu_type.sql  -o %6\cu_type.out

echo cu_table.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\cu_table.sql  -o %6\cu_table.out

echo cr_view.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\cu_view.sql  -o %6\cu_view.out

echo cu_function.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\cu_function.sql  -o %6\cu_function.out

echo cu_seqnos.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\cu_seqnos.sql  -o %6\cu_seqnos.out

echo cu_parametriza.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\cu_parametriza.sql  -o %6\cu_parametriza.out

echo cu_catalogos.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\cu_catalogos.sql  -o %6\cu_catalogos.out

echo cu_param.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\cu_param.sql  -o %6\cu_param.out

echo cu_transac.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\cu_transac.sql  -o %6\cu_transac.out

echo cu_errores.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\cu_errores.sql  -o %6\cu_errores.out

echo cu_sarta.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\cu_sarta.sql  -o %6\cu_sarta.out

echo cu_batch.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\cu_batch.sql  -o %6\cu_batch.out

echo cu_sarta_batch.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\cu_sarta_batch.sql  -o %6\cu_sarta_batch.out

echo cu_parametro.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\cu_parametro.sql  -o %6\cu_parametro.out

echo cu_enlace.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\cu_enlace.sql  -o %6\cu_enlace.out

echo cu_producto.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\cu_producto.sql  -o %6\cu_producto.out

echo cu_tipo_custodia.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\cu_tipo_custodia.sql  -o %6\cu_tipo_custodia.out

echo cu_item.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\cu_item.sql  -o %6\cu_item.out

echo cu_colac_adic.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\cu_colac_adic.sql  -o %6\cu_colac_adic.out

echo cu_estados.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\cu_estados.sql  -o %6\cu_estados.out

echo cu_menu.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\cu_menu.sql  -o %6\cu_menu.out

echo cu_service_auth.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\cu_service_auth.sql  -o %6\cu_service_auth.out

echo cu_cew_menu_auth.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\cu_cew_menu_auth.sql  -o %6\cu_cew_menu_auth.out

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
