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

echo Instalando Dependencias de Depositos a Plazo Fijo - Repositorio
echo -- CREACION DE TIPOS DE DATOS
sqlcmd -U%1 -P%2 -S%3 -i %5\sb_type.sql     -o %6\sb_type.out
echo -- CREACION DE TABLAS
sqlcmd -U%1 -P%2 -S%3 -i %5\sb_table.sql    -o %6\sb_table.out
echo -- CREACION DE CLAVES PRIMARIAS
sqlcmd -U%1 -P%2 -S%3 -i %5\sb_pkey.sql     -o %6\sb_pkey.out
echo -- CREACION DE CATALOGOS
sqlcmd -U%1 -P%2 -S%3 -i %5\sb_catlg.sql     -o %6\sb_catlg.out
echo Fin.

goto fin

:uso
echo Uso: full.cmd user password SERVER_BDD SERVER_COBIS path_fuentes path_out
:fin

