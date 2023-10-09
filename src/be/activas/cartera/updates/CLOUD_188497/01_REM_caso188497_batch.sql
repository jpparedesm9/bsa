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

insert into ba_batch(ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino) 
values (@w_batch, 'GENERA XML PROXIMO VENCIMIENTO DE CUOTAS', 'GENERA ARCHIVO XML PARA ENVIO DE CORREO ELECTRONICO DE AVISO PROXIMO VENCIMIENTO A DEUDORES', 'SP', getdate(), 7, 'R', 1, 'CARTERA', 'referenciadepago.xml', 'cob_cartera..sp_prox_vencimientos_cuotas', 10000, NULL, @w_server, 'S', 'C:\Notificador\notification\', 'C:\Notificador\notification\xml\')

select * from ba_batch where ba_batch = @w_batch

-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>
--REGISTRO DE PARAMETROS
------->>>>>>>Registro de parametros para batch
select * from cobis..ba_parametro where pa_batch =  @w_batch
delete from ba_parametro where pa_batch = @w_batch

insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
values (0, @w_batch, 0, 1, 'FECHA_PROCESO', 'D', '07/14/2022')

insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
values (0, @w_batch, 0, 2, 'OPERACION', 'C', '')

select * from ba_parametro where pa_batch = @w_batch

go
