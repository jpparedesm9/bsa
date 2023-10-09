@echo off
if "%1"=="" goto error
if "%2"=="" goto error
if "%3"=="" goto error
cls
echo ---------------------------------------------------------------------
echo                            BANCO COBIS                              
echo                    CREACION DE STORED PROCEDURES
echo                         COBIS VISUAL BATCH                           
echo ---------------------------------------------------------------------

echo --------------------------------------------------------------------- >  sp.out
echo                            BANCO COBIS                                >> sp.out
echo                    CREACION DE STORED PROCEDURES                      >> sp.out
echo                         COBIS VISUAL BATCH                            >> sp.out
echo --------------------------------------------------------------------- >> sp.out

REM echo LIMPIANDO LOG DE COBIS
REM echo LIMPIANDO LOG DE COBIS               	>> sp.out
REM osql -U%1 -P%2 -S%3 -n  < dump.sql >> sp.out

cd spsql
del /f /q *.out
cd..

echo sp_ba_error_log.sp
sqlcmd  -U%1 -P%2 -S%3 -i %4\sp_ba_error_log.sp -o %5\sp.out

echo aprueba.sp
sqlcmd  -U%1 -P%2 -S%3 -i %4\aprueba.sp -o %5\sp.out

echo aut_eje_forzada.sp
sqlcmd  -U%1 -P%2 -S%3 -i %4\aut_eje_forzada.sp -o %5\sp.out

echo autorizacion_lectura.sp
sqlcmd  -U%1 -P%2 -S%3 -i %4\autorizacion_lectura.sp -o %5\sp.out

echo ba_deshabilita_ej.sp
sqlcmd  -U%1 -P%2 -S%3 -i %4\ba_deshabilita_ej.sp -o %5\sp.out

echo ba_habilita_ej.sp
sqlcmd  -U%1 -P%2 -S%3 -i %4\ba_habilita_ej.sp -o %5\sp.out

echo batch.sp
sqlcmd  -U%1 -P%2 -S%3 -i %4\batch.sp -o %5\sp.out

echo cambio_fecha_pro.sp
sqlcmd  -U%1 -P%2 -S%3 -i %4\cambio_fecha_pro.sp -o %5\sp.out

echo consapar.sp
sqlcmd  -U%1 -P%2 -S%3 -i %4\consapar.sp -o %5\sp.out

echo consultas.sp
sqlcmd  -U%1 -P%2 -S%3 -i %4\consultas.sp -o %5\sp.out

echo corrida.sp
sqlcmd  -U%1 -P%2 -S%3 -i %4\corrida.sp -o %5\sp.out

echo datepart.sp
sqlcmd  -U%1 -P%2 -S%3 -i %4\datepart.sp -o %5\sp.out

echo ejec.sp
sqlcmd  -U%1 -P%2 -S%3 -i %4\ejec.sp -o %5\sp.out

echo enlace_aux.sp
sqlcmd  -U%1 -P%2 -S%3 -i %4\enlace_aux.sp -o %5\sp.out

echo execbatch.sp
sqlcmd  -U%1 -P%2 -S%3 -i %4\execbatch.sp -o %5\sp.out

echo fcierre.sp
sqlcmd  -U%1 -P%2 -S%3 -i %4\fcierre.sp -o %5\sp.out

echo fecha.sp
sqlcmd  -U%1 -P%2 -S%3 -i %4\fecha.sp -o %5\sp.out

echo find.sp
sqlcmd  -U%1 -P%2 -S%3 -i %4\find.sp -o %5\sp.out

echo impresora.sp
sqlcmd  -U%1 -P%2 -S%3 -i %4\impresora.sp -o %5\sp.out

echo lectura.sp
sqlcmd  -U%1 -P%2 -S%3 -i %4\lectura.sp -o %5\sp.out

echo log.sp
sqlcmd  -U%1 -P%2 -S%3 -i %4\log.sp -o %5\sp.out

echo login_batch.sp
sqlcmd  -U%1 -P%2 -S%3 -i %4\login_batch.sp -o %5\sp.out

echo loteproc.sp
sqlcmd  -U%1 -P%2 -S%3 -i %4\loteproc.sp -o %5\sp.out

echo ls.sp
sqlcmd  -U%1 -P%2 -S%3 -i %4\ls.sp -o %5\sp.out

echo opbatch.sp
sqlcmd  -U%1 -P%2 -S%3 -i %4\opbatch.sp -o %5\sp.out

echo operador.sp
sqlcmd  -U%1 -P%2 -S%3 -i %4\operador.sp -o %5\sp.out

echo paramet.sp
sqlcmd  -U%1 -P%2 -S%3 -i %4\paramet.sp -o %5\sp.out

echo pathproc.sp
sqlcmd  -U%1 -P%2 -S%3 -i %4\pathproc.sp -o %5\sp.out

echo poleo.sp
sqlcmd  -U%1 -P%2 -S%3 -i %4\poleo.sp -o %5\sp.out

echo readfile.sp
sqlcmd  -U%1 -P%2 -S%3 -i %4\readfile.sp -o %5\sp.out

echo sar_bach.sp
sqlcmd  -U%1 -P%2 -S%3 -i %4\sar_bach.sp -o %5\sp.out

echo sarta.sp
sqlcmd  -U%1 -P%2 -S%3 -i %4\sarta.sp -o %5\sp.out

echo sarta_bat_aux.sp
sqlcmd  -U%1 -P%2 -S%3 -i %4\sarta_bat_aux.sp -o %5\sp.out

echo sec_ejec.sp
sqlcmd  -U%1 -P%2 -S%3 -i %4\sec_ejec.sp -o %5\sp.out

echo sp_ba_error_his.sp
sqlcmd  -U%1 -P%2 -S%3 -i %4\sp_ba_error_his.sp -o %5\sp.out

echo sp_verifica_ba_log.sp
sqlcmd  -U%1 -P%2 -S%3 -i %4\sp_verifica_ba_log.sp -o %5\sp.out

echo update_sarta_batch.sp
sqlcmd  -U%1 -P%2 -S%3 -i %4\update_sarta_batch.sp -o %5\sp.out

echo fin 
goto fin

:error
echo MODO DE USO:
echo full.cmd user_bdd passwd_bdd SQL
echo DONDE:
echo user_bdd: Usuario de la base de datos, ejemplo: sa
echo passwd_bdd: Password del usuario de la base de datos
echo SQL: Nombre del Servidor de Base de Datos 
echo.
:fin

