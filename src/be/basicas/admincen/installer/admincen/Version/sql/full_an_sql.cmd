@echo off
if "%1"=="" goto ayuda
if "%2"=="" goto ayuda
if "%3"=="" goto ayuda



echo ---- CREANDO OBJETOS DE ADMINISTRACION CEN   ... ---
echo an_esquema1.sql
sqlcmd  -U%1 -P%2 -S%3 -i %5\an_esquema1.sql -o %6\an_esquema1.out

echo an_aut_serviciosob1.sql
sqlcmd  -U%1 -P%2 -S%3 -i %5\an_aut_serviciosob1.sql -o %6\an_aut_serviciosob1.out

echo an_segur.sql
sqlcmd  -U%1 -P%2 -S%3 -i %5\an_segur.sql -o %6\an_segur.out

echo an_ins_admin.sql
sqlcmd  -U%1 -P%2 -S%3 -i %5\an_ins_admin.sql -o %6\an_ins_admin.out

echo an_error.sql
sqlcmd  -U%1 -P%2 -S%3 -i %5\an_error.sql -o %6\an_error.out

echo an_error.sql
sqlcmd  -U%1 -P%2 -S%3 -i %5\an_ins_admin_queryCatalog.sql -o %6\an_ins_admin_queryCatalog.out
REM sqlcmd  -U%1 -P%2 -S%3 < cts_serv_catalog.sql > cts_serv_catalog.out

echo ---- CREANDO MENUS DE CEN EN SERVIDOR  ... ---
echo MenuPrincipalconrol.sql
sqlcmd  -U%1 -P%2 -S%3 -i %5\MenuPrincipalconrol.sql -o %6\MenuPrincipalconrol.out

echo menu-admin-conrol.sql
sqlcmd  -U%1 -P%2 -S%3 -i %5\menu-admin-conrol.sql -o %6\menu-admin-conrol.out

echo adm-official.sql
sqlcmd  -U%1 -P%2 -S%3 -i %5\adm_official.sql -o %6\adm-official.out

echo ---- CREANDO MENU AUTORIZACION DE FUNCIONALIDADES  ... ---
echo Menu-AdminPro.sql
sqlcmd  -U%1 -P%2 -S%3 -i %5\Menu-AdminPro.sql -o %6\Menu-AdminPro.out

echo Menu-AdminRed.sql
sqlcmd  -U%1 -P%2 -S%3 -i %5\Menu-AdminRed.sql -o %6\Menu-AdminRed.out

echo Menu-AdminRef.sql
sqlcmd  -U%1 -P%2 -S%3 -i %5\Menu-AdminRef.sql -o %6\Menu-AdminRef.out

echo Menu-AdminSeg.sql
sqlcmd  -U%1 -P%2 -S%3 -i %5\Menu-AdminSeg.sql -o %6\Menu-AdminSeg.out

REM echo menu-admincen-conrol.sql
REM sqlcmd  -U%1 -P%2 -S%3   -i menu-admincen-conrol.sql   -o menu-admincen-conrol.out

echo -------FIN-------

echo Fin.

goto fin

:ayuda
echo full.cmd [parametro 1] [parametro 2] [parametro 3] 
echo donde:
echo [parametro 1]: usuario de base de datos
echo [parametro 2]: password del usuario de base de datos
echo [parametro 3]: nombre del servidor 
:fin