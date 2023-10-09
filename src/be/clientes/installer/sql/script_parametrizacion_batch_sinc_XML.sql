---------------------------------------------------
-- Creacion y remediacion de estructuras del batch
---------------------------------------------------

use cobis
go

print 'Eliminando el batch ARCHIVOS XML SINCRONIZACION'
delete from cobis..ba_batch 
where ba_batch = 2249
go

print 'Creando el batch ARCHIVOS XML SINCRONIZACION'
insert into cobis..ba_batch
      (ba_batch, ba_nombre                    , ba_descripcion                  , ba_lenguaje, ba_fecha_creacion      , ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado,            ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso,                ba_path_fuente, ba_path_destino)
values(    2249, 'ARCHIVOS XML SINCRONIZACION', 'ARCHIVOS XML SINCRONIZACION',           'SP', '08/3/2017 12:00:00 AM',           2,           'P',              1,         'cl_ente',              null, 'cob_sincroniza..sp_sinc_arch_xml',             1000,         null,      'CLOUDSRV',          'S', 'F:\Vbatch\Clientes\Objetos\', null           )

print 'Eliminando los parametros ARCHIVOS XML SINCRONIZACION'
delete from cobis..ba_parametro 
where pa_batch = 2249
go

print 'Creando los parametros ARCHIVOS XML SINCRONIZACION'
insert into cobis..ba_parametro
      (pa_sarta, pa_batch, pa_ejecucion, pa_parametro,    pa_nombre, pa_tipo, pa_valor)
values(0       ,     2249,            0,            1,  'OPERACION',      'C',      'Q')
insert into cobis..ba_parametro
      (pa_sarta, pa_batch, pa_ejecucion, pa_parametro,    pa_nombre, pa_tipo, pa_valor)
values(0       ,     2249,            0,            2,  'TRANSACCION',    'C',      'S')
insert into cobis..ba_parametro
      (pa_sarta, pa_batch, pa_ejecucion, pa_parametro,    pa_nombre, pa_tipo, pa_valor)
values(0       ,     2249,            0,            3,  'SUBTIPO',        'C',      '0')
insert into cobis..ba_parametro
      (pa_sarta, pa_batch, pa_ejecucion, pa_parametro,    pa_nombre, pa_tipo, pa_valor)
values(2010    ,     2249,            1,            1,  'OPERACION',      'C',      'Q')
insert into cobis..ba_parametro
      (pa_sarta, pa_batch, pa_ejecucion, pa_parametro,    pa_nombre, pa_tipo, pa_valor)
values(2010    ,     2249,            1,            2,  'TRANSACCION',    'C',      'S')
insert into cobis..ba_parametro
      (pa_sarta, pa_batch, pa_ejecucion, pa_parametro,    pa_nombre, pa_tipo, pa_valor)
values(2010    ,     2249,            1,            3,  'SUBTIPO',        'C',      '0')
go

print 'Eliminando la sarta batch ARCHIVOS XML SINCRONIZACION'
delete from cobis..ba_sarta_batch 
where sb_sarta = 2010 and sb_batch = 2249
go

print 'Creando la sarta batch ARCHIVOS XML SINCRONIZACION'
insert into cobis..ba_sarta_batch
      (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
values(    2010,     2249,                   3,           null,           'S',        'N',     500,    550,           2010,           'S')
go

print 'Eliminando el enlace ARCHIVOS XML SINCRONIZACION'
delete from cobis..ba_enlace 
where en_sarta = 2010 and en_batch_inicio  = 2249
go

update cobis..ba_enlace set en_secuencial_inicio = 1, en_batch_fin = 2249 , en_secuencial_fin = 3
where en_sarta = 2010 and en_batch_inicio = 2247
go

print 'Creando el enlace ARCHIVOS XML SINCRONIZACION'
insert into cobis..ba_enlace
      (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
values(    2010,            2249,                    2,           0,                  0,            'S',      null,            'N')


