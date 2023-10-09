set nocount on

use cobis
go

print '===> ca_segur.sql'
go

if exists (select 1 from ad_pro_instalado where pi_producto = 'CCA')
    delete ad_pro_instalado where pi_producto = 'CCA'
go

insert into ad_pro_instalado (pi_producto, pi_bdd, pi_nomfirmas, pi_uso_firmas, pi_qrfirmas, pi_trn_nom, pi_trn_qry)
        values    ('CCA', 'cob_cartera', NULL, NULL, NULL, NULL, NULL)
go


print' ***  ad_rol .....(Creacion de rol del MENU POR PROCESOS) '

declare @w_rol     smallint,
        @w_moneda  tinyint

if not exists (select 1 from ad_rol
                where ro_descripcion = 'MENU POR PROCESOS'
                  and ro_filial = 1)
begin
   select @w_rol = max(ro_rol)  + 1
     from ad_rol
    where ro_filial = 1

   update cl_seqnos
      set siguiente = @w_rol
    where tabla = 'ad_rol'

   insert into ad_rol(
   ro_rol,        ro_filial,  ro_descripcion,
   ro_fecha_crea, ro_creador, ro_estado,
   ro_fecha_ult_mod)
   values(
   @w_rol,        1,          'MENU POR PROCESOS',
   getdate(),     1,          'V',
   getdate())
end
else begin
   print 'Ya existe el rol MENU POR PROCESOS'
end



print ' ***  ad_pro_rol .....(Asignacion de productos a MENU POR PROCESOS) '

select @w_rol = ro_rol
  from ad_rol
 where ro_descripcion = 'MENU POR PROCESOS'
   and ro_filial = 1
   
select @w_moneda = pa_tinyint
  from cobis..cl_parametro
 where pa_nemonico = 'CMNAC'
   and pa_producto = 'ADM'

delete ad_pro_rol
 where pr_rol = @w_rol
   and pr_producto in (19,1,8,7)
   and pr_moneda = @w_moneda

insert into ad_pro_rol  (pr_rol, pr_producto, pr_tipo, pr_moneda,
                         pr_fecha_crea, pr_autorizante, pr_estado,
                         pr_fecha_ult_mod, pr_menu_inicial)
                values  (@w_rol, 19,'R', @w_moneda, getdate(), 1,'V', getdate(),  null)

insert into ad_pro_rol  (pr_rol, pr_producto, pr_tipo, pr_moneda,
                         pr_fecha_crea, pr_autorizante, pr_estado,
                         pr_fecha_ult_mod, pr_menu_inicial)
                values  (@w_rol, 1,'R', @w_moneda, getdate(),  1,'V', getdate(),  null)

insert into ad_pro_rol  (pr_rol, pr_producto, pr_tipo, pr_moneda,
                         pr_fecha_crea, pr_autorizante, pr_estado,
                         pr_fecha_ult_mod, pr_menu_inicial)
                values  (@w_rol, 8,'R', @w_moneda, getdate(),  1,'V', getdate(),  null)

insert into ad_pro_rol  (pr_rol, pr_producto, pr_tipo, pr_moneda,
                         pr_fecha_crea, pr_autorizante, pr_estado,
                         pr_fecha_ult_mod, pr_menu_inicial)
                values  (@w_rol, 7,'R', @w_moneda, getdate(),  1,'V', getdate(),  null)
                

PRINT '<<< INICIALIZACION DEL PROCESO DE INSERCION EN LA ad_procedure >>>'

delete cobis..ad_procedure
 where pd_procedure in (7001,7002,7003,7004,7005,7006,7007,7008,7009,7010,7011,7012,7013,7014,7015,7016,7017,7018,7019,7020,7021,
                        7022,7023,7024,7025,7026,7027,7028,7029,7030,7031,7032,7033,7034,7035,7036,7037,7038,7039,7040,7041,7042,
                        7044,7045,7046,7047,7048,7049,7050,7051,7052,7053,7054,7055,7056,7057,7058,7059,7060,7061,7062,7063,7064,
                        7065,7066,7067,7068,7069,7070,7071,7072,7073,7074,7075,7076,7077,7078,7079,7080,7081,7082,7083,7084,7086,
                        7087,7088,7089,7090,7098,7099,7100,7101,7102,7103,7106,7300,7306,77501,7990, 7991, 74663 ,73904,77502,77503,77511)
   and pd_base_datos = 'cob_cartera'
go

insert into cobis..ad_procedure values (7001,        'sp_actualiza_estado',            'cob_cartera',                    'V', '06/27/2008', 'ac_estad.sp')    
insert into cobis..ad_procedure values (7002,        'sp_borrar_tmp',                  'cob_cartera',                    'V', '06/27/2008', 'borratmp.sp')    
insert into cobis..ad_procedure values (7003,        'sp_cuenta_cobis',                'cob_cartera',                    'V', '06/27/2008', 'ccobis.sp')      
insert into cobis..ad_procedure values (7004,        'sp_codeudor_tmp',                'cob_cartera',                    'V', '06/27/2008', 'codeutmp.sp')    
insert into cobis..ad_procedure values (7005,        'sp_concepto',                    'cob_cartera',                    'V', '06/27/2008', 'concepto.sp')    
insert into cobis..ad_procedure values (7006,        'sp_consulta_rubro',              'cob_cartera',                    'V', '06/27/2008', 'conrubro.sp')    
insert into cobis..ad_procedure values (7007,        'sp_consultar_transacciones',     'cob_cartera',                    'V', '06/27/2008', 'constran.sp')    
insert into cobis..ad_procedure values (7008,        'sp_crear_operacion',             'cob_cartera',                    'V', '06/27/2008', 'crearop.sp')     
insert into cobis..ad_procedure values (7009,        'sp_crear_tmp',                   'cob_cartera',                    'V', '06/27/2008', 'creartmp.sp')    
insert into cobis..ad_procedure values (7010,        'sp_cuotas_adicionales',          'cob_cartera',                    'V', '06/27/2008', 'cuotadic.sp')    
insert into cobis..ad_procedure values (7011,        'sp_datos_operacion',             'cob_cartera',                    'V', '06/27/2008', 'datosop.sp')     
insert into cobis..ad_procedure values (7012,        'sp_decodificador',               'cob_cartera',                    'V', '06/27/2008', 'decoder.sp')     
insert into cobis..ad_procedure values (7013,        'sp_default_toperacion',          'cob_cartera',                    'V', '06/27/2008', 'defa_top.sp')    
insert into cobis..ad_procedure values (7014,        'sp_cargar_pagos_masivos',        'cob_cartera',                    'V', '06/27/2008', 'cargamas.sp')    
insert into cobis..ad_procedure values (7015,        'sp_desembolso',                  'cob_cartera',                    'V', '06/27/2008', 'desembol.sp')    
insert into cobis..ad_procedure values (7016,        'sp_detalle_reajuste',            'cob_cartera',                    'V', '06/27/2008', 'detareaj.sp')    
insert into cobis..ad_procedure values (7017,        'sp_eliminar_pagos',              'cob_cartera',                    'V', '06/27/2008', 'elimpag.sp')     
insert into cobis..ad_procedure values (7018,        'sp_estados_man',                 'cob_cartera',                    'V', '06/27/2008', 'est_manu.sp')    
insert into cobis..ad_procedure values (7019,        'sp_estados_rubro',               'cob_cartera',                    'V', '06/27/2008', 'estrubro.sp')    
insert into cobis..ad_procedure values (7020,        'sp_fecha_valor',                 'cob_cartera',                    'V', '06/27/2008', 'fechaval.sp')    
insert into cobis..ad_procedure values (7021,        'sp_variables_generales',         'cob_cartera',                    'V', '06/27/2008', 'general.sp')     
insert into cobis..ad_procedure values (7022,        'sp_imprimir_oficina',            'cob_cartera',                    'V', '06/27/2008', 'imp_ofic.sp')    
insert into cobis..ad_procedure values (7023,        'sp_imprimir_datos_op',           'cob_cartera',                    'V', '06/27/2008', 'imp_ofic.sp')    
insert into cobis..ad_procedure values (7024,        'sp_imprimir_liquidacion',        'cob_cartera',                    'V', '06/27/2008', 'impliqui.sp')    
insert into cobis..ad_procedure values (7025,        'sp_imprimir_orden',              'cob_cartera',                    'V', '06/27/2008', 'imporden.sp')    
insert into cobis..ad_procedure values (7026,        'sp_imp_recibo_pago',             'cob_cartera',                    'V', '06/27/2008', 'imprpago.sp')    
insert into cobis..ad_procedure values (7027,        'sp_imp_tabla_amort',             'cob_cartera',                    'V', '06/27/2008', 'imptabla.sp')    
insert into cobis..ad_procedure values (7028,        'sp_imp_transaccion',             'cob_cartera',                    'V', '06/27/2008', 'imptrans.sp')    
insert into cobis..ad_procedure values (7029,        'sp_ing_abono',                   'cob_cartera',                    'V', '06/27/2008', 'ingabono.sp')    
insert into cobis..ad_procedure values (7030,        'sp_ing_detabono',                'cob_cartera',                    'V', '06/27/2008', 'ingdetab.sp')    
insert into cobis..ad_procedure values (7031,        'sp_liquida',                     'cob_cartera',                    'V', '06/27/2008', 'liquida.sp')     
insert into cobis..ad_procedure values (7032,        'sp_modificar_operacion',         'cob_cartera',                    'V', '06/27/2008', 'modifop.sp')     
insert into cobis..ad_procedure values (7033,        'sp_oficiales',                   'cob_cartera',                    'V', '06/27/2008', 'oficial.sp')     
insert into cobis..ad_procedure values (7034,        'sp_operacion_def',               'cob_cartera',                    'V', '06/27/2008', 'operdef.sp')     
insert into cobis..ad_procedure values (7035,        'sp_otros_cargos',                'cob_cartera',                    'V', '06/27/2008', 'otcargos.sp')    
insert into cobis..ad_procedure values (7036,        'sp_parametro',                   'cob_cartera',                    'V', '06/27/2008', 'paramet.sp')     
insert into cobis..ad_procedure values (7037,        'sp_qamortmp',                    'cob_cartera',                    'V', '06/27/2008', 'qamortmp.sp')    
insert into cobis..ad_procedure values (7038,        'sp_qr_codeudor',                 'cob_cartera',                    'V', '06/27/2008', 'qrcodeu.sp')     
insert into cobis..ad_procedure values (7039,        'sp_consulta_estado',             'cob_cartera',                    'V', '06/27/2008', 'qrestado.sp')    
insert into cobis..ad_procedure values (7040,        'sp_qr_producto',                 'cob_cartera',                    'V', '06/27/2008', 'qrproduc.sp')    
insert into cobis..ad_procedure values (7041,        'sp_reajuste_operacion',          'cob_cartera',                    'V', '06/27/2008', 'reajusop.sp')    
insert into cobis..ad_procedure values (7042,        'sp_redescuento',                 'cob_cartera',                    'V', '06/27/2008', 'redescue.sp')    
insert into cobis..ad_procedure values (7044,        'sp_retencion',                   'cob_cartera',                    'V', '06/27/2008', 'retencio.sp')    
insert into cobis..ad_procedure values (7045,        'sp_rubro_dml',                   'cob_cartera',                    'V', '06/27/2008', 'rubrodml.sp')    
insert into cobis..ad_procedure values (7046,        'sp_rubro_qry',                   'cob_cartera',                    'V', '06/27/2008', 'rubroqry.sp')    
insert into cobis..ad_procedure values (7047,        'sp_rubro_tmp',                   'cob_cartera',                    'V', '06/27/2008', 'rubrotmp.sp')    
insert into cobis..ad_procedure values (7048,        'sp_tabla_rango',                 'cob_cartera',                    'V', '06/27/2008', 'tabrango.sp')    
insert into cobis..ad_procedure values (7049,        'sp_tabla_rubro',                 'cob_cartera',                    'V', '06/27/2008', 'tabrubro.sp')    
insert into cobis..ad_procedure values (7050,        'sp_tdividendo',                  'cob_cartera',                    'V', '06/27/2008', 'tdividen.sp')    
insert into cobis..ad_procedure values (7051,        'sp_tiptran',                     'cob_cartera',                    'V', '06/27/2008', 'tiptran.sp')     
insert into cobis..ad_procedure values (7052,        'sp_tplazo',                      'cob_cartera',                    'V', '06/27/2008', 'tplazo.sp')      
insert into cobis..ad_procedure values (7053,        'sp_trn_oper',                    'cob_cartera',                    'V', '06/27/2008', 'trnoper.sp')     
insert into cobis..ad_procedure values (7054,        'sp_valor_referencial',           'cob_cartera',                    'V', '06/27/2008', 'val_refe.sp')    
insert into cobis..ad_procedure values (7055,        'sp_valor',                       'cob_cartera',                    'V', '06/27/2008', 'valor.sp')       
insert into cobis..ad_procedure values (7056,        'sp_vencimiento_reajuste',        'cob_cartera',                    'V', '06/27/2008', 'vencreaj.sp')    
insert into cobis..ad_procedure values (7057,        'sp_buscar_operaciones',          'cob_cartera',                    'V', '06/27/2008', 'busopera.sp')    
insert into cobis..ad_procedure values (7058,        'sp_estados',                     'cob_cartera',                    'V', '06/27/2008', 'estados.sp')     
insert into cobis..ad_procedure values (7059,        'sp_qr_usuario',                  'cob_cartera',                    'V', '06/27/2008', 'qrusuari.sp')    
insert into cobis..ad_procedure values (7060,        'sp_cambio_estado_op_ext',        'cob_cartera',                    'V', '06/27/2008', 'camopex.sp')     
insert into cobis..ad_procedure values (7061,        'sp_calcula_dividendo',           'cob_cartera',                    'V', '06/27/2008', 'cal_div.sp')     
insert into cobis..ad_procedure values (7062,        'sp_instroper',                   'cob_cartera',                    'V', '06/27/2008', 'instrucc.sp')    
insert into cobis..ad_procedure values (7063,        'sp_qry_abono',                   'cob_cartera',                    'V', '06/27/2008', 'qryabono.sp')    
insert into cobis..ad_procedure values (7064,        'sp_consulta_trn',                'cob_cartera',                    'V', '06/27/2008', 'qrtran.sp')      
insert into cobis..ad_procedure values (7065,        'sp_qr_operacion_tmp',            'cob_cartera',                    'V', '06/27/2008', 'qroptmp.sp')     
insert into cobis..ad_procedure values (7066,        'sp_qr_pagos',                    'cob_cartera',                    'V', '06/27/2008', 'qrpagos.sp')     
insert into cobis..ad_procedure values (7067,        'sp_qr_operacion',                'cob_cartera',                    'V', '06/27/2008', 'qroper.sp')      
insert into cobis..ad_procedure values (7068,        'sp_qr_distribucion',             'cob_cartera',                    'V', '06/27/2008', 'qrdistri.sp')    
insert into cobis..ad_procedure values (7069,        'sp_trn_aut',                     'cob_cartera',                    'V', '06/27/2008', 'tranaut.sp')     
insert into cobis..ad_procedure values (7070,        'sp_detalle_amortizacion',        'cob_cartera',                    'V', '06/27/2008', 'detamor.sp')     
insert into cobis..ad_procedure values (7071,        'sp_dias_gracia',                 'cob_cartera',                    'V', '06/27/2008', 'diasgrac.sp')    
insert into cobis..ad_procedure values (7072,        'sp_datos_efectiva',              'cob_cartera',                    'V', '06/27/2008', 'defectiv.sp')    
insert into cobis..ad_procedure values (7073,        'sp_pagos_noaplicados',           'cob_cartera',                    'V', '06/27/2008', 'pagnoapl.sp')    
insert into cobis..ad_procedure values (7074,        'sp_proyeccion_cuota',            'cob_cartera',                    'V', '06/27/2008', 'proycuot.sp')    
insert into cobis..ad_procedure values (7075,        'sp_consulta_atx',                'cob_cartera',                    'V', '06/27/2008', 'consatx.sp')     
insert into cobis..ad_procedure values (7076,        'sp_valor_atx',                   'cob_cartera',                    'V', '06/27/2008', 'valoratx.sp')    
insert into cobis..ad_procedure values (7077,        'sp_abono_atx',                   'cob_cartera',                    'V', '06/27/2008', 'abonoatx.sp')    
insert into cobis..ad_procedure values (7078,        'sp_traslada_cartera',            'cob_cartera',                    'V', '06/27/2008', 'trascart.sp')    
insert into cobis..ad_procedure values (7079,        'sp_dias_aceleratoria',           'cob_cartera',                    'V', '06/27/2008', 'diasacel.sp')    
insert into cobis..ad_procedure values (7080,        'sp_conversion_tasas',            'cob_cartera',                    'V', '06/27/2008', 'convtasa.sp')    
insert into cobis..ad_procedure values (7081,        'sp_tasa_valor',                  'cob_cartera',                    'V', '06/27/2008', 'tasaval.sp')     
insert into cobis..ad_procedure values (7082,        'sp_crea_pasiva',                 'cob_cartera',                    'V', '06/27/2008', 'creapas.sp')     
insert into cobis..ad_procedure values (7083,        'sp_renovacion',                  'cob_cartera',                    'V', '06/27/2008', 'renovac.sp')     
insert into cobis..ad_procedure values (7084,        'sp_qr_renovacion',               'cob_cartera',                    'V', '06/27/2008', 'qrrenova.sp')    
insert into cobis..ad_procedure values (7086,        'sp_clausula_aceleratoria',       'cob_cartera',                    'V', '06/27/2008', 'clauacel.sp')    
insert into cobis..ad_procedure values (7087,        'sp_distribucion_nomina',         'cob_cartera',                    'V', '06/27/2008', 'distnomi.sp')    
insert into cobis..ad_procedure values (7088,        'sp_parametros_capitalizacion',   'cob_cartera',                    'V', '06/27/2008', 'capitali.sp')    
insert into cobis..ad_procedure values (7089,        'sp_buscar_op_reajuste',          'cob_cartera',                    'V', '06/27/2008', 'busreaj.sp')     
insert into cobis..ad_procedure values (7098,        'sp_tipo_plazo',                  'cob_cartera',                    'V', '06/27/2008', 'tabplazo.sp')    
insert into cobis..ad_procedure values (7090,        'sp_pagare_finagro',              'cob_cartera',                    'V', '06/27/2008', 'ca_pag_fag.sp')    
insert into cobis..ad_procedure values (7099,        'sp_crear_op_automatica',         'cob_cartera',                    'V', '06/27/2008', 'creaopau.sp')    
insert into cobis..ad_procedure values (7100,        'sp_consulta_act_pas',            'cob_cartera',                    'V', '06/27/2008', 'consacpa.sp')    
insert into cobis..ad_procedure values (7101,        'sp_imp_tabla_amort_var',         'cob_cartera',                    'V', '06/27/2008', 'imptabac.sp')    
insert into cobis..ad_procedure values (7102,        'sp_abonos_masivos_generales',    'cob_cartera',                    'V', '06/27/2008', 'abmagene.sp')    
insert into cobis..ad_procedure values (7103,        'sp_abonos_masivos_cabecera',     'cob_cartera',                    'V', '06/27/2008', 'abmacabe.sp')    
insert into cobis..ad_procedure values (7106,        'sp_imprimir_timbre',             'cob_cartera',                    'V', '06/27/2008', 'imptimbr.sp')    
insert into cobis..ad_procedure values (77501,       'sp_crea_renovacion',             'cob_cartera',                    'V', '05/09/2017', 'crearen.sp')
insert into cobis..ad_procedure values (7990,        'sp_orden_desembolso_gru',        'cob_cartera',                    'V', getdate()   , 'ordesem_gru.sp')
insert into cobis..ad_procedure values (7991,        'sp_pago_grupal',                 'cob_cartera',                    'V', getdate()   , 'pago_grup.sp')
insert into cobis..ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (74663, 'sp_simulacion_prestamo', 'cob_cartera', 'V', getdate(), 's_prestamo.sp')
insert into cobis..ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo)
values (73904,'sp_actualiza_grupal','cob_cartera','V',getdate(),'actgrp.sp')
insert into cobis..ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo)
values(77502,'sp_santander_orden_dep_fallido','cob_cartera','V',getdate(),'SantanderOrdenDepFallido.sp')
insert into cobis..ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo)
values(77503,'sp_santander_orden_dep_fallido','cob_cartera','V',getdate(),'SantanderOrdenDepFallido.sp')
INSERT INTO cobis..ad_procedure(pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo) 
VALUES(77511, 'sp_lcr_resp_desembolso', 'cob_cartera', 'V', getdate(), 'lcr_rdes.sp')



GO

insert into cobis..ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo) 
						values (7300, 'sp_catalog_valor_det', 'cob_cartera', 'V', getdate(), 'catalvaldet.sp') 
insert into cobis..ad_procedure values (7306,        'sp_rule_condonacion',             'cob_cartera',                    'V', getdate(),  substring('rule_condonacion.sp',1,14))
go

delete cobis..ad_procedure
 where pd_procedure in (7107,7108,7109)
   and pd_base_datos = 'cobis'
go

insert into cobis..ad_procedure values (7107,        'sp_pcca_focl',                   'cobis',                          'V', '07/10/2008', 'pcfocl.sp')      
insert into cobis..ad_procedure values (7108,        'sp_pcca_val',                    'cobis',                          'V', '07/10/2008', 'pcval.sp')       
insert into cobis..ad_procedure values (7109,        'sp_pcca_emp',                    'cobis',                          'V', '07/10/2008', 'pcemp.sp')       
go

delete cobis..ad_procedure
 where pd_procedure in (7110,7111,7112,7113,7114,7116,7117,7118,7119,7120,7121,7122,7123,7124,7130,7131,7141,7148,7156,7178,7186,
                        7187,7189,7190,7191,7192,7193,7194,7195,7196,7214,7218,7237,7238,7239,7240,7241,7242,7243,7244,7245,7250,7251,
                        7252,7253,7259,7260,7266,7267,7268,7269,7270,7271,7280,7202,7203,7204,7205,7206,7207,7281,7282,7283,7284,7285,
						7286)
   and pd_base_datos = 'cob_cartera'
go

insert into cobis..ad_procedure values (7110,        'sp_saldo_cca',                   'cob_cartera',                    'V', '06/27/2008', 'saldocar.sp')    
insert into cobis..ad_procedure values (7111,        'sp_cargar_facturas',             'cob_cartera',                    'V', '06/27/2008', 'qamorfac.sp')    
insert into cobis..ad_procedure values (7112,        'sp_qr_pagos_factoring',          'cob_cartera',                    'V', '06/27/2008', 'qrpagosf.sp')    
insert into cobis..ad_procedure values (7113,        'sp_acciones',                    'cob_cartera',                    'V', '06/27/2008', 'acciones.sp')    
insert into cobis..ad_procedure values (7114,        'sp_decodificador_dias_manual',   'cob_cartera',                    'V', '06/27/2008', 'decdias.sp')     
insert into cobis..ad_procedure values (7116,        'sp_impcta',                      'cob_cartera',                    'V', '06/27/2008', 'impcta.sp')      
insert into cobis..ad_procedure values (7117,        'sp_categoria_pago',              'cob_cartera',                    'V', '06/27/2008', 'catpago.sp')     
insert into cobis..ad_procedure values (7118,        'sp_subtipo_linea',               'cob_cartera',                    'V', '06/27/2008', 'casubtil.sp')    
insert into cobis..ad_procedure values (7119,        'sp_categoria_rubro',             'cob_cartera',                    'V', '06/27/2008', 'catrubro.sp')    
insert into cobis..ad_procedure values (7120,        'sp_consulta_ref',                'cob_cartera',                    'V', '06/27/2008', 'consuref.sp')    
insert into cobis..ad_procedure values (7121,        'sp_consulta_oficial',            'cob_cartera',                    'V', '06/27/2008', 'consofi.sp')     
insert into cobis..ad_procedure values (7122,        'sp_consultar_envios_ach',        'cob_cartera',                    'V', '06/27/2008', 'consuach.sp')    
insert into cobis..ad_procedure values (7123,        'sp_maestro_ach_ext',             'cob_cartera',                    'V', '06/27/2008', 'maestext.sp')    
insert into cobis..ad_procedure values (7124,        'sp_buscar_empleados',            'cob_cartera',                    'V', '06/27/2008', 'buscempl.sp')    
insert into cobis..ad_procedure values (7130,        'sp_fecha_bcartera',              'cob_cartera',                    'V', '06/27/2008', 'fechacca.sp')    
insert into cobis..ad_procedure values (7131,        'sp_prorroga_cuota',              'cob_cartera',                    'V', '06/27/2008', 'prorroga.sp')    
insert into cobis..ad_procedure values (7141,        'sp_consulta_abonos_rubros',      'cob_cartera',                    'V', '06/27/2008', 'conaborub.s')    
insert into cobis..ad_procedure values (7148,        'sp_encab_consulta',              'cob_cartera',                    'V', '06/27/2008', 'encabcon.sp')    
insert into cobis..ad_procedure values (7156,        'sp_consulta_atx',                'cob_cartera',                    'V', '03/03/2009', 'consatx.sp')     
insert into cobis..ad_procedure values (7178,        'sp_consulta_abonos_cuota',       'cob_cartera',                    'V', '06/27/2008', 'conabocuo.sp')   
insert into cobis..ad_procedure values (7186,        'sp_consulta_pend_desem',         'cob_cartera',                    'V', '06/27/2008', 'conpendes.sp')   
insert into cobis..ad_procedure values (7187,        'sp_datos_procredito',            'cob_cartera',                    'V', '06/27/2008', 'cadatpcr.sp')    
insert into cobis..ad_procedure values (7189,        'sp_num_pagare',                  'cob_cartera',                    'V', '06/27/2008', 'num_pagare.sp')
insert into cobis..ad_procedure values (7190,        'sp_consulta_entidad_convenio',   'cob_cartera',                    'V', '06/27/2008', 'conentco.sp')    
insert into cobis..ad_procedure values (7191,        'sp_consulta_fac_masivos',        'cob_cartera',                    'V', '06/27/2008', 'confacma.sp')    
insert into cobis..ad_procedure values (7192,        'sp_recibir_recaudos',            'cob_cartera',                    'V', '06/27/2008', 'receprec.sp')    
insert into cobis..ad_procedure values (7193,        'sp_bus_linea',                   'cob_cartera',                    'V', '07/24/2008', 'ca_buslinea.sp') 
insert into cobis..ad_procedure values (7194,        'sp_porc_condonacion',            'cob_cartera',                    'V', '05/21/2009', 'porcondo.sp')
insert into cobis..ad_procedure values (7195,        'sp_porc_cond',                   'cob_cartera',                    'V', '05/27/2009', 'porcondusu.sp')
insert into cobis..ad_procedure values (7196,        'sp_porc_cond',                   'cob_cartera',                    'V', '05/27/2009', 'porcondusu.sp')
insert into cobis..ad_procedure values (7202,        'sp_matriz_doc',                  'cob_cartera',                    'V', getdate(),    'matriz_doc.sp')
insert into cobis..ad_procedure values (7203,        'sp_seguros',                     'cob_cartera',                    'V', '06/27/2008', 'sp_seguros.sp') 
insert into cobis..ad_procedure values (7204,        'sp_qr_table_amortiza_web',       'cob_cartera',                    'V', '06/27/2008', 'amortizaweb.sp') 
insert into cobis..ad_procedure values (7205,        'sp_actualizar_tflexible',        'cob_cartera',                    'V', '06/27/2008', 'act_tflex.sp') 
insert into cobis..ad_procedure values (7206,        'sp_datocab_operacion',            'cob_cartera',                   'V', getdate(),    'datcabop.sp')
insert into cobis..ad_procedure values (7207,        'sp_qr_renova_opera',              'cob_cartera',                   'V', getdate(),    'qrrenope.sp')
insert into cobis..ad_procedure values (7214,        'sp_confirma_pago_atx',           'cob_cartera',                    'V', '06/27/2008', 'confpagoatx.sp') 
insert into cobis..ad_procedure values (7218,        'sp_normalizacion',               'cob_cartera',                    'V', '06/27/2008', 'normalizaci.sp') 
insert into cobis..ad_procedure values (7237,        'sp_restaurar',                   'cob_cartera',                    'V', '06/27/2008', 'hmrestar.sp')    
insert into cobis..ad_procedure values (7238,        'sp_respaldar',                   'cob_cartera',                    'V', '06/27/2008', 'hmrespal.sp')    
insert into cobis..ad_procedure values (7239,        'sp_ejecutar_batch',              'cob_cartera',                    'V', '06/27/2008', 'hmejecu.sp')     
insert into cobis..ad_procedure values (7240,        'sp_crea_operacion_rapida',       'cob_cartera',                    'V', '06/27/2008', 'hmcreara.sp')    
insert into cobis..ad_procedure values (7241,        'sp_consulta_tablas',             'cob_cartera',                    'V', '06/27/2008', 'hmctabla.sp')    
insert into cobis..ad_procedure values (7242,        'sp_cargar_lote',                 'cob_cartera',                    'V', '06/27/2008', 'cargalot.sp')    
insert into cobis..ad_procedure values (7243,        'sp_negociar_operacion_pm',       'cob_cartera',                    'V', '06/27/2008', 'negopma.sp')     
insert into cobis..ad_procedure values (7244,        'sp_imprimir_abonos_masivos',     'cob_cartera',                    'V', '06/27/2008', 'impaboma.sp')    
insert into cobis..ad_procedure values (7245,        'sp_rubro_conversion',            'cob_cartera',                    'V', '06/27/2008', 'rccacre.sp')     
insert into cobis..ad_procedure values (7250,        'sp_qr_pasivas',                  'cob_cartera',                    'V', '06/27/2008', 'qrpasiva.sp')    
insert into cobis..ad_procedure values (7251,        'sp_actualiza_llave_redes',       'cob_cartera',                    'V', '06/27/2008', 'actllared.sp')   
insert into cobis..ad_procedure values (7252,        'sp_datos_maestro',               'cob_cartera',                    'V', '06/27/2008', 'datosmae.sp')    
insert into cobis..ad_procedure values (7253,        'sp_codigos_prepago',             'cob_cartera',                    'V', '06/27/2008', 'cacodpre.sp')    
insert into cobis..ad_procedure values (7259,        'sp_prepagos_pasivas',            'cob_cartera',                    'V', '06/27/2008', 'prepapas.sp')    
insert into cobis..ad_procedure values (7260,        'sp_otras_tasas_rubros',          'cob_cartera',                    'V', '06/27/2008', 'otrtasas.sp')    
insert into cobis..ad_procedure values (7266,        'sp_mante_prepagos_pasivas',      'cob_cartera',                    'V', '06/27/2008', 'camanpas.sp')    
insert into cobis..ad_procedure values (7267,        'sp_envio_datos_ext',             'cob_cartera',                    'V', '06/27/2008', 'cargaext.sp')    
insert into cobis..ad_procedure values (7268,        'sp_imp_extracto_linea_ext',      'cob_cartera',                    'V', '06/27/2008', 'extlinea.sp')    
insert into cobis..ad_procedure values (7269,        'sp_tamor_fend',                  'cob_cartera',                    'V', '06/27/2008', 'tamrfend.sp')    
insert into cobis..ad_procedure values (7270,        'sp_rubro_planificador',          'cob_cartera',                    'V', '02/25/2009', 'paramplanif.sp') 
insert into cobis..ad_procedure values (7271,        'sp_camb_nota',                   'cob_cartera',                    'V', '02/26/2009', 'cacambnota.sp')  
insert into cobis..ad_procedure values (7280,        'sp_imp_interes_pagado',          'cob_cartera',                    'V',  getdate(),   'impintpag.sp') 
insert into cobis..ad_procedure values (7281,        'sp_pago_grupal',                 'cob_cartera',                    'V',  getdate(),   'pago_grup.sp') 
insert into cobis..ad_procedure values (7282,        'sp_fuen_recur',                  'cob_cartera',                    'V',  getdate(),   'ca_funrecur.sp')
insert into cobis..ad_procedure values (7283,        'sp_cons_tramite',                'cob_cartera',                    'V',  getdate(),   'coninstr.sp')
insert into cobis..ad_procedure values (7284,        'sp_envio_correo_garliquida',     'cob_cartera',                    'V',  getdate(),   'sp_envio_co.sp')
insert into cobis..ad_procedure values (7285,        'sp_genera_xml_gar_liquida',      'cob_cartera',                    'V',  getdate(),   'sp_gene_xml.sp')
insert into cobis..ad_procedure values (7286,        'sp_santander_gen_orden_dep',     'cob_cartera',                    'V',  getdate(),   'GenOrdenDep.sp')
go

delete cobis..ad_procedure
 where pd_procedure in (7400,7401,7402,7403,7404,7405,7406,7407,7408,7409,7410,7411,7412,7413,7414,7415,7416,7417,7418,7419,7420,
                        7421,7422,7423,7424,7425,7426,7427,7428,7429,7430,7431,7432)
   and pd_base_datos = 'cobis'
go

insert into cobis..ad_procedure values (7400,        'sp_contabilidad_cte',            'cobis',                          'V', '07/10/2008', 'contacte.sp')    
insert into cobis..ad_procedure values (7401,        'sp_contabilidad_cat',            'cobis',                          'V', '07/10/2008', 'contacat.sp')    
insert into cobis..ad_procedure values (7402,        'sp_contabilidad_mon',            'cobis',                          'V', '07/10/2008', 'contamon.sp')    
insert into cobis..ad_procedure values (7403,        'sp_contabilidad_eor',            'cobis',                          'V', '06/27/2008', 'contaeor.sp')    
insert into cobis..ad_procedure values (7404,        'sp_contabilidad_tli',            'cobis',                          'V', '07/10/2008', 'contatli.sp')    
insert into cobis..ad_procedure values (7405,        'sp_contabilidad_cor',            'cobis',                          'V', '07/10/2008', 'contacor.sp')    
insert into cobis..ad_procedure values (7406,        'sp_contabilidad_lcc',            'cobis',                          'V', '07/10/2008', 'contalcc.sp')    
insert into cobis..ad_procedure values (7407,        'sp_contabilidad_pce',            'cobis',                          'V', '07/10/2008', 'contapce.sp')    
insert into cobis..ad_procedure values (7408,        'sp_contabilidad_clc',            'cobis',                          'V', '07/10/2008', 'contaclc.sp')    
insert into cobis..ad_procedure values (7409,        'sp_contabilidad_tge',            'cobis',                          'V', '07/10/2008', 'contatge.sp')    
insert into cobis..ad_procedure values (7410,        'sp_contabilidad_mge',            'cobis',                          'V', '07/10/2008', 'contamge.sp')    
insert into cobis..ad_procedure values (7411,        'sp_contabilidad_est',            'cobis',                          'V', '07/10/2008', 'contaest.sp')    
insert into cobis..ad_procedure values (7412,        'sp_contabilidad_rgc',            'cobis',                          'V', '07/10/2008', 'contargc.sp')    
insert into cobis..ad_procedure values (7413,        'sp_contabilidad_con',            'cobis',                          'V', '07/10/2008', 'contacon.sp')    
insert into cobis..ad_procedure values (7414,        'sp_contabilidad_cga',            'cobis',                          'V', '07/10/2008', 'contacga.sp')    
insert into cobis..ad_procedure values (7415,        'sp_contabilidad_cmo',            'cobis',                          'V', '07/10/2008', 'contacmo.sp')    
insert into cobis..ad_procedure values (7416,        'sp_contabilidad_rcl',            'cobis',                          'V', '07/10/2008', 'contarcl.sp')    
insert into cobis..ad_procedure values (7417,        'sp_contabilidad_cci',            'cobis',                          'V', '07/10/2008', 'contacci.sp')    
insert into cobis..ad_procedure values (7418,        'sp_contabilidad_geo',            'cobis',                          'V', '07/10/2008', 'contageo.sp')    
insert into cobis..ad_procedure values (7419,        'sp_contabilidad_tga',            'cobis',                          'V', '07/10/2008', 'contatga.sp')    
insert into cobis..ad_procedure values (7420,        'sp_contabilidad_ces',            'cobis',                          'V', '07/10/2008', 'contaces.sp')    
insert into cobis..ad_procedure values (7421,        'sp_contabilidad_clor',           'cobis',                          'V', '07/10/2008', 'contacloria.sp') 
insert into cobis..ad_procedure values (7422,        'sp_contabilidad_io',             'cobis',                          'V', '07/10/2008', 'contaclorio.sp') 
insert into cobis..ad_procedure values (7423,        'sp_contabilidad_est1',           'cobis',                          'V', '07/10/2008', 'contaest1.sp')   
insert into cobis..ad_procedure values (7424,        'sp_contabilidad_est2',           'cobis',                          'V', '07/10/2008', 'contaest2.sp')   
insert into cobis..ad_procedure values (7425,        'sp_contabilidad_epoa',           'cobis',                          'V', '07/10/2008', 'contaepoa.sp')   
insert into cobis..ad_procedure values (7426,        'sp_contabilidad_rucx',           'cobis',                          'V', '07/10/2008', 'contarucx.sp')   
insert into cobis..ad_procedure values (7427,        'sp_contabilidad_epia',           'cobis',                          'V', '07/10/2008', 'contaepia.sp')   
insert into cobis..ad_procedure values (7428,        'sp_contabilidad_clcc',           'cobis',                          'V', '07/10/2008', 'contaclcc.sp')   
insert into cobis..ad_procedure values (7429,        'sp_contabilidad_rucc',           'cobis',                          'V', '07/10/2008', 'contarucc.sp')   
insert into cobis..ad_procedure values (7430,        'sp_pcca_mo',                     'cobis',                          'V', '06/27/2008', 'pcmocl.sp')      
insert into cobis..ad_procedure values (7431,        'sp_cont_devint',                 'cobis',                          'V', '07/10/2008', 'cadevint')       
insert into cobis..ad_procedure values (7432,        'sp_cont_devint_uno',             'cobis',                          'V', '07/10/2008', 'cadevin1')       
go

delete cobis..ad_procedure
 where pd_procedure in (7433,7434,7435,7436,7437,7438,7439,7440,7441,7442,7443,7444,7445,7446,7447,7448,7449,7460,7500,7501,7502,
                        7503,7504,7505,7583,7584,7984,7999)
   and pd_base_datos = 'cob_cartera'
go

insert into cobis..ad_procedure values (7433,        'sp_f127_masivo',                 'cob_cartera',                    'V', '06/27/2008', 'ppasf127.sp')    
insert into cobis..ad_procedure values (7434,        'sp_consulta_ppasivas',           'cob_cartera',                    'V', '06/27/2008', 'consulpp.sp')    
insert into cobis..ad_procedure values (7435,        'sp_cargar_castigos_masivos',     'cob_cartera',                    'V', '06/27/2008', 'cargacas.sp')    
insert into cobis..ad_procedure values (7436,        'sp_aviso_reaj_masivo',           'cob_cartera',                    'V', '06/27/2008', 'avisoreaj')      
insert into cobis..ad_procedure values (7437,        'sp_devolucion_comisiones',       'cob_cartera',                    'V', '06/27/2008', 'devrubro')       
insert into cobis..ad_procedure values (7438,        'sp_resumen_mov_redescuento',     'cob_cartera',                    'V', '06/27/2008', 'caresred.sp')    
insert into cobis..ad_procedure values (7439,        'sp_mensajes_facturacion',        'cob_cartera',                    'V', '06/27/2008', 'camenfac.sp')    
insert into cobis..ad_procedure values (7440,        'sp_traslado_interes',            'cob_cartera',                    'V', '06/27/2008', 'traslado.sp')    
insert into cobis..ad_procedure values (7441,        'sp_fval_masivo',                 'cob_cartera',                    'V', '06/27/2008', 'fvalmas.sp')     
go

delete cobis..ad_procedure
 where pd_procedure in (7442)
   and pd_base_datos = 'cobis'
go

insert into cobis..ad_procedure values (7442,        'sp_contabilidad_cas',            'cobis',                          'V', '06/27/2008', 'contacas.sp')    
go

delete cobis..ad_procedure
 where pd_procedure in (7443,7444,7445,7446,7447,7448,7449,7460,7500,7501)
   and pd_base_datos = 'cob_cartera'
go

insert into cobis..ad_procedure values (7443,        'sp_matriz',                      'cob_cartera',                    'V', '02/26/2009', 'ca_matriz.sp')   
insert into cobis..ad_procedure values (7444,        'sp_eje',                         'cob_cartera',                    'V', '02/26/2009', 'ca_eje.sp')      
insert into cobis..ad_procedure values (7445,        'sp_eje_rango',                   'cob_cartera',                    'V', '02/26/2009', 'ca_eje_rango.s') 
insert into cobis..ad_procedure values (7446,        'sp_man_matriz_valor',            'cob_cartera',                    'V', '02/28/2009', 'ca_man_matriz_') 
insert into cobis..ad_procedure values (7447,        'sp_reestructuracion_cca',        'cob_cartera',                    'V', '03/18/2009', 'reestcca.sp')    
insert into cobis..ad_procedure values (7448,        'sp_trano_conta_cons',            'cob_cartera',                    'V', '06/27/2008', 'trnocontaco')    
insert into cobis..ad_procedure values (7449,        'sp_simula_comp',                 'cob_cartera',                    'V', '06/27/2008', 'casimcomp.s')    
insert into cobis..ad_procedure values (7460,        'sp_actualiza_codeudor',          'cob_cartera',                    'V', '06/27/2008', 'actcodeu.sp')    
insert into cobis..ad_procedure values (7500,        'sp_front_end',                   'cob_cartera',                    'V', '06/27/2008', 'frontend.sp')    
insert into cobis..ad_procedure values (7501,        'sp_trano_conta_cons',            'cob_cartera',                    'V', '06/27/2008', 'qroperh.sp')     
go

delete cobis..ad_procedure
 where pd_procedure in (7502,7503)
   and pd_base_datos = 'cob_cartera_his'
go

insert into cobis..ad_procedure values (7502,        'sp_datos_operacion_his',         'cob_cartera_his',                'V', '06/27/2008', 'datosoph.sp')    
insert into cobis..ad_procedure values (7503,        'sp_buscar_operaciones_his',      'cob_cartera_his',                'V', '06/27/2008', 'busoperh.sp')    
go

delete cobis..ad_procedure
 where pd_procedure in (7301,7504,7505,7583,7584,7984,7999,7067,7968,74668, 7969, 7297,7295,7296,7299)
   and pd_base_datos = 'cob_cartera'
go
insert into cobis..ad_procedure values (7301,        'sp_log_pagos',                   'cob_cartera',                    'V', '07/27/2017', 'log_pagos.sp')
insert into cobis..ad_procedure values (7067,        'sp_qr_operacion',                'cob_cartera',                    'V', '08/06/2008', 'qroper.sp')
insert into cobis..ad_procedure values (7504,        'sp_fuente_recursos',             'cob_cartera',                    'V', '08/26/2008', 'fuerecur.sp')    
insert into cobis..ad_procedure values (7505,        'sp_cartas_desembolso',           'cob_cartera',                    'V', '03/05/2009', 'cardesem.sp')    
insert into cobis..ad_procedure values (7583,        'sp_desembolso_parcial',          'cob_cartera',                    'V', '06/27/2008', 'desembolpar')    
insert into cobis..ad_procedure values (7584,        'sp_estado_diario_cartera',       'cob_cartera',                    'V', '05/30/2009', 'estado_diario')
insert into cobis..ad_procedure values (7984,        'sp_cambiar_fecha',               'cob_cartera',                    'V', '06/27/2008', 'cambfech.sp')    
insert into cobis..ad_procedure values (7999,        'sp_version',                     'cob_cartera',                    'V', '06/27/2008', 'version.sp')
insert into cobis..ad_procedure values (7968,        'sp_aplica_pag_sol',              'cob_cartera',                    'V', getdate(),    'aplipagsol.sp')
insert into cobis..ad_procedure values (74668,       'sp_reportes',                    'cob_cartera',                    'V', getdate(),    'sp_reportes.sp')
insert into cobis..ad_procedure values (7969,        'sp_qr_operaciones_hijas',        'cob_cartera',                    'V', getdate(),    'qrophi.sp')
insert into cobis..ad_procedure values (7297,        'sp_lcr_desembolsar',             'cob_cartera',                    'V', getdate(), 'lcr_desem.sp')    
insert into cobis..ad_procedure values (7295,        'sp_lcr_parametros_generales',    'cob_cartera',                    'V', getdate(), 'lcr_par_gen.sp')    
insert into cobis..ad_procedure values (7296,        'sp_lcr_consultar',               'cob_cartera',                    'V', getdate(), 'lcr_desembolsar.sp')    
insert into cobis..ad_procedure values (7299,        'sp_lcr_incrementar_cupo',        'cob_cartera',                    'V', getdate(), 'lcr_inccup.sp')    
go

PRINT '<<< FINALIZACION DEL PROCESO DE INSERCION EN LA ad_procedure >>>'


PRINT '<<< INICIALIZACION DEL PROCESO DE INSERCION EN LA cl_ttransaccion >>>'

delete cobis..cl_ttransaccion
 where tn_trn_code in(7001,7002,7003,7004,7005,7006,7007,7008,7009,7010,7011,7012,7013,7014,7015,7016,7017,7018,7019,7020,7021,
                      7022,7023,7024,7025,7026,7027,7028,7029,7030,7031,7032,7033,7034,7035,7036,7037,7038,7039,7040,7041,7042,
                      7043,7044,7045,7046,7047,7048,7049,7050,7051,7052,7053,7054,7055,7056,7057,7058,7059,7060,7061,7062,7063,
                      7064,7065,7066,7067,7068,7069,7070,7071,7072,7073,7074,7075,7076,7077,7078,7079,7080,7081,7082,7083,7084,
                      7085,7086,7087,7088,7089,7090,7091,7092,7093,7094,7095,7096,7097,7098,7099,7100,7101,7102,7103,7104,7105,
					  7106,7107,7108,7109,7110,7111,7112,7113,7114,7115,7116,7117,7118,7119,7120,7121,7122,7123,7124,7125,7126,
                      7127,7128,7129,7130,7131,7132,7133,7134,7135,7136,7137,7138,7139,7140,7141,7142,7143,7144,7145,7146,7147,
                      7148,7149,7150,7151,7152,7153,7154,7155,7156,7157,7158,7159,7160,7161,7162,7163,7164,7165,7166,7167,7168,
                      7169,7170,7171,7172,7173,7174,7175,7176,7177,7178,7179,7180,7181,7182,7183,7184,7185,7186,7187,7188,7189,
                      7190,7191,7192,7193,7194,7195,7196,7197,7198,7199,7200,7274,7290,7300,77501,7990, 74663, 73904,77502,77503,77511)
go

insert into cobis..cl_ttransaccion values (7001,       'ACTUALIZACION DEL ESTADO DE LA OPERACION',                         '7001',   'ACTUALIZACION DEL ESTADO DE LA OPERACION')                                                                                                                                                                                                                     
insert into cobis..cl_ttransaccion values (7002,       'ELIMINACION DE TABLAS TEMPORALES',                                 '7002',   'ELIMINACION DE TABLAS TEMPORALES')                                                                                                                                                                                                                             
insert into cobis..cl_ttransaccion values (7003,       'AYUDA DE CUENTAS DE OTROS MODULOS COBIS',                          '7003',   'AYUDA DE CUENTAS DE OTROS MODULOS COBIS')                                                                                                                                                                                                                      
insert into cobis..cl_ttransaccion values (7004,       'VALIDACION DE CUENTAS DE OTROS MODULOS COBIS',                     '7004',   'VALIDACION DE CUENTAS DE OTROS MODULOS COBIS')                                                                                                                                                                                                                 
insert into cobis..cl_ttransaccion values (7005,       'INSERCION DEL CLIENTE EN TEMPORALES',                              '7005',   'INSERCION DEL CLIENTE EN TEMPORALES')                                                                                                                                                                                                                          
insert into cobis..cl_ttransaccion values (7006,       'SELECCION DE CONCEPTOS',                                           '7006',   'SELECCION DE CONCEPTOS')                                                                                                                                                                                                                                       
insert into cobis..cl_ttransaccion values (7007,       'AYUDA DE CONCEPTOS',                                               '7007',   'AYUDA DE CONCEPTOS')                                                                                                                                                                                                                                           
insert into cobis..cl_ttransaccion values (7008,       'CONSULTA DE CONCEPTOS',                                            '7008',   'CONSULTA DE CONCEPTOS')                                                                                                                                                                                                                                        
insert into cobis..cl_ttransaccion values (7009,       'CONSULTA DE TRANSACCIONES',                                        '7009',   'CONSULTA DE TRANSACCIONES')                                                                                                                                                                                                                                    
insert into cobis..cl_ttransaccion values (7010,       'CREACION DE OPERACION',                                            '7010',   'CREACION DE OPERACION')                                                                                                                                                                                                                                        
insert into cobis..cl_ttransaccion values (7011,       'CREACION DE OPERACION TEMPORAL',                                   '7011',   'CREACION DE OPERACION TEMPORAL')                                                                                                                                                                                                                               
insert into cobis..cl_ttransaccion values (7012,       'SELECCION DE LAS CUOTAS ADICIONALES',                              '7012',   'SELECCION DE LAS CUOTAS ADICIONALES')                                                                                                                                                                                                                          
insert into cobis..cl_ttransaccion values (7013,       'ACTUALIZACION DE CUOTAS ADICIONALES',                              '7013',   'ACTUALIZACION DE CUOTAS ADICIONALES')                                                                                                                                                                                                                          
insert into cobis..cl_ttransaccion values (7014,       'ELIMINACION DE CUOTAS ADICIONALES',                                '7014',   'ELIMINACION DE CUOTAS ADICIONALES')                                                                                                                                                                                                                            
insert into cobis..cl_ttransaccion values (7015,       'DETALLE DEL ESTADO DE LA OPERACION',                               '7015',   'DETALLE DEL ESTADO DE LA OPERACION')                                                                                                                                                                                                                           
insert into cobis..cl_ttransaccion values (7016,       'DETALLE DE LOS ABONOS DE LA OPERACION',                            '7016',   'DETALLE DE LOS ABONOS DE LA OPERACION')                                                                                                                                                                                                                        
insert into cobis..cl_ttransaccion values (7017,       'RUBROS DE LA OPERACION',                                           '7017',   'RUBROS DE LA OPERACION')                                                                                                                                                                                                                                       
insert into cobis..cl_ttransaccion values (7018,       'DEUDORES DE LA OPERACION',                                         '7018',   'DEUDORES DE LA OPERACION')                                                                                                                                                                                                                                     
insert into cobis..cl_ttransaccion values (7019,       'CONDICIONES DE PAGO DE LA OPERACION',                              '7019',   'CONDICIONES DE PAGO DE LA OPERACION')                                                                                                                                                                                                                          
insert into cobis..cl_ttransaccion values (7020,       'ABONOS DE LA OPERACION',                                           '7020',   'ABONOS DE LA OPERACION')                                                                                                                                                                                                                                       
insert into cobis..cl_ttransaccion values (7021,       'GARANTIAS DE LA OPERACION',                                        '7021',   'GARANTIAS DE LA OPERACION')                                                                                                                                                                                                                                    
insert into cobis..cl_ttransaccion values (7022,       'INSTRUCCIONES OPERATIVAS DE LA OPERACION',                         '7022',   'INSTRUCCIONES OPERATIVAS DE LA OPERACION')                                                                                                                                                                                                                     
insert into cobis..cl_ttransaccion values (7023,       'ESTADO ACTUAL DE LA OPERACION',                                    '7023',   'ESTADO ACTUAL DE LA OPERACION')                                                                                                                                                                                                                                
insert into cobis..cl_ttransaccion values (7024,       'TASAS DE LA OPERACION',                                            '7024',   'TASAS DE LA OPERACION')                                                                                                                                                                                                                                        
insert into cobis..cl_ttransaccion values (7025,       'DECODIFICADOR DE PARAMETROS',                                      '7025',   'DECODIFICADOR DE PARAMETROS')                                                                                                                                                                                                                                  
insert into cobis..cl_ttransaccion values (7026,       'ACTUALIZACION DE PARAMETROS POR TIPO DE OPERACION',                '7026',   'ACTUALIZACION DE PARAMETROS POR TIPO DE OPERACION')                                                                                                                                                                                                            
insert into cobis..cl_ttransaccion values (7027,       'CONSULTA DE PARAMETROS POR TIPO DE OPERACION',                     '7027',   'CONSULTA DE PARAMETROS POR TIPO DE OPERACION')                                                                                                                                                                                                                 
insert into cobis..cl_ttransaccion values (7028,       'PAGOS MASIVOS',                                                    '7028',   'PAGOS MASIVOS')                                                                                                                                                                                                                                                
insert into cobis..cl_ttransaccion values (7029,       'SELECCION DE DESEMBOLSOS',                                         '7029',   'SELECCION DE DESEMBOLSOS')                                                                                                                                                                                                                                     
insert into cobis..cl_ttransaccion values (7030,       'INSERCION DE DESEMBOLSOS',                                         '7030',   'INSERCION DE DESEMBOLSOS')                                                                                                                                                                                                                                     
insert into cobis..cl_ttransaccion values (7031,       'ELIMINACION DE DESEMBOLSOS',                                       '7031',   'ELIMINACION DE DESEMBOLSOS')                                                                                                                                                                                                                                   
insert into cobis..cl_ttransaccion values (7032,       'CONSULTA DE DESEMBOLSOS',                                          '7032',   'CONSULTA DE DESEMBOLSOS')                                                                                                                                                                                                                                      
insert into cobis..cl_ttransaccion values (7033,       'ACTUALIZACION DE DETALLE DE REAJUSTE',                             '7033',   'ACTUALIZACION DE DETALLE DE REAJUSTE')                                                                                                                                                                                                                         
insert into cobis..cl_ttransaccion values (7034,       'SELECCION DE DETALLE DE REAJUSTE',                                 '7034',   'SELECCION DE DETALLE DE REAJUSTE')                                                                                                                                                                                                                             
insert into cobis..cl_ttransaccion values (7035,       'ELIMINACION DE DETALLE DE REAJUSTE',                               '7035',   'ELIMINACION DE DETALLE DE REAJUSTE')                                                                                                                                                                                                                           
insert into cobis..cl_ttransaccion values (7036,       'ELIMINACION DE PAGOS PENDIENTES',                                  '7036',   'ELIMINACION DE PAGOS PENDIENTES')                                                                                                                                                                                                                              
insert into cobis..cl_ttransaccion values (7037,       'SELECCION DE PAGOS PENDIENTES',                                    '7037',   'SELECCION DE PAGOS PENDIENTES')                                                                                                                                                                                                                                
insert into cobis..cl_ttransaccion values (7038,       'CONSULTA DE PAGOS PENDIENTES',                                     '7038',   'CONSULTA DE PAGOS PENDIENTES')                                                                                                                                                                                                                                 
insert into cobis..cl_ttransaccion values (7039,       'SELECCION DE CAMBIOS DE ESTADO',                                   '7039',   'SELECCION DE CAMBIOS DE ESTADO')                                                                                                                                                                                                                               
insert into cobis..cl_ttransaccion values (7040,       'ELIMINACION DE CAMBIOS DE ESTADO',                                 '7040',   'ELIMINACION DE CAMBIOS DE ESTADO')                                                                                                                                                                                                                             
insert into cobis..cl_ttransaccion values (7041,       'INSERCION DE CAMBIOS DE ESTADO',                                   '7041',   'INSERCION DE CAMBIOS DE ESTADO')                                                                                                                                                                                                                               
insert into cobis..cl_ttransaccion values (7042,       'ACTUALIZACION DE CAMBIOS DE ESTADO',                               '7042',   'ACTUALIZACION DE CAMBIOS DE ESTADO')                                                                                                                                                                                                                           
insert into cobis..cl_ttransaccion values (7043,       'AYUDA DE CAMBIOS DE ESTADO',                                       '7043',   'AYUDA DE CAMBIOS DE ESTADO')                                                                                                                                                                                                                                   
insert into cobis..cl_ttransaccion values (7044,       'VALIDACION DE CAMBIOS DE ESTADO',                                  '7044',   'VALIDACION DE CAMBIOS DE ESTADO')                                                                                                                                                                                                                              
insert into cobis..cl_ttransaccion values (7045,       'SELECCION DE ESTADOS DE RUBRO',                                    '7045',   'SELECCION DE ESTADOS DE RUBRO')                                                                                                                                                                                                                                
insert into cobis..cl_ttransaccion values (7046,       'ELIMINACION DE ESTADOS DE RUBRO',                                  '7046',   'ELIMINACION DE ESTADOS DE RUBRO')                                                                                                                                                                                                                              
insert into cobis..cl_ttransaccion values (7047,       'INSERCION DE ESTADOS DE RUBRO',                                    '7047',   'INSERCION DE ESTADOS DE RUBRO')                                                                                                                                                                                                                                
insert into cobis..cl_ttransaccion values (7048,       'ACTUALIZACION DE ESTADOS DE RUBRO',                                '7048',   'ACTUALIZACION DE ESTADOS DE RUBRO')                                                                                                                                                                                                                            
insert into cobis..cl_ttransaccion values (7049,       'PROCESO DE FECHA VALOR',                                           '7049',   'PROCESO DE FECHA VALOR')                                                                                                                                                                                                                                       
insert into cobis..cl_ttransaccion values (7050,       'VARIABLES GENERALES',                                              '7050',   'VARIABLES GENERALES')                                                                                                                                                                                                                                          
insert into cobis..cl_ttransaccion values (7051,       'IMPRESION DE OFICINA',                                             '7051',   'IMPRESION DE OFICINA')                                                                                                                                                                                                                                         
insert into cobis..cl_ttransaccion values (7052,       'IMPRESION DE DATOS DE LA OPERACION',                               '7052',   'IMPRESION DE DATOS DE LA OPERACION')                                                                                                                                                                                                                           
insert into cobis..cl_ttransaccion values (7053,       'IMPRESION DE LA LIQUIDACION DE LA OPERACION',                      '7053',   'IMPRESION DE LA LIQUIDACION DE LA OPERACION')                                                                                                                                                                                                                  
insert into cobis..cl_ttransaccion values (7054,       'IMPRESION DE LA ORDEN DE PAGO',                                    '7054',   'IMPRESION DE LA ORDEN DE PAGO')                                                                                                                                                                                                                                
insert into cobis..cl_ttransaccion values (7055,       'IMPRESION DEL RECIBO DE PAGO',                                     '7055',   'IMPRESION DEL RECIBO DE PAGO')                                                                                                                                                                                                                                 
insert into cobis..cl_ttransaccion values (7056,       'IMPRESION DE LA TABLA DE AMORTIZACION',                            '7056',   'IMPRESION DE LA TABLA DE AMORTIZACION')                                                                                                                                                                                                                        
insert into cobis..cl_ttransaccion values (7057,       'IMPRESION DE TRANSACCIONES',                                       '7057',   'IMPRESION DE TRANSACCIONES')                                                                                                                                                                                                                                   
insert into cobis..cl_ttransaccion values (7058,       'INGRESO DE ABONO',                                                 '7058',   'INGRESO DE ABONO')                                                                                                                                                                                                                                             
insert into cobis..cl_ttransaccion values (7059,       'INGRESO DEL DETALLE DEL ABONO',                                    '7059',   'INGRESO DEL DETALLE DEL ABONO')                                                                                                                                                                                                                                
insert into cobis..cl_ttransaccion values (7060,       'LIQUIDACION DE LA OPERACION',                                      '7060',   'LIQUIDACION DE LA OPERACION')                                                                                                                                                                                                                                  
insert into cobis..cl_ttransaccion values (7061,       'MODIFICACION DE OPERACION',                                        '7061',   'MODIFICACION DE OPERACION')                                                                                                                                                                                                                                    
insert into cobis..cl_ttransaccion values (7062,       'AYUDA DE OFICIALES',                                               '7062',   'AYUDA DE OFICIALES')                                                                                                                                                                                                                                           
insert into cobis..cl_ttransaccion values (7063,       'VALIDACION DE UN OFICIAL',                                         '7063',   'VALIDACION DE UN OFICIAL')                                                                                                                                                                                                                                     
insert into cobis..cl_ttransaccion values (7064,       'CREACION DE OPERACION DEFINITIVA',                                 '7064',   'CREACION DE OPERACION DEFINITIVA')                                                                                                                                                                                                                             
insert into cobis..cl_ttransaccion values (7065,       'CONSULTA DE OTROS CARGOS',                                         '7065',   'CONSULTA DE OTROS CARGOS')                                                                                                                                                                                                                                     
insert into cobis..cl_ttransaccion values (7066,       'INSERCION DE LA TRANSACCION DE OTROS CARGOS',                      '7066',   'INSERCION DE LA TRANSACCION DE OTROS CARGOS')                                                                                                                                                                                                                  
insert into cobis..cl_ttransaccion values (7067,       'AYUDA DE OTROS CARGOS',                                            '7067',   'AYUDA DE OTROS CARGOS')                                                                                                                                                                                                                                        
insert into cobis..cl_ttransaccion values (7068,       'SELECCION DE OTROS CARGOS',                                        '7068',   'SELECCION DE OTROS CARGOS')                                                                                                                                                                                                                                    
insert into cobis..cl_ttransaccion values (7069,       'INSERCION DE PARAMETRO',                                           '7069',   'INSERCION DE PARAMETRO')                                                                                                                                                                                                                                       
insert into cobis..cl_ttransaccion values (7070,       'ACTUALIZACION DE PARAMETRO',                                       '7070',   'ACTUALIZACION DE PARAMETRO')                                                                                                                                                                                                                                   
insert into cobis..cl_ttransaccion values (7071,       'SELECCION DE PARAMETROS',                                          '7071',   'SELECCION DE PARAMETROS')                                                                                                                                                                                                                                      
insert into cobis..cl_ttransaccion values (7072,       'CONSULTA DE PARAMETROS',                                           '7072',   'CONSULTA DE PARAMETROS')                                                                                                                                                                                                                                       
insert into cobis..cl_ttransaccion values (7073,       'CONSULTA DE TABLA TEMPORAL',                                       '7073',   'CONSULTA DE TABLA TEMPORAL')                                                                                                                                                                                                                                   
insert into cobis..cl_ttransaccion values (7074,       'CONSULTA DE CODEUDORES',                                           '7074',   'CONSULTA DE CODEUDORES')                                                                                                                                                                                                                                       
insert into cobis..cl_ttransaccion values (7075,       'CONSULTA DE ESTADOS',                                              '7075',   'CONSULTA DE ESTADOS')                                                                                                                                                                                                                                          
insert into cobis..cl_ttransaccion values (7076,       'CONSULTA DE PRODUCTOS',                                            '7076',   'CONSULTA DE PRODUCTOS')                                                                                                                                                                                                                                        
insert into cobis..cl_ttransaccion values (7077,       'ACTUALIZACION DE REAJUSTE',                                        '7077',   'ACTUALIZACION DE REAJUSTE')                                                                                                                                                                                                                                    
insert into cobis..cl_ttransaccion values (7078,       'SELECCION DE REAJUSTE',                                            '7078',   'SELECCION DE REAJUSTE')                                                                                                                                                                                                                                        
insert into cobis..cl_ttransaccion values (7079,       'ELIMINACION DE REAJUSTE',                                          '7079',   'ELIMINACION DE REAJUSTE')                                                                                                                                                                                                                                      
insert into cobis..cl_ttransaccion values (7080,       'ACTUALIZACION DE REAJUSTE',                                        '7080',   'ACTUALIZACION DE REAJUSTE')                                                                                                                                                                                                                                    
insert into cobis..cl_ttransaccion values (7081,       'SELECCION DE REAJUSTE',                                            '7081',   'SELECCION DE REAJUSTE')                                                                                                                                                                                                                                        
insert into cobis..cl_ttransaccion values (7082,       'ELIMINACION DE REAJUSTE',                                          '7082',   'ELIMINACION DE REAJUSTE')                                                                                                                                                                                                                                      
insert into cobis..cl_ttransaccion values (7083,       'REESTRUCTURACION DE OPERACIONES',                                  '7083',   'REESTRUCTURACION DE OPERACIONES')                                                                                                                                                                                                                              
insert into cobis..cl_ttransaccion values (7084,       'SELECCION DE RETENCIONES',                                         '7084',   'SELECCION DE RETENCIONES')                                                                                                                                                                                                                                     
insert into cobis..cl_ttransaccion values (7085,       'ACTUALIZACION DE RETENCIONES',                                     '7085',   'ACTUALIZACION DE RETENCIONES')                                                                                                                                                                                                                                 
insert into cobis..cl_ttransaccion values (7086,       'INSERCION DE RETENCIONES',                                         '7086',   'INSERCION DE RETENCIONES')                                                                                                                                                                                                                                     
insert into cobis..cl_ttransaccion values (7087,       'ELIMINACION DE RETENCIONES',                                       '7087',   'ELIMINACION DE RETENCIONES')                                                                                                                                                                                                                                   
insert into cobis..cl_ttransaccion values (7088,       'INSERCION DE CONCEPTOS',                                           '7088',   'INSERCION DE CONCEPTOS')                                                                                                                                                                                                                                       
insert into cobis..cl_ttransaccion values (7089,       'ACTUALIZACION DE CONCEPTOS',                                       '7089',   'ACTUALIZACION DE CONCEPTOS')                                                                                                                                                                                                                                   
insert into cobis..cl_ttransaccion values (7090,       'ELIMINACION DE CONCEPTOS',                                         '7090',   'ELIMINACION DE CONCEPTOS')                                                                                                                                                                                                                                     
insert into cobis..cl_ttransaccion values (7091,       'AYUDA DE CONCEPTOS',                                               '7091',   'AYUDA DE CONCEPTOS')                                                                                                                                                                                                                                           
insert into cobis..cl_ttransaccion values (7092,       'SELECCION DE CONCEPTOS',                                           '7092',   'SELECCION DE CONCEPTOS')                                                                                                                                                                                                                                       
insert into cobis..cl_ttransaccion values (7093,       'CONSULTA DE CONCEPTOS',                                            '7093',   'CONSULTA DE CONCEPTOS')                                                                                                                                                                                                                                        
insert into cobis..cl_ttransaccion values (7094,       'SELECCION DE RUBROS TEMPORALES',                                   '7094',   'SELECCION DE RUBROS TEMPORALES')                                                                                                                                                                                                                               
insert into cobis..cl_ttransaccion values (7095,       'CONSULTA DE RUBROS TEMPORALES',                                    '7095',   'CONSULTA DE RUBROS TEMPORALES')                                                                                                                                                                                                                                
insert into cobis..cl_ttransaccion values (7096,       'ELIMINACION DE RUBROS TEMPORALES',                                 '7096',   'ELIMINACION DE RUBROS TEMPORALES')                                                                                                                                                                                                                             
insert into cobis..cl_ttransaccion values (7097,       'ACTUALIZACION DE RUBROS TEMPORALES',                               '7097',   'ACTUALIZACION DE RUBROS TEMPORALES')                                                                                                                                                                                                                           
insert into cobis..cl_ttransaccion values (7098,       'SELECCION DE RANGOS',                                              '7098',   'SELECCION DE RANGOS')                                                                                                                                                                                                                                          
insert into cobis..cl_ttransaccion values (7099,       'ELIMINACION DE RANGOS',                                            '7099',   'ELIMINACION DE RANGOS')                                                                                                                                                                                                                                        
insert into cobis..cl_ttransaccion values (7100,       'INSERCION DE RANGOS',                                              '7100',   'INSERCION DE RANGOS')                                                                                                                                                                                                                                          
insert into cobis..cl_ttransaccion values (7101,       'ACTUALIZACION DE RANGOS',                                          '7101',   'ACTUALIZACION DE RANGOS')                                                                                                                                                                                                                                      
insert into cobis..cl_ttransaccion values (7102,       'SELECCION DE TABLA DE RUBROS',                                     '7102',   'SELECCION DE TABLA DE RUBROS')                                                                                                                                                                                                                                 
insert into cobis..cl_ttransaccion values (7103,       'ELIMINACION DE TABLA DE RUBROS',                                   '7103',   'ELIMINACION DE TABLA DE RUBROS')                                                                                                                                                                                                                               
insert into cobis..cl_ttransaccion values (7104,       'INSERCION DE TABLA DE RUBROS',                                     '7104',   'INSERCION DE TABLA DE RUBROS')                                                                                                                                                                                                                                 
insert into cobis..cl_ttransaccion values (7105,       'ACTUALIZACION DE TABLA DE RUBROS',                                 '7105',   'ACTUALIZACION DE TABLA DE RUBROS')                                                                                                                                                                                                                             
insert into cobis..cl_ttransaccion values (7106,       'SELECCION DE TIPOS DE DIVIDENDO',                                  '7106',   'SELECCION DE TIPOS DE DIVIDENDO')                                                                                                                                                                                                                              
insert into cobis..cl_ttransaccion values (7107,       'AYUDA DE TIPOS DE DIVIDENDO',                                      '7107',   'AYUDA DE TIPOS DE DIVIDENDO')                                                                                                                                                                                                                                  
insert into cobis..cl_ttransaccion values (7108,       'INSERCION DE TIPOS DE DIVIDENDO',                                  '7108',   'INSERCION DE TIPOS DE DIVIDENDO')                                                                                                                                                                                                                              
insert into cobis..cl_ttransaccion values (7109,       'ACTUALIZACION DE TIPOS DE DIVIDENDO',                              '7109',   'ACTUALIZACION DE TIPOS DE DIVIDENDO')                                                                                                                                                                                                                          
insert into cobis..cl_ttransaccion values (7110,       'ACTUALIZACION DE TIPOS DE TRANSACCION',                            '7110',   'ACTUALIZACION DE TIPOS DE TRANSACCION')                                                                                                                                                                                                                        
insert into cobis..cl_ttransaccion values (7111,       'CONSULTA DE TIPOS DE TRANSACCION',                                 '7111',   'CONSULTA DE TIPOS DE TRANSACCION')                                                                                                                                                                                                                             
insert into cobis..cl_ttransaccion values (7112,       'AYUDA DE TIPOS DE TRANSACCION',                                    '7112',   'AYUDA DE TIPOS DE TRANSACCION')                                                                                                                                                                                                                                
insert into cobis..cl_ttransaccion values (7113,       'VALIDACION DE TIPOS DE TRANSACCION',                               '7113',   'VALIDACION DE TIPOS DE TRANSACCION')                                                                                                                                                                                                                           
insert into cobis..cl_ttransaccion values (7114,       'CONSULTA DE TIPO DE PLAZO',                                        '7114',   'CONSULTA DE TIPO DE PLAZO')                                                                                                                                                                                                                                    
insert into cobis..cl_ttransaccion values (7115,       'AYUDA DE PERFIL POR TIPO DE OPERACION',                            '7115',   'AYUDA DE PERFIL POR TIPO DE OPERACION')                                                                                                                                                                                                                        
insert into cobis..cl_ttransaccion values (7116,       'ELIMINACION DE PERFIL POR TIPO DE OPERACION',                      '7116',   'ELIMINACION DE PERFIL POR TIPO DE OPERACION')                                                                                                                                                                                                                  
insert into cobis..cl_ttransaccion values (7117,       'INSERCION DE PERFIL POR TIPO DE OPERACION',                        '7117',   'INSERCION DE PERFIL POR TIPO DE OPERACION')                                                                                                                                                                                                                    
insert into cobis..cl_ttransaccion values (7118,       'ACTUALIZACION DE PERFIL POR TIPO DE OPERACION',                    '7118',   'ACTUALIZACION DE PERFIL POR TIPO DE OPERACION')                                                                                                                                                                                                                
insert into cobis..cl_ttransaccion values (7119,       'CONSULTA DE PERFIL POR TIPO DE OPERACION',                         '7119',   'CONSULTA DE PERFIL POR TIPO DE OPERACION')                                                                                                                                                                                                                     
insert into cobis..cl_ttransaccion values (7120,       'AYUDA DE VALORES REFERENCIALES',                                   '7120',   'AYUDA DE VALORES REFERENCIALES')                                                                                                                                                                                                                               
insert into cobis..cl_ttransaccion values (7121,       'SELECCION DE VALORES REFERENCIALES',                               '7121',   'SELECCION DE VALORES REFERENCIALES')                                                                                                                                                                                                                           
insert into cobis..cl_ttransaccion values (7122,       'CONSULTA DE VALORES REFERENCIALES',                                '7122',   'CONSULTA DE VALORES REFERENCIALES')                                                                                                                                                                                                                            
insert into cobis..cl_ttransaccion values (7123,       'INSERCION DE VALORES REFERENCIALES',                               '7123',   'INSERCION DE VALORES REFERENCIALES')                                                                                                                                                                                                                           
insert into cobis..cl_ttransaccion values (7124,       'ACTUALIZACION DE VALORES REFERENCIALES',                           '7124',   'ACTUALIZACION DE VALORES REFERENCIALES')                                                                                                                                                                                                                       
insert into cobis..cl_ttransaccion values (7125,       'AYUDA DE VALORES',                                                 '7125',   'AYUDA DE VALORES')                                                                                                                                                                                                                                             
insert into cobis..cl_ttransaccion values (7126,       'SELECCION DE VALORES',                                             '7126',   'SELECCION DE VALORES')                                                                                                                                                                                                                                         
insert into cobis..cl_ttransaccion values (7127,       'INSERCION DE VALORES',                                             '7127',   'INSERCION DE VALORES')                                                                                                                                                                                                                                         
insert into cobis..cl_ttransaccion values (7128,       'CONSULTA DE VALORES',                                              '7128',   'CONSULTA DE VALORES')                                                                                                                                                                                                                                          
insert into cobis..cl_ttransaccion values (7129,       'CONSULTA DE VENCIMIENTOS Y REAJUSTES',                             '7129',   'CONSULTA DE VENCIMIENTOS Y REAJUSTES')                                                                                                                                                                                                                         
insert into cobis..cl_ttransaccion values (7130,       'BUSQUEDA GENERAL DE OPERACIONES',                                  '7130',   'BUSQUEDA GENERAL DE OPERACIONES')                                                                                                                                                                                                                              
insert into cobis..cl_ttransaccion values (7131,       'DESCRIPCION DE LOS ESTADOS',                                       '7131',   'DESCRIPCION DE LOS ESTADOS')                                                                                                                                                                                                                                   
insert into cobis..cl_ttransaccion values (7132,       'CONSULTA CAMBIOS DE ESTADOS DE LAS OPERACIONES',                   '7132',   'CONSULTA CAMBIOS DE ESTADOS DE LAS OPERACIONES')                                                                                                                                                                                                               
insert into cobis..cl_ttransaccion values (7133,       'CONSULTA DE USUARIOS',                                             '7133',   'CONSULTA DE USUARIOS')                                                                                                                                                                                                                                         
insert into cobis..cl_ttransaccion values (7134,       'VALIDACION DE USUARIOS',                                           '7134',   'VALIDACION DE USUARIOS')                                                                                                                                                                                                                                       
insert into cobis..cl_ttransaccion values (7135,       'CAMBIOS DE ESTADO DE LA OPERACION',                                '7135',   'CAMBIOS DE ESTADO DE LA OPERACION')                                                                                                                                                                                                                            
insert into cobis..cl_ttransaccion values (7136,       'INSERCION DE CONCEPTOS',                                           '7136',   'INSERCION DE CONCEPTOS')                                                                                                                                                                                                                                       
insert into cobis..cl_ttransaccion values (7137,       'ACTUALIZACION DE CONCEPTOS',                                       '7137',   'ACTUALIZACION DE CONCEPTOS')                                                                                                                                                                                                                                   
insert into cobis..cl_ttransaccion values (7138,       'CONSULTA DE TIPOS DE DIVIDENDOS',                                  '7138',   'CONSULTA DE TIPOS DE DIVIDENDOS')                                                                                                                                                                                                                              
insert into cobis..cl_ttransaccion values (7139,       'SELECCION DE INSTRUCCIONES OPERATIVAS',                            '7139',   'SELECCION DE INSTRUCCIONES OPERATIVAS')                                                                                                                                                                                                                        
insert into cobis..cl_ttransaccion values (7140,       'CONSULTA DE ABONOS',                                               '7140',   'CONSULTA DE ABONOS')                                                                                                                                                                                                                                           
insert into cobis..cl_ttransaccion values (7141,       'CONSULTA ABONOS POR RUBROS',                                       '7141',   'CONSULTA ABONOS POR RUBROS')                                                                                                                                                                                                                                   
insert into cobis..cl_ttransaccion values (7142,       'CONSULTA DE TRANSACCIONES',                                        '7142',   'CONSULTA DE TRANSACCIONES')                                                                                                                                                                                                                                    
insert into cobis..cl_ttransaccion values (7143,       'CONSULTA DE OPERACION TEMPORAL',                                   '7143',   'CONSULTA DE OPERACION TEMPORAL')                                                                                                                                                                                                                               
insert into cobis..cl_ttransaccion values (7144,       'CONSULTA DE PAGOS',                                                '7144',   'CONSULTA DE PAGOS')                                                                                                                                                                                                                                            
insert into cobis..cl_ttransaccion values (7145,       'CONSULTA DE OPERACIONES',                                          '7145',   'CONSULTA DE OPERACIONES')                                                                                                                                                                                                                                      
insert into cobis..cl_ttransaccion values (7146,       'CONSULTA DE DISTRIBUCION DEL CREDITO',                             '7146',   'CONSULTA DE DISTRIBUCION DEL CREDITO')                                                                                                                                                                                                                         
insert into cobis..cl_ttransaccion values (7147,       'AUTORIZACION DE USUARIO PARA CAMBIO DE RUBRO',                     '7147',   'AUTORIZACION DE USUARIO PARA CAMBIO DE RUBRO')                                                                                                                                                                                                                 
insert into cobis..cl_ttransaccion values (7148,       'ENCABEZADO PARA CONSULTAS CRYSTAL',                                '7148',   'ENCABEZADO PARA CONSULTAS CRYSTAL')                                                                                                                                                                                                                            
insert into cobis..cl_ttransaccion values (7149,       'CONSULTA DEL DETALLE DE LA TABLA DE AMORTIZACION',                 '7149',   'CONSULTA DEL DETALLE DE LA TABLA DE AMORTIZACION')                                                                                                                                                                                                             
insert into cobis..cl_ttransaccion values (7150,       'CONSULTA DE DIAS DE GRACIA',                                       '7150',   'CONSULTA DE DIAS DE GRACIA')                                                                                                                                                                                                                                   
insert into cobis..cl_ttransaccion values (7151,       'MODIFICACION DE DIAS GRACIA',                                      '7151',   'MODIFICACION DE DIAS GRACIA')                                                                                                                                                                                                                                  
insert into cobis..cl_ttransaccion values (7152,       'TASA EFECTIVA DE UNA OPERACION',                                   '7152',   'TASA EFECTIVA DE UNA OPERACION')                                                                                                                                                                                                                               
insert into cobis..cl_ttransaccion values (7153,       'APLICACION PAGOS DE ABONOS PENDIENTES O NO APLICADOS',             '7153',   'APLICACION PAGOS DE ABONOS PENDIENTES O NO APLICADOS')                                                                                                                                                                                                         
insert into cobis..cl_ttransaccion values (7154,       'PROYECCION DE CUOTA A PAGAR',                                      '7154',   'PROYECCION DE CUOTA A PAGAR')                                                                                                                                                                                                                                  
insert into cobis..cl_ttransaccion values (7155,       'CONSULTA PAGOS POR ATX',                                           '7155',   'CONSULTA PAGOS POR ATX')                                                                                                                                                                                                                                       
insert into cobis..cl_ttransaccion values (7156,       'CONSULTA DE OPERACIONES',                                          '701',    'CONSULTA DE OPERACIONES')                                                                                                                                                                                                                                      
insert into cobis..cl_ttransaccion values (7157,       'CONSULTA VALORES A PAGAR POR ATX',                                 '7157',   'CONSULTA VALORES A PAGAR POR ATX')                                                                                                                                                                                                                             
insert into cobis..cl_ttransaccion values (7158,       'APLICACION DE PAGOS POR ATX',                                      '7158',   'APLICACION DE PAGOS POR ATX')                                                                                                                                                                                                                                  
insert into cobis..cl_ttransaccion values (7159,       'REVERSA DE APLICACION DE PAGOS POR ATX',                           '7159',   'REVERSA DE APLICACION DE PAGOS POR ATX')                                                                                                                                                                                                                       
insert into cobis..cl_ttransaccion values (7160,       'INSERCION DE UN ESTADO DE OPERACION',                              '7160',   'INSERCION DE UN ESTADO DE OPERACION')                                                                                                                                                                                                                          
insert into cobis..cl_ttransaccion values (7161,       'ELIMINACION DE UN ESTADO DE OPERACION',                            '7161',   'ELIMINACION DE UN ESTADO DE OPERACION')                                                                                                                                                                                                                        
insert into cobis..cl_ttransaccion values (7162,       'TRASLADO DE CARTERA',                                              '7162',   'TRASLADO DE CARTERA')                                                                                                                                                                                                                                          
insert into cobis..cl_ttransaccion values (7163,       'INGRESO DE DIAS DE ACELERATORIA',                                  '7163',   'INGRESO DE DIAS DE ACELERATORIA')                                                                                                                                                                                                                              
insert into cobis..cl_ttransaccion values (7164,       'ACTUALIZACION DE DIAS DE ACELERATORIA',                            '7164',   'ACTUALIZACION DE DIAS DE ACELERATORIA')                                                                                                                                                                                                                        
insert into cobis..cl_ttransaccion values (7165,       'BUSQUEDA DE DIAS DE ACELERATORIA',                                 '7165',   'BUSQUEDA DE DIAS DE ACELERATORIA')                                                                                                                                                                                                                             
insert into cobis..cl_ttransaccion values (7166,       'CONSULTA DE DIAS DE ACELERATORIA',                                 '7166',   'CONSULTA DE DIAS DE ACELERATORIA')                                                                                                                                                                                                                             
insert into cobis..cl_ttransaccion values (7167,       'ELIMINACION DE DIAS DE ACELERATORIA',                              '7167',   'ELIMINACION DE DIAS DE ACELERATORIA')                                                                                                                                                                                                                          
insert into cobis..cl_ttransaccion values (7168,       'CONVERSION DE TASAS',                                              '7168',   'CONVERSION DE TASAS')                                                                                                                                                                                                                                          
insert into cobis..cl_ttransaccion values (7169,       'SELECCION DE TASAS',                                               '7169',   'SELECCION DE TASAS')                                                                                                                                                                                                                                           
insert into cobis..cl_ttransaccion values (7170,       'AYUDA DE TASAS',                                                   '7170',   'AYUDA DE TASAS')                                                                                                                                                                                                                                               
insert into cobis..cl_ttransaccion values (7171,       'INSERCION DE TASAS',                                               '7171',   'INSERCION DE TASAS')                                                                                                                                                                                                                                           
insert into cobis..cl_ttransaccion values (7172,       'ACTUALIZACION DE TASAS',                                           '7172',   'ACTUALIZACION DE TASAS')                                                                                                                                                                                                                                       
insert into cobis..cl_ttransaccion values (7173,       'CREACION DE OPERACION PASIVA',                                     '7173',   'CREACION DE OPERACION PASIVA')                                                                                                                                                                                                                                 
insert into cobis..cl_ttransaccion values (7174,       'CONSULTA DE LA OPERACION PASIVA DE UN ACTIVA',                     '7174',   'CONSULTA DE LA OPERACION PASIVA DE UN ACTIVA')                                                                                                                                                                                                                 
insert into cobis..cl_ttransaccion values (7175,       'RENOVACION DE OPERACIONES',                                        '7175',   'RENOVACION DE OPERACIONES')                                                                                                                                                                                                                                    
insert into cobis..cl_ttransaccion values (7176,       'CONSULTA DE CUENTAS ACTIVAS',                                      '7176',   'CONSULTA DE CUENTAS ACTIVAS')                                                                                                                                                                                                                                  
insert into cobis..cl_ttransaccion values (7177,       'CONSULTA RENOVACION DE OPERACIONES',                               '7177',   'CONSULTA RENOVACION DE OPERACIONES')                                                                                                                                                                                                                           
insert into cobis..cl_ttransaccion values (7178,       'CONSULTA ABONOS POR CUOTAS',                                       '7178',   'CONSULTA ABONOS POR CUOTAS')                                                                                                                                                                                                                                   
insert into cobis..cl_ttransaccion values (7179,       'APLICA LA CLAUSULA ACELERATORIA',                                  '7179',   'APLICA LA CLAUSULA ACELERATORIA')                                                                                                                                                                                                                              
insert into cobis..cl_ttransaccion values (7180,       'INSERCION DE REGISTRO DE NOMINA',                                  '7180',   'INSERCION DE REGISTRO DE NOMINA')                                                                                                                                                                                                                              
insert into cobis..cl_ttransaccion values (7181,       'ELIMINACION DE REGISTRO DE NOMINA',                                '7181',   'ELIMINACION DE REGISTRO DE NOMINA')                                                                                                                                                                                                                            
insert into cobis..cl_ttransaccion values (7182,       'BUSQUEDA DE REGISTROS DE NOMINA',                                  '7182',   'BUSQUEDA DE REGISTROS DE NOMINA')                                                                                                                                                                                                                              
insert into cobis..cl_ttransaccion values (7183,       'CREACION DE PARAMETROS DE CAPITALIZACION',                         '7183',   'CREACION DE PARAMETROS DE CAPITALIZACION')                                                                                                                                                                                                                     
insert into cobis..cl_ttransaccion values (7184,       'CONSULTA DE PARAMETROS DE CAPITALIZACION',                         '7184',   'CONSULTA DE PARAMETROS DE CAPITALIZACION')                                                                                                                                                                                                                     
insert into cobis..cl_ttransaccion values (7185,       'BUSQUEDA DE OPERACIONES QUE SE VAN A REAJUSTAR MASIVAMENTE',       '7185',   'BUSQUEDA DE OPERACIONES QUE SE VAN A REAJUSTAR MASIVAMENTE')                                                                                                                                                                                                   
insert into cobis..cl_ttransaccion values (7186,       'CONSULTA PENDIENTES POR DESEMBOLSO',                               '7186',   'CONSULTA PENDIENTES POR DESEMBOLSO')                                                                                                                                                                                                                           
insert into cobis..cl_ttransaccion values (7187,       'CONSULTA DE DATOS PROCREDITO EN CAJA',                             '7187',   'CONSULTA DE DATOS PROCREDITO EN CAJA')                                                                                                                                                                                                                         
insert into cobis..cl_ttransaccion values (7188,       'CONSULTA PAGOS PROCREDITO',                                        '7188',   'CONSULTA PAGOS PROCREDITO')                                                                                                                                                                                                                                    
insert into cobis..cl_ttransaccion values (7189,       'PASO A HISTORICOS PROCREDITO',                                     '7189',   'PASO A HISTORICOS PROCREDITO')                                                                                                                                                                                                                                 
insert into cobis..cl_ttransaccion values (7190,       'CONSULTA ENTIDADES CONVENIO RECAUDO',                              '7190',   'CONSULTA ENTIDADES CONVENIO RECAUDO')                                                                                                                                                                                                                          
insert into cobis..cl_ttransaccion values (7191,       'CONSULTA FACTURACION MASIVA CONVENIO RECAUDO',                     '7191',   'CONSULTA FACTURACION MASIVA CONVENIO RECAUDO')                                                                                                                                                                                                                 
insert into cobis..cl_ttransaccion values (7192,       'CARGAR PLANO DE FACTURACION',                                      '7192',   'CARGAR PLANO DE FACTURACION')                                                                                                                                                                                                                                  
insert into cobis..cl_ttransaccion values (7193,       'CONSULTA LINEAS DE CUPO APROBADAS PARA UN CLIENTE',                '7193',   'CONSULTA LINEAS DE CUPO APROBADAS PARA UN CLIENTE')                                                                                                                                                                                                            
insert into cobis..cl_ttransaccion values (7194,       'SELECCION DE TIPOS DE PLAZOS',                                     '7194',   'SELECCION DE TIPOS DE PLAZOS')                                                                                                                                                                                                                                 
insert into cobis..cl_ttransaccion values (7195,       'AYUDA DE TIPOS DE PLAZOS',                                         '7195',   'AYUDA DE TIPOS DE PLAZOS')                                                                                                                                                                                                                                     
insert into cobis..cl_ttransaccion values (7196,       'INSERCION DE TIPOS DE PLAZOS',                                     '7196',   'INSERCION DE TIPOS DE PLAZOS')                                                                                                                                                                                                                                 
insert into cobis..cl_ttransaccion values (7197,       'ACTUALIZACION DE TIPOS DE PLAZOS',                                 '7197',   'ACTUALIZACION DE TIPOS DE PLAZOS')                                                                                                                                                                                                                             
insert into cobis..cl_ttransaccion values (7198,       'CREACION AUTOMATICA DE OPERACIONES DESDE OTROS MODULOS',           '7198',   'CREACION AUTOMATICA DE OPERACIONES DESDE OTROS MODULOS')                                                                                                                                                                                                       
insert into cobis..cl_ttransaccion values (7199,       'BUSQUEDA DE OPERACIONES ACTIVAS - PASIVAS',                        '7199',   'BUSQUEDA DE OPERACIONES ACTIVAS - PASIVAS')                                                                                                                                                                                                                    
insert into cobis..cl_ttransaccion values (7200,       'IMPRESION DE LA TABLA DE AMORTIZACION TASA VARIABLE',              '7200',   'IMPRESION DE LA TABLA DE AMORTIZACION TASA VARIABLE')                                                                                                                                                                                                          
insert into cobis..cl_ttransaccion values (7274,       'BUSQUEDA DE OPERACIONES PARA RENOVACION',                          'BOPR',   'BUSQUEDA DE OPERACIONES PARA RENOVACION')                                                                                                                                                                                                          
insert into cobis..cl_ttransaccion values (7290,       'MATRIZ DE REPORTES CARTERA',                                       'MATREP', 'MATRIZ DE REPORTES CARTERA')
insert into cobis..cl_ttransaccion values (7300,       'CATALOGO VALOR DET',                                               '7300',   'CATALOGO VALOR DET FRONT END WEB')
insert into cobis..cl_ttransaccion values (7990,       'REPORTE ORDEN DESEMBOLSO',                                         '7990',   'REPORTE ORDEN DESEMBOLSO')
insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
values (73904, 'ACTUALIZAR PRESTAMO GRUPAL', '73904', 'ACTUALIZAR PRESTAMO GRUPAL')
insert into cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga) values
(77502,'CONSULTA DE DISPERSIONES RECHAZADAS','CDDR','CONSULTA DE DISPERSIONES RECHAZADAS')
insert into cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga) values
(77503,'ACCIONES PARA DISPERSIONES RECHAZADAS','APDR','ACCIONES PARA DISPERSIONES RECHAZADAS')
INSERT INTO cobis..cl_ttransaccion(tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga) 
VALUES(77511, 'LCR - PROCESAR RESPUESTA DESEMBOLSO', 'LCRPRD', 'LCR - PROCESAR RESPUESTA DESEMBOLSO')
go

delete cobis..cl_ttransaccion
 where tn_trn_code in(7201,7203,7204,7205,7206,7207,7208,7209,7210,7211,7212,7213,7214,7215,7216,7217,7218,7219,7220,7221,7222,7223,
                      7224,7225,7226,7227,7228,7229,7230,7231,7232,7233,7234,7235,7236,7237,7238,7239,7240,7241,7242,7243,7244,
                      7245,7246,7247,7248,7249,7250,7251,7252,7253,7254,7255,7256,7257,7258,7259,7260,7261,7262,7263,7264,7265,
                      7266,7267,7268,7269,7270,7271,7272,7273,7275,7276,7278,7279,7280,7293,7291,7298,7301,7305,7306, 7400,7281,7282,
					  7284,7285,7286)
go

insert into cobis..cl_ttransaccion values (7201,       'CARTA DE DESEMBOLSO',                                              '7201',   'CARTA DE DESEMBOLSO')                                                                                                                                                                                                                                          
insert into cobis..cl_ttransaccion values (7203,       'TABLA DE AMORTIZACION',                                            '7203',   'TABLA DE AMORTIZACION')                                                                                                                                                                                                                                          
insert into cobis..cl_ttransaccion values (7204,       'CONSULTA DATOS DE CABECERA DEL PRESTAMO',                          'CDCP',   'CONSULTA DATOS DE CABECERA DEL PRESTAMO')
insert into cobis..cl_ttransaccion values (7205,       'IMPRESION DEL CERTIFICADO DE RETENCION IMPUESTO DE TIMBRE',        '7205',   'IMPRESION DEL CERTIFICADO DE RETENCION IMPUESTO DE TIMBRE')                                                                                                                                                                                                    
insert into cobis..cl_ttransaccion values (7206,       'BUSQUEDA PARAMETRO ORIGEN DE FONDOS - CLASE',                      '7206',   'BUSQUEDA PARAMETRO ORIGEN DE FONDOS - CLASE')                                                                                                                                                                                                                  
insert into cobis..cl_ttransaccion values (7207,       'BUSQUEDA PARAMETRO VALIDACION FINAGRO',                            '7207',   'BUSQUEDA PARAMETRO VALIDACION FINAGRO')                                                                                                                                                                                                                        
insert into cobis..cl_ttransaccion values (7208,       'BUSQUEDA PARAMETRO DE TIPO DE EMPRESA',                            '7208',   'BUSQUEDA PARAMETRO DE TIPO DE EMPRESA')                                                                                                                                                                                                                        
insert into cobis..cl_ttransaccion values (7209,       'CALCULO DE SALDO ACTUAL DE UN PRESTAMO',                           '7209',   'CALCULO DE SALDO ACTUAL DE UN PRESTAMO')                                                                                                                                                                                                                       
insert into cobis..cl_ttransaccion values (7210,       'CARGAR FACTURAS DE FACTORING',                                     '7210',   'CARGAR FACTURAS DE FACTORING')                                                                                                                                                                                                                                 
insert into cobis..cl_ttransaccion values (7211,       'CONSULTA PAGOS DE FACTORING',                                      '7211',   'CONSULTA PAGOS DE FACTORING')                                                                                                                                                                                                                                  
insert into cobis..cl_ttransaccion values (7212,       'MANTENIMIENTO DE RANGOS DE CAPITALIZACION',                        '7212',   'MANTENIMIENTO DE RANGOS DE CAPITALIZACION')                                                                                                                                                                                                                    
insert into cobis..cl_ttransaccion values (7213,       'DECODIFICADOR DE PARAMETROS',                                      '7213',   'DECODIFICADOR DE PARAMETROS')                                                                                                                                                                                                                                  
insert into cobis..cl_ttransaccion values (7214,       'CONFIRMACION DE PAGOS POR ATX O SERVICIOS BANCARIOS',              '7214',   'CONFIRMACION DE PAGOS POR ATX O SERVICIOS BANCARIOS')                                                                                                                                                                                                          
insert into cobis..cl_ttransaccion values (7215,       'IMPRESION DEL ESTADO DE CUENTA',                                   '7215',   'IMPRESION DEL ESTADO DE CUENTA')                                                                                                                                                                                                                               
insert into cobis..cl_ttransaccion values (7216,       'INSERCION DE LOS DIFERENTES SUBTIPOS DE LINEA',                    '7216',   'INSERCION DE LOS DIFERENTES SUBTIPOS DE LINEA')                                                                                                                                                                                                                
insert into cobis..cl_ttransaccion values (7217,       'ACTUALIZACION DEL REGISTRO DE SUBTIPOS DE LINEA',                  '7217',   'ACTUALIZACION DEL REGISTRO DE SUBTIPOS DE LINEA')                                                                                                                                                                                                              
insert into cobis..cl_ttransaccion values (7218,       'ELIMINACION DEL REGISTRO DE SUBTIPOS DE LINEA',                    '7218',   'ELIMINACION DEL REGISTRO DE SUBTIPOS DE LINEA')                                                                                                                                                                                                                
insert into cobis..cl_ttransaccion values (7219,       'BUSQUEDA DE LOS REGISTROS DE LOS DIFERENTES SUBTIPOS DE LINEA',    '7219',   'BUSQUEDA DE LOS REGISTROS DE LOS DIFERENTES SUBTIPOS DE LINEA')                                                                                                                                                                                                
insert into cobis..cl_ttransaccion values (7220,       'CONSULTA DE UN REGISTROS DE SUBTIPOS DE LINEA',                    '7220',   'CONSULTA DE UN REGISTROS DE SUBTIPOS DE LINEA')                                                                                                                                                                                                                
insert into cobis..cl_ttransaccion values (7221,       'AYUDA EN LOS REGISTROS DE SUBTIPOS DE LINEA',                      '7221',   'AYUDA EN LOS REGISTROS DE SUBTIPOS DE LINEA')                                                                                                                                                                                                                  
insert into cobis..cl_ttransaccion values (7222,       'CONSULTA DE LAS CATEGORIAS DE PAGOS',                              '7222',   'CONSULTA DE LAS CATEGORIAS DE PAGOS')                                                                                                                                                                                                                          
insert into cobis..cl_ttransaccion values (7223,       'CONSULTA DE LAS CATEGORIAS DE RUBROS',                             '7223',   'CONSULTA DE LAS CATEGORIAS DE RUBROS')                                                                                                                                                                                                                         
insert into cobis..cl_ttransaccion values (7224,       'APLICACION DE PAGOS POR ATX EN HORARIO EXTENDIDO',                 '7224',   'APLICACION DE PAGOS POR ATX EN HORARIO EXTENDIDO')                                                                                                                                                                                                             
insert into cobis..cl_ttransaccion values (7225,       'CONSULTA DE MALAS REFERENCIAS CLIENTE',                            '7225',   'CONSULTA DE MALAS REFERENCIAS CLIENTE')                                                                                                                                                                                                                        
insert into cobis..cl_ttransaccion values (7226,       'CONSULTA DE GERENTE ASOCIADO AL CLIENTE',                          '7226',   'CONSULTA DE GERENTE ASOCIADO AL CLIENTE')                                                                                                                                                                                                                      
insert into cobis..cl_ttransaccion values (7227,       'CONSULTA DE TRANSACCIONES ACH',                                    '7227',   'CONSULTA DE TRANSACCIONES ACH')                                                                                                                                                                                                                                
insert into cobis..cl_ttransaccion values (7228,       'CARGAR MAESTRO ACH A PRENOTIFICAR',                                '7228',   'CARGAR MAESTRO ACH A PRENOTIFICAR')                                                                                                                                                                                                                            
insert into cobis..cl_ttransaccion values (7229,       'CONSULTA DE OPERACIONES PARA PAGOS MASIVOS',                       '7229',   'CONSULTA DE OPERACIONES PARA PAGOS MASIVOS')                                                                                                                                                                                                                   
insert into cobis..cl_ttransaccion values (7230,       'ACTUALIZACION DE LA FECHA DE CIERRE',                              '7230',   'ACTUALIZACION DE LA FECHA DE CIERRE')                                                                                                                                                                                                                          
insert into cobis..cl_ttransaccion values (7231,       'CONSULTA DE LA FECHA DE CIERRE',                                   '7231',   'CONSULTA DE LA FECHA DE CIERRE')                                                                                                                                                                                                                               
insert into cobis..cl_ttransaccion values (7232,       'INSERT DE CUOTA PARA PRORROGA',                                    '7232',   'INSERT DE CUOTA PARA PRORROGA')                                                                                                                                                                                                                                
insert into cobis..cl_ttransaccion values (7233,       'DELETE DE CUOTA PARA PRORROGA',                                    '7233',   'DELETE DE CUOTA PARA PRORROGA')                                                                                                                                                                                                                                
insert into cobis..cl_ttransaccion values (7234,       'UPDATE DE CUOTA PARA PRORROGA',                                    '7234',   'UPDATE DE CUOTA PARA PRORROGA')                                                                                                                                                                                                                                
insert into cobis..cl_ttransaccion values (7235,       'QUERY  DE CUOTA PARA PRORROGA',                                    '7235',   'QUERY  DE CUOTA PARA PRORROGA')                                                                                                                                                                                                                                
insert into cobis..cl_ttransaccion values (7236,       'SEARCH DE CUOTA PARA PRORROGA',                                    '7236',   'SEARCH DE CUOTA PARA PRORROGA')                                                                                                                                                                                                                                
insert into cobis..cl_ttransaccion values (7237,       'RESTAURAR LOS DATOS DE UNA OPERACION',                             '7237',   'RESTAURAR LOS DATOS DE UNA OPERACION')                                                                                                                                                                                                                         
insert into cobis..cl_ttransaccion values (7238,       'RESPALDAR LOS DATOS DE UNA OPERACION',                             '7238',   'RESPALDAR LOS DATOS DE UNA OPERACION')                                                                                                                                                                                                                         
insert into cobis..cl_ttransaccion values (7239,       'EJECUCION DEL BATCH DE UNA OPERACION',                             '7239',   'EJECUCION DEL BATCH DE UNA OPERACION')                                                                                                                                                                                                                         
insert into cobis..cl_ttransaccion values (7240,       'CREACION RAPITA DE OPERACIONES DE CARTERA',                        '7240',   'CREACION RAPITA DE OPERACIONES DE CARTERA')                                                                                                                                                                                                                    
insert into cobis..cl_ttransaccion values (7241,       'CONSULTA DE DATOS DE UNA TABLA',                                   '7241',   'CONSULTA DE DATOS DE UNA TABLA')                                                                                                                                                                                                                               
insert into cobis..cl_ttransaccion values (7242,       'CARGAR INFORMACION DE PAGOS MASIVOS POR LOTES',                    '7242',   'CARGAR INFORMACION DE PAGOS MASIVOS POR LOTES')                                                                                                                                                                                                                
insert into cobis..cl_ttransaccion values (7243,       'MANEJO DE OPERACIONES INDIVIDUALES EN ABONO MASIVO',               '7243',   'MANEJO DE OPERACIONES INDIVIDUALES EN ABONO MASIVO')                                                                                                                                                                                                           
insert into cobis..cl_ttransaccion values (7244,       'IMPRESION DE ABONOS MASIVOS',                                      '7244',   'IMPRESION DE ABONOS MASIVOS')                                                                                                                                                                                                                                  
insert into cobis..cl_ttransaccion values (7245,       'INSERCION DE RUBROS CCA CRE',                                      '7245',   'INSERCION DE RUBROS CCA CRE')                                                                                                                                                                                                                                  
insert into cobis..cl_ttransaccion values (7246,       'ACTUALIZACION DE RUBROS CCA CRE',                                  '7246',   'ACTUALIZACION DE RUBROS CCA CRE')                                                                                                                                                                                                                              
insert into cobis..cl_ttransaccion values (7247,       'BUSQUEDA GENERAL DE RUBROS CCA CRE',                               '7247',   'BUSQUEDA GENERAL DE RUBROS CCA CRE')                                                                                                                                                                                                                           
insert into cobis..cl_ttransaccion values (7248,       'ELIMINACION DE RUBROS CCA CRE',                                    '7248',   'ELIMINACION DE RUBROS CCA CRE')                                                                                                                                                                                                                                
insert into cobis..cl_ttransaccion values (7249,       'BUSQUEDA DE UN REGISTRO RUBROS CCA CRE',                           '7249',   'BUSQUEDA DE UN REGISTRO RUBROS CCA CRE')                                                                                                                                                                                                                       
insert into cobis..cl_ttransaccion values (7250,       'CONSULTA DE OP. PASIVAS VENCIDAS',                                 '7250',   'CONSULTA DE OP. PASIVAS VENCIDAS')                                                                                                                                                                                                                             
insert into cobis..cl_ttransaccion values (7251,       'ACTUALIZACION LLAVE REDESCUENTO',                                  '7251',   'ACTUALIZACION LLAVE REDESCUENTO')                                                                                                                                                                                                                              
insert into cobis..cl_ttransaccion values (7252,       'CONSULTAR DATOS DEL MAESTRO',                                      '7252',   'CONSULTAR DATOS DEL MAESTRO')                                                                                                                                                                                                                                  
insert into cobis..cl_ttransaccion values (7253,       'INSERCION DE LOS CODIGOS PREPAGO',                                 '7253',   'INSERCION DE LOS CODIGOS PREPAGO')                                                                                                                                                                                                                             
insert into cobis..cl_ttransaccion values (7254,       'ACTUALIZACION DE LOS CODIGOS PREPAGO',                             '7254',   'ACTUALIZACION DE LOS CODIGOS PREPAGO')                                                                                                                                                                                                                         
insert into cobis..cl_ttransaccion values (7255,       'BUSQUEDA DE LOS CODIGOS PREPAGO',                                  '7255',   'BUSQUEDA DE LOS CODIGOS PREPAGO')                                                                                                                                                                                                                              
insert into cobis..cl_ttransaccion values (7256,       'CONSULTA DE LOS CODIGOS PREPAGO OPERACION Q',                      '7256',   'CONSULTA DE LOS CODIGOS PREPAGO OPERACION Q')                                                                                                                                                                                                                  
insert into cobis..cl_ttransaccion values (7257,       'CONSULTA DE LOS CODIGOS PREPAGO OPERACION V',                      '7257',   'CONSULTA DE LOS CODIGOS PREPAGO OPERACION V')                                                                                                                                                                                                                  
insert into cobis..cl_ttransaccion values (7258,       'CONSULTA DE LOS CODIGOS PREPAGO OPERACION H',                      '7258',   'CONSULTA DE LOS CODIGOS PREPAGO OPERACION H')                                                                                                                                                                                                                  
insert into cobis..cl_ttransaccion values (7259,       'CONSULTA PREPAGOS PASIVAS',                                        '7259',   'CONSULTA PREPAGOS PASIVAS')                                                                                                                                                                                                                                    
insert into cobis..cl_ttransaccion values (7260,       'INSERCION OTRAS TASAS',                                            '7260',   'INSERCION OTRAS TASAS')                                                                                                                                                                                                                                        
insert into cobis..cl_ttransaccion values (7261,       'ACTUALIZACION DEL REGISTRO  OTRAS TASAS',                          '7261',   'ACTUALIZACION DEL REGISTRO  OTRAS TASAS')                                                                                                                                                                                                                      
insert into cobis..cl_ttransaccion values (7262,       'ELIMINACION DEL REGISTRO DE  OTRAS TASAS',                         '7262',   'ELIMINACION DEL REGISTRO DE  OTRAS TASAS')                                                                                                                                                                                                                     
insert into cobis..cl_ttransaccion values (7263,       'BUSQUEDA DE LOS REGISTROS DE OTRAS TASAS',                         '7263',   'BUSQUEDA DE LOS REGISTROS DE OTRAS TASAS')                                                                                                                                                                                                                     
insert into cobis..cl_ttransaccion values (7264,       'CONSULTA DE UN REGISTROS DE OTRAS TASAS',                          '7264',   'CONSULTA DE UN REGISTROS DE OTRAS TASAS')                                                                                                                                                                                                                      
insert into cobis..cl_ttransaccion values (7265,       'AYUDA EN LOS REGISTROS DE OTRAS TASAS',                            '7265',   'AYUDA EN LOS REGISTROS DE OTRAS TASAS')                                                                                                                                                                                                                        
insert into cobis..cl_ttransaccion values (7266,       'MANTENIMIENTO PREPAGOS PASIVAS',                                   '7266',   'MANTENIMIENTO PREPAGOS PASIVAS')                                                                                                                                                                                                                               
insert into cobis..cl_ttransaccion values (7267,       'ENVIO DATOS DEL EXTRACTO',                                         '7267',   'ENVIO DATOS DEL EXTRACTO')                                                                                                                                                                                                                                     
insert into cobis..cl_ttransaccion values (7268,       'GENERA EXTRACTO EN LINEA',                                         '7268',   'GENERA EXTRACTO EN LINEA')                                                                                                                                                                                                                                     
insert into cobis..cl_ttransaccion values (7269,       'CARGAR PAGOS MASIVOS GENERALES',                                   '7269',   'CARGAR PAGOS MASIVOS GENERALES')                                                                                                                                                                                                                               
insert into cobis..cl_ttransaccion values (7270,       'GENERA TABLA AMORTIZACION PROYECTADA',                             '7270',   'GENERA TABLA AMORTIZACION PROYECTADA')                                                                                                                                                                                                                         
insert into cobis..cl_ttransaccion values (7271,       'CARGAR REGISTRO CABECERA',                                         '7271',   'CARGAR REGISTRO CABECERA')                                                                                                                                                                                                                                     
insert into cobis..cl_ttransaccion values (7272,       'CONSULTA DEL CLIENTE EN CARTERA',                                  '7272',   'CONSULTA DEL CLIENTE EN CARTERA')                                                                                                                                                                                                                              
insert into cobis..cl_ttransaccion values (7273,       'Cambio de Nota en la operacion del cliente',                       '7273',   'Cambio de Nota en la operacion del cliente')                                                                                                                                                                                                                   
insert into cobis..cl_ttransaccion values (7275,       'CREACION DEL NUMERO DEL PAGARE',                                   '7275',   'CREACION DEL NUMERO DEL PAGARE')
insert into cobis..cl_ttransaccion values (7276,       'VALIDACION DEL PORCENTAJE DE CONDONACIONES',                       '7276',   'VALIDACION DEL PORCENTAJE DE CONDONACIONES')
insert into cobis..cl_ttransaccion values (7278,       'CONSULTA DE CONTROL DIARIO DE CARTERA',                            '7278',   'CONSULTA DE CONTROL DIARIO DE CARTERA')
insert into cobis..cl_ttransaccion values (7279,       'CONTRATO DE APERTURA DE CREDITO SIMPLE',                           '7279',   'CONTRATO DE APERTURA DE CREDITO SIMPLE')
insert into cobis..cl_ttransaccion values (7280,       'IMPRESION CERTIFICADO DE INTERESES PAGADOS',                       '7280',   'IMPRESION CERTIFICADO DE INTERESES PAGADOS') 
insert into cobis..cl_ttransaccion values (7281,       'Pago Grupal',                                                      '7281',   'Pago Grupal')
insert into cobis..cl_ttransaccion values (7282,       'Manejo de Fondos',                                                 '7282',   'Manejo de Fondos')
insert into cobis..cl_ttransaccion values (7283,       'Consulta de datos del trámite',                                    '7283',   'Consulta de datos del trámite')
insert into cobis..cl_ttransaccion values (7284,       'Envio de correo de Garantia Liquida',                              '7284',   'Envio de correo de Garantia Liquida')
insert into cobis..cl_ttransaccion values (7285,       'Consulta de Datos del Correo',                                     '7285',   'Envio de correo de Garantia Liquida')
insert into cobis..cl_ttransaccion values (7286,       'Consulta de datos del trámite',                                    '7286',   'Consulta de datos del trámite')
insert into cobis..cl_ttransaccion values (7298,       'NORMALIZACION DE CARTERA',                                         '7298',   'Consulta de Datos del Correo') 
insert into cobis..cl_ttransaccion values (7291,       'Establece Tabla de amortizacion FLEXIBLE',                         '7291',   'Establece Tabla de amortizacion FLEXIBLE') 
insert into cobis..cl_ttransaccion values (7301,       'LOG DE PAGOS ORDENES DEBITO',                                      '7301',   'Consulta de log de pagos')
insert into cobis..cl_ttransaccion values (7305,       'IMPRESION PAGARE FINAGRO',                                         'PAGFAG', 'IMPRESION DE PAGARES FINAGRO') 
insert into cobis..cl_ttransaccion values (7306,       'REGLA PARA PORCENTAJE DE CONDONACIONES',                           '7306',   'REGLA PARA PORCENTAJE DE CONDONACIONES')
insert into cobis..cl_ttransaccion values (7400,       'BUSQUEDA CLASE.TIPO GARANTIA.EDAD',                                '7400',   'BUSQUEDA CLASE.TIPO GARANTIA.EDAD')                                                                                                                                                                                                                            
go

delete cobis..cl_ttransaccion
 where tn_trn_code in(7401,7402,7403,7404,7405,7406,7407,7408,7409,7410,7411,7412,7413,7414,7415,7416,7417,7418,7419,7420,7421,
                      7422,7423,7424,7425,7426,7427,7428,7429,7430,7431,7432,7433,7434,7435,7436,7437,7438,7439,7440,7441,7442,
                      7445,7460,7461,7462,7463,7464,7465,7466,7500,7501,7502,7503,7504,7505,7506,7507,7508,7509,7510,7511,7512,
                      7513,7514,7515,7516,7517,7518,7519,7520,7521,7522,7523,7524,7525,7526,7527,7528,7529,7530,7531,7532,7533,
                      7534,7535,7536,7537,7538,7539,7540,7541,7542,7543,7544,7545,7546,7547,7548,7549,7550,7551,7552,7553,7554,
                      7555,7556,7557,7558,7559,7560,7561,7562,7563,7564,7565,7566,7567,7568,7569,7570,7571,7572,7573,7574,7575,
                      7576,7577,7578,7579,7580,7581,7582,7583,7584,7585,7586,7587,7588,7589,7590,7591,7592,7593,7594,7595,7596,
                      7597,7598,7599,7600,714500)
go

insert into cobis..cl_ttransaccion values (7401,       'BUSQUEDA ENTIDAD PRESTAMISTA PROGRAMA',                            '7401',   'BUSQUEDA ENTIDAD PRESTAMISTA PROGRAMA')                                                                                                                                                                                                                        
insert into cobis..cl_ttransaccion values (7402,       'BUSQUEDA MONEDA',                                                  '7402',   'BUSQUEDA MONEDA')                                                                                                                                                                                                                                              
insert into cobis..cl_ttransaccion values (7403,       'BUSQUEDA ENTIDAD PRESTAMISTA',                                     '7403',   'BUSQUEDA ENTIDAD PRESTAMISTA')                                                                                                                                                                                                                                 
insert into cobis..cl_ttransaccion values (7404,       'BUSQUEDA ORIGEN DE LOS RECURSOS (OR,OR-GYC, OR-IA, OR-IO )',       '7404',   'BUSQUEDA ORIGEN DE LOS RECURSOS (OR,OR-GYC, OR-IA, OR-IO )')                                                                                                                                                                                                   
insert into cobis..cl_ttransaccion values (7405,       'BUSQUEDA PROGRAMA CARTERA PASIVA FINAGRO',                         '7405',   'BUSQUEDA PROGRAMA CARTERA PASIVA FINAGRO')                                                                                                                                                                                                                     
insert into cobis..cl_ttransaccion values (7406,       'BUSQUEDA RIESGO CLASE DE CARTERA',                                 '7406',   'BUSQUEDA RIESGO CLASE DE CARTERA')                                                                                                                                                                                                                             
insert into cobis..cl_ttransaccion values (7407,       'BUSQUEDA RIESGO TIPO GARANTIA CLASE CARTERA',                      '7407',   'BUSQUEDA RIESGO TIPO GARANTIA CLASE CARTERA')                                                                                                                                                                                                                  
insert into cobis..cl_ttransaccion values (7408,       'BUSQUEDA CLASE DE CARTERA',                                        '7408',   'BUSQUEDA CLASE DE CARTERA')                                                                                                                                                                                                                                    
insert into cobis..cl_ttransaccion values (7409,       'BUSQUEDA INT-IMO ORIGEN RECURSOS',                                 '7409',   'BUSQUEDA INT-IMO ORIGEN RECURSOS')                                                                                                                                                                                                                             
insert into cobis..cl_ttransaccion values (7410,       'BUSQUEDA MONEDA.TIPO GARANTIA.EDAD',                               '7410',   'BUSQUEDA MONEDA.TIPO GARANTIA.EDAD')                                                                                                                                                                                                                           
insert into cobis..cl_ttransaccion values (7411,       'BUSQUEDA RUBROS DE CARTERA (RU,RU-CxP,RU-OA,RU-OCxP)',             '7411',   'BUSQUEDA RUBROS DE CARTERA (RU,RU-CxP,RU-OA,RU-OCxP)')                                                                                                                                                                                                         
insert into cobis..cl_ttransaccion values (7412,       'BUSQUEDA CLASE CARTERA RIESGO GARANTIA',                           '7412',   'BUSQUEDA CLASE CARTERA RIESGO GARANTIA')                                                                                                                                                                                                                       
insert into cobis..cl_ttransaccion values (7413,       'BUSQUEDA PARAMETRO CON (CONCEPTO)',                                '7413',   'BUSQUEDA PARAMETRO CON (CONCEPTO)')                                                                                                                                                                                                                            
insert into cobis..cl_ttransaccion values (7414,       'BUSQUEDA CLASE CARTERA RIESGO',                                    '7414',   'BUSQUEDA CLASE CARTERA RIESGO')                                                                                                                                                                                                                                
insert into cobis..cl_ttransaccion values (7415,       'BUSQUEDA PARAMETRO CMO (CLASE Y MONEDA)',                          '7415',   'BUSQUEDA PARAMETRO CMO (CLASE Y MONEDA)')                                                                                                                                                                                                                      
insert into cobis..cl_ttransaccion values (7416,       'BUSQUEDA PARAMETROS (RCE,RCI,RCL)',                                '7416',   'BUSQUEDA PARAMETROS (RCE,RCI,RCL)')                                                                                                                                                                                                                            
insert into cobis..cl_ttransaccion values (7417,       'BUSQUEDA PARAMETRO CCI  CLASE CATEGORIA',                          '7417',   'BUSQUEDA PARAMETRO CCI  CLASE CATEGORIA')                                                                                                                                                                                                                      
insert into cobis..cl_ttransaccion values (7418,       'BUSQUEDA ENTIDAD PRESTAMISTA ORIGEN DE RECURSOS',                  '7418',   'BUSQUEDA ENTIDAD PRESTAMISTA ORIGEN DE RECURSOS')                                                                                                                                                                                                              
insert into cobis..cl_ttransaccion values (7419,       'BUSQUEDA PARAMETRO TGA  TIPO GARANTIA',                            '7419',   'BUSQUEDA PARAMETRO TGA  TIPO GARANTIA')                                                                                                                                                                                                                        
insert into cobis..cl_ttransaccion values (7420,       'BUSQUEDA PARAMETRO CES  CLASE ESTADO',                             '7420',   'BUSQUEDA PARAMETRO CES  CLASE ESTADO')                                                                                                                                                                                                                         
insert into cobis..cl_ttransaccion values (7421,       'BUSQUEDA PARAMETRO CL_OR_IA',                                      '7421',   'BUSQUEDA PARAMETRO CL_OR_IA')                                                                                                                                                                                                                                  
insert into cobis..cl_ttransaccion values (7422,       'BUSQUEDA PARAMETRO CL_OR_IO',                                      '7422',   'BUSQUEDA PARAMETRO CL_OR_IO')                                                                                                                                                                                                                                  
insert into cobis..cl_ttransaccion values (7423,       'BUSQUEDA PARAMETRO RU_CXP',                                        '7423',   'BUSQUEDA PARAMETRO RU_CXP')                                                                                                                                                                                                                                    
insert into cobis..cl_ttransaccion values (7424,       'BUSQUEDA PARAMETRO RU_OCXP',                                       '7424',   'BUSQUEDA PARAMETRO RU_OCXP')                                                                                                                                                                                                                                   
insert into cobis..cl_ttransaccion values (7425,       'BUSQUEDA PARAMETRO EP_OA',                                         '7425',   'BUSQUEDA PARAMETRO EP_OA')                                                                                                                                                                                                                                     
insert into cobis..cl_ttransaccion values (7426,       'BUSQUEDA PARAMETRO RU_CXPT',                                       '7426',   'BUSQUEDA PARAMETRO RU_CXPT')                                                                                                                                                                                                                                   
insert into cobis..cl_ttransaccion values (7427,       'BUSQUEDA PARAMETRO EP_IA',                                         '7427',   'BUSQUEDA PARAMETRO EP_IA')                                                                                                                                                                                                                                     
insert into cobis..cl_ttransaccion values (7428,       'BUSQUEDA PARAMETRO CL_CC',                                         '7428',   'BUSQUEDA PARAMETRO CL_CC')                                                                                                                                                                                                                                     
insert into cobis..cl_ttransaccion values (7429,       'BUSQUEDA PARAMETRO RU_CC',                                         '7429',   'BUSQUEDA PARAMETRO RU_CC')                                                                                                                                                                                                                                     
insert into cobis..cl_ttransaccion values (7430,       'PARAMETROS PARA MONEDA CLASE',                                     '7430',   'PARAMETROS PARA MONEDA CLASE')                                                                                                                                                                                                                                 
insert into cobis..cl_ttransaccion values (7431,       'COMBINACION PARA DEVINT',                                          '7431',   'COMBINACION PARA DEVINT')                                                                                                                                                                                                                                      
insert into cobis..cl_ttransaccion values (7432,       'COMBINACION PARA DEVINT',                                          '7432',   'COMBINACION PARA DEVINT')                                                                                                                                                                                                                                      
insert into cobis..cl_ttransaccion values (7433,       'IMPRESION MASIVA DE f127 PREPAGOS PASIVAS',                        '7433',   'IMPRESION MASIVA DE f127 PREPAGOS PASIVAS')                                                                                                                                                                                                                    
insert into cobis..cl_ttransaccion values (7434,       'CONSULTAS PREPAGOS PASIVAS',                                       '7434',   'CONSULTAS PREPAGOS PASIVAS')                                                                                                                                                                                                                                   
insert into cobis..cl_ttransaccion values (7435,       'CARGAR CARTIGOS MASIVOS',                                          '7435',   'CARGAR CARTIGOS MASIVOS')                                                                                                                                                                                                                                      
insert into cobis..cl_ttransaccion values (7436,       'DATOS DE LOS AVISOS POR REAJUSTE MASIVO',                          '7436',   'DATOS DE LOS AVISOS POR REAJUSTE MASIVO')                                                                                                                                                                                                                      
insert into cobis..cl_ttransaccion values (7437,       'DEVOLUCION DE COMISIONES',                                         '7437',   'DEVOLUCION DE COMISIONES')                                                                                                                                                                                                                                     
insert into cobis..cl_ttransaccion values (7438,       'RESUMEN MOVIMIENTOS DIARIOS REDESCUENTO',                          '7438',   'RESUMEN MOVIMIENTOS DIARIOS REDESCUENTO')                                                                                                                                                                                                                      
insert into cobis..cl_ttransaccion values (7439,       'MENSAJES PARA FACTURACION PERIODICA',                              '7439',   'MENSAJES PARA FACTURACION PERIODICA')                                                                                                                                                                                                                          
insert into cobis..cl_ttransaccion values (7440,       'EJECUTAR TRASLADO DE INTERESES',                                   '7440',   'EJECUTAR TRASLADO DE INTERESES')                                                                                                                                                                                                                               
insert into cobis..cl_ttransaccion values (7441,       'FECHA VALOR MASIVO',                                               '7441',   'FECHA VALOR MASIVO')                                                                                                                                                                                                                                           
insert into cobis..cl_ttransaccion values (7442,       'DIVISION DE LA CARTERA EN DOS TIPOS CASTIGADA Y ACTIVA',           '7442',   'DIVISION DE LA CARTERA EN DOS TIPOS CASTIGADA Y ACTIVA')                                                                                                                                                                                                       
insert into cobis..cl_ttransaccion values (7445,       'Da mantenimiento a la tabla ca_rubro_planificador',                '7445',   'Da mantenimiento a la tabla ca_rubro_planificador')                                                                                                                                                                                                            
insert into cobis..cl_ttransaccion values (7460,       'ELIMINA O ADICIONA UN CODEUDOR CUANDO LA OBLIGACION ESTA EN ESTA', '7460',   'ELIMINA O ADICIONA UN CODEUDOR CUANDO LA OBLIGACION ESTA EN ESTADO VIGENTE')                                                                                                                                                                                   
insert into cobis..cl_ttransaccion values (7461,       'CONSULTA DE FUENTES DE RECURSO',                                   '7461',   'CONSULTA DE FUENTES DE RECURSOS')                                                                                                                                                                                                                              
insert into cobis..cl_ttransaccion values (7462,       'TABLAS DIMENSIONALES',                                             '7462',   'TABLAS DIMENSIONALES')                                                                                                                                                                                                                                         
insert into cobis..cl_ttransaccion values (7463,       'EJES DIMENSIONALES',                                               '7463',   'EJES DIMENSIONALES')                                                                                                                                                                                                                                           
insert into cobis..cl_ttransaccion values (7464,       'EJES - RANGOS DIMENSIONALES',                                      '7464',   'EJES - RANGOS DIMENSIONALES')                                                                                                                                                                                                                                  
insert into cobis..cl_ttransaccion values (7465,       'VALORES MATRIZ DIMENSIONALES',                                     '7465',   'VALORES MATRIZ DIMENSIONALES')                                                                                                                                                                                                                                 
insert into cobis..cl_ttransaccion values (7466,       'REESTRUCTURACIONES EXTERNAS',                                      '7466',   'REESTRUCTURACIONES EXTERNAS') 
insert into cobis..cl_ttransaccion values (7500,       'Operaciones',                                                      '7500',   'Operaciones')                                                                                                                                                                                                                                                  
insert into cobis..cl_ttransaccion values (7501,       'Operaciones/Creacion',                                             '7501',   'Operaciones/Creacion')                                                                                                                                                                                                                                         
insert into cobis..cl_ttransaccion values (7502,       'Operaciones/Creacion/Rubros',                                      '7502',   'Operaciones/Creacion/Rubros')                                                                                                                                                                                                                                  
insert into cobis..cl_ttransaccion values (7503,       'Operaciones/Creacion/Rubros/Buscar',                               '7503',   'Operaciones/Creacion/Rubros/Buscar')                                                                                                                                                                                                                           
insert into cobis..cl_ttransaccion values (7504,       'Operaciones/Creacion/Rubros/Modificar',                            '7504',   'Operaciones/Creacion/Rubros/Modificar')                                                                                                                                                                                                                        
insert into cobis..cl_ttransaccion values (7505,       'Operaciones/Creacion/Rubros/Eliminar',                             '7505',   'Operaciones/Creacion/Rubros/Eliminar')                                                                                                                                                                                                                         
insert into cobis..cl_ttransaccion values (7506,       'Operaciones/Creacion/Rubros/Aceptar',                              '7506',   'Operaciones/Creacion/Rubros/Aceptar')                                                                                                                                                                                                                          
insert into cobis..cl_ttransaccion values (7507,       'Operaciones/Creacion/Rubros/Transmitir',                           '7507',   'Operaciones/Creacion/Rubros/Transmitir')                                                                                                                                                                                                                       
insert into cobis..cl_ttransaccion values (7508,       'Operaciones/Creacion/Parametros',                                  '7508',   'Operaciones/Creacion/Parametros')                                                                                                                                                                                                                              
insert into cobis..cl_ttransaccion values (7509,       'Operaciones/Creacion/Parametros/Transmitir',                       '7509',   'Operaciones/Creacion/Parametros/Transmitir')                                                                                                                                                                                                                   
insert into cobis..cl_ttransaccion values (7510,       'Operaciones/Creacion/Amortizacion',                                '7510',   'Operaciones/Creacion/Amortizacion')                                                                                                                                                                                                                            
insert into cobis..cl_ttransaccion values (7511,       'Operaciones/Creacion/Amortizacion/Calcular',                       '7511',   'Operaciones/Creacion/Amortizacion/Calcular')                                                                                                                                                                                                                   
insert into cobis..cl_ttransaccion values (7512,       'Operaciones/Creacion/Amortizacion/Adicionales',                    '7512',   'Operaciones/Creacion/Amortizacion/Adicionales')                                                                                                                                                                                                                
insert into cobis..cl_ttransaccion values (7513,       'Operaciones/Creacion/Amortizacion/Adicionales/Transmitir',         '7513',   'Operaciones/Creacion/Amortizacion/Adicionales/Transmitir')                                                                                                                                                                                                     
insert into cobis..cl_ttransaccion values (7514,       'Operaciones/Creacion/Amortizacion/Insertar',                       '7514',   'Operaciones/Creacion/Amortizacion/Insertar')                                                                                                                                                                                                                   
insert into cobis..cl_ttransaccion values (7515,       'Operaciones/Creacion/Amortizacion/Eliminar',                       '7515',   'Operaciones/Creacion/Amortizacion/Eliminar')                                                                                                                                                                                                                   
insert into cobis..cl_ttransaccion values (7516,       'Operaciones/Creacion/Amortizacion/Transmitir',                     '7516',   'Operaciones/Creacion/Amortizacion/Transmitir')                                                                                                                                                                                                                 
insert into cobis..cl_ttransaccion values (7517,       'Operaciones/Creacion/Imprimir',                                    '7517',   'Operaciones/Creacion/Imprimir')                                                                                                                                                                                                                                
insert into cobis..cl_ttransaccion values (7518,       'Operaciones/Creacion/Crear',                                       '7518',   'Operaciones/Creacion/Crear')                                                                                                                                                                                                                                   
insert into cobis..cl_ttransaccion values (7519,       'Operaciones/Creacion/Actualizar',                                  '7519',   'Operaciones/Creacion/Actualizar')                                                                                                                                                                                                                              
insert into cobis..cl_ttransaccion values (7520,       'Operaciones/Creacion/Transmitir',                                  '7520',   'Operaciones/Creacion/Transmitir')                                                                                                                                                                                                                              
insert into cobis..cl_ttransaccion values (7521,       'Operaciones/Actualizacion',                                        '7521',   'Operaciones/Actualizacion')                                                                                                                                                                                                                                    
insert into cobis..cl_ttransaccion values (7522,       'Operaciones/Actualizacion/Buscar',                                 '7522',   'Operaciones/Actualizacion/Buscar')                                                                                                                                                                                                                             
insert into cobis..cl_ttransaccion values (7523,       'Operaciones/Actualizacion/Siguiente',                              '7523',   'Operaciones/Actualizacion/Siguiente')                                                                                                                                                                                                                          
insert into cobis..cl_ttransaccion values (7524,       'Operaciones/Actualizacion/Escoger',                                '7524',   'Operaciones/Actualizacion/Escoger')                                                                                                                                                                                                                            
insert into cobis..cl_ttransaccion values (7525,       'Operaciones/Actualizacion/Escoger/Rubros',                         '7525',   'Operaciones/Actualizacion/Escoger/Rubros')                                                                                                                                                                                                                     
insert into cobis..cl_ttransaccion values (7526,       'Operaciones/Actualizacion/Escoger/Rubros/Buscar',                  '7526',   'Operaciones/Actualizacion/Escoger/Rubros/Buscar')                                                                                                                                                                                                              
insert into cobis..cl_ttransaccion values (7527,       'Operaciones/Actualizacion/Escoger/Rubros/Modificar',               '7527',   'Operaciones/Actualizacion/Escoger/Rubros/Modificar')                                                                                                                                                                                                           
insert into cobis..cl_ttransaccion values (7528,       'Operaciones/Actualizacion/Escoger/Rubros/Eliminar',                '7528',   'Operaciones/Actualizacion/Escoger/Rubros/Eliminar')                                                                                                                                                                                                            
insert into cobis..cl_ttransaccion values (7529,       'Operaciones/Actualizacion/Escoger/Rubros/Aceptar',                 '7529',   'Operaciones/Actualizacion/Escoger/Rubros/Aceptar')                                                                                                                                                                                                             
insert into cobis..cl_ttransaccion values (7530,       'Operaciones/Actualizacion/Escoger/Rubros/Transmitir',              '7530',   'Operaciones/Actualizacion/Escoger/Rubros/Transmitir')                                                                                                                                                                                                          
insert into cobis..cl_ttransaccion values (7531,       'Operaciones/Actualizacion/Escoger/Parametros',                     '7531',   'Operaciones/Actualizacion/Escoger/Parametros')                                                                                                                                                                                                                 
insert into cobis..cl_ttransaccion values (7532,       'Operaciones/Actualizacion/Escoger/Parametros/Transmitir',          '7532',   'Operaciones/Actualizacion/Escoger/Parametros/Transmitir')                                                                                                                                                                                                      
insert into cobis..cl_ttransaccion values (7533,       'Operaciones/Actualizacion/Escoger/Amortizacion',                   '7533',   'Operaciones/Actualizacion/Escoger/Amortizacion')                                                                                                                                                                                                               
insert into cobis..cl_ttransaccion values (7534,       'Operaciones/Actualizacion/Escoger /Amortizacion/Calcular',         '7534',   'Operaciones/Actualizacion/Escoger /Amortizacion/Calcular')                                                                                                                                                                                                     
insert into cobis..cl_ttransaccion values (7535,       'Operaciones/Actualizacion/Escoger /Amortizacion/Adicionales',      '7535',   'Operaciones/Actualizacion/Escoger /Amortizacion/Adicionales')                                                                                                                                                                                                  
insert into cobis..cl_ttransaccion values (7536,       'Operaciones/Actualizacion/Escoger/Amortizacion/Adicionales/Trans', '7536',   'Operaciones/Actualizacion/Escoger/Amortizacion/Adicionales/Transmitir')                                                                                                                                                                                        
insert into cobis..cl_ttransaccion values (7537,       'Operaciones/Actualizacion/Escoger/Amortizacion/Insertar',          '7537',   'Operaciones/Actualizacion/Escoger/Amortizacion/Insertar')                                                                                                                                                                                                      
insert into cobis..cl_ttransaccion values (7538,       'Operaciones/Actualizacion/Escoger/Amortizacion/Eliminar',          '7538',   'Operaciones/Actualizacion/Escoger/Amortizacion/Eliminar')                                                                                                                                                                                                      
insert into cobis..cl_ttransaccion values (7539,       'Operaciones/Actualizacion/Escoger/Amortizacion/Transmitir',        '7539',   'Operaciones/Actualizacion/Escoger/Amortizacion/Transmitir')                                                                                                                                                                                                    
insert into cobis..cl_ttransaccion values (7540,       'Operaciones/Actualizacion/Escoger/Imprimir',                       '7540',   'Operaciones/Actualizacion/Escoger/Imprimir')                                                                                                                                                                                                                   
insert into cobis..cl_ttransaccion values (7541,       'Operaciones/Actualizacion/Escoger/Crear',                          '7541',   'Operaciones/Actualizacion/Escoger/Crear')                                                                                                                                                                                                                      
insert into cobis..cl_ttransaccion values (7542,       'Operaciones/Actualizacion/Escoger/Actualizar',                     '7542',   'Operaciones/Actualizacion/Escoger/Actualizar')                                                                                                                                                                                                                 
insert into cobis..cl_ttransaccion values (7543,       'Operaciones/Actualizacion/Escoger/Transmitir',                     '7543',   'Operaciones/Actualizacion/Escoger/Transmitir')                                                                                                                                                                                                                 
insert into cobis..cl_ttransaccion values (7544,       'Operaciones/Actualizacion/Escoger/Asociar',                        '7544',   'Operaciones/Actualizacion/Escoger/Asociar')                                                                                                                                                                                                                    
insert into cobis..cl_ttransaccion values (7545,       'Operaciones/Desembolso de Operaciones',                            '7545',   'Operaciones/Desembolso de Operaciones')                                                                                                                                                                                                                        
insert into cobis..cl_ttransaccion values (7546,       'Operaciones/Desembolso de Operaciones/Buscar',                     '7546',   'Operaciones/Desembolso de Operaciones/Buscar')                                                                                                                                                                                                                 
insert into cobis..cl_ttransaccion values (7547,       'Operaciones/Desembolso de Operaciones/Siguiente',                  '7547',   'Operaciones/Desembolso de Operaciones/Siguiente')                                                                                                                                                                                                              
insert into cobis..cl_ttransaccion values (7548,       'Operaciones/Desembolso de Operaciones/Escoger',                    '7548',   'Operaciones/Desembolso de Operaciones/Escoger')                                                                                                                                                                                                                
insert into cobis..cl_ttransaccion values (7549,       'Operaciones/Desembolso de Operaciones/Escoger/Buscar',             '7549',   'Operaciones/Desembolso de Operaciones/Escoger/Buscar')                                                                                                                                                                                                         
insert into cobis..cl_ttransaccion values (7550,       'Operaciones/Desembolso de Operaciones/Escoger/Crear',              '7550',   'Operaciones/Desembolso de Operaciones/Escoger/Crear')                                                                                                                                                                                                          
insert into cobis..cl_ttransaccion values (7551,       'Operaciones/Desembolso de Operaciones/Escoger/Eliminar',           '7551',   'Operaciones/Desembolso de Operaciones/Escoger/Eliminar')                                                                                                                                                                                                       
insert into cobis..cl_ttransaccion values (7552,       'Operaciones/Desembolso de Operaciones/Escoger/Imprimir',           '7552',   'Operaciones/Desembolso de Operaciones/Escoger/Imprimir')                                                                                                                                                                                                       
insert into cobis..cl_ttransaccion values (7553,       'Operaciones/Desembolso de Operaciones/Escoger/Transmitir',         '7553',   'Operaciones/Desembolso de Operaciones/Escoger/Transmitir')                                                                                                                                                                                                     
insert into cobis..cl_ttransaccion values (7554,       'Operaciones/(Pagos/Cancelaciones/Precancelaciones)',               '7554',   'Operaciones/(Pagos/Cancelaciones/Precancelaciones)')                                                                                                                                                                                                           
insert into cobis..cl_ttransaccion values (7555,       'Operaciones/(Pagos/Cancelaciones/Precancelaciones)/Buscar',        '7555',   'Operaciones/(Pagos/Cancelaciones/Precancelaciones)/Buscar')                                                                                                                                                                                                    
insert into cobis..cl_ttransaccion values (7556,       'Operaciones/(Pagos/Cancelaciones/Precancelaciones)/Siguiente',     '7556',   'Operaciones/(Pagos/Cancelaciones/Precancelaciones)/Siguiente')                                                                                                                                                                                                 
insert into cobis..cl_ttransaccion values (7557,       'Operaciones/(Pagos/Cancelaciones/Precancelaciones)/Escoger',       '7557',   'Operaciones/(Pagos/Cancelaciones/Precancelaciones)/Escoger')                                                                                                                                                                                                   
insert into cobis..cl_ttransaccion values (7558,       'Operaciones/(Pagos/Cancelaciones/Precancelaciones)/Escoger/Trans', '7558',   'Operaciones/(Pagos/Cancelaciones/Precancelaciones)/Escoger/Transmitir')                                                                                                                                                                                        
insert into cobis..cl_ttransaccion values (7559,       'Operaciones/(Pagos/Cancelaciones/Precancelaciones)/Escoger/Impri', '7559',   'Operaciones/(Pagos/Cancelaciones/Precancelaciones)/Escoger/Imprimir')                                                                                                                                                                                          
insert into cobis..cl_ttransaccion values (7560,       'Operaciones/(Pagos/Cancelaciones/Precancelaciones)/Escoger/Detal', '7560',   'Operaciones/(Pagos/Cancelaciones/Precancelaciones)/Escoger/Detalle')                                                                                                                                                                                           
insert into cobis..cl_ttransaccion values (7561,       'Operaciones/Reajustes por Operacion',                              '7561',   'Operaciones/Reajustes por Operacion')                                                                                                                                                                                                                          
insert into cobis..cl_ttransaccion values (7562,       'Operaciones/Reajustes por Operacion/Buscar',                       '7562',   'Operaciones/Reajustes por Operacion/Buscar')                                                                                                                                                                                                                   
insert into cobis..cl_ttransaccion values (7563,       'Operaciones/Reajustes por Operacion/Siguiente',                    '7563',   'Operaciones/Reajustes por Operacion/Siguiente')                                                                                                                                                                                                                
insert into cobis..cl_ttransaccion values (7564,       'Operaciones/Reajustes por Operacion/Escoger',                      '7564',   'Operaciones/Reajustes por Operacion/Escoger')                                                                                                                                                                                                                  
insert into cobis..cl_ttransaccion values (7565,       'Operaciones/Reajustes por Operacion/Escoger/Escoger',              '7565',   'Operaciones/Reajustes por Operacion/Escoger/Escoger')                                                                                                                                                                                                          
insert into cobis..cl_ttransaccion values (7566,       'Operaciones/Reajustes por Operacion/Escoger/Actualizar Reajuste',  '7566',   'Operaciones/Reajustes por Operacion/Escoger/Actualizar Reajuste')                                                                                                                                                                                              
insert into cobis..cl_ttransaccion values (7567,       'Operaciones/Reajustes por Operacion/Escoger/Eliminar Reajuste',    '7567',   'Operaciones/Reajustes por Operacion/Escoger/Eliminar Reajuste')                                                                                                                                                                                                
insert into cobis..cl_ttransaccion values (7568,       'Operaciones/Reajustes por Operacion/Escoger/Actualizar Detalle',   '7568',   'Operaciones/Reajustes por Operacion/Escoger/Actualizar Detalle')                                                                                                                                                                                               
insert into cobis..cl_ttransaccion values (7569,       'Operaciones/Reajustes por Operacion/Escoger/Eliminar Detalle',     '7569',   'Operaciones/Reajustes por Operacion/Escoger/Eliminar Detalle')                                                                                                                                                                                                 
insert into cobis..cl_ttransaccion values (7570,       'Operaciones/Reajustes Masivos',                                    '7570',   'Operaciones/Reajustes Masivos')                                                                                                                                                                                                                                
insert into cobis..cl_ttransaccion values (7571,       'Operaciones/Reajustes Masivos/Anadir',                             '7571',   'Operaciones/Reajustes Masivos/Anadir')                                                                                                                                                                                                                         
insert into cobis..cl_ttransaccion values (7572,       'Operaciones/Reajustes Masivos/Eliminar',                           '7572',   'Operaciones/Reajustes Masivos/Eliminar')                                                                                                                                                                                                                       
insert into cobis..cl_ttransaccion values (7573,       'Operaciones/Reajustes Masivos/Transmitir',                         '7573',   'Operaciones/Reajustes Masivos/Transmitir')                                                                                                                                                                                                                     
insert into cobis..cl_ttransaccion values (7574,       'Operaciones/Ingresos Otros Cargos',                                '7574',   'Operaciones/Ingresos Otros Cargos')                                                                                                                                                                                                                            
insert into cobis..cl_ttransaccion values (7575,       'Operaciones/Ingresos Otros Cargos/Buscar',                         '7575',   'Operaciones/Ingresos Otros Cargos/Buscar')                                                                                                                                                                                                                     
insert into cobis..cl_ttransaccion values (7576,       'Operaciones/Ingresos Otros Cargos/Siguientes',                     '7576',   'Operaciones/Ingresos Otros Cargos/Siguientes')                                                                                                                                                                                                                 
insert into cobis..cl_ttransaccion values (7577,       'Operaciones/Ingresos Otros Cargos/Escoger',                        '7577',   'Operaciones/Ingresos Otros Cargos/Escoger')                                                                                                                                                                                                                    
insert into cobis..cl_ttransaccion values (7578,       'Operaciones/Ingresos Otros Cargos/Escoger/Transmitir',             '7578',   'Operaciones/Ingresos Otros Cargos/Escoger/Transmitir')                                                                                                                                                                                                         
insert into cobis..cl_ttransaccion values (7579,       'Operaciones/Desembolsos Parciales',                                '7579',   'Operaciones/Desembolsos Parciales')                                                                                                                                                                                                                            
insert into cobis..cl_ttransaccion values (7580,       'Operaciones/Desembolsos Parciales/Buscar',                         '7580',   'Operaciones/Desembolsos Parciales/Buscar')                                                                                                                                                                                                                     
insert into cobis..cl_ttransaccion values (7581,       'Operaciones/Desembolsos Parciales/Siguientes',                     '7581',   'Operaciones/Desembolsos Parciales/Siguientes')                                                                                                                                                                                                                 
insert into cobis..cl_ttransaccion values (7582,       'Operaciones/Desembolsos Parciales/Escoger',                        '7582',   'Operaciones/Desembolsos Parciales/Escoger')                                                                                                                                                                                                                    
insert into cobis..cl_ttransaccion values (7583,       'Operaciones/Desembolsos Parciales/Escoger/Rubros',                 '7583',   'Operaciones/Desembolsos Parciales/Escoger/Rubros')                                                                                                                                                                                                             
insert into cobis..cl_ttransaccion values (7584,       'Operaciones/Desembolsos Parciales/Escoger/Rubros/Buscar',          '7584',   'Operaciones/Desembolsos Parciales/Escoger/Rubros/Buscar')                                                                                                                                                                                                      
insert into cobis..cl_ttransaccion values (7585,       'Operaciones/Desembolsos Parciales/Escoger/Rubros/Modificar',       '7585',   'Operaciones/Desembolsos Parciales/Escoger/Rubros/Modificar')                                                                                                                                                                                                   
insert into cobis..cl_ttransaccion values (7586,       'Operaciones/Desembolsos Parciales/Escoger/Rubros/Eliminar',        '7586',   'Operaciones/Desembolsos Parciales/Escoger/Rubros/Eliminar')                                                                                                                                                                                                    
insert into cobis..cl_ttransaccion values (7587,       'Operaciones/Desembolsos Parciales/Escoger/Rubros/Aceptar',         '7587',   'Operaciones/Desembolsos Parciales/Escoger/Rubros/Aceptar')                                                                                                                                                                                                     
insert into cobis..cl_ttransaccion values (7588,       'Operaciones/Desembolsos Parciales/Escoger/Rubros/Transmitir',      '7588',   'Operaciones/Desembolsos Parciales/Escoger/Rubros/Transmitir')                                                                                                                                                                                                  
insert into cobis..cl_ttransaccion values (7589,       'Operaciones/Desembolsos Parciales/Escoger/Desembolso',             '7589',   'Operaciones/Desembolsos Parciales/Escoger/Desembolso')                                                                                                                                                                                                         
insert into cobis..cl_ttransaccion values (7590,       'Operaciones/Desembolsos Parciales/Escoger/Desembolso/Buscar',      '7590',   'Operaciones/Desembolsos Parciales/Escoger/Desembolso/Buscar')                                                                                                                                                                                                  
insert into cobis..cl_ttransaccion values (7591,       'Operaciones/Desembolsos Parciales/Escoger/Desembolso/Crear',       '7591',   'Operaciones/Desembolsos Parciales/Escoger/Desembolso/Crear')                                                                                                                                                                                                   
insert into cobis..cl_ttransaccion values (7592,       'Operaciones/Desembolsos Parciales/Escoger/Desembolso/Eliminar',    '7592',   'Operaciones/Desembolsos Parciales/Escoger/Desembolso/Eliminar')                                                                                                                                                                                                
insert into cobis..cl_ttransaccion values (7593,       'Operaciones/Desembolsos Parciales/Escoger/Desembolso/Imprimir',    '7593',   'Operaciones/Desembolsos Parciales/Escoger/Desembolso/Imprimir')                                                                                                                                                                                                
insert into cobis..cl_ttransaccion values (7594,       'Operaciones/Desembolsos Parciales/Escoger/Desembolso/Transmitir',  '7594',   'Operaciones/Desembolsos Parciales/Escoger/Desembolso/Transmitir')                                                                                                                                                                                              
insert into cobis..cl_ttransaccion values (7595,       'Operaciones/Reestructuracion',                                     '7595',   'Operaciones/Reestructuracion')                                                                                                                                                                                                                                 
insert into cobis..cl_ttransaccion values (7596,       'Operaciones/Reestructuracion/Buscar',                              '7596',   'Operaciones/Reestructuracion/Buscar')                                                                                                                                                                                                                          
insert into cobis..cl_ttransaccion values (7597,       'Operaciones/Reestructuracion/Siguiente',                           '7597',   'Operaciones/Reestructuracion/Siguiente')                                                                                                                                                                                                                       
insert into cobis..cl_ttransaccion values (7598,       'Operaciones/Reestructuracion/Escoger',                             '7598',   'Operaciones/Reestructuracion/Escoger')                                                                                                                                                                                                                         
insert into cobis..cl_ttransaccion values (7599,       'Operaciones/Reestructuracion/Escoger/Parametros',                  '7599',   'Operaciones/Reestructuracion/Escoger/Parametros')                                                                                                                                                                                                              
insert into cobis..cl_ttransaccion values (7600,       'Operaciones/Reestructuracion/Escoger/Parametros/Transmitir',       '7600',   'Operaciones/Reestructuracion/Escoger/Parametros/Transmitir')                                                                                                                                                                                                   
insert into cobis..cl_ttransaccion values (714500,      'CONSULTA DE OPERACIONES CARTERA',                                 'COC',    'CONSULTA DE OPERACIONES CARTERA')
go

delete cobis..cl_ttransaccion
 where tn_trn_code in(7601,7602,7603,7604,7605,7606,7607,7608,7609,7610,7612,7613,7614,7615,7616,7617,7618,7619,7620,7621,7622,
                      7623,7624,7625,7626,7627,7628,7629,7630,7631,7632,7633,7634,7635,7636,7637,7638,7639,7640,7641,7642,7643,
                      7644,7645,7646,7647,7648,7649,7650,7651,7652,7653,7654,7655,7656,7657,7658,7659,7660,7661,7662,7663,7664,
                      7665,7666,7667,7668,7669,7670,7671,7672,7673,7674,7675,7676,7677,7678,7679,7680,7681,7682,7683,7684,7685,
                      7686,7687,7688,7689,7690,7691,7692,7693,7694,7695,7696,7697,7698,7699,7700,7701,7702,7703,7704,7705,7706,
                      7707,7709,7710,7711,7714,7715,7716,7717,7718,7719,7720,7721,7722,7723,7724,7725,7726,7727,7728,7729,7730,
                      7731,7732,7733,7734,7735,7736,7737,7738,7739,7740,7741,7742,7743,7744,7745,7746,7747,7748,7749,7750,7751,
                      7752,7753,7754,7755,7756,7757,7758,7759,7760,7761,7762,7763,7764,7765,7766,7767,7768,7769,7770,7771,7772,
                      7773,7774,7775,7776,7777,7778,7779,7780,7781,7782,7783,7784,7785,7786,7787,7788,7789,7790,7792,7794,7796,
                      7797,7798,7799,7800)
go

insert into cobis..cl_ttransaccion values (7601,       'Operaciones/Reestructuracion/Escoger/Amortizacion',                '7601',   'Operaciones/Reestructuracion/Escoger/Amortizacion')                                                                                                                                                                                                            
insert into cobis..cl_ttransaccion values (7602,       'Operaciones/Reestructuracion/Escoger/Amortizacion/Calcular',       '7602',   'Operaciones/Reestructuracion/Escoger/Amortizacion/Calcular')                                                                                                                                                                                                   
insert into cobis..cl_ttransaccion values (7603,       'Operaciones/Reestructuracion/Escoger/Amortizacion/Adicionales',    '7603',   'Operaciones/Reestructuracion/Escoger/Amortizacion/Adicionales')                                                                                                                                                                                                
insert into cobis..cl_ttransaccion values (7604,       'Operaciones/Reestructuracion/Escoger/Amortizacion/Adicionales/Tr', '7604',   'Operaciones/Reestructuracion/Escoger/Amortizacion/Adicionales/Transmitir')                                                                                                                                                                                     
insert into cobis..cl_ttransaccion values (7605,       'Operaciones/Reestructuracion/Escoger/Amortizacion/Insertar',       '7605',   'Operaciones/Reestructuracion/Escoger/Amortizacion/Insertar')                                                                                                                                                                                                   
insert into cobis..cl_ttransaccion values (7606,       'Operaciones/Reestructuracion/Escoger/Amortizacion/Eliminar',       '7606',   'Operaciones/Reestructuracion/Escoger/Amortizacion/Eliminar')                                                                                                                                                                                                   
insert into cobis..cl_ttransaccion values (7607,       'Operaciones/Reestructuracion/Escoger/Amortizacion/Transmitir',     '7607',   'Operaciones/Reestructuracion/Escoger/Amortizacion/Transmitir')                                                                                                                                                                                                 
insert into cobis..cl_ttransaccion values (7608,       'Operaciones/Reestructuracion/Escoger/Imprimir',                    '7608',   'Operaciones/Reestructuracion/Escoger/Imprimir')                                                                                                                                                                                                                
insert into cobis..cl_ttransaccion values (7609,       'Operaciones/Reestructuracion/Escoger/Actualizar',                  '7609',   'Operaciones/Reestructuracion/Escoger/Actualizar')                                                                                                                                                                                                              
insert into cobis..cl_ttransaccion values (7610,       'Operaciones/Reestructuracion/Escoger/Transmitir',                  '7610',   'Operaciones/Reestructuracion/Escoger/Transmitir')                                                                                                                                                                                                              
insert into cobis..cl_ttransaccion values (7612,       'Operaciones/Ajustes Remisiones',                                   '7612',   'Operaciones/Ajustes Remisiones')                                                                                                                                                                                                                               
insert into cobis..cl_ttransaccion values (7613,       'Consultas/Rubros/Consultas Generales/Consultas Informe Emprender', '7613',   'Consultas/Rubros/Consultas Generales/Consultas Informe Emprender')                                                                                                                                                                                             
insert into cobis..cl_ttransaccion values (7614,       'Operaciones/Aplicar Fecha Valor',                                  '7614',   'Operaciones/Aplicar Fecha Valor')                                                                                                                                                                                                                              
insert into cobis..cl_ttransaccion values (7615,       'Operaciones/Aplicar Fecha Valor/Buscar',                           '7615',   'Operaciones/Aplicar Fecha Valor/Buscar')                                                                                                                                                                                                                       
insert into cobis..cl_ttransaccion values (7616,       'Operaciones/Aplicar Fecha Valor/Siguiente',                        '7616',   'Operaciones/Aplicar Fecha Valor/Siguiente')                                                                                                                                                                                                                    
insert into cobis..cl_ttransaccion values (7617,       'Operaciones/Aplicar Fecha Valor/Escoger',                          '7617',   'Operaciones/Aplicar Fecha Valor/Escoger')                                                                                                                                                                                                                      
insert into cobis..cl_ttransaccion values (7618,       'Operaciones/Aplicar Fecha Valor/Escoger/Transmitir',               '7618',   'Operaciones/Aplicar Fecha Valor/Escoger/Transmitir')                                                                                                                                                                                                           
insert into cobis..cl_ttransaccion values (7619,       'Operaciones/Aplicar Fecha Valor/Escoger/Reversar',                 '7619',   'Operaciones/Aplicar Fecha Valor/Escoger/Reversar')                                                                                                                                                                                                             
insert into cobis..cl_ttransaccion values (7620,       'Operaciones/Cambios de Estado',                                    '7620',   'Operaciones/Cambios de Estado')                                                                                                                                                                                                                                
insert into cobis..cl_ttransaccion values (7621,       'Operaciones/Cambios de Estado/Buscar',                             '7621',   'Operaciones/Cambios de Estado/Buscar')                                                                                                                                                                                                                         
insert into cobis..cl_ttransaccion values (7622,       'Operaciones/Cambios de Estado/Siguiente',                          '7622',   'Operaciones/Cambios de Estado/Siguiente')                                                                                                                                                                                                                      
insert into cobis..cl_ttransaccion values (7623,       'Operaciones/Cambios de Estado/Escoger',                            '7623',   'Operaciones/Cambios de Estado/Escoger')                                                                                                                                                                                                                        
insert into cobis..cl_ttransaccion values (7624,       'Operaciones/Cambios de Estado/Escoger/Transmitir',                 '7624',   'Operaciones/Cambios de Estado/Escoger/Transmitir')                                                                                                                                                                                                             
insert into cobis..cl_ttransaccion values (7625,       'Operaciones/Pagos No Aplicados',                                   '7625',   'Operaciones/Pagos No Aplicados')                                                                                                                                                                                                                               
insert into cobis..cl_ttransaccion values (7626,       'Operaciones/Pagos No Aplicados/Buscar',                            '7626',   'Operaciones/Pagos No Aplicados/Buscar')                                                                                                                                                                                                                        
insert into cobis..cl_ttransaccion values (7627,       'Operaciones/Pagos No Aplicados/Siguiente',                         '7627',   'Operaciones/Pagos No Aplicados/Siguiente')                                                                                                                                                                                                                     
insert into cobis..cl_ttransaccion values (7628,       'Operaciones/Pagos No Aplicados/Escoger',                           '7628',   'Operaciones/Pagos No Aplicados/Escoger')                                                                                                                                                                                                                       
insert into cobis..cl_ttransaccion values (7629,       'Operaciones/Pagos No Aplicados/Escoger/Buscar',                    '7629',   'Operaciones/Pagos No Aplicados/Escoger/Buscar')                                                                                                                                                                                                                
insert into cobis..cl_ttransaccion values (7630,       'Operaciones/Pagos No Aplicados/Escoger/Eliminar',                  '7630',   'Operaciones/Pagos No Aplicados/Escoger/Eliminar')                                                                                                                                                                                                              
insert into cobis..cl_ttransaccion values (7631,       'Operaciones/Pagos No Aplicados/Escoger/Aceptar',                   '7631',   'Operaciones/Pagos No Aplicados/Escoger/Aceptar')                                                                                                                                                                                                               
insert into cobis..cl_ttransaccion values (7632,       'Consultas',                                                        '7632',   'Consultas')                                                                                                                                                                                                                                                    
insert into cobis..cl_ttransaccion values (7633,       'Consultas/Datos del Prestamo',                                     '7633',   'Consultas/Datos del Prestamo')                                                                                                                                                                                                                                 
insert into cobis..cl_ttransaccion values (7634,       'Consultas/Datos del Prestamo/Buscar',                              '7634',   'Consultas/Datos del Prestamo/Buscar')                                                                                                                                                                                                                          
insert into cobis..cl_ttransaccion values (7635,       'Consultas/Datos del Prestamo/Siguiente',                           '7635',   'Consultas/Datos del Prestamo/Siguiente')                                                                                                                                                                                                                       
insert into cobis..cl_ttransaccion values (7636,       'Consultas/Datos del Prestamo/Escoger',                             '7636',   'Consultas/Datos del Prestamo/Escoger')                                                                                                                                                                                                                         
insert into cobis..cl_ttransaccion values (7637,       'Consultas/Datos del Prestamo/Escoger/Imprimir',                    '7637',   'Consultas/Datos del Prestamo/Escoger/Imprimir')                                                                                                                                                                                                                
insert into cobis..cl_ttransaccion values (7638,       'Consultas/Transacciones',                                          '7638',   'Consultas/Transacciones')                                                                                                                                                                                                                                      
insert into cobis..cl_ttransaccion values (7639,       'Consultas/Transacciones/Buscar',                                   '7639',   'Consultas/Transacciones/Buscar')                                                                                                                                                                                                                               
insert into cobis..cl_ttransaccion values (7640,       'Consultas/Transacciones/Detalle',                                  '7640',   'Consultas/Transacciones/Detalle')                                                                                                                                                                                                                              
insert into cobis..cl_ttransaccion values (7641,       'Consultas/(Vencimientos/Reajustes Futuros)',                       '7641',   'Consultas/(Vencimientos/Reajustes Futuros)')                                                                                                                                                                                                                   
insert into cobis..cl_ttransaccion values (7642,       'Consultas/(Vencimientos/Reajustes Futuros)/Buscar',                '7642',   'Consultas/(Vencimientos/Reajustes Futuros)/Buscar')                                                                                                                                                                                                            
insert into cobis..cl_ttransaccion values (7643,       'Consultas/(Vencimientos/Reajustes Futuros)/Siguiente',             '7643',   'Consultas/(Vencimientos/Reajustes Futuros)/Siguiente')                                                                                                                                                                                                         
insert into cobis..cl_ttransaccion values (7644,       'Consultas/Proyeccion Valor a Pagar',                               '7644',   'Consultas/Proyeccion Valor a Pagar')                                                                                                                                                                                                                           
insert into cobis..cl_ttransaccion values (7645,       'Consultas/Proyeccion Cuota a Pagar/Buscar',                        '7645',   'Consultas/Proyeccion Cuota a Pagar/Buscar')                                                                                                                                                                                                                    
insert into cobis..cl_ttransaccion values (7646,       'Consultas/Proyeccion Cuota a Pagar/Siguiente',                     '7646',   'Consultas/Proyeccion Cuota a Pagar/Siguiente')                                                                                                                                                                                                                 
insert into cobis..cl_ttransaccion values (7647,       'Consultas/Simulacion de Creacion de Operacion',                    '7647',   'Consultas/Simulacion de Creacion de Operacion')                                                                                                                                                                                                                
insert into cobis..cl_ttransaccion values (7648,       'Consultas/Simulacion de Creacion de Operacion/Rubros',             '7648',   'Consultas/Simulacion de Creacion de Operacion/Rubros')                                                                                                                                                                                                         
insert into cobis..cl_ttransaccion values (7649,       'Consultas/Simulacion de Creacion de Operacion/Rubros/Buscar',      '7649',   'Consultas/Simulacion de Creacion de Operacion/Rubros/Buscar')                                                                                                                                                                                                  
insert into cobis..cl_ttransaccion values (7650,       'Consultas/Simulacion de Creacion de Operacion/Rubros/Modificar',   '7650',   'Consultas/Simulacion de Creacion de Operacion/Rubros/Modificar')                                                                                                                                                                                               
insert into cobis..cl_ttransaccion values (7651,       'Consultas/Simulacion de Creacion de Operacion/Rubros/Eliminar',    '7651',   'Consultas/Simulacion de Creacion de Operacion/Rubros/Eliminar')                                                                                                                                                                                                
insert into cobis..cl_ttransaccion values (7652,       'Consultas/Simulacion de Creacion de Operacion/Rubros/Aceptar',     '7652',   'Consultas/Simulacion de Creacion de Operacion/Rubros/Aceptar')                                                                                                                                                                                                 
insert into cobis..cl_ttransaccion values (7653,       'Consultas/Simulacion de Creacion de Operacion/Rubros/Transmitir',  '7653',   'Consultas/Simulacion de Creacion de Operacion/Rubros/Transmitir')                                                                                                                                                                                              
insert into cobis..cl_ttransaccion values (7654,       'Consultas/Simulacion de Creacion de Operacion/Parametros',         '7654',   'Consultas/Simulacion de Creacion de Operacion/Parametros')                                                                                                                                                                                                     
insert into cobis..cl_ttransaccion values (7655,       'Consultas/Simulacion de Creacion de Operacion/Parametros/Transmi', '7655',   'Consultas/Simulacion de Creacion de Operacion/Parametros/Transmitir')                                                                                                                                                                                          
insert into cobis..cl_ttransaccion values (7656,       'Consultas/Simulacion de Creacion de Operacion/Amortizacion',       '7656',   'Consultas/Simulacion de Creacion de Operacion/Amortizacion')                                                                                                                                                                                                   
insert into cobis..cl_ttransaccion values (7657,       'Consultas/Simulacion de Creacion de Operacion/Amortizacion/Calcu', '7657',   'Consultas/Simulacion de Creacion de Operacion/Amortizacion/Calcular')                                                                                                                                                                                          
insert into cobis..cl_ttransaccion values (7658,       'Consultas/Simulacion de Creacion de Operacion/Amortizacion/Adici', '7658',   'Consultas/Simulacion de Creacion de Operacion/Amortizacion/Adicionales')                                                                                                                                                                                       
insert into cobis..cl_ttransaccion values (7659,       'Consultas/Simulacion de Creacion de Operacion/Amortizacion/Adici', '7659',   'Consultas/Simulacion de Creacion de Operacion/Amortizacion/Adicionales/Transmitir')                                                                                                                                                                            
insert into cobis..cl_ttransaccion values (7660,       'Consultas/Simulacion de Creacion de Operacion/Amortizacion/Inser', '7660',   'Consultas/Simulacion de Creacion de Operacion/Amortizacion/Insertar')                                                                                                                                                                                          
insert into cobis..cl_ttransaccion values (7661,       'Consultas/Simulacion de Creacion de Operacion/Amortizacion/Elimi', '7661',   'Consultas/Simulacion de Creacion de Operacion/Amortizacion/Eliminar')                                                                                                                                                                                          
insert into cobis..cl_ttransaccion values (7662,       'Consultas/Simulacion de Creacion de Operacion/Amortizacion/Trans', '7662',   'Consultas/Simulacion de Creacion de Operacion/Amortizacion/Transmitir')                                                                                                                                                                                        
insert into cobis..cl_ttransaccion values (7663,       'Consultas/Simulacion de Creacion de Operacion/Crear',              '7663',   'Consultas/Simulacion de Creacion de Operacion/Crear')                                                                                                                                                                                                          
insert into cobis..cl_ttransaccion values (7664,       'Consultas/Simulacion de Creacion de Operacion/Actaulizar',         '7664',   'Consultas/Simulacion de Creacion de Operacion/Actaulizar')                                                                                                                                                                                                     
insert into cobis..cl_ttransaccion values (7665,       'Consultas/Distribucion del Credito',                               '7665',   'Consultas/Distribucion del Credito')                                                                                                                                                                                                                           
insert into cobis..cl_ttransaccion values (7666,       'Consultas/Distribucion del Credito/Imprimir',                      '7666',   'Consultas/Distribucion del Credito/Imprimir')                                                                                                                                                                                                                  
insert into cobis..cl_ttransaccion values (7667,       'Consultas/Consulta de Reportes Bach',                              '7667',   'Consultas/Consulta de Reportes Bach')                                                                                                                                                                                                                          
insert into cobis..cl_ttransaccion values (7668,       'Consultas/Consulta de Reportes Bach/Primera',                      '7668',   'Consultas/Consulta de Reportes Bach/Primera')                                                                                                                                                                                                                  
insert into cobis..cl_ttransaccion values (7669,       'Consultas/Consulta de Reportes Bach/Siguinte',                     '7669',   'Consultas/Consulta de Reportes Bach/Siguinte')                                                                                                                                                                                                                 
insert into cobis..cl_ttransaccion values (7670,       'Consultas/Consulta de Reportes Bach/anterior',                     '7670',   'Consultas/Consulta de Reportes Bach/anterior')                                                                                                                                                                                                                 
insert into cobis..cl_ttransaccion values (7671,       'Consultas/Consulta de Reportes Bach/Ultima',                       '7671',   'Consultas/Consulta de Reportes Bach/Ultima')                                                                                                                                                                                                                   
insert into cobis..cl_ttransaccion values (7672,       'Consultas/Consulta de Reportes Bach/Buscar',                       '7672',   'Consultas/Consulta de Reportes Bach/Buscar')                                                                                                                                                                                                                   
insert into cobis..cl_ttransaccion values (7673,       'Consultas/Instrucciones Operativas',                               '7673',   'Consultas/Instrucciones Operativas')                                                                                                                                                                                                                           
insert into cobis..cl_ttransaccion values (7674,       'Consultas/Instrucciones Operativas/Escoger/Buscar',                '7674',   'Consultas/Instrucciones Operativas/Escoger/Buscar')                                                                                                                                                                                                            
insert into cobis..cl_ttransaccion values (7675,       'Consultas/Instrucciones Operativas/Escoger/Ejecutada',             '7675',   'Consultas/Instrucciones Operativas/Escoger/Ejecutada')                                                                                                                                                                                                         
insert into cobis..cl_ttransaccion values (7676,       'Administracion',                                                   '7676',   'Administracion')                                                                                                                                                                                                                                               
insert into cobis..cl_ttransaccion values (7677,       'Administracion/Catalogo',                                          '7677',   'Administracion/Catalogo')                                                                                                                                                                                                                                      
insert into cobis..cl_ttransaccion values (7678,       'Administracion/Catalogo/Buscar',                                   '7678',   'Administracion/Catalogo/Buscar')                                                                                                                                                                                                                               
insert into cobis..cl_ttransaccion values (7679,       'Administracion/Catalogo/Siguiente',                                '7679',   'Administracion/Catalogo/Siguiente')                                                                                                                                                                                                                            
insert into cobis..cl_ttransaccion values (7680,       'Administracion/Catalogo/Crear',                                    '7680',   'Administracion/Catalogo/Crear')                                                                                                                                                                                                                                
insert into cobis..cl_ttransaccion values (7681,       'Administracion/Catalogo/Crear/Transmitir',                         '7681',   'Administracion/Catalogo/Crear/Transmitir')                                                                                                                                                                                                                     
insert into cobis..cl_ttransaccion values (7682,       'Administracion/Catalogo/Modificar',                                '7682',   'Administracion/Catalogo/Modificar')                                                                                                                                                                                                                            
insert into cobis..cl_ttransaccion values (7683,       'Administracion/Catalogo/Modificar/Transmitir',                     '7683',   'Administracion/Catalogo/Modificar/Transmitir')                                                                                                                                                                                                                 
insert into cobis..cl_ttransaccion values (7684,       'Administracion/Parametros Generales',                              '7684',   'Administracion/Parametros Generales')                                                                                                                                                                                                                          
insert into cobis..cl_ttransaccion values (7685,       'Administracion/Parametros Generales/Buscar',                       '7685',   'Administracion/Parametros Generales/Buscar')                                                                                                                                                                                                                   
insert into cobis..cl_ttransaccion values (7686,       'Administracion/Parametros Generales/Siguiente',                    '7686',   'Administracion/Parametros Generales/Siguiente')                                                                                                                                                                                                                
insert into cobis..cl_ttransaccion values (7687,       'Administracion/Parametros Generales/Crear',                        '7687',   'Administracion/Parametros Generales/Crear')                                                                                                                                                                                                                    
insert into cobis..cl_ttransaccion values (7688,       'Administracion/Parametros Generales/Crear/Transmitir',             '7688',   'Administracion/Parametros Generales/Crear/Transmitir')                                                                                                                                                                                                         
insert into cobis..cl_ttransaccion values (7689,       'Administracion/Parametros Generales/Actualizar',                   '7689',   'Administracion/Parametros Generales/Actualizar')                                                                                                                                                                                                               
insert into cobis..cl_ttransaccion values (7690,       'Administracion/Parametros Generales/Actualizar/Transmitir',        '7690',   'Administracion/Parametros Generales/Actualizar/Transmitir')                                                                                                                                                                                                    
insert into cobis..cl_ttransaccion values (7691,       'Administracion/Rubros/Definicion de Tablas de Rubros',             '7691',   'Administracion/Rubros/Definicion de Tablas de Rubros')                                                                                                                                                                                                         
insert into cobis..cl_ttransaccion values (7692,       'Administracion/Rubros/Definicion de Tablas de Rubros/Buscar',      '7692',   'Administracion/Rubros/Definicion de Tablas de Rubros/Buscar')                                                                                                                                                                                                  
insert into cobis..cl_ttransaccion values (7693,       'Administracion/Rubros/Definicion de Tablas de Rubros/Rangos',      '7693',   'Administracion/Rubros/Definicion de Tablas de Rubros/Rangos')                                                                                                                                                                                                  
insert into cobis..cl_ttransaccion values (7694,       'Administracion/Rubros/Definicion de Tablas de Rubros/Rangos/Busc', '7694',   'Administracion/Rubros/Definicion de Tablas de Rubros/Rangos/Buscar')                                                                                                                                                                                           
insert into cobis..cl_ttransaccion values (7695,       'Administracion/Rubros/Definicion de Tablas de Rubros/Rangos/Sigu', '7695',   'Administracion/Rubros/Definicion de Tablas de Rubros/Rangos/Siguiente')                                                                                                                                                                                        
insert into cobis..cl_ttransaccion values (7696,       'Administracion/Rubros/Definicion de Tablas de Rubros/Rangos/Crea', '7696',   'Administracion/Rubros/Definicion de Tablas de Rubros/Rangos/Crear')                                                                                                                                                                                            
insert into cobis..cl_ttransaccion values (7697,       'Administracion/Rubros/Definicion de Tablas de Rubros/Rangos/Crea', '7697',   'Administracion/Rubros/Definicion de Tablas de Rubros/Rangos/Crear/Transmitir')                                                                                                                                                                                 
insert into cobis..cl_ttransaccion values (7698,       'Administracion/Rubros/Definicion de Tablas de Rubros/Rangos/Elim', '7698',   'Administracion/Rubros/Definicion de Tablas de Rubros/Rangos/Eliminar')                                                                                                                                                                                         
insert into cobis..cl_ttransaccion values (7699,       'Administracion/Rubros/Definicion de Tablas de Rubros/Rangos/Modi', '7699',   'Administracion/Rubros/Definicion de Tablas de Rubros/Rangos/Modificar')                                                                                                                                                                                        
insert into cobis..cl_ttransaccion values (7700,       'Administracion/Rubros/Definicion de Tablas de Rubros/Rangos/Modi', '7700',   'Administracion/Rubros/Definicion de Tablas de Rubros/Rangos/Modificar/Transmitir')                                                                                                                                                                             
insert into cobis..cl_ttransaccion values (7701,       'Administracion/Rubros/Definicion de Tablas de Rubros/Eliminar',    '7701',   'Administracion/Rubros/Definicion de Tablas de Rubros/Eliminar')                                                                                                                                                                                                
insert into cobis..cl_ttransaccion values (7702,       'Administracion/Rubros/Definicion de Tablas de Rubros/Crear',       '7702',   'Administracion/Rubros/Definicion de Tablas de Rubros/Crear')                                                                                                                                                                                                   
insert into cobis..cl_ttransaccion values (7703,       'Administracion/Rubros/Definicion de Tablas de Rubros/Crear/Trans', '7703',   'Administracion/Rubros/Definicion de Tablas de Rubros/Crear/Transmitir')                                                                                                                                                                                        
insert into cobis..cl_ttransaccion values (7704,       'Administracion/Rubros/Definicion de Tablas de Rubros/Modificar',   '7704',   'Administracion/Rubros/Definicion de Tablas de Rubros/Modificar')                                                                                                                                                                                               
insert into cobis..cl_ttransaccion values (7705,       'Administracion/Rubros/Definicion de Tablas de Rubros/Modificar/T', '7705',   'Administracion/Rubros/Definicion de Tablas de Rubros/Modificar/Transmitir')                                                                                                                                                                                    
insert into cobis..cl_ttransaccion values (7706,       'Administracion/Rubros/Rubros Pagos Planificadores',                '7706',   'Administracion/Rubros/Rubros Pagos Planificadores')                                                                                                                                                                                                            
insert into cobis..cl_ttransaccion values (7707,       'Operaciones/modificacion de nota',                                 '7707',   'Operaciones/modificacion de nota')                                                                                                                                                                                                                             
insert into cobis..cl_ttransaccion values (7709,       'Administracion/(Valores / Tasas Referenciales)',                   '7709',   'Administracion/(Valores / Tasas Referenciales)')                                                                                                                                                                                                               
insert into cobis..cl_ttransaccion values (7710,       'Administracion/(Valores / Tasas Referenciales)/Buscar',            '7710',   'Administracion/(Valores / Tasas Referenciales)/Buscar')                                                                                                                                                                                                        
insert into cobis..cl_ttransaccion values (7711,       'Administracion/(Valores / Tasas Referenciales)/Siguiente',         '7711',   'Administracion/(Valores / Tasas Referenciales)/Siguiente')                                                                                                                                                                                                     
insert into cobis..cl_ttransaccion values (7714,       'Administracion/(Valores / Tasas a Aplicar)',                       '7714',   'Administracion/(Valores / Tasas a Aplicar)')                                                                                                                                                                                                                   
insert into cobis..cl_ttransaccion values (7715,       'Administracion/(Valores / Tasas a Aplicar)/Buscar',                '7715',   'Administracion/(Valores / Tasas a Aplicar)/Buscar')                                                                                                                                                                                                            
insert into cobis..cl_ttransaccion values (7716,       'Administracion/(Valores / Tasas a Aplicar)/Siguiente',             '7716',   'Administracion/(Valores / Tasas a Aplicar)/Siguiente')                                                                                                                                                                                                         
insert into cobis..cl_ttransaccion values (7717,       'Administracion/(Valores / Tasas a Aplicar)/Modificar',             '7717',   'Administracion/(Valores / Tasas a Aplicar)/Modificar')                                                                                                                                                                                                         
insert into cobis..cl_ttransaccion values (7718,       'Administracion/(Valores / Tasas a Aplicar)/Transmitir',            '7718',   'Administracion/(Valores / Tasas a Aplicar)/Transmitir')                                                                                                                                                                                                        
insert into cobis..cl_ttransaccion values (7719,       'Administracion/Asignacion de Perfiles Contables',                  '7719',   'Administracion/Asignacion de Perfiles Contables')                                                                                                                                                                                                              
insert into cobis..cl_ttransaccion values (7720,       'Administracion/Asignacion de Perfiles Contables/Buscar',           '7720',   'Administracion/Asignacion de Perfiles Contables/Buscar')                                                                                                                                                                                                       
insert into cobis..cl_ttransaccion values (7721,       'Administracion/Asignacion de Perfiles Contables/Siguiente',        '7721',   'Administracion/Asignacion de Perfiles Contables/Siguiente')                                                                                                                                                                                                    
insert into cobis..cl_ttransaccion values (7722,       'Administracion/Asignacion de Perfiles Contables/Modificar',        '7722',   'Administracion/Asignacion de Perfiles Contables/Modificar')                                                                                                                                                                                                    
insert into cobis..cl_ttransaccion values (7723,       'Administracion/Asignacion de Perfiles Contables/Eliminar',         '7723',   'Administracion/Asignacion de Perfiles Contables/Eliminar')                                                                                                                                                                                                     
insert into cobis..cl_ttransaccion values (7724,       'Administracion/Asignacion de Perfiles Contables/Transmitir',       '7724',   'Administracion/Asignacion de Perfiles Contables/Transmitir')                                                                                                                                                                                                   
insert into cobis..cl_ttransaccion values (7725,       'Administracion/Lineas de Credito/Parametros linea de Credito',     '7725',   'Administracion/Lineas de Credito/Parametros linea de Credito')                                                                                                                                                                                                 
insert into cobis..cl_ttransaccion values (7726,       'Administracion/Lineas de Credito/Parametros linea de Credito/Tra', '7726',   'Administracion/Lineas de Credito/Parametros linea de Credito/Transmitir')                                                                                                                                                                                      
insert into cobis..cl_ttransaccion values (7727,       'Administracion/Rubros/Rubros por Linea de Credito',                '7727',   'Administracion/Rubros/Rubros por Linea de Credito')                                                                                                                                                                                                            
insert into cobis..cl_ttransaccion values (7728,       'Administracion/Rubros/Rubros por Linea de Credito/Buscar',         '7728',   'Administracion/Rubros/Rubros por Linea de Credito/Buscar')                                                                                                                                                                                                     
insert into cobis..cl_ttransaccion values (7729,       'Administracion/Rubros/Rubros por Linea de Credito/Siguiente',      '7729',   'Administracion/Rubros/Rubros por Linea de Credito/Siguiente')                                                                                                                                                                                                  
insert into cobis..cl_ttransaccion values (7730,       'Administracion/Rubros/Rubros por Linea de Credito/Modificar',      '7730',   'Administracion/Rubros/Rubros por Linea de Credito/Modificar')                                                                                                                                                                                                  
insert into cobis..cl_ttransaccion values (7731,       'Administracion/Rubros/Rubros por Linea de Credito/Eliminar',       '7731',   'Administracion/Rubros/Rubros por Linea de Credito/Eliminar')                                                                                                                                                                                                   
insert into cobis..cl_ttransaccion values (7732,       'Administracion/Rubros/Rubros por Linea de Credito/Transmitir',     '7732',   'Administracion/Rubros/Rubros por Linea de Credito/Transmitir')                                                                                                                                                                                                 
insert into cobis..cl_ttransaccion values (7733,       'Administracion/Mantenimiento de Forma de Pago',                    '7733',   'Administracion/Mantenimiento de Forma de Pago')                                                                                                                                                                                                                
insert into cobis..cl_ttransaccion values (7734,       'Administracion/Mantenimiento de Forma de Pago/Buscar',             '7734',   'Administracion/Mantenimiento de Forma de Pago/Buscar')                                                                                                                                                                                                         
insert into cobis..cl_ttransaccion values (7735,       'Administracion/Mantenimiento de Forma de Pago/Crear',              '7735',   'Administracion/Mantenimiento de Forma de Pago/Crear')                                                                                                                                                                                                          
insert into cobis..cl_ttransaccion values (7736,       'Administracion/Mantenimiento de Forma de Pago/Modificar',          '7736',   'Administracion/Mantenimiento de Forma de Pago/Modificar')                                                                                                                                                                                                      
insert into cobis..cl_ttransaccion values (7737,       'Administracion/Mantenimiento de Forma de Pago/Eliminar',           '7737',   'Administracion/Mantenimiento de Forma de Pago/Eliminar')                                                                                                                                                                                                       
insert into cobis..cl_ttransaccion values (7738,       'Administracion/Mantenimiento de Estados',                          '7738',   'Administracion/Mantenimiento de Estados')                                                                                                                                                                                                                      
insert into cobis..cl_ttransaccion values (7739,       'Administracion/Mantenimiento de Estados/Modificar',                '7739',   'Administracion/Mantenimiento de Estados/Modificar')                                                                                                                                                                                                            
insert into cobis..cl_ttransaccion values (7740,       'Administracion/Mantenimiento de Estados/Crear',                    '7740',   'Administracion/Mantenimiento de Estados/Crear')                                                                                                                                                                                                                
insert into cobis..cl_ttransaccion values (7741,       'Administracion/Lineas de Credito/Estado Por Linea de Credito',     '7741',   'Administracion/Lineas de Credito/Estado Por Linea de Credito')                                                                                                                                                                                                 
insert into cobis..cl_ttransaccion values (7742,       'Administracion/Lineas de Credito/Estado Por Linea de Credito/Bus', '7742',   'Administracion/Lineas de Credito/Estado Por Linea de Credito/Buscar')                                                                                                                                                                                          
insert into cobis..cl_ttransaccion values (7743,       'Administracion/Lineas de Credito/Estado Por Linea de Credito/Sig', '7743',   'Administracion/Lineas de Credito/Estado Por Linea de Credito/Siguiente')                                                                                                                                                                                       
insert into cobis..cl_ttransaccion values (7744,       'Administracion/Lineas de Credito/Estado Por Linea de Credito/Mod', '7744',   'Administracion/Lineas de Credito/Estado Por Linea de Credito/Modificar')                                                                                                                                                                                       
insert into cobis..cl_ttransaccion values (7745,       'Administracion/Lineas de Credito/Estado Por Linea de Credito/Eli', '7745',   'Administracion/Lineas de Credito/Estado Por Linea de Credito/Eliminar')                                                                                                                                                                                        
insert into cobis..cl_ttransaccion values (7746,       'Administracion/Lineas de Credito/Estado Por Linea de Credito/Tra', '7746',   'Administracion/Lineas de Credito/Estado Por Linea de Credito/Transmitir')                                                                                                                                                                                      
insert into cobis..cl_ttransaccion values (7747,       'Administracion/Rubros/Estado de rubros',                           '7747',   'Administracion/Rubros/Estado de rubros')                                                                                                                                                                                                                       
insert into cobis..cl_ttransaccion values (7748,       'Administracion/Rubros/Estado de rubros/Buscar',                    '7748',   'Administracion/Rubros/Estado de rubros/Buscar')                                                                                                                                                                                                                
insert into cobis..cl_ttransaccion values (7749,       'Administracion/Rubros/Estado de rubros/Siguiente',                 '7749',   'Administracion/Rubros/Estado de rubros/Siguiente')                                                                                                                                                                                                             
insert into cobis..cl_ttransaccion values (7750,       'Administracion/Rubros/Estado de rubros/Modificar',                 '7750',   'Administracion/Rubros/Estado de rubros/Modificar')                                                                                                                                                                                                             
insert into cobis..cl_ttransaccion values (7751,       'Administracion/Rubros/Estado de rubros/Eliminar',                  '7751',   'Administracion/Rubros/Estado de rubros/Eliminar')                                                                                                                                                                                                              
insert into cobis..cl_ttransaccion values (7752,       'Administracion/Rubros/Estado de rubros/Transmitir',                '7752',   'Administracion/Rubros/Estado de rubros/Transmitir')                                                                                                                                                                                                            
insert into cobis..cl_ttransaccion values (7753,       'Operaciones/Aplicar Fecha Valor/Escoger/Buscar',                   '7753',   'Operaciones/Aplicar Fecha Valor/Escoger/Buscar')                                                                                                                                                                                                               
insert into cobis..cl_ttransaccion values (7754,       'Consultas/Transacciones/Imprimir',                                 '7754',   'Consultas/Transacciones/Imprimir')                                                                                                                                                                                                                             
insert into cobis..cl_ttransaccion values (7755,       'Operaciones/Creacion/Asociar',                                     '7755',   'Operaciones/Creacion/Asociar')                                                                                                                                                                                                                                 
insert into cobis..cl_ttransaccion values (7756,       'Operaciones/Reestructuracion/Escoger/Asociar',                     '7756',   'Operaciones/Reestructuracion/Escoger/Asociar')                                                                                                                                                                                                                 
insert into cobis..cl_ttransaccion values (7757,       'Operaciones/Pagos No Aplicados/Escoger/Detalle',                   '7757',   'Operaciones/Pagos No Aplicados/Escoger/Detalle')                                                                                                                                                                                                               
insert into cobis..cl_ttransaccion values (7758,       'Operaciones/Creacion/Amortizacion/Gracia',                         '7758',   'Operaciones/Creacion/Amortizacion/Gracia')                                                                                                                                                                                                                     
insert into cobis..cl_ttransaccion values (7759,       'Operaciones/Actualizacion/Escoger/Amortizacion/Gracia',            '7759',   'Operaciones/Actualizacion/Escoger/Amortizacion/Gracia')                                                                                                                                                                                                        
insert into cobis..cl_ttransaccion values (7760,       'Operaciones/Reestructuracion/Escoger/Amortizacion/Gracia',         '7760',   'Operaciones/Reestructuracion/Escoger/Amortizacion/Gracia')                                                                                                                                                                                                     
insert into cobis..cl_ttransaccion values (7761,       'Operaciones/Creacion/Asociar/Anadir',                              '7761',   'Operaciones/Creacion/Asociar/Anadir')                                                                                                                                                                                                                          
insert into cobis..cl_ttransaccion values (7762,       'Operaciones/Creacion/Asociar/Eliminar',                            '7762',   'Operaciones/Creacion/Asociar/Eliminar')                                                                                                                                                                                                                        
insert into cobis..cl_ttransaccion values (7763,       'Operaciones/Actualizacion/Escoger/Asociar/Anadir',                 '7763',   'Operaciones/Actualizacion/Escoger/Asociar/Anadir')                                                                                                                                                                                                             
insert into cobis..cl_ttransaccion values (7764,       'Operaciones/Actualizacion/Escoger/Asociar/Eliminar',               '7764',   'Operaciones/Actualizacion/Escoger/Asociar/Eliminar')                                                                                                                                                                                                           
insert into cobis..cl_ttransaccion values (7765,       'Operaciones/Desembolsos Parciales/Escoger/Asociar',                '7765',   'Operaciones/Desembolsos Parciales/Escoger/Asociar')                                                                                                                                                                                                            
insert into cobis..cl_ttransaccion values (7766,       'Consultas/Proyeccion Cuota a Pagar/Escoger',                       '7766',   'Consultas/Proyeccion Cuota a Pagar/Escoger')                                                                                                                                                                                                                   
insert into cobis..cl_ttransaccion values (7767,       'Consultas/Proyeccion Cuota a Pagar/Escoger/Calcular',              '7767',   'Consultas/Proyeccion Cuota a Pagar/Escoger/Calcular')                                                                                                                                                                                                          
insert into cobis..cl_ttransaccion values (7768,       'Consultas/Proyeccion Cuota a Pagar/Imprimir',                      '7768',   'Consultas/Proyeccion Cuota a Pagar/Imprimir')                                                                                                                                                                                                                  
insert into cobis..cl_ttransaccion values (7769,       'Operaciones/Actualizacion/Imprimir',                               '7769',   'Operaciones/Actualizacion/Imprimir')                                                                                                                                                                                                                           
insert into cobis..cl_ttransaccion values (7770,       'Operaciones/Desembolso de Operaciones/Imprimir',                   '7770',   'Operaciones/Desembolso de Operaciones/Imprimir')                                                                                                                                                                                                               
insert into cobis..cl_ttransaccion values (7771,       'Operaciones/(Pagos/Cancelaciones/Precancelaciones/Imprimir',       '7771',   'Operaciones/(Pagos/Cancelaciones/Precancelaciones/Imprimir')                                                                                                                                                                                                   
insert into cobis..cl_ttransaccion values (7772,       'Operaciones/Reajustes por Operacion/Imprimir',                     '7772',   'Operaciones/Reajustes por Operacion/Imprimir')                                                                                                                                                                                                                 
insert into cobis..cl_ttransaccion values (7773,       'Operaciones/Ingresos Otros Cargos/Imprimir',                       '7773',   'Operaciones/Ingresos Otros Cargos/Imprimir')                                                                                                                                                                                                                   
insert into cobis..cl_ttransaccion values (7774,       'Operaciones/Desembolsos Parciales/Imprimir',                       '7774',   'Operaciones/Desembolsos Parciales/Imprimir')                                                                                                                                                                                                                   
insert into cobis..cl_ttransaccion values (7775,       'Operaciones/Reestructuracion/Imprimir',                            '7775',   'Operaciones/Reestructuracion/Imprimir')                                                                                                                                                                                                                        
insert into cobis..cl_ttransaccion values (7776,       'Operaciones/Aplicar Fecha Valor/Imprimir',                         '7776',   'Operaciones/Aplicar Fecha Valor/Imprimir')                                                                                                                                                                                                                     
insert into cobis..cl_ttransaccion values (7777,       'Operaciones/Cambios de Estado/Imprimir',                           '7777',   'Operaciones/Cambios de Estado/Imprimir')                                                                                                                                                                                                                       
insert into cobis..cl_ttransaccion values (7778,       'Operaciones/Pagos No Aplicados/Imprimir',                          '7778',   'Operaciones/Pagos No Aplicados/Imprimir')                                                                                                                                                                                                                      
insert into cobis..cl_ttransaccion values (7779,       'Consultas/Datos del Prestamo/Imprimir',                            '7779',   'Consultas/Datos del Prestamo/Imprimir')                                                                                                                                                                                                                        
insert into cobis..cl_ttransaccion values (7780,       'Consultas/Instrucciones Operativas/Buscar',                        '7780',   'Consultas/Instrucciones Operativas/Buscar')                                                                                                                                                                                                                    
insert into cobis..cl_ttransaccion values (7781,       'Consultas/Instrucciones Operativas/Siguiente',                     '7781',   'Consultas/Instrucciones Operativas/Siguiente')                                                                                                                                                                                                                 
insert into cobis..cl_ttransaccion values (7782,       'Consultas/Instrucciones Operativas/Escoger',                       '7782',   'Consultas/Instrucciones Operativas/Escoger')                                                                                                                                                                                                                   
insert into cobis..cl_ttransaccion values (7783,       'Consultas/Instrucciones Operativas/Imprimir',                      '7783',   'Consultas/Instrucciones Operativas/Imprimir')                                                                                                                                                                                                                  
insert into cobis..cl_ttransaccion values (7784,       'Administracion/Mantenimiento de Estados/Eliminar',                 '7784',   'Administracion/Mantenimiento de Estados/Eliminar')                                                                                                                                                                                                             
insert into cobis..cl_ttransaccion values (7785,       'Operaciones/Reversas',                                             '7785',   'Operaciones/Reversas')                                                                                                                                                                                                                                         
insert into cobis..cl_ttransaccion values (7786,       'Operaciones/Reversas/Buscar',                                      '7786',   'Operaciones/Reversas/Buscar')                                                                                                                                                                                                                                  
insert into cobis..cl_ttransaccion values (7787,       'Operaciones/Reversas/Siguiente',                                   '7787',   'Operaciones/Reversas/Siguiente')                                                                                                                                                                                                                               
insert into cobis..cl_ttransaccion values (7788,       'Operaciones/Reversas/Escoger',                                     '7788',   'Operaciones/Reversas/Escoger')                                                                                                                                                                                                                                 
insert into cobis..cl_ttransaccion values (7789,       'Operaciones/Reversas/Imprimir',                                    '7789',   'Operaciones/Reversas/Imprimir')                                                                                                                                                                                                                                
insert into cobis..cl_ttransaccion values (7790,       'Operaciones/Reversas/Escoger/Buscar',                              '7790',   'Operaciones/Reversas/Escoger/Buscar')                                                                                                                                                                                                                          
insert into cobis..cl_ttransaccion values (7792,       'Operaciones/Reversas/Escoger/Reversar',                            '7792',   'Operaciones/Reversas/Escoger/Reversar')                                                                                                                                                                                                                        
insert into cobis..cl_ttransaccion values (7794,       'Operaciones/Renovaciones/Escoger/Pago',                            '7794',   'Operaciones/Renovaciones/Escoger/Pago')                                                                                                                                                                                                                        
insert into cobis..cl_ttransaccion values (7796,       'Consultas/Conversion Tasas',                                       '7796',   'Consultas/Conversion Tasas')                                                                                                                                                                                                                                   
insert into cobis..cl_ttransaccion values (7797,       'Administracion/Dias Clausula Aceleratoria',                        '7797',   'Administracion/Dias Clausula Aceleratoria')                                                                                                                                                                                                                    
insert into cobis..cl_ttransaccion values (7798,       'Operaciones/Traslado de Cartera',                                  '7798',   'Operaciones/Traslado de Cartera')                                                                                                                                                                                                                              
insert into cobis..cl_ttransaccion values (7799,       'Operaciones/Clausula Aceleratoria',                                '7799',   'Operaciones/Clausula Aceleratoria')                                                                                                                                                                                                                            
insert into cobis..cl_ttransaccion values (7800,       'Operaciones/Creacion/Amortizacion/Adicionales/Renta',              '7800',   'Operaciones/Creacion/Amortizacion/Adicionales/Renta')                                                                                                                                                                                                          
go

delete cobis..cl_ttransaccion
 where tn_trn_code in(7801,7802,7803,7804,7805,7806,7807,7808,7809,7810,7811,7812,7813,7814,7815,7816,7817,7818,7819,7820,7821,
                      7822,7823,7824,7825,7826,7827,7828,7829,7830,7831,7832,7833,7834,7835,7836,7837,7838,7839,7840,7841,7842,
                      7843,7844,7845,7846,7847,7848,7849,7850,7851,7852,7853,7854,7855,7856,7857,7858,7859,7860,7861,7862,7863,
                      7864,7865,7866,7867,7868,7869,7870,7871,7872,7873,7882,7883,7884,7885,7886,7887,7888,7889,7890,7891,7892,
                      7893,7894,7895,7896,7897,7898,7899,7900,7901,7902,7903,7904,7905,7906,7907,7908,7909,7910,7911,7912,7913,
                      7914,7915,7916,7917,7918,7919,7920,7921,7922,7923,7924,7925,7926,7927,7928,7929,7930,7931,7932,7933,7934,
                      7935,7936,7937,7938,7939,7940,7941,7942,7943,7944,7945,7946,7947,7948,7949,7950,7951,7952,7953,7954,7955,
                      7956,7957,7958,7959,7960,7961,7962,7964,7965,7967,7970,7971,7972,7973,7974,7975,7976,7977,7978,7979,7980,
                      7981,7982,7983,7984,7985,7986,7987,7999,14775,14776,14777,7966,7968,74668, 7969,7297,7295,7296,7299,77505,
					  77506)
go

insert into cobis..cl_ttransaccion values (7801,       'Consultas/(Vencimientos/Reajustes Futuros)/Imprimir',              '7801',   'Consultas/(Vencimientos/Reajustes Futuros)/Imprimir')                                                                                                                                                                                                          
insert into cobis..cl_ttransaccion values (7802,       'Consultas/Datos Operaciones Activas - Pasivas',                    '7802',   'Consultas/Datos Operaciones Activas - Pasivas')                                                                                                                                                                                                                
insert into cobis..cl_ttransaccion values (7803,       'Consultas/Datos Operaciones Activas - Pasivas/Buscar',             '7803',   'Consultas/Datos Operaciones Activas - Pasivas/Buscar')                                                                                                                                                                                                         
insert into cobis..cl_ttransaccion values (7804,       'Consultas/Datos Operaciones Activas - Pasivas/Siguiente',          '7804',   'Consultas/Datos Operaciones Activas - Pasivas/Siguiente')                                                                                                                                                                                                      
insert into cobis..cl_ttransaccion values (7805,       'Consultas/Datos Operaciones Activas - Pasivas/Escoger',            '7805',   'Consultas/Datos Operaciones Activas - Pasivas/Escoger')                                                                                                                                                                                                        
insert into cobis..cl_ttransaccion values (7806,       'Consultas/Datos Operaciones Activas - Pasivas/Imprimir',           '7806',   'Consultas/Datos Operaciones Activas - Pasivas/Imprimir')                                                                                                                                                                                                       
insert into cobis..cl_ttransaccion values (7807,       'Consultas/Datos Operaciones Activas - Pasivas/Escoger/Buscar',     '7807',   'Consultas/Datos Operaciones Activas - Pasivas/Escoger/Buscar')                                                                                                                                                                                                 
insert into cobis..cl_ttransaccion values (7808,       'Consultas/Datos Operaciones Activas - Pasivas/Escoger/Siguiente',  '7808',   'Consultas/Datos Operaciones Activas - Pasivas/Escoger/Siguiente')                                                                                                                                                                                              
insert into cobis..cl_ttransaccion values (7809,       'Operaciones/Pagos Masivos',                                        '7809',   'Operaciones/Pagos Masivos')                                                                                                                                                                                                                                    
insert into cobis..cl_ttransaccion values (7810,       'Operaciones/Pagos Masivos/Convenios/Generar Archivo Plano',        '7810',   'Operaciones/Pagos Masivos/Convenios/Generar Archivo Plano')                                                                                                                                                                                                    
insert into cobis..cl_ttransaccion values (7811,       'Operaciones/Pagos Masivos/Convenios/Generar Archivo Plano/Imprim', '7811',   'Operaciones/Pagos Masivos/Convenios/Generar Archivo Plano/Imprimir')                                                                                                                                                                                           
insert into cobis..cl_ttransaccion values (7812,       'Operaciones/Pagos Masivos/Convenios/Crear Lote',                   '7812',   'Operaciones/Pagos Masivos/Convenios/Crear Lote')                                                                                                                                                                                                               
insert into cobis..cl_ttransaccion values (7813,       'Operaciones/Pagos Masivos/Convenios/Crear Lote/Desde A:/',         '7813',   'Operaciones/Pagos Masivos/Convenios/Crear Lote/Desde A:/')                                                                                                                                                                                                     
insert into cobis..cl_ttransaccion values (7814,       'Operaciones/Renovaciones',                                         '7814',   'Operaciones/Renovaciones')                                                                                                                                                                                                                                     
insert into cobis..cl_ttransaccion values (7815,       'Operaciones/Renovaciones/Buscar',                                  '7815',   'Operaciones/Renovaciones/Buscar')                                                                                                                                                                                                                              
insert into cobis..cl_ttransaccion values (7816,       'Operaciones/Renovaciones/Siguiente',                               '7816',   'Operaciones/Renovaciones/Siguiente')                                                                                                                                                                                                                           
insert into cobis..cl_ttransaccion values (7817,       'Operaciones/Renovaciones/Escoger',                                 '7817',   'Operaciones/Renovaciones/Escoger')                                                                                                                                                                                                                             
insert into cobis..cl_ttransaccion values (7818,       'Operaciones/Renovaciones/Imprimir',                                '7818',   'Operaciones/Renovaciones/Imprimir')                                                                                                                                                                                                                            
insert into cobis..cl_ttransaccion values (7819,       'Operaciones/Renovaciones/Escoger/Renovar',                         '7819',   'Operaciones/Renovaciones/Escoger/Renovar')                                                                                                                                                                                                                     
insert into cobis..cl_ttransaccion values (7820,       'Operaciones/(Pagos/Cancelaciones/Precancelaciones)/Escoger/Trans', '7820',   'Operaciones/(Pagos/Cancelaciones/Precancelaciones)/Escoger/Transmitir(Factoring)')                                                                                                                                                                             
insert into cobis..cl_ttransaccion values (7821,       'Operaciones/(Pagos/Cancelaciones/Precancelaciones)/Escoger/Impri', '7821',   'Operaciones/(Pagos/Cancelaciones/Precancelaciones)/Escoger/Imprimir(Factoring)')                                                                                                                                                                               
insert into cobis..cl_ttransaccion values (7822,       'Administracion/(Valores / Tasas a Aplicar)/Eliminar',              '7822',   'Administracion/(Valores / Tasas a Aplicar)/Eliminar')                                                                                                                                                                                                          
insert into cobis..cl_ttransaccion values (7823,       'Operaciones/Creacion/Amortizacion/Capitalizacion/Buscar',          '7823',   'Operaciones/Creacion/Amortizacion/Capitalizacion/Buscar')                                                                                                                                                                                                      
insert into cobis..cl_ttransaccion values (7824,       'Operaciones/Creacion/Amortizacion/Capitalizacion/Siguiente',       '7824',   'Operaciones/Creacion/Amortizacion/Capitalizacion/Siguiente')                                                                                                                                                                                                   
insert into cobis..cl_ttransaccion values (7825,       'Operaciones/Creacion/Amortizacion/Capitalizacion/Transmitir',      '7825',   'Operaciones/Creacion/Amortizacion/Capitalizacion/Transmitir')                                                                                                                                                                                                  
insert into cobis..cl_ttransaccion values (7826,       'Operaciones/Creacion/Amortizacion/Capitalizacion/Modificar',       '7826',   'Operaciones/Creacion/Amortizacion/Capitalizacion/Modificar')                                                                                                                                                                                                   
insert into cobis..cl_ttransaccion values (7827,       'Operaciones/Creacion/Amortizacion/Capitalizacion/Eliminar',        '7827',   'Operaciones/Creacion/Amortizacion/Capitalizacion/Eliminar')                                                                                                                                                                                                    
insert into cobis..cl_ttransaccion values (7828,       'Operaciones/Creacion/Gerente/Modificar',                           '7828',   'Operaciones/Creacion/Gerente/Modificar')                                                                                                                                                                                                                       
insert into cobis..cl_ttransaccion values (7829,       'Consultas/Consultas ACH',                                          '7829',   'Consultas/Consultas ACH')                                                                                                                                                                                                                                      
insert into cobis..cl_ttransaccion values (7830,       'Administracion/Dias Clausula Aceleratoria/Buscar',                 '7830',   'Administracion/Dias Clausula Aceleratoria/Buscar')                                                                                                                                                                                                             
insert into cobis..cl_ttransaccion values (7831,       'Administracion/Dias Clausula Aceleratoria/Modificar',              '7831',   'Administracion/Dias Clausula Aceleratoria/Modificar')                                                                                                                                                                                                          
insert into cobis..cl_ttransaccion values (7832,       'Administracion/Dias Clausula Aceleratoria/Eliminar',               '7832',   'Administracion/Dias Clausula Aceleratoria/Eliminar')                                                                                                                                                                                                           
insert into cobis..cl_ttransaccion values (7833,       'Administracion/Dias Clausula Aceleratoria/Trasmitir',              '7833',   'Administracion/Dias Clausula Aceleratoria/Trasmitir')                                                                                                                                                                                                          
insert into cobis..cl_ttransaccion values (7834,       'Consultas/Consultas ACH/Buscar',                                   '7834',   'Consultas/Consultas ACH/Buscar')                                                                                                                                                                                                                               
insert into cobis..cl_ttransaccion values (7835,       'Operaciones/Creacion/Asociar/Buscar',                              '7835',   'Operaciones/Creacion/Asociar/Buscar')                                                                                                                                                                                                                          
insert into cobis..cl_ttransaccion values (7836,       'Operaciones/Creacion/Asociar/siguiente',                           '7836',   'Operaciones/Creacion/Asociar/siguiente')                                                                                                                                                                                                                       
insert into cobis..cl_ttransaccion values (7837,       'Operaciones/Creacion/Asociar/Aceptar',                             '7837',   'Operaciones/Creacion/Asociar/Aceptar')                                                                                                                                                                                                                         
insert into cobis..cl_ttransaccion values (7838,       'Operaciones/Creacion/Asociar/Cancelar',                            '7838',   'Operaciones/Creacion/Asociar/Cancelar')                                                                                                                                                                                                                        
insert into cobis..cl_ttransaccion values (7839,       'Operaciones/Actualizacion/Escoger/Asociar/Buscar',                 '7839',   'Operaciones/Actualizacion/Escoger/Asociar/Buscar')                                                                                                                                                                                                             
insert into cobis..cl_ttransaccion values (7840,       'Operaciones/Actualizacion/Escoger/Asociar/siguiente',              '7840',   'Operaciones/Actualizacion/Escoger/Asociar/siguiente')                                                                                                                                                                                                          
insert into cobis..cl_ttransaccion values (7841,       'Operaciones/Actualizacion/Escoger/Asociar/Aceptar',                '7841',   'Operaciones/Actualizacion/Escoger/Asociar/Aceptar')                                                                                                                                                                                                            
insert into cobis..cl_ttransaccion values (7842,       'Operaciones/Actualizacion/Escoger/Asociar/Cancelar',               '7842',   'Operaciones/Actualizacion/Escoger/Asociar/Cancelar')                                                                                                                                                                                                           
insert into cobis..cl_ttransaccion values (7843,       'Operaciones/Traslado de Cartera/Buscar',                           '7843',   'Operaciones/Traslado de Cartera/Buscar')                                                                                                                                                                                                                       
insert into cobis..cl_ttransaccion values (7844,       'Operaciones/Traslado de Cartera/Siguiente',                        '7844',   'Operaciones/Traslado de Cartera/Siguiente')                                                                                                                                                                                                                    
insert into cobis..cl_ttransaccion values (7845,       'Operaciones/Traslado de Cartera/Eliminar',                         '7845',   'Operaciones/Traslado de Cartera/Eliminar')                                                                                                                                                                                                                     
insert into cobis..cl_ttransaccion values (7846,       'Operaciones/Traslado de Cartera/Transmitir',                       '7846',   'Operaciones/Traslado de Cartera/Transmitir')                                                                                                                                                                                                                   
insert into cobis..cl_ttransaccion values (7847,       'Operaciones/Clausula Aceleratoria/Buscar',                         '7847',   'Operaciones/Clausula Aceleratoria/Buscar')                                                                                                                                                                                                                     
insert into cobis..cl_ttransaccion values (7848,       'Operaciones/Clausula Aceleratoria/Siguiente',                      '7848',   'Operaciones/Clausula Aceleratoria/Siguiente')                                                                                                                                                                                                                  
insert into cobis..cl_ttransaccion values (7849,       'Operaciones/Clausula Aceleratoria/Escoger',                        '7849',   'Operaciones/Clausula Aceleratoria/Escoger')                                                                                                                                                                                                                    
insert into cobis..cl_ttransaccion values (7850,       'Operaciones/Clausula Aceleratoria/Imprimir',                       '7850',   'Operaciones/Clausula Aceleratoria/Imprimir')                                                                                                                                                                                                                   
insert into cobis..cl_ttransaccion values (7851,       'Operaciones/Clausula Aceleratoria/Escoger/Aplicar',                '7851',   'Operaciones/Clausula Aceleratoria/Escoger/Aplicar')                                                                                                                                                                                                            
insert into cobis..cl_ttransaccion values (7852,       'Operaciones/Prorroga',                                             '7852',   'Operaciones/Prorroga')                                                                                                                                                                                                                                         
insert into cobis..cl_ttransaccion values (7853,       'Operaciones/Prorroga/Buscar',                                      '7853',   'Operaciones/Prorroga/Buscar')                                                                                                                                                                                                                                  
insert into cobis..cl_ttransaccion values (7854,       'Operaciones/Prorroga/Siguiente',                                   '7854',   'Operaciones/Prorroga/Siguiente')                                                                                                                                                                                                                               
insert into cobis..cl_ttransaccion values (7855,       'Operaciones/Prorroga/Escoger',                                     '7855',   'Operaciones/Prorroga/Escoger')                                                                                                                                                                                                                                 
insert into cobis..cl_ttransaccion values (7856,       'Operaciones/Prorroga/Imprimir',                                    '7856',   'Operaciones/Prorroga/Imprimir')                                                                                                                                                                                                                                
insert into cobis..cl_ttransaccion values (7857,       'Operaciones/Prorroga/Escoger/Crear',                               '7857',   'Operaciones/Prorroga/Escoger/Crear')                                                                                                                                                                                                                           
insert into cobis..cl_ttransaccion values (7858,       'Operaciones/Prorroga/Escoger/Transmitir',                          '7858',   'Operaciones/Prorroga/Escoger/Transmitir')                                                                                                                                                                                                                      
insert into cobis..cl_ttransaccion values (7859,       'Operaciones/Pagos Masivos/Convenios/Crear Lote/Negociar',          '7859',   'Operaciones/Pagos Masivos/Convenios/Crear Lote/Negociar')                                                                                                                                                                                                      
insert into cobis..cl_ttransaccion values (7860,       'Operaciones/Pagos Masivos/Convenios/Crear Lote/Trasmitir',         '7860',   'Operaciones/Pagos Masivos/Convenios/Crear Lote/Trasmitir')                                                                                                                                                                                                     
insert into cobis..cl_ttransaccion values (7861,       'Operaciones/Pagos Masivos/Convenios/Crear Lote/Imprimir',          '7861',   'Operaciones/Pagos Masivos/Convenios/Crear Lote/Imprimir')                                                                                                                                                                                                      
insert into cobis..cl_ttransaccion values (7862,       'Operaciones/Pagos Masivos/Convenios/Crear Lote/Actualizar',        '7862',   'Operaciones/Pagos Masivos/Convenios/Crear Lote/Actualizar')                                                                                                                                                                                                    
insert into cobis..cl_ttransaccion values (7863,       'Operaciones/Pagos Masivos/Convenios/Crear Lote/Aceptar',           '7863',   'Operaciones/Pagos Masivos/Convenios/Crear Lote/Aceptar')                                                                                                                                                                                                       
insert into cobis..cl_ttransaccion values (7864,       'Operaciones/Pagos Masivos/Convenios/Modificar Lote',               '7864',   'Operaciones/Pagos Masivos/Convenios/Modificar Lote')                                                                                                                                                                                                           
insert into cobis..cl_ttransaccion values (7865,       'Operaciones/Pagos Masivos/Geenrales',                              '7865',   'Operaciones/Pagos Masivos/Geenrales')                                                                                                                                                                                                                          
insert into cobis..cl_ttransaccion values (7866,       'Operaciones/Pagos Masivos/Geenrales/Crear Lote',                   '7866',   'Operaciones/Pagos Masivos/Geenrales/Crear Lote')                                                                                                                                                                                                               
insert into cobis..cl_ttransaccion values (7867,       'Operaciones/Pagos Masivos/Geenrales/Crear Lote/Desde A:/',         '7867',   'Operaciones/Pagos Masivos/Geenrales/Crear Lote/Desde A:/')                                                                                                                                                                                                     
insert into cobis..cl_ttransaccion values (7868,       'Operaciones/Castigos/Carga de Obligaciones Para Castigar/Desde A', '7868',   'Operaciones/Castigos/Carga de Obligaciones Para Castigar/Desde A:/')                                                                                                                                                                                           
insert into cobis..cl_ttransaccion values (7869,       'Operaciones/Pagos Masivos/Geenrales/Crear Lote/Trasmitir',         '7869',   'Operaciones/Pagos Masivos/Geenrales/Crear Lote/Trasmitir')                                                                                                                                                                                                     
insert into cobis..cl_ttransaccion values (7870,       'Operaciones/Pagos Masivos/Geenrales/Crear Lote/Imprimir',          '7870',   'Operaciones/Pagos Masivos/Geenrales/Crear Lote/Imprimir')                                                                                                                                                                                                      
insert into cobis..cl_ttransaccion values (7871,       'Operaciones/Castigos/Carga de Obligaciones Para Castigar/Trasmit', '7871',   'Operaciones/Castigos/Carga de Obligaciones Para Castigar/Trasmitir')                                                                                                                                                                                           
insert into cobis..cl_ttransaccion values (7872,       'Operaciones/Castigos',                                             '7872',   'Operaciones/Castigos')                                                                                                                                                                                                                                         
insert into cobis..cl_ttransaccion values (7873,       'Operaciones/Castigos/Carga de Obligaciones Para Castigar/Elimina', '7873',   'Operaciones/Castigos/Carga de Obligaciones Para Castigar/Eliminar')                                                                                                                                                                                            
insert into cobis..cl_ttransaccion values (7882,       'Operaciones/Creacion/Amortizacion/Capitalizacion',                 '7882',   'Operaciones/Creacion/Amortizacion/Capitalizacion')                                                                                                                                                                                                             
insert into cobis..cl_ttransaccion values (7883,       'Administracion/Lineas de Credito',                                 '7883',   'Administracion/Lineas de Credito')                                                                                                                                                                                                                             
insert into cobis..cl_ttransaccion values (7884,       'Administracion/Rubros',                                            '7884',   'Administracion/Rubros')                                                                                                                                                                                                                                        
insert into cobis..cl_ttransaccion values (7885,       'Operaciones/Pagos Masivos/Convenios',                              '7885',   'Operaciones/Pagos Masivos/Convenios')                                                                                                                                                                                                                          
insert into cobis..cl_ttransaccion values (7886,       'Operaciones/Pagos Masivos/Generales/Modificar Lote',               '7886',   'Operaciones/Pagos Masivos/Generales/Modificar Lote')                                                                                                                                                                                                           
insert into cobis..cl_ttransaccion values (7887,       'Operaciones/(Pagos/Cancelaciones/Precancelaciones)/Condonaciones', '7887',   'Operaciones/(Pagos/Cancelaciones/Precancelaciones)/Condonaciones')                                                                                                                                                                                             
insert into cobis..cl_ttransaccion values (7888,       'Operaciones/(Pagos/Cancelaciones/Precancelaciones)/Sobrante',      '7888',   'Operaciones/(Pagos/Cancelaciones/Precancelaciones)/Sobrante')                                                                                                                                                                                                  
insert into cobis..cl_ttransaccion values (7889,       'Operaciones/(Pagos/Cancelaciones/Precancelaciones)/Prioridades',   '7889',   'Operaciones/(Pagos/Cancelaciones/Precancelaciones)/Prioridades')                                                                                                                                                                                               
insert into cobis..cl_ttransaccion values (7890,       'Administracion/Asociacion de Rubros Cartera-Credito',              '7890',   'Administracion/Asociacion de Rubros Cartera-Credito')                                                                                                                                                                                                          
insert into cobis..cl_ttransaccion values (7891,       'Administracion/Asociacion de Rubros Cartera-Credito/Buscar',       '7891',   'Administracion/Asociacion de Rubros Cartera-Credito/Buscar')                                                                                                                                                                                                   
insert into cobis..cl_ttransaccion values (7892,       'Administracion/Asociacion de Rubros Cartera-Credito/Siguientes',   '7892',   'Administracion/Asociacion de Rubros Cartera-Credito/Siguientes')                                                                                                                                                                                               
insert into cobis..cl_ttransaccion values (7893,       'Administracion/Asociacion de Rubros Cartera-Credito/Modificar',    '7893',   'Administracion/Asociacion de Rubros Cartera-Credito/Modificar')                                                                                                                                                                                                
insert into cobis..cl_ttransaccion values (7894,       'Administracion/Asociacion de Rubros Cartera-Credito/Eliminar',     '7894',   'Administracion/Asociacion de Rubros Cartera-Credito/Eliminar')                                                                                                                                                                                                 
insert into cobis..cl_ttransaccion values (7895,       'Administracion/Asociacion de Rubros Cartera-Credito/Transmitir',   '7895',   'Administracion/Asociacion de Rubros Cartera-Credito/Transmitir')                                                                                                                                                                                               
insert into cobis..cl_ttransaccion values (7896,       'Administracion/Asociacion de Rubros Cartera-Credito/Limpiar',      '7896',   'Administracion/Asociacion de Rubros Cartera-Credito/Limpiar')                                                                                                                                                                                                  
insert into cobis..cl_ttransaccion values (7897,       'Administracion/Asociacion de Rubros Cartera-Credito/Salir',        '7897',   'Administracion/Asociacion de Rubros Cartera-Credito/Salir')                                                                                                                                                                                                    
insert into cobis..cl_ttransaccion values (7898,       'Operaciones/Pagos Masivos/Convenios/Crear Lote/Eliminar',          '7898',   'Operaciones/Pagos Masivos/Convenios/Crear Lote/Eliminar')                                                                                                                                                                                                      
insert into cobis..cl_ttransaccion values (7899,       'Operaciones/Pagos Masivos/Generales/Crear Lote/Eliminar',          '7899',   'Operaciones/Pagos Masivos/Generales/Crear Lote/Eliminar')                                                                                                                                                                                                      
insert into cobis..cl_ttransaccion values (7900,       'Operaciones/(Pagos/Cancelaciones/Precancelaciones)/Condonaciones', '7900',   'Operaciones/(Pagos/Cancelaciones/Precancelaciones)/Condonaciones')                                                                                                                                                                                             
insert into cobis..cl_ttransaccion values (7901,       'Operaciones/Actualizacion/Escoger/Datos Reestructuracion',         '7901',   'Operaciones/Actualizacion/Escoger/Datos Reestructuracion')                                                                                                                                                                                                     
insert into cobis..cl_ttransaccion values (7902,       'CONSULTA DE OPERACIONES',                                          '7902',   'CONSULTA DE OPERACIONES')                                                                                                                                                                                                                                      
insert into cobis..cl_ttransaccion values (7903,       'DETALLE DEL ESTADO DE LA OPERACION',                               '7903',   'DETALLE DEL ESTADO DE LA OPERACION')                                                                                                                                                                                                                           
insert into cobis..cl_ttransaccion values (7904,       'DETALLE DE LOS ABONOS DE LA OPERACION',                            '7904',   'DETALLE DE LOS ABONOS DE LA OPERACION')                                                                                                                                                                                                                        
insert into cobis..cl_ttransaccion values (7905,       'RUBROS DE LA OPERACION',                                           '7905',   'RUBROS DE LA OPERACION')                                                                                                                                                                                                                                       
insert into cobis..cl_ttransaccion values (7906,       'DEUDORES DE LA OPERACION',                                         '7906',   'DEUDORES DE LA OPERACION')                                                                                                                                                                                                                                     
insert into cobis..cl_ttransaccion values (7907,       'CONDICIONES DE PAGO DE LA OPERACION',                              '7907',   'CONDICIONES DE PAGO DE LA OPERACION')                                                                                                                                                                                                                          
insert into cobis..cl_ttransaccion values (7908,       'ABONOS DE LA OPERACION',                                           '7908',   'ABONOS DE LA OPERACION')                                                                                                                                                                                                                                       
insert into cobis..cl_ttransaccion values (7909,       'GARANTIAS DE LA OPERACION',                                        '7909',   'GARANTIAS DE LA OPERACION')                                                                                                                                                                                                                                    
insert into cobis..cl_ttransaccion values (7910,       'INSTRUCCIONES OPERATIVAS DE LA OPERACION',                         '7910',   'INSTRUCCIONES OPERATIVAS DE LA OPERACION')                                                                                                                                                                                                                     
insert into cobis..cl_ttransaccion values (7911,       'Consultas/Prepagos pasivas',                                       '7911',   'Consultas/Prepagos pasivas')                                                                                                                                                                                                                                   
insert into cobis..cl_ttransaccion values (7912,       'Operaciones/Banca de Segundo Piso/Aplicaciones y Rechazos/Buscar', '7912',   'Operaciones/Banca de Segundo Piso/Aplicaciones y Rechazos/Buscar')                                                                                                                                                                                             
insert into cobis..cl_ttransaccion values (7913,       'Operaciones/Banca de Segundo Piso/Aplicaciones y Rechazos/Pagar',  '7913',   'Operaciones/Banca de Segundo Piso/Aplicaciones y Rechazos/Pagar')                                                                                                                                                                                              
insert into cobis..cl_ttransaccion values (7914,       'Operaciones/Banca de Segundo Piso/Aplicaciones y Rechazos/Elimin', '7914',   'Operaciones/Banca de Segundo Piso/Aplicaciones y Rechazos/Eliminar')                                                                                                                                                                                           
insert into cobis..cl_ttransaccion values (7915,       'Operaciones/Banca de Segundo Piso/Impresion F-127',                '7915',   'Operaciones/Banca de Segundo Piso/Impresión F-127')                                                                                                                                                                                                            
insert into cobis..cl_ttransaccion values (7916,       'Operaciones/Banca de Segundo Piso/Aplicaciones y Rechazos/Limpia', '7916',   'Operaciones/Banca de Segundo Piso/Aplicaciones y Rechazos/Limpiar')                                                                                                                                                                                            
insert into cobis..cl_ttransaccion values (7917,       'Operaciones/Banca de Segundo Piso/Aplicaciones y Rechazos/Marcar', '7917',   'Operaciones/Banca de Segundo Piso/Aplicaciones y Rechazos/Marcar Rechazos')                                                                                                                                                                                    
insert into cobis..cl_ttransaccion values (7918,       'Operaciones/Banca de Segundo Piso/Impresion F127/Buscar',          '7918',   'Operaciones/Banca de Segundo Piso/Impresión F127/Buscar')                                                                                                                                                                                                      
insert into cobis..cl_ttransaccion values (7919,       'ESTADO ACTUAL DE LA OPERACION',                                    '7919',   'ESTADO ACTUAL DE LA OPERACION')                                                                                                                                                                                                                                
insert into cobis..cl_ttransaccion values (7920,       'Operaciones/Banca de Segundo Piso',                                '7920',   'Operaciones/Banca de Segundo Piso')                                                                                                                                                                                                                            
insert into cobis..cl_ttransaccion values (7921,       'Operaciones/Banca de Segundo Piso/Aplicaciones y Rechazos',        '7921',   'Operaciones/Banca de Segundo Piso/Aplicaciones y Rechazos')                                                                                                                                                                                                    
insert into cobis..cl_ttransaccion values (7922,       'BUSQUEDA GENERAL DE OPERACIONES',                                  '7922',   'BUSQUEDA GENERAL DE OPERACIONES')                                                                                                                                                                                                                              
insert into cobis..cl_ttransaccion values (7923,       'Consultas/Datos del Maestro',                                      '7923',   'Consultas/Datos del Maestro')                                                                                                                                                                                                                                  
insert into cobis..cl_ttransaccion values (7924,       'Operaciones/Banca de Segundo Piso/Consultas',                      '7924',   'Operaciones/Banca de Segundo Piso/Consultas')                                                                                                                                                                                                                  
insert into cobis..cl_ttransaccion values (7925,       'Operaciones/Banca de Segundo Piso/Prepagos pasivas',               '7925',   'Operaciones/Banca de Segundo Piso/Prepagos pasivas')                                                                                                                                                                                                           
insert into cobis..cl_ttransaccion values (7926,       'Operaciones/Banca de Segundo Piso/Aplicaciones y Rechazos/Actual', '7926',   'Operaciones/Banca de Segundo Piso/Aplicaciones y Rechazos/Actualizar')                                                                                                                                                                                         
insert into cobis..cl_ttransaccion values (7927,       'Operaciones/Reajustes Masivos/Registrar Mensaje para Carta de Av', '7927',   'Operaciones/Reajustes Masivos/Registrar Mensaje para Carta de Aviso')                                                                                                                                                                                          
insert into cobis..cl_ttransaccion values (7928,       'Operaciones/Reajustes Masivos/Datos Para Carta de Aviso Al Clien', '7928',   'Operaciones/Reajustes Masivos/Datos Para Carta de Aviso Al Cliente/Trasmitir')                                                                                                                                                                                 
insert into cobis..cl_ttransaccion values (7929,       'Operaciones/Reajustes Masivos/Datos Para Carta de Aviso Al Clien', '7929',   'Operaciones/Reajustes Masivos/Datos Para Carta de Aviso Al Cliente/Limpiar')                                                                                                                                                                                   
insert into cobis..cl_ttransaccion values (7930,       'Operaciones/Reajustes Masivos/Datos Para Carta de Aviso Al Clien', '7930',   'Operaciones/Reajustes Masivos/Datos Para Carta de Aviso Al Cliente/salir')                                                                                                                                                                                     
insert into cobis..cl_ttransaccion values (7931,       'AVISOS/REGISTRADOS/BUSCAR',                                        '7931',   'AVISOS/REGISTRADOS/BUSCAR')                                                                                                                                                                                                                                    
insert into cobis..cl_ttransaccion values (7932,       'AVISOS/AVISOS REGISTRADOS/GENERAR',                                '7932',   'AVISOS/AVISOS REGISTRADOS/GENERAR')                                                                                                                                                                                                                            
insert into cobis..cl_ttransaccion values (7933,       'AVISOS/AVISOS REGISTRADOS/ LIMPIAR',                               '7933',   'AVISOS/AVISOS REGISTRADOS/ LIMPIAR')                                                                                                                                                                                                                           
insert into cobis..cl_ttransaccion values (7934,       'AVISOS/AVISOS REGISTRADOS/SALIR',                                  '7934',   'AVISOS/AVISOS REGISTRADOS/SALIR')                                                                                                                                                                                                                              
insert into cobis..cl_ttransaccion values (7935,       'OPERACIONES/DEVOLUCION COMISIONES',                                '7935',   'OPERACIONES/DEVOLUCION COMISIONES')                                                                                                                                                                                                                            
insert into cobis..cl_ttransaccion values (7936,       'OPERACIONES/DEVOLUCION COMISIONES/BUSCAR',                         '7936',   'OPERACIONES/DEVOLUCION COMISIONES/BUSCAR')                                                                                                                                                                                                                     
insert into cobis..cl_ttransaccion values (7937,       'OPERACIONES/DEVOLUCION COMISIONES/DEVOLVER',                       '7937',   'OPERACIONES/DEVOLUCION COMISIONES/DEVOLVER')                                                                                                                                                                                                                   
insert into cobis..cl_ttransaccion values (7938,       'OPERACIONES/DEVOLUCION COMISIONES/LIMPIAR',                        '7938',   'OPERACIONES/DEVOLUCION COMISIONES/LIMPIAR')                                                                                                                                                                                                                    
insert into cobis..cl_ttransaccion values (7939,       'OPERACIONES/DEVOLUCION COMISIONES/SALIR',                          '7939',   'OPERACIONES/DEVOLUCION COMISIONES/SALIR')                                                                                                                                                                                                                      
insert into cobis..cl_ttransaccion values (7940,       'Operaciones/Banca de Segundo piso/Resumen Movimientos Diarios',    '7940',   'Operaciones/Banca de Segundo piso/Resumen Movimientos Diarios')                                                                                                                                                                                                
insert into cobis..cl_ttransaccion values (7941,       'Operaciones/Banca de Segundo piso/Resumen Movimientos Diarios/Bu', '7941',   'Operaciones/Banca de Segundo piso/Resumen Movimientos Diarios/Buscar')                                                                                                                                                                                         
insert into cobis..cl_ttransaccion values (7942,       'Operaciones/Banca de Segundo piso/Resumen Movimientos Diarios/Im', '7942',   'Operaciones/Banca de Segundo piso/Resumen Movimientos Diarios/Imprimir')                                                                                                                                                                                       
insert into cobis..cl_ttransaccion values (7943,       'Operaciones/Banca de Segundo piso/Resumen Movimientos Diarios/Li', '7943',   'Operaciones/Banca de Segundo piso/Resumen Movimientos Diarios/Limpiar')                                                                                                                                                                                        
insert into cobis..cl_ttransaccion values (7944,       'Operaciones/Banca de Segundo piso/Resumen Movimientos Diarios/Sa', '7944',   'Operaciones/Banca de Segundo piso/Resumen Movimientos Diarios/Salir')                                                                                                                                                                                          
insert into cobis..cl_ttransaccion values (7945,       'Operaciones/Banca de Segundo piso/Resumen Movimientos Diarios/Re', '7945',   'Operaciones/Banca de Segundo piso/Resumen Movimientos Diarios/Respaldar')                                                                                                                                                                                      
insert into cobis..cl_ttransaccion values (7946,       'MENSAJES FACTURACION PERIODICA',                                   '7946',   'MENSAJES FACTURACION PERIODICA')                                                                                                                                                                                                                               
insert into cobis..cl_ttransaccion values (7947,       'MENSAJES FACTURACION PERIODICA/BUSCAR',                            '7947',   'MENSAJES FACTURACION PERIODICA/BUSCAR')                                                                                                                                                                                                                        
insert into cobis..cl_ttransaccion values (7948,       'MENSAJES FACTURACION PERIODICA/TRANSMITIR',                        '7948',   'MENSAJES FACTURACION PERIODICA/TRANSMITIR')                                                                                                                                                                                                                    
insert into cobis..cl_ttransaccion values (7949,       'MENSAJES FACTURACION PERIODICA/MODIFICAR',                         '7949',   'MENSAJES FACTURACION PERIODICA/MODIFICAR')                                                                                                                                                                                                                     
insert into cobis..cl_ttransaccion values (7950,       'MENSAJES FACTURACION PERIODICA/ELIMINAR',                          '7950',   'MENSAJES FACTURACION PERIODICA/ELIMINAR')                                                                                                                                                                                                                      
insert into cobis..cl_ttransaccion values (7951,       'MENSAJES FACTURACION PERIODICA/LIMPIAR',                           '7951',   'MENSAJES FACTURACION PERIODICA/LIMPIAR')                                                                                                                                                                                                                       
insert into cobis..cl_ttransaccion values (7952,       'MENSAJES  FACTURACION PERIODICA/SALIR',                            '7952',   'MENSAJES  FACTURACION PERIODICA/SALIR')                                                                                                                                                                                                                        
insert into cobis..cl_ttransaccion values (7953,       'Operaciones/Actualizacion/Asig_Codeu',                             '7953',   'Operaciones/Actualizaciion/Asig_Codeu')                                                                                                                                                                                                                        
insert into cobis..cl_ttransaccion values (7954,       'Operaciones/Actualizacion/Elim_Codeu',                             '7954',   'Operaciones/Actualizacion/Elim_Codeu')                                                                                                                                                                                                                         
insert into cobis..cl_ttransaccion values (7955,       'Operaciones/Reajustes Masivos/Impresion Carta de Aviso',           '7955',   'Operaciones/Reajustes Masivos/Impresion Carta de Aviso')                                                                                                                                                                                                       
insert into cobis..cl_ttransaccion values (7956,       'OPERACIONES/TRASLADO DE INTERESES CORRIENTE',                      '7956',   'OPERACIONES/TRASLADO DE INTERESES CORRIENTE')                                                                                                                                                                                                                  
insert into cobis..cl_ttransaccion values (7957,       'OPERACIONES/FECHA VALOR/MASIVO',                                   '7957',   'OPERACIONES/FECHA VALOR/MASIVO')                                                                                                                                                                                                                               
insert into cobis..cl_ttransaccion values (7958,       'OPERACIONES/FECHA VALOR/MASIBVO/DESDE A',                          '7958',   'OPERACIONES/FECHA VALOR/MASIBVO/DESDE A')                                                                                                                                                                                                                      
insert into cobis..cl_ttransaccion values (7959,       'OPERACIONES/FECHA VALOR/MASIVO/ELIMINAR',                          '7959',   'OPERACIONES/FECHA VALOR/MASIVO/ELIMINAR')                                                                                                                                                                                                                      
insert into cobis..cl_ttransaccion values (7960,       'OPERACIONES/FECHA VALOR/MASIVO/ELIMINAR',                          '7960',   'OPERACIONES/FECHA VALOR/MASIVO/ELIMINAR')                                                                                                                                                                                                                      
insert into cobis..cl_ttransaccion values (7961,       'OPERACIONES/FECHA VALOR/MASIVO/BUSCAR',                            '7961',   'OPERACIONES/FECHA VALOR/MASIVO/BUSCAR')                                                                                                                                                                                                                        
insert into cobis..cl_ttransaccion values (7962,       'OPERACIONES/ACTUALIZACION/ RUBROS',                                '7962',   'OPERACIONES/ACTUALIZACION/ RUBROS')                                                                                                                                                                                                                            
insert into cobis..cl_ttransaccion values (7964,       'OPERACIONES/ACTUALIZACION/PARAMETROS/DIR CLIENTE',                 '7964',   'OPERACIONES/ACTUALIZACION/PARAMETROS/DIR CLIENTE')                                                                                                                                                                                                             
insert into cobis..cl_ttransaccion values (7965,       'CONSULTAS/INFORMES DEL CLIENTE',                                   '7965',   'CONSULTAS/INFORMES DEL CLIENTE')                                                                                                                                                                                                                               
insert into cobis..cl_ttransaccion values (7967,       'HERRAMIENTAS',                                                     '7967',   'HERRAMIENTAS')                                                                                                                                                                                                                                                 
insert into cobis..cl_ttransaccion values (7970,       'INSERTAR AUTORIZACION DE RENOVACION',                              '7970',   'INSERTAR AUTORIZACION DE RENOVACION')                                                                                                                                                                                                                          
insert into cobis..cl_ttransaccion values (7971,       'CONDONACION DE RENOVACIONES',                                      '7971',   'CONDONACION DE RENOVACIONES')                                                                                                                                                                                                                                  
insert into cobis..cl_ttransaccion values (7972,       'CANCELACION DE RUBROS EN SUSPENSO',                                '7972',   'CANCELACION DE RUBROS EN SUSPENSO')                                                                                                                                                                                                                            
insert into cobis..cl_ttransaccion values (7973,       'Operaciones/Ajuste Remisiones',                                    '7973',   'Operaciones/Ajuste Remisiones')                                                                                                                                                                                                                                
insert into cobis..cl_ttransaccion values (7974,       'Operaciones/Ajuste Remisiones/Transmitir',                         '7974',   'Operaciones/Ajuste Remisiones/Transmitir')                                                                                                                                                                                                                     
insert into cobis..cl_ttransaccion values (7975,       'Operaciones/SistemaPagos',                                         '7975',   'Operaciones/SistemaPagos')                                                                                                                                                                                                                                     
insert into cobis..cl_ttransaccion values (7976,       'CONSULTA DE TASAS EN OPERACIONES CANCELADAS',                      '7976',   'CONSULTA DE TASAS EN OPERACIONES CANCELADAS')                                                                                                                                                                                                                          
insert into cobis..cl_ttransaccion values (7977,       'Consulta/Fondos de Recursos/',                                     '7977',   'Consulta/Fondos de Recursos')                                                                                                                                                                                                                                  
insert into cobis..cl_ttransaccion values (7978,       'Consulta/Transacciones No Contabilizadas/',                        '7978',   'Consulta/Transacciones No Contabilizadas')                                                                                                                                                                                                                     
insert into cobis..cl_ttransaccion values (7979,       'Consulta/Simulacion de Comprobantes/',                             '7979',   'Consulta/Simulacion de Comprobantes')                                                                                                                                                                                                                          
insert into cobis..cl_ttransaccion values (7980,       'MENU CONSULTA/ TRANSACCIONES',                                     '7980',   'MENU CONSULTA/ TRANSACCIONES')                                                                                                                                                                                                                                 
insert into cobis..cl_ttransaccion values (7981,       'MENU CONSULTA/SIMULACION DE COMPROBANTES',                         '7981',   'MENU CONSULTA/SIMULACION DE COMPROBANTES')                                                                                                                                                                                                                     
insert into cobis..cl_ttransaccion values (7982,       'RESUMEN DE TRANSACCIONES NO CONTABILIZADAS',                       '7982',   'RESUMEN DE TRANSACCIONES NO CONTABILIZADAS')                                                                                                                                                                                                                   
insert into cobis..cl_ttransaccion values (7983,       'SIMULACION DE COMPROBANTES',                                       '7983',   'SIMULACION DE COMPROBANTES')                                                                                                                                                                                                                                   
insert into cobis..cl_ttransaccion values (7984,       'CAMBIO FECHA DE VENCIMIENTO',                                      '7984',   'CAMBIO FECHA DE VENCIMIENTO')                                                                                                                                                                                                                                  
insert into cobis..cl_ttransaccion values (7985,       'Consulta/Fondos de Recursos/',                                     '7985',   'Consulta/Fondos de Recursos')
insert into cobis..cl_ttransaccion values (7986,       'Administracion/Rubros/Rubros Pagos Planificadores/',               '7986',   'Administracion/Rubros/Rubros Pagos Planificadores/')
insert into cobis..cl_ttransaccion values (7987,       'Consulta/Fondos de Recursos/',                                     '7987',   'Consulta/Fondos de Recursos')                                                                                                                                                                                                                                  
insert into cobis..cl_ttransaccion values (7999,       'CONTROL DE VERSION DE FRONT - END',                                '7999',   'CONTROL DE VERSION DE FRONT - END')                                                                        
insert into cobis..cl_ttransaccion values (14775,      'IMPRESION APERTURA DEPOSITO',                                      'IMPAP',  'IMPRESION APERTURA DEPOSITO')
insert into cobis..cl_ttransaccion values (14776,      'IMPRESION CONSULTA GENERAL',                                       'IMPCG',  'IMPRESION CONSULTA GENERAL')
insert into cobis..cl_ttransaccion values (14777,      'IMPRESION CONSULTA DEPOSITO',                                      'IMPCD',  'IMPRESION CONSULTA DEPOSITO')
insert into cobis..cl_ttransaccion values (77501,      'CREACION DE RENOVACION',                                           '77500',  'Proceso de renovacion')
insert into cobis..cl_ttransaccion values (7966,       'PAGOS GRUPALES',                                                   '7966',   'Pagos grupales')
insert into cobis..cl_ttransaccion values (7968,       'Pago Solidario',                                                   '7968',   'Pago Solidario')
insert into cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga) values (74663, 'SIMULADOR DE PRESTAMOS', '74663', 'SIMULADOR DE PRESTAMOS')
insert into cobis..cl_ttransaccion values (74668,      'CONSULTAS PARA REPORTES',                                          '74668', 'CONSULTAS PARA REPORTES')
insert into cobis..cl_ttransaccion values (7969,       'Consulta de operaciones hijas',                                                   '7969',   'Consulta de operaciones hijas')
insert into cobis..cl_ttransaccion values (7297,       'B2C - DESEMBOLSO DE CRÉDITO REVOLVENTE',                           '7297',   'B2C - GENERACION DE PREGUNTAS DE VERIFICACION') 
insert into cobis..cl_ttransaccion values (7295,       'LCR - PARAMETROS GENERALES',                         '7295',   'LCR - PARAMETROS GENERALES') 
insert into cobis..cl_ttransaccion values (7296,       'B2C - CONSULTA DE DATOS',                         '7296',   'B2C - CONSULTA DE DATOS') 
insert into cobis..cl_ttransaccion values (7299,       'INCREMENTO CUPO LINEA DE CREDITO',                         '7299',   'INCREMENTO CUPO LINEA DE CREDITO') 
insert into cobis..cl_ttransaccion values (77505,      'LCR - IMPRESIÓN FICHA PAGO',                      '77505',   'LCR - IMPRESIÓN FICHA PAGO') 
insert into cobis..cl_ttransaccion values (77506,      'LCR - BLOQUEAR',                                  '77506',   'LCR - BLOQUEAR') 

go

PRINT '<<< FINALIZACION DEL PROCESO DE INSERCION EN LA cl_ttransaccion >>>'

PRINT '<<< INICIALIZACION DEL PROCESO DE INSERCION EN LA ad_pro_transaccion >>>'

declare @w_moneda  tinyint

select @w_moneda = pa_tinyint
  from cobis..cl_parametro
 where pa_nemonico = 'CMNAC'
   and pa_producto = 'ADM'

delete cobis..ad_pro_transaccion
 where pt_producto = 7
   and pt_moneda   = @w_moneda
   and pt_transaccion in (7001,7002,7003,7004,7005,7006,7007,7008,7009,7010,7011,7012,7013,7014,7015,7016,7017,7018,7019,7020,
                          7021,7022,7023,7024,7025,7026,7027,7028,7029,7030,7031,7032,7033,7034,7035,7036,7037,7038,7039,7040,
                          7041,7042,7043,7044,7045,7046,7047,7048,7049,7050,7051,7052,7053,7054,7055,7056,7057,7058,7059,7060,
                          7061,7062,7063,7064,7065,7066,7067,7068,7069,7070,7071,7072,7073,7074,7075,7076,7077,7078,7079,7080,
                          7081,7082,7083,7084,7085,7086,7087,7088,7089,7090,7091,7092,7093,7094,7095,7096,7097,7098,7099,7100,
                          7101,7102,7103,7104,7105,7106,7107,7108,7109,7110,7111,7112,7113,7114,7115,7116,7117,7118,7119,7120,
                          7121,7122,7123,7124,7125,7126,7127,7128,7129,7130,7131,7132,7133,7134,7135,7136,7137,7138,7139,7140,
                          7141,7142,7143,7144,7145,7146,7147,7148,7149,7150,7151,7152,7153,7154,7155,7156,7157,7158,7159,7160,
                          7161,7162,7163,7164,7165,7166,7167,7168,7169,7170,7171,7172,7173,7174,7175,7176,7177,7178,7179,7180,
                          7181,7182,7183,7184,7185,7186,7187,7188,7189,7190,7191,7192,7193,7194,7195,7196,7197,7198,7199,7200,
                          7201,7274,77501,7990,7966, 74663, 73904,77502,77503,77507,77511)

insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7001,       'V', '06/27/2008', 7001,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7002,       'V', '06/27/2008', 7002,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7003,       'V', '06/27/2008', 7003,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7004,       'V', '06/27/2008', 7003,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7005,       'V', '06/27/2008', 7004,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7006,       'V', '06/27/2008', 7005,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7007,       'V', '06/27/2008', 7005,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7008,       'V', '06/27/2008', 7006,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7009,       'V', '06/27/2008', 7007,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7010,       'V', '06/27/2008', 7008,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7011,       'V', '06/27/2008', 7009,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7012,       'V', '06/27/2008', 7010,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7013,       'V', '06/27/2008', 7010,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7014,       'V', '06/27/2008', 7010,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7015,       'V', '06/27/2008', 7011,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7016,       'V', '06/27/2008', 7011,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7017,       'V', '06/27/2008', 7011,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7018,       'V', '06/27/2008', 7011,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7019,       'V', '06/27/2008', 7011,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7020,       'V', '06/27/2008', 7011,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7021,       'V', '06/27/2008', 7011,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7022,       'V', '06/27/2008', 7011,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7023,       'V', '06/27/2008', 7011,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7024,       'V', '06/27/2008', 7011,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7025,       'V', '06/27/2008', 7012,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7026,       'V', '06/27/2008', 7013,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7027,       'V', '06/27/2008', 7013,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7028,       'V', '06/27/2008', 7014,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7029,       'V', '06/27/2008', 7015,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7030,       'V', '06/27/2008', 7015,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7031,       'V', '06/27/2008', 7015,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7032,       'V', '06/27/2008', 7015,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7033,       'V', '06/27/2008', 7016,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7034,       'V', '06/27/2008', 7016,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7035,       'V', '06/27/2008', 7016,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7036,       'V', '06/27/2008', 7017,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7037,       'V', '06/27/2008', 7017,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7038,       'V', '06/27/2008', 7017,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7039,       'V', '06/27/2008', 7018,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7040,       'V', '06/27/2008', 7018,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7041,       'V', '06/27/2008', 7018,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7042,       'V', '06/27/2008', 7018,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7043,       'V', '06/27/2008', 7018,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7044,       'V', '06/27/2008', 7018,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7045,       'V', '06/27/2008', 7019,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7046,       'V', '06/27/2008', 7019,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7047,       'V', '06/27/2008', 7019,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7048,       'V', '06/27/2008', 7019,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7049,       'V', '06/27/2008', 7020,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7050,       'V', '06/27/2008', 7021,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7051,       'V', '06/27/2008', 7022,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7052,       'V', '06/27/2008', 7023,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7053,       'V', '06/27/2008', 7024,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7054,       'V', '06/27/2008', 7025,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7055,       'V', '06/27/2008', 7026,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7056,       'V', '06/27/2008', 7027,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7057,       'V', '06/27/2008', 7028,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7058,       'V', '06/27/2008', 7029,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7059,       'V', '06/27/2008', 7030,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7060,       'V', '06/27/2008', 7031,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7061,       'V', '06/27/2008', 7032,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7062,       'V', '06/27/2008', 7033,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7063,       'V', '06/27/2008', 7033,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7064,       'V', '06/27/2008', 7034,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7065,       'V', '06/27/2008', 7035,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7066,       'V', '06/27/2008', 7035,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7067,       'V', '06/27/2008', 7035,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7068,       'V', '06/27/2008', 7035,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7069,       'V', '06/27/2008', 7036,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7070,       'V', '06/27/2008', 7036,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7071,       'V', '06/27/2008', 7036,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7072,       'V', '06/27/2008', 7036,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7073,       'V', '06/27/2008', 7037,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7074,       'V', '06/27/2008', 7038,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7075,       'V', '06/27/2008', 7039,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7076,       'V', '06/27/2008', 7040,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7077,       'V', '06/27/2008', 7041,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7078,       'V', '06/27/2008', 7041,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7079,       'V', '06/27/2008', 7041,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7080,       'V', '06/27/2008', 7042,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7081,       'V', '06/27/2008', 7042,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7082,       'V', '06/27/2008', 7042,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7083,       'V', '06/27/2008', 7043,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7084,       'V', '06/27/2008', 7044,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7085,       'V', '06/27/2008', 7044,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7086,       'V', '06/27/2008', 7044,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7087,       'V', '06/27/2008', 7044,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7088,       'V', '06/27/2008', 7045,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7089,       'V', '06/27/2008', 7045,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7090,       'V', '06/27/2008', 7045,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7091,       'V', '06/27/2008', 7046,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7092,       'V', '06/27/2008', 7046,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7093,       'V', '06/27/2008', 7046,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7094,       'V', '06/27/2008', 7047,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7095,       'V', '06/27/2008', 7047,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7096,       'V', '06/27/2008', 7047,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7097,       'V', '06/27/2008', 7047,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7098,       'V', '06/27/2008', 7048,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7099,       'V', '06/27/2008', 7048,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7100,       'V', '06/27/2008', 7048,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7101,       'V', '06/27/2008', 7048,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7102,       'V', '06/27/2008', 7049,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7103,       'V', '06/27/2008', 7049,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7104,       'V', '06/27/2008', 7049,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7105,       'V', '06/27/2008', 7049,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7106,       'V', '06/27/2008', 7050,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7107,       'V', '06/27/2008', 7050,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7108,       'V', '06/27/2008', 7050,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7109,       'V', '06/27/2008', 7050,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7110,       'V', '06/27/2008', 7051,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7111,       'V', '06/27/2008', 7051,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7112,       'V', '06/27/2008', 7051,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7113,       'V', '06/27/2008', 7051,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7114,       'V', '06/27/2008', 7052,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7115,       'V', '06/27/2008', 7053,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7116,       'V', '06/27/2008', 7053,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7117,       'V', '06/27/2008', 7053,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7118,       'V', '06/27/2008', 7053,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7119,       'V', '06/27/2008', 7053,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7120,       'V', '06/27/2008', 7054,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7121,       'V', '06/27/2008', 7054,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7122,       'V', '06/27/2008', 7054,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7123,       'V', '06/27/2008', 7054,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7124,       'V', '06/27/2008', 7054,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7125,       'V', '06/27/2008', 7055,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7126,       'V', '06/27/2008', 7055,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7127,       'V', '06/27/2008', 7055,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7128,       'V', '06/27/2008', 7055,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7129,       'V', '06/27/2008', 7056,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7130,       'V', '06/27/2008', 7057,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7131,       'V', '06/27/2008', 7058,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7132,       'V', '06/27/2008', 7058,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7133,       'V', '06/27/2008', 7059,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7134,       'V', '06/27/2008', 7059,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7135,       'V', '06/27/2008', 7060,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7136,       'V', '06/27/2008', 7005,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7137,       'V', '06/27/2008', 7005,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7138,       'V', '06/27/2008', 7061,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7139,       'V', '06/27/2008', 7062,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7140,       'V', '06/27/2008', 7063,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7141,       'V', '06/27/2008', 7141,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7142,       'V', '06/27/2008', 7064,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7143,       'V', '06/27/2008', 7065,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7144,       'V', '06/27/2008', 7066,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7145,       'V', '06/27/2008', 7067,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7146,       'V', '06/27/2008', 7068,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7147,       'V', '06/27/2008', 7069,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7148,       'V', '06/27/2008', 7148,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7149,       'V', '06/27/2008', 7070,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7150,       'V', '06/27/2008', 7071,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7151,       'V', '06/27/2008', 7071,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7152,       'V', '06/27/2008', 7072,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7153,       'V', '06/27/2008', 7073,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7154,       'V', '06/27/2008', 7074,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7155,       'V', '06/27/2008', 7075,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7156,       'V', '06/27/2008', 7075,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7157,       'V', '06/27/2008', 7076,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7158,       'V', '06/27/2008', 7077,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7159,       'V', '06/27/2008', 7077,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7160,       'V', '06/27/2008', 7001,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7161,       'V', '06/27/2008', 7001,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7162,       'V', '06/27/2008', 7078,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7163,       'V', '06/27/2008', 7079,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7164,       'V', '06/27/2008', 7079,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7165,       'V', '06/27/2008', 7079,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7166,       'V', '06/27/2008', 7079,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7167,       'V', '06/27/2008', 7079,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7168,       'V', '06/27/2008', 7080,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7169,       'V', '06/27/2008', 7081,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7170,       'V', '06/27/2008', 7081,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7171,       'V', '06/27/2008', 7081,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7172,       'V', '06/27/2008', 7081,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7173,       'V', '06/27/2008', 7082,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7174,       'V', '06/27/2008', 7082,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7175,       'V', '06/27/2008', 7083,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7176,       'V', '06/27/2008', 7083,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7177,       'V', '06/27/2008', 7084,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7178,       'V', '06/27/2008', 7178,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7179,       'V', '06/27/2008', 7086,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7180,       'V', '06/27/2008', 7087,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7181,       'V', '06/27/2008', 7087,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7182,       'V', '06/27/2008', 7087,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7183,       'V', '06/27/2008', 7088,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7184,       'V', '06/27/2008', 7088,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7185,       'V', '06/27/2008', 7089,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7186,       'V', '06/27/2008', 7186,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7187,       'V', '06/27/2008', 7187,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7188,       'V', '06/27/2008', 7187,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7189,       'V', '06/27/2008', 7187,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7190,       'V', '06/27/2008', 7190,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7191,       'V', '06/27/2008', 7191,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7192,       'V', '06/27/2008', 7192,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7193,       'V', '07/24/2008', 7193,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7194,       'V', '06/27/2008', 7098,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7195,       'V', '06/27/2008', 7098,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7196,       'V', '06/27/2008', 7098,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7197,       'V', '06/27/2008', 7098,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7198,       'V', '06/27/2008', 7099,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7199,       'V', '06/27/2008', 7100,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7200,       'V', '06/27/2008', 7101,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7201,       'V', '03/05/2009', 7505,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7274,       'V', '03/05/2009', 7207,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          77501,      'V', '05/09/2017', 77501,      null)
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7990,       'V', getdate()   , 7990,       null)
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7966,       'V', getdate()   , 7991,       null)
insert into cobis..ad_pro_transaccion values (7,          'R', 0,                  73904,      'V', getdate()   , 73904,      null)
insert into cobis..ad_pro_transaccion values (7,          'R', 0,                  77502,      'V', getdate()   , 77502,      null)
insert into cobis..ad_pro_transaccion values (7,          'R', 0,                  77503,      'V', getdate()   , 77503,      null)
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          77507,      'V', getdate()   , 77507,      null)
INSERT INTO cobis..ad_pro_transaccion VALUES (7,          'R', @w_moneda,          77511,      'V', getdate()   , 77511,      NULL)
go

declare @w_moneda  tinyint

select @w_moneda = pa_tinyint
  from cobis..cl_parametro
 where pa_nemonico = 'CMNAC'
   and pa_producto = 'ADM'

delete cobis..ad_pro_transaccion
 where pt_producto = 7
   and pt_moneda   = @w_moneda
   and pt_transaccion in (7203,7204,7205,7209,7210,7211,7212,7213,7214,7215,7216,7217,7218,7219,7220,7221,7222,7223,7224,7225,
                          7226,7227,7228,7229,7230,7231,7232,7233,7234,7235,7236,7237,7238,7239,7240,7241,7242,7243,7244,7245,
                          7246,7247,7248,7249,7250,7251,7252,7253,7254,7255,7256,7257,7258,7259,7260,7261,7262,7263,7264,7265,
                          7266,7267,7268,7269,7270,7271,7272,7273,7275,7276,7278,7279,7280,7301,7403,7430,7433,7434,7435,7436,
						  7437,7438,7439,7440,7441,7442,7445,7460,7461,7462,7463,7464,7465,7466,7500,7501,7502,7503,7504,7505,
						  7506,7507,7508,7509,7510,7511,7512,7513,7514,7515,7516,7517,7518,7519,7520,7521,7522,7523,7524,7525,
						  7526,7527,7528,7529,7530,7531,7532,7533,7534,7535,7536,7537,7538,7539,7540,7541,7542,7543,7544,7545,
						  7546,7547,7548,7549,7550,7551,7552,7553,7554,7555,7556,7557,7558,7559,7560,7561,7562,7563,7564,7565,
						  7566,7567,7568,7569,7570,7571,7572,7573,7574,7575,7576,7577,7578,7579,7580,7581,7582,7583,7584,7585,
						  7586,7587,7588,7589,7590,7591,7592,7593,7594,7595,7596,7597,7598,7599,7600,7601,7602,7603,7604,7605,
						  7606,7607,7608,7609,7610,7612,7613,7614,7615,7293,7300,7305,7306,7290,7291,7298,7281,7282,7283,7284,
						  7285,7286)

insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7203,       'V', '06/27/2008', 7204,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7204,       'V', getdate(),    7206,       null )
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7205,       'V', '06/27/2008', 7106,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7209,       'V', '06/27/2008', 7110,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7210,       'V', '06/27/2008', 7111,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7211,       'V', '06/27/2008', 7112,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7212,       'V', '06/27/2008', 7113,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7213,       'V', '06/27/2008', 7114,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7214,       'V', '06/27/2008', 7214,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7215,       'V', '06/27/2008', 7116,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7216,       'V', '06/27/2008', 7118,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7217,       'V', '06/27/2008', 7118,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7218,       'V', '06/27/2008', 7118,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7219,       'V', '06/27/2008', 7118,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7220,       'V', '06/27/2008', 7118,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7221,       'V', '06/27/2008', 7118,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7222,       'V', '06/27/2008', 7117,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7223,       'V', '06/27/2008', 7119,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7224,       'V', '06/27/2008', 7077,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7225,       'V', '06/27/2008', 7120,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7226,       'V', '06/27/2008', 7121,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7227,       'V', '06/27/2008', 7122,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7228,       'V', '06/27/2008', 7123,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7229,       'V', '06/27/2008', 7124,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7230,       'V', '06/27/2008', 7130,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7231,       'V', '06/27/2008', 7130,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7232,       'V', '06/27/2008', 7131,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7233,       'V', '06/27/2008', 7131,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7234,       'V', '06/27/2008', 7131,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7235,       'V', '06/27/2008', 7131,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7236,       'V', '06/27/2008', 7131,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7237,       'V', '06/27/2008', 7237,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7238,       'V', '06/27/2008', 7238,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7239,       'V', '06/27/2008', 7239,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7240,       'V', '06/27/2008', 7240,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7241,       'V', '06/27/2008', 7241,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7242,       'V', '06/27/2008', 7242,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7243,       'V', '06/27/2008', 7243,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7244,       'V', '06/27/2008', 7244,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7245,       'V', '06/27/2008', 7245,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7246,       'V', '06/27/2008', 7245,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7247,       'V', '06/27/2008', 7245,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7248,       'V', '06/27/2008', 7245,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7249,       'V', '06/27/2008', 7245,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7250,       'V', '06/27/2008', 7250,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7251,       'V', '06/27/2008', 7251,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7252,       'V', '06/27/2008', 7252,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7253,       'V', '06/27/2008', 7253,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7254,       'V', '06/27/2008', 7253,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7255,       'V', '06/27/2008', 7253,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7256,       'V', '06/27/2008', 7253,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7257,       'V', '06/27/2008', 7253,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7258,       'V', '06/27/2008', 7253,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7259,       'V', '06/27/2008', 7259,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7260,       'V', '06/27/2008', 7260,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7261,       'V', '06/27/2008', 7260,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7262,       'V', '06/27/2008', 7260,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7263,       'V', '06/27/2008', 7260,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7264,       'V', '06/27/2008', 7260,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7265,       'V', '06/27/2008', 7260,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7266,       'V', '06/27/2008', 7266,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7267,       'V', '06/27/2008', 7267,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7268,       'V', '06/27/2008', 7268,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7269,       'V', '06/27/2008', 7102,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7270,       'V', '06/27/2008', 7269,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7271,       'V', '06/27/2008', 7103,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7272,       'V', '02/19/2009', 7187,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7273,       'V', '02/26/2009', 7271,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7275,       'V', '02/26/2009', 7189,       null)
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7276,       'V', '02/26/2009', 7194,       null)
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7278,       'V', '05/30/2009', 7584,       null)
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7279,       'V', '07/03/2009', 7196,       null)
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7280,       'V', getdate(),    7280,       null)
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7281,       'V', getdate(),    7281,       null)
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7282,       'V', getdate(),    7282,       null)
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7283,       'V', getdate(),    7283,       null)
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7284,       'V', getdate(),    7284,       null)
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7285,       'V', getdate(),    7285,       null)
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7286,       'V', getdate(),    7286,       null)
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7290,       'V', getdate(),    7202,       null)
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7291,       'V', getdate(),    7205,       null)
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7293,       'V', getdate(),    7203,       null)
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7298,       'V', getdate(),    7218,       null)
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7301,       'V', getdate(),    7301,       null)
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7403,       'V', '06/27/2008', 7403,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7430,       'V', '06/27/2008', 7430,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7433,       'V', '06/27/2008', 7433,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7434,       'V', '06/27/2008', 7434,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7435,       'V', '06/27/2008', 7435,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7436,       'V', '06/27/2008', 7436,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7437,       'V', '06/27/2008', 7437,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7438,       'V', '06/27/2008', 7438,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7439,       'V', '06/27/2008', 7439,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7440,       'V', '06/27/2008', 7440,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7441,       'V', '06/27/2008', 7441,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7442,       'V', '06/27/2008', 7442,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7445,       'V', '02/25/2009', 7270,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7460,       'V', '06/27/2008', 7460,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7461,       'V', '08/26/2008', 7504,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7462,       'V', '02/26/2009', 7443,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7463,       'V', '02/26/2009', 7444,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7464,       'V', '02/26/2009', 7445,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7465,       'V', '02/26/2009', 7446,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7466,       'V', '03/18/2009', 7447,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7500,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7501,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7502,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7503,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7504,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7505,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7506,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7507,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7508,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7509,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7510,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7511,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7512,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7513,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7514,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7515,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7516,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7517,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7518,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7519,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7520,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7521,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7522,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7523,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7524,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7525,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7526,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7527,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7528,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7529,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7530,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7531,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7532,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7533,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7534,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7535,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7536,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7537,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7538,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7539,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7540,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7541,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7542,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7543,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7544,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7545,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7546,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7547,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7548,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7549,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7550,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7551,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7552,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7553,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7554,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7555,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7556,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7557,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7558,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7559,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7560,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7561,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7562,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7563,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7564,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7565,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7566,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7567,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7568,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7569,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7570,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7571,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7572,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7573,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7574,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7575,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7576,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7577,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7578,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7579,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7580,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7581,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7582,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7583,       'V', '06/27/2008', 7583,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7584,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7585,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7586,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7587,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7588,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7589,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7590,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7591,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7592,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7593,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7594,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7595,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7596,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7597,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7598,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7599,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7600,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7601,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7602,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7603,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7604,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7605,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7606,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7607,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7608,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7609,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7610,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7612,       'V', '10/18/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7613,       'V', '02/25/2009', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7614,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7615,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7300,       'V', getdate(),    7300,       null)
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7305,       'V', getdate(),    7090,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7306,       'V', getdate(),    7306,       null) 
go

declare @w_moneda  tinyint

select @w_moneda = pa_tinyint
  from cobis..cl_parametro
 where pa_nemonico = 'CMNAC'
   and pa_producto = 'ADM'

delete cobis..ad_pro_transaccion
 where pt_producto = 7
   and pt_moneda   = @w_moneda
   and pt_transaccion in (7616,7617,7618,7619,7620,7621,7622,7623,7624,7625,7626,7627,7628,7629,7630,7631,7632,7633,7634,7635,
                          7636,7637,7638,7639,7640,7641,7642,7643,7644,7645,7646,7647,7648,7649,7650,7651,7652,7653,7654,7655,
                          7656,7657,7658,7659,7660,7661,7662,7663,7664,7665,7666,7667,7668,7669,7670,7671,7672,7673,7674,7675,
                          7676,7677,7678,7679,7680,7681,7682,7683,7684,7685,7686,7687,7688,7689,7690,7691,7692,7693,7694,7695,
                          7696,7697,7698,7699,7700,7701,7702,7703,7704,7705,7706,7707,7709,7710,7711,7714,7715,7716,7717,7718,
                          7719,7720,7721,7722,7723,7724,7725,7726,7727,7728,7729,7730,7731,7732,7733,7734,7735,7736,7737,7738,
                          7739,7740,7741,7742,7743,7744,7745,7746,7747,7748,7749,7750,7751,7752,7753,7754,7755,7756,7757,7758,
                          7759,7760,7761,7762,7763,7764,7765,7766,7767,7768,7769,7770,7771,7772,7773,7774,7775,7776,7777,7778,
                          7779,7780,7781,7782,7783,7784,7785,7786,7787,7788,7789,7790,7792,7794,7796,7797,7798,7799,7800,7801,
                          7802,7803,7804,7805,7806,7807,7808,7809,7810,7811,7812,7813,7814,7815,7816,7817,7818,7819,7820,7821,
                          7822)

insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7616,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7617,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7618,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7619,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7620,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7621,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7622,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7623,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7624,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7625,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7626,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7627,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7628,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7629,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7630,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7631,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7632,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7633,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7634,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7635,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7636,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7637,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7638,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7639,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7640,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7641,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7642,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7643,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7644,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7645,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7646,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7647,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7648,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7649,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7650,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7651,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7652,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7653,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7654,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7655,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7656,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7657,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7658,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7659,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7660,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7661,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7662,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7663,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7664,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7665,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7666,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7667,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7668,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7669,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7670,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7671,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7672,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7673,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7674,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7675,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7676,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7677,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7678,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7679,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7680,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7681,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7682,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7683,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7684,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7685,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7686,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7687,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7688,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7689,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7690,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7691,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7692,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7693,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7694,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7695,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7696,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7697,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7698,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7699,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7700,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7701,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7702,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7703,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7704,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7705,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7706,       'V', '02/25/2009', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7707,       'V', '02/26/2009', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7709,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7710,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7711,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7714,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7715,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7716,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7717,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7718,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7719,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7720,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7721,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7722,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7723,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7724,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7725,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7726,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7727,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7728,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7729,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7730,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7731,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7732,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7733,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7734,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7735,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7736,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7737,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7738,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7739,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7740,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7741,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7742,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7743,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7744,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7745,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7746,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7747,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7748,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7749,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7750,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7751,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7752,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7753,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7754,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7755,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7756,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7757,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7758,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7759,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7760,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7761,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7762,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7763,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7764,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7765,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7766,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7767,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7768,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7769,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7770,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7771,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7772,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7773,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7774,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7775,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7776,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7777,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7778,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7779,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7780,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7781,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7782,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7783,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7784,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7785,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7786,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7787,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7788,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7789,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7790,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7792,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7794,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7796,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7797,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7798,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7799,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7800,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7801,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7802,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7803,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7804,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7805,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7806,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7807,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7808,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7809,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7810,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7811,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7812,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7813,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7814,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7815,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7816,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7817,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7818,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7819,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7820,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7821,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7822,       'V', '06/27/2008', 7500,       null) 
go

declare @w_moneda  tinyint

select @w_moneda = pa_tinyint
  from cobis..cl_parametro
 where pa_nemonico = 'CMNAC'
   and pa_producto = 'ADM'

delete cobis..ad_pro_transaccion
 where pt_producto = 7
   and pt_moneda   = @w_moneda
   and pt_transaccion in (7823,7824,7825,7826,7827,7828,7829,7830,7831,7832,7833,7834,7835,7836,7837,7838,7839,7840,7841,7842,
                          7843,7844,7845,7846,7847,7848,7849,7850,7851,7852,7853,7854,7855,7856,7857,7858,7859,7860,7861,7862,
                          7863,7864,7865,7866,7867,7868,7869,7870,7871,7872,7873,7882,7883,7884,7885,7886,7887,7888,7889,7890,
                          7891,7892,7893,7894,7895,7896,7897,7898,7899,7900,7901,7902,7903,7904,7905,7906,7907,7908,7909,7910,
                          7911,7912,7913,7914,7915,7916,7917,7918,7919,7920,7921,7922,7923,7924,7925,7926,7927,7928,7929,7930,
                          7931,7932,7933,7934,7935,7936,7937,7938,7939,7940,7941,7942,7943,7944,7945,7946,7947,7948,7949,7950,
                          7951,7952,7953,7954,7955,7956,7957,7958,7959,7960,7961,7962,7964,7965,7967,7970,7971,7972,7973,7974,
                          7975,7976,7977,7978,7979,7980,7981,7982,7983,7984,7985,7986,7987,7999,18400,18401,18402,18403,18404,
                          22163,7968)

insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7823,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7824,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7825,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7826,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7827,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7828,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7829,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7830,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7831,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7832,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7833,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7834,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7835,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7836,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7837,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7838,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7839,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7840,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7841,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7842,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7843,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7844,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7845,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7846,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7847,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7848,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7849,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7850,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7851,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7852,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7853,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7854,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7855,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7856,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7857,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7858,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7859,       'V', '06/28/2008', 6540,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7860,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7861,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7862,       'V', '06/27/2008', 26248,      null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7863,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7864,       'V', '06/27/2008', 26248,      null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7865,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7866,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7867,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7868,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7869,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7870,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7871,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7872,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7873,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7882,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7883,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7884,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7885,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7886,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7887,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7888,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7889,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7890,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7891,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7892,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7893,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7894,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7895,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7896,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7897,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7898,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7899,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7900,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7901,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7902,       'V', '06/27/2008', 7501,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7903,       'V', '06/27/2008', 7502,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7904,       'V', '06/27/2008', 7502,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7905,       'V', '06/27/2008', 7502,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7906,       'V', '06/27/2008', 7502,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7907,       'V', '06/27/2008', 7502,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7908,       'V', '06/27/2008', 7502,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7909,       'V', '06/27/2008', 7502,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7910,       'V', '06/27/2008', 7502,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7911,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7912,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7913,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7914,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7915,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7916,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7917,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7918,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7919,       'V', '06/27/2008', 7502,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7920,       'V', '06/27/2008', 7502,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7921,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7922,       'V', '06/27/2008', 7503,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7923,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7924,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7925,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7926,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7927,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7928,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7929,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7930,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7931,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7932,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7933,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7934,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7935,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7936,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7937,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7938,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7939,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7940,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7941,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7942,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7943,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7944,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7945,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7946,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7947,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7948,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7949,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7950,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7951,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7952,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7953,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7954,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7955,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7956,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7957,       'V', '06/27/2008', 7441,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7958,       'V', '06/27/2008', 7441,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7959,       'V', '06/27/2008', 7441,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7960,       'V', '06/27/2008', 7441,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7961,       'V', '06/27/2008', 7441,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7962,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7964,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7965,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7967,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7970,       'V', '06/27/2008', 18405,      null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7971,       'V', '06/27/2008', 18406,      null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7972,       'V', '06/27/2008', 18407,      null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7973,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7974,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7975,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7976,       'V', '06/27/2008', 7502,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7977,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7978,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7979,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7980,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7981,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7982,       'V', '06/27/2008', 7448,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7983,       'V', '06/27/2008', 7448,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7984,       'V', '06/27/2008', 7984,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7985,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7986,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7987,       'V', '06/27/2008', 7500,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7999,       'V', '06/27/2008', 7999,       null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          18400,      'V', '06/27/2008', 18400,      null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          18401,      'V', '06/27/2008', 18401,      null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          18402,      'V', '06/27/2008', 18402,      null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          18403,      'V', '06/27/2008', 18403,      null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          18404,      'V', '06/27/2008', 18404,      null) 
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          22163,      'V', '08/06/2008', 21556,      null)
insert into cobis..ad_pro_transaccion values (7,          'R', @w_moneda,          7968,       'V', '06/27/2008', 7968,       null)
insert into cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial) 
values (7, 'R', @w_moneda, 74663, 'V', getdate(), 74663, null)
go

/*PGA REQ-CAR00074 02/02/2010*/

declare @w_moneda  tinyint

select @w_moneda = pa_tinyint
  from cobis..cl_parametro
 where pa_nemonico = 'CMNAC'
   and pa_producto = 'ADM'

delete cobis..ad_pro_transaccion
 where pt_producto = 7
   and pt_moneda   = @w_moneda
   and pt_transaccion in (7963,7966,7881,7969,7988,7989,7997,7998,7992,7993,7994,7995,7996,714500,74668,7295,7297,7296,7299,77505,77506)
     
insert into ad_pro_transaccion values (7,'R',@w_moneda,7963 ,'V',getdate(),7500,null)
insert into ad_pro_transaccion values (7,'R',@w_moneda,7966 ,'V',getdate(),7500,null)
insert into ad_pro_transaccion values (7,'R',@w_moneda,7881 ,'V',getdate(),7500,null)
insert into ad_pro_transaccion values (7,'R',@w_moneda,7969 ,'V',getdate(),7969,null)
insert into ad_pro_transaccion values (7,'R',@w_moneda,7988 ,'V',getdate(),7500,null)
insert into ad_pro_transaccion values (7,'R',@w_moneda,7989 ,'V',getdate(),7500,null)
insert into ad_pro_transaccion values (7,'R',@w_moneda,7997 ,'V',getdate(),7500,null)
insert into ad_pro_transaccion values (7,'R',@w_moneda,7998 ,'V',getdate(),7500,null)
insert into ad_pro_transaccion values (7,'R',@w_moneda,7992 ,'V',getdate(),7500,null)
insert into ad_pro_transaccion values (7,'R',@w_moneda,7993 ,'V',getdate(),7500,null)
insert into ad_pro_transaccion values (7,'R',@w_moneda,7994 ,'V',getdate(),7500,null)
insert into ad_pro_transaccion values (7,'R',@w_moneda,7995 ,'V',getdate(),7500,null)
insert into ad_pro_transaccion values (7,'R',@w_moneda,7996 ,'V',getdate(),7500,null)
insert into ad_pro_transaccion values (7,'R',@w_moneda,714500, 'V', getdate(), 7067, NULL)
insert into ad_pro_transaccion values (7,'R',@w_moneda,74668,'V',getdate(),74668,null)
insert into ad_pro_transaccion values (7,'R',@w_moneda,7297, 'V',getdate(), 7297,null)
insert into ad_pro_transaccion values (7,'R',@w_moneda,7295, 'V',getdate(), 7295,null)
insert into ad_pro_transaccion values (7,'R',@w_moneda,7296, 'V',getdate(), 7296,null)
insert into ad_pro_transaccion values (7,'R',@w_moneda,7299, 'V',getdate(), 7299,null)                                                                                                                                                                                                                     
insert into ad_pro_transaccion values (7,'R',@w_moneda,77505,'V', getdate(),77505,null) 
insert into ad_pro_transaccion values (7,'R',@w_moneda,77506,'V', getdate(),77506,null)                                                                                                                                                                                                                    

go
/*PGA REQ-CAR00074 02/02/2010*/     

declare @w_moneda  tinyint

select @w_moneda = pa_tinyint
  from cobis..cl_parametro
 where pa_nemonico = 'CMNAC'
   and pa_producto = 'ADM'

delete cobis..ad_pro_transaccion
 where pt_producto = 14
   and pt_moneda   = @w_moneda
   and pt_transaccion in (14775,14776,14777)
     
insert into ad_pro_transaccion values (14,'R',@w_moneda,14775,'V',getdate(),243,null)
insert into ad_pro_transaccion values (14,'R',@w_moneda,14776,'V',getdate(),243,null)
insert into ad_pro_transaccion values (14,'R',@w_moneda,14777,'V',getdate(),243,null)
go


PRINT '<<< FINALIZACION DEL PROCESO DE INSERCION EN LA ad_pro_transaccion >>>'

PRINT '<<< INICIALIZACION DEL PROCESO DE INSERCION EN LA ad_tr_autorizada >>>'

declare @w_rol     smallint,
        @w_moneda  tinyint

select @w_moneda = pa_tinyint
  from cobis..cl_parametro
 where pa_nemonico = 'CMNAC'
   and pa_producto = 'ADM'

select @w_rol = ro_rol
  from ad_rol
 where ro_descripcion = 'MENU POR PROCESOS' 
   and ro_filial = 1

delete cobis..ad_tr_autorizada
 where ta_producto = 7
   and ta_rol      = @w_rol
   and ta_moneda   = @w_moneda
   and ta_transaccion in (1015,1018,1140,1278,7001,7002,7003,7004,7005,7006,7007,7008,7009,7010,7011,7012,7013,7014,7015,7016,7017,
                          7018,7019,7020,7021,7022,7023,7024,7025,7026,7027,7028,7029,7030,7031,7032,7033,7034,7035,7036,7037,7038,
                          7039,7040,7041,7042,7043,7044,7045,7046,7047,7048,7049,7050,7051,7052,7053,7054,7055,7056,7057,7058,7059,
                          7060,7061,7062,7063,7064,7065,7066,7067,7068,7069,7070,7071,7072,7073,7074,7075,7076,7077,7078,7079,7080,
                          7081,7082,7083,7084,7085,7086,7087,7088,7089,7090,7091,7092,7093,7094,7095,7096,7097,7098,7099,7100,7101,
                          7102,7103,7104,7105,7106,7107,7108,7109,7110,7111,7112,7113,7114,7115,7116,7117,7118,7119,7120,7121,7122,
                          7123,7124,7125,7126,7127,7128,7129,7130,7131,7132,7133,7134,7135,7136,7137,7138,7139,7140,7141,7142,7143,
                          7144,7145,7146,7147,7148,7149,7150,7151,7152,7153,7154,7155,7156,7157,7158,7159,7160,7161,7162,7163,7164,
                          7165,7166,7167,7168,7169,7170,7171,7172,7173,7174,7175,7176,7177,7178,7179,7180,7181,7182,7183,7184,7185,
                          7186,7187,7188,7189,7190,7191,7192,7193,7194,7195,7196,7197,7198,7199,7200,7201,7203,7205,7206,7207,7208,
                          7209,7204,7274,77501,7990,714500, 74663,74668, 73904,77502,77503,77507,77511)

insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          714500,    @w_rol,         '04/26/2008', 3,          'V', '04/26/2008')
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          1015,      @w_rol,         '04/26/2008', 3,          'V', '04/26/2008') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          1018,      @w_rol,         '04/26/2008', 3,          'V', '04/26/2008') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          1140,      @w_rol,         '05/13/2008', 3,          'V', '05/13/2008') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          1278,      @w_rol,         '07/01/2008', 3,          'V', '07/01/2008') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7001,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7002,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7003,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7004,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7005,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7006,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7007,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7008,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7009,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7010,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7011,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7012,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7013,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7014,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7015,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7016,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7017,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7018,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7019,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7020,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7021,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7022,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7023,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7024,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7025,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7026,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7027,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7028,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7029,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7030,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7031,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7032,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7033,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7034,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7035,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7036,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7037,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7038,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7039,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7040,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7041,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7042,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7043,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7044,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7045,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7046,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7047,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7048,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7049,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7050,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7051,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7052,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7053,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7054,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7055,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7056,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7057,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7058,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7059,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7060,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7061,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7062,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7063,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7064,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7065,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7066,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7067,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7068,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7069,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7070,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7071,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7072,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7073,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7074,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7075,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7076,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7077,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7078,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7079,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7080,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7081,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7082,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7083,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7084,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7085,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7086,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7087,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7088,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7089,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7090,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7091,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7092,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7093,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7094,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7095,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7096,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7097,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7098,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7099,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7100,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7101,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7102,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7103,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7104,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7105,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7106,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7107,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7108,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7109,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7110,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7111,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7112,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7113,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7114,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7115,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7116,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7117,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7118,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7119,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7120,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7121,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7122,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7123,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7124,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7125,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7126,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7127,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7128,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7129,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7130,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7131,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7132,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7133,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7134,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7135,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7136,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7137,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7138,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7139,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7140,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7141,      @w_rol,         '05/06/2008', 3,          'V', '05/06/2008') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7142,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7143,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7144,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7145,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7146,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7147,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7148,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7149,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7150,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7151,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7152,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7153,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7154,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7155,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7156,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7157,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7158,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7159,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7160,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7161,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7162,      @w_rol,         '04/02/2008', 4,          'V', '04/02/2008') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7163,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7164,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7165,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7166,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7167,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7168,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7169,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7170,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7171,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7172,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7173,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7174,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7175,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7176,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7177,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7178,      @w_rol,         '05/13/2008', 3,          'V', '05/13/2008') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7179,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7180,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7181,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7182,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7183,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7184,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7185,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7186,      @w_rol,         '05/13/2008', 3,          'V', '05/13/2008') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7187,      @w_rol,         '05/21/2008', 3,          'V', '05/21/2008') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7188,      @w_rol,         '05/21/2008', 3,          'V', '05/21/2008') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7189,      @w_rol,         '05/21/2008', 3,          'V', '05/21/2008') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7190,      @w_rol,         '05/21/2008', 3,          'V', '05/21/2008') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7191,      @w_rol,         '05/21/2008', 3,          'V', '05/21/2008') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7192,      @w_rol,         '05/21/2008', 3,          'V', '05/21/2008') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7193,      @w_rol,         '07/24/2008', 3,          'V', '07/24/2008') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7194,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7195,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7196,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7197,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7198,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7199,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7200,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7201,      @w_rol,         '03/05/2009', 3,          'V', '03/05/2009') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7203,      @w_rol,         '03/05/2009', 3,          'V', '03/05/2009') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7205,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7206,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7207,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7208,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7209,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7204,      @w_rol,         getdate(),    1,          'V', getdate())
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7274,      @w_rol,         getdate(),    1,          'V', getdate())
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          77501,     @w_rol,         getdate(),    1,          'V', getdate())
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7990,      @w_rol,         getdate(),    1,          'V', getdate())
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          74668,     @w_rol,         getdate(),    1,          'V', getdate())
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          73904,     @w_rol,         getdate(),    1,          'V', getdate())
insert into cobis..ad_tr_autorizada values (7,          'R', 0,                  77502,     @w_rol,         getdate(),    1,          'V', getdate())
insert into cobis..ad_tr_autorizada values (7,          'R', 0,                  77503,     @w_rol,         getdate(),    1,          'V', getdate())
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          77507,     @w_rol,         getdate(),    1,          'V', getdate())


select @w_rol = ro_rol
from ad_rol
where ro_descripcion = 'SCHEDULER CTS' 
INSERT INTO cobis..ad_tr_autorizada VALUES (7,          'R', @w_moneda,          77511,     @w_rol,         getdate(),    1,          'V', getdate())
go

declare @w_rol     smallint,
        @w_moneda  tinyint

select @w_moneda = pa_tinyint
  from cobis..cl_parametro
 where pa_nemonico = 'CMNAC'
   and pa_producto = 'ADM'

select @w_rol = ro_rol
  from ad_rol
 where ro_descripcion = 'MENU POR PROCESOS' 
   and ro_filial = 1

delete cobis..ad_tr_autorizada
 where ta_producto = 7
   and ta_rol      = @w_rol
   and ta_moneda   = @w_moneda
   and ta_transaccion in (7210,7211,7212,7213,7214,7215,7216,7217,7218,7219,7220,7221,7222,7223,7224,7225,7226,7227,7228,7229,7230,
                          7231,7232,7233,7234,7235,7236,7237,7238,7239,7240,7241,7242,7243,7244,7245,7246,7247,7248,7249,7250,7251,
                          7252,7253,7254,7255,7256,7257,7258,7259,7260,7261,7262,7263,7264,7265,7266,7267,7268,7269,7270,7271,7272,
                          7273,7275,7276,7278,7279,7280,7400,7401,7402,7403,7404,7405,7406,7407,7408,7409,7410,7411,7412,7413,7414,
                          7415,7416,7417,7418,7419,7420,7421,7422,7426,7427,7428,7429,7430,7433,7434,7435,7436,7437,7438,7439,7440,
                          7441,7442,7445,7460,7461,7462,7463,7464,7465,7466,7500,7501,7502,7503,7504,7505,7506,7507,7508,7509,7510,
                          7511,7512,7513,7514,7515,7516,7517,7518,7519,7520,7521,7522,7523,7524,7525,7526,7527,7528,7529,7530,7531,
                          7532,7533,7534,7535,7536,7537,7538,7539,7540,7541,7542,7543,7544,7545,7546,7547,7548,7549,7550,7551,7552,
                          7553,7554,7555,7556,7557,7558,7559,7560,7561,7562,7563,7564,7565,7566,7567,7568,7569,7570,7571,7572,7573,
                          7574,7575,7576,7577,7578,7579,7580,7581,7582,7583,7584,7585,7586,7587,7588,7589,7590,7591,7592,7593,7594,
                          7290,7291,7293,7298,7305,7306,7281,7282,7283,7284,7285,7286,7301)

insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7210,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7211,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7212,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7213,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7214,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7215,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7216,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7217,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7218,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7219,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7220,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7221,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7222,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7223,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7224,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7225,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7226,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7227,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7228,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7229,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7230,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7231,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7232,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7233,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7234,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7235,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7236,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7237,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7238,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7239,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7240,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7241,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7242,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7243,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7244,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7245,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7246,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7247,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7248,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7249,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7250,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7251,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7252,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7253,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7254,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7255,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7256,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7257,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7258,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7259,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7260,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7261,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7262,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7263,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7264,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7265,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7266,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7267,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7268,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7269,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7270,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7271,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7272,      @w_rol,         '02/19/2009', 3,          'V', '02/19/2009') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7273,      @w_rol,         '02/26/2009', 3,          'V', '02/26/2009') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7275,      @w_rol,         '02/26/2009', 3,          'V', '02/26/2009')
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7276,      @w_rol,         '05/21/2009', 3,          'V', '05/21/2009')
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7278,      @w_rol,         '05/30/2009', 3,          'V', '05/30/2009')
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7279,      @w_rol,         '07/03/2009', 3,          'V', '07/03/2009')
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7280,      @w_rol,         getdate(),    3,          'V', getdate())
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7281,      @w_rol,         getdate(),    3,          'V', getdate())
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7282,      @w_rol,         getdate(),    3,          'V', getdate())
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7283,      @w_rol,         getdate(),    3,          'V', getdate())
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7284,      @w_rol,         getdate(),    3,          'V', getdate())
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7285,      @w_rol,         getdate(),    3,          'V', getdate())
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7286,      @w_rol,         getdate(),    3,          'V', getdate())
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7290,      @w_rol,         '03/05/2009', 1,          'V', '03/05/2009') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7291,      @w_rol,         '03/05/2009', 1,          'V', '03/05/2009') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7293,      @w_rol,         '03/05/2009', 1,          'V', '03/05/2009') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7298,      @w_rol,         '03/05/2009', 1,          'V', '03/05/2009')
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7301,      @w_rol,         '07/27/2017', 3,          'V', '07/27/2017')  
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7305,      @w_rol,         '03/05/2009', 1,          'V', '03/05/2009') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7306,      @w_rol,         getdate(),	  1,          'V', getdate()) 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7400,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7401,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7402,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7403,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7404,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7405,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7406,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7407,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7408,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7409,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7410,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7411,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7412,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7413,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7414,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7415,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7416,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7417,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7418,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7419,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7420,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7421,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7422,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7426,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7427,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7428,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7429,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7430,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7433,      @w_rol,         '09/22/2005', 3,          'V', '09/22/2005') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7434,      @w_rol,         '09/22/2005', 3,          'V', '09/22/2005') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7435,      @w_rol,         '03/29/2005', 3,          'V', '03/29/2005') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7436,      @w_rol,         '03/09/2006', 3,          'V', '03/09/2006') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7437,      @w_rol,         '03/08/2006', 3,          'V', '03/08/2006') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7438,      @w_rol,         '02/08/2006', 3,          'V', '02/08/2006') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7439,      @w_rol,         '06/20/2006', 3,          'V', '06/20/2006') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7440,      @w_rol,         '03/23/2007', 3,          'V', '03/23/2007') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7441,      @w_rol,         '02/17/2006', 3,          'V', '02/17/2006') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7442,      @w_rol,         '05/17/2006', 3,          'V', '05/17/2006') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7445,      @w_rol,         '02/25/2009', 3,          'V', '02/25/2009') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7460,      @w_rol,         '09/22/2005', 3,          'V', '09/22/2005') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7461,      @w_rol,         '02/25/2009', 3,          'V', '02/25/2009') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7462,      @w_rol,         '02/25/2009', 1,          'V', '02/25/2009')
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7463,      @w_rol,         '02/25/2009', 1,          'V', '02/25/2009')
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7464,      @w_rol,         '02/25/2009', 1,          'V', '02/25/2009')
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7465,      @w_rol,         '02/25/2009', 1,          'V', '02/25/2009')
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7466,      @w_rol,         '03/18/2009', 1,          'V', '03/18/2009') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7500,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7501,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7502,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7503,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7504,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7505,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7506,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7507,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7508,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7509,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7510,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7511,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7512,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7513,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7514,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7515,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7516,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7517,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7518,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7519,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7520,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7521,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7522,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7523,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7524,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7525,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7526,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7527,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7528,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7529,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7530,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7531,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7532,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7533,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7534,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7535,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7536,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7537,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7538,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7539,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7540,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7541,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7542,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7543,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7544,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7545,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7546,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7547,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7548,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7549,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7550,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7551,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7552,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7553,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7554,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7555,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7556,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7557,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7558,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7559,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7560,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7561,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7562,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7563,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7564,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7565,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7566,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7567,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7568,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7569,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7570,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7571,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7572,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7573,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7574,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7575,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7576,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7577,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7578,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7579,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7580,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7581,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7582,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7583,      @w_rol,         '09/12/2007', 3,          'V', '09/12/2007') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7584,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7585,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7586,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7587,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7588,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7589,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7590,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7591,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7592,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7593,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7594,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004')
go

declare @w_rol     smallint,
        @w_moneda  tinyint

select @w_moneda = pa_tinyint
  from cobis..cl_parametro
 where pa_nemonico = 'CMNAC'
   and pa_producto = 'ADM'

select @w_rol = ro_rol
  from ad_rol
 where ro_descripcion = 'MENU POR PROCESOS' 
   and ro_filial = 1

delete cobis..ad_tr_autorizada
 where ta_producto = 7
   and ta_rol      = @w_rol
   and ta_moneda   = @w_moneda
   and ta_transaccion in (7595,7596,7597,7598,7599,7600,7601,7602,7603,7604,7605,7606,7607,7608,7609,7610,7613,7614,7615,7616,7617,
                          7618,7619,7620,7621,7622,7623,7624,7625,7626,7627,7628,7629,7630,7631,7632,7633,7634,7635,7636,7637,7638,
                          7639,7640,7641,7642,7643,7644,7645,7646,7647,7648,7649,7650,7651,7652,7653,7654,7655,7656,7657,7658,7659,
                          7660,7661,7662,7663,7664,7665,7666,7667,7668,7669,7670,7671,7672,7673,7674,7675,7676,7677,7678,7679,7680,
                          7681,7682,7683,7684,7685,7686,7687,7688,7689,7690,7691,7692,7693,7694,7695,7696,7697,7698,7699,7700,7701,
                          7702,7703,7704,7705,7706,7707,7709,7710,7711,7714,7715,7716,7717,7718,7719,7720,7721,7722,7723,7724,7725,
                          7726,7727,7728,7729,7730,7731,7732,7733,7734,7735,7736,7737,7738,7739,7740,7741,7742,7743,7744,7745,7746,
                          7747,7748,7749,7750,7751,7752,7753,7754,7755,7756,7757,7758,7759,7760,7761,7762,7763,7764,7765,7766,7767,
                          7768,7769,7770,7771,7772,7773,7774,7775,7776,7777,7778,7779,7780,7781,7782,7783,7784,7785,7786,7787,7788,
                          7789,7790,7792,7794,7796,7797,7798,7799,7800,7801,7802,7803,7804,7805,7806,7807,7808,7809,7810,7811,7812)

insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7595,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7596,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7597,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7598,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7599,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7600,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7601,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7602,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7603,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7604,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7605,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7606,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7607,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7608,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7609,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7610,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7613,      @w_rol,         '02/25/2009', 3,          'V', '02/25/2009') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7614,      @w_rol,         '02/01/2007', 3,          'V', '02/01/2007') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7615,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7616,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7617,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7618,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7619,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7620,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7621,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7622,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7623,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7624,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7625,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7626,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7627,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7628,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7629,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7630,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7631,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7632,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7633,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7634,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7635,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7636,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7637,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7638,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7639,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7640,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7641,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7642,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7643,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7644,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7645,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7646,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7647,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7648,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7649,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7650,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7651,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7652,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7653,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7654,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7655,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7656,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7657,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7658,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7659,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7660,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7661,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7662,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7663,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7664,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7665,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7666,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7667,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7668,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7669,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7670,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7671,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7672,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7673,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7674,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7675,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7676,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7677,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7678,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7679,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7680,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7681,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7682,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7683,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7684,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7685,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7686,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7687,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7688,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7689,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7690,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7691,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7692,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7693,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7694,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7695,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7696,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7697,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7698,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7699,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7700,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7701,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7702,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7703,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7704,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7705,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7706,      @w_rol,         '02/25/2009', 3,          'V', '02/25/2009') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7707,      @w_rol,         '02/26/2009', 3,          'V', '02/26/2009') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7709,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7710,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7711,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7714,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7715,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7716,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7717,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7718,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7719,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7720,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7721,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7722,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7723,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7724,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7725,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7726,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7727,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7728,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7729,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7730,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7731,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7732,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7733,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7734,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7735,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7736,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7737,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7738,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7739,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7740,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7741,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7742,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7743,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7744,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7745,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7746,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7747,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7748,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7749,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7750,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7751,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7752,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7753,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7754,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7755,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7756,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7757,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7758,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7759,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7760,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7761,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7762,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7763,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7764,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7765,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7766,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7767,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7768,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7769,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7770,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7771,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7772,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7773,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7774,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7775,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7776,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7777,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7778,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7779,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7780,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7781,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7782,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7783,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7784,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7785,      @w_rol,         '02/01/2007', 3,          'V', '02/01/2007') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7786,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7787,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7788,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7789,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7790,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7792,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7794,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7796,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7797,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7798,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7799,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7800,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7801,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7802,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7803,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7804,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7805,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7806,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7807,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7808,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7809,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7810,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7811,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7812,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
go

declare @w_rol     smallint,
        @w_moneda  tinyint

select @w_moneda = pa_tinyint
  from cobis..cl_parametro
 where pa_nemonico = 'CMNAC'
   and pa_producto = 'ADM'

select @w_rol = ro_rol
  from ad_rol
 where ro_descripcion = 'MENU POR PROCESOS' 
   and ro_filial = 1

delete cobis..ad_tr_autorizada
 where ta_producto = 7
   and ta_rol      = @w_rol
   and ta_moneda   = @w_moneda
   and ta_transaccion in (7813,7814,7815,7816,7817,7818,
						  7819,7820,7821,7822,7823,7824,7825,7826,7827,7828,7829,7830,
						  7831,7832,7833,7834,7835,7836,7837,7838,7839,7840,7841,7842,
						  7843,7844,7845,7846,7847,7848,7849,7850,7851,7852,7853,7854,
						  7855,7856,7857,7858,7859,7860,7861,7862,7863,7864,7865,7866,
						  7867,7868,7869,7870,7871,7872,7873,7882,7883,7884,7885,7886,
						  7887,7888,7889,7890,7891,7892,7893,7894,7895,7896,7897,7898,
						  7899,7900,7901,7902,7903,7904,7905,7906,7907,7908,7909,7910,
						  7911,7912,7913,7914,7915,7916,7917,7918,7919,7920,7921,7922,
						  7923,7924,7925,7926,7927,7928,7929,7930,7931,7932,7933,7934,
						  7935,7936,7937,7938,7939,7940,7941,7942,7943,7944,7945,7946,
						  7947,7948,7949,7950,7951,7952,7953,7954,7955,7956,7957,7958,
						  7959,7960,7961,7962,7964,7965,7967,7971,7972,7973,7974,7975,
						  7976,7977,7978,7979,7980,7982,7983,7984,7985,7986,7987,7999, 
						  18400,18401,18402,18403,18404,22065,22163,22172,28744,74662,
						  7300,7968)

insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7813,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7814,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7815,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7816,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7817,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7818,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7819,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7820,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7821,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7822,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7823,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7824,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7825,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7826,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7827,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7828,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7829,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7830,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7831,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7832,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7833,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7834,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7835,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7836,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7837,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7838,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7839,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7840,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7841,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7842,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7843,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7844,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7845,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7846,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7847,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7848,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7849,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7850,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7851,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7852,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7853,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7854,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7855,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7856,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7857,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7858,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7859,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7860,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7861,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7862,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7863,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7864,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7865,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7866,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7867,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7868,      @w_rol,         '03/29/2005', 3,          'V', '03/29/2005') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7869,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7870,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7871,      @w_rol,         '03/29/2005', 3,          'V', '03/29/2005') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7872,      @w_rol,         '03/29/2005', 3,          'V', '03/29/2005') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7873,      @w_rol,         '03/29/2005', 3,          'V', '03/29/2005') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7882,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7883,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7884,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7885,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7886,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7887,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7888,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7889,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7890,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7891,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7892,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7893,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7894,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7895,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7896,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7897,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7898,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7899,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7900,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7901,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7902,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7903,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7904,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7905,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7906,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7907,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7908,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7909,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7910,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7911,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7912,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7913,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7914,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7915,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7916,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7917,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7918,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7919,      @w_rol,         '03/23/2007', 3,          'V', '03/23/2007') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7920,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7921,      @w_rol,         '09/22/2005', 3,          'V', '09/22/2005') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7922,      @w_rol,         '03/23/2007', 3,          'V', '03/23/2007') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7923,      @w_rol,         '09/22/2005', 3,          'V', '09/22/2005') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7924,      @w_rol,         '09/22/2005', 3,          'V', '09/22/2005') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7925,      @w_rol,         '09/22/2005', 3,          'V', '09/22/2005') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7926,      @w_rol,         '09/22/2005', 3,          'V', '09/22/2005') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7927,      @w_rol,         '03/08/2006', 3,          'V', '03/08/2006') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7928,      @w_rol,         '03/08/2006', 3,          'V', '03/08/2006') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7929,      @w_rol,         '03/08/2006', 3,          'V', '03/08/2006') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7930,      @w_rol,         '03/08/2006', 3,          'V', '03/08/2006') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7931,      @w_rol,         '03/08/2006', 3,          'V', '03/08/2006') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7932,      @w_rol,         '03/08/2006', 3,          'V', '03/08/2006') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7933,      @w_rol,         '03/08/2006', 3,          'V', '03/08/2006') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7934,      @w_rol,         '03/08/2006', 3,          'V', '03/08/2006') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7935,      @w_rol,         '03/09/2006', 3,          'V', '03/09/2006') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7936,      @w_rol,         '03/09/2006', 3,          'V', '03/09/2006') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7937,      @w_rol,         '03/09/2006', 3,          'V', '03/09/2006') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7938,      @w_rol,         '03/09/2006', 3,          'V', '03/09/2006') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7939,      @w_rol,         '03/09/2006', 3,          'V', '03/09/2006') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7940,      @w_rol,         '02/08/2006', 3,          'V', '02/08/2006') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7941,      @w_rol,         '02/08/2006', 3,          'V', '02/08/2006') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7942,      @w_rol,         '02/08/2006', 3,          'V', '02/08/2006') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7943,      @w_rol,         '02/08/2006', 3,          'V', '02/08/2006') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7944,      @w_rol,         '02/08/2006', 3,          'V', '02/08/2006') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7945,      @w_rol,         '02/08/2006', 3,          'V', '02/08/2006') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7946,      @w_rol,         '03/08/2006', 3,          'V', '03/08/2006') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7947,      @w_rol,         '03/08/2006', 3,          'V', '03/08/2006') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7948,      @w_rol,         '03/08/2006', 3,          'V', '03/08/2006') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7949,      @w_rol,         '03/08/2006', 3,          'V', '03/08/2006') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7950,      @w_rol,         '03/08/2006', 3,          'V', '03/08/2006') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7951,      @w_rol,         '03/08/2006', 3,          'V', '03/08/2006') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7952,      @w_rol,         '03/08/2006', 3,          'V', '03/08/2006') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7953,      @w_rol,         '09/22/2005', 3,          'V', '09/22/2005') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7954,      @w_rol,         '09/22/2005', 3,          'V', '09/22/2005') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7955,      @w_rol,         '03/23/2007', 3,          'V', '03/23/2007') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7956,      @w_rol,         '03/23/2007', 3,          'V', '03/23/2007') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7957,      @w_rol,         '02/01/2007', 3,          'V', '02/01/2007') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7958,      @w_rol,         '02/17/2006', 3,          'V', '02/17/2006') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7959,      @w_rol,         '02/17/2006', 3,          'V', '02/17/2006') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7960,      @w_rol,         '02/17/2006', 3,          'V', '02/17/2006') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7961,      @w_rol,         '02/17/2006', 3,          'V', '02/17/2006') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7962,      @w_rol,         '02/17/2006', 3,          'V', '02/17/2006') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7964,      @w_rol,         '03/23/2007', 3,          'V', '03/23/2007') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7965,      @w_rol,         '02/24/2006', 3,          'V', '02/24/2006') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7967,      @w_rol,         '02/27/2006', 3,          'V', '02/27/2006') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7968,      @w_rol,         '02/27/2006', 3,          'V', '02/27/2006')
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7971,      @w_rol,         '10/29/2007', 101,        'V', '10/29/2007') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7972,      @w_rol,         '10/29/2007', 101,        'V', '10/29/2007') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7973,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7974,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7975,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7976,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7977,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7978,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7979,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7980,      @w_rol,         '10/29/2007', 101,        'V', '10/29/2007') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7982,      @w_rol,         '03/04/2008', 3,          'V', '03/04/2008') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7983,      @w_rol,         '07/14/2008', 3,          'V', '07/14/2008') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7984,      @w_rol,         '04/17/2008', 3,          'V', '04/17/2008') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7985,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7986,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7987,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7999,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          18400,     @w_rol,         '03/23/2007', 3,          'V', '03/23/2007') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          18401,     @w_rol,         '03/23/2007', 3,          'V', '03/23/2007') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          18402,     @w_rol,         '03/23/2007', 3,          'V', '03/23/2007') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          18403,     @w_rol,         '03/23/2007', 3,          'V', '03/23/2007') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          18404,     @w_rol,         '03/23/2007', 3,          'V', '03/23/2007') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          22065,     @w_rol,         '05/21/2008', 3,          'V', '05/21/2008') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          22163,     @w_rol,         '08/06/2008', 3,          'V', '08/06/2008') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          22172,     @w_rol,         '02/25/2009', 3,          'V', '02/25/2009') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          28744,     @w_rol,         '02/26/2009', 3,          'V', '02/26/2009') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          74662,     @w_rol,         '03/18/2009', 1,          'V', '03/18/2009') 

insert into cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
							values (7, 'R', @w_moneda, 7300, @w_rol, getdate(), 3, 'V', getdate())
go


declare @w_rol     smallint,
        @w_moneda  tinyint

select @w_moneda = pa_tinyint
  from cobis..cl_parametro
 where pa_nemonico = 'CMNAC'
   and pa_producto = 'ADM'

select @w_rol = ro_rol
  from ad_rol
 where ro_descripcion = 'MENU POR PROCESOS' 
   and ro_filial = 1

delete cobis..ad_tr_autorizada
 where ta_producto = 7
   and ta_rol      = @w_rol
   and ta_moneda   = @w_moneda
   and ta_transaccion in (7963,7966,7881,7969,7988,7989,7997,7998,7992,7993,7994,7995,7996,7297,7295,7296,7299,77505,77506)

insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7963,      @w_rol,         '04/26/2008', 3,          'V', '04/26/2008') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7966,      @w_rol,         '04/26/2008', 3,          'V', '04/26/2008') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7881,      @w_rol,         '05/13/2008', 3,          'V', '05/13/2008') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7969,      @w_rol,         '07/01/2008', 3,          'V', '07/01/2008') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7988,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7989,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7997,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7998,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7992,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7993,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7994,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7995,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004') 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7996,      @w_rol,         '02/28/2004', 3,          'V', '02/28/2004')
insert into cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
 values (7, 'R', @w_moneda, 74663, @w_rol, getdate(), 3, 'V', getdate()) 
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7297,    @w_rol,         getdate(), 3,          'V', getdate())
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7295,    @w_rol,         getdate(), 3,          'V', getdate())
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7296,    @w_rol,         getdate(), 3,          'V', getdate())
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          7299,    @w_rol,         getdate(), 3,          'V', getdate())
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          77505,   @w_rol,         getdate(), 3,          'V', getdate())
insert into cobis..ad_tr_autorizada values (7,          'R', @w_moneda,          77506,   @w_rol,         getdate(), 3,          'V', getdate())

go

--------------------
-- CONCILIACION MANUAL DE PAGOS CASO #107888
--------------------
use cobis
go

declare 
@w_tn_trn_code    int, 
@w_pd_procedure   int, 
@w_pd_producto    tinyint, 
@w_ro_rol		  tinyint, 
@w_ta_autorizante smallint

select @w_tn_trn_code = 7316 -- Se inicializa el codigo de la transacciÃ³n
select @w_pd_procedure = isnull(max(pd_procedure), 0) +1 from ad_procedure -- Obtiene el id de maximo de la tabla cobis..ad_procedure
select @w_pd_producto = pd_producto from cobis..cl_producto where pd_descripcion = 'CARTERA' and pd_abreviatura = 'CCA' -- Obtiene el codigo del producto de cartera
select @w_ro_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'OPERACIONES' -- Obtiene el codigo del rol de operaciones
select @w_ta_autorizante = ro_rol from cobis..ad_rol where ro_descripcion = 'OPERACIONES' -- Obtiene el codigo del rol autorizante

delete from cl_ttransaccion where tn_trn_code = @w_tn_trn_code
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga) values (@w_tn_trn_code, 'CONSULTA DE DATOS DE CONCILIACION MANUAL', @w_tn_trn_code, 'CONSULTA DE DATOS DE CONCILIACION MANUAL')

delete from ad_procedure where pd_stored_procedure = 'sp_conciliar_corresponsal_qry'
insert into ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo) values (@w_pd_procedure, 'sp_conciliar_corresponsal_qry', 'cob_cartera' ,'V', GETDATE(), 'conciliar_qry')

delete from ad_pro_transaccion where pt_transaccion = @w_tn_trn_code and pt_producto = @w_pd_producto
insert into ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial) values (@w_pd_producto, 'R', 0, @w_tn_trn_code, 'V', GETDATE(), @w_pd_procedure, NULL)

delete from ad_tr_autorizada where ta_transaccion = @w_tn_trn_code and ta_producto = @w_pd_producto
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) values (@w_pd_producto, 'R', 0, @w_tn_trn_code, @w_ro_rol, GETDATE(), @w_ta_autorizante, 'V', GETDATE())

------------------------------------------------------------------

select @w_tn_trn_code = 7317 -- Se inicializa el codigo de la transacciÃ³n
select @w_pd_procedure = isnull(max(pd_procedure), 0) +1 from ad_procedure -- Obtiene el id de maximo de la tabla cobis..ad_procedure

delete from cl_ttransaccion where tn_trn_code = @w_tn_trn_code
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga) values (@w_tn_trn_code, 'APLICAR ACCIONES DE CONCILIACION MANUAL', @w_tn_trn_code, 'APLICAR ACCIONES DE CONCILIACION MANUAL')

delete from ad_procedure where pd_stored_procedure = 'sp_conciliar_corresponsal_acc'
insert into ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo) values (@w_pd_procedure, 'sp_conciliar_corresponsal_acc', 'cob_cartera' ,'V', GETDATE(), 'conciliar_acc')

delete from ad_pro_transaccion where pt_transaccion = @w_tn_trn_code and pt_producto = @w_pd_producto
insert into ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial) values (@w_pd_producto, 'R', 0, @w_tn_trn_code, 'V', GETDATE(), @w_pd_procedure, NULL)

delete from ad_tr_autorizada where ta_transaccion = @w_tn_trn_code and ta_producto = @w_pd_producto
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) values (@w_pd_producto, 'R', 0, @w_tn_trn_code, @w_ro_rol, GETDATE(), @w_ta_autorizante, 'V', GETDATE())
go


--------------------
-- PAGOS OBJETADOS #108348
--------------------
use cobis
go

declare 
@w_tn_trn_code    int, 
@w_pd_procedure   int, 
@w_pd_producto    tinyint, 
@w_ro_rol		  tinyint, 
@w_ta_autorizante smallint

--------------------------------- RegularizePayments.ObjetedPayments.GetAllObjetedPayments ---------------------------------

select @w_tn_trn_code = 7070001 -- Se inicializa el codigo de la transacciÃ³n
select @w_pd_procedure = isnull(max(pd_procedure), 0) +1 from ad_procedure -- Obtiene el id de maximo de la tabla cobis..ad_procedure
select @w_pd_producto = pd_producto from cobis..cl_producto where pd_descripcion = 'CARTERA' and pd_abreviatura = 'CCA' -- Obtiene el codigo del producto de cartera
select @w_ro_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'MESA DE OPERACIONES' -- Obtiene el codigo del rol de operaciones
select @w_ta_autorizante = ro_rol from cobis..ad_rol where ro_descripcion = 'MESA DE OPERACIONES' -- Obtiene el codigo del rol autorizante

delete from ad_procedure where pd_stored_procedure = 'sp_abono_objetado'
insert into ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo) values (@w_pd_procedure, 'sp_abono_objetado', 'cob_cartera' ,'V', GETDATE(), 'abono_obj.sp')

select @w_pd_procedure = pd_procedure from ad_procedure where pd_stored_procedure = 'sp_abono_objetado'

delete from cl_ttransaccion where tn_trn_code = @w_tn_trn_code
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga) values (@w_tn_trn_code, 'CONSULTA PAGOS OBJETADOS', @w_tn_trn_code, 'CONSULTA PAGOS OBJETADOS')

delete from ad_pro_transaccion where pt_transaccion = @w_tn_trn_code and pt_producto = @w_pd_producto
insert into ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial) values (@w_pd_producto, 'R', 0, @w_tn_trn_code, 'V', GETDATE(), @w_pd_procedure, NULL)

delete from ad_tr_autorizada where ta_transaccion = @w_tn_trn_code and ta_producto = @w_pd_producto
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) values (@w_pd_producto, 'R', 0, @w_tn_trn_code, @w_ro_rol, GETDATE(), @w_ta_autorizante, 'V', GETDATE())

--------------------------------- RegularizePayments.ObjetedPayments.InsertObjetedPayments ---------------------------------

select @w_tn_trn_code = 7070002 -- Se inicializa el codigo de la transacciÃ³n
select @w_pd_producto = pd_producto from cobis..cl_producto where pd_descripcion = 'CARTERA' and pd_abreviatura = 'CCA' -- Obtiene el codigo del producto de cartera
select @w_ro_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'MESA DE OPERACIONES' -- Obtiene el codigo del rol de operaciones
select @w_ta_autorizante = ro_rol from cobis..ad_rol where ro_descripcion = 'MESA DE OPERACIONES' -- Obtiene el codigo del rol autorizante

delete from cl_ttransaccion where tn_trn_code = @w_tn_trn_code
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga) values (@w_tn_trn_code, 'INSERTAR PAGOS OBJETADOS', @w_tn_trn_code, 'INSERTAR PAGOS OBJETADOS')

delete from ad_pro_transaccion where pt_transaccion = @w_tn_trn_code and pt_producto = @w_pd_producto
insert into ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial) values (@w_pd_producto, 'R', 0, @w_tn_trn_code, 'V', GETDATE(), @w_pd_procedure, NULL)

delete from ad_tr_autorizada where ta_transaccion = @w_tn_trn_code and ta_producto = @w_pd_producto
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) values (@w_pd_producto, 'R', 0, @w_tn_trn_code, @w_ro_rol, GETDATE(), @w_ta_autorizante, 'V', GETDATE())


--------------------------------- RegularizePayments.ObjetedPayments.OpRegularizePayments ---------------------------------

select @w_tn_trn_code = 7070003 -- Se inicializa el codigo de la transacciÃ³n
select @w_pd_producto = pd_producto from cobis..cl_producto where pd_descripcion = 'CARTERA' and pd_abreviatura = 'CCA' -- Obtiene el codigo del producto de cartera
select @w_ro_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'MESA DE OPERACIONES' -- Obtiene el codigo del rol de operaciones
select @w_ta_autorizante = ro_rol from cobis..ad_rol where ro_descripcion = 'MESA DE OPERACIONES' -- Obtiene el codigo del rol autorizante

delete from cl_ttransaccion where tn_trn_code = @w_tn_trn_code
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga) values (@w_tn_trn_code, 'REGULARIZAR PAGOS OBJETADOS', @w_tn_trn_code, 'REGULARIZAR PAGOS OBJETADOS')

delete from ad_pro_transaccion where pt_transaccion = @w_tn_trn_code and pt_producto = @w_pd_producto
insert into ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial) values (@w_pd_producto, 'R', 0, @w_tn_trn_code, 'V', GETDATE(), @w_pd_procedure, NULL)

delete from ad_tr_autorizada where ta_transaccion = @w_tn_trn_code and ta_producto = @w_pd_producto
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) values (@w_pd_producto, 'R', 0, @w_tn_trn_code, @w_ro_rol, GETDATE(), @w_ta_autorizante, 'V', GETDATE())
----------------------------------------------------------------------
go
----------------------------------------------------------------------
-- sp_pagos_corresponsal_batch

select @w_tn_trn_code   = 775071 -- Se inicializa el codigo de la transacciÃ³n
select @w_pd_procedure  = 775071
select @w_pd_producto = pd_producto from cobis..cl_producto where pd_descripcion = 'CARTERA' and pd_abreviatura = 'CCA' -- Obtiene el codigo del producto de cartera

select @w_ro_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'SCHEDULER CTS' -- Obtiene el codigo del rol de operaciones
select @w_ta_autorizante = ro_rol from cobis..ad_rol where ro_descripcion = 'SCHEDULER CTS' -- Obtiene el codigo del rol autorizante

-- SE INSERTA EN LA TABLA DE TRANSACCIONES CON EL SECUENCIAL DE TRANSACCIONES
delete from cobis..cl_ttransaccion where tn_trn_code = @w_tn_trn_code and tn_descripcion = 'TANQUEO CORRESPONSAL' 
INSERT INTO cobis..cl_ttransaccion(tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga) 
VALUES(@w_tn_trn_code, 'TANQUEO CORRESPONSAL', @w_tn_trn_code, 'TANQUEO CORRESPONSAL')

-- SE INSERTA EN LA TABLA AD_PROCEDURE EL SP CON EL SECUENCUAL DE PROCEDURE
delete from cobis..ad_procedure where pd_procedure = @w_pd_procedure and pd_stored_procedure ='sp_pagos_corresponsal_batch' 
INSERT INTO cobis..ad_procedure(pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo) 
VALUES(@w_pd_procedure, 'sp_pagos_corresponsal_batch', 'cob_cartera', 'V', getdate(), 'sp_corr_bat.sp')

-- ASOCIACION DE LA TRANSACCION CON EL SP POR LA TRANSACCION SECUENCIAL
delete from cobis..ad_pro_transaccion where pt_transaccion=@w_tn_trn_code and pt_procedure = @w_pd_procedure
INSERT INTO cobis..ad_pro_transaccion(pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial) 
VALUES(@w_pd_producto, 'R', 0, @w_tn_trn_code, 'V', getdate(), @w_pd_procedure, NULL)

-- AUTORIZACION DE LA TRANSACCION EN EL ROL 20 CON EL SECUENCIAL DEL DE LA TRANSACCION
delete from cobis..ad_tr_autorizada where ta_transaccion = @w_tn_trn_code and ta_rol=@w_ro_rol
INSERT INTO cobis..ad_tr_autorizada(ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
VALUES(@w_pd_producto, 'R', 0, @w_tn_trn_code, @w_ro_rol, getdate(), @w_ta_autorizante, 'V', getdate())

---------------------------------------------------------------------------------

select @w_tn_trn_code      = 775061
select @w_pd_procedure     = 775061
select @w_pd_producto = pd_producto from cobis..cl_producto where pd_descripcion = 'CARTERA' and pd_abreviatura = 'CCA' -- Obtiene el codigo del producto de cartera

select @w_ro_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'CORRESPONSAL OXXO'

delete from cobis..cl_ttransaccion where tn_trn_code = @w_tn_trn_code and tn_descripcion = 'CORRESPONSAL OXXO'
INSERT INTO cobis..cl_ttransaccion(tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga) 
VALUES(@w_tn_trn_code, 'CORRESPONSAL OXXO', @w_tn_trn_code, 'CORRESPONSAL OXXO')

delete from cobis..ad_procedure where pd_procedure = @w_pd_procedure and pd_stored_procedure ='sp_corresponsal_consulta' 
INSERT INTO cobis..ad_procedure(pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo) 
VALUES(@w_pd_procedure, 'sp_corresponsal_consulta', 'cob_cartera', 'V', getdate(), 'sp_corr_con.sp')

delete from cobis..ad_pro_transaccion where pt_transaccion=@w_tn_trn_code and pt_procedure = @w_pd_procedure
INSERT INTO cobis..ad_pro_transaccion(pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial) 
VALUES(@w_pd_producto, 'R', 0, @w_tn_trn_code, 'V', getdate(), @w_pd_procedure, NULL)

delete from cobis..ad_tr_autorizada where ta_transaccion = @w_tn_trn_code and ta_rol=@w_ro_rol
INSERT INTO cobis..ad_tr_autorizada(ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
VALUES(@w_pd_producto, 'R', 0, @w_tn_trn_code, @w_ro_rol, getdate(), 1, 'V', getdate())
GO

-----------------------------------------------
-------------venta de seguros------------------
-------reporte de seguros consulta-------------
-----------------------------------------------
select @w_tn_trn_code      = 74007
select @w_pd_procedure     = 74007
select @w_pd_producto = pd_producto from cobis..cl_producto where pd_descripcion = 'CARTERA' and pd_abreviatura = 'CCA' -- Obtiene el codigo del producto de cartera

select @w_ro_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'CONSULTA'

delete from cobis..ad_pro_transaccion where pt_transaccion=@w_tn_trn_code and pt_procedure = @w_pd_procedure
INSERT INTO cobis..ad_pro_transaccion(pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial) 
VALUES(@w_pd_producto, 'R', 0, @w_tn_trn_code, 'V', getdate(), @w_pd_procedure, NULL)

delete from cobis..cl_ttransaccion where tn_trn_code = @w_tn_trn_code and tn_descripcion = 'Reporte Consentimiento de seguros TUIIO Seguro'
INSERT INTO cobis..cl_ttransaccion(tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga) 
VALUES(@w_tn_trn_code, 'Reporte Consentimiento de seguros TUIIO Seguro', @w_tn_trn_code, 'Reporte Consentimiento de seguros TUIIO Seguro')

delete from cobis..ad_tr_autorizada where ta_transaccion = @w_tn_trn_code and ta_rol=@w_ro_rol
INSERT INTO cobis..ad_tr_autorizada(ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
VALUES(@w_pd_producto, 'R', 0, @w_tn_trn_code, @w_ro_rol, getdate(), 1, 'V', getdate())

delete from cobis..ad_procedure where pd_procedure = @w_pd_procedure and pd_stored_procedure ='sp_conse_seguro' 
INSERT INTO cobis..ad_procedure(pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo) 
VALUES(@w_pd_procedure, 'sp_conse_seguro', 'cob_cartera', 'V', getdate(), 'sp_conse_seguro.sp')
GO
---------------------------------
---reporte de seguros + medico---
---------------------------------
select @w_tn_trn_code      = 74008
select @w_pd_procedure     = 74008
select @w_pd_producto = pd_producto from cobis..cl_producto where pd_descripcion = 'CARTERA' and pd_abreviatura = 'CCA' -- Obtiene el codigo del producto de cartera

select @w_ro_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'CONSULTA'

delete from cobis..ad_pro_transaccion where pt_transaccion=@w_tn_trn_code and pt_procedure = @w_pd_procedure
INSERT INTO cobis..ad_pro_transaccion(pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial) 
VALUES(@w_pd_producto, 'R', 0, @w_tn_trn_code, 'V', getdate(), @w_pd_procedure, NULL)

delete from cobis..cl_ttransaccion where tn_trn_code = @w_tn_trn_code and tn_descripcion = 'Reporte Consentimiento de seguros TUIIO Seguro + MÃ©dico'
INSERT INTO cobis..cl_ttransaccion(tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga) 
VALUES(@w_tn_trn_code, 'Reporte Consentimiento de seguros TUIIO Seguro + MÃ©dico', @w_tn_trn_code, 'Reporte Consentimiento de seguros TUIIO Seguro + MÃ©dico')

delete from cobis..ad_tr_autorizada where ta_transaccion = @w_tn_trn_code and ta_rol=@w_ro_rol
INSERT INTO cobis..ad_tr_autorizada(ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
VALUES(@w_pd_producto, 'R', 0, @w_tn_trn_code, @w_ro_rol, getdate(), 1, 'V', getdate())

delete from cobis..ad_procedure where pd_procedure = @w_pd_procedure and pd_stored_procedure ='sp_conse_seguro_medico' 
INSERT INTO cobis..ad_procedure(pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo) 
VALUES(@w_pd_procedure, 'sp_conse_seguro_medico', 'cob_cartera', 'V', getdate(), 'sp_conse_seguro_medico.sp')
GO
---------------------------------
---rconsultar clientes 
---------------------------------
---------------------------------
select @w_tn_trn_code      = 74009
select @w_pd_procedure     = 74009
select @w_pd_producto = pd_producto from cobis..cl_producto where pd_descripcion = 'CARTERA' and pd_abreviatura = 'CCA' -- Obtiene el codigo del producto de cartera

select @w_ro_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'CONSULTA'

delete from cobis..ad_pro_transaccion where pt_transaccion=@w_tn_trn_code and pt_procedure = @w_pd_procedure
INSERT INTO cobis..ad_pro_transaccion(pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial) 
VALUES(@w_pd_producto, 'R', 0, @w_tn_trn_code, 'V', getdate(), @w_pd_procedure, NULL)

delete from cobis..cl_ttransaccion where tn_trn_code = @w_tn_trn_code and tn_descripcion = 'consullta de clientes de un grupo'
INSERT INTO cobis..cl_ttransaccion(tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga) 
VALUES(@w_tn_trn_code, 'consullta de clientes de un grupo', @w_tn_trn_code, 'consullta de clientes de un grupo')

delete from cobis..ad_tr_autorizada where ta_transaccion = @w_tn_trn_code and ta_rol=@w_ro_rol
INSERT INTO cobis..ad_tr_autorizada(ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
VALUES(@w_pd_producto, 'R', 0, @w_tn_trn_code, @w_ro_rol, getdate(), 1, 'V', getdate())

delete from cobis..ad_procedure where pd_procedure = @w_pd_procedure and pd_stored_procedure ='sp_clientes_grupo' 
INSERT INTO cobis..ad_procedure(pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo) 
VALUES(@w_pd_procedure, 'sp_clientes_grupo', 'cob_cartera', 'V', getdate(), 'sp_clientes_grupo.sp')
GO
-----------------------------------------
---consulta tipo seguro -----------------
-----------------------------------------
-----------------------------------------
select @w_tn_trn_code      = 74010
select @w_pd_procedure     = 74010
select @w_pd_producto = pd_producto from cobis..cl_producto where pd_descripcion = 'CARTERA' and pd_abreviatura = 'CCA' -- Obtiene el codigo del producto de cartera

select @w_ro_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'CONSULTA'

delete from cobis..ad_pro_transaccion where pt_transaccion=@w_tn_trn_code and pt_procedure = @w_pd_procedure
INSERT INTO cobis..ad_pro_transaccion(pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial) 
VALUES(@w_pd_producto, 'R', 0, @w_tn_trn_code, 'V', getdate(), @w_pd_procedure, NULL)

delete from cobis..cl_ttransaccion where tn_trn_code = @w_tn_trn_code and tn_descripcion = 'Consulta tipo de seguros'
INSERT INTO cobis..cl_ttransaccion(tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga) 
VALUES(@w_tn_trn_code, 'Consulta tipo de seguros', @w_tn_trn_code, 'Consulta tipo de seguros')

delete from cobis..ad_tr_autorizada where ta_transaccion = @w_tn_trn_code and ta_rol=@w_ro_rol
INSERT INTO cobis..ad_tr_autorizada(ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
VALUES(@w_pd_producto, 'R', 0, @w_tn_trn_code, @w_ro_rol, getdate(), 1, 'V', getdate())

delete from cobis..ad_procedure where pd_procedure = @w_pd_procedure and pd_stored_procedure ='sp_cons_tipo_seguro' 
INSERT INTO cobis..ad_procedure(pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo) 
VALUES(@w_pd_procedure, 'sp_cons_tipo_seguro', 'cob_cartera', 'V', getdate(), 'sp_cons_tipo_seguro.sp')
GO

----------------------------------------->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>-----------------------------------------
-----------------------------------------Para pagos de garantias caso #153406
----------------------------------------->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>-----------------------------------------
select @w_tn_trn_code = 775073 -- Se inicializa el codigo de la transacción
select @w_pd_procedure  = 775073
select @w_pd_producto = pd_producto from cobis..cl_producto where pd_descripcion = 'CARTERA' and pd_abreviatura = 'CCA' -- Obtiene el codigo del producto de cartera

select @w_ro_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'SCHEDULER CTS' -- Obtiene el codigo del rol de operaciones
select @w_ta_autorizante = ro_rol from cobis..ad_rol where ro_descripcion = 'SCHEDULER CTS' -- Obtiene el codigo del rol autorizante

-- SE INSERTA EN LA TABLA DE TRANSACCIONES CON EL SECUENCIAL DE TRANSACCIONES
delete from cobis..cl_ttransaccion where tn_trn_code = @w_tn_trn_code and tn_descripcion = 'TANQUEO CORRESPONSAL PAGO GARANTIA' 
INSERT INTO cobis..cl_ttransaccion(tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga) 
VALUES(@w_tn_trn_code, 'TANQUEO CORRESPONSAL PAGO GARANTIA', @w_tn_trn_code, 'TANQUEO CORRESPONSAL PAGO GARANTIA')

-- SE INSERTA EN LA TABLA AD_PROCEDURE EL SP CON EL SECUENCUAL DE PROCEDURE
delete from cobis..ad_procedure where pd_procedure = @w_pd_procedure and pd_stored_procedure ='sp_pagos_corresponsl_gl_batch' 
INSERT INTO cobis..ad_procedure(pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo) 
VALUES(@w_pd_procedure, 'sp_pagos_corresponsl_gl_batch', 'cob_cartera', 'V', getdate(), 'sp_pgclglbh.sp')

-- ASOCIACION DE LA TRANSACCION CON EL SP POR LA TRANSACCION SECUENCIAL
delete from cobis..ad_pro_transaccion where pt_transaccion=@w_tn_trn_code and pt_procedure = @w_pd_procedure
INSERT INTO cobis..ad_pro_transaccion(pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial) 
VALUES(@w_pd_producto, 'R', 0, @w_tn_trn_code, 'V', getdate(), @w_pd_procedure, NULL)

-- AUTORIZACION DE LA TRANSACCION EN EL ROL 20 CON EL SECUENCIAL DEL DE LA TRANSACCION
delete from cobis..ad_tr_autorizada where ta_transaccion = @w_tn_trn_code and ta_rol=@w_ro_rol
INSERT INTO cobis..ad_tr_autorizada(ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
VALUES(@w_pd_producto, 'R', 0, @w_tn_trn_code, @w_ro_rol, getdate(), @w_ta_autorizante, 'V', getdate())

GO

/*************************************************************************/
/*   Archivo:              autoriza_transaccion.sql          		     */
/*   Stored procedure:     autoriza_transaccion.sql      		    	 */
/*   Base de datos:        cobis		                                 */
/*   Producto:             cartera                                  	 */
/*   Disenado por:         jcastro                                       */
/*   Fecha de escritura:   Octubre 2020                              	 */
/*************************************************************************/
/*                                  IMPORTANTE                           */
/*   Este programa es parte de los paquetes bancarios propiedad de       */
/*   'COBIS'.                                                            */
/*   Su uso no autorizado queda expresamente prohibido asi como          */
/*   cualquier alteracion o agregado hecho por alguno de sus             */
/*   usuarios sin el debido consentimiento por escrito de la             */
/*   Presidencia Ejecutiva de COBIS o su representante legal.            */
/*************************************************************************/
/*                                   PROPOSITO                           */
/*   				Script para la creación de la transacción 			 */
/*   				  y la autorizacion para el caso 107888 			 */
/*                              CAMBIOS                                  */
/*************************************************************************/
/*                             MODIFICACION                              */
/*    FECHA                 AUTOR                 RAZON                  */
/*    10/Octubre/2020       Johan Castro          Emision inicial        */
/*                                                                       */
/*************************************************************************/
USE cobis
GO

DECLARE 
@w_tn_trn_code    int, 
@w_pd_procedure   int, 
@w_pd_producto    tinyint, 
@w_ro_rol		  tinyint, 
@w_ta_autorizante smallint

-- Se inicializa el codigo de la transacción
SELECT @w_tn_trn_code = 775100

-- Obtiene el id de maximo de la tabla cobis..ad_procedure
SELECT @w_pd_procedure = ISNULL(MAX(pd_procedure), 0) +1 FROM ad_procedure
select @w_pd_procedure 

-- Obtiene el codigo del producto de cartera
SELECT @w_pd_producto = pd_producto FROM cobis..cl_producto WHERE pd_descripcion = 'CARTERA' AND pd_abreviatura = 'CCA'

-- Obtiene el codigo del rol de OPERACIONES 
SELECT @w_ro_rol = ro_rol FROM cobis..ad_rol WHERE ro_descripcion = 'OPERACIONES'

-- Obtiene el codigo del rol autorizante
SELECT @w_ta_autorizante = ro_rol FROM cobis..ad_rol WHERE ro_descripcion = 'OPERACIONES'

DELETE FROM cl_ttransaccion
	WHERE tn_descripcion = 'CONSULTA CONSENTIMIENTO ZURICH'

INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
	VALUES (@w_tn_trn_code, 'CONSULTA CONSENTIMIENTO ZURICH', @w_tn_trn_code, 'CONSENTIMIENTO ZURICH')

DELETE FROM ad_procedure
  WHERE pd_stored_procedure = 'sp_conse_seguro_zurich'

INSERT INTO ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
	VALUES (@w_pd_procedure, 'sp_conse_seguro_zurich', 'cob_cartera' ,'V', GETDATE(), 'segzurich')

DELETE FROM ad_pro_transaccion
	WHERE pt_transaccion = @w_tn_trn_code AND pt_producto = @w_pd_producto

INSERT INTO ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
	VALUES (@w_pd_producto, 'R', 0, @w_tn_trn_code, 'V', GETDATE(), @w_pd_procedure, NULL)

DELETE FROM ad_tr_autorizada
	WHERE ta_transaccion = @w_tn_trn_code AND ta_producto = @w_pd_producto

INSERT INTO ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
	VALUES (@w_pd_producto, 'R', 0, @w_tn_trn_code, 10, GETDATE(), @w_ta_autorizante, 'V', GETDATE())
INSERT INTO ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
	VALUES (@w_pd_producto, 'R', 0, @w_tn_trn_code, 12, GETDATE(), @w_ta_autorizante, 'V', GETDATE())
INSERT INTO ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
	VALUES (@w_pd_producto, 'R', 0, @w_tn_trn_code, 16, GETDATE(), @w_ta_autorizante, 'V', GETDATE())
INSERT INTO ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
	VALUES (@w_pd_producto, 'R', 0, @w_tn_trn_code, 26, GETDATE(), @w_ta_autorizante, 'V', GETDATE())
	

