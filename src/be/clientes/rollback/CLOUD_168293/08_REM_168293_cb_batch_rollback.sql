--------------------------------------------------------------------------------------------------------------------------------
-- ROLLBACK DE BATCH PARA REPORTE DE GEOLOCALIZACION 168293 F2
--------------------------------------------------------------------------------------------------------------------------------
use cobis
go

declare @w_batch int

select @w_batch = 36450

if exists(select 1 from cobis..ba_batch where ba_batch = @w_batch)
begin
   delete from ba_batch where ba_batch= @w_batch
end 

go
