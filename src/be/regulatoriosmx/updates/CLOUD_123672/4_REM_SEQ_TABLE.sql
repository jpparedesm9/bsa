use cob_credito
go

IF OBJECT_ID ('dbo.cr_seqnos_comp_pago_xml') IS NOT NULL
	DROP table dbo.cr_seqnos_comp_pago_xml
go

create table dbo.cr_seqnos_comp_pago_xml
	(
	csc_folio            varchar(50),
	csc_id_documento     varchar(100),	
	csc_num_operation    varchar (24),
	csc_NumParcialidad   int,
	csc_fecha_reg        datetime,
 	csc_fecha_afec       datetime
	
	)
go

create index indx_seqnos_comp
on cob_credito..cr_seqnos_comp_pago_xml(csc_folio,csc_id_documento,csc_num_operation,csc_fecha_reg,csc_fecha_afec)