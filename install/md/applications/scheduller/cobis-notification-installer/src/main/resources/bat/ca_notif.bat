@echo off
rem ***********************************************************************
rem *    ARCHIVO:         envioNotificacionCartera.bat
rem *    NOMBRE LOGICO:   
rem *    PRODUCTO:        COB_CARTERA
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
rem *  realiza la actualizacion de estados en cuenta de cartera 
rem ***********************************************************************

echo off

if "%1"=="" goto ayuda
if "%2"=="" goto ayuda

cd %2

java -jar %2notification\cloud-notification-service-1.0.0-jar-with-dependencies.jar %1

goto fin

:ayuda
echo full.cmd [parametro 1] 
echo [parametro 1]: Operacion a Notificar
echo [parametro 2]: Ruta del jar
:fin
