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

echo Instalando Dependencias de Depositos a Plazo Fijo - Historico Cuentas
echo -- CREACION DE TIPOS DE DATOS
sqlcmd -U%1 -P%2 -S%3 -i %5\cc_his_type.sql     -o %6\cc_his_type.out
echo -- CREACION DE TABLAS
sqlcmd -U%1 -P%2 -S%3 -i %5\cc_his_table.sql    -o %6\cc_his_table.out

echo Fin.

goto fin

:uso
echo Uso: full.cmd user password SERVER_BDD SERVER_COBIS path_fuentes path_out
:fin

