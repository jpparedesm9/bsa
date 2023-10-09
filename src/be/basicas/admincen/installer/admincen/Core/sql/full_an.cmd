@echo off
del /f /q *.out

echo ---- CREANDO OBJETOS DE ADMINISTRACION CEN   ... ---
echo an_parametro.sql
sqlcmd  -U%1 -P%2 -S%3   -i %5\an_parametro.sql   -o %6\an_parametro.out

echo an_esquema.sql
sqlcmd  -U%1 -P%2 -S%3   -i %5\an_esquema.sql   -o %6\an_esquema.out

echo an_ins.sql
sqlcmd  -U%1 -P%2 -S%3   -i %5\an_ins.sql  -o %6\an_ins.out
rem sqlcmd  -U%1 -P%2 -S%3 < an_aut_serviciosob.sql > an_aut_serviciosob.out

echo krn_excepcion.sql
sqlcmd  -U%1 -P%2 -S%3   -i %5\krn_excepcion.sql  -o %6\krn_excepcion.out

echo -------FIN-------