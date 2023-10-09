--referencia: select * from cobis..ba_parametro where pa_batch = 7077
-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>
--CREACION DE BATCH
use cobis
go

declare @w_batch int, @w_server varchar(30)
select @w_batch = 7077

select @w_server = pa_char from cl_parametro where pa_producto = 'ADM' and   pa_nemonico = 'SRVR'

------->>>>>>>Registro de batch
select * from ba_batch where ba_batch = @w_batch

delete from ba_batch where ba_batch = @w_batch

select * from ba_batch where ba_batch = @w_batch

-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>
--REGISTRO DE PARAMETROS
------->>>>>>>Registro de parametros para batch
select * from cobis..ba_parametro where pa_batch =  @w_batch

delete from ba_parametro where pa_batch = @w_batch

select * from ba_parametro where pa_batch = @w_batch

go
