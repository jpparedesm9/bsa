cls
echo off
echo ***************************************************************************
echo *                               COBIS                                     *
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
echo * Creación de triggers temporales para no crear distribucion              *
echo ***************************************************************************
echo * FECHA         VERSION     AUTOR  RAZON                                  *
echo ***************************************************************************
echo * 30-Abr-2012   4.0.0.0    PCL    Internacionalizacion                    *
echo * 04-MAy-2016              ELO    Migracion de Sybase a SQLSERVER         *
echo ***************************************************************************

if !%1!==!! goto ayuda
if !%2!==!! goto ayuda
if !%3!==!! goto ayuda
if !%5!==!! goto ayuda
if !%6!==!! goto ayuda

echo %DATE% - %TIME%

if not exist %6 (
  mkdir %6
)


REM echo dump
REM sqlcmd  -U%1 -P%2 -S%3 -i %5\dump.sql -o %6\dump.out

echo 1) catalogo_d.tg
sqlcmd  -U%1 -P%2 -S%3 -i %5\catalogo_d.tg -o %6\catalogo_d.out

echo 2) catalogo_i.tg
sqlcmd  -U%1 -P%2 -S%3 -i %5\catalogo_i.tg -o %6\catalogo_i.out

echo 3) catalogo_u.tg
sqlcmd  -U%1 -P%2 -S%3 -i %5\catalogo_u.tg -o %6\catalogo_u.out

echo 4) default_d.tg
sqlcmd  -U%1 -P%2 -S%3 -i %5\default_d.tg -o %6\default_d.out

echo 5) default_i.tg
sqlcmd  -U%1 -P%2 -S%3 -i %5\default_i.tg -o %6\default_i.out

echo 6) default_u.tg
sqlcmd  -U%1 -P%2 -S%3 -i %5\default_u.tg -o %6\default_u.out

echo 7) errores_d.tg
sqlcmd  -U%1 -P%2 -S%3 -i %5\errores_d.tg -o %6\errores_d.out

echo 8) errores_i.tg
sqlcmd  -U%1 -P%2 -S%3 -i %5\errores_i.tg -o %6\errores_i.out

echo 9) errores_u.tg
sqlcmd  -U%1 -P%2 -S%3 -i %5\errores_u.tg -o %6\errores_u.out

echo 10) cl_ttransaccion_d.tg
sqlcmd  -U%1 -P%2 -S%3 -i %5\cl_ttransaccion_d.tg -o %6\cl_ttransaccion_d.out

echo 11) cl_ttransaccion_i.tg
sqlcmd  -U%1 -P%2 -S%3 -i %5\cl_ttransaccion_i.tg -o %6\cl_ttransaccion_i.out

echo 12) cl_ttransaccion_u.tg
sqlcmd  -U%1 -P%2 -S%3 -i %5\cl_ttransaccion_u.tg -o %6\cl_ttransaccion_u.out
echo update_recursos.sql
sqlcmd  -U%1 -P%2 -S%3  -i %5\update_recursos.sql  -o %6\update_recursos.out 

echo %DATE% - %TIME%
echo ***************************************************************************
echo *           FIN DE LA INSTALACION TRIGGERS_TMP CENTRAL                    *
echo *                Revise los archivos del log                              *
echo *                                                                         *
echo ***************************************************************************

goto fin

:ayuda

echo ********************************************************************************
echo *                                   USO                                        *
echo ********************************************************************************
echo fulltg.cmd [parametro 1] [parametro 2] [parametro 3] [parametro 4] [parametro 5] 
echo donde:
echo [parametro 1]: usuario de base de datos
echo [parametro 2]: password del usuario de base de datos
echo [parametro 3]: nombre del servidor COBIS
echo [parametro 4]: directorio de los fuentes
echo [parametro 5]: directorio del log de instalacion
:fin
