@echo off
rem ***********************************************************************
rem *    ARCHIVO:         full.cmd
rem *    NOMBRE LOGICO:   full.cmd
rem *    PRODUCTO:        COB_REMESAS
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
rem *   Instalacion general de PERSONALIZACION BackEnd Central
rem ***********************************************************************
rem *                     MODIFICACIONES
rem *   FECHA        AUTOR      RAZON
rem *  10/May/2016   jbaque    Emision Inicial

echo off
if "%1"=="" goto ayuda
if "%2"=="" goto ayuda
if "%3"=="" goto ayuda
if "%4"=="" goto ayuda
if "%5"=="" goto ayuda

if not exist %5\log ( 
md %5\log
)




echo ------ CREANDO OBJETOS DE PERSON ... ------
echo re_dropf.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\re_dropf.sql  -o %6\re_dropf.out

echo re_dropp.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\re_dropp.sql  -o %6\re_dropp.out

echo re_dropv.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\re_dropv.sql  -o %6\re_dropv.out

echo re_dropt.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\re_dropt.sql  -o %6\re_dropt.out

echo re_dtype.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\re_dtype.sql  -o %6\re_dtype.out

echo re_table.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\re_table.sql  -o %6\re_table.out

echo re_fkey.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\re_fkey.sql  -o %6\re_fkey.out

echo re_pkey.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\re_pkey.sql  -o %6\re_pkey.out

echo re_seqnos.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\re_seqnos.sql  -o %6\re_seqnos.out

echo re_trse.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\re_trse.sql  -o %6\re_trse.out

echo ------ REMESAS... ------ 

echo re_catlgo.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\re_catlgo.sql -o %6\re_catlgo.out

echo re_param.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\re_param.sql -o %6\re_param.out

echo re_error.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\re_error.sql -o %6\re_error.out

echo re_datosini.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\re_datosini.sql -o %6\re_datosini.out

echo cm_datini.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\cm_datini.sql -o %6\cm_datini.out

echo re_transito_ad.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\re_transito_ad.sql -o %6\re_transito_ad.out

echo re_tran.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\re_tran.sql -o %6\re_tran.out

echo re_proc.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\re_proc.sql -o %6\re_proc.out

echo re_protran.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\re_protran.sql -o %6\re_protran.out

echo re_traut.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\re_traut.sql -o %6\re_traut.out

echo re_producto.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\re_producto.sql -o %6\re_producto.out

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
