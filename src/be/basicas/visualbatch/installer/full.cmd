@echo off
rem ***********************************************************************
rem *    ARCHIVO:         full.cmd
rem *    NOMBRE LOGICO:   full.cmd
rem *    PRODUCTO:        VBATCH
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
rem *   Instalacion general de VBATCH BackEnd Central
rem ***********************************************************************
rem *                     MODIFICACIONES
rem *   FECHA        AUTOR      RAZON
rem *  21/Jun/2016   fvargas    Emision Inicial
rem ***********************************************************************

echo off
if "%1"=="" goto ayuda
if "%2"=="" goto ayuda
if "%3"=="" goto ayuda
if "%4"=="" goto ayuda

echo ------ EJECUCION DE SQL ... ------
@echo off 
call .\sql\full.cmd %1 %2 %3 %4 .\sql .\sql
echo ------ FIN EJECUCION DE SQL ... ------


echo ------ EJECUCION DE SP ... ------
@echo off 
call .\spsql\full.cmd %1 %2 %3 .\spsql  .\spsql 
echo ------ FIN EJECUCION DE SP ... ------

echo Fin del Proceso.....

goto fin

:ayuda
echo full.cmd [parametro 1] [parametro 2] [parametro 3] [parametro 4] [parametro 5] [parametro 6]
echo donde:
echo [parametro 1]: usuario de Sybase
echo [parametro 2]: password del usuario de Sybase
echo [parametro 3]: nombre del servidor Sybase
echo [parametro 4]: nombre del Transerver de COBIS
:fin