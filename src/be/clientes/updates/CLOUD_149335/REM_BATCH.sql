use cobis
go

declare 
@w_producto               int,
@w_fecha_proceso          datetime

select @w_producto = pd_producto 
from cobis..cl_producto 
where pd_descripcion = 'CLIENTES'

select @w_fecha_proceso = fp_fecha
from cobis..ba_fecha_proceso

delete cobis..ba_fecha_cierre where fc_producto = @w_producto

insert into ba_fecha_cierre (fc_producto, fc_fecha_cierre, fc_fecha_propuesta)
values (@w_producto, @w_fecha_proceso, NULL)


delete ba_batch where ba_batch = 5100

insert into ba_batch values (
5100,'B2B/WEB LOG DE TRANSACCIONES','REPORTE LOG DE TRANSACCIONES B2B/WEB','SP',getdate(), @w_producto, 'R', 1, 'LOG','LOGB2BWEB','cobis..sp_b2b_web_cons_transacciones',1,'1p','CTSSRV','S',
'C:\cobis\vbatch\clientes\objetos\','C:\cobis\vbatch\clientes\listados\')



go