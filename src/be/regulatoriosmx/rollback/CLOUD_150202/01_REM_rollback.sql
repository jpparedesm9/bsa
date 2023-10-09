-----------------------------------------------------------------
--- INGRESAR LA DATA ref.caso150202----
-----------------------------------------------------------------
use cob_conta_super
go

if object_id ('info_gen_xml_refacturacion') is not null
    drop table info_gen_xml_refacturacion
go

-----------------------------------------------------------------
--- INGRESAR FECHA A PROCESAR ref.caso150202
-----------------------------------------------------------------
if object_id ('fecha_gen_xml_refacturacion') is not null
    drop table fecha_gen_xml_refacturacion
go

-----------------------------------------------------------------
-----------------------------------------------------------------
--- PARA GENERAR LOS ARCHIVOS ref.caso150202
-----------------------------------------------------------------
if object_id ('gen_xml_refacturacion') is not null
    drop table gen_xml_refacturacion
go

-----------------------------------------------------------------
--- CREACION DE PARAMETRO PARA RUTA  ref.caso150202
if exists (select 1 from cobis..cl_parametro where pa_nemonico = 'RREFX1' and pa_producto = 'REC')
    delete from cobis..cl_parametro where pa_nemonico = 'RREFX1'  and pa_producto = 'REC'
go

-----------------------------------------------------------------
if exists(select 1 from sysobjects where name = 'sp_ing_info_gen_xml_refacturacion')
    drop proc sp_ing_info_gen_xml_refacturacion
go

-----------------------------------------------------------------
if exists(select 1 from sysobjects where name = 'sp_gen_xml_refacturacion')
    drop proc sp_gen_xml_refacturacion
go