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
echo pe_dropf.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\pe_dropf.sql  -o %5\pe_dropf.out

echo pe_dropp.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\pe_dropp.sql  -o %5\pe_dropp.out

echo pe_dropv.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\pe_dropv.sql  -o %5\pe_dropv.out

echo pe_dropt.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\pe_dropt.sql  -o %5\pe_dropt.out

echo pe_dtype.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\pe_dtype.sql  -o %5\pe_dtype.out

echo pe_table.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\pe_table.sql  -o %5\pe_table.out

echo pa_trser.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\pe_trser.sql  -o %5\pe_trser.out

echo pe_pkey.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\pe_pkey.sql  -o %5\pe_pkey.out

echo pa_fkey.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\pe_fkey.sql  -o %5\pe_fkey.out

echo pa_error.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\pe_error.sql  -o %5\pe_error.out

echo ------ SEGURIDADES DE PERSONALIZACION ... ------ 

echo pe_catlgo.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\pe_catlgo.sql -o %5\pe_catlgo.out

echo pe_param.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\pe_param.sql -o %5\pe_param.out

echo pe_seqnos.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\pe_seqnos.sql -o %5\pe_seqnos.out

echo pe_producto.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\pe_producto.sql -o %5\pe_producto.out

echo pe_tran.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\pe_tran.sql -o %5\pe_tran.out

echo pe_proc.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\pe_proc.sql -o %5\pe_proc.out

echo pe_protran.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\pe_protran.sql -o %5\pe_protran.out

echo pe_traut.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\pe_traut.sql -o %5\pe_traut.out

echo pe_parametria.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\pe_parametria.sql -o %5\pe_parametria.out

echo pe_parametria_cta_normal.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\pe_parametria_cta_normal.sql -o %5\pe_parametria_cta_normal.out

echo pe_parametria_cta_ordinario.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\pe_parametria_cta_ordinario.sql -o %5\pe_parametria_cta_ordinario.out

echo pe_parametria_cta_adicional.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\pe_parametria_cta_adicional.sql -o %5\pe_parametria_cta_adicional.out

echo pe_parametria_cta_menor_edad.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\pe_parametria_cta_menor_edad.sql -o %5\pe_parametria_cta_menor_edad.out

echo pe_parametria_cta_programada.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\pe_parametria_cta_programada.sql -o %5\pe_parametria_cta_programada.out


rem * echo ------ MENU DE PERSONALIZACION ... ------ 
rem * echo menu-person-conrol.sql
rem * sqlcmd -U%1 -P%2 -S%3 -i %5\menu-person-conrol.sql -o %5\menu-person-conrol.out

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
