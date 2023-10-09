/************************************************************************/
/*      Archivo:            ah_param.sql                                */
/*      Base de datos:      cob_ahorros                                 */
/*      Producto:           Cuentas de Ahorros                          */
/*      Disenado por:       Ignacio Yupa                                */
/*      Fecha de escritura: 09/Mayo/2016                                */
/************************************************************************/
/*                              IMPORTANTE                              */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de COBISCorp.                                                       */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como    */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus    */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.   */
/*  Este programa esta protegido por la ley de   derechos de autor      */
/*  y por las    convenciones  internacionales   de  propiedad inte-    */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir        */
/*  penalmente a los autores de cualquier   infraccion.                 */
/************************************************************************/
/*                              PROPOSITO                               */
/*      Este programa realiza la creacion de los parametros generales   */
/*      para el modulo de cuentas de ahorros                            */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR           RAZON                           */
/*    09/Mayo/2016      Ignacio Yupa    Migración a CEN                 */
/*    20/Jul/2016       Eduardo Williams AHO-H77223                     */
/*    22/Jul/2016       Jorge Salazar    AHO-H77275                     */
/*    08/Ago/2016       Jorge Salazar    AHO-H79807                     */
/*    08/Ago/2016       Juan Tagle       AHO-H79806                     */
/************************************************************************/
use cobis
go

delete cl_parametro
	where pa_producto = 'AHO'
	and pa_nemonico in ('PAHCT', 'PAHPR', 'PCANOR', 'PCAME', 'PCAASO', 'PCAASA')

insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('AHORRO PROGRAMADO', 'PAHCT', 'I', NULL, NULL, NULL, 0, NULL, NULL, NULL, 'AHO')

insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('PRODUCTO BANCARIO PROGRESIVO', 'PAHPR', 'I', NULL, NULL, NULL, 0, NULL, NULL, NULL, 'AHO')

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('AHORRO NORMAL', 'PCANOR', 'I', NULL, NULL, NULL, 0, NULL, NULL, NULL, 'AHO')

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('AHORROS MENOR EDAD', 'PCAME', 'I', NULL, NULL, NULL, 0, NULL, NULL, NULL, 'AHO')
    
INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('APORTE SOCIAL ORDINARIO', 'PCAASO', 'I', NULL, NULL, NULL, 0, NULL, NULL, NULL, 'AHO') 

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('APORTE SOCIAL ADICIONAL', 'PCAASA', 'I', NULL, NULL, NULL, 0, NULL, NULL, NULL, 'AHO')

GO
