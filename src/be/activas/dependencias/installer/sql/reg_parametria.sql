/************************************************************************/
/*    ARCHIVO:         reg_parametria.sql                               */
/*    NOMBRE LOGICO:   reg_parametria.sql                               */
/*    PRODUCTO:        REGULATORIOS                                     */
/************************************************************************/
/*                     IMPORTANTE                                       */
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
/*                     PROPOSITO                                        */
/*  Creacion de parametria inicial para el envio de notificacion        */
/************************************************************************/
/*                            MODIFICACIONES                            */
/*  FECHA           AUTOR                   RAZON                       */
/*  25/08/2016      Ignacio Yupa            Emision Inicial             */
/*  31/08/2016      Jorge Salazar           AHO-H81321-Reporte R08      */
/*  21/12/2016      Jorge Salazar           CCA-H90878 REPORTES         */
/*                                              R0451-R0453             */
/************************************************************************/

use cobis
go
delete cobis..cl_parametro
 where pa_producto = 'REC'
   and pa_nemonico in ('OFCU','NCLN','NOBA','MANO','CLAVEN','SUBREP','FECSIC','CLAPRE')


INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('OFICIAL DE CUMPLIMIENTO', 'OFCU', 'I', NULL, NULL, NULL, 1, NULL, NULL, NULL, 'REC')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('NUMERO DE CLIENTES NOTIFICAR', 'NCLN', 'I', NULL, NULL, NULL, 10, NULL, NULL, NULL, 'REC')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('NOMBRE BANCO', 'NOBA', 'C', 'Cobis Cloud Banking', NULL, NULL, NULL, NULL, NULL, NULL, 'REC')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('MAIL DE NOTIFICADOR', 'MANO', 'C', 'cobiscloud@cobiscorp.com', NULL, NULL, NULL, NULL, NULL, NULL, 'REC')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('CLAVE DE ENTIDAD', 'CLAVEN', 'C', '123456', NULL, NULL, NULL, NULL, NULL, NULL, 'REC')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('SUBREPORTE', 'SUBREP', 'C', '841', NULL, NULL, NULL, NULL, NULL, NULL, 'REC')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('FECHA CONSULTA SIC', 'FECSIC', 'D', NULL, NULL, NULL, NULL, NULL, '01/01/1900', NULL, 'REC')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('CLAVE DE PREVENCION SIC', 'CLASIC', 'C', '1234567890', NULL, NULL, NULL, NULL, NULL, NULL, 'REC')
GO

DELETE cobis..ns_template WHERE te_id = 1 
GO

INSERT INTO cobis..ns_template (te_id, te_tipo, te_cultura, te_nombre, te_estado, te_version)
VALUES (1,'XSLT', 'NEUTRAL', 'NotificacionesEC_ctas.xslt', 'A', '1.0.0.0')
GO

if not exists (select 1 from cobis..ns_template where te_nombre = 'NotificacionGenerica.xslt')
begin
   INSERT INTO cobis..ns_template (te_id,te_tipo,te_cultura,te_nombre,te_estado,te_version) 
   VALUES(1009,'XSLT','','NotificacionGenerica.xslt','A','1.0.0')
declare @w_id_template int
select @w_id_template = max(te_id)+1 from cobis..ns_template

delete from cobis..ns_template where te_nombre  = 'NotificacionDescuento.xslt'

insert into cobis..ns_template values(@w_id_template,'XSLT','NEUTRAL','NotificacionDescuento.xslt','A','1.0.0.0')
go
