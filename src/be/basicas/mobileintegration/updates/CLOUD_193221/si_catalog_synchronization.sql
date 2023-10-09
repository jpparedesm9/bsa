USE cob_sincroniza
GO

if OBJECT_ID (N'dbo.si_catalog_synchronization', N'U') is not NULL
   drop table dbo.si_catalog_synchronization
GO

CREATE TABLE si_catalog_synchronization (
	sc_catalog_name varchar(30) NOT NULL,
	sc_synchronization_date datetime NOT NULL
)
GO