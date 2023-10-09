--------------------------------------------------------------------------------------------------------------------------------
-- ELIMINACION DE BATCH PARA REPORTE DE MODIFICACIÓN DE DATOS
--------------------------------------------------------------------------------------------------------------------------------
use cobis
go

if exists (select 1 from cobis..ba_batch where ba_batch = 28799)
begin
   print 'Ingreso a borrar el proceso batch'
   delete from cobis..ba_batch where ba_batch = 28799   
end

if exists (select 1 from ba_parametro where pa_batch = 28799 and pa_nombre = 'FECHA PROCESO' )
  delete from ba_parametro where pa_batch = 28799 and pa_nombre = 'FECHA PROCESO'

if exists(select 1 from ba_parametro where pa_batch = 28799 and pa_nombre = 'PROCESO')
  delete from ba_parametro where pa_batch = 28799 and pa_nombre = 'PROCESO'

if exists(select 1 from ba_parametro where pa_batch = 28799 and pa_nombre = 'FORMATO FECHA')
  delete from ba_parametro where pa_batch = 28799 and pa_nombre = 'FORMATO FECHA' 

go 
