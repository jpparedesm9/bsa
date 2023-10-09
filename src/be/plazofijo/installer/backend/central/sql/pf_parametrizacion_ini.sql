/************************************************************************/
/*                 Descripcion                                          */
/*  Script para Insercion de Parametrizacion Inicial                    */
/************************************************************************/
/*                                                                      */
/*  Fecha         Autor    Comentario                                   */
/*  06-Sept-2016  EMO      Parametrizacion Basica                       */
/************************************************************************/
use cobis
go

SET NOCOUNT ON
go

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

print '***********************************************'
print '***** INSERCION PARAMETRIZACION TEMPORAL ******'
print '***********************************************'
print ''
print 'Inicio Ejecucion Insercion Parametrizacion Temporal : ' + convert(varchar(60),getdate(),109)
print ''

print '-->Parametrizacion: Tipo de Deposito'
if exists (select 1 from cob_pfijo..pf_tipo_deposito) begin
   delete from cob_pfijo..pf_tipo_deposito
end

insert into cob_pfijo..pf_tipo_deposito(td_tipo_deposito, td_mnemonico, td_descripcion,              td_forma_pago, td_capitalizacion, td_dias_reverso, td_base_calculo, td_estado, td_fecha_crea, td_fecha_mod, td_mantiene_stock, td_stock, td_emision_inicial, td_anio_comercial, td_num_dias_gracia, td_dias_gracia, td_prorroga_aut, td_num_prorrogas, td_tasa_variable, td_tasa_efectiva, td_retiene_impto, td_tran_sabado, td_paga_comision, td_cupon, td_cambio_tasa, td_incr_decr, td_area_contable, td_tipo_persona, td_tipo_tasa_var, td_dias_reales, td_tipo_banca, td_desmaterializa, td_num_serie,   td_periodo_tasa, td_tasa_precancela, td_encaje_legal) 
                                values (1,                'DF1',        'CDT AL VENCIMIENTO NO CAP', 'VEN',         'N',               0,               '360',           'A',       getdate(),     getdate(),    null,              0,        0,                  'N',               0,                  'N',            'S',             999999,           'N',              'N',              'N',              'N',            'N',              'N',      'S',            'N',          31,               'J',             null,             'N',            'COR',         'N',               'CTRE274D0001', null,            null,               null) 
insert into cob_pfijo..pf_tipo_deposito(td_tipo_deposito, td_mnemonico, td_descripcion,              td_forma_pago, td_capitalizacion, td_dias_reverso, td_base_calculo, td_estado, td_fecha_crea, td_fecha_mod, td_mantiene_stock, td_stock, td_emision_inicial, td_anio_comercial, td_num_dias_gracia, td_dias_gracia, td_prorroga_aut, td_num_prorrogas, td_tasa_variable, td_tasa_efectiva, td_retiene_impto, td_tran_sabado, td_paga_comision, td_cupon, td_cambio_tasa, td_incr_decr, td_area_contable, td_tipo_persona, td_tipo_tasa_var, td_dias_reales, td_tipo_banca, td_desmaterializa, td_num_serie,   td_periodo_tasa, td_tasa_precancela, td_encaje_legal) 
                                values (2,                'DF2',        'CDT AL VENCIMIENTO CAP',    'VEN',         'S',               0,               '360',           'A',       getdate(),     getdate(),    null,              0,        0,                  'N',               0,                  'N',            'S',             999999,           'N',              'N',              'N',              'N',            'N',              'N',      'S',            'N',          31,               'J',             null,             'N',            'COR',         'N',               'CTRE274D0001', null,            null,               null)
insert into cob_pfijo..pf_tipo_deposito(td_tipo_deposito, td_mnemonico, td_descripcion,              td_forma_pago, td_capitalizacion, td_dias_reverso, td_base_calculo, td_estado, td_fecha_crea, td_fecha_mod, td_mantiene_stock, td_stock, td_emision_inicial, td_anio_comercial, td_num_dias_gracia, td_dias_gracia, td_prorroga_aut, td_num_prorrogas, td_tasa_variable, td_tasa_efectiva, td_retiene_impto, td_tran_sabado, td_paga_comision, td_cupon, td_cambio_tasa, td_incr_decr, td_area_contable, td_tipo_persona, td_tipo_tasa_var, td_dias_reales, td_tipo_banca, td_desmaterializa, td_num_serie,   td_periodo_tasa, td_tasa_precancela, td_encaje_legal) 
                                values (3,                'DF3',        'CDT PERIODICO NO CAP',      'PER',         'N',               0,               '360',           'A',       getdate(),     getdate(),    null,              0,        0,                  'N',               0,                  'N',            'S',             999999,           'N',              'N',              'N',              'N',            'N',              'N',      'S',            'N',          31,               'J',             null,             'N',            'COR',         'N',               'CTRE274D0001', null,            null,               null) 
insert into cob_pfijo..pf_tipo_deposito(td_tipo_deposito, td_mnemonico, td_descripcion,              td_forma_pago, td_capitalizacion, td_dias_reverso, td_base_calculo, td_estado, td_fecha_crea, td_fecha_mod, td_mantiene_stock, td_stock, td_emision_inicial, td_anio_comercial, td_num_dias_gracia, td_dias_gracia, td_prorroga_aut, td_num_prorrogas, td_tasa_variable, td_tasa_efectiva, td_retiene_impto, td_tran_sabado, td_paga_comision, td_cupon, td_cambio_tasa, td_incr_decr, td_area_contable, td_tipo_persona, td_tipo_tasa_var, td_dias_reales, td_tipo_banca, td_desmaterializa, td_num_serie,   td_periodo_tasa, td_tasa_precancela, td_encaje_legal) 
                                values (4,                'DF4',        'CDT PERIODICO CAP',         'PER',         'S',               0,               '360',           'A',       getdate(),     getdate(),    null,              0,        0,                  'N',               0,                  'N',            'S',             999999,           'N',              'N',              'N',              'N',            'N',              'N',      'S',            'N',          31,               'J',             null,             'N',            'COR',         'N',               'CTRE274D0001', null,            null,               null)


print '-->Parametrizacion Temporal: Montos'
if exists (select 1 from cob_pfijo..pf_monto) begin
   delete from cob_pfijo..pf_monto
end

insert into cob_pfijo..pf_monto values(1, 'M01', 'DE 1 A 9.999.999.999.999.99', '1', '9999999999999.99', getdate(), getdate())
go

print '-->Parametrizacion Temporal: Plazos'
if exists (select 1 from cob_pfijo..pf_plazo) begin
   delete from cob_pfijo..pf_plazo
end

insert into cob_pfijo..pf_plazo values(1,  'P01', 'PLAZO DE 30  A 60   DIAS', 30,   60,   getdate(), getdate(), 'P1')
insert into cob_pfijo..pf_plazo values(2,  'P02', 'PLAZO DE 61  A 90   DIAS', 61,   90,   getdate(), getdate(), 'P2')
insert into cob_pfijo..pf_plazo values(3,  'P03', 'PLAZO DE 91  A 120  DIAS', 91,   120,  getdate(), getdate(), 'P3')
insert into cob_pfijo..pf_plazo values(4,  'P04', 'PLAZO DE 121 A 150  DIAS', 121,  150,  getdate(), getdate(), 'P4')
insert into cob_pfijo..pf_plazo values(5,  'P05', 'PLAZO DE 151 A 180  DIAS', 151,  180,  getdate(), getdate(), 'P5')
insert into cob_pfijo..pf_plazo values(6,  'P06', 'PLAZO DE 181 A 270  DIAS', 181,  270,  getdate(), getdate(), 'P6')
insert into cob_pfijo..pf_plazo values(7,  'P07', 'PLAZO DE 271 A 360  DIAS', 271,  360,  getdate(), getdate(), 'P7')
insert into cob_pfijo..pf_plazo values(8,  'P08', 'PLAZO DE 361 A 540  DIAS', 361,  540,  getdate(), getdate(), 'P8')
insert into cob_pfijo..pf_plazo values(9,  'P09', 'PLAZO DE 541 A 720  DIAS', 541,  720,  getdate(), getdate(), 'P9')
insert into cob_pfijo..pf_plazo values(10, 'P10', 'PLAZO DE 721 A 1080 DIAS', 721,  1080, getdate(), getdate(), 'P10')
insert into cob_pfijo..pf_plazo values(11, 'P11', 'PLAZO MAYOR  A 1081 DIAS', 1080, 9999, getdate(), getdate(), 'P11')
go

print '-->Parametrizacion Temporal: Formas de Pago'
if exists (select 1 from cob_pfijo..pf_fpago) begin
   delete from cob_pfijo..pf_fpago
end
go

insert into cob_pfijo..pf_fpago values (1, 'EFEC',  'EFECTIVO',             0, 'N', getdate(), getdate(), 'A', 14, 31, 'N', 'A', 'N')
insert into cob_pfijo..pf_fpago values (3, 'OTROS', 'OTROS MEDIOS DE PAGO', 0, 'N', getdate(), getdate(), 'A', 14, 31, 'N', 'A', 'N')
insert into cob_pfijo..pf_fpago values (4, 'CHQL',  'CHEQUE LOCAL',         0, 'C', getdate(), getdate(), 'A', 14, 31, 'N', 'R', 'N')
insert into cob_pfijo..pf_fpago values (5, 'CHQE',  'CHEQUE EXTERIOR',      0, 'C', getdate(), getdate(), 'A', 14, 31, 'N', 'R', 'N')

if exists(select * from cobis..ad_pro_instalado where pi_producto = 'SBA')
    insert into cob_pfijo..pf_fpago values (6, 'CHG',   'CHEQUE DE GERENCIA',   0, 'C', getdate(), getdate(), 'A', 42, 31, 'N', 'P', 'N')
else
    insert into cob_pfijo..pf_fpago values (6, 'CHG',   'CHEQUE DE GERENCIA',   0, 'C', getdate(), getdate(), 'A', 14, 31, 'N', 'P', 'N')

if exists(select * from cobis..ad_pro_instalado where pi_producto = 'AHO')
    insert into cob_pfijo..pf_fpago values (7, 'AHO',   'CUENTA AHORRO',        0, 'S', getdate(), getdate(), 'A', 4,   31, 'N', 'A', 'S')
else
    insert into cob_pfijo..pf_fpago values (7, 'AHO',   'CUENTA AHORRO',        0, 'S', getdate(), getdate(), 'A', 14,  31, 'N', 'A', 'S')

if exists(select * from cobis..ad_pro_instalado where pi_producto = 'CTE')
    insert into cob_pfijo..pf_fpago values (8, 'CTE',   'CUENTA CORRIENTE',     0, 'S', getdate(), getdate(), 'A', 3,  31, 'N', 'A', 'S')
else
    insert into cob_pfijo..pf_fpago values (8, 'CTE',   'CUENTA CORRIENTE',     0, 'S', getdate(), getdate(), 'A', 14, 31, 'N', 'A', 'S')
go

print '-->Parametrizacion Temporal: Frecuencias de Pago'
if exists (select 1 from cob_pfijo..pf_ppago) begin
   delete from cob_pfijo..pf_ppago
end
go

insert into cob_pfijo..pf_ppago(pp_codigo, pp_descripcion, pp_factor_en_meses, pp_estado, pp_fecha_crea, pp_fecha_mod, pp_factor_dias)
                         values('1M',      'MENSUAL',      1,                  'A',       getdate(),     getdate(),    30)
insert into cob_pfijo..pf_ppago(pp_codigo, pp_descripcion, pp_factor_en_meses, pp_estado, pp_fecha_crea, pp_fecha_mod, pp_factor_dias)
                         values('2M',      'BIMENSUAL',    2,                  'A',       getdate(),     getdate(),    60)
insert into cob_pfijo..pf_ppago(pp_codigo, pp_descripcion, pp_factor_en_meses, pp_estado, pp_fecha_crea, pp_fecha_mod, pp_factor_dias)
                         values('3M',      'TRIMESTRAL',   3,                  'A',       getdate(),     getdate(),    90)
insert into cob_pfijo..pf_ppago(pp_codigo, pp_descripcion, pp_factor_en_meses, pp_estado, pp_fecha_crea, pp_fecha_mod, pp_factor_dias)
                         values('6M',      'SEMESTRAL',    6,                  'A',       getdate(),     getdate(),    180)
insert into cob_pfijo..pf_ppago(pp_codigo, pp_descripcion, pp_factor_en_meses, pp_estado, pp_fecha_crea, pp_fecha_mod, pp_factor_dias)
                         values('12M',     'ANUAL',        12,                 'A',       getdate(),     getdate(),    360)
go

print '-->Parametrizacion Temporal: Feriados Oficina'
if exists (select 1 from cob_pfijo..pf_feriados_oficina) begin
    delete from cob_pfijo..pf_feriados_oficina
end
go

print '-->Parametrizacion Temporal: Tasa'
if exists (select 1 from cob_pfijo..pf_tasa) begin
   delete from cob_pfijo..pf_tasa
end
go

insert into cob_pfijo..pf_tasa values('DF1', 0, 'M01', 'P01', 4.50, 5.50, 5.00, getdate(), getdate(), 5.00, 'sa', 'N', null)
insert into cob_pfijo..pf_tasa values('DF1', 0, 'M01', 'P02', 4.55, 5.55, 5.05, getdate(), getdate(), 5.05, 'sa', 'N', null)
insert into cob_pfijo..pf_tasa values('DF1', 0, 'M01', 'P03', 4.60, 5.60, 5.10, getdate(), getdate(), 5.10, 'sa', 'N', null)
insert into cob_pfijo..pf_tasa values('DF1', 0, 'M01', 'P04', 4.65, 5.65, 5.15, getdate(), getdate(), 5.15, 'sa', 'N', null)
insert into cob_pfijo..pf_tasa values('DF1', 0, 'M01', 'P05', 4.70, 5.70, 5.20, getdate(), getdate(), 5.20, 'sa', 'N', null)
insert into cob_pfijo..pf_tasa values('DF1', 0, 'M01', 'P06', 4.75, 5.75, 5.25, getdate(), getdate(), 5.25, 'sa', 'N', null)
insert into cob_pfijo..pf_tasa values('DF1', 0, 'M01', 'P07', 4.80, 5.80, 5.30, getdate(), getdate(), 5.30, 'sa', 'N', null)
insert into cob_pfijo..pf_tasa values('DF1', 0, 'M01', 'P08', 4.85, 5.85, 5.35, getdate(), getdate(), 5.35, 'sa', 'N', null)
insert into cob_pfijo..pf_tasa values('DF1', 0, 'M01', 'P09', 4.90, 5.90, 5.40, getdate(), getdate(), 5.40, 'sa', 'N', null)
insert into cob_pfijo..pf_tasa values('DF1', 0, 'M01', 'P10', 4.95, 5.95, 5.45, getdate(), getdate(), 5.45, 'sa', 'N', null)
insert into cob_pfijo..pf_tasa values('DF1', 0, 'M01', 'P11', 5.00, 6.00, 5.50, getdate(), getdate(), 5.50, 'sa', 'N', null)

insert into cob_pfijo..pf_tasa values('DF2', 0, 'M01', 'P01', 4.50, 5.50, 5.00, getdate(), getdate(), 5.00, 'sa', 'N', null)
insert into cob_pfijo..pf_tasa values('DF2', 0, 'M01', 'P02', 4.55, 5.55, 5.05, getdate(), getdate(), 5.05, 'sa', 'N', null)
insert into cob_pfijo..pf_tasa values('DF2', 0, 'M01', 'P03', 4.60, 5.60, 5.10, getdate(), getdate(), 5.10, 'sa', 'N', null)
insert into cob_pfijo..pf_tasa values('DF2', 0, 'M01', 'P04', 4.65, 5.65, 5.15, getdate(), getdate(), 5.15, 'sa', 'N', null)
insert into cob_pfijo..pf_tasa values('DF2', 0, 'M01', 'P05', 4.70, 5.70, 5.20, getdate(), getdate(), 5.20, 'sa', 'N', null)
insert into cob_pfijo..pf_tasa values('DF2', 0, 'M01', 'P06', 4.75, 5.75, 5.25, getdate(), getdate(), 5.25, 'sa', 'N', null)
insert into cob_pfijo..pf_tasa values('DF2', 0, 'M01', 'P07', 4.80, 5.80, 5.30, getdate(), getdate(), 5.30, 'sa', 'N', null)
insert into cob_pfijo..pf_tasa values('DF2', 0, 'M01', 'P08', 4.85, 5.85, 5.35, getdate(), getdate(), 5.35, 'sa', 'N', null)
insert into cob_pfijo..pf_tasa values('DF2', 0, 'M01', 'P09', 4.90, 5.90, 5.40, getdate(), getdate(), 5.40, 'sa', 'N', null)
insert into cob_pfijo..pf_tasa values('DF2', 0, 'M01', 'P10', 4.95, 5.95, 5.45, getdate(), getdate(), 5.45, 'sa', 'N', null)
insert into cob_pfijo..pf_tasa values('DF2', 0, 'M01', 'P11', 5.00, 6.00, 5.50, getdate(), getdate(), 5.50, 'sa', 'N', null)

insert into cob_pfijo..pf_tasa values('DF3', 0, 'M01', 'P01', 4.50, 5.50, 5.00, getdate(), getdate(), 5.00, 'sa', 'N', null)
insert into cob_pfijo..pf_tasa values('DF3', 0, 'M01', 'P02', 4.55, 5.55, 5.05, getdate(), getdate(), 5.05, 'sa', 'N', null)
insert into cob_pfijo..pf_tasa values('DF3', 0, 'M01', 'P03', 4.60, 5.60, 5.10, getdate(), getdate(), 5.10, 'sa', 'N', null)
insert into cob_pfijo..pf_tasa values('DF3', 0, 'M01', 'P04', 4.65, 5.65, 5.15, getdate(), getdate(), 5.15, 'sa', 'N', null)
insert into cob_pfijo..pf_tasa values('DF3', 0, 'M01', 'P05', 4.70, 5.70, 5.20, getdate(), getdate(), 5.20, 'sa', 'N', null)
insert into cob_pfijo..pf_tasa values('DF3', 0, 'M01', 'P06', 4.75, 5.75, 5.25, getdate(), getdate(), 5.25, 'sa', 'N', null)
insert into cob_pfijo..pf_tasa values('DF3', 0, 'M01', 'P07', 4.80, 5.80, 5.30, getdate(), getdate(), 5.30, 'sa', 'N', null)
insert into cob_pfijo..pf_tasa values('DF3', 0, 'M01', 'P08', 4.85, 5.85, 5.35, getdate(), getdate(), 5.35, 'sa', 'N', null)
insert into cob_pfijo..pf_tasa values('DF3', 0, 'M01', 'P09', 4.90, 5.90, 5.40, getdate(), getdate(), 5.40, 'sa', 'N', null)
insert into cob_pfijo..pf_tasa values('DF3', 0, 'M01', 'P10', 4.95, 5.95, 5.45, getdate(), getdate(), 5.45, 'sa', 'N', null)
insert into cob_pfijo..pf_tasa values('DF3', 0, 'M01', 'P11', 5.00, 6.00, 5.50, getdate(), getdate(), 5.50, 'sa', 'N', null)

insert into cob_pfijo..pf_tasa values('DF4', 0, 'M01', 'P01', 4.50, 5.50, 5.00, getdate(), getdate(), 5.00, 'sa', 'N', null)
insert into cob_pfijo..pf_tasa values('DF4', 0, 'M01', 'P02', 4.55, 5.55, 5.05, getdate(), getdate(), 5.05, 'sa', 'N', null)
insert into cob_pfijo..pf_tasa values('DF4', 0, 'M01', 'P03', 4.60, 5.60, 5.10, getdate(), getdate(), 5.10, 'sa', 'N', null)
insert into cob_pfijo..pf_tasa values('DF4', 0, 'M01', 'P04', 4.65, 5.65, 5.15, getdate(), getdate(), 5.15, 'sa', 'N', null)
insert into cob_pfijo..pf_tasa values('DF4', 0, 'M01', 'P05', 4.70, 5.70, 5.20, getdate(), getdate(), 5.20, 'sa', 'N', null)
insert into cob_pfijo..pf_tasa values('DF4', 0, 'M01', 'P06', 4.75, 5.75, 5.25, getdate(), getdate(), 5.25, 'sa', 'N', null)
insert into cob_pfijo..pf_tasa values('DF4', 0, 'M01', 'P07', 4.80, 5.80, 5.30, getdate(), getdate(), 5.30, 'sa', 'N', null)
insert into cob_pfijo..pf_tasa values('DF4', 0, 'M01', 'P08', 4.85, 5.85, 5.35, getdate(), getdate(), 5.35, 'sa', 'N', null)
insert into cob_pfijo..pf_tasa values('DF4', 0, 'M01', 'P09', 4.90, 5.90, 5.40, getdate(), getdate(), 5.40, 'sa', 'N', null)
insert into cob_pfijo..pf_tasa values('DF4', 0, 'M01', 'P10', 4.95, 5.95, 5.45, getdate(), getdate(), 5.45, 'sa', 'N', null)
insert into cob_pfijo..pf_tasa values('DF4', 0, 'M01', 'P11', 5.00, 6.00, 5.50, getdate(), getdate(), 5.50, 'sa', 'N', null)



go

print '-->Parametrizacion Temporal: Tipo de Auxiliar'
if exists (select 1 from cob_pfijo..pf_auxiliar_tip) begin
   delete from cob_pfijo..pf_auxiliar_tip
end
go

insert into cob_pfijo..pf_auxiliar_tip values (1, 0, 'CAT', 'NOM', 'A', getdate(), getdate(), null)
insert into cob_pfijo..pf_auxiliar_tip values (1, 0, 'MOT', 'M01', 'A', getdate(), getdate(), null)
insert into cob_pfijo..pf_auxiliar_tip values (1, 0, 'PLA', 'P01', 'A', getdate(), getdate(), null)
insert into cob_pfijo..pf_auxiliar_tip values (1, 0, 'PLA', 'P02', 'A', getdate(), getdate(), null)
insert into cob_pfijo..pf_auxiliar_tip values (1, 0, 'PLA', 'P03', 'A', getdate(), getdate(), null)
insert into cob_pfijo..pf_auxiliar_tip values (1, 0, 'PLA', 'P04', 'A', getdate(), getdate(), null)
insert into cob_pfijo..pf_auxiliar_tip values (1, 0, 'PLA', 'P05', 'A', getdate(), getdate(), null)
insert into cob_pfijo..pf_auxiliar_tip values (1, 0, 'PLA', 'P06', 'A', getdate(), getdate(), null)
insert into cob_pfijo..pf_auxiliar_tip values (1, 0, 'PLA', 'P07', 'A', getdate(), getdate(), null)
insert into cob_pfijo..pf_auxiliar_tip values (1, 0, 'PLA', 'P08', 'A', getdate(), getdate(), null)
insert into cob_pfijo..pf_auxiliar_tip values (1, 0, 'PLA', 'P09', 'A', getdate(), getdate(), null)
insert into cob_pfijo..pf_auxiliar_tip values (1, 0, 'PLA', 'P10', 'A', getdate(), getdate(), null)
insert into cob_pfijo..pf_auxiliar_tip values (1, 0, 'PLA', 'P11', 'A', getdate(), getdate(), null)

insert into cob_pfijo..pf_auxiliar_tip select 1, 0, 'OFI', convert(varchar, of_oficina), 'A', getdate(), getdate(), null from cobis..cl_oficina

insert into cob_pfijo..pf_auxiliar_tip values (2, 0, 'CAT', 'NOM', 'A', getdate(), getdate(), null)
insert into cob_pfijo..pf_auxiliar_tip values (2, 0, 'MOT', 'M01', 'A', getdate(), getdate(), null)
insert into cob_pfijo..pf_auxiliar_tip values (2, 0, 'PLA', 'P01', 'A', getdate(), getdate(), null)
insert into cob_pfijo..pf_auxiliar_tip values (2, 0, 'PLA', 'P02', 'A', getdate(), getdate(), null)
insert into cob_pfijo..pf_auxiliar_tip values (2, 0, 'PLA', 'P03', 'A', getdate(), getdate(), null)
insert into cob_pfijo..pf_auxiliar_tip values (2, 0, 'PLA', 'P04', 'A', getdate(), getdate(), null)
insert into cob_pfijo..pf_auxiliar_tip values (2, 0, 'PLA', 'P05', 'A', getdate(), getdate(), null)
insert into cob_pfijo..pf_auxiliar_tip values (2, 0, 'PLA', 'P06', 'A', getdate(), getdate(), null)
insert into cob_pfijo..pf_auxiliar_tip values (2, 0, 'PLA', 'P07', 'A', getdate(), getdate(), null)
insert into cob_pfijo..pf_auxiliar_tip values (2, 0, 'PLA', 'P08', 'A', getdate(), getdate(), null)
insert into cob_pfijo..pf_auxiliar_tip values (2, 0, 'PLA', 'P09', 'A', getdate(), getdate(), null)
insert into cob_pfijo..pf_auxiliar_tip values (2, 0, 'PLA', 'P10', 'A', getdate(), getdate(), null)
insert into cob_pfijo..pf_auxiliar_tip values (2, 0, 'PLA', 'P11', 'A', getdate(), getdate(), null)

insert into cob_pfijo..pf_auxiliar_tip select 2, 0, 'OFI', convert(varchar, of_oficina), 'A', getdate(), getdate(), null from cobis..cl_oficina

insert into cob_pfijo..pf_auxiliar_tip values (3, 0, 'CAT', 'NOM', 'A', getdate(), getdate(), null)
insert into cob_pfijo..pf_auxiliar_tip values (3, 0, 'MOT', 'M01', 'A', getdate(), getdate(), null)
insert into cob_pfijo..pf_auxiliar_tip values (3, 0, 'PLA', 'P01', 'A', getdate(), getdate(), null)
insert into cob_pfijo..pf_auxiliar_tip values (3, 0, 'PLA', 'P02', 'A', getdate(), getdate(), null)
insert into cob_pfijo..pf_auxiliar_tip values (3, 0, 'PLA', 'P03', 'A', getdate(), getdate(), null)
insert into cob_pfijo..pf_auxiliar_tip values (3, 0, 'PLA', 'P04', 'A', getdate(), getdate(), null)
insert into cob_pfijo..pf_auxiliar_tip values (3, 0, 'PLA', 'P05', 'A', getdate(), getdate(), null)
insert into cob_pfijo..pf_auxiliar_tip values (3, 0, 'PLA', 'P06', 'A', getdate(), getdate(), null)
insert into cob_pfijo..pf_auxiliar_tip values (3, 0, 'PLA', 'P07', 'A', getdate(), getdate(), null)
insert into cob_pfijo..pf_auxiliar_tip values (3, 0, 'PLA', 'P08', 'A', getdate(), getdate(), null)
insert into cob_pfijo..pf_auxiliar_tip values (3, 0, 'PLA', 'P09', 'A', getdate(), getdate(), null)
insert into cob_pfijo..pf_auxiliar_tip values (3, 0, 'PLA', 'P10', 'A', getdate(), getdate(), null)
insert into cob_pfijo..pf_auxiliar_tip values (3, 0, 'PLA', 'P11', 'A', getdate(), getdate(), null)

insert into cob_pfijo..pf_auxiliar_tip select 3, 0, 'OFI', convert(varchar, of_oficina), 'A', getdate(), getdate(), null from cobis..cl_oficina

insert into cob_pfijo..pf_auxiliar_tip values (4, 0, 'CAT', 'NOM', 'A', getdate(), getdate(), null)
insert into cob_pfijo..pf_auxiliar_tip values (4, 0, 'MOT', 'M01', 'A', getdate(), getdate(), null)
insert into cob_pfijo..pf_auxiliar_tip values (4, 0, 'PLA', 'P01', 'A', getdate(), getdate(), null)
insert into cob_pfijo..pf_auxiliar_tip values (4, 0, 'PLA', 'P02', 'A', getdate(), getdate(), null)
insert into cob_pfijo..pf_auxiliar_tip values (4, 0, 'PLA', 'P03', 'A', getdate(), getdate(), null)
insert into cob_pfijo..pf_auxiliar_tip values (4, 0, 'PLA', 'P04', 'A', getdate(), getdate(), null)
insert into cob_pfijo..pf_auxiliar_tip values (4, 0, 'PLA', 'P05', 'A', getdate(), getdate(), null)
insert into cob_pfijo..pf_auxiliar_tip values (4, 0, 'PLA', 'P06', 'A', getdate(), getdate(), null)
insert into cob_pfijo..pf_auxiliar_tip values (4, 0, 'PLA', 'P07', 'A', getdate(), getdate(), null)
insert into cob_pfijo..pf_auxiliar_tip values (4, 0, 'PLA', 'P08', 'A', getdate(), getdate(), null)
insert into cob_pfijo..pf_auxiliar_tip values (4, 0, 'PLA', 'P09', 'A', getdate(), getdate(), null)
insert into cob_pfijo..pf_auxiliar_tip values (4, 0, 'PLA', 'P10', 'A', getdate(), getdate(), null)
insert into cob_pfijo..pf_auxiliar_tip values (4, 0, 'PLA', 'P11', 'A', getdate(), getdate(), null)

insert into cob_pfijo..pf_auxiliar_tip select 4, 0, 'OFI', convert(varchar, of_oficina), 'A', getdate(), getdate(), null from cobis..cl_oficina

insert into cob_pfijo..pf_auxiliar_tip values (3, 0, 'PPE', '12M', 'A', getdate(), getdate(), null)
insert into cob_pfijo..pf_auxiliar_tip values (3, 0, 'PPE', '1M',  'A', getdate(), getdate(), null)
insert into cob_pfijo..pf_auxiliar_tip values (3, 0, 'PPE', '2M',  'A', getdate(), getdate(), null)
insert into cob_pfijo..pf_auxiliar_tip values (3, 0, 'PPE', '3M',  'A', getdate(), getdate(), null)
insert into cob_pfijo..pf_auxiliar_tip values (3, 0, 'PPE', '6M',  'A', getdate(), getdate(), null)

insert into cob_pfijo..pf_auxiliar_tip values (4, 0, 'PPE', '12M', 'A', getdate(), getdate(), null)
insert into cob_pfijo..pf_auxiliar_tip values (4, 0, 'PPE', '1M',  'A', getdate(), getdate(), null)
insert into cob_pfijo..pf_auxiliar_tip values (4, 0, 'PPE', '2M',  'A', getdate(), getdate(), null)
insert into cob_pfijo..pf_auxiliar_tip values (4, 0, 'PPE', '3M',  'A', getdate(), getdate(), null)
insert into cob_pfijo..pf_auxiliar_tip values (4, 0, 'PPE', '6M',  'A', getdate(), getdate(), null)

go

print '-->Parametrizacion Temporal: Limite'
if exists (select 1 from cob_pfijo..pf_limite) begin
    delete from cob_pfijo..pf_limite
end
go


if exists(select 1 from cob_pfijo..pf_funcionario)
begin
    delete from cob_pfijo..pf_funcionario
end

insert into cob_pfijo..pf_funcionario(fu_secuencial, fu_funcionario, fu_tautorizacion, fu_estado, fu_fecha_crea, fu_fecha_elim, fu_func_relacionado)
                               values(1,             'sa',           'APRO',           'A',       getdate(),     null,          'admuser')

insert into cob_pfijo..pf_funcionario(fu_secuencial, fu_funcionario, fu_tautorizacion, fu_estado, fu_fecha_crea, fu_fecha_elim, fu_func_relacionado)
                               values(2,             'admuser',      'APRO',           'A',       getdate(),     null,          'sa')
go

update  cobis..cl_seqnos set siguiente = isnull((select max(ce_secuencial) from cob_pfijo..pf_cliente_externo),0) where tabla = 'pf_cliente_externo ' and bdatos = 'cob_pfijo'
go
update  cobis..cl_seqnos set siguiente = isnull((select max(fp_tipo_fpago) from cob_pfijo..pf_fpago),0) where tabla = 'pf_fpago ' and bdatos = 'cob_pfijo'
go
update  cobis..cl_seqnos set siguiente = isnull((select max(fu_secuencial) from cob_pfijo..pf_funcionario),0) where tabla = 'pf_funcionario ' and bdatos = 'cob_pfijo'
go
update  cobis..cl_seqnos set siguiente = isnull((select max(ht_secuencial) from cob_pfijo..pf_hist_tasa),0) where tabla = 'pf_hist_tasa ' and bdatos = 'cob_pfijo'
go
update  cobis..cl_seqnos set siguiente = isnull((select max(hv_secuencial) from cob_pfijo..pf_hist_tasa_variable),0) where tabla = 'pf_hist_tasa_variable ' and bdatos = 'cob_pfijo'
go
update  cobis..cl_seqnos set siguiente = isnull((select max(io_secuencial) from cob_pfijo..pf_incre_op),0) where tabla = 'pf_incre_op ' and bdatos = 'cob_pfijo'
go
update  cobis..cl_seqnos set siguiente = isnull((select max(li_secuencial) from cob_pfijo..pf_limite),0) where tabla = 'pf_limite ' and bdatos = 'cob_pfijo'
go
update  cobis..cl_seqnos set siguiente = isnull((select max(mo_tipo_monto) from cob_pfijo..pf_monto),0) where tabla = 'pf_monto ' and bdatos = 'cob_pfijo'
go
update  cobis..cl_seqnos set siguiente = isnull((select max(np_preimpreso) from cob_pfijo..pf_npreimpreso),0) where tabla = 'pf_npreimpreso ' and bdatos = 'cob_pfijo'
go
update  cobis..cl_seqnos set siguiente = isnull((select max(op_operacion) from cob_pfijo..pf_operacion),0) where tabla = 'pf_operacion ' and bdatos = 'cob_pfijo'
go
update  cobis..cl_seqnos set siguiente = isnull((select max(pl_tipo_plazo) from cob_pfijo..pf_plazo),0) where tabla = 'pf_plazo ' and bdatos = 'cob_pfijo'
go
update  cobis..cl_seqnos set siguiente = isnull((select max(sc_comprobante) from cob_pfijo..pf_scomprobante),0) where tabla = 'pf_scomprobante ' and bdatos = 'cob_pfijo'
go
update  cobis..cl_seqnos set siguiente = isnull((select max(td_tipo_deposito) from cob_pfijo..pf_tipo_deposito),0) where tabla = 'pf_tipo_deposito ' and bdatos = 'cob_pfijo'
go

print ''
print 'Fin Ejecucion Insercion Parametrizacion Temporal : ' + convert(varchar(60),getdate(),109)
print ''
go

