@echo off
if "%1"=="" goto error
if "%2"=="" goto error
if "%3"=="" goto error
cls
echo ---------------------------------------------------------------------
echo                            BANCO COBIS                              
echo                          CREACION DE SQTs                             
echo                         COBIS VISUAL BATCH                           
echo ---------------------------------------------------------------------

echo --------------------------------------------------------------------- >  sp.out
echo                            BANCO COBIS                                >> sp.out
echo                          CREACION DE SQTs                             >> sp.out
echo                         COBIS VISUAL BATCH                            >> sp.out
echo --------------------------------------------------------------------- >> sp.out

echo in_ba_log.sqr
sqrw in_ba_log.sqr %1/%2 -V%3 -RS -XMB

echo up_ba_log.sqr
sqrw up_ba_log.sqr %1/%2 -V%3 -RS -XMB

echo up_ba_sb_exec.sqr
sqrw up_ba_sb_exec.sqr %1/%2 -V%3 -RS -XMB

echo Los archivos *.sqt deben permanecer en el directorio  ..\vbatch\backend\shells
echo Final de Instalacion

goto fin

:error
echo MODO DE USO:
echo full.cmd user_bdd passwd_bdd SYBASE
echo DONDE:
echo user_bdd: Usuario de la base de datos, ejemplo: sa
echo passwd_bdd: Password del usuario de la base de datos
echo SYBASE: Nombre del Servidor de Base de Datos 
echo.
:fin
