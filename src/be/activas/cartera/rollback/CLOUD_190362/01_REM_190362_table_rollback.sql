--Requerimiento #190362 Impresion de Ficha PI
-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>
use cob_cartera
go

if object_id ('dbo.ca_gen_ficha_pago_ind_det') is not null
	drop table dbo.ca_gen_ficha_pago_ind_det
go

if object_id ('dbo.ca_gen_ficha_pago_ind') is not null
	drop table dbo.ca_gen_ficha_pago_ind
go
-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>


