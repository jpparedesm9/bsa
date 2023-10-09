@echo off
if "%1"=="" goto error
if "%2"=="" goto error
if "%3"=="" goto error
if "%4"=="" goto error
cls
echo ---------------------------------------------------------------------
echo                              BANCO COBIS                              
echo                      INSTALACION DE ESTRUCTURAS                      
echo                         COBIS VISUAL BATCH                           
echo ---------------------------------------------------------------------

echo --------------------------------------------------------------------- >  resultado.out
echo                              BANCO COBIS                              >> resultado.out
echo                      INSTALACION DE ESTRUCTURAS                       >> resultado.out
echo                         COBIS VISUAL BATCH                            >> resultado.out
echo --------------------------------------------------------------------- >> resultado.out

cd sql
del /f /q *.out

cd..

echo ELIMINACION DE TABLAS            
sqlcmd  -U%1 -P%2 -S%3 -i %5\ba_dropt.sql -o %6\resultado.out

echo CREACION DE TABLAS
sqlcmd  -U%1 -P%2 -S%3 -i %5\ba_table.sql -o %6\resultado.out

echo ELIMINACION DE LLAVES PRIMARIAS
sqlcmd  -U%1 -P%2 -S%3 -i %5\ba_dropp.sql -o %6\resultado.out

echo CREACION DE LLAVES PRIMARIAS
sqlcmd  -U%1 -P%2 -S%3 -i %5\ba_pkey.sql -o %6\resultado.out

echo ELIMINACION DE VISTAS DE TRANSACCIONES DE SERVICIO
sqlcmd  -U%1 -P%2 -S%3 -i %5\ba_dropv.sql  -o %6\resultado.out

echo TABLA DE TRANSACCIONES DE SERVICIO
sqlcmd  -U%1 -P%2 -S%3 -i %5\ba_trser.sql  -o %6\resultado.out

echo CREACION DEL PRODUCTO BATCH
sqlcmd  -U%1 -P%2 -S%3 -i %5\ba_segur.sql -o %6\resultado.out

echo INSERCION DE CODIGOS DE ERRORES
sqlcmd  -U%1 -P%2 -S%3 -i %5\ba_error.sql -o %6\resultado.out

echo CREACION DE ROL Y SEGURIDADES
sqlcmd  -U%1 -P%2 -S%3 -i %5\ba_rol.sql -o %6\resultado.out

echo CATALOGOS Y PARAMETROS
sqlcmd  -U%1 -P%2 -S%3 -i %5\ba_ins.sql -o %6\resultado.out

echo CREACION BATCH
sqlcmd  -U%1 -P%2 -S%3 -i %5\ba_batch.sql -o %6\resultado.out

echo CREACION PARAMETROS BATCH
sqlcmd  -U%1 -P%2 -S%3 -i %5\ba_param.sql -o %6\resultado.out

echo CREACION SARTA BATCH
sqlcmd  -U%1 -P%2 -S%3 -i %5\ba_sarta.sql  -o %6\resultado.out

echo CREACION MENU VBATCH
sqlcmd  -U%1 -P%2 -S%3 -i %5\ba_menu_vbatch.sql -o %6\resultado.out

echo CREACION SEGURIDAD UNIFICADA
sqlcmd  -U%1 -P%2 -S%3 -i %5\ba_segur_unificada.sql -o %6\resultado.out

echo GENERACION Y CARGA DE ARCHIVOS .DAT

echo REENTRY...rp_gen_rol        > genload.sql
echo go                         >> genload.sql
echo %4...rp_load_rol           >> genload.sql
echo go                         >> genload.sql
echo REENTRY...rp_gen_rolspro   >> genload.sql
echo go                         >> genload.sql
echo %4...rp_load_rolspro       >> genload.sql
echo go                         >> genload.sql
echo REENTRY...rp_gen_loghorol  >> genload.sql
echo go                         >> genload.sql
echo %4...rp_load_loghorol      >> genload.sql
echo go                         >> genload.sql
echo REENTRY...rp_gen_catalogo  >> genload.sql
echo go                         >> genload.sql
echo %4...sp_load_catalogo      >> genload.sql
echo go                         >> genload.sql

sqlcmd  -U%1 -P%2 -S%3 -i %5\genload.sql -o %6\resultado.out

echo FIN DE PROCESO... REVISAR ARCHIVO RESULTADO.OUT
echo FIN DE PROCESO... REVISAR ARCHIVO RESULTADO.OUT  >> resultado.out
goto fin

:error
echo MODO DE USO:
echo full.cmd user_bdd passwd_bdd SQL TRANSRV
echo DONDE:
echo user_bdd: Usuario de la base de datos, ejemplo: sa
echo passwd_bdd: Password del usuario de la base de datos
echo SQL: Nombre del Servidor de Base de Datos 
echo TRANSRV: Nombre del Transerver de COBIS
echo.
:fin
