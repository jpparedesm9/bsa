
-- Autor: Walther Toledo
-- Fecha: 16/Mar/2023
-- Req. 193221
-- Instalador: \src\be\basicas\mobileintegration\updates\CLOUD_193221\si_ins.sql

use cob_sincroniza
GO

declare @w_date datetime
select @w_date = getdate()

delete si_catalog_synchronization where sc_catalog_name in ('cl_actividad_profesional')

insert into si_catalog_synchronization(sc_catalog_name,sc_synchronization_date) values('cl_actividad_profesional', @w_date)
go

