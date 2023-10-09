/*----------------------------------------------------------------------------------------------------------------*/
--Historia                   : CGS-S146493 Proceso Batch Listas Negras
--Descripción del Problema   : Crear el reporte de solicitud de credito de inclusion
--Responsable                : Patricio Samueza
--Ruta TFS                   : $/COB/Desarrollos/DEV_SaaSMX/Clientes/Backend/sql/cl_batch.sql
--Nombre Archivo             : cl_batch.sql
/*----------------------------------------------------------------------------------------------------------------*/

use cobis
GO

declare @w_serv   varchar(30),
        @w_path_fuente varchar(50),
        @w_path_destino  varchar(50)

select @w_serv = pa_char
from   cobis..cl_parametro
where  pa_nemonico = 'SRVR'
and    pa_producto = 'ADM'

select
     @w_path_destino = pp_path_destino
    ,@w_path_fuente  = pp_path_fuente
from ba_path_pro
where pp_producto = 2



select @w_path_destino = isnull(@w_path_destino, 'C:\Cobis\vbatch\clientes\listados\')
select @w_path_fuente  = isnull(@w_path_fuente,  'C:\Cobis\vbatch\clientes\objetos\')

------Sarta para listado listas negras clientes
delete ba_sarta where sa_sarta=2012
 
INSERT INTO cobis..ba_sarta (sa_sarta, sa_nombre, sa_descripcion, sa_fecha_creacion, sa_creador, sa_producto, sa_dependencia, sa_autorizacion)
VALUES (2012, 'CLIENTES LISTA NEGRAS', 'CLIENTES LISTA NEGRAS', '2017-11-24 08:47:24.42', 'psamueza', 2, NULL, NULL)


/*
delete cobis..ba_batch where ba_batch=2212
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2212, 'CLIENTES ', 'CLIENTES ', 'QR', '2017-11-24', 2, 'R', 1, 'REGISTROS', 'cl_linegra.lis', 'cl_linegra.sqr', 1000, 'lp', @w_serv, 'S', @w_path_fuente, @w_path_destino)
*/
print 'Eliminando el batch para clientes listas negras'
delete from cobis..ba_batch 
where ba_batch = 2253--cambiar


print 'Creando el batch de lista negra clientes'
insert into cobis..ba_batch
      (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado,ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso,ba_path_fuente, ba_path_destino)
values(2253, 'ARCHIVOS DE CLIENTES EN LISTAS NEGRAS', 'ARCHIVOS DE CLIENTE EN LISTAS NEGRAS','SP', '2017-11-24',2,'P',1,'cl_ente',null, 'cobis..sp_batch_lista_negra',1000,null,'CLOUDSRV','S', @w_path_fuente, null)

print 'Eliminando los parametros lista negra  CLIENTE'
delete from cobis..ba_parametro 
where pa_batch = 2253
go

print'Creando los parametros ARCHIVOS XML SINCRONIZACION'
insert into cobis..ba_parametro
(pa_sarta, pa_batch, pa_ejecucion, pa_parametro,    pa_nombre, pa_tipo, pa_valor)
values(0       ,     2253,            0,            1,  'OPERACION',      'C',      'Q')

insert into cobis..ba_parametro
      (pa_sarta, pa_batch, pa_ejecucion, pa_parametro,    pa_nombre, pa_tipo, pa_valor)
values(0       ,     2253,            0,            2,  'MODO',        'C',      '1')

insert into cobis..ba_parametro
      (pa_sarta, pa_batch, pa_ejecucion, pa_parametro,    pa_nombre, pa_tipo, pa_valor)
values(0       ,     2253,            0,            3,  'FECHA PROCESO', 'D', '11/24/2017')

insert into cobis..ba_parametro
(pa_sarta, pa_batch, pa_ejecucion, pa_parametro,    pa_nombre, pa_tipo, pa_valor)
values(2012       ,     2253,            1,            1,  'OPERACION',      'C',      'Q')

insert into cobis..ba_parametro
      (pa_sarta, pa_batch, pa_ejecucion, pa_parametro,    pa_nombre, pa_tipo, pa_valor)
values(2012      ,     2253,            1,            2,  'MODO',        'C',      '1')

insert into cobis..ba_parametro
      (pa_sarta, pa_batch, pa_ejecucion, pa_parametro,    pa_nombre, pa_tipo, pa_valor)
values(2012       ,     2253,            1,            3,  'FECHA PROCESO', 'D', '11/24/2017')


print 'Eliminando la sarta batch ARCHIVOS LISTA NEGRA'
delete from cobis..ba_sarta_batch 
where sb_sarta = 2012 and sb_batch = 2253
go

print 'Creando la sarta batch listas negras'
insert into cobis..ba_sarta_batch
      (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
values(    2012,    2253,                   1,           null,           'S',        'N',     500,    550,           2012,           'S')
go

print 'Eliminando el enlace Listas negras'
delete from cobis..ba_enlace 
where en_sarta = 2012 and en_batch_inicio  = 2253
go

/*update cobis..ba_enlace set en_secuencial_inicio = 1, en_batch_fin = 0 , en_secuencial_fin = 0
where en_sarta = 2010 and en_batch_inicio = 2247
go*/

print 'Creando el enlace ARCHIVOS listas negras'
insert into cobis..ba_enlace
      (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
values(    2012,            2253,                    1,           0,                 0,            'S',      null,            'N')

