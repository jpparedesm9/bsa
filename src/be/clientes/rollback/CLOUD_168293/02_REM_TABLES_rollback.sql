use cobis
go

if exists (select 1 from sys.columns where Name = N'ea_onboarding' and Object_ID = Object_ID(N'cl_ente_aux')) begin
   ALTER TABLE cl_ente_aux
   drop COLUMN ea_onboarding
end

use cobis
go
if (OBJECT_ID('cl_onboard_id_ext')) IS NOT NULL
    drop table cl_onboard_id_ext
go
