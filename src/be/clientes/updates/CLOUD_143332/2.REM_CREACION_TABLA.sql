use cobis 
go 


if object_id ('dbo.ns_notif_bio_log') is not null
	drop table dbo.ns_notif_bio_log
go


CREATE TABLE [dbo].[ns_notif_bio_log]  ( 
	[nb_inst_proc]  	int NOT NULL,
	[nb_descripcion]	varchar(1500) NOT NULL,
	[nb_fecha]      	datetime NOT NULL 
	)

CREATE CLUSTERED INDEX nb_index1
	ON dbo.ns_notif_bio_log (nb_inst_proc,nb_fecha)
GO
