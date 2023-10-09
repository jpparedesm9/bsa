echo off
if "%1"=="" goto ayuda
if "%2"=="" goto ayuda
if "%3"=="" goto ayuda
if "%4"=="" goto ayuda
if "%5"=="" goto ayuda
if "%6"=="" goto ayuda


echo Creando objetos para BATCH ADMIN ..
echo ad_batch.sql     
	sqlcmd  -U%1 -P%2 -S%3   -i %5\ad_batch.sql     -o %6\ad_batch.out
echo ad_sarta.sql      
	sqlcmd  -U%1 -P%2 -S%3   -i %5\ad_sarta.sql     -o %6\ad_sarta.out
echo ad_param.sql       
	sqlcmd  -U%1 -P%2 -S%3   -i %5\ad_param.sql     -o %6\ad_param..out

echo Fin.

goto fin

:ayuda
echo full.cmd [parametro 1] [parametro 2] [parametro 3] [parametro 4] [parametro 5] [parametro 6]
echo donde:
echo [parametro 1]: usuario de Sybase
echo [parametro 2]: password del usuario de Sybase
echo [parametro 3]: nombre del servidor Sybase
echo [parametro 4]: directorio de los fuentes
echo [parametro 5]: directorio del log de instalacion
echo [parametro 6]: nombre del servidor COBIS Central
:fin
