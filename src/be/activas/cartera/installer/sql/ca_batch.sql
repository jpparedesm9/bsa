use cobis
go
set nocount on

print '<<< PARAMETROS INICIALES >>>'
print '<<< Cierre >>>'
--Fecha cierre
delete cobis..ba_fecha_cierre 
 where fc_producto in (7)

declare @w_fecha_proceso datetime

select @w_fecha_proceso = isnull(fp_fecha, convert(varchar(10),getdate(),101))
  from cobis..ba_fecha_proceso   

insert into cobis..ba_fecha_cierre (fc_producto, fc_fecha_cierre, fc_fecha_propuesta)
values (7, @w_fecha_proceso, null)

--Path de producto
delete cobis..ba_path_pro
 where pp_producto = 7

insert into cobis..ba_path_pro (pp_producto, pp_path_fuente, pp_path_destino)
values (7, 'C:\Cobis\vbatch\cartera\objetos\', 'C:\Cobis\vbatch\cartera\listados\')
go


print '<<< Crea Batch CARTERA >>>'
print '<<< Sarta >>>'
delete cobis..ba_sarta
 where sa_sarta in (7000,7001,7002,7003,7004,7005,7006,7007,7010,7310,7210,7532,7533)
go

insert into cobis..ba_sarta values (7000,'INICIO DE DIA',                   'INICIO DE DIA',                    getdate(), 'operador', 7 , null, null) 
insert into cobis..ba_sarta values (7001,'PROCESOS PREVIOS AL CIERRE',      'PROCESOS PREVIOS AL CIERRE',       getdate(), 'operador', 7 , null, null) 
insert into cobis..ba_sarta values (7002,'FIN DIA',                         'FIN DIA',                          getdate(), 'operador', 7 , null, null) 
insert into cobis..ba_sarta values (7003,'CONTABILIDAD',                    'CONTABILIDAD',                     getdate(), 'operador', 7 , null, null) 
insert into cobis..ba_sarta values (7004,'CONSOLIDADOR',                    'CONSOLIDADOR',                     getdate(), 'operador', 7 , null, null) 
insert into cobis..ba_sarta values (7005,'BOC',                             'BOC',                              getdate(), 'operador', 7 , null, null) 
insert into cobis..ba_sarta values (7006,'PASO ATX',                        'PASO ATX',                         getdate(), 'operador', 7 , null, null) 
insert into cobis..ba_sarta values (7007,'CARTERA PALM',                    'CARTERA PALM',                     getdate(), 'operador', 7 , null, null) 
insert into cobis..ba_sarta values (7010,'REPORTES DIARIOS DE CARTERA',     'REPORTES DIARIOS DE CARTERA',      getdate(), 'operador', 7 , null ,null)  
insert into cobis..ba_sarta values (7310,'REPORTES EVENTUALES DE CARTERA',  'REPORTES EVENTUALES DE CARTERA',   getdate(), 'operador', 7 , null ,null) 
insert into cobis..ba_sarta values (7210,'REPORTES MENSUALES DE CARTERA',   'REPORTES MENSUALES DE CARTERA',    getdate(), 'operador', 7 , null ,null) 

go

print '<<< Batch >>>'
delete cobis..ba_batch
 where ba_batch in (7000,7001,7002,7003,7004,7005,7006,7007,7009,7010,7011,7013,7014,7015,7016,7017,7018,7019,7020,7021,
                    7022,7023,7024,7026,7027,7028,7029,7030,7031,7032,7033,7034,7035,7036,7037,7038,7039,7040,7041,7042,
                    7043,7044,7046,7047,7048,7049,7050,7051,7052,7053,7054,7055,7056,7057,7450,7532,7533)
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
where pp_producto = 7

select @w_path_destino = isnull(@w_path_destino, 'C:\Cobis\vbatch\cartera\listados\')

select   
@w_path_fuente = pp_path_fuente
from ba_path_pro
where pp_producto = 7

select @w_path_fuente = isnull(@w_path_fuente, 'C:\Cobis\vbatch\cartera\objetos\')


insert into cobis..ba_batch values (7000,'PREPARAR TABLAS TEMPORALES',                            'PREPARAR TABLAS TEMPORALES',                            'SP',getdate(),7, 'R', 1, 'CARTERA', null,              'cob_cartera..sp_deldia'               ,1,   null, @w_servidor, 'S', @w_path_fuente,  null)
insert into cobis..ba_batch values (7001,'FIN DIA GENERAR UNIVERSO',                              'FIN DIA GENERAR UNIVERSO',                              'SP',getdate(),7, 'P', 1, 'CARTERA', null,              'cob_cartera..sp_batch_ccra'           ,1,   null, @w_servidor, 'S', @w_path_fuente,  null)
insert into cobis..ba_batch values (7002,'FIN DIA',                                               'FIN DIA'                 ,                              'SP',getdate(),7, 'P', 1, 'CARTERA', null,              'cob_cartera..sp_batch_ccra'           ,1,   null, @w_servidor, 'S', @w_path_fuente,  null)
insert into cobis..ba_batch values (7003,'CONTABILIDAD GENERAR UNIVERSO',                         'CONTABILIDAD GENERAR UNIVERSO',                         'SP',getdate(),7, 'P', 1, 'CARTERA', null,              'cob_cartera..sp_caconta'              ,1,   null, @w_servidor, 'S', @w_path_fuente,  null)
insert into cobis..ba_batch values (7004,'CONTABILIDAD',                                          'CONTABILIDAD'                 ,                         'SP',getdate(),7, 'P', 1, 'CARTERA', null,              'cob_cartera..sp_caconta'              ,1,   null, @w_servidor, 'S', @w_path_fuente,  null)
insert into cobis..ba_batch values (7005,'CALIFICACION INTERNA',                                  'CALIFICACION INTERNA',                                  'SP',getdate(),7, 'P', 1, 'CARTERA', null,              'cob_cartera..sp_califica_interna'     ,1,   null, @w_servidor, 'S', @w_path_fuente,  null)
insert into cobis..ba_batch values (7006,'CONSOLIDADOR CARTERA',                                  'CONSOLIDADOR CARTERA',                                  'SP',getdate(),7, 'P', 1, 'CARTERA', null,              'cob_cartera..sp_consolidador'         ,1,   null, @w_servidor, 'S', @w_path_fuente,  null)
insert into cobis..ba_batch values (7007,'EJECUCION BOC GENERAR UNIVERSO',                        'EJECUCION BOC GENERAR UNIVERSO',                        'SP',getdate(),7, 'P', 1, 'CARTERA', null,              'cob_cartera..sp_boc'                  ,1,   null, @w_servidor, 'S', @w_path_fuente,  null)
insert into cobis..ba_batch values (7009,'EJECUCION BOC',                                         'EJECUCION BOC',                                         'SP',getdate(),7, 'P', 1, 'CARTERA', null,              'cob_cartera..sp_boc'                  ,1,   null, @w_servidor, 'S', @w_path_fuente,  null)
insert into cobis..ba_batch values (7010,'EJECUCION PASO ATX GENERAR UNIVERSO',                   'EJECUCION PASO ATX GENERAR UNIVERSO',                   'SP',getdate(),7, 'P', 1, 'CARTERA', null,              'cob_cartera..sp_actatx_ccra'          ,1,   null, @w_servidor, 'S', @w_path_fuente,  null)
insert into cobis..ba_batch values (7011,'EJECUCION PASO ATX',                                    'EJECUCION PASO ATX',                                    'SP',getdate(),7, 'P', 1, 'CARTERA', null,              'cob_cartera..sp_actatx_ccra'          ,1,   null, @w_servidor, 'S', @w_path_fuente,  null)
insert into cobis..ba_batch values (7532, 'REPORTE CLIENTES NO RENUEVAN',                         'REPORTE CLIENTES NO RENUEVAN',                          'SP',getdate(),7, 'P', 1, 'CARTERA', null,              'cob_cartera..sp_reporte_renovaciones', 1,   null, @w_server,   'S', @w_path_fuente, @w_path_destino)
insert into cobis..ba_batch values (7533, 'ELIMINAR OPERACIONES A FUTURO',                        'ELIMINAR OPERACIONES A FUTURO',                         'SP',getdate(),7, 'P', 1, 'CARTERA', NULL,              'cob_cartera..sp_cambio_fecha_fut'    ,1000, NULL, @w_servidor, 'S', @w_path_fuente,  null)
insert into cobis..ba_batch values (7013,'PAGOS NO APLICADOS',                                    'PAGOS NO APLICADOS',                                    'QR',getdate(),7, 'R', 1, 'CARTERA', 'ca_dpanoapli.lis','ca_dpanoapli.sqr'                     ,100, 'lp', @w_servidor, 'S', @w_path_fuente, @w_path_destino)
insert into cobis..ba_batch values (7014,'OPERACONES A REAJUSTAR',                                'OPERACONES A REAJUSTAR',                                'QR',getdate(),7, 'R', 1, 'CARTERA', 'ca_dreajus.lis',  'ca_dreajus.sqr'                       ,100, 'lp', @w_servidor, 'S', @w_path_fuente, @w_path_destino)                                                                                                                                                                                                                                                           
insert into cobis..ba_batch values (7015,'PAGOS DE CARTERA',                                      'PAGOS DE CARTERA',                                      'QR',getdate(),7, 'R', 1, 'CARTERA', 'ca_dpagosa.lis',  'ca_dpagosa.sqr'                       ,100, 'lp', @w_servidor, 'S', @w_path_fuente, @w_path_destino)                                                                                                                                                                                                                                                           
insert into cobis..ba_batch values (7016,'ERRORES DE AJUSTES DE CARTERA',                         'ERRORES DE AJUSTES DE CARTERA',                         'QR',getdate(),7, 'R', 1, 'CARTERA', 'errorajucar.lis', 'errorajucar.sqr'                      ,1000,'lp', @w_servidor, 'S', @w_path_fuente, @w_path_destino)                                                                                                                                                                                                                                                           
insert into cobis..ba_batch values (7017,'ADMINISTRACION DE SEGUROS',                             'ADMINISTRACION DE SEGUROS',                             'QR',getdate(),7, 'R', 1, 'CARTERA', 'ca_eadmseg.lis',  'ca_eadmseg.sqr'                       ,100, 'lp', @w_servidor, 'S', @w_path_fuente, @w_path_destino)                                                                                                                                                                                                                                                           
insert into cobis..ba_batch values (7018,'FORMATO EVALUACION DE CARTERA',                         'FORMATO EVALUACION DE CARTERA',                         'QR',getdate(),7, 'R', 1, 'CARTERA', 'ca_eevalua.lis',  'ca_eevalua.sqr'                       ,100, 'lp', @w_servidor, 'S', @w_path_fuente, @w_path_destino)                                                                                                                                                                                                                                                           
insert into cobis..ba_batch values (7019,'SALDOS Y CAUSACION ALFABETICO',                         'SALDOS Y CAUSACION ALFABETICO',                         'QR',getdate(),7, 'R', 1, 'CARTERA', 'ca_esalalf.lis',  'ca_esalalf.sqr'                       ,100, 'lp', @w_servidor, 'S', @w_path_fuente, @w_path_destino)                                                                                                                                                                                                                                                           
insert into cobis..ba_batch values (7020,'DESEMBOLSOS APLICADOS NO EJECUTADOS',                   'DESEMBOLSOS APLICADOS NO EJECUTADOS',                   'QR',getdate(),7, 'R', 1, 'CARTERA', 'ca_denoapli.lis', 'ca_denoapli.sqr'                      ,100, 'lp', @w_servidor, 'S', @w_path_fuente, @w_path_destino)                                                                                                                                                                                                                                                           
insert into cobis..ba_batch values (7021,'TRANSLADO INDIVIDUAL DE CREDITOS ENTRE OFICINAS',       'TRANSLADO INDIVIDUAL DE CREDITOS ENTRE OFICINAS',       'QR',getdate(),7, 'R', 1, 'CARTERA', 'ca_mtracre.lis',  'ca_mtracre.sqr'                       ,20,  'lp', @w_servidor, 'S', @w_path_fuente, @w_path_destino)                                                                                                                                                                                                                                                           
insert into cobis..ba_batch values (7022,'MICROSEGUROS A SURAMERICANA',                           'MICROSEGUROS A SURAMERICANA',                           'QR',getdate(),7, 'R', 1, 'CARTERA', 'ca_msuramer.lis', 'ca_msuramer.sqr'                      ,100, 'lp', @w_servidor, 'S', @w_path_fuente, @w_path_destino)                                                                                                                                                                                                                                                           
insert into cobis..ba_batch values (7023,'CONTROL PAGO MICROSEGUROS',                             'CONTROL PAGO MICROSEGUROS',                             'QR',getdate(),7, 'R', 1, 'CARTERA', 'ca_mplamic.lis',  'ca_mplamic.sqr'                       ,100, 'lp', @w_servidor, 'S', @w_path_fuente, @w_path_destino)                                                                                                                                                                                                                                                           
insert into cobis..ba_batch values (7024,'POLIZAS VIGENTES MICROSEGUROS',                         'POLIZAS VIGENTES MICROSEGUROS',                         'QR',getdate(),7, 'R', 1, 'CARTERA', 'ca_msegurvig.lis','ca_msegurvig.sqr'                     ,20,  'lp', @w_servidor, 'S', @w_path_fuente, @w_path_destino)                                                                                                                                                                                                                                                           
insert into cobis..ba_batch values (7026,'COMPORTAMIENTO MENSUAL DE CARTERA POR LINEA DE CREDITO','COMPORTAMIENTO MENSUAL DE CARTERA POR LINEA DE CREDITO','QR',getdate(),7, 'R', 1, 'CARTERA', 'ca_mcommen.lis',  'ca_mcommen.sqr'                       ,100, 'lp', @w_servidor, 'S', @w_path_fuente, @w_path_destino)                                                                                                                                                                                                                                                           
insert into cobis..ba_batch values (7027,'COMPORTAMIENTO ANUAL DE CARTERA POR LINEA DE CREDITO',  'COMPORTAMIENTO ANUAL DE CARTERA POR LINEA DE CREDITO',  'QR',getdate(),7, 'R', 1, 'CARTERA', 'ca_mcompan.lis',  'ca_mcompan.sqr'                       ,100, 'lp', @w_servidor, 'S', @w_path_fuente, @w_path_destino)                                                                                                                                                                                                                                                           
insert into cobis..ba_batch values (7028,'COLOCACION MENSUAL Y CARTERA VIGENTE',                  'COLOCACION MENSUAL Y CARTERA VIGENTE',                  'QR',getdate(),7, 'R', 1, 'CARTERA', 'ca_mcolmen.lis',  'ca_mcolmen.sqr'                       ,100, 'lp', @w_servidor, 'S', @w_path_fuente, @w_path_destino)                                                                                                                                                                                                                                                           
insert into cobis..ba_batch values (7029,'COMPORTAMIENTO DE LA CARTERA POR OFICINA',              'COMPORTAMIENTO DE LA CARTERA POR OFICINA',              'QR',getdate(),7, 'R', 1, 'CARTERA', 'ca_mcompofi.lis', 'ca_mcompofi.sqr'                      ,100, 'lp', @w_servidor, 'S', @w_path_fuente, @w_path_destino)                                                                                                                                                                                                                                                           
insert into cobis..ba_batch values (7030,'CRECIMIENTO DE LA CARTERA EN NUMERO Y MONTO',           'CRECIMIENTO DE LA CARTERA EN NUMERO Y MONTO',           'QR',getdate(),7, 'R', 1, 'CARTERA', 'ca_mcrecmon.lis', 'ca_mcrecmon.sqr'                      ,100, 'lp', @w_servidor, 'S', @w_path_fuente, @w_path_destino)                                                                                                                                                                                                                                                           
insert into cobis..ba_batch values (7031,'VARIACION DE LA MORA',                                  'VARIACION DE LA MORA',                                  'QR',getdate(),7, 'R', 1, 'CARTERA', 'ca_mmora.lis',    'ca_mmora.sqr'                         ,100, 'lp', @w_servidor, 'S', @w_path_fuente, @w_path_destino)                                                                                                                                                                                                                                                           
insert into cobis..ba_batch values (7032,'SECRETARIA DE HACIENDA DE CREDITO DISTRITAL',           'SECRETARIA DE HACIENDA DE CREDITO DISTRITAL',           'QR',getdate(),7, 'R', 1, 'CARTERA', 'ca_mdeshaci.lis', 'ca_mdeshaci.sqr'                      ,100, 'lp', @w_servidor, 'S', @w_path_fuente, @w_path_destino)                                                                                                                                                                                                                                                           
insert into cobis..ba_batch values (7033,'CARTERA VIGENTE Y PROMEDIO POR ANALISTA',               'CARTERA VIGENTE Y PROMEDIO POR ANALISTA',               'QR',getdate(),7, 'R', 1, 'CARTERA', 'ca_mvigprom.lis', 'ca_mvigprom.sqr'                      ,100, 'lp', @w_servidor, 'S', @w_path_fuente, @w_path_destino)                                                                                                                                                                                                                                                           
insert into cobis..ba_batch values (7034,'NIVEL DE MOROSIDAD VARIACION DE LA CARTERA EN MORA',    'NIVEL DE MOROSIDAD VARIACION DE LA CARTERA EN MORA',    'QR',getdate(),7, 'R', 1, 'CARTERA', 'ca_mvarmora.lis', 'ca_mvarmora.sqr'                      ,100, 'lp', @w_servidor, 'S', @w_path_fuente, @w_path_destino)                                                                                                                                                                                                                                                           
insert into cobis..ba_batch values (7035,'COLOCACION POR OFICINA Y TIPO DE CLIENTE',              'COLOCACION POR OFICINA Y TIPO DE CLIENTE',              'QR',getdate(),7, 'R', 1, 'CARTERA', 'ca_mcoltcli.lis', 'ca_mcoltcli.sqr'                      ,100, 'lp', @w_servidor, 'S', @w_path_fuente, @w_path_destino)                                                                                                                                                                                                                                                           
insert into cobis..ba_batch values (7036,'COMPOSICION DE CARTERA POR GENERO',                     'COMPOSICION DE CARTERA POR GENERO',                     'QR',getdate(),7, 'R', 1, 'CARTERA', 'ca_mcompos.lis',  'ca_mcompos.sqr'                       ,100, 'lp', @w_servidor, 'S', @w_path_fuente, @w_path_destino)                                                                                                                                                                                                                                                           
insert into cobis..ba_batch values (7037,'COMPOSICION DE DESEMBOLSOS POR GENERO',                 'COMPOSICION DE DESEMBOLSOS POR GENERO',                 'QR',getdate(),7, 'R', 1, 'CARTERA', 'ca_mcomdes.lis',  'ca_mcomdes.sqr'                       ,100, 'lp', @w_servidor, 'S', @w_path_fuente, @w_path_destino)                                                                                                                                                                                                                                                           
insert into cobis..ba_batch values (7038,'SALDOS DE CARTERA  ACTIVA POR MUNICIPIO',               'SALDOS DE CARTERA  ACTIVA POR MUNICIPIO',               'QR',getdate(),7, 'R', 1, 'CARTERA', 'ca_msalact.lis',  'ca_msalact.sqr'                       ,100, 'lp', @w_servidor, 'S', @w_path_fuente, @w_path_destino)                                                                                                                                                                                                                                                           
insert into cobis..ba_batch values (7039,'DESEMBOLSOS REALIZADOS EN EL MES POR MUNICIPIO',        'DESEMBOLSOS REALIZADOS EN EL MES POR MUNICIPIO',        'QR',getdate(),7, 'R', 1, 'CARTERA', 'ca_mensdes.lis',  'ca_mensdes.sqr'                       ,100, 'lp', @w_servidor, 'S', @w_path_fuente, @w_path_destino)                                                                                                                                                                                                                                                           
insert into cobis..ba_batch values (7040,'CARTERA MICRORATE',                                     'CARTERA MICRORATE',                                     'QR',getdate(),7, 'R', 1, 'CARTERA', 'ca_smicrora.lis', 'ca_smicrora.sqr'                      ,100, 'lp', @w_servidor, 'S', @w_path_fuente, @w_path_destino)                                                                                                                                                                                                                                                           
insert into cobis..ba_batch values (7041,'ARCHIVO PLANO PROPUESTA CASTIGO DE CARTERA',            'ARCHIVO PLANO PROPUESTA CASTIGO DE CARTERA',            'QR',getdate(),7, 'R', 1, 'CARTERA', 'ca_eprocast.lis', 'ca_eprocast.sqr'                      ,10,  'lp', @w_servidor, 'S', @w_path_fuente, @w_path_destino)                                                                                                                                                                                                                                                           
insert into cobis..ba_batch values (7042,'PRESTAMOS APROBADOS POR DESEMBOLSAR',                   'PRESTAMOS APROBADOS POR DESEMBOLSAR',                   'QR',getdate(),7, 'R', 1, 'CARTERA', 'ca_dpresapr.lis', 'ca_dpresapr.sqr'                      ,100, 'lp', @w_servidor, 'S', @w_path_fuente, @w_path_destino)                                                                                                                                                                                                                                                           
insert into cobis..ba_batch values (7043,'PLAZO PROMEDIO DE COLOCACION',                          'PLAZO PROMEDIO DE COLOCACION',                          'QR',getdate(),7, 'R', 1, 'CARTERA', 'ca_eplacol.lis',  'ca_eplacol.sqr'                       ,100, 'lp', @w_servidor, 'S', @w_path_fuente, @w_path_destino)                                                                                                                                                                                                                                                           
insert into cobis..ba_batch values (7044,'PLAZO PROMEDIO DE COLOCACION DE LA CARTERA VIGENTE',    'PLAZO PROMEDIO DE COLOCACION DE LA CARTERA VIGENTE',    'QR',getdate(),7, 'R', 1, 'CARTERA', 'ca_mplaprom.lis', 'ca_mplaprom.sqr'                      ,100, 'lp', @w_servidor, 'S', @w_path_fuente, @w_path_destino)                                                                                                                                                                                                                                                           
insert into cobis..ba_batch values (7046,'PLAZO PROMEDIO DE VENCIMIENTOS DE LA CARTERA VIGENTE',  'PLAZO PROMEDIO DE VENCIMIENTOS DE LA CARTERA VIGENTE',  'QR',getdate(),7, 'R', 1, 'CARTERA', 'ca_mplaven.lis',  'ca_mplaven.sqr'                       ,100, 'lp', @w_servidor, 'S', @w_path_fuente, @w_path_destino)                                                                                                                                                                                                                                                           
insert into cobis..ba_batch values (7047,'COLOCACIONES POR FONDO EMPRENDER-AUTONOMO-BID',         'COLOCACIONES POR FONDO EMPRENDER-AUTONOMO-BID',         'QR',getdate(),7, 'R', 1, 'CARTERA', 'ca_mcol_eab.lis', 'ca_mcol_eab.sqr'                      ,100, 'lp', @w_servidor, 'S', @w_path_fuente, @w_path_destino)                                                                                                                                                                                                                                                           
insert into cobis..ba_batch values (7048,'COLOCACIONES POR FONDO BANCOLDEX-COMFAMA-AECI',         'COLOCACIONES POR FONDO BANCOLDEX-COMFAMA-AECI',         'QR',getdate(),7, 'R', 1, 'CARTERA', 'ca_mcoldex.lis',  'ca_mcoldex.sqr'                       ,100, 'lp', @w_servidor, 'S', @w_path_fuente, @w_path_destino)                                                                                                                                                                                                                                                           
insert into cobis..ba_batch values (7049,'COLOCACIONES CONVENIO ANTIOQUIA EMPRENDEDORA',          'COLOCACIONES CONVENIO ANTIOQUIA EMPRENDEDORA',          'QR',getdate(),7, 'R', 1, 'CARTERA', 'ca_mcolant.lis',  'ca_mcolant.sqr'                       ,100, 'lp', @w_servidor, 'S', @w_path_fuente, @w_path_destino)                                                                                                                                                                                                                                                           
insert into cobis..ba_batch values (7050,'PROYECCION DE RECUPERACION DE RECAUDOS',                'PROYECCION DE RECUPERACION DE RECAUDOS',                'QR',getdate(),7, 'R', 1, 'CARTERA', 'ca_eprorec.lis',  'ca_eprorec.sqr'                       ,100, 'lp', @w_servidor, 'S', @w_path_fuente, @w_path_destino)                                                                                                                                                                                                                                                           
insert into cobis..ba_batch values (7051,'(CCA) REPORTE DE OBLIGACIONES REESTRUCTURADAS',         '(CCA) REPORTE DE OBLIGACIONES REESTRUCTURADAS',         'QR',getdate(),7, 'R', 1, 'CARTERA', 'careestr.lis',    'careestr.sqr'                         ,1,   'lp', @w_servidor, 'S', @w_path_fuente, @w_path_destino)                                                                                                                                                                                                                                                           
insert into cobis..ba_batch values (7052,'(CCA) REPORTE DE PREPAGOS PASIVAS',                     '(CCA) REPORTE DE PREPAGOS PASIVAS',                     'QR',getdate(),7, 'R', 1, 'CARTERA', 'careprep.lis',    'careprep.sqr'                         ,1,   'lp', @w_servidor, 'S', @w_path_fuente, @w_path_destino)                                                                                                                                                                                                                                                           
insert into cobis..ba_batch values (7053,'GENERACION VALORES A RECAUDAR BALOTO',                  'GENERACION VALORES A RECAUDAR G.TECH',                  'QR',getdate(),7, 'R', 1, 'CARTERA', 'confacma.sqr',    'confacma.sqr'                         ,100, 'lp', @w_servidor, 'S', @w_path_fuente, @w_path_destino)                                                                                                                                                                                                                                                           
insert into cobis..ba_batch values (7054,'PALM CARTERA',                                          'PALM CARTERA',                                          'SP',getdate(),7, 'P', 1, 'CARTERA', null,              'cob_palm..sp_interfaz_palm_pda2_ccra' ,1,   null, @w_servidor, 'S', @w_path_fuente,  null)
insert into cobis..ba_batch values (7055,'REVERSA DE DESEMBOLSOS NO ENTREGADOS',                  'REVERSA DE DESEMBOLSOS NO ENTREGADOS',                  'SP',getdate(),7, 'P', 1, 'CARTERA', null,              'cob_cartera..sp_revdesnoapag'         ,1,   null, @w_servidor, 'S', @w_path_fuente,  null)
insert into cobis..ba_batch values (7056,'PAGOS RECHAZADOS RECUADOS DE CARTERA',                  'PAGOS RECHAZADOS RECUADOS DE CARTERA',                  'QR',getdate(),7, 'R', 1, 'CARTERA', 'ca_dpagrec.lis',  'ca_dpagrec.sqr'                       ,100, 'lp', @w_servidor, 'S', @w_path_fuente, @w_path_destino)
insert into cobis..ba_batch values (7057,'TRALSADO CARTERA OFICINA',                              'TRALSADO CARTERA OFICINA',                              'QR',getdate(),7, 'R', 1, 'CARTERA', 'catracar.lis',    'catracar.sqr'                         ,100, 'lp', @w_servidor, 'S', @w_path_fuente, @w_path_destino)
insert into cobis..ba_batch values (7450, 'REPORTE ELAVON',                                       'REPORTE SEGUROS ELAVON',                                'SP',getdate(),7, 'P', 1, 'CARTERA', 'REPORTE_ELAVON_', 'cob_cartera..sp_reporte_pagos_elavon' , 1 , NULL, @w_servidor, 'S', @w_path_fuente, @w_path_destino)
--req 121717 ODS 
INSERT INTO ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (7512, 'SALDOS DE CARTERA TII - ARCHIVO 1.1 ODS', 'SALDOS DE CARTERA TII - ARCHIVO 1.1 ODS', 'SP', '09/17/2019', 36, 'R', 1, 'REGULATORIOS', 'BMXP_SAL_CAR_TTI_YYYY_MM_DD.txt', 'cob_conta_super..sp_ods_saldos_oper_tti', 10000, 'lp', 'CTSSRV', 'S', 'C:\Cobis\VBatch\Regulatorios\Objetos\', 'C:\Cobis\VBatch\Regulatorios\listados\')
GO

INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (75221, 'ARCHIVO ODS-2 DE BALANCE DE ACTIVOS TTI', 'ARCHIVO ODS-2 DE BALANCE DE ACTIVOS TTI', 'SP', '01/19/2018 05:08:09', 36, 'P', 1, 'REGULATORIOS', 'BMXP_VAL_ACT_TTI', 'cob_conta_super..sp_ods_balance_activos_tti', 1, NULL, 'CTSSRV', 'S', 'C:\Cobis\VBatch\Regulatorios\Objetos\', 'C:\Cobis\VBatch\Regulatorios\listados\')
GO

INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (75231, 'ARCHIVO ODS-3 DE MOVIMIENTOS-RESULTADOS TTI', 'ARCHIVO ODS-3 DE MOVIMIENTOS-RESULTADOS TTI', 'SP', '01/19/2018 05:08:09', 36, 'P', 1, 'REGULATORIOS', 'BMXP_MOV_RES_TTI', 'cob_conta_super..sp_ods_mov_resultados_tti', 1, NULL, 'CTSSRV', 'S', 'C:\Cobis\VBatch\Regulatorios\Objetos\', 'C:\Cobis\VBatch\Regulatorios\listados\')
GO




go

print '<<< Parametros >>>'
delete cobis..ba_parametro
 where pa_batch in (7001,7002,7003,7004,7007,7009,7010,7011,7014,7015,7016,7017,7018,7019,7020,7021,7022,7023,7024,7026,
                    7027,7028,7029,7030,7031,7032,7033,7034,7035,7036,7037,7038,7039,7040,7041,7042,7043,7044,7046,7047,
                    7048,7049,7050,7051,7053,7054,7057)
go
                                                                                                                                                                                                                                         
insert into cobis..ba_parametro values(0,7001,0,1,'HIJO',              'C', '0')
insert into cobis..ba_parametro values(0,7001,0,2,'SARTA',             'C', '7001')
insert into cobis..ba_parametro values(0,7001,0,3,'BATCH',             'C', '7003')
insert into cobis..ba_parametro values(0,7001,0,4,'OPCION',            'C', 'G')
insert into cobis..ba_parametro values(0,7001,0,5,'BLOQUE',            'C', '0')
insert into cobis..ba_parametro values(0,7002,0,1,'HIJO',              'C', '2')
insert into cobis..ba_parametro values(0,7002,0,2,'SARTA',             'C', '7001')
insert into cobis..ba_parametro values(0,7002,0,3,'BATCH',             'C', '7003')
insert into cobis..ba_parametro values(0,7002,0,4,'OPCION',            'C', 'B')
insert into cobis..ba_parametro values(0,7002,0,5,'BLOQUE',            'C', '2000')

insert into cobis..ba_parametro values(0,7003,0,1,'HIJO',              'C', '0')
insert into cobis..ba_parametro values(0,7003,0,2,'SARTA',             'C', '7003')
insert into cobis..ba_parametro values(0,7003,0,3,'BATCH',             'C', '7005')
insert into cobis..ba_parametro values(0,7003,0,4,'OPCION',            'C', 'G')
insert into cobis..ba_parametro values(0,7003,0,5,'BLOQUE',            'C', '0')
insert into cobis..ba_parametro values(0,7004,0,1,'HIJO',              'C', '2')
insert into cobis..ba_parametro values(0,7004,0,2,'SARTA',             'C', '7003')
insert into cobis..ba_parametro values(0,7004,0,3,'BATCH',             'C', '7005')
insert into cobis..ba_parametro values(0,7004,0,4,'OPCION',            'C', 'B')
insert into cobis..ba_parametro values(0,7004,0,5,'BLOQUE',            'C', '2000')

insert into cobis..ba_parametro values(0,7007,0,1,'FECHA',             'D', '05/02/2009')
insert into cobis..ba_parametro values(0,7007,0,2,'HISTORICO',         'C', 'N')
insert into cobis..ba_parametro values(0,7007,0,3,'HIJO',              'C', '0')
insert into cobis..ba_parametro values(0,7007,0,4,'SARTA',             'C', '7005')
insert into cobis..ba_parametro values(0,7007,0,5,'BATCH',             'C', '7010')
insert into cobis..ba_parametro values(0,7007,0,6,'OPCION',            'C', 'G')
insert into cobis..ba_parametro values(0,7007,0,7,'BLOQUE',            'C', '0')
insert into cobis..ba_parametro values(0,7009,0,1,'FECHA',             'D', '05/02/2009')
insert into cobis..ba_parametro values(0,7009,0,2,'HISTORICO',         'C', 'N')
insert into cobis..ba_parametro values(0,7009,0,3,'HIJO',              'C', '2')
insert into cobis..ba_parametro values(0,7009,0,4,'SARTA',             'C', '7005')
insert into cobis..ba_parametro values(0,7009,0,5,'BATCH',             'C', '7010')
insert into cobis..ba_parametro values(0,7009,0,6,'OPCION',            'C', 'B')
insert into cobis..ba_parametro values(0,7009,0,7,'BLOQUE',            'C', '2000')

insert into cobis..ba_parametro values(0,7010,0,1,'HIJO',              'C', '0')
insert into cobis..ba_parametro values(0,7010,0,2,'SARTA',             'C', '7006')
insert into cobis..ba_parametro values(0,7010,0,3,'BATCH',             'C', '7012')
insert into cobis..ba_parametro values(0,7010,0,4,'OPCION',            'C', 'G')
insert into cobis..ba_parametro values(0,7010,0,5,'BLOQUE',            'C', '0')
insert into cobis..ba_parametro values(0,7011,0,1,'HIJO',              'C', '2')
insert into cobis..ba_parametro values(0,7011,0,2,'SARTA',             'C', '7006')
insert into cobis..ba_parametro values(0,7011,0,3,'BATCH',             'C', '7012')
insert into cobis..ba_parametro values(0,7011,0,4,'OPCION',            'C', 'B')
insert into cobis..ba_parametro values(0,7011,0,5,'BLOQUE',            'C', '2000')

insert into cobis..ba_parametro values(0,7014,0,1,'FECHA DE PROCESO',  'D', '05/02/2009')                                                                                                                                                                                                                                                   
insert into cobis..ba_parametro values(0,7015,0,1,'FECHA INICIAL',     'D', '05/02/2009')                                                                                                                                                                                                                                                   
insert into cobis..ba_parametro values(0,7015,0,2,'FECHA FIN',         'D', '05/02/2009')                                                                                                                                                                                                                                                   
insert into cobis..ba_parametro values(0,7016,0,1,'FECHA INICIO',      'D', '05/02/2009')                                                                                                                                                                                                                                                   
insert into cobis..ba_parametro values(0,7017,0,1,'FECHA INICIAL',     'D', '05/02/2009')                                                                                                                                                                                                                                                   
insert into cobis..ba_parametro values(0,7017,0,2,'FECHA FINAL',       'D', '05/02/2009')                                                                                                                                                                                                                                                   
insert into cobis..ba_parametro values(0,7018,0,1,'FECHA DE PROCESO',  'D', '05/02/2009')                                                                                                                                                                                                                                                   
insert into cobis..ba_parametro values(0,7018,0,2,'OPCION',            'C', '1'         )                                                                                                                                                                                                                                                   
insert into cobis..ba_parametro values(0,7019,0,1,'FECHA DE PROCESO',  'D', '05/02/2009')                                                                                                                                                                                                                                                   
insert into cobis..ba_parametro values(0,7019,0,2,'TODAS O ESPECIFICA','C', 'T'         )                                                                                                                                                                                                                                                   
insert into cobis..ba_parametro values(0,7019,0,3,'OFICINA',           'C', '255'       )                                                                                                                                                                                                                                                   
insert into cobis..ba_parametro values(0,7020,0,1,'FECHA DE PROCESO',  'D', '05/02/2009')                                                                                                                                                                                                                                                   
insert into cobis..ba_parametro values(0,7021,0,1,'FECHA DE PROCESO',  'D', '05/02/2009')                                                                                                                                                                                                                                                   
insert into cobis..ba_parametro values(0,7022,0,1,'FECHA DE PROCESO',  'D', '05/02/2009')                                                                                                                                                                                                                                                   
insert into cobis..ba_parametro values(0,7023,0,1,'FECHA DE PROCESO',  'D', '05/02/2009')                                                                                                                                                                                                                                                   
insert into cobis..ba_parametro values(0,7024,0,1,'FECHA DE PROCESO',  'D', '05/02/2009')                                                                                                                                                                                                                                                   
insert into cobis..ba_parametro values(0,7026,0,1,'FECHA DE PROCESO',  'D', '05/02/2009')                                                                                                                                                                                                                                                   
insert into cobis..ba_parametro values(0,7027,0,1,'FECHA DE PROCESO',  'D', '05/02/2009')                                                                                                                                                                                                                                                   
insert into cobis..ba_parametro values(0,7028,0,1,'FECHA DE PROCESO',  'D', '05/02/2009')                                                                                                                                                                                                                                                   
insert into cobis..ba_parametro values(0,7029,0,1,'FECHA DE PROCESO',  'D', '05/02/2009')                                                                                                                                                                                                                                                   
insert into cobis..ba_parametro values(0,7030,0,1,'FECHA DE PROCESO',  'D', '05/02/2009')                                                                                                                                                                                                                                                   
insert into cobis..ba_parametro values(0,7031,0,1,'FECHA DE PROCESO',  'D', '05/02/2009')                                                                                                                                                                                                                                                   
insert into cobis..ba_parametro values(0,7031,0,2,'LINEA DE CREDI TO', 'C', 'C'         )                                                                                                                                                                                                                                                   
insert into cobis..ba_parametro values(0,7032,0,1,'FECHA DE PROCE SO', 'D', '05/02/2009')                                                                                                                                                                                                                                                   
insert into cobis..ba_parametro values(0,7033,0,1,'FECHA DE PROCESO',  'D', '05/02/2009')                                                                                                                                                                                                                                                   
insert into cobis..ba_parametro values(0,7034,0,1,'FECHA DE PROCESO',  'D', '05/02/2009')                                                                                                                                                                                                                                                   
insert into cobis..ba_parametro values(0,7035,0,1,'FECHA DE PROCESO',  'D', '05/02/2009')                                                                                                                                                                                                                                                   
insert into cobis..ba_parametro values(0,7035,0,2,'OFICINA',           'C', '0'         )                                                                                                                                                                                                                                                   
insert into cobis..ba_parametro values(0,7036,0,1,'FECHA DE PROCESO',  'D', '05/02/2009')                                                                                                                                                                                                                                                   
insert into cobis..ba_parametro values(0,7036,0,2,'OFICINA',           'C', '0'         )                                                                                                                                                                                                                                                   
insert into cobis..ba_parametro values(0,7037,0,1,'FECHA DE PROCESO',  'D', '05/02/2009')                                                                                                                                                                                                                                                   
insert into cobis..ba_parametro values(0,7038,0,1,'FECHA DE PROCESO',  'D', '05/02/2009')                                                                                                                                                                                                                                                   
insert into cobis..ba_parametro values(0,7039,0,1,'FECHA DE PROCESO',  'D', '05/02/2009')                                                                                                                                                                                                                                                   
insert into cobis..ba_parametro values(0,7040,0,1,'DIAS DE MORA',      'I', '1'         )                                                                                                                                                                                                                                                   
insert into cobis..ba_parametro values(0,7041,0,1,'FECHA INICIAL',     'D', '05/02/2009')                                                                                                                                                                                                                                                   
insert into cobis..ba_parametro values(0,7041,0,2,'FECHA FINAL',       'D', '05/02/2009')                                                                                                                                                                                                                                                   
insert into cobis..ba_parametro values(0,7042,0,1,'FECHA DE PROCESO',  'D', '05/02/2009')                                                                                                                                                                                                                                                   
insert into cobis..ba_parametro values(0,7043,0,1,'FECHA DE PROCESO',  'D', '05/02/2009')                                                                                                                                                                                                                                                   
insert into cobis..ba_parametro values(0,7044,0,1,'FECHA INICIAL',     'D', '05/02/2009')                                                                                                                                                                                                                                                   
insert into cobis..ba_parametro values(0,7044,0,2,'FECHA FINAL',       'D', '05/02/2009')                                                                                                                                                                                                                                                   
insert into cobis..ba_parametro values(0,7046,0,1,'FECHA INICIAL',     'D', '05/02/2009')                                                                                                                                                                                                                                                   
insert into cobis..ba_parametro values(0,7046,0,2,'FECHA FINAL',       'D', '05/02/2009')                                                                                                                                                                                                                                                   
insert into cobis..ba_parametro values(0,7047,0,1,'FECHA INICIAL',     'D', '05/02/2009')                                                                                                                                                                                                                                                   
insert into cobis..ba_parametro values(0,7047,0,2,'FECHA FINAL',       'D', '05/02/2009')                                                                                                                                                                                                                                                   
insert into cobis..ba_parametro values(0,7048,0,1,'FECHA INICIAL',     'D', '05/02/2009')                                                                                                                                                                                                                                                   
insert into cobis..ba_parametro values(0,7048,0,2,'FECHA FINAL',       'D', '05/02/2009')                                                                                                                                                                                                                                                   
insert into cobis..ba_parametro values(0,7049,0,1,'FECHA_PROCESO',     'D', '05/02/2009')                                                                                                                                                                                                                                                   
insert into cobis..ba_parametro values(0,7050,0,1,'FECHA INICIAL',     'D', '05/02/2009')                                                                                                                                                                                                                                                   
insert into cobis..ba_parametro values(0,7050,0,2,'FECHA_FIN',         'D', '05/02/2009')                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    
insert into cobis..ba_parametro values(0,7051,0,2,'FECHA_PROCESO',     'D', '05/02/2009')                                                                                                                                                                                                                                                   
insert into cobis..ba_parametro values(0,7053,0,1,'FECHA_PROCESO',     'D', '05/02/2009')                                                                                                                                                                                                                                                   
insert into cobis..ba_parametro values(0,7053,0,2,'CONVENIO',          'I', '1')       
insert into cobis..ba_parametro values(0,7054,0,1,'OPERACION',         'C', 'B')                                                                                                                                                                                                                                                   
insert into cobis..ba_parametro values(0,7054,0,2,'BATCH',             'C', 'S')       
insert into cobis..ba_parametro values(0,7057,0,1,'FECHA',             'D', '05/02/2009')                                                                                                                                                                                                                                                   
insert into cobis..ba_parametro values(0,7532,0,1,'param1',            'D', '09/19/2017')
insert into cobis..ba_parametro values(0,7533,0,1,'FECHA PROCESO',     'D', '31/01/2023')
                                                                                                                                                                                                                                                 
   
go

/*PROCESOS EVENTUALES DE CARTERA*/
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
where pp_producto = 7

select @w_path_destino = isnull(@w_path_destino, 'C:\Cobis\vbatch\cartera\listados\')

select   
@w_path_fuente = pp_path_fuente
from ba_path_pro
where pp_producto = 7

select @w_path_fuente = isnull(@w_path_fuente, 'C:\Cobis\vbatch\cartera\objetos\')

DELETE FROM ba_sarta where sa_sarta = 7020

INSERT INTO ba_sarta (sa_sarta, sa_nombre, sa_descripcion, sa_fecha_creacion, sa_creador, sa_producto, sa_dependencia, sa_autorizacion)
VALUES (7020, 'EVENTUALES CARTERA', 'EVENTUALES CARTERA', getdate(), 'operador', 7, NULL, NULL)

DELETE FROM ba_batch WHERE ba_batch IN (7058,7059,7060)

INSERT INTO ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (7058, 'CLIENTES EMPROBLEMADOS', 'INGRESO DE CLIENTES EMPROBLEMADOS', 'SP', getdate(), 7, 'P', 1, 'CARTERA', NULL, 'cob_cartera..sp_carga_cliente_emproblemado', 10000, NULL, @w_servidor, 'S', @w_path_fuente, NULL)

INSERT INTO ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (7059, 'PAGOS SOSTENIDO', 'VALIDACION DE OPERACIONES DE PAGO SOSTENIDO', 'SP', getdate(), 7, 'P', 1, 'CARTERA', NULL, 'cob_cartera..sp_pago_sostenido', 10000, NULL, @w_servidor, 'S', @w_path_fuente, NULL)

INSERT INTO ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (7060, 'CAMBIO ESTADO VIGENTE', 'CAMBIO ESTADO VIGENTE', 'SP', getdate(), 7, 'P', 1, 'CARTERA', NULL, 'cob_cartera..sp_cambio_est_vig', 10000, NULL, @w_servidor, 'S', @w_path_fuente, NULL)
GO

DELETE FROM ba_sarta_batch WHERE sb_sarta = 7020

INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (7020, 7058, 1, NULL, 'S', 'N', 465, 600, 7020, 'S')
GO

INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (7020, 7059, 2, NULL, 'S', 'N', 1965, 600, 7020, 'S')
GO

INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (7020, 7060, 3, NULL, 'S', 'N', 3465, 600, 7020, 'S')
GO



DELETE FROM ba_enlace WHERE en_sarta = 7020

INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
VALUES (7020, 7058, 1, 0, 0, 'S', NULL, 'N')
GO

INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
VALUES (7020, 7059, 2, 0, 0, 'S', NULL, 'N')
GO

INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
VALUES (7020, 7060, 3, 0, 0, 'S', NULL, 'N')
GO


DELETE FROM ba_parametro WHERE pa_sarta IN (0,7020) AND pa_batch IN (7058,7059,7060)

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 7058, 0, 1, 'NOMBRE ARCHIVO', 'C', 'CLI_EMP_PRMR_6.txt')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 7058, 0, 2, 'RUTA', 'C', 'C:\Cobis\vbatch\cartera\listados\')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 7059, 0, 1, 'OPERACION', 'I', '0')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 7060, 0, 1, 'OPERACION', 'I', '0')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (7020, 7058, 1, 1, 'NOMBRE ARCHIVO', 'C', 'CLI_EMP_PRMR_6.txt')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (7020, 7058, 1, 2, 'RUTA', 'C', 'C:\Cobis\vbatch\cartera\listados\')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (7020, 7059, 2, 1, 'OPERACION', 'I', '0')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (7020, 7060, 3, 1, 'OPERACION', 'I', '0')
GO
--/////////////////////////////////////////////////////////////////////////////////////
-- SARTA PARA GENERAR/CARGAR/APLICAR PAGOS 

use cobis
go
declare @w_path_objetos  varchar(255),
        @w_path_listados varchar(255),
        @w_transerver    varchar(255)

select  @w_path_objetos  = pp_path_fuente,
        @w_path_listados = pp_path_destino
from ba_path_pro
where pp_producto = 7

select @w_transerver  = pa_char
  from cobis..cl_parametro
 where pa_producto = 'ADM'
   and pa_nemonico = 'SRVR'

-- generacion y carga de archivos de pagos normales
delete cobis..ba_sarta where sa_sarta = 7008
delete cobis..ba_batch where ba_batch in (7061, 7062, 7063, 7064, 7065, 7066) and ba_producto = 7
delete cobis..ba_sarta_batch where sb_sarta = 7008
delete cobis..ba_parametro where pa_batch in (7061, 7062, 7063, 7064, 7065, 7066)
delete cobis..ba_enlace where en_sarta = 7008

--/////////////////////////////////////////////////////////////////////////////
insert into cobis..ba_sarta
(sa_sarta,           sa_nombre,                         sa_descripcion,
 sa_fecha_creacion,  sa_creador,                        sa_producto,
 sa_dependencia,     sa_autorizacion)
values
(7008,               'PAGOS GRUPALES/INDIVIDUALES',                  'PAGOS DE GRUPALES/INDIVIDUALES',
 getdate(),          'admuser',                         7,
 null,                null)

--/////////////////////////////////////////////////////////////////////////////
insert into cobis..ba_batch
(ba_batch,           ba_nombre,                         ba_descripcion,
 ba_lenguaje,        ba_fecha_creacion,                 ba_producto,
 ba_tipo_batch,      ba_sec_corrida,                    ba_ente_procesado,
 ba_arch_resultado,  ba_arch_fuente,                    ba_frec_reg_proc,
 ba_impresora,       ba_serv_destino,                   ba_reproceso,
 ba_path_fuente,     ba_path_destino)
 values
 (7061,              'EXTRAER INFORMACION',             'EXTRAER INFORMACION',
  'SP',              getdate(),                         7,
  'P',               1,                                 'PRESTAMOS',
  null,              'cob_cartera..sp_grupo_pag_env',    1000,
  'lp',              @w_transerver,                     'S',
  @w_path_objetos,   @w_path_listados)
--/////////////////////////////////////////////////////////////////////////////
insert into ba_batch
(ba_batch,           ba_nombre,                         ba_descripcion,
 ba_lenguaje,        ba_fecha_creacion,                 ba_producto,
 ba_tipo_batch,      ba_sec_corrida,                    ba_ente_procesado,
 ba_arch_resultado,  ba_arch_fuente,                    ba_frec_reg_proc,
 ba_impresora,       ba_serv_destino,                   ba_reproceso,
 ba_path_fuente,     ba_path_destino)
 values
 (7062,             'GENERAR ARCHIVO PARA SANTANDER',   'GENERAR ARCHIVO PARA SANTANDER',
  'SP',              getdate(),                         7,
  'P',               1,                                 'PRESTAMOS',
  null,              'cob_cartera..sp_grupo_pag_env',   1000,
  'lp',              @w_transerver,                     'S',
  @w_path_objetos,   @w_path_listados)
--/////////////////////////////////////////////////////////////////////////////
insert into ba_batch
(ba_batch,           ba_nombre,                         ba_descripcion,
 ba_lenguaje,        ba_fecha_creacion,                 ba_producto,
 ba_tipo_batch,      ba_sec_corrida,                    ba_ente_procesado,
 ba_arch_resultado,  ba_arch_fuente,                    ba_frec_reg_proc,
 ba_impresora,       ba_serv_destino,                   ba_reproceso,
 ba_path_fuente,     ba_path_destino)
 values
 (7063,             'CARGAR ARCHIVO SANTANDER',         'CARGAR ARCHIVO SANTANDER',
  'SP',              getdate(),                         7,
  'P',               1,                                 'PRESTAMOS',
  null,              'cob_cartera..sp_grupo_pag_apl',   1000,
  'lp',              @w_transerver,                     'S',
  @w_path_objetos,   @w_path_listados)
--/////////////////////////////////////////////////////////////////////////////
insert into ba_batch
(ba_batch,           ba_nombre,                         ba_descripcion,
 ba_lenguaje,        ba_fecha_creacion,                 ba_producto,
 ba_tipo_batch,      ba_sec_corrida,                    ba_ente_procesado,
 ba_arch_resultado,  ba_arch_fuente,                    ba_frec_reg_proc,
 ba_impresora,       ba_serv_destino,                   ba_reproceso,
 ba_path_fuente,     ba_path_destino)
 values
 (7064,             'CREAR ABONOS EN CARTERA',          'CREAR ABONOS EN CARTERA',
  'SP',              getdate(),                         7,
  'P',               1,                                 'PRESTAMOS',
  null,              'cob_cartera..sp_grupo_pag_apl',   1000,
  'lp',              @w_transerver,                     'S',
  @w_path_objetos,   @w_path_listados)
--/////////////////////////////////////////////////////////////////////////////
insert into ba_batch
(ba_batch,           ba_nombre,                         ba_descripcion,
 ba_lenguaje,        ba_fecha_creacion,                 ba_producto,
 ba_tipo_batch,      ba_sec_corrida,                    ba_ente_procesado,
 ba_arch_resultado,  ba_arch_fuente,                    ba_frec_reg_proc,
 ba_impresora,       ba_serv_destino,                   ba_reproceso,
 ba_path_fuente,     ba_path_destino)
 values
 (7065,             'APLICAR PAGOS MASIVOS',             'APLICAR PAGOS MASIVOS',
  'SP',              getdate(),                          7,
  'P',               1,                                  'PRESTAMOS',
  null,              'cob_cartera..sp_pagos_masivos',    1000,
  'lp',              @w_transerver,                      'S',
  @w_path_objetos,   @w_path_listados)
--/////////////////////////////////////////////////////////////////////////////
insert into ba_batch
(ba_batch,           ba_nombre,                         ba_descripcion,
 ba_lenguaje,        ba_fecha_creacion,                 ba_producto,
 ba_tipo_batch,      ba_sec_corrida,                    ba_ente_procesado,
 ba_arch_resultado,  ba_arch_fuente,                    ba_frec_reg_proc,
 ba_impresora,       ba_serv_destino,                   ba_reproceso,
 ba_path_fuente,     ba_path_destino)
 values
 (7066,             'COBROS ATRASOS - ARCHIVO',         'COBROS ATRASOS - ARCHIVO',
  'SP',              getdate(),                          7,
  'P',               1,                                  'PRESTAMOS',
  null,              'cob_cartera..sp_consulta_pago_solidario', 1000,
  'lp',              @w_transerver,                      'S',
  @w_path_objetos,   @w_path_listados)

--////////////////////////////////////////////////////////////////////////
insert into ba_parametro(pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre,       pa_tipo, pa_valor)
                  values(0,        7061,     0,            1,            'OPCION',        'C',     'I')
insert into ba_parametro(pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre,       pa_tipo, pa_valor)
                  values(0,        7061,     0,            2,            'FECHA_PROCESO', 'D',     '05/16/2017')

insert into ba_parametro(pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre,       pa_tipo, pa_valor)
                  values(0,        7062,     0,            1,            'OPCION',        'C',     'E')
insert into ba_parametro(pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre,       pa_tipo, pa_valor)
                  values(0,        7062,     0,            2,            'FECHA_PROCESO', 'D',     '05/16/2017')
insert into ba_parametro(pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre,       pa_tipo, pa_valor)
                  values(0,        7062,     0,            3,            'ARCHIVO',       'C',     'CBRPRESTGRUPAL')
insert into ba_parametro(pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre,       pa_tipo, pa_valor)
                  values(0,        7062,     0,            4,            'ENTIDAD',       'C',     'STD')

insert into ba_parametro(pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre,       pa_tipo, pa_valor)
                  values(0,        7063,     0,            1,            'OPCION',        'C',     'B')
insert into ba_parametro(pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre,       pa_tipo, pa_valor)
                  values(0,        7063,     0,            2,            'FECHA_PROCESO', 'D',     '05/16/2017')
insert into ba_parametro(pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre,       pa_tipo, pa_valor)
                  values(0,        7063,     0,            3,            'ARCHIVO',       'C',     'CBRPRESTGRUPAL')

insert into ba_parametro(pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre,       pa_tipo, pa_valor)
                  values(0,        7064,     0,            1,            'OPCION',        'C',     'A')
insert into ba_parametro(pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre,       pa_tipo, pa_valor)
                  values(0,        7064,     0,            2,            'FECHA_PROCESO', 'D',     '05/16/2017')

insert into ba_parametro(pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre,       pa_tipo, pa_valor)
                  values(0,        7065,     0,            1,            'FECHA_PROCESO', 'D',     '05/16/2017')
                  
insert into ba_parametro(pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre,       pa_tipo, pa_valor)
                  values(0,        7066,     0,            1,            'OPERACION',     'C',     'G')
                  
insert into ba_parametro(pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre,       pa_tipo, pa_valor)
                  values(0,        7066,     0,            2,            'FECHA_PROCESO', 'D',     '05/16/2017')

insert into ba_parametro(pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre,       pa_tipo, pa_valor)
                  values(0,        7066,     0,            3,            'ARCHIVO',       'C',     'COBRANZA')
                  
--////////////////////////////////////////////////////////////////////////
insert into ba_parametro(pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre,       pa_tipo, pa_valor)
                  values(7008,     7061,     1,            1,            'OPCION',        'C',     'I')
insert into ba_parametro(pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre,       pa_tipo, pa_valor)
                  values(7008,     7061,     1,            2,            'FECHA_PROCESO', 'D',     '05/16/2017')

insert into ba_parametro(pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre,       pa_tipo, pa_valor)
                  values(7008,     7062,     2,            1,            'OPCION',        'C',     'E')
insert into ba_parametro(pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre,       pa_tipo, pa_valor)
                  values(7008,     7062,     2,            2,            'FECHA_PROCESO', 'D',     '05/16/2017')
insert into ba_parametro(pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre,       pa_tipo, pa_valor)
                  values(7008,     7062,     2,            3,            'ARCHIVO',       'C',     'CBRPRESTGRUPAL')
insert into ba_parametro(pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre,       pa_tipo, pa_valor)
                  values(7008,     7062,     2,            4,            'ENTIDAD',       'C',     'STD')

insert into ba_parametro(pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre,       pa_tipo, pa_valor)
                  values(7008,     7063,     3,            1,            'OPCION',        'C',     'B')
insert into ba_parametro(pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre,       pa_tipo, pa_valor)
                  values(7008,     7063,     3,            2,            'FECHA_PROCESO', 'D',     '05/16/2017')
insert into ba_parametro(pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre,       pa_tipo, pa_valor)
                  values(7008,     7063,     3,            3,            'ARCHIVO',       'C',     'CBRPRESTGRUPAL')

insert into ba_parametro(pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre,       pa_tipo, pa_valor)
                  values(7008,     7064,     4,            1,            'OPCION',        'C',     'A')
insert into ba_parametro(pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre,       pa_tipo, pa_valor)
                  values(7008,     7064,     4,            2,            'FECHA_PROCESO', 'D',     '05/16/2017')

insert into ba_parametro(pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre,       pa_tipo, pa_valor)
                  values(7008,     7065,     5,            1,            'FECHA_PROCESO', 'D',     '05/16/2017')

insert into ba_parametro(pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre,       pa_tipo, pa_valor)
                  values(0,        7066,     6,            1,            'OPERACION',     'C',     'G')
                  
insert into ba_parametro(pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre,       pa_tipo, pa_valor)
                  values(0,        7066,     6,            2,            'FECHA_PROCESO', 'D',     '05/16/2017')

insert into ba_parametro(pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre,       pa_tipo, pa_valor)
                  values(0,        7066,     6,            3,            'ARCHIVO',       'C',     'COBRANZA')

--////////////////////////////////////////////////////////////////////////

insert into ba_sarta_batch(sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
                   values (7008,     7061,     1,             null,           'S',           'N',        495,     450,    7008,           'S')
insert into ba_sarta_batch(sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
                   values (7008,     7062,     2,             1,              'S',           'N',        1995,    465,    7008,           'S')
insert into ba_sarta_batch(sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
                   values (7008,     7063,     3,             null,           'S',           'N',        4035,    735,    7008,           'N')
insert into ba_sarta_batch(sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
                   values (7008,     7064,     4,             null,           'S',           'N',        510,     2010,   7008,           'N')
insert into ba_sarta_batch(sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
                   values (7008,     7065,     5,             null,           'S',           'N',        1980,    2010,   7008,           'N')
insert into ba_sarta_batch(sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
                   values (7008,     7066,     6,             null,           'S',           'N',        510,     3000,   7008,           'N')

--///////////////////////////////////////////////////////////////////////////////////////
insert into cobis..ba_enlace (en_sarta    ,en_batch_inicio ,en_secuencial_inicio ,en_batch_fin ,en_secuencial_fin ,en_tipo_enlace ,en_puntos   ,en_entre_lotes)
                      values (7008        ,7061            ,1                    ,7062         ,2                 ,'S'            ,null        ,'N')
insert into cobis..ba_enlace (en_sarta    ,en_batch_inicio ,en_secuencial_inicio ,en_batch_fin ,en_secuencial_fin ,en_tipo_enlace ,en_puntos   ,en_entre_lotes)
                      values (7008        ,7062            ,2                    ,7063         ,3                 ,'S'            ,null        ,'N')
insert into cobis..ba_enlace (en_sarta    ,en_batch_inicio ,en_secuencial_inicio ,en_batch_fin ,en_secuencial_fin ,en_tipo_enlace ,en_puntos   ,en_entre_lotes)
                      values (7008        ,7063            ,3                    ,0            ,0                 ,'S'            ,null        ,'N')
insert into cobis..ba_enlace (en_sarta    ,en_batch_inicio ,en_secuencial_inicio ,en_batch_fin ,en_secuencial_fin ,en_tipo_enlace ,en_puntos   ,en_entre_lotes)
                      values (7008        ,7064            ,4                    ,7065         ,5                 ,'S'            ,null        ,'N')
insert into cobis..ba_enlace (en_sarta    ,en_batch_inicio ,en_secuencial_inicio ,en_batch_fin ,en_secuencial_fin ,en_tipo_enlace ,en_puntos   ,en_entre_lotes)
                      values (7008        ,7065            ,5                    ,0            ,0                 ,'S'            ,null        ,'N')


-- procesos masivos para actualizar control pago y saldos de grupales
delete cobis..ba_sarta where sa_sarta = 7009
delete cobis..ba_batch where ba_batch in (7067, 7068) and ba_producto = 7
delete cobis..ba_sarta_batch where sb_sarta = 7009
delete cobis..ba_parametro where pa_batch in (7067, 7068)
delete cobis..ba_enlace where en_sarta = 7009

--/////////////////////////////////////////////////////////////////////////////
insert into cobis..ba_sarta
(sa_sarta,           sa_nombre,                         sa_descripcion,
 sa_fecha_creacion,  sa_creador,                        sa_producto,
 sa_dependencia,     sa_autorizacion)
values
(7009,               'PROCESOS MASIVOS OPERACIONES GRUPALES',                  'PROCESOS MASIVOS OPERACIONES GRUPALES',
 getdate(),          'admuser',                         7,
 null,                null)

--/////////////////////////////////////////////////////////////////////////////
insert into cobis..ba_batch
(ba_batch,           ba_nombre,                         ba_descripcion,
 ba_lenguaje,        ba_fecha_creacion,                 ba_producto,
 ba_tipo_batch,      ba_sec_corrida,                    ba_ente_procesado,
 ba_arch_resultado,  ba_arch_fuente,                    ba_frec_reg_proc,
 ba_impresora,       ba_serv_destino,                   ba_reproceso,
 ba_path_fuente,     ba_path_destino)
 values
 (7067,              'ACTUALIZAR SALDOS PADRES',        'ACTUALIZAR SALDOS PADRES',
  'SP',              getdate(),                         7,
  'P',               1,                                 'PRESTAMOS',
  null,              'cob_cartera..sp_grupo_upd_masivo',1000,
  'lp',              @w_transerver,                     'S',
  @w_path_objetos,   @w_path_listados)
--/////////////////////////////////////////////////////////////////////////////
insert into ba_batch
(ba_batch,           ba_nombre,                         ba_descripcion,
 ba_lenguaje,        ba_fecha_creacion,                 ba_producto,
 ba_tipo_batch,      ba_sec_corrida,                    ba_ente_procesado,
 ba_arch_resultado,  ba_arch_fuente,                    ba_frec_reg_proc,
 ba_impresora,       ba_serv_destino,                   ba_reproceso,
 ba_path_fuente,     ba_path_destino)
 values
 (7068,             'ACTUALIZAR CONTROL DE PAGO',       'ACTUALIZAR CONTROL DE PAGO',
  'SP',              getdate(),                         7,
  'P',               1,                                 'PRESTAMOS',
  null,              'cob_cartera..sp_grupo_upd_masivo',1000,
  'lp',              @w_transerver,                     'S',
  @w_path_objetos,   @w_path_listados)
--////////////////////////////////////////////////////////////////////////

insert into ba_parametro(pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre,       pa_tipo, pa_valor)
                  values(0,        7067,     0,            1,            'FECHA_PROCESO', 'D',     '05/16/2017')
insert into ba_parametro(pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre,       pa_tipo, pa_valor)
                  values(0,        7067,     0,            2,            'SUMAR_PADRE',   'C',     'S')

insert into ba_parametro(pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre,       pa_tipo, pa_valor)
                  values(0,        7068,     0,            1,            'FECHA_PROCESO', 'D',     '05/16/2017')
insert into ba_parametro(pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre,       pa_tipo, pa_valor)
                  values(0,        7068,     0,            2,            'CONTROL_PAGO',  'C',     'C')
insert into ba_parametro(pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre,       pa_tipo, pa_valor)
                  values(0,        7068,     0,            3,            'OPCION',        'C',     'M')
--////////////////////////////////////////////////////////////////////////
insert into ba_parametro(pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre,       pa_tipo, pa_valor)        
                  values(7009,     7067,     1,            1,            'FECHA_PROCESO', 'D',     '05/16/2017')    
insert into ba_parametro(pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre,       pa_tipo, pa_valor)        
                  values(7009,     7067,     1,            2,            'SUMAR_PADRE',   'C',     'S')             

insert into ba_parametro(pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre,       pa_tipo, pa_valor)      
                  values(7009,     7068,     2,            1,            'FECHA_PROCESO', 'D',     '05/16/2017')  
insert into ba_parametro(pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre,       pa_tipo, pa_valor)      
                  values(7009,     7068,     2,            2,            'CONTROL_PAGO',  'C',     'C')           
insert into ba_parametro(pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre,       pa_tipo, pa_valor)      
                  values(7009,     7068,     2,            3,            'OPCION',        'C',     'M')           

--////////////////////////////////////////////////////////////////////////

insert into ba_sarta_batch(sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
                   values (7009,     7067,     1,             null,           'S',           'N',        495,     450,    7009,           'S')
insert into ba_sarta_batch(sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
                   values (7009,     7068,     2,             1,              'S',           'N',        1995,    465,    7009,           'S')

--///////////////////////////////////////////////////////////////////////////////////////
insert into cobis..ba_enlace (en_sarta    ,en_batch_inicio ,en_secuencial_inicio ,en_batch_fin ,en_secuencial_fin ,en_tipo_enlace ,en_puntos   ,en_entre_lotes)
                      values (7009        ,7067            ,1                    ,7068         ,2                 ,'D'            ,null        ,'N')
insert into cobis..ba_enlace (en_sarta    ,en_batch_inicio ,en_secuencial_inicio ,en_batch_fin ,en_secuencial_fin ,en_tipo_enlace ,en_puntos   ,en_entre_lotes)
                      values (7009        ,7068            ,2                    ,7063         ,3                 ,'S'            ,null        ,'N')


go

--///////////////////////////////////////////////////////////////////////////////////////

delete from cobis..ba_batch where ba_batch = 7091
delete from cobis..ba_parametro where pa_batch = 7091

insert into cobis..ba_batch values(7091,'CANCELACION ANTICIPADA DE LCR POR INACTIVIDAD','CANCELACION ANTICIPADA DE LCR POR INACTIVIDAD','SP',getdate(),	7,	'P',1,NULL,NULL,'cob_cartera..sp_lcr_cancelacion_ba',10000,	NULL,'CTSSRV','S','C:\Cobis\VBatch\cartera\Objetos\','C:\Cobis\VBatch\cartera\listados\')

insert into ba_parametro values(0,7091,0,1,'FECHA PROCESO','D','09/08/2019')
insert into ba_parametro values(22,7091,5,1,'FECHA PROCESO','D','09/08/2019')

go

---BATCH PARA APLICACION DE SEGURO ADICIONAL REESTRUCTURACION
delete from cobis..cl_parametro where pa_nemonico = 'SEGAD' and pa_producto='CCA'

insert into cobis..cl_parametro (pa_parametro,pa_nemonico, pa_tipo,pa_money, pa_producto)
values('VALOR SEGURO ADICIONAL','SEGAD','M',48.00,'CCA')

delete from ba_parametro where pa_batch = 7095
delete from ba_batch where ba_batch = 7095

INSERT INTO dbo.ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (7095, 'APLICACION DE SEGURO ADICIONAL REESTRUCTURACIONES', 'APLICACION DE SEGURO ADICIONAL REESTRUCTURACIONES', 'SP', getDate(), 7, 'P', 1, NULL, 'DSP_.txt', 'cob_cartera..sp_reestructuracion_cobro_seg', 10000, NULL, 'CTSSRV', 'S', 'C:\Cobis\VBatch\Cartera\Objetos\', 'C:\Cobis\VBatch\Cartera\listados\Desplazamientos\')


INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 7095, 0, 1, 'FECHA PROCESO', 'D', '10/09/2019')

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 7095, 0, 2, 'ARCHIVO', 'C', 'Reestructuracion_17042020_V2.txt')

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (99, 7095, 19, 1, 'FECHA PROCESO', 'D', '04/06/2020')

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (99, 7095, 19, 2, 'ARCHIVO', 'C', 'Reestructuracion_17042020_V2.txt')

go

use cobis
go


if exists (select 1 from cobis..ba_batch where ba_batch = 7975) 
begin
   delete from cobis..ba_batch where ba_batch = 7975		
end

INSERT INTO cobis.dbo.ba_batch
(ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES(7975, 'Reporte Seguros Zurich', 'Generación del reporte seguros Zurich', 'SP ', getdate(), 7, 'R', 0, 'cartera', 'SEGUROSZURICH_DDMMYYYY.csv', 'cob_cartera..sp_batch_seguros_zurich', 1000, 'lp', 'CTSSRV', 'S', 'C:\Cobis\VBatch\Cartera\Objetos\', 'C:\Cobis\VBatch\Cartera\listados\');

go
----------------------->>>>>>>>>>>>>>>>>>>>>>>----------------------->>>>>>>>>>>>>>>>>>>>>>>----------------------->>>>>>>>>>>>>>>>>>>>>>>
----------------------->>>>>>>>>>>>>>>>>>>>>>>Caso#166547
----------------------->>>>>>>>>>>>>>>>>>>>>>>----------------------->>>>>>>>>>>>>>>>>>>>>>>----------------------->>>>>>>>>>>>>>>>>>>>>>>
declare @w_batch int
select @w_batch = 7977--se toma el ultimo numero, puede variar.

--Nuevo
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
					  
delete from ba_parametro where pa_batch = @w_batch and pa_nombre = 'FECHA PROCESO'
insert into ba_parametro(pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre,       pa_tipo, pa_valor)
values (0,       @w_batch, 0,            1,            'FECHA PROCESO',  'D',     '08/06/2021')
go

-- 140636 - BATCH PARA ENVIO DE SMS
delete cobis..ba_batch 
where ba_producto = 7
and   ba_batch IN (7978,7979)
INSERT INTO cobis..ba_batch (ba_batch,ba_nombre,ba_descripcion,ba_lenguaje,ba_fecha_creacion,ba_producto,ba_tipo_batch,ba_sec_corrida,ba_ente_procesado,ba_arch_resultado,ba_arch_fuente,ba_frec_reg_proc,ba_impresora,ba_serv_destino,ba_reproceso,ba_path_fuente,ba_path_destino) 
VALUES(7978,'GENERACION SMS COBRANZAS','GENERACION SMS COBRANZAS','SP ',GETDATE(),7,'R',1,'CARTERA',null,'cob_cartera..sp_batch_env_sms_cobranza',10000,null,'CTSSRV','S','C:\Cobis\VBatch\Cartera\Objetos\','C:\Cobis\VBatch\Cartera\listados\')

INSERT INTO cobis..ba_batch (ba_batch,ba_nombre,ba_descripcion,ba_lenguaje,ba_fecha_creacion,ba_producto,ba_tipo_batch,ba_sec_corrida,ba_ente_procesado,ba_arch_resultado,ba_arch_fuente,ba_frec_reg_proc,ba_impresora,ba_serv_destino,ba_reproceso,ba_path_fuente,ba_path_destino) 
VALUES(7979,'GENERACION SMS RECORDTORIOS','GENERACION SMS RECORDATORIOS','SP ',GETDATE(),7,'R',1,'CARTERA',null,'cob_cartera..sp_batch_env_sms_recordatorios',10000,null,'CTSSRV','S','C:\Cobis\VBatch\Cartera\Objetos\','C:\Cobis\VBatch\Cartera\listados\')
GO
