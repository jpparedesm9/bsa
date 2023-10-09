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

echo ------ CREANDO OBJETOS DEPENDENCIAS DE CARTERA ... ------

echo ------ COB_CREDITO ------

echo cr_dtable.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\cr_dtable.sql  -o %6\cr_dtable.out

echo cr_dtable_his.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\cr_dtable_his.sql  -o %6\cr_dtable_his.out

echo cr_type.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\cr_type.sql  -o %6\cr_type.out

echo cr_type_his.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\cr_type_his.sql  -o %6\cr_type_his.out

echo cr_table.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\cr_table.sql  -o %6\cr_table.out

echo cr_table_his.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\cr_table_his.sql  -o %6\cr_table_his.out

echo cr_view.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\cr_view.sql  -o %6\cr_view.out

echo cr_function.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\cr_function.sql  -o %6\cr_function.out

echo cr_triggers.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\cr_triggers.sql  -o %6\cr_triggers.out

echo cr_catalogos.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\cr_catalogos.sql  -o %6\cr_catalogos.out

echo cr_parametro.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\cr_parametro.sql  -o %6\cr_parametro.out

echo cr_transac.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\cr_transac.sql  -o %6\cr_transac.out

echo cr_seqnos.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\cr_seqnos.sql  -o %6\cr_seqnos.out

echo cr_datosini.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\cr_datosini.sql  -o %6\cr_datosini.out

echo cr_datosini.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\cr_batch.sql  -o %6\cr_batch.out

echo cr_produ.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\cr_produ.sql  -o %6\cr_produ.out

echo cr_errores.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\cr_errores.sql  -o %6\cr_errores.out

echo cr_imp_documento.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\cr_imp_documento.sql  -o %6\cr_imp_documento.out

echo cr_ins.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\cr_ins.sql  -o %6\cr_ins.out

echo cr_services_authorization.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\cr_services_authorization.sql  -o %6\cr_services_authorization.out

echo cr_cew_menu.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\cr_cew_menu.sql  -o %6\cr_cew_menu.out

echo cr_parametria.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\cr_parametria.sql  -o %6\cr_parametria.out

echo IEN\01_IENEliminacionDesembolsos.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\IEN\01_IENEliminacionDesembolsos.sql  -o %6\01_IENEliminacionDesembolsos.out

echo IEN\02_IENEliminacionCobros.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\IEN\02_IENEliminacionCobros.sql  -o %6\02_IENEliminacionCobros.out

echo IEN\03_IENEliminacionPagosReferenciados.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\IEN\03_IENEliminacionPagosReferenciados.sql  -o %6\03_IENEliminacionPagosReferenciados.out

echo IEN\04_IENDatosGenerales.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\IEN\04_IENDatosGenerales.sql  -o %6\04_IENDatosGenerales.out

echo IEN\05_IEN_cl_catalogo.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\IEN\05_IEN_cl_catalogo.sql  -o %6\05_IEN_cl_catalogo.out

echo IEN\06_IENPagosReferenciados.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\IEN\06_IENPagosReferenciados.sql  -o %6\06_IENPagosReferenciados.out

echo IEN\07_IENCobros.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\IEN\07_IENCobros.sql  -o %6\07_IENCobros.out

echo IEN\08_IENDesembolsos.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\IEN\08_IENDesembolsos.sql  -o %6\08_IENDesembolsos.out

echo IEN\09_IENDesembolsosCheck.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\IEN\09_IENDesembolsosCheck.sql  -o %6\09_IENDesembolsosCheck.out

echo IEN\10_IEN_holidays.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\IEN\10_IEN_holidays.sql  -o %6\10_IEN_holidays.out

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
