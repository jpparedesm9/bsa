@echo off
rem ***********************************************************************
rem *    ARCHIVO:         full.cmd
rem *    NOMBRE LOGICO:   full.cmd
rem *    PRODUCTO:        GENERADOR
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
rem *   Instalacion GENERADOR DE REPORTES ESTADO DE CUENTA
rem ***********************************************************************

echo off
if "%1"=="" goto ayuda
if "%2"=="" goto ayuda
if "%3"=="" goto ayuda


if not exist C:\java\ ( 
md C:\java\
)
echo ------ EJECUCION DE SP ... ------
@echo off 

call .\source\backend\spsql\full.cmd %1 %2 %3 .\source\backend\spsql\ .\source\backend\spsql\log\
echo ------ FIN EJECUCION DE SP ... ------

call .\source\frontend\full.cmd .\source\frontend

call .\cloud-configuration\full.cmd .\cloud-configuration

call ..\cloud-util-jdbc\full.cmd ..\cloud-util-jdbc

call ..\cloud-util-marshall\full.cmd ..\cloud-util-marshall

call ..\cloud-xmlgenerator\full.cmd ..\cloud-xmlgenerator

copy .\target\cloud-xmlgenerator-1.0.0.jar C:\java                                                             
copy .\target\cloud-xmlgenerator-1.0.0-jar-with-dependencies.jar C:\java  



echo Fin del Proceso.....

goto fin

:ayuda
echo full.cmd [parametro 1] [parametro 2] [parametro 3] [parametro 4] [parametro 5] [parametro 6]
echo donde:
echo [parametro 1]: usuario de Sybase
echo [parametro 2]: password del usuario de Sybase
echo [parametro 3]: nombre del servidor Sybase
:fin