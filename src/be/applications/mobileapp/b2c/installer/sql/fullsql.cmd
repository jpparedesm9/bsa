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
echo *  Creación de tablas y parámetros en el servidor central                 *
echo ***************************************************************************
echo * FECHA         VERSION   AUTOR         RAZON                             *
echo ***************************************************************************
echo * 29-Nov-2018   4.3.0.0   E. Ramirez    Emision inicial                   *
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

echo 1) INSERTAR archivo de errores: b2c_error.sql
osql -U%1 -P%2 -S%3  -i %5\b2c_error.sql -o %6\b2c_error.out

echo 2) INSERTAR DATOS cts_serv_catalog: b2c_services.sql
osql -U%1 -P%2 -S%3  -i %5\b2c_services.sql -o %6\b2c_services.out

echo 3) INSERTAR DATOS seguridades Cobis: b2c_segur.sql
osql -U%1 -P%2 -S%3  -i %5\b2c_segur.sql -o %6\b2c_segur.out

echo 4) CREACION DE TIPOS DE DATO: b2c_type.sql
osql -U%1 -P%2 -S%3  -i %5\b2c_type.sql -o %6\b2c_type.out

echo 5) CREACION TABLAS: b2c_table.sql
osql -U%1 -P%2 -S%3  -i %5\b2c_table.sql -o %6\b2c_table.out

echo 6) CREACION TABLA transaccion de servicio: b2c_trser.sql
osql -U%1 -P%2 -S%3  -i %5\b2c_trser.sql -o %6\b2c_trser.out

echo 7) INSERTAR DATOS cl_seqnos: b2c_seqno.sql
osql -U%1 -P%2 -S%3  -i %5\b2c_seqno.sql -o %6\b2c_seqno.out

echo 8) INSERTAR DATOS cl_parametros: b2c_param.sql
osql -U%1 -P%2 -S%3  -i %5\b2c_param.sql -o %6\b2c_param.out

echo 9) INSERTAR DATOS varios: b2c_ins.sql
osql -U%1 -P%2 -S%3  -i %5\b2c_ins.sql -o %6\b2c_ins.out

echo 10) INSERTAR DATOS bv_template: b2c_plantilla.sql
osql -U%1 -P%2 -S%3  -i %5\b2c_plantilla.sql -o %6\b2c_plantilla.out

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
