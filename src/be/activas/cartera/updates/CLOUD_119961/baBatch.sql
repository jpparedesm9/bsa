use cobis 
go

delete from cobis..ba_batch where ba_batch = 7091
delete from cobis..ba_parametro where pa_batch = 7091

insert into cobis..ba_batch values(7091,'CANCELACION ANTICIPADA DE LCR POR INACTIVIDAD','CANCELACION ANTICIPADA DE LCR POR INACTIVIDAD','SP',getdate(),	7,	'P',1,NULL,NULL,'cob_cartera..sp_lcr_cancelacion_ba',10000,	NULL,'CTSSRV','S','C:\Cobis\VBatch\cartera\Objetos\','C:\Cobis\VBatch\cartera\listados\')

insert into ba_parametro values(0,7091,0,1,'FECHA PROCESO','D','09/08/2019')
insert into ba_parametro values(22,7091,5,1,'FECHA PROCESO','D','09/08/2019')

go
