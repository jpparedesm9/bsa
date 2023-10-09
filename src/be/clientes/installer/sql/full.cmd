ECHO OFF
rem ********************************************************
rem *    ARCHIVO:         full.cmd
rem *    NOMBRE LOGICO:   full.cmd
rem *    PRODUCTO:        Clientes
rem ********************************************************
rem *                     IMPORTANTE
rem *   Esta  aplicacion  es parte de los paquetes bancarios
rem *   propiedad de COBISCorp.
rem *   Su  uso  no autorizado queda  expresamente prohibido 
rem *   asi  como  cualquier alteracion o agregado hecho por  
rem *   alguno  de sus usuarios sin el debido consentimiento 
rem *   por escrito de COBISCorp.
rem *   Este  programa esta protegido por la ley de derechos 
rem *   de  autor  y por las convenciones internacionales de 
rem *   propiedad intelectual. Su uso no autorizado dara de-
rem *   recho a COBISCorp para obtener ordenes de  secuestro
rem *   o retencion y para perseguir penalmente a los autores 
rem *   de cualquier infraccion.
rem ********************************************************
rem *                     PROPOSITO
rem *   Compilacion de estructuras Clientes
rem ********************************************************
rem *                     MODIFICACIONES
rem *   FECHA        AUTOR           RAZON
rem *   06/08/2016   DFu             Emision Inicial
rem ********************************************************

echo off
if "%1"=="" goto ayuda
if "%2"=="" goto ayuda
if "%3"=="" goto ayuda
if "%5"=="" goto ayuda
if "%6"=="" goto ayuda

if not exist %5\log ( 
md %5\log
)


echo ====== ELIMINACION DE TRANSACCIONES DE SERVICIO
    sqlcmd -U%1 -P%2 -S%3  -i %5\cl_dropv.sql  -o %6\dropv.out

echo ====== CREACION DE TIPOS DE DATOS
    sqlcmd -U%1 -P%2 -S%3  -i %5\cl_dtype.sql   -o %6\dtype.out

echo ====== CREACION DE TABLAS
    sqlcmd -U%1 -P%2 -S%3  -i %5\cl_table.sql  -o %6\table.out
	
echo ====== CREACION DE ESTRUCTURAS
    sqlcmd -U%1 -P%2 -S%3  -i %5\cl_trser.sql  -o %6\trser.out

echo ====== TRUNCANDO TABLAS Y UPDATE SEQNOS
    sqlcmd -U%1 -P%2 -S%3  -i %5\cl_limpiar.sql  -o %6\limpiar.out

echo ====== CREACION DE VISTAS
    sqlcmd -U%1 -P%2 -S%3  -i %5\cl_view.sql   -o %6\view.out

echo ====== INSERCION DE DATOS
    sqlcmd -U%1 -P%2 -S%3 -i %5\cl_ins.sql    -o %6\ins.out

echo ====== INICIALIZACION DE CATALOGOS
        sqlcmd -U%1 -P%2 -S%3 -i %5\cl_insnv.sql    -o %6\insnv.out

echo ====== INSERCION DE TRANSACCIONES AUTORIZADAS
    sqlcmd -U%1 -P%2 -S%3 -i %5\cl_segur.sql  -o %6\segur.out

echo ====== INSERCION DE CODIGOS DE ERRORES
    sqlcmd -U%1 -P%2 -S%3 -i %5\cl_error.sql  -o %6\error.out

echo ====== INSERCION DE LOTES DE PROGRAMAS BATCH
    sqlcmd -U%1 -P%2 -S%3 -i %5\cl_batch.sql -o %6\batch.out

echo ====== INSERCION DE AGENTE BUSQUEDA DE CLIENTES
    sqlcmd -U%1 -P%2 -S%3 -i %5\cl_agent.sql -o %6\cl_agent.out

echo ====== INSERCION DE CEW MENU
    sqlcmd -U%1 -P%2 -S%3 -i %5\cl_cew_menu.sql -o %6\cl_cew_menu.out

echo ====== INSERCION DE FORMULARIOS
    sqlcmd -U%1 -P%2 -S%3 -i %5\cl_component.sql -o %6\cl_component.out

echo ====== INSERCION DE SERVICIOS AUTORIZADOS
    sqlcmd -U%1 -P%2 -S%3 -i %5\cl_services_authorization.sql -o %6\cl_services_authorization.out

echo ====== INSERCION DE RECURSOS DEL CONTENEDOR
    sqlcmd -U%1 -P%2 -S%3 -i %5\cl_cew_resource.sql -o %6\cl_cew_resource.out



echo ====== INSERCION DE PARAMETROS GENERALES
    sqlcmd -U%1 -P%2 -S%3 -i %5\cl_parametros.sql              -o %6\cl_parametros.out
echo ====== CATALOGOS
    sqlcmd -U%1 -P%2 -S%3 -i %5\cl_catalogo.sql               -o %6\cl_catalogo.out

echo ====== ALTER A TABLAS
    sqlcmd -U%1 -P%2 -S%3 -i %5\3_sta_alter_table.sql         -o %6\3_sta_alter_table.out
echo ====== DATOS
    sqlcmd -U%1 -P%2 -S%3 -i %5\5_sta_data.sql                -o %6\5_sta_data.out

echo ====== RECURSOS MAPAS
    sqlcmd -U%1 -P%2 -S%3 -i %5\cl_cew_resource.sql           -o %6\cl_cew_resource.out
echo ====== AUTORIZACION DE SERVICIOS DE PROSPECTOS Y GRUPOS
    sqlcmd -U%1 -P%2 -S%3 -i %5\cli_cew_menu_auth.sql          -o %6\cli_cew_menu_auth.out


	
echo ====== CATALOGO ESTADO-CIUDAD
    sqlcmd -U%1 -P%2 -S%3 -i %5\cl_catalogo_estado_ciudad.sql           -o %6\cl_catalogo_estado_ciudad.out
echo ====== CATALOGO COLONIAS
    sqlcmd -U%1 -P%2 -S%3 -i %5\cl_catalogo_parroquia.sql               -o %6\cl_catalogo_parroquia.out


echo ====== DISTRIBUCION GEOGRAFICA - CIUDADES  
    sqlcmd -U%1 -P%2 -S%3 -i %5\cl_ciudad.sql                           -o %6\cl_ciudad.OUT
echo ====== DISTRIBUCION GEOGRAFICA - COLONIAS
    sqlcmd -U%1 -P%2 -S%3 -i %5\cl_parroquia.sql                        -o %6\cl_parroquia.out

	
echo ====== EQUIVALENCIAS CIUDADES
    sqlcmd -U%1 -P%2 -S%3 -i %5\cl_equi_ciudad.sql              -o %6\cl_equi_ciudad.out
echo ====== EQUIVALENCIAS COLONIAS 
    sqlcmd -U%1 -P%2 -S%3 -i %5\cl_equi_parroquia.sql           -o %6\cl_equi_parroquia.out
echo ====== EQUIVALENCIAS DE ENTIDADES FEDERATIVAS
    sqlcmd -U%1 -P%2 -S%3 -i %5\cl_equi_01_entidades_curp.sql           -o %6\cl_equi_01_entidades_curp.out

echo ====== CODIGO POSTAL
    sqlcmd -U%1 -P%2 -S%3 -i %5\cl_codigo_postal.sql                    -o %6\cl_codigo_postal.out
echo ====== TU NEGOVIO
    sqlcmd -U%1 -P%2 -S%3 -i %5\frm_Tu_Negocio.sql.sql                    -o %6\frm_Tu_Negocio.sql.out
	

echo Fin.

goto fin

:ayuda
echo full.cmd [parametro 1] [parametro 2] [parametro 3] [parametro 4] [parametro 5]
echo donde:
echo [parametro 1]: Login del usuario de la base de datos
echo [parametro 2]: password del usuario de Sybase
echo [parametro 3]: Servidor SQL
echo [parametro 4]: directorio de los fuentes
echo [parametro 5]: directorio del log de instalacion
:fin