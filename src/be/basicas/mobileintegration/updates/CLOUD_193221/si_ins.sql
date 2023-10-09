use cob_sincroniza
GO

delete si_catalog_synchronization where sc_catalog_name in ('cr_plazo_ind', 'cr_tplazo_ind', 'cr_plazo_grp','cl_actividad_profesional')

INSERT INTO dbo.si_catalog_synchronization
(sc_catalog_name, sc_synchronization_date)
VALUES('cr_plazo_ind',getdate()) 
GO


INSERT INTO dbo.si_catalog_synchronization
(sc_catalog_name, sc_synchronization_date)
VALUES('cr_tplazo_ind',getdate())
GO


INSERT INTO dbo.si_catalog_synchronization
(sc_catalog_name, sc_synchronization_date)
VALUES('cr_plazo_grp',getdate())
GO

insert into si_catalog_synchronization
(sc_catalog_name,sc_synchronization_date)
values('cl_actividad_profesional', getdate())
go

