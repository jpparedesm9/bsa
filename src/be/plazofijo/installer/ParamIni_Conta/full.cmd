@echo off
rem ***********************************************************************
rem *    ARCHIVO:         full.cmd
rem *    NOMBRE LOGICO:   full.cmd
rem *    PRODUCTO:        COB_AHORROS
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
rem *   Instalacion de la parametrizacion de Contabilidad de PLAZO FIJO
rem ***********************************************************************
rem *                     MODIFICACIONES
rem *   FECHA        AUTOR      RAZON
rem *  06/May/2016   wtoledo    Emision Inicial

echo off
if "%1"=="" goto ayuda
if "%2"=="" goto ayuda
if "%3"=="" goto ayuda
if "%4"=="" goto ayuda
if "%5"=="" goto ayuda

if not exist %4\log ( 
md %4\log
)

echo ------ PARAMETRIZACIÓN CONTABILIDAD PARA EL MÒDULO DE PLAZO FIJO... ------
echo param_cb_tipo_area.sql
sqlcmd -U%1 -P%2 -S%3 -i %4\param_cb_tipo_area.sql  -o %5\param_cb_tipo_area.out

echo param_cb_area.sql
sqlcmd -U%1 -P%2 -S%3 -i %4\param_cb_area.sql  -o %5\param_cb_area.out

echo param_cb_codigo_valor.sql
sqlcmd -U%1 -P%2 -S%3 -i %4\param_cb_codigo_valor.sql  -o %5\param_cb_codigo_valor.out

echo param_cb_relparam.sql
sqlcmd -U%1 -P%2 -S%3 -i %4\param_cb_relparam.sql -o %5\param_cb_relparam.out

echo param_cb_parametro.sql
sqlcmd -U%1 -P%2 -S%3 -i %4\param_cb_parametro.sql  -o %5\param_cb_parametro.out

echo param_cb_perfil.sql
sqlcmd -U%1 -P%2 -S%3 -i %4\param_cb_perfil.sql  -o %5\param_cb_perfil.out

echo param_cb_det_perfil.sql
sqlcmd -U%1 -P%2 -S%3 -i %4\param_cb_det_perfil.sql  -o %5\param_cb_det_perfil.out

echo param_pf_contable_cat.sql
sqlcmd -U%1 -P%2 -S%3 -i %4\param_pf_contable_cat.sql  -o %5\param_pf_contable_cat.out

echo param_pf_equivalencias.sql
sqlcmd -U%1 -P%2 -S%3 -i %4\param_pf_equivalencias.sql  -o %5\param_pf_equivalencias.out

echo param_pf_plazo_contable.sql
sqlcmd -U%1 -P%2 -S%3 -i %4\param_pf_plazo_contable.sql  -o %5\param_pf_plazo_contable.out

echo param_pf_tranperfil.sql
sqlcmd -U%1 -P%2 -S%3 -i %4\param_pf_tranperfil.sql  -o %5\param_pf_tranperfil.out

echo Fin del Proceso.....

goto fin

:ayuda
echo full.cmd [parametro 1] [parametro 2] [parametro 3] [parametro 4] [parametro 5] 
echo [parametro 1]: usuario de Sybase
echo [parametro 2]: password del usuario de Sybase
echo [parametro 3]: nombre del servidor Sybase
echo [parametro 4]: directorio de los fuentes
echo [parametro 5]: directorio del log de instalacion
:fin
