cls
echo off
echo ***************************************************************************
echo *                        COBIS Internet Banking                           *
echo ***************************************************************************
echo *                             IMPORTANTE                                  *
echo ***************************************************************************
echo * Esta aplicacion es parte de los  paquetes bancarios propiedad de        *
echo * COBISCORP                                                               *
echo * Su uso no autorizado queda  expresamente  prohibido asi como cualquier  *
echo * alteracion o agregado hecho por alguno de sus usuarios sin el debido    *
echo * consentimiento por escrito de COBISCORP.                                *
echo * Este programa esta protegido por la ley de derechos de autor y por las  *
echo * convenciones  internacionales de propiedad intelectual.                 *
echo * Su uso  no  autorizado dara derecho a COBISCORP para obtener ordenes de *
echo * secuestro o retencion  y  para  perseguir  penalmente a  los autores de *
echo * cualquier infraccion.                                                   *
echo ***************************************************************************
echo *                            PROPOSITO                                    *
echo *  Creación de tablas y parámetros en el servidor local                   *
echo ***************************************************************************
echo * FECHA         VERSION   AUTOR         RAZON                             *
echo ***************************************************************************
echo * 21-Feb-2017   4.3.0.0   G.Quisiguina  Emision inicial                   *
echo ***************************************************************************

if "%1" == "" goto ayuda
if "%2" == "" goto ayuda
if "%3" == "" goto ayuda
if "%4" == "" goto ayuda
if "%5" == "" goto ayuda
if "%6" == "" goto ayuda

echo ------------------------------------------------------
echo ------ CREANDO OBJETOS DE BANCA VIRTUAL (LOCAL) ------
echo ------------------------------------------------------

echo %DATE% - %TIME%

if not exist %6 (
  mkdir %6
)

echo 1) CREACION DE TABLAS archivo: se_table.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\se_table.sql -o %6\se_table.out

echo 2) CREACION DE INDICES INTERNOS archivo: se_pkey.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\se_pkey.sql -o %6\se_pkey.out

echo 3) INSERTAR PERFILES: se_perfil.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\se_perfil.sql -o %6\se_perfil.out

echo 4) INSERTAR PARAMETROS: se_ins.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\se_ins.sql -o %6\se_ins.out

echo 5) INSERTAR PLANTILLA bv_template: se_plantilla.sql
sqlcmd -U%1 -P%2 -S%3 -i %5\se_plantilla.sql -o %6\se_plantilla.out

echo 'Fin del Proceso.....'

echo %DATE% - %TIME%
echo ***************************************************************************
echo *           FIN DE LA INSTALACION SQL'S CENTRAL                           *
echo *                Revise los archivos del log                              *
echo *                                                                         *
echo ***************************************************************************

goto fin

echo fullsql.cmd [parametro 1] [parametro 2] [parametro 3] [parametro 4] [parametro 5] [parametro 6]
echo donde:
echo [parametro 1]: usuario de SQL-SERVER
echo [parametro 2]: password del usuario de SQL-SERVER
echo [parametro 3]: nombre del servidor SQL-SERVER
echo [parametro 4]: nombre del servidor COBIS Branch
echo [parametro 5]: directorio de los fuentes
echo [parametro 6]: directorio del log de instalacion
:fin
