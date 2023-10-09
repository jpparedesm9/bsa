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

echo ----------------- Creando objetos de CONTA ---------
echo ----------------- Creando objetos de CONTA --------- >> Salida.out

echo -------------------------------------- cbbfunction.sql >> Salida.out
echo cbbfunction.sql
sqlcmd -U%2 -P%3 -S%1 -m 1 -i cbbfunction.sql    >> Salida.out
echo -------------------------------------- cbbview.sql >> Salida.out
echo cbbview.sql
sqlcmd -U%2 -P%3 -S%1 -m 1 -i cbbview.sql    >> Salida.out
echo -------------------------------------- cbbtable.sql >> Salida.out
echo cbbtable.sql
sqlcmd -U%2 -P%3 -S%1 -m 1 -i cbbtable.sql    >> Salida.out
echo ----------------- Eliminando Datos de Usuario ----- >> Salida.out
echo -------------------------------------- cbbtype.sql >> Salida.out
echo cbbtype.sql
sqlcmd -U%2 -P%3 -S%1 -m 1 -i cbbtype.sql    >> Salida.out
echo ----------------- Creacion Datos de Usuario ----- >> Salida.out
echo -------------------------------------- cbctype.sql >> Salida.out
echo cbctype.sql
sqlcmd -U%2 -P%3 -S%1 -m 1 -i cbctype.sql   >> Salida.out
echo -------------------------------------- cbctable.sql >> Salida.out
echo cbctable.sql
sqlcmd -U%2 -P%3 -S%1 -m 1 -i cbctable.sql    >> Salida.out
echo -------------------------------------- cbcindex.sql >> Salida.out
echo cbcindex.sql
sqlcmd -U%2 -P%3 -S%1 -m 1 -i cbcindex.sql    >> Salida.out
echo -------------------------------------- cbcview.sql >> Salida.out
echo cbcview.sql
sqlcmd -U%2 -P%3 -S%1 -m 1 -i cbcview.sql    >> Salida.out
echo -------------------------------------- cbcfunction.sql >> Salida.out
echo cbcfunction.sql
sqlcmd -U%2 -P%3 -S%1 -m 1 -i cbcfunction.sql    >> Salida.out
echo -------------------------------------- cbccatal.sql >> Salida.out
echo cbccatal.sql
sqlcmd -U%2 -P%3 -S%1 -m 1 -i cbccatal.sql    >> Salida.out

echo ----------------- Creando objetos de CONTA TERCERO -----
echo ----------------- Creando objetos de CONTA TERCERO ----- >> Salida.out

echo -------------------------------------- ctbtable.sql >> Salida.out
echo ctbtable.sql
sqlcmd -U%2 -P%3 -S%1 -m 1 -i ctbtable.sql    >> Salida.out
echo ----------------- Eliminando Datos de Usuario ----- >> Salida.out
echo -------------------------------------- ctbtype.sql  >> Salida.out
echo ctbtype.sql 
sqlcmd -U%2 -P%3 -S%1 -m 1 -i ctbtype.sql   >> Salida.out
echo ----------------- Creacion Datos de Usuario ----- >> Salida.out
echo -------------------------------------- ctctype.sql  >> Salida.out
echo ctctype.sql 
sqlcmd -U%2 -P%3 -S%1 -m 1 -i ctctype.sql   >> Salida.out
echo -------------------------------------- ctctable.sql >> Salida.out
echo ctctable.sql
sqlcmd -U%2 -P%3 -S%1 -m 1 -i ctctable.sql    >> Salida.out
echo -------------------------------------- ctcindex.sql >> Salida.out
echo ctcindex.sql
sqlcmd -U%2 -P%3 -S%1 -m 1 -i ctcindex.sql    >> Salida.out

echo ----------------- Creando objetos de CONTA HIS -----
echo ----------------- Creando objetos de CONTA HIS ----- >> Salida.out

echo -------------------------------------- chbtable.sql >> Salida.out
echo chbtable.sql
sqlcmd -U%2 -P%3 -S%1 -m 1 -i chbtable.sql    >> Salida.out
echo ----------------- Eliminando Datos de Usuario ----- >> Salida.out
echo -------------------------------------- chbtype.sql  >> Salida.out
echo chbtype.sql 
sqlcmd -U%2 -P%3 -S%1 -m 1 -i chbtype.sql    >> Salida.out
echo ----------------- Creacion Datos de Usuario ----- >> Salida.out
echo -------------------------------------- chctype >> Salida.out
echo chctype.sql 
sqlcmd -U%2 -P%3 -S%1 -m 1 -i chctype.sql    >> Salida.out
echo -------------------------------------- chctable.sql >> Salida.out
echo chctable.sql
sqlcmd -U%2 -P%3 -S%1 -m 1 -i chctable.sql    >> Salida.out
echo -------------------------------------- chcindex.sql >> Salida.out
echo chcindex.sql
sqlcmd -U%2 -P%3 -S%1 -m 1 -i chcindex.sql    >> Salida.out


echo ----------------- Creando objetos de CCONTABLE -----
echo ----------------- Creando objetos de CCONTABLE ----- >> Salida.out

echo -------------------------------------- ccbtable.sql >> Salida.out
echo ccbtable.sql      
sqlcmd -U%2 -P%3 -S%1 -m 1 -i ccbtable.sql   >> Salida.out

echo -------------------------------------- ccbtype.sql  >> Salida.out
echo ccbtype.sql      
sqlcmd -U%2 -P%3 -S%1 -m 1 -i ccbtype.sql    >> Salida.out

echo -------------------------------------- ccctype.sql  >> Salida.out
echo ccctype.sql      
sqlcmd -U%2 -P%3 -S%1 -m 1 -i ccctype.sql    >> Salida.out

echo -------------------------------------- ccctable.sql >> Salida.out
echo ccctable.sql      
sqlcmd -U%2 -P%3 -S%1 -m 1 -i ccctable.sql   >> Salida.out


echo ----------------- Creando PARAMETROS -----
echo ----------------- Creando PARAMETROS ----- >> Salida.out
echo -------------------------------------- cbcparam.sql >> Salida.out
echo cbcparam.sql
sqlcmd -U%2 -P%3 -S%1 -m 1 -i cbcparam.sql    >> Salida.out

echo ----------------- Creando TRANSACCIONES -----
echo ----------------- Creando TRANSACCIONES ----- >> Salida.out
echo -------------------------------------- cbcsegur.sql >> Salida.out
echo cbcsegur.sql
sqlcmd -U%2 -P%3 -S%1 -m 1 -i cbcsegur.sql    >> Salida.out

echo ----------------- Creando MENU CEN -----
echo ----------------- Creando MENU CEN ----- >> Salida.out
echo -------------------------------------- Menu_CON.sql >> Salida.out
echo Menu_CON.sql
sqlcmd -U%2 -P%3 -S%1 -m 1 -i Menu_CON.sql    >> Salida.out
echo -------------------------------------- Menu-MCON.sql >> Salida.out
echo Menu-MCON.sql
sqlcmd -U%2 -P%3 -S%1 -m 1 -i Menu-MCON.sql    >> Salida.out

echo ---------------------------------------- FIN ---




