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
if "%5"=="" goto ayuda
if "%6"=="" goto ayuda

if not exist %6 ( 
	md %6
)

if exist Salida.out del Salida.out

echo ----------------- Iniciando Instalacion
echo ----------------- Creando objetos de CONTA --------- >> Salida.out


echo cb_empresa.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\cb_empresa.sql -o %6\cb_empresa.out
echo -------------------------------------- Ejecutado cb_empresa.sql >> Salida.out

echo cb_organizacion.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\cb_organizacion.sql -o %6\cb_organizacion.out
echo --------------------------------------Ejecutado cb_organizacion.sql >> Salida.out

echo cb_producto.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\cb_producto.sql -o %6\cb_producto.out
echo --------------------------------------Ejecutado cb_producto.sql >> Salida.out

echo cb_oficina.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\cb_oficina.sql -o %6\cb_oficina.out
echo --------------------------------------Ejecutado cb_oficina.sql >> Salida.out

echo cb_relofi.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\cb_relofi.sql -o %6\cb_relofi.out
echo --------------------------------------Ejecutado cb_relofi.sql >> Salida.out

echo cb_tipo_area.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\cb_tipo_area.sql -o %6\cb_tipo_area.out
echo --------------------------------------Ejecutado cb_tipo_area.sql >> Salida.out

echo cb_nivel_area.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\cb_nivel_area.sql -o %6\cb_nivel_area.out
echo --------------------------------------Ejecutado cb_nivel_area.sql >> Salida.out

echo cb_area.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\cb_area.sql -o %6\cb_area.out
echo --------------------------------------Ejecutado cb_area.sql >> Salida.out

echo cb_cotizacion.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\cb_cotizacion.sql -o %6\cb_cotizacion.out
echo --------------------------------------Ejecutado cb_cotizacion.sql >> Salida.out

echo cb_periodo.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\cb_periodo.sql -o %6\cb_periodo.out
echo --------------------------------------Ejecutado cb_periodo.sql >> Salida.out

echo cb_corte.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\cb_corte.sql -o %6\cb_corte.out
echo --------------------------------------Ejecutado cb_corte.sql >> Salida.out

echo cb_nivel_cuenta.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\cb_nivel_cuenta.sql -o %6\cb_nivel_cuenta.out
echo --------------------------------------Ejecutado cb_nivel_cuenta.sql >> Salida.out

echo cb_cuenta.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\cb_cuenta.sql -o %6\cb_cuenta.out
echo --------------------------------------Ejecutado cb_cuenta.sql >> Salida.out

echo cb_mov_cuenta.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\cb_mov_cuenta.sql -o %6\cb_mov_cuenta.out
echo --------------------------------------Ejecutado cb_mov_cuenta.sql >> Salida.out

echo cb_plan_general.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\cb_plan_general.sql -o %6\cb_plan_general.out
echo --------------------------------------Ejecutado cb_plan_general.sql >> Salida.out

echo cb_parametro.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\cb_parametro.sql -o %6\cb_parametro.out
echo --------------------------------------Ejecutado cb_parametro.sql >> Salida.out

echo cb_tipo_trn.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\cb_tipo_trn.sql -o %6\cb_tipo_trn.out
echo --------------------------------------Ejecutado cb_tipo_trn.sql >> Salida.out

echo cb_perfil.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\cb_perfil.sql -o %6\cb_perfil.out
echo --------------------------------------Ejecutado cb_perfil.sql >> Salida.out

echo cb_trn_oper.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\cb_trn_oper.sql -o %6\cb_trn_oper.out
echo --------------------------------------Ejecutado cb_trn_oper.sql >> Salida.out

echo cb_det_perfil.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\cb_det_perfil.sql -o %6\cb_det_perfil.out
echo --------------------------------------Ejecutado cb_det_perfil.sql >> Salida.out

echo cb_relparam.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\cb_relparam.sql -o %6\cb_relparam.out
echo --------------------------------------Ejecutado cb_relparam.sql >> Salida.out

echo cbpathpro.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\cbpathpro.sql -o %6\cbpathpro.out
echo --------------------------------------Ejecutado cbpathpro.sql >> Salida.out

echo cb_batch.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\cb_batch.sql -o %6\cb_batch.out
echo --------------------------------------Ejecutado cb_batch.sql >> Salida.out

echo ad_dias_feriados.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\ad_dias_feriados.sql -o %6\ad_dias_feriados.out
echo --------------------------------------Ejecutado ad_dias_feriados.sql >> Salida.out


rem echo pe_conta_aho.sql
rem sqlcmd -U%1 -P%2 -S%3 -i %5\pe_conta_aho.sql -o %6\pe_conta_aho.out
rem echo --------------------------------------Ejecutado pe_conta_aho.sql >> Salida.out


rem echo cb_cuenta_proceso.sql
rem sqlcmd -U%1 -P%2 -S%3 -i %5\cb_cuenta_proceso.sql -o %6\cb_cuenta_proceso.out
rem echo --------------------------------------Ejecutado cb_cuenta_proceso.sql >> Salida.out

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

