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

echo Instalando Dependencias de Depositos a Plazo Fijo - Ahorros
echo -- CREACION DE TIPOS DE DATOS
sqlcmd -U%1 -P%2 -S%3 -i %5\ah_type.sql     -o %6\ah_type.out
echo -- CREACION DE TABLAS
sqlcmd -U%1 -P%2 -S%3 -i %5\ah_table.sql    -o %6\ah_table.out
echo -- CREACION DE CLAVES PRIMARIAS
sqlcmd -U%1 -P%2 -S%3 -i %5\ah_pkey.sql     -o %6\ah_pkey.out

echo Fin.

goto fin

:uso
echo Uso: full.cmd user password SERVER_BDD SERVER_COBIS path_fuentes path_out
:fin

