--------- SRO
use cobis
go

if not exists (select 1 from sys.columns where Name = N'rb_aprobado_por_monto' and Object_ID = Object_ID(N'cobis..cl_respuesta_bio')) begin
  alter table cl_respuesta_bio
  add rb_aprobado_por_monto char(1)
end

--------- ACHP
use cobis
go

if not exists (select 1 from sys.columns where Name = N'rb_aprobado_por_doc' and Object_ID = Object_ID(N'cobis..cl_respuesta_bio')) begin
  alter table cl_respuesta_bio
  add rb_aprobado_por_doc char(1)
end
go
