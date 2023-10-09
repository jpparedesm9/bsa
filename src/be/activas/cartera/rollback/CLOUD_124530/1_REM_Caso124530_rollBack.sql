use cob_cartera
go

IF OBJECT_ID ('dbo.ca_reporte_pagos_elavon') IS NOT NULL
	DROP table dbo.ca_reporte_pagos_elavon
go

declare @w_batch int
select @w_batch = 7450

if exists (select 1 from cobis..ba_batch where ba_batch = @w_batch)
begin
    select * from cobis..ba_batch where ba_batch = @w_batch
	delete cobis..ba_batch where ba_batch = @w_batch
end
else
    print 'No existe el proceso 7450'
go
