--------- SRO
use cobis
go

if exists (select 1 from sys.columns where Name = N'rb_aprobado_por_monto' and Object_ID = Object_ID(N'cobis..cl_respuesta_bio')) begin
  alter table cl_respuesta_bio
  drop column rb_aprobado_por_monto
end

--------- ACHP
use cobis
go

if exists (select 1 from sys.columns where Name = N'rb_aprobado_por_doc' and Object_ID = Object_ID(N'cobis..cl_respuesta_bio')) begin
  alter table cl_respuesta_bio
  drop column rb_aprobado_por_doc
end
go
