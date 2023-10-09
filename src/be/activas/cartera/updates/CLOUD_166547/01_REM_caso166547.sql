----------------------------->>>>>>>>>>>>>>>>>>>>>>>>>>>>>----------------------------->>>>>>>>>>>>>>>>>>>>>>>>>>>>>
----------------------------->>>>>>>>>>>>>>>>>>>>>>>>>>>>>----------------------------->>>>>>>>>>>>>>>>>>>>>>>>>>>>>
use cobis
go

select * from cl_parametro where pa_nemonico = 'ERCTRE' and pa_producto = 'CCA'
delete cl_parametro WHERE pa_nemonico = 'ERCTRE' and pa_producto = 'CCA'

if exists (select 1 from cl_parametro where pa_nemonico = 'ERCTRE' and pa_producto = 'CCA')
    update cl_parametro set pa_int = 5 where pa_nemonico = 'ERCTRE' and pa_producto = 'CCA'
else
    insert into cl_parametro values ('NUM DIAS ANTES PARA ELIMINAR REG CON ERROR CORRESPONSAL_TRN', 'ERCTRE', 'I', NULL, NULL, NULL, 5, NULL, NULL, NULL, 'CCA')
go
----------------------------->>>>>>>>>>>>>>>>>>>>>>>>>>>>>----------------------------->>>>>>>>>>>>>>>>>>>>>>>>>>>>>
----------------------------->>>>>>>>>>>>>>>>>>>>>>>>>>>>>----------------------------->>>>>>>>>>>>>>>>>>>>>>>>>>>>>
use cobis
go

declare @w_batch int
select @w_batch = 7977--se toma el ultimo numero, puede variar.

--Nuevo
select * from ba_batch where ba_batch = @w_batch
delete from ba_batch where ba_batch = @w_batch

insert into dbo.ba_batch (ba_batch,                           ba_nombre,                                 ba_descripcion,                            
                          ba_lenguaje,                        ba_fecha_creacion,                         ba_producto, 
						  ba_tipo_batch,                      ba_sec_corrida,                            ba_ente_procesado, 
						  ba_arch_resultado,                  ba_arch_fuente,                            ba_frec_reg_proc, 
						  ba_impresora,                       ba_serv_destino,                           ba_reproceso, 
						  ba_path_fuente,                     ba_path_destino)
                  values (7977,                               'ELIMINAR REG CON ERROR CORRESPONSAL_TRN', 'ELIMINAR REG CON ERROR CORRESPONSAL_TRN', 
				          'SP',                               getdate(),                                 7, 
						  'P',                                1,                                         NULL, 
						  '',                                 'cob_cartera..sp_act_reg_con_error',       10000, 
						  NULL,                               'CTSSRV',                                  'S', 
						  'C:\Cobis\VBatch\Cartera\Objetos\', 'C:\Cobis\VBatch\Cartera\listados\')
					  
select * from ba_parametro where pa_batch = @w_batch and pa_nombre = 'FECHA PROCESO'
delete from ba_parametro where pa_batch = @w_batch and pa_nombre = 'FECHA PROCESO'

if not exists (select 1 from ba_parametro where pa_batch = @w_batch and pa_nombre = 'FECHA PROCESO')
    insert into ba_parametro(pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre,       pa_tipo, pa_valor)
	                 VALUES (0,       @w_batch, 0,            1,            'FECHA PROCESO',  'D',     '08/06/2021')
go
