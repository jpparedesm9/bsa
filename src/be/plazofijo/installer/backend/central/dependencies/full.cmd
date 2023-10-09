@echo off
rem ********************************************************
rem *    ARCHIVO:         full.cmd
rem *    NOMBRE LOGICO:   full.cmd
rem *    PRODUCTO:        COBIS
rem ********************************************************
rem *                     IMPORTANTE
rem *   Esta  aplicacion  es parte de los paquetes bancarios
rem *   propiedad de COBISCorp.
rem *   Su  uso  no autorizado queda  expresamente prohibido 
rem *   asi  como  cualquier alteracion o agregado hecho por  
rem *   alguno  de sus usuarios sin el debido consentimiento 
rem *   por escrito de COBISCorp.
rem *   Este  programa esta protegido por la ley de derechos 
rem *   de  autor  y por las convenciones internacionales de 
rem *   propiedad intelectual. Su uso no autorizado dara de-
rem *   recho a COBISCorp para obtener ordenes de  secuestro
rem *   o retencion y para perseguir penalmente a los autores 
rem *   de cualquier infraccion.
rem ********************************************************
rem *                     PROPOSITO
rem *   Instalacion general de COBIS BackEnd Central
rem ********************************************************
rem *                     MODIFICACIONES
rem *   FECHA             AUTOR         RAZON
rem *  06/May/2016        Dfu           Emision Inicial
rem ********************************************************

echo off
if "%1"=="" goto ayuda
if "%2"=="" goto ayuda
if "%3"=="" goto ayuda

echo ------ EJECUCION DE COMPILADORES ... ------
@echo off
call .\dependencies\cob_ahorros\full.cmd %1 %2 %3
call .\dependencies\cob_cartera\full.cmd %1 %2 %3
call .\dependencies\cob_ccontable\full.cmd %1 %2 %3
call .\dependencies\cob_conta\full.cmd %1 %2 %3
call .\dependencies\cob_conta_his\full.cmd %1 %2 %3
call .\dependencies\cob_conta_super\full.cmd %1 %2 %3
call .\dependencies\cob_conta_terceros\full.cmd %1 %2 %3
call .\dependencies\cob_cuentas\full.cmd %1 %2 %3
call .\dependencies\cob_cuentas_his\full.cmd %1 %2 %3
call .\dependencies\cob_externos\full.cmd %1 %2 %3
call .\dependencies\cob_interfase\full.cmd %1 %2 %3
call .\dependencies\cob_remesas\full.cmd %1 %2 %3
call .\dependencies\cob_sbancarios\full.cmd %1 %2 %3
call .\dependencies\cob_wservices\full.cmd %1 %2 %3
call .\dependencies\firmas\full.cmd %1 %2 %3
call .\dependencies\cob_interfase\full.cmd %1 %2 %3
call .\dependencies\cob_ahorros\full.cmd %1 %2 %3
echo Fin del Proceso.....

goto fin

:ayuda
echo full.cmd [parametro 1] [parametro 2] [parametro 3]
echo donde:
echo [parametro 1]: Login del usuario de la base de datos
echo [parametro 2]: password del usuario de la base de datos
echo [parametro 3]: Servidor SQL
:fin