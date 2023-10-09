use cobis
go

delete ba_batch
 where ba_producto = 19
   and ba_batch in (19057,19058,19059,19060) --19064)           -- PROCESOS DEL CONSOLIDADOR YA EN PRODUCCION
go

--Fecha cierre
delete cobis..ba_fecha_cierre 
 where fc_producto in (19)

declare @w_fecha_proceso datetime

select @w_fecha_proceso = isnull(fp_fecha, getdate())
  from cobis..ba_fecha_proceso   

insert into cobis..ba_fecha_cierre (fc_producto, fc_fecha_cierre, fc_fecha_propuesta)
values (19, @w_fecha_proceso, null)

--Path de producto
delete cobis..ba_path_pro
 where pp_producto = 19

insert into cobis..ba_path_pro (pp_producto, pp_path_fuente, pp_path_destino)
values (19, 'C:/Cobis/vbatch/custodia/objetos/', 'C:/Cobis/vbatch/custodia/listados/')
go

declare @w_servidor varchar(30),
        @w_path_fuente varchar(50),
        @w_path_destino  varchar(50)
        
select @w_servidor = pa_char
  from cobis..cl_parametro
 where pa_producto = 'ADM'
   and pa_nemonico = 'SRVR'

select   
@w_path_destino = pp_path_destino
from ba_path_pro
where pp_producto = 19

select @w_path_destino = isnull(@w_path_destino, 'C:/Cobis/vbatch/custodia/listados/')

select   
@w_path_fuente = pp_path_fuente
from ba_path_pro
where pp_producto = 19

select @w_path_fuente = isnull(@w_path_fuente, 'C:/Cobis/vbatch/custodia/objetos/')


insert into ba_batch values (19057, 'PROCESO PARA LA CUSTODIA DE GARANTIAS MENSUAL',               'PROCESO PARA LA CUSTODIA DE GARANTIAS MENSUAL',               'SP', getdate(), 19, 'R', 1, 'GARANTIAS', 'prcolate.lis',  'cob_custodia..sp_prcolate_ex',        1000, 'lp', @w_servidor, 'S', @w_path_fuente, @w_path_destino)
insert into ba_batch values (19058, 'FONDO NACIONAL DE GARANTIAS ANEXO N 5 MENSUAL',               'FONDO NACIONAL DE GARANTIAS ANEXO N 5 MENSUAL',               'SP', getdate(), 19, 'R', 1, 'GARANTIAS', 'fng5.txt',      'cob_custodia..sp_fng_5_ex',           20,   'lp', @w_servidor, 'S', @w_path_fuente, @w_path_destino)
insert into ba_batch values (19059, 'FONDO NACIONAL DE GARANTIAS ANEXO N 7 MENSUAL',               'FONDO NACIONAL DE GARANTIAS ANEXO N 7 MENSUAL',               'SP', getdate(), 19, 'R', 1, 'GARANTIAS', 'fng7.txt',      'cob_custodia..sp_fng_7_ex',           20,   'lp', @w_servidor, 'S', @w_path_fuente, @w_path_destino)
--insert into ba_batch values (19064, 'GENERACION DATOS GARANTIAS',                                  'GENERACION DATOS GARANTIAS',                                  'SP', getdate(), 19, 'P', 1, 'GARANTIAS', null,            'cob_custodia..sp_garantias_externo',  20,   null, @w_servidor, 'S', @w_path_fuente, null)
insert into ba_batch values (19060, 'REPORTE CONTABILIZACIOIN DE GARANTIAS',                       'REPORTE CONTABILIZACIOIN DE GARANTIAS',                       'SP', getdate(), 19, 'P', 1, 'GARANTIAS',  NULL,           'cob_conta_super..sp_rep_conta_gar',   20,    NULL, @w_servidor, 'S', @w_path_fuente, @w_path_destino)
go
