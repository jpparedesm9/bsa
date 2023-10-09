/***********************************************************************************************************/
---No Bug					: NA
---Título del Bug			: NA
---Fecha					: 27/09/2016
--Descripción del Problema	: Req paso de temporales a definitivas
--Descripción de la Solución: se genera proceso batch para paso a definitivas
--Autor						: EMO
/***********************************************************************************************************/

use cob_conta_tercero
go

if object_id ('ct_extrae_compr') is not null
	drop table ct_extrae_compr
go

create table ct_extrae_compr
	(
	ec_empresa           tinyint       not null,
	ec_fecha_tran        varchar(10)   null,
	ec_comprobante       int           not null,
	ec_oficina_orig      smallint      not null,
	ec_descripcion       varchar (160) not null,
	ec_tot_debito        money         not null,
	ec_tot_credito       money         not null,
	ec_tot_debito_me     money         not null,
	ec_tot_credito_me    money         not null,
	ec_estado            char (1)      not null,
	ec_producto          tinyint       not null,
	ec_perfil            varchar (20)  not null,
	ec_detalles          int           not null,
	ec_asiento           int           not null,
	ec_cuenta            varchar (30)  not null,
	ec_oficina_dest      smallint      not null,
	ec_area_dest         smallint      not null,
    ec_debito            money         null,
	ec_credito           money         null,
	ec_debito_me         money         null,
	ec_credito_me        money         null,
	ec_concepto          varchar (160) not null,
	ec_cotizacion        money         null,
	ec_moneda            tinyint       null
	)
go







use cobis
go


declare @w_fecha_proceso datetime

select @w_fecha_proceso = isnull(fp_fecha, getdate()) from ba_fecha_proceso   

delete cobis..ba_fecha_cierre where fc_producto = 6
insert into cobis..ba_fecha_cierre (fc_producto, fc_fecha_cierre,  fc_fecha_propuesta)
                            values (6,           @w_fecha_proceso, null)

delete cobis..ba_path_pro where pp_producto = 6

insert into cobis..ba_path_pro (pp_producto,  pp_path_fuente,                   pp_path_destino)
                        values (6,            'C:/Cobis/vbatch/conta/objetos/', 'C:/Cobis/vbatch/conta/listados/')

go


declare @w_usuario varchar(64)       

select @w_usuario = 'operador'

delete from cobis..ba_sarta where sa_sarta in (6999)

insert into cobis..ba_sarta (sa_sarta, sa_nombre,                            sa_descripcion,                       sa_fecha_creacion, sa_creador, sa_producto, sa_dependencia, sa_autorizacion)
                     values (6999,     'PROCESOS EVENTUALES CONTA TERCEROS', 'PROCESOS EVENTUALES CONTA TERCEROS', getdate(),         @w_usuario, 6,           null,           null)


delete ba_batch where ba_batch in (6999, 6998)


declare @w_servidor   varchar(30), @w_path_fuente varchar(50), @w_path_destino  varchar(50)

select @w_servidor = pa_char
from   cobis..cl_parametro
where  pa_producto = 'ADM'
and    pa_nemonico = 'SRVR'

select @w_path_destino = pp_path_destino from ba_path_pro where  pp_producto = 6

select @w_path_destino = isnull(@w_path_destino, 'C:/Cobis/vbatch/conta/listados/')

select @w_path_fuente = pp_path_fuente from ba_path_pro where pp_producto = 6

select @w_path_fuente = isnull(@w_path_fuente, 'C:/Cobis/vbatch/conta/objetos/')

     
insert into cobis..ba_batch (ba_batch, ba_nombre,                                    ba_descripcion,                             ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado,   ba_arch_resultado, ba_arch_fuente,                      ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
                     values (6998,     'CONTA TERCEROS - PASO A DEFINITIVAS',        'CONTA TERCEROS - PASO A DEFINITIVAS',      'SP',        getdate(),         6,           'P',           1,              'TABLAS TEMPORALES', 'cont_def.lis',    'cob_pfijo..sp_ct_paso_def',         1000,             'lp',         @w_servidor,     'S',          @w_path_fuente, @w_path_destino)
                                                                                                                                 
insert into cobis..ba_batch (ba_batch, ba_nombre,                                    ba_descripcion,                             ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado,   ba_arch_resultado, ba_arch_fuente,                      ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
                     values (6999,     'CONTA TERCEROS - DESCARGA DE COMPROBANTES', 'CONTA TERCEROS - DESCARGA DE COMPROBANTES', 'SP',        getdate(),         6,           'P',           1,              'TABLAS TEMPORALES', 'cont_def.lis',    'cob_conta..sp_extrae_comprobantes', 1000,             'lp',         @w_servidor,     'S',          @w_path_fuente, @w_path_destino)

delete from cobis..ba_sarta_batch where sb_sarta in (6998, 6999)


insert into cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
                           values (6999,     6998,     1,             null,           'S',           'N',        500,     500,    6999,           'S')

insert into cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
                           values (6999,     6999,     2,             null,           'S',           'N',        1500,    500,    6999,           'S')



--**** parametros ****
delete from cobis..ba_parametro where pa_sarta in (0, 6999) 
                                  and pa_batch in (6998,6999)
go

declare @w_path_destino  varchar(50)

select   
@w_path_destino = pp_path_destino
from ba_path_pro
where pp_producto = 6

select @w_path_destino = isnull(@w_path_destino, 'C:/Cobis/vbatch/conta/listados/')


insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(0,    6998, 0, 1 , 'EMPRESA',       'I', '1')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(0,    6998, 0, 2 , 'PRODUCTO',      'I', '14')

insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(6999, 6998, 1, 1 , 'EMPRESA',       'I', '1')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(6999, 6998, 1, 2 , 'PRODUCTO',      'I', '14')

insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(0,    6999, 0, 1 , 'FECHA_PROCESO', 'D', convert(varchar, getdate(), 101))
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(0,    6999, 0, 2 , 'PRODUCTO',      'C', 'T')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(0,    6999, 0, 3 , 'ARCHIVO',       'C', 'COMPROB_TERCEROS')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(0,    6999, 0, 4 , 'RUTA',          'C', @w_path_destino)

insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(6999, 6999, 2, 1 , 'FECHA_PROCESO', 'D', convert(varchar, getdate(), 101))
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(6999, 6999, 2, 2 , 'PRODUCTO',      'C', 'T')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(6999, 6999, 2, 3 , 'ARCHIVO',       'C', 'COMPROB_TERCEROS')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(6999, 6999, 2, 4 , 'RUTA',          'C', @w_path_destino)


delete from cobis..ba_enlace WHERE en_sarta in (6999)

insert into cobis..ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
                      values (6999,     6998,            1,                    6999,         2,                 'S',            null,      'N')
insert into cobis..ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
                      values (6999,     6999,            2,                    0,            0,                 'S',            null,      'N')
go