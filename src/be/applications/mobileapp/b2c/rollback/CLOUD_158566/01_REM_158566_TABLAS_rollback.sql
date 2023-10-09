use cob_bvirtual
go

if object_id('cob_bvirtual..bv_b2c_token_tmp') is not null
   drop table cob_bvirtual..bv_b2c_token_tmp

if object_id('cob_bvirtual..bv_b2c_registro_tmp') is not null
   drop table cob_bvirtual..bv_b2c_registro_tmp

go


use cobis
go


if exists (select 1 from sys.columns where Name = N'dmd_eliminar' and Object_ID = Object_ID(N'ns_datos_mensaje_detalle')) begin
   alter table ns_datos_mensaje_detalle
   drop column dmd_eliminar
end
go
