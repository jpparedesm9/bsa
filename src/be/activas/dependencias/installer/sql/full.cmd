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

echo ------ DEPENDENCIAS ------

echo co_dtable.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\co_dtable.sql  -o %6\co_dtable.out

echo co_type.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\co_type.sql  -o %6\co_type.out

echo co_type.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\co_type.sql  -o %6\co_type.out

echo adm_type.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\adm_type.sql  -o %6\adm_type.out

echo adm_table.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\adm_table.sql  -o %6\adm_table.out

echo cc_type.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\cc_type.sql  -o %6\cc_type.out

echo cc_table.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\cc_table.sql  -o %6\cc_table.out

echo cbsup_table.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\cbsup_table.sql  -o %6\cbsup_table.out

echo sb_type.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\sb_type.sql  -o %6\sb_type.out

echo sb_table.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\sb_table.sql  -o %6\sb_table.out

echo cobex_type.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\cobex_type.sql  -o %6\cobex_type.out

echo cobex_table.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\cobex_table.sql  -o %6\cobex_table.out

echo sb_datosini.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\sb_datosini.sql  -o %6\sb_datosini.out

echo cc_view.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\cc_view.sql  -o %6\cc_view.out

echo mis_catalogos.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\mis_catalogos.sql  -o %6\mis_catalogos.out


echo cc_catlgo.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\cc_catlgo.sql  -o %6\cc_catlgo.out

echo cc_param.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\cc_param.sql  -o %6\cc_param.out


echo adm_traut.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\adm_traut.sql  -o %6\adm_traut.out

echo cb_trser.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\cb_trser.sql  -o %6\cb_trser.out

echo tes_table.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\tes_table.sql  -o %6\tes_table.out

echo in_table.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\in_table.sql  -o %6\in_table.out

echo in_numpara.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\in_numpara.sql  -o %6\in_numpara.out


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
