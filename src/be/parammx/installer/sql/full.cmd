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
rem *   Parametría Inicial México
rem ***********************************************************************
rem *                     MODIFICACIONES
rem *   FECHA        AUTOR      RAZON
rem *  26/Ago/2016   KMEZA    Emision Inicial

echo off
if "%1"=="" goto ayuda
if "%2"=="" goto ayuda
if "%3"=="" goto ayuda
if "%4"=="" goto ayuda
if "%5"=="" goto ayuda

if not exist %5\log ( 
md %5\log
)

echo ------ CARGANDO PAISES ... ------
echo carga_cl_pais.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\carga_cl_pais.sql  -o %6\carga_cl_pais.out

echo ------ CARGANDO ESTADOS ... ------
echo carga_cl_provincia.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\carga_cl_provincia.sql  -o %6\carga_cl_provincia.out

echo ------ VALIDANDO EQUIVALENCIAS PARA PAIS ... ------
echo validacion_eq_pais.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\validacion_eq_pais.sql  -o %6\validacion_eq_pais.out

echo ------ VALIDANDO EQUIVALENCIAS ENTE ... ------
echo validacion_equivalencias.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\validacion_equivalencias.sql  -o %6\validacion_equivalencias.out

echo ------ CARGANDO BANCOS MEXICOS ... ------
echo carga_bancos_mex.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\carga_bancos_mex.sql  -o %6\carga_bancos_mex.out

echo ------ CARGANDO OFICINAS MEXICO ... ------
echo carga_oficinas_mex.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\carga_oficinas_mex.sql  -o %6\carga_oficinas_mex.out

echo ------ CARGANDO EMPRESA ... ------
echo crea_empresa.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\crea_empresa.sql  -o %6\crea_empresa.out

echo ------ VALIDANDO TIPO DE DOCUMENTO ... ------
echo parametria_mexico.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\parametria_mexico.sql  -o %6\parametria_mexico.out

echo ------ CONVERSION MONEDA LOCAL ... ------
echo conversion_moneda.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\conversion_moneda.sql  -o %6\conversion_moneda.out


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
