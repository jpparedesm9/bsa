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

echo off
if "%1"=="" goto ayuda
if "%2"=="" goto ayuda
if "%3"=="" goto ayuda
if "%4"=="" goto ayuda
if "%5"=="" goto ayuda

if not exist %5 ( 
	md %5
)

if exist Salida.out del Salida.out

echo ----------------- Iniciando Instalacion
echo ----------------- Creando objetos de CONTA --------- >> Salida.out


rem echo cb_empresa.sql
rem sqlcmd -U%1 -P%2 -S%3 -i %4\cb_empresa.sql -o %5\cb_empresa.out
rem echo -------------------------------------- Ejecutado cb_empresa.sql >> Salida.out

rem echo cb_organizacion.sql
rem sqlcmd -U%1 -P%2 -S%3 -i %4\cb_organizacion.sql -o %5\cb_organizacion.out
rem echo --------------------------------------Ejecutado cb_organizacion.sql >> Salida.out

echo cb_producto.sql
sqlcmd -U%1 -P%2 -S%3 -i %4\cb_producto.sql -o %5\cb_producto.out
echo --------------------------------------Ejecutado cb_producto.sql >> Salida.out

rem echo cb_oficina.sql
rem sqlcmd -U%1 -P%2 -S%3 -i %4\cb_oficina.sql -o %5\cb_oficina.out
rem echo --------------------------------------Ejecutado cb_oficina.sql >> Salida.out

rem echo cb_relofi.sql
rem sqlcmd -U%1 -P%2 -S%3 -i %4\cb_relofi.sql -o %5\cb_relofi.out
rem echo --------------------------------------Ejecutado cb_relofi.sql >> Salida.out

echo cb_tipo_area.sql
sqlcmd -U%1 -P%2 -S%3 -i %4\cb_tipo_area.sql -o %5\cb_tipo_area.out
echo --------------------------------------Ejecutado cb_tipo_area.sql >> Salida.out

rem echo cb_nivel_area.sql
rem sqlcmd -U%1 -P%2 -S%3 -i %4\cb_nivel_area.sql -o %5\cb_nivel_area.out
rem echo --------------------------------------Ejecutado cb_nivel_area.sql >> Salida.out

rem echo cb_area.sql
rem sqlcmd -U%1 -P%2 -S%3 -i %4\cb_area.sql -o %5\cb_area.out
rem echo --------------------------------------Ejecutado cb_area.sql >> Salida.out

rem echo cb_cotizacion.sql
rem sqlcmd -U%1 -P%2 -S%3 -i %4\cb_cotizacion.sql -o %5\cb_cotizacion.out
rem echo --------------------------------------Ejecutado cb_cotizacion.sql >> Salida.out

rem echo cb_periodo.sql
rem sqlcmd -U%1 -P%2 -S%3 -i %4\cb_periodo.sql -o %5\cb_periodo.out
rem echo --------------------------------------Ejecutado cb_periodo.sql >> Salida.out

rem echo cb_corte.sql
rem sqlcmd -U%1 -P%2 -S%3 -i %4\cb_corte.sql -o %5\cb_corte.out
rem echo --------------------------------------Ejecutado cb_corte.sql >> Salida.out

rem echo cb_nivel_cuenta.sql
rem sqlcmd -U%1 -P%2 -S%3 -i %4\cb_nivel_cuenta.sql -o %5\cb_nivel_cuenta.out
rem echo --------------------------------------Ejecutado cb_nivel_cuenta.sql >> Salida.out

rem echo cb_cuenta.sql
rem sqlcmd -U%1 -P%2 -S%3 -i %4\cb_cuenta.sql -o %5\cb_cuenta.out
rem echo --------------------------------------Ejecutado cb_cuenta.sql >> Salida.out

rem echo cb_plan_general.sql
rem sqlcmd -U%1 -P%2 -S%3 -i %4\cb_plan_general.sql -o %5\cb_plan_general.out
rem echo --------------------------------------Ejecutado cb_plan_general.sql >> Salida.out

echo cb_parametro.sql
sqlcmd -U%1 -P%2 -S%3 -i %4\cb_parametro.sql -o %5\cb_parametro.out
echo --------------------------------------Ejecutado cb_parametro.sql >> Salida.out

echo cb_perfil.sql
sqlcmd -U%1 -P%2 -S%3 -i %4\cb_perfil.sql -o %5\cb_perfil.out
echo --------------------------------------Ejecutado cb_perfil.sql >> Salida.out

echo cb_det_perfil.sql
sqlcmd -U%1 -P%2 -S%3 -i %4\cb_det_perfil.sql -o %5\cb_det_perfil.out
echo --------------------------------------Ejecutado cb_det_perfil.sql >> Salida.out

echo cb_relparam.sql
sqlcmd -U%1 -P%2 -S%3 -i %4\cb_relparam.sql -o %5\cb_relparam.out
echo --------------------------------------Ejecutado cb_relparam.sql >> Salida.out

echo pe_conta_aho.sql
sqlcmd -U%1 -P%2 -S%3 -i %4\pe_conta_aho.sql -o %5\pe_conta_aho.out
echo --------------------------------------Ejecutado pe_conta_aho.sql >> Salida.out


echo ----------------- Finalizando Instalacion
echo ---------------------------------------- FIN --- >> Salida.out


goto fin

:ayuda
echo full.cmd [parametro 1] [parametro 2] [parametro 3] [parametro 4] [parametro 5] 
echo [parametro 1]: usuario de la Base de Datos
echo [parametro 2]: password de la Base de Datos
echo [parametro 3]: nombre del servidor de la Base de Datos
echo [parametro 4]: directorio de los fuentes
echo [parametro 5]: directorio del log de instalacion
:fin

