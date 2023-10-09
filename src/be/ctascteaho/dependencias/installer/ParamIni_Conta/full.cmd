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
%1 - Server
%2 - Login
%3 - Password
%4 - servidor ADMIN

if exist Salida.out del Salida.out

echo ----------------- Creando objetos de CONTA ---------
echo ----------------- Creando objetos de CONTA --------- >> Salida.out

echo -------------------------------------- cb_area.sql >> Salida.out
echo cb_area.sql
sqlcmd -U%2 -P%3 -S%1 -m 1 -i cb_area.sql    >> Salida.out
echo -------------------------------------- cb_campos_banco.sql >> Salida.out
echo cb_campos_banco.sql
sqlcmd -U%2 -P%3 -S%1 -m 1 -i cb_campos_banco.sql    >> Salida.out
echo -------------------------------------- cb_corte.sql >> Salida.out
echo cb_corte.sql
sqlcmd -U%2 -P%3 -S%1 -m 1 -i cb_corte.sql    >> Salida.out
echo -------------------------------------- cb_cotizacion.sql >> Salida.out
echo cb_cotizacion.sql
sqlcmd -U%2 -P%3 -S%1 -m 1 -i cb_cotizacion.sql    >> Salida.out

echo -------------------------------------- cb_det_perfil.sql >> Salida.out
echo cb_det_perfil.sql
sqlcmd -U%2 -P%3 -S%1 -m 1 -i cb_det_perfil.sql    >> Salida.out

echo -------------------------------------- cb_empresa.sql >> Salida.out
echo cb_empresa.sql
sqlcmd -U%2 -P%3 -S%1 -m 1 -i cb_empresa.sql    >> Salida.out

echo -------------------------------------- cb_jerararea.sql >> Salida.out
echo cb_jerararea.sql
sqlcmd -U%2 -P%3 -S%1 -m 1 -i cb_jerararea.sql    >> Salida.out

echo -------------------------------------- cb_jerarquia.sql >> Salida.out
echo cb_jerarquia.sql
sqlcmd -U%2 -P%3 -S%1 -m 1 -i cb_jerarquia.sql    >> Salida.out

echo -------------------------------------- cb_nivel_area.sql >> Salida.out
echo cb_nivel_area.sql
sqlcmd -U%2 -P%3 -S%1 -m 1 -i cb_nivel_area.sql    >> Salida.out

echo -------------------------------------- cb_nivel_cuenta.sql >> Salida.out
echo cb_nivel_cuenta.sql
sqlcmd -U%2 -P%3 -S%1 -m 1 -i cb_nivel_cuenta.sql    >> Salida.out

echo -------------------------------------- cb_oficina.sql >> Salida.out
echo cb_oficina.sql
sqlcmd -U%2 -P%3 -S%1 -m 1 -i cb_oficina.sql    >> Salida.out

echo -------------------------------------- cb_ofic_cont.sql >> Salida.out
echo cb_ofic_cont.sql
sqlcmd -U%2 -P%3 -S%1 -m 1 -i cb_ofic_cont.sql    >> Salida.out

echo -------------------------------------- cb_paramdep.sql >> Salida.out
echo cb_paramdep.sql
sqlcmd -U%2 -P%3 -S%1 -m 1 -i cb_paramdep.sql    >> Salida.out

echo -------------------------------------- cb_parametro.sql >> Salida.out
echo cb_parametro.sql
sqlcmd -U%2 -P%3 -S%1 -m 1 -i cb_parametro.sql    >> Salida.out

echo -------------------------------------- cb_perfil.sql >> Salida.out
echo cb_perfil.sql
sqlcmd -U%2 -P%3 -S%1 -m 1 -i cb_perfil.sql    >> Salida.out

echo -------------------------------------- cb_producto.sql >> Salida.out
echo cb_producto.sql
sqlcmd -U%2 -P%3 -S%1 -m 1 -i cb_producto.sql    >> Salida.out

echo --------------------------------------cb_relofi.sql >> Salida.out
echo cb_relofi.sql
sqlcmd -U%2 -P%3 -S%1 -m 1 -i cb_relofi.sql    >> Salida.out


echo --------------------------------------cb_relparam.sql >> Salida.out
echo cb_relparam.sql
sqlcmd -U%2 -P%3 -S%1 -m 1 -i cb_relparam.sql    >> Salida.out


echo --------------------------------------cb_tipo_area.sql >> Salida.out
echo cb_tipo_area.sql
sqlcmd -U%2 -P%3 -S%1 -m 1 -i cb_tipo_area.sql    >> Salida.out


echo --------------------------------------cb_organizacion.sql >> Salida.out
echo cb_organizacion.sql
sqlcmd -U%2 -P%3 -S%1 -m 1 -i cb_organizacion.sql    >> Salida.out

echo ---------------------------------------- FIN ---


