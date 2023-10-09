@echo off
rem ***********************************************************************
rem *    ARCHIVO:         full.cmd
rem *    NOMBRE LOGICO:   full.cmd
rem *    PRODUCTO:        ADMIN
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
rem *   Instalacion general de ADMIN BackEnd Central
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
if "%5"=="" goto ayuda


echo ------ EJECUCION DE FULL1 ... ------
call .\sql\full1.cmd %1 %2 %3 .\sql .\sql
echo ------ FIN EJECUCION DE FULL1 ... ------
echo ------ EJECUCION DE FULL2 ... ------
call .\sql\full2.cmd %1 %2 %3 .\sql .\sql %4
echo ------ FIN EJECUCION DE FULL2 ... ------
echo ------ EJECUCION DE full_admbatch ... ------
call .\sql\full_admbatch.cmd %1 %2 %3 .\sql .\sql %4
echo ------ FIN EJECUCION DE full_admbatch ... ------
echo ------ FIN EJECUCION DE SQL ... ------

echo ------ EJECUCION DE SP ... ------
@echo off 
call .\spsql\full.cmd %1 %2 %3 %5 .\spsql .\spsql
echo ------ FIN EJECUCION DE SP ... ------
cd ..
echo ------ EJECUCION DE TRIGGERS ... ------
@echo off 
call .\triggers\fulltg.cmd %1 %2 %3 .\triggers .\triggers
echo ------ FIN EJECUCION DE TRIGGERS ... ------

echo Fin del Proceso.....

goto fin

:ayuda
echo full.cmd [parametro 1] [parametro 2] [parametro 3] [parametro 4] [parametro 5]
echo donde:
echo [parametro 1]: usuario de SQLServer
echo [parametro 2]: password del usuario de SQLServer
echo [parametro 3]: nombre del servidor SQLServer
echo [parametro 4]: Transerver
echo [parametro 5]: Versión servidor SQLServer

:fin