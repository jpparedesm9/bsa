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
rem ***********************************************************************

echo off
if "%1"=="" goto ayuda
if "%2"=="" goto ayuda
if "%3"=="" goto ayuda

echo ------ EJECUCION DE SQL ... ------
echo ------ EJECUCION REMESAS... ------

@echo off 
call .\Dependencias\sql\full.cmd %1 %2 %3 .\Dependencias\sql\ .\Dependencias\sql\log\
echo ------ FIN EJECUCION DE Dependencias ... ------


@echo off 
call  .\Remesas\Backend\sql\full.cmd %1 %2 %3 .\Remesas\Backend\sql\ .\Remesas\Backend\sql\log\
echo ------ EJECUCION DE SQL Remesas... ------

@echo off 
call  .\Person\Backend\sql\full.cmd %1 %2 %3 .\Person\Backend\sql\ .\Person\Backend\sql\log\
echo ------ EJECUCION DE SQL PERSON ... ------

@echo off 
call  .\Ahorros\Backend\sql\full.cmd %1 %2 %3 .\Ahorros\Backend\sql\ .\Ahorros\Backend\sql\log\
echo ------ EJECUCION DE SQL AHORROS ... ------

@echo off 
call  .\Remesas\Backend\spsql\full.cmd %1 %2 %3 .\Remesas\Backend\spsql\ .\Remesas\Backend\spsql\log\
echo ------ FIN REMESAS ... ------

@echo off 
call  .\Dependencias\spsql\full.cmd %1 %2 %3 .\Dependencias\spsql\ .\Dependencias\spsql\log\
echo ------ FIN Dependencias ... ------

@echo off 
call  .\Person\Backend\spsql\full.cmd %1 %2 %3 .\Person\Backend\spsql\ .\Person\Backend\spsql\log\
echo ------ FIN EJECUCION DE SP Person ... ------

@echo off 
call .\Ahorros\Backend\spsql\full.cmd %1 %2 %3 .\Ahorros\Backend\spsql\ .\Ahorros\Backend\spsql\log\
echo ------ FIN EJECUCION DE SP Ahorros ... ------

@echo off 
call .\Ahorros\Backend\sql\Param_Conta_MX\full.cmd %1 %2 %3 .\Ahorros\Backend\sql\Param_Conta_MX\ .\Ahorros\Backend\sql\Param_Conta_MX\log\

@echo off 
call .\Ahorros\Generador\full.cmd %1 %2 %3
echo ------ FIN EJECUCION PARAMETRIZACION CONTABLE ... ------

echo Fin del Proceso.....

goto fin

:ayuda
echo full.cmd [parametro 1] [parametro 2] [parametro 3] 
echo donde:
echo [parametro 1]: usuario de Sybase
echo [parametro 2]: password del usuario de Sybase
echo [parametro 3]: nombre del servidor Sybase
:fin
