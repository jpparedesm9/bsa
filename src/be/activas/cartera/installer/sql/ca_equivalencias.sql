/************************************************************************/
/*    ARCHIVO:         ca_equivalencias.sql                             */
/*    NOMBRE LOGICO:                                                    */
/*    PRODUCTO:        CARTERA                                          */
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
/*  Script de validación de equivalencias codigos cobis,                */
/*  con los codigos del documento entregado                             */
/************************************************************************/
/*                            MODIFICACIONES                            */
/*      FECHA           AUTOR                   RAZON                   */
/*      27/12/2016      Jorge Salazar           Emision Inicial         */  
/************************************************************************/
use cob_conta_super
go

delete cob_conta_super..sb_equivalencias where eq_catalogo in ('CA_SUBTLIN')

insert into sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
values ('CA_SUBTLIN', '130105010000', '01', 'OPERACIONES QUIROGRAFARIAS', 'V')

insert into sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
values ('CA_SUBTLIN', '130105020000', '02', 'OPERACIONES PRENDARIAS', 'V')

insert into sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
values ('CA_SUBTLIN', '130105040000', '03', 'OPERACIONES DE FACTORAJE', 'V')

insert into sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
values ('CA_SUBTLIN', '130105050000', '04', 'OPERACIONES DE ARRENDAMIENTO CAPITALIZABLE', 'V')

insert into sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
values ('CA_SUBTLIN', '130105070000', '05', 'MICROCREDITOS', 'V')

insert into sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
values ('CA_SUBTLIN', '130122000000', '06', 'PRESTAMO DE LIQUIDEZ A OTRAS SOCIEDADES COOPERATIVAS', 'V')

insert into sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
values ('CA_SUBTLIN', '130105060000', '07', 'OTROS', 'V')
go


use cobis
go

DELETE cl_catalogo_pro
  FROM cl_tabla
 WHERE tabla IN ('ca_equivalencias')
   AND codigo = cp_tabla
   
DELETE cl_catalogo FROM cl_tabla
 WHERE cl_tabla.tabla IN ('ca_equivalencias')
   AND cl_tabla.codigo = cl_catalogo.tabla

DELETE cl_tabla WHERE tabla = 'ca_equivalencias'

declare @w_codigo smallint

select @w_codigo = isnull(max(codigo), 0) + 1
from cl_tabla

INSERT INTO cl_tabla (codigo, tabla, descripcion)
VALUES (@w_codigo, 'ca_equivalencias', 'TABLAS DE EQUIVALENCIAS DE CARTERA')

INSERT INTO cl_catalogo_pro VALUES ('CCA', @w_codigo) 

INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, 'CA_SUBTLIN', 'SUBTIPO DE LINEA', 'V', NULL, NULL, NULL)

UPDATE cl_seqnos SET siguiente = CASE WHEN siguiente <= @w_codigo THEN siguiente END
WHERE tabla = 'cl_tabla'
GO

