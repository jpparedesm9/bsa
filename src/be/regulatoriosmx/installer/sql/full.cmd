@echo off
rem ***********************************************************************
rem *    ARCHIVO:         full.cmd
rem *    NOMBRE LOGICO:   full.cmd
rem *    PRODUCTO:        REGULATORIOS
rem ***********************************************************************
rem *                     IMPORTANTE
rem * Esta aplicacion es parte de los paquetes bancarios propiedad       
rem * de COBISCorp.                                                      
rem * Su uso no    autorizado queda  expresamente   prohibido asi como   
rem * cualquier    alteracion o  agregado  hecho por    alguno  de sus   
rem * usuarios sin el debido consentimiento por   escrito de COBISCorp.  
rem * Este programa esta protegido por la ley de   derechos de autor     
rem * y por las    convenciones  internacionales   de  propiedad inte-   
rem * lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para
rem * obtener ordenes  de secuestro o  retencion y para  perseguir       
rem * penalmente a los autores de cualquier   infraccion.                
rem ***********************************************************************
rem *                     PROPOSITO
rem *   Instalacion para regulatorios
rem ***********************************************************************

echo off
if "%1"=="" goto ayuda
if "%2"=="" goto ayuda
if "%3"=="" goto ayuda
if "%5"=="" goto ayuda
if "%6"=="" goto ayuda

if not exist %5\log ( 
md %5\log
)

echo ------ CREANDO OBJETOS PARA LAVADO DE DINERO... ------
echo reg_producto.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\reg_producto.sql  -o %6\reg_producto.out

echo reg_batch.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\reg_batch.sql  -o %6\reg_batch.out

echo cbsup_dtype.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\cbsup_dtype.sql  -o %6\cbsup_dtype.out

echo cbsup_table.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\cbsup_table.sql  -o %6\cbsup_table.out

echo reg_tabla.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\reg_tabla.sql  -o %6\reg_tabla.out

echo reg_functions.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\reg_functions.sql  -o %6\reg_functions.out

echo reg_catalogo.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\reg_catalogo.sql  -o %6\reg_catalogo.out

echo reg_parametria.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\reg_parametria.sql  -o %6\reg_parametria.out

echo reg_datosini.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\reg_datosini.sql  -o %6\reg_datosini.out

echo reg_trn.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\reg_trn.sql  -o %6\reg_trn.out

echo reg_elimina_menu.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\reg_elimina_menu.sql  -o %6\reg_elimina_menu.out

echo reg_crea_menu.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\reg_crea_menu.sql  -o %6\reg_crea_menu.out

echo reg_menu_dependencia.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\reg_menu_dependencia.sql  -o %6\reg_menu_dependencia.out

echo reg_errores.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\reg_errores.sql  -o %6\reg_errores.out


echo ------ CREANDO OBJETOS PARA SOLICITUD GENERACION DE REGULATORIOS... ------
echo cb_table_view.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\cb_table_view.sql  -o %6\cb_table_view.out

echo cb_parametria.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\cb_parametria.sql  -o %6\cb_parametria.out

echo cb_seg_trn.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\cb_seg_trn.sql  -o %6\cb_seg_trn.out

echo Fin del Proceso.....

goto fin

:ayuda
echo full.cmd [parametro 1] [parametro 2] [parametro 3] [parametro 5] [parametro 6] 
echo [parametro 1]: usuario de Sybase
echo [parametro 2]: password del usuario de Sybase
echo [parametro 3]: nombre del servidor Sybase
echo [parametro 5]: directorio de los fuentes
echo [parametro 6]: directorio del log de instalacion
:fin
