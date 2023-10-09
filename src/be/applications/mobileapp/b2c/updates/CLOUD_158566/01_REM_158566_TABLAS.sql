use cob_bvirtual
go

if object_id('cob_bvirtual..bv_b2c_token_tmp') is not null
   drop table cob_bvirtual..bv_b2c_token_tmp

create table bv_b2c_token_tmp (
   tt_token      varchar(10)  not null,
   tt_ente       int          not null
)


if object_id('cob_bvirtual..bv_b2c_registro_tmp') is not null
   drop table cob_bvirtual..bv_b2c_registro_tmp


create table bv_b2c_registro_tmp (
   rt_registro   varchar(10)  not null,
   rt_ente       int          not null
)

go


use cobis
go

alter table ns_detalle_plantilla 
alter column dp_id_plantilla varchar(10) not null

alter table ns_detalle_plantilla 
alter column dp_codigo varchar(10) not null

if not exists (select 1 from sys.columns where Name = N'dmd_eliminar' and Object_ID = Object_ID(N'ns_datos_mensaje_detalle')) begin
   alter table ns_datos_mensaje_detalle
   add dmd_eliminar char(1) null
end
go
