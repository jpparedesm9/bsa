---------------------------CREACION DE TABLA
use cob_cartera
go

IF OBJECT_ID ('ca_reporte_pago_tmp_tti') IS NOT NULL
   DROP TABLE ca_reporte_pago_tmp_tti
GO
---------------------------CREACION DE BATCH
use cobis
go
 
declare @w_server varchar(24),
        @w_path_fuente_REG varchar(255),
        @w_path_destino_REG varchar(255),
        @w_batch int, 
        @w_producto int
select @w_batch = 7092, @w_producto = 7

select @w_server = pa_char
from cl_parametro
where pa_producto = 'ADM'
and   pa_nemonico = 'SRVR'
 
select @w_path_fuente_REG = pp_path_fuente, 
       @w_path_destino_REG = pp_path_destino
from ba_path_pro
where pp_producto = @w_producto

if exists (select 1 from ba_batch where ba_batch =  @w_batch and ba_nombre = 'REPORTE DIARIO DE PAGOS TTI' )
begin
   select * from ba_batch where ba_batch = @w_batch and ba_nombre = 'REPORTE DIARIO DE PAGOS TTI'
   delete ba_batch where ba_batch = @w_batch and ba_nombre = 'REPORTE DIARIO DE PAGOS TTI'
end

--PARAMETRO 
if exists(select 1 from ba_parametro where pa_batch = @w_batch)
begin
   select * from ba_parametro where pa_batch = @w_batch
   delete ba_parametro where pa_batch = @w_batch
end
go
