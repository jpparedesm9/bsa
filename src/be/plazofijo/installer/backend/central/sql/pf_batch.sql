/************************************************************************/
/*                 Descripcion                                          */
/*  Script para creacion de procesos Batch                              */
/************************************************************************/
/*                                                                      */
/*  Fecha         Autor               Comentario                        */
/*  07/07/2016    Oscar Saavedra      Instalador Version Davivienda     */
/************************************************************************/
use cobis
go

SET NOCOUNT ON
go

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

print '****************************************'
print '*****  CREACION DE PROCESOS BATCH ******'
print '****************************************'
print ''
print 'Inicio Ejecucion Creacion de Procesos Batch Plazo Fijo : ' + convert(varchar(60),getdate(),109)
print ''



print '-->Procesos Batch: Batch-Producto'
if exists (select 1 from cobis..ba_path_pro where pp_producto in (14))
   delete cobis..ba_path_pro where pp_producto in (14)
go

insert into cobis..ba_path_pro values ('14', 'C:/Cobis/vbatch/pfijo/objetos/', 'C:/Cobis/vbatch/pfijo/listados/')
go

print '-->Procesos Batch: Producto-Moneda'
if exists (select 1 from cobis..cl_pro_moneda where pm_producto in (14))
   delete cobis..cl_pro_moneda where pm_producto in (14)
go

insert into cobis..cl_pro_moneda values ('14', 'R', '0', 'PFI', convert(varchar(60),getdate(),101), 'V')
go

print '-->Procesos Batch: Sarta'
if exists (select 1 from cobis..ba_sarta where sa_sarta like '14%')
   delete cobis..ba_sarta where sa_sarta like '14%'
go

declare @w_fecha_proceso datetime
select @w_fecha_proceso = convert(varchar, fp_fecha, 101) from cobis..ba_fecha_proceso

insert into cobis..ba_sarta values (14000,'INICIO DE DIA','LOTE DE INICIO DE DIA',                                          @w_fecha_proceso, 'sa', 14, null, null)
insert into cobis..ba_sarta values (14001,'CONTABILIDAD DE PLAZO FIJO','CONTABILIDAD DE PLAZO FIJO',                        @w_fecha_proceso, 'sa', 14, null, null)
insert into cobis..ba_sarta values (14002,'TRANSACCIONES MONETARIAS PLAZO FIJO','TRANSACCIONES MONETARIAS PLAZO FIJO',      @w_fecha_proceso, 'sa', 14, null, null)
insert into cobis..ba_sarta values (14003,'CONTABILIDAD FIN DE SEMANA PLAZO FIJO','CONTABILIDAD FIN DE SEMANA PLAZO FIJO',  @w_fecha_proceso, 'sa', 14, null, null)
insert into cobis..ba_sarta values (14004,'BOC - PLAZO FIJO','BOC - PLAZO FIJO',                                            @w_fecha_proceso, 'sa', 14, null, null)
insert into cobis..ba_sarta values (14005,'REPORTES EVENTUALES PLAZO FIJO','REPORTES EVENTUALES PLAZO FIJO',                @w_fecha_proceso, 'sa', 14, null, null)
go

print '-->Procesos Batch: Batch'
if exists (select 1 from cobis..ba_sarta_batch, cobis..ba_batch where sb_sarta like '14%' and sb_batch = ba_batch)
   delete cobis..ba_batch from cobis..ba_sarta_batch, cobis..ba_batch where sb_sarta like '14%' and sb_batch = ba_batch
go

declare @w_fecha_proceso datetime
declare @w_path_fuente varchar(255)
declare @w_path_destino varchar(255)
declare @w_servidor varchar(255)

select @w_fecha_proceso = convert(varchar, fp_fecha, 101)
from   cobis..ba_fecha_proceso

select @w_path_fuente  = pp_path_fuente,
       @w_path_destino = pp_path_destino
from   cobis..ba_path_pro where pp_producto = 14

select @w_servidor = pa_char
from   cobis..cl_parametro
where  pa_producto = 'ADM'
and    pa_nemonico = 'SRVR'

insert into cobis..ba_batch values ('14001', 'INICIO DE DIA',                                       'PROCESO DE INICIO DE DIA',                                                                                                                                                          'SP ', @w_fecha_proceso, '14', 'P', '1', 'PF_OPERACION,PF_REG_CONTROL,PF_MOV_MONET', '',                         'cob_pfijo..sp_inidia',               '50',   '',   @w_servidor, 'S', @w_path_fuente, @w_path_destino)
insert into cobis..ba_batch values ('14003', 'GENERACION DE TOTALES PARA GRAFICOS ESTADISTICOS',    'GENERACION DE TABLA DE TOTALES PARA LOS GRAFICOS ESTADISTICOS EN EL FRONT-END DEL MODULO',                                                                                          'SP ', @w_fecha_proceso, '14', 'P', '1', 'PF_ESTADISTICA',                           '',                         'cob_pfijo..sp_graba_totales',        '50',   '',   @w_servidor, 'S', @w_path_fuente, @w_path_destino)
insert into cobis..ba_batch values ('14005', 'PROGRAMA DE CONTABILIDAD',                            'PROGRAMA DE CONTABILIDAD',                                                                                                                                                          'SP ', @w_fecha_proceso, '14', 'R', '1', 'PF_TRANSACCION',                           'texto.lis',                'cob_pfijo..sp_conta',                '50',   'lp', @w_servidor, 'S', @w_path_fuente, @w_path_destino)
insert into cobis..ba_batch values ('14006', 'DESMARCADOR',                                         'DESMARCADOR',                                                                                                                                                                       'SP ', @w_fecha_proceso, '14', 'R', '1', '',                                         'texto.lis',                'cob_pfijo..sp_desmarcar_trn',        '50',   'lp', @w_servidor, 'S', @w_path_fuente, @w_path_destino)
insert into cobis..ba_batch values ('14007', 'REP DE ORD DE PAG EMITIDAS',                          'EMITE LIST DE ORD DE PAG EMITIDAS, EJEC DESP DEL INI DIA',                                                                                                                          'QR ', @w_fecha_proceso, '14', 'R', '1', 'PF_MOV_MON,PF_OPER',                       'pf_ordpa.lis',             'pf_ordpa.sqr',                       '50',   'lp', @w_servidor, 'S', @w_path_fuente, @w_path_destino)
insert into cobis..ba_batch values ('14008', 'REPORTE DE PROVISION DIARIA DE INTERESES',            'PERMITE VISUALIZAR LAS CANTIDADES QUE SE PROVISIONAN O AMORTIZAN EN EL DIA. IMPRIME LA PROVISION ACUMULADA, NUMERO DE DIAS PROVISIONADOS, INTERES PAGADO O INTERES POR AMORTIZAR.', 'QR ', @w_fecha_proceso, '14', 'R', '1', 'PF_OPERACION,CL_CIUDAD,CL_OFICINA',        'pf_prami.lis',             'pf_prami.sqr',                       '50',   'lp', @w_servidor, 'S', @w_path_fuente, @w_path_destino)
insert into cobis..ba_batch values ('14009', 'REC',                                                 'REC',                                                                                                                                                                               'SP ', @w_fecha_proceso, '14', 'R', '1', '',                                         'texto.lis',                'cob_pfijo..sp_consolidador',         '50',   'lp', @w_servidor, 'S', @w_path_fuente, @w_path_destino)
insert into cobis..ba_batch values ('14011', 'REPORTE DE TRANSACCIONES MONETARIAS - FORMATO 444',   'REPORTE DE TRANSACCIONES MONETARIAS - FORMATO 444. REQ_186_V1.07/16/2011.JCCC',                                                                                                     'SP ', @w_fecha_proceso, '14', 'R', '1', 'TRANSACCIONES',                            'transacciones.lis',        'cob_pfijo..sp_mensual_monetarias',   '1000', 'lp', @w_servidor, 'S', @w_path_fuente, @w_path_destino)
insert into cobis..ba_batch values ('14030', 'GENERACION REPORTE INTERESES CAUSADOS NO PAGADOS',    'GENERACION REPORTE INTERESES CAUSADOS NO PAGADOS  ORS_602          08/01/2013',                                                                                                     'SP ', @w_fecha_proceso, '14', 'R', '1', 'CDTS',                                     'interes_causado_aaaammdd', 'cob_pfijo..sp_intereses_cancelados', '1000', 'lp', @w_servidor, 'S', @w_path_fuente, @w_path_destino)
insert into cobis..ba_batch values ('14048', 'REPORTE DE ERROR BATCH',                              'LISTADO DE LOG DE ERRORES',                                                                                                                                                         'QR ', @w_fecha_proceso, '14', 'R', '1', 'PF_ERRORLOG,PF_OPERACION,CL_ERRORES',      'pf_loger.lis',             'pf_loger.sqr',                       '50',   'lp', @w_servidor, 'S', @w_path_fuente, @w_path_destino)
insert into cobis..ba_batch values ('14073', 'DESBLOQUEO BLOQUEO CDT',                              'DESBLOQUEO BLOQUEO CDT  CCA_520',                                                                                                                                                   'SP ', @w_fecha_proceso, '14', 'R', '1', 'OPERACIONES',                              'NOMBRE_ARCHIVO.txt',       'cob_pfijo..sp_lev_bloqueo',          '1000', 'lp', @w_servidor, 'S', @w_path_fuente, @w_path_destino)
insert into cobis..ba_batch values ('14087', 'REPORTE DE VENCIMIENTOS DE CDTS',                     'REPORTE DE VENCIMIENTOS DE CDTS  FTO_PARAM_BATCH_ORS_001165_V01.xlsx',                                                                                                              'SP ', @w_fecha_proceso, '14', 'R', '1', 'OFICINAS',                                 'REPORTE_VENC_CDT_',        'cob_pfijo..sp_pf_rep_ven_cdt',       '1000', 'lp', @w_servidor, 'S', @w_path_fuente, @w_path_destino)
insert into cobis..ba_batch values ('14090', 'GENERACION ARCHIVO (P) DECEVAL',                      'GENERACION ARCHIVO (P) DECEVAL',                                                                                                                                                    'SP ', @w_fecha_proceso, '14', 'R', '1', '',                                         'arch_deceval_p.lis',       'cob_pfijo..sp_arch_deceval_p',       '50',   'lp', @w_servidor, 'S', @w_path_fuente, @w_path_destino)
insert into cobis..ba_batch values ('14091', 'CARGA ARCHIVO (Z) DECEVAL',                           'CARGA ARCHIVO (Z) DECEVAL',                                                                                                                                                         'SP ', @w_fecha_proceso, '14', 'R', '1', '',                                         'arch_deceval_p.lis',       'cob_pfijo..sp_arch_deceval_z',       '50',   'lp', @w_servidor, 'S', @w_path_fuente, @w_path_destino)
insert into cobis..ba_batch values ('14092', 'REPORTE OPERACIONES DECEVAL',                         'REPORTE OPERACIONES DECEVAL',                                                                                                                                                       'SP ', @w_fecha_proceso, '14', 'R', '1', '',                                         'deceval.lis',              'deceval.sqr',                        '50',   'lp', @w_servidor, 'S', @w_path_fuente, @w_path_destino)
insert into cobis..ba_batch values ('14093', 'MAESTRO PLAZO FIJO',                                  'GENERA ARCHIVO PLANO MAESTRO PFIJO',                                                                                                                                                'SP ', @w_fecha_proceso, '14', 'R', '1', 'PF_OPERACION,PF_CUOTAS',                   'maestro_pf.lis',           'cob_pfijo..maestro_pf',              '50',   'lp', @w_servidor, 'S', @w_path_fuente, @w_path_destino)
insert into cobis..ba_batch values ('14094', 'MAESTRO PROYECCIONES FIJO',                           'GENERA ARCHIVO PLANO MAESTRO PROYECCIONES PFIJO',                                                                                                                                   'SP ', @w_fecha_proceso, '14', 'R', '1', 'PF_OPERACION,PF_CUOTAS',                   'mestro_pry_pf.lis',        'cob_pfijo..maestro_pry_pf',          '50',   'lp', @w_servidor, 'S', @w_path_fuente, @w_path_destino)
insert into cobis..ba_batch values ('14999', 'EJECUCIONES BOC PLAZO FIJO',                          'EJECUCIONES BOC PLAZO FIJO',                                                                                                                                                        'SP ', @w_fecha_proceso, '14', 'P', '1', 'PLAZO FIJO',                               '',                         'cob_pfijo..sp_boc',                  '1000', '',   @w_servidor, 'S', @w_path_fuente, @w_path_destino)
insert into cobis..ba_batch values ('6525',  'VALIDACION DE COMPROBANTES POR PRODUCTO',             'VALIDACION DE COMPROBANTES POR PRODUCTO',                                                                                                                                           'SP ', @w_fecha_proceso, '6',  'P', '1', 'COMPROBANTES',                             '',                         'cob_conta..sp_ejec_asientos_val',    '100',  '',   @w_servidor, 'S', @w_path_fuente, @w_path_destino)
go

print '-->Procesos Batch: Sarta-Batch'
if exists (select 1 from cobis..ba_sarta_batch where sb_sarta like '14%')
   delete cobis..ba_sarta_batch where sb_sarta like '14%'
go

insert into cobis..ba_sarta_batch values (14000, 14001, 1,  null, 'S', 'N', 500,  500,  14000, 'N')
insert into cobis..ba_sarta_batch values (14000, 14048, 2,  '1',  'S', 'N', 1500, 500,  14000, 'S')
insert into cobis..ba_sarta_batch values (14000, 14007, 3,  '2',  'S', 'N', 2500, 500,  14000, 'S')

insert into cobis..ba_sarta_batch values (14001, 6525,  1,  null, 'S', 'N', 500,  500,  14001, 'S')
insert into cobis..ba_sarta_batch values (14001, 14003, 2,  null, 'S', 'N', 1500, 500,  14001, 'N')
insert into cobis..ba_sarta_batch values (14001, 14005, 3,  '2',  'S', 'N', 2500, 500,  14001, 'S')
insert into cobis..ba_sarta_batch values (14001, 14006, 4,  '1',  'S', 'N', 3500, 500,  14001, 'S')
insert into cobis..ba_sarta_batch values (14001, 14009, 5,  '4',  'S', 'N', 4500, 500,  14001, 'S')
insert into cobis..ba_sarta_batch values (14001, 14048, 6,  '5',  'S', 'N', 500,  1500, 14001, 'S')
insert into cobis..ba_sarta_batch values (14001, 14008, 7,  null, 'S', 'N', 1500, 1500, 14001, 'S')
insert into cobis..ba_sarta_batch values (14001, 14090, 8,  null, 'S', 'N', 2500, 1500, 14001, 'S')
insert into cobis..ba_sarta_batch values (14001, 14091, 9,  '8',  'S', 'N', 3500, 1500, 14001, 'S')
insert into cobis..ba_sarta_batch values (14001, 14092, 10, '9',  'S', 'N', 4500, 1500, 14001, 'S')
insert into cobis..ba_sarta_batch values (14001, 14093, 11, '10', 'S', 'N', 5500, 1500, 14001, 'S')
insert into cobis..ba_sarta_batch values (14001, 14094, 12, '11', 'S', 'N', 6500, 1500,  14001, 'S')


insert into cobis..ba_sarta_batch values (14002, 14011, 1, null,  'S', 'N', 500, 500, 14002, 'S')

insert into cobis..ba_sarta_batch values (14003, 14005, 1, null,  'S', 'N', 500,  500, 14003, 'N')
insert into cobis..ba_sarta_batch values (14003, 6525,  2, '1',   'S', 'N', 1500, 500, 14003, 'S')
insert into cobis..ba_sarta_batch values (14003, 14006, 3, '2',   'S', 'N', 2500, 500, 14003, 'S')

insert into cobis..ba_sarta_batch values (14004, 14999, 1, null,  'S', 'N', 500, 500, 14004, 'N')

insert into cobis..ba_sarta_batch values (14005, 14030, 1, null,  'S', 'N', 500,  500, 14005, 'N')
insert into cobis..ba_sarta_batch values (14005, 14087, 2, null,  'S', 'N', 1500, 500, 14005, 'N')
insert into cobis..ba_sarta_batch values (14005, 14073, 3, null,  'S', 'N', 2500, 500, 14005, 'N')
go

print '-->Procesos Batch: Parametro'
if exists (select 1 from cobis..ba_sarta_batch, cobis..ba_batch, cobis..ba_parametro where sb_batch = ba_batch and ba_batch = pa_batch and sb_sarta in (14000, 14001, 14002, 14003, 14004, 14005))
   delete cobis..ba_parametro from cobis..ba_sarta_batch, cobis..ba_batch, cobis..ba_parametro where sb_batch = ba_batch and ba_batch = pa_batch and sb_sarta in (14000, 14001, 14002, 14003, 14004, 14005)
go

declare @w_fecha_proceso datetime

select @w_fecha_proceso = convert(varchar, fp_fecha, 101)
from   cobis..ba_fecha_proceso

insert into cobis..ba_parametro values (4202, 14003, 18, 1, 'FECHA', 'D', @w_fecha_proceso)
insert into cobis..ba_parametro values (0, 14008, 0, 2, 'TOPERACION', 'C', 'T')
insert into cobis..ba_parametro values (6018, 6525, 2, 2, 'EMPRESA', 'I', '1')
insert into cobis..ba_parametro values (1, 14093, 36, 1, 'FECHA INICIAL', 'D', @w_fecha_proceso)
insert into cobis..ba_parametro values (4103, 6525, 2, 1, 'OPERACION (V)', 'C', 'V')
insert into cobis..ba_parametro values (4202, 6525, 31, 3, 'PRODUCTO', 'I', '7')
insert into cobis..ba_parametro values (14004, 14999, 1, 1, 'EMPRESA', 'I', '1')
insert into cobis..ba_parametro values (14001, 14008, 7, 1, 'FECHA', 'D', @w_fecha_proceso)
insert into cobis..ba_parametro values (0, 14007, 0, 5, 'TOPERACION', 'C', 'T')
insert into cobis..ba_parametro values (14001, 14094, 12, 2, 'FECHA FINAL', 'D', @w_fecha_proceso)
insert into cobis..ba_parametro values (14003, 6525, 2, 3, 'PRODUCTO', 'I', '14')
insert into cobis..ba_parametro values (0, 14008, 0, 3, 'CIUDAD', 'C', 'T')
insert into cobis..ba_parametro values (21008, 14999, 40, 3, 'HISTORICO', 'C', 'S')
insert into cobis..ba_parametro values (36009, 6525, 5, 1, 'OPERACION (V)', 'C', 'V')
insert into cobis..ba_parametro values (14000, 14007, 3, 2, 'FECHA FINAL', 'D', @w_fecha_proceso)
insert into cobis..ba_parametro values (14003, 6525, 2, 2, 'EMPRESA', 'I', '1')
insert into cobis..ba_parametro values (21008, 6525, 67, 3, 'PRODUCTO', 'I', '7')
insert into cobis..ba_parametro values (1, 14999, 7, 1, 'EMPRESA', 'I', '1')
insert into cobis..ba_parametro values (8000, 14001, 13, 1, 'FECHA', 'D', @w_fecha_proceso)
insert into cobis..ba_parametro values (36009, 6525, 4, 1, 'OPERACION (V)', 'C', 'V')
insert into cobis..ba_parametro values (8000, 14048, 14, 1, 'FECHA INICIAL', 'D', @w_fecha_proceso)
insert into cobis..ba_parametro values (36009, 6525, 14, 1, 'OPERACION (V)', 'C', 'V')
insert into cobis..ba_parametro values (14004, 14999, 1, 3, 'HISTORICO', 'C', 'S')
insert into cobis..ba_parametro values (1, 6525, 2, 1, 'OPERACION (V)', 'C', 'V')
insert into cobis..ba_parametro values (8000, 14007, 15, 5, 'TOPERACION', 'C', 'T')
insert into cobis..ba_parametro values (0, 14094, 0, 2, 'FECHA FINAL', 'D', @w_fecha_proceso)
insert into cobis..ba_parametro values (4102, 14999, 19, 1, 'EMPRESA', 'I', '1')
insert into cobis..ba_parametro values (14001, 6525, 1, 3, 'PRODUCTO', 'I', '14')
insert into cobis..ba_parametro values (0, 14001, 0, 1, 'FECHA', 'D', @w_fecha_proceso)
insert into cobis..ba_parametro values (1, 6525, 16, 3, 'PRODUCTO', 'I', '7')
insert into cobis..ba_parametro values (4202, 6525, 17, 3, 'PRODUCTO', 'I', '14')
insert into cobis..ba_parametro values (4102, 6525, 5, 2, 'EMPRESA', 'I', '1')
insert into cobis..ba_parametro values (14002, 14011, 1, 1, 'FECHA INICIO', 'D', @w_fecha_proceso)
insert into cobis..ba_parametro values (7008, 6525, 2, 1, 'OPERACION (V)', 'C', 'V')
insert into cobis..ba_parametro values (4202, 14094, 28, 2, 'FECHA FINAL', 'D', @w_fecha_proceso)
insert into cobis..ba_parametro values (0, 14007, 0, 6, 'FORMA DE PAGO', 'C', 'T')
insert into cobis..ba_parametro values (4202, 14048, 22, 1, 'FECHA INICIAL', 'D', @w_fecha_proceso)
insert into cobis..ba_parametro values (0, 14048, 0, 2, 'FECHA FINAL', 'D', @w_fecha_proceso)
insert into cobis..ba_parametro values (14000, 14007, 3, 5, 'TOPERACION', 'C', 'T')
insert into cobis..ba_parametro values (36009, 6525, 15, 3, 'PRODUCTO', 'I', '21')
insert into cobis..ba_parametro values (4102, 14999, 19, 2, 'FECHA', 'D', @w_fecha_proceso)
insert into cobis..ba_parametro values (21006, 6525, 54, 3, 'PRODUCTO', 'I', '42')
insert into cobis..ba_parametro values (21006, 6525, 54, 2, 'EMPRESA', 'I', '1')
insert into cobis..ba_parametro values (21006, 6525, 45, 1, 'OPERACION (V)', 'C', 'V')
insert into cobis..ba_parametro values (1, 6525, 2, 3, 'PRODUCTO', 'I', '7')
insert into cobis..ba_parametro values (1, 6525, 2, 2, 'EMPRESA', 'I', '1')
insert into cobis..ba_parametro values (14004, 14999, 1, 2, 'FECHA', 'D', @w_fecha_proceso)
insert into cobis..ba_parametro values (0, 14093, 0, 2, 'FECHA FINAL', 'D', @w_fecha_proceso)
insert into cobis..ba_parametro values (4202, 6525, 31, 2, 'EMPRESA', 'I', '1')
insert into cobis..ba_parametro values (21006, 6525, 45, 2, 'EMPRESA', 'I', '1')
insert into cobis..ba_parametro values (14000, 14007, 3, 3, 'CIUDAD', 'C', 'T')
insert into cobis..ba_parametro values (21006, 6525, 54, 1, 'OPERACION (V)', 'C', 'V')
insert into cobis..ba_parametro values (0, 14003, 0, 1, 'FECHA', 'D', @w_fecha_proceso)
insert into cobis..ba_parametro values (0, 14008, 0, 4, 'OFICINA', 'C', 'T')
insert into cobis..ba_parametro values (4202, 6525, 17, 1, 'OPERACION (V)', 'C', 'V')
insert into cobis..ba_parametro values (8000, 14007, 15, 2, 'FECHA FINAL', 'D', @w_fecha_proceso)
insert into cobis..ba_parametro values (21006, 6525, 28, 1, 'OPERACION (V)', 'C', 'V')
insert into cobis..ba_parametro values (14000, 14048, 2, 2, 'FECHA FINAL', 'D', @w_fecha_proceso)
insert into cobis..ba_parametro values (36009, 6525, 14, 2, 'EMPRESA', 'I', '1')
insert into cobis..ba_parametro values (36009, 6525, 15, 1, 'OPERACION (V)', 'C', 'V')
insert into cobis..ba_parametro values (1, 14999, 7, 3, 'HISTORICO', 'C', 'S')
insert into cobis..ba_parametro values (8000, 14007, 15, 6, 'FORMA DE PAGO', 'C', 'T')
insert into cobis..ba_parametro values (14000, 14001, 1, 1, 'FECHA', 'D', @w_fecha_proceso)
insert into cobis..ba_parametro values (14002, 14011, 1, 2, 'FECHA FIN', 'D', @w_fecha_proceso)
insert into cobis..ba_parametro values (4102, 14999, 19, 3, 'HISTORICO', 'C', 'S')
insert into cobis..ba_parametro values (4103, 6525, 2, 2, 'EMPRESA', 'I', '1')
insert into cobis..ba_parametro values (14003, 6525, 2, 1, 'OPERACION (V)', 'C', 'V')
insert into cobis..ba_parametro values (1, 6525, 16, 2, 'EMPRESA', 'I', '1')
insert into cobis..ba_parametro values (21006, 6525, 30, 2, 'EMPRESA', 'I', '1')
insert into cobis..ba_parametro values (0, 14094, 0, 1, 'FECHA INICIAL', 'D', @w_fecha_proceso)
insert into cobis..ba_parametro values (4202, 14008, 23, 1, 'FECHA', 'D', @w_fecha_proceso)
insert into cobis..ba_parametro values (4202, 14094, 28, 1, 'FECHA INICIAL', 'D', @w_fecha_proceso)
insert into cobis..ba_parametro values (0, 14087, 0, 1, 'FECHA CORTE', 'D', @w_fecha_proceso)
insert into cobis..ba_parametro values (14001, 14048, 6, 1, 'FECHA INICIAL', 'D', @w_fecha_proceso)
insert into cobis..ba_parametro values (21006, 6525, 30, 3, 'PRODUCTO', 'I', '21')
insert into cobis..ba_parametro values (14001, 14093, 11, 1, 'FECHA INICIAL', 'D', @w_fecha_proceso)
insert into cobis..ba_parametro values (0, 14048, 0, 1, 'FECHA INICIAL', 'D', @w_fecha_proceso)
insert into cobis..ba_parametro values (21303, 6525, 2, 2, 'EMPRESA', 'I', '1')
insert into cobis..ba_parametro values (14001, 14048, 6, 2, 'FECHA FINAL', 'D', @w_fecha_proceso)
insert into cobis..ba_parametro values (36009, 6525, 14, 3, 'PRODUCTO', 'I', '21')
insert into cobis..ba_parametro values (36009, 6525, 6, 3, 'PRODUCTO', 'I', '7')
insert into cobis..ba_parametro values (4103, 6525, 2, 3, 'PRODUCTO', 'I', '4')
insert into cobis..ba_parametro values (4202, 14008, 23, 4, 'OFICINA', 'C', 'T')
insert into cobis..ba_parametro values (8000, 14007, 15, 4, 'OFICINA', 'C', 'T')
insert into cobis..ba_parametro values (0, 14093, 0, 1, 'FECHA INICIAL', 'D', @w_fecha_proceso)
insert into cobis..ba_parametro values (6018, 6525, 2, 1, 'OPERACION (V)', 'C', 'V')
insert into cobis..ba_parametro values (21006, 6525, 44, 2, 'EMPRESA', 'I', '1')
insert into cobis..ba_parametro values (21008, 14999, 40, 2, 'FECHA', 'D', @w_fecha_proceso)
insert into cobis..ba_parametro values (4102, 6525, 5, 3, 'PRODUCTO', 'I', '4')
insert into cobis..ba_parametro values (36009, 6525, 5, 2, 'EMPRESA', 'I', '1')
insert into cobis..ba_parametro values (14005, 14087, 2, 1, 'FECHA CORTE', 'D', @w_fecha_proceso)
insert into cobis..ba_parametro values (8000, 14007, 15, 1, 'FECHA INICIAL', 'D', @w_fecha_proceso)
insert into cobis..ba_parametro values (14001, 14008, 7, 3, 'CIUDAD', 'C', 'T')
insert into cobis..ba_parametro values (4202, 6525, 17, 2, 'EMPRESA', 'I', '1')
insert into cobis..ba_parametro values (0, 14011, 0, 1, 'FECHA INICIO', 'D', @w_fecha_proceso)
insert into cobis..ba_parametro values (36009, 6525, 15, 2, 'EMPRESA', 'I', '1')
insert into cobis..ba_parametro values (0, 14999, 0, 1, 'EMPRESA', 'I', '1')
insert into cobis..ba_parametro values (21006, 6525, 28, 3, 'PRODUCTO', 'I', '21')
insert into cobis..ba_parametro values (0, 14008, 0, 1, 'FECHA', 'D', @w_fecha_proceso)
insert into cobis..ba_parametro values (1, 14999, 18, 1, 'EMPRESA', 'I', '1')
insert into cobis..ba_parametro values (14001, 14003, 2, 1, 'FECHA', 'D', @w_fecha_proceso)
insert into cobis..ba_parametro values (14005, 14073, 3, 1, 'NOMBRE ARCHIVO', 'C', 'DESBLOQUEO_24112015.txt')
insert into cobis..ba_parametro values (14001, 14094, 12, 1, 'FECHA INICIAL', 'D', @w_fecha_proceso)
insert into cobis..ba_parametro values (0, 14999, 0, 2, 'FECHA', 'D', @w_fecha_proceso)
insert into cobis..ba_parametro values (0, 14007, 0, 1, 'FECHA INICIAL', 'D', @w_fecha_proceso)
insert into cobis..ba_parametro values (1, 14999, 7, 2, 'FECHA', 'D', @w_fecha_proceso)
insert into cobis..ba_parametro values (1, 14999, 18, 2, 'FECHA', 'D', @w_fecha_proceso)
insert into cobis..ba_parametro values (0, 6525, 0, 3, 'PRODUCTO', 'I', '7')
insert into cobis..ba_parametro values (21006, 6525, 45, 3, 'PRODUCTO', 'I', '10')
insert into cobis..ba_parametro values (36009, 6525, 5, 3, 'PRODUCTO', 'I', '19')
insert into cobis..ba_parametro values (4202, 14008, 23, 3, 'CIUDAD', 'C', 'T')
insert into cobis..ba_parametro values (4202, 14093, 27, 1, 'FECHA INICIAL', 'D', @w_fecha_proceso)
insert into cobis..ba_parametro values (0, 14007, 0, 3, 'CIUDAD', 'C', 'T')
insert into cobis..ba_parametro values (36009, 6525, 6, 1, 'OPERACION (V)', 'C', 'V')
insert into cobis..ba_parametro values (8000, 14048, 14, 2, 'FECHA FINAL', 'D', @w_fecha_proceso)
insert into cobis..ba_parametro values (14000, 14007, 3, 6, 'FORMA DE PAGO', 'C', 'T')
insert into cobis..ba_parametro values (1, 6525, 16, 1, 'OPERACION (V)', 'C', 'V')
insert into cobis..ba_parametro values (14000, 14007, 3, 4, 'OFICINA', 'C', 'T')
insert into cobis..ba_parametro values (4202, 14093, 27, 2, 'FECHA FINAL', 'D', @w_fecha_proceso)
insert into cobis..ba_parametro values (0, 14007, 0, 2, 'FECHA FINAL', 'D', @w_fecha_proceso)
insert into cobis..ba_parametro values (21006, 6525, 74, 2, 'EMPRESA', 'I', '1')
insert into cobis..ba_parametro values (14001, 6525, 1, 1, 'OPERACION (V)', 'C', 'V')
insert into cobis..ba_parametro values (0, 6525, 0, 2, 'EMPRESA', 'I', '1')
insert into cobis..ba_parametro values (14000, 14048, 2, 1, 'FECHA INICIAL', 'D', @w_fecha_proceso)
insert into cobis..ba_parametro values (4202, 14008, 23, 2, 'TOPERACION', 'C', 'T')
insert into cobis..ba_parametro values (21008, 14999, 40, 1, 'EMPRESA', 'I', '1')
insert into cobis..ba_parametro values (0, 14073, 0, 1, 'NOMBRE ARCHIVO', 'C', 'NOMBRE ARCHIVO.CVS')
insert into cobis..ba_parametro values (21006, 6525, 74, 1, 'OPERACION (V)', 'C', 'V')
insert into cobis..ba_parametro values (1, 14999, 18, 3, 'HISTORICO', 'C', 'S')
insert into cobis..ba_parametro values (7008, 6525, 2, 2, 'EMPRESA', 'I', '1')
insert into cobis..ba_parametro values (36009, 6525, 4, 2, 'EMPRESA', 'I', '1')
insert into cobis..ba_parametro values (0,6525, 0, 1, ', PERACION (V)', 'C', 'V')
insert into cobis..ba_parametro values (36009, 6525, 6, 2, 'EMPRESA', 'I', '1')
insert into cobis..ba_parametro values (21006, 6525, 28, 2, 'EMPRESA', 'I', '1')
insert into cobis..ba_parametro values (21006, 6525, 74, 3, 'PRODUCTO', 'I', '4')
insert into cobis..ba_parametro values (14001, 14008, 7, 2, 'TOPERACION', 'C', 'T')
insert into cobis..ba_parametro values (6018, 6525, 2, 3, 'PRODUCTO', 'I', '6')
insert into cobis..ba_parametro values (21008, 6525, 67, 2, 'EMPRESA', 'I', '1')
insert into cobis..ba_parametro values (21006, 6525, 44, 1, 'OPERACION (V)', 'C', 'V')
insert into cobis..ba_parametro values (14001, 14008, 7, 4, 'OFICINA', 'C', 'T')
insert into cobis..ba_parametro values (36009, 6525, 4, 3, 'PRODUCTO', 'I', '21')
insert into cobis..ba_parametro values (4202, 14048, 22, 2, 'FECHA FINAL', 'D', @w_fecha_proceso)
insert into cobis..ba_parametro values (14001, 6525, 1, 2, 'EMPRESA', 'I', '1')
insert into cobis..ba_parametro values (21006, 6525, 30, 1, 'OPERACION (V)', 'C', 'V')
insert into cobis..ba_parametro values (7008, 6525, 2, 3, 'PRODUCTO', 'I', '7')
insert into cobis..ba_parametro values (14000, 14007, 3, 1, 'FECHA INICIAL', 'D', @w_fecha_proceso)
insert into cobis..ba_parametro values (0, 14999, 0, 3, 'HISTORICO', 'C', 'S')
insert into cobis..ba_parametro values (1, 14093, 36, 2, 'FECHA FINAL', 'D', @w_fecha_proceso)
insert into cobis..ba_parametro values (21008, 6525, 67, 1, 'OPERACION (V)', 'C', 'V')
insert into cobis..ba_parametro values (14001, 14093, 11, 2, 'FECHA FINAL', 'D', @w_fecha_proceso)
insert into cobis..ba_parametro values (8000, 14007, 15, 3, 'CIUDAD', 'C', 'T')
insert into cobis..ba_parametro values (0, 14011, 0, 2, 'FECHA FIN', 'D', @w_fecha_proceso)
insert into cobis..ba_parametro values (0, 14007, 0, 4, 'OFICINA', 'C', 'T')
insert into cobis..ba_parametro values (21006, 6525, 44, 3, 'PRODUCTO', 'I', '3')
insert into cobis..ba_parametro values (21303, 6525, 2, 1, 'OPERACION (V)', 'C', 'V')
insert into cobis..ba_parametro values (21303, 6525, 2, 3, 'PRODUCTO', 'I', '21')
insert into cobis..ba_parametro values (4202, 6525, 31, 1, 'OPERACION (V)', 'C', 'V')
insert into cobis..ba_parametro values (4102, 6525, 5, 1, 'OPERACION (V)', 'C', 'V')
go

print '-->Procesos Batch: Enlace'
if exists (select 1 from cobis..ba_enlace where en_sarta in (14000, 14005, 14006))
   delete from cobis..ba_enlace where en_sarta in (14000, 14005, 14006)
go
insert into cobis..ba_enlace values (14000,14001,1,14048,2,'S',null,'N')
insert into cobis..ba_enlace values (14000,14048,2,14047,3,'S',null,'N')
insert into cobis..ba_enlace values (14000,14047,3,0,0,'S',null,'N') 
insert into cobis..ba_enlace values (14005, 14030, 1 , 14087, 2 , 'S', null, 'N')
insert into cobis..ba_enlace values (14005, 14087, 2 , 14073, 3 , 'S', null, 'N')
insert into cobis..ba_enlace values (14005, 14073, 3 , 14004, 4 , 'S', null, 'N')
insert into cobis..ba_enlace values (14005, 14004, 4 , 14007, 5 , 'S', null, 'N')
insert into cobis..ba_enlace values (14005, 14007, 5 , 14008, 6 , 'S', null, 'N')
insert into cobis..ba_enlace values (14005, 14008, 6 , 14048, 7 , 'S', null, 'N')
insert into cobis..ba_enlace values (14005, 14048, 7 , 14059, 8 , 'S', null, 'N')
insert into cobis..ba_enlace values (14005, 14059, 8 , 14092, 9 , 'S', null, 'N')
insert into cobis..ba_enlace values (14005, 14092, 9 , 14095, 10, 'S', null, 'N')
insert into cobis..ba_enlace values (14005, 14095, 10, 14099, 11, 'S', null, 'N')
insert into cobis..ba_enlace values (14006, 14095, 10, 14096, 11, 'D', NULL, 'N')
insert into cobis..ba_enlace values (14006, 14096, 11, 14097, 12, 'D', NULL, 'N')
insert into cobis..ba_enlace values (14006, 14097, 12, 14098, 13, 'D', NULL, 'N')
insert into cobis..ba_enlace values (14006, 14098, 13, 0,     0 , 'S', NULL, 'N')
insert into cobis..ba_enlace values (14005, 14099, 11, 0    , 0 , 'S', null, 'N')
go


print '-->Procesos Batch: Fecha-Cierre'
if exists (select 1 from cobis..ba_fecha_cierre where fc_producto in (14))
   delete cobis..ba_fecha_cierre where fc_producto in (14)
go

declare @w_fecha_proceso datetime

select @w_fecha_proceso = convert(varchar, fp_fecha, 101)
from   cobis..ba_fecha_proceso

insert into cobis..ba_fecha_cierre values ('14', @w_fecha_proceso, @w_fecha_proceso)
go

print ''
print 'Fin Ejecucion Creacion de Procesos Batch Plazo Fijo : ' + convert(varchar(60),getdate(),109)
print ''
