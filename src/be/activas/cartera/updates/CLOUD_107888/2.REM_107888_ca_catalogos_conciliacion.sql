/*************************************************************************/
/*   Archivo:              REM_107888_ca_catalogos_conciliacion.sql      */
/*   Stored procedure:     REM_107888_ca_catalogos_conciliacion.sql      */
/*   Base de datos:        cobis		                               	 */
/*   Producto:             cartera                                  	 */
/*   Disenado por:         jlsdv                                         */
/*   Fecha de escritura:   Marzo 2019                                  	 */
/*************************************************************************/
/*                                  IMPORTANTE                           */
/*   Este programa es parte de los paquetes bancarios propiedad de       */
/*   'COBIS'.                                                            */
/*   Su uso no autorizado queda expresamente prohibido asi como          */
/*   cualquier alteracion o agregado hecho por alguno de sus             */
/*   usuarios sin el debido consentimiento por escrito de la             */
/*   Presidencia Ejecutiva de COBIS o su representante legal.            */
/*************************************************************************/
/*                                   PROPOSITO                           */
/*   	Script para la creacion de catalogos para el caso #107888        */
/*                              CAMBIOS                                  */
/*************************************************************************/
/*                             MODIFICACION                              */
/*    FECHA                 AUTOR                 RAZON                  */
/*    15/Marzo/2019       	Jose Sánchez          Emision inicial        */
/*                                                                       */
/*************************************************************************/
use cobis
go

------------------------------------------------
-- catalogo ca_corresponsal
------------------------------------------------
delete from cl_catalogo where tabla = (select codigo from cl_tabla where tabla ='ca_corresponsal')
delete from cl_catalogo_pro where cp_tabla = (select codigo from cl_tabla where tabla ='ca_corresponsal')
delete from cl_tabla where tabla ='ca_corresponsal'

go
 
declare @w_id_catalogo int
 
select @w_id_catalogo = max(codigo) + 1 from cl_tabla
 
insert into cl_tabla (codigo, tabla, descripcion) 
values (@w_id_catalogo, 'ca_corresponsal', 'Corresponsal')
 
insert into cl_catalogo_pro (cp_producto, cp_tabla)
values ('CCA', @w_id_catalogo)
 
insert into cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type) 
values (@w_id_catalogo, 'SANTANDER', 'SANTANDER', 'V', NULL, NULL, NULL)

go

------------------------------------------------
-- catalogo ca_tipo_pago_corresponsal
------------------------------------------------
delete from cl_catalogo where tabla = (select codigo from cl_tabla where tabla ='ca_tipo_pago_corresponsal')
delete from cl_catalogo_pro where cp_tabla = (select codigo from cl_tabla where tabla ='ca_tipo_pago_corresponsal')
delete from cl_tabla where tabla ='ca_tipo_pago_corresponsal'
 
go
 
declare @w_id_catalogo int
 
select @w_id_catalogo = max(codigo) + 1 from cl_tabla
 
insert into cl_tabla (codigo, tabla, descripcion) 
values (@w_id_catalogo, 'ca_tipo_pago_corresponsal', 'Tipo de Pago Corresponsal')
 
insert into cl_catalogo_pro (cp_producto, cp_tabla) 
values ('CCA', @w_id_catalogo)
 
insert into cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type) 
values (@w_id_catalogo, 'TO', 'Todos', 'V', NULL, NULL, NULL)

insert into cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type) 
values (@w_id_catalogo, 'PG', 'Pago Grupal', 'V', NULL, NULL, NULL)

insert into cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type) 
values (@w_id_catalogo, 'PI', 'Pago Individual', 'V', NULL, NULL, NULL)

insert into cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type) 
values (@w_id_catalogo, 'CG', 'Cancelación Grupal', 'V', NULL, NULL, NULL)

insert into cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type) 
values (@w_id_catalogo, 'CI', 'Cancelación Individual', 'V', NULL, NULL, NULL)

insert into cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type) 
values (@w_id_catalogo, 'GL', 'Pago de Garantias', 'V', NULL, NULL, NULL) 

go

------------------------------------------------
-- catalogo ca_no_concilia_corresponsal
------------------------------------------------
delete from cl_catalogo where tabla = (select codigo from cl_tabla where tabla ='ca_no_concilia_corresponsal')
delete from cl_catalogo_pro where cp_tabla = (select codigo from cl_tabla where tabla ='ca_no_concilia_corresponsal')
delete from cl_tabla where tabla ='ca_no_concilia_corresponsal'

go
 
declare @w_id_catalogo int
 
select @w_id_catalogo = max(codigo) + 1 from cl_tabla
 
insert into cl_tabla (codigo, tabla, descripcion) 
values (@w_id_catalogo, 'ca_no_concilia_corresponsal', 'RazÃ³n por la que no concilia corresponsal')
 
insert into cl_catalogo_pro (cp_producto, cp_tabla)
values ('CCA', @w_id_catalogo)

insert into cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
values (@w_id_catalogo, 'T', 'Todos', 'V', NULL, NULL, NULL)
 
insert into cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
values (@w_id_catalogo, 'C', 'Húerfano Cobis', 'V', NULL, NULL, NULL)

insert into cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
values (@w_id_catalogo, 'A', 'Húerfano Archivo', 'V', NULL, NULL, NULL)

go

------------------------------------------------
-- catalogo ca_estado_pago_corresponsal
------------------------------------------------
delete from cl_catalogo where tabla = (select codigo from cl_tabla where tabla ='ca_estado_pago_corresponsal')
delete from cl_catalogo_pro where cp_tabla = (select codigo from cl_tabla where tabla ='ca_estado_pago_corresponsal')
delete from cl_tabla where tabla ='ca_estado_pago_corresponsal'

go
 
declare @w_id_catalogo int
 
select @w_id_catalogo = max(codigo) + 1 from cl_tabla
 
insert into cl_tabla (codigo, tabla, descripcion) 
values (@w_id_catalogo, 'ca_estado_pago_corresponsal', 'Estado de Pago en COBIS')
 
insert into cl_catalogo_pro (cp_producto, cp_tabla)
values ('CCA', @w_id_catalogo)
 
insert into cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
values (@w_id_catalogo, 'T', 'Todos', 'V', NULL, NULL, NULL)

insert into cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
values (@w_id_catalogo, 'A', 'Aplicado', 'V', NULL, NULL, NULL)

insert into cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
values (@w_id_catalogo, 'I', 'Ingresado', 'V', NULL, NULL, NULL)

insert into cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
values (@w_id_catalogo, 'E', 'Error', 'V', NULL, NULL, NULL)

insert into cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
values (@w_id_catalogo, 'P', 'Procesado', 'V', NULL, NULL, NULL)

insert into cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
values (@w_id_catalogo, 'R', 'Reversado', 'V', NULL, NULL, NULL)

go

------------------------------------------------
-- catalogo sb_corresponsal_archivo
------------------------------------------------
use cobis
go

delete from cl_catalogo where tabla = (select codigo from cl_tabla where tabla ='sb_corresponsal_archivo')
delete from cl_catalogo_pro where cp_tabla = (select codigo from cl_tabla where tabla ='sb_corresponsal_archivo')
delete from cl_tabla where tabla ='sb_corresponsal_archivo'
go

declare @w_catalog_id int

select @w_catalog_id = max(codigo)+1 from cobis..cl_tabla

insert into cobis..cl_tabla
values(@w_catalog_id,'sb_corresponsal_archivo','Corresponsal Archivo')

insert into cl_catalogo_pro (cp_producto, cp_tabla)
values ('CCA', @w_catalog_id)

insert into cobis..cl_catalogo(tabla, codigo, valor, estado)
values(@w_catalog_id,'H2H_','SANTANDER','V')

go
