@echo off
if "%1"=="" goto ayuda
if "%2"=="" goto ayuda
if "%3"=="" goto ayuda
if "%4"=="" goto ayuda
if "%5"=="" goto ayuda

echo Creando objetos para ADMIN ..

echo ad_dropv.sql      
	sqlcmd  -U%1 -P%2 -S%3   -i %5\ad_dropv.sql   -o %6\ad_dropv.out
echo ad_dropp.sql      
	sqlcmd  -U%1 -P%2 -S%3   -i %5\ad_dropp.sql   -o %6\ad_dropp.out
echo ad_dropp_con.sql      
	sqlcmd  -U%1 -P%2 -S%3   -i %5\ad_dropp_con.sql   -o %6\ad_dropp_con.out
echo ad_dropf.sql      
	sqlcmd  -U%1 -P%2 -S%3   -i %5\ad_dropf.sql   -o %6\ad_dropf.out
echo ad_dropt.sql      
	sqlcmd  -U%1 -P%2 -S%3   -i %5\ad_dropt.sql   -o %6\ad_dropt.out
	
echo ad_dtype.sql      
	sqlcmd  -U%1 -P%2 -S%3   -i %5\ad_dtype.sql   -o %6\ad_dtype.out
echo ad_table.sql      
	sqlcmd  -U%1 -P%2 -S%3   -i %5\ad_table.sql   -o %6\ad_table.out
echo ad_llave.sql      
	sqlcmd  -U%1 -P%2 -S%3   -i %5\ad_llave.sql   -o %6\ad_llave.out
echo ad_pkey.sql       
	sqlcmd  -U%1 -P%2 -S%3   -i %5\ad_pkey.sql    -o %6\ad_pkey.out
echo ad_pkey_con.sql       
	sqlcmd  -U%1 -P%2 -S%3   -i %5\ad_pkey_con.sql    -o %6\ad_pkey_con.out
	
echo inicio de Tablas y vistas de intercionalizacion
	
echo table.sql
   sqlcmd  -U%1 -P%2 -S%3   -i %5\table.sql     -o %6\table.out
echo view.sql
   sqlcmd  -U%1 -P%2 -S%3   -i %5\view.sql      -o %6\view.out
echo seqnos.sql
   sqlcmd  -U%1 -P%2 -S%3   -i %5\seqnos.sql    -o %6\seqnos.out
echo fn_aleatoria.fn
   sqlcmd  -U%1 -P%2 -S%3   -i %5\fn_aleatoria.fn	-o %6\fn_aleatoria.out
echo fin de Tablas y vistas de intercionalizacion

echo Fin.

goto fin

:ayuda
echo full.cmd [parametro 1] [parametro 2] [parametro 3] [parametro 4] [parametro 5] 
echo donde:
echo [parametro 1]: usuario de Cobis
echo [parametro 2]: password del usuario de Cobis
echo [parametro 3]: nombre del servidor COBIS 
echo [parametro 4]: directorio de los fuentes
echo [parametro 5]: directorio del log de instalacion
:fin
