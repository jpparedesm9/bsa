@echo off
rem ***********************************************************************
rem *    ARCHIVO:         full.cmd
rem *    NOMBRE LOGICO:   full.cmd
rem *    PRODUCTO:        COB_INTERFASE
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
rem ***********************************************************************

echo off
if "%1"=="" goto ayuda
if "%2"=="" goto ayuda
if "%3"=="" goto ayuda


echo ------ EJECUCION DE BACKEND\SP ... ------
@echo off 
call .\Backend\spsql\full.cmd %1 %2 %3 .\Backend\spsql\ .\Backend\spsql\log\
echo ------ FIN EJECUCION DE BACKEND\SP ... ------

echo Fin del Proceso.....

goto fin

:ayuda
echo full.cmd [parametro 1] [parametro 2] [parametro 3] [parametro 4] [parametro 5] [parametro 6]
echo donde:
echo [parametro 1]: usuario de Sybase
echo [parametro 2]: password del usuario de Sybase
echo [parametro 3]: nombre del servidor Sybase
:fin