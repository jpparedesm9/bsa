rem full.cmd
cls
echo off
echo ------------------------------------------------
echo                                  COBISCORP      
echo                          SCRIPTS DE INSTALACION 
echo                              COBIS - SCRIPTS      
echo                             SQL Server 2012      
date /T
time /T
echo ------------------------------------------------
rem Parametros:
rem %1 - Server
rem %2 - Login
rem %3 - Password
rem %4 - servidor ADMIN

if exist Salida.out del Salida.out

echo Creando objetos para interfaces ..

echo -------------------------------------- inbtable.sql >> Salida.out

echo inbtable.sql      
sqlcmd -U%2 -P%3 -S%1   -i %5\inbtable.sql   -o %6\inbtable.out

echo -------------------------------------- inbtype.sql >> inbtype.out

echo inbtype.sql      
sqlcmd -U%2 -P%3 -S%1   -i %5\inbtype.sql   -o %6\inbtype.out
echo -------------------------------------- inctype.sql >> inctype.out

echo inctype.sql      
sqlcmd -U%2 -P%3 -S%1   -i %5\inctype.sql   -o %6\inctype.out
echo -------------------------------------- inctable.sql >> inctable.out

echo inctable.sql      
sqlcmd -U%2 -P%3 -S%1   -i %5\inctable.sql   -o %6\inctable.out
echo -------------------------------------- inbtype.sql >> inbtype.out
echo ---------------------------------------- FIN ---

