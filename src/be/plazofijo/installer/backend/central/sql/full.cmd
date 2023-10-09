@echo off
if "%1"=="" goto uso
if "%2"=="" goto uso
if "%3"=="" goto uso
if "%4"=="" goto uso
if "%5"=="" goto uso
if "%6"=="" goto uso

for %%d in (*.out) do (
    del %%d  
)

echo Instalando DEPOSITOS A PLAZO 
echo -- ELIMINACION DE TABLAS 
sqlcmd -U%1 -P%2 -S%3 -i %5\pf_dropt.sql    -o %6\pf_dropt.out
echo -- ELIMINACION DE DEFAULTS
sqlcmd -U%1 -P%2 -S%3 -i %5\pf_ddef.sql     -o %6\pf_ddef.out
echo -- CREACION DE TIPOS DE DATOS
sqlcmd -U%1 -P%2 -S%3 -i %5\pf_type.sql     -o %6\pf_type.out
echo -- CREACION DE TABLAS
sqlcmd -U%1 -P%2 -S%3 -i %5\pf_table.sql    -o %6\pf_table.out
echo -- CREACION DE CLAVES PRIMARIAS
sqlcmd -U%1 -P%2 -S%3 -i %5\pf_pkey.sql     -o %6\pf_pkey.out
echo -- CREACION DE VISTAS 
sqlcmd -U%1 -P%2 -S%3 -i %5\pf_view.sql     -o %6\pf_view.out
echo -- CREACION DE TRANSACCIONES DE SERVICIO 
sqlcmd -U%1 -P%2 -S%3 -i %5\pf_trser.sql    -o %6\pf_trser.out
echo -- TRANSACCIONES AUTORIZADAS 
sqlcmd -U%1 -P%2 -S%3 -i %5\pf_traut.sql    -o %6\pf_traut.out
echo -- CREACION DE ROL DPF
sqlcmd -U%1 -P%2 -S%3 -i %5\pf_segur.sql    -o %6\pf_segur.out
echo -- SEQNOS 
sqlcmd -U%1 -P%2 -S%3 -i %5\pf_seq.sql      -o %6\pf_seq.out
echo -- CREACION DE DEFAULTS
sqlcmd -U%1 -P%2 -S%3 -i %5\pf_def.sql      -o %6\pf_def.out
echo -- BATCH 
sqlcmd -U%1 -P%2 -S%3 -i %5\pf_batch.sql    -o %6\pf_batch.out
echo -- CATALOGOS
sqlcmd -U%1 -P%2 -S%3 -i %5\pf_error.sql    -o %6\pf_error.out
sqlcmd -U%1 -P%2 -S%3 -i %5\pf_catlg.sql    -o %6\pf_catlg.out
echo -- CEN
sqlcmd -U%1 -P%2 -S%3 -i %5\pf_cen.sql      -o %6\pf_cen.out
echo -- PERFILES CONTABLES 
sqlcmd -U%1 -P%2 -S%3 -i %5\pf_conta.sql    -o %6\pf_conta.out
echo -- PARAMETRIZACION PIZARRA
sqlcmd -U%1 -P%2 -S%3 -i %5\pf_pizarra.sql    -o %6\pf_pizarra.out
echo -- PARAMETRIZACION TEMPORAL
sqlcmd -U%1 -P%2 -S%3 -i %5\pf_parametrizacion_temp.sql    -o %6\pf_parametrizacion_temp.out
echo Fin.

goto fin

:uso
echo Uso: full.cmd user password SERVER_BDD SERVER_COBIS path_fuentes path_out
:fin

