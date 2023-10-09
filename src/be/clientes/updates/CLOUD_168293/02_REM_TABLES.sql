use cobis
go

if not exists (select 1 from sys.columns where Name = N'ea_onboarding' and Object_ID = Object_ID(N'cl_ente_aux')) begin
   ALTER TABLE cl_ente_aux
   ADD ea_onboarding char(1) null
end


use cobis
go
if (OBJECT_ID('cl_onboard_id_ext')) IS NOT NULL
    drop table cl_onboard_id_ext
create table cl_onboard_id_ext(
    oi_ente           INT NOT NULL,
    oi_id_expediente  varchar(24) null,
    oi_fecha_registro DATETIME null
)
create index idx_ente on cl_onboard_id_ext (oi_ente)

go

