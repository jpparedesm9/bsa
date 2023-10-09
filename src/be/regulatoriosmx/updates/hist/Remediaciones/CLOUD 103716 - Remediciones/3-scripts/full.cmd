@echo off
rem ***********************************************************************
rem *    ARCHIVO:         full.cmd
rem *    NOMBRE LOGICO:   full.cmd
rem *    PRODUCTO:        PLATAFORMA	
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
rem *   Cambio de oficinas
rem ***********************************************************************
rem *                     MODIFICACIONES
rem *   FECHA        AUTOR      RAZON

echo off
if "%1"=="" goto ayuda
if "%2"=="" goto ayuda
if "%3"=="" goto ayuda
if "%4"=="" goto ayuda
if "%5"=="" goto ayuda

if not exist %5\log\ ( 
md %5\log\
)

echo ------ EJECUCION SCRIPTS CONTINUACION ------

echo ------1------------------------
echo 00_Script103378.sql
sqlcmd -U%1 -P%2 -S%3 -i %4\00_Script103378.sql  -o %5\log\00_Script103378.out
echo ------2------------------------
echo wf_r_actividad_103378.sql
sqlcmd -U%1 -P%2 -S%3 -i %4\wf_r_actividad_103378.sql  -o %5\log\wf_r_actividad_103378.out
echo ------3------------------------
echo wf_r_asignacion_103378.sql
sqlcmd -U%1 -P%2 -S%3 -i %4\wf_r_asignacion_103378.sql  -o %5\log\wf_r_asignacion_103378.out
echo ------4------------------------
echo wf_r_proceso_103378.sql
sqlcmd -U%1 -P%2 -S%3 -i %4\wf_r_proceso_103378.sql  -o %5\log\wf_r_proceso_103378.out







 
 


echo Fin del Proceso.....

goto fin

:ayuda
echo full.cmd [parametro 1] [parametro 2] [parametro 3] [parametro 4] [parametro 5] 
echo [parametro 1]: usuario de BDD
echo [parametro 2]: password del usuario de BDD
echo [parametro 3]: nombre del servidor BDD
echo [parametro 4]: directorio de los fuentes
echo [parametro 5]: directorio del log de instalacion
:fin
