@echo off
rem ***********************************************************************
rem *    ARCHIVO:         fullini.cmd
rem *    NOMBRE LOGICO:   fullini.cmd
rem *    PRODUCTO:        COBIS
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
rem *   Instalacion bases de datos iniciales 
rem ***********************************************************************
rem *                     MODIFICACIONES
rem *   FECHA        AUTOR      RAZON
rem *  05/Sep/2016   AGO        Emision Inicial

echo off
if "%1"=="" goto ayuda
if "%2"=="" goto ayuda
if "%3"=="" goto ayuda
if "%4"=="" goto ayuda
if "%5"=="" goto ayuda

if not exist %4\log ( 
md %4\log
)

echo ------ CREANDO BASES DE DATOS INICIALES ... ------
echo bases_create.sql
sqlcmd -U%1 -P%2 -S%3 -i %4\bases_create.sql  -o %5\bases_create.out


echo Fin del Proceso.....

goto fin

:ayuda
echo full.cmd [parametro 1] [parametro 2] [parametro 3] [parametro 4] [parametro 5] 
echo [parametro 1]: usuario de SQLserver
echo [parametro 2]: password del usuario de SQLserver
echo [parametro 3]: nombre del servidor SQLserver
echo [parametro 4]: directorio de los fuentes
echo [parametro 5]: directorio del log de instalacion
:fin
