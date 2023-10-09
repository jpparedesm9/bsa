use cobis
go

set nocount on
go

delete ad_procedure
where pd_procedure in (714, 4000, 4001, 4002, 4003, 4004, 4005, 4006, 4008, 4009, 4010,
4011, 4012, 4013, 4014, 4015, 4016, 4017, 4018, 4019, 4021,
4022, 4023, 4024, 4025, 4026, 4027, 4028, 4029, 4030, 4031,
4032, 4033, 4034, 4035, 4036, 4037, 4038, 4039, 4040, 4041,
4042, 4043, 4044, 4045, 4046, 4047, 4048, 4049, 4050, 4051,
4054, 4055, 4056, 4060, 4061, 4062, 4063, 4064, 4065, 420, 421, 422,2940
)

go
insert into ad_procedure values(421,'sp_rango_fechas',        'cob_remesas','V',getdate(),'rangofechas.sp')
insert into ad_procedure values(714,'sp_autoriza_trn_caja','cob_remesas','V','Dec 20 1994  1:48:26:000PM','peauttrncj.sp')
insert into ad_procedure values(4000,'sp_prod_bancario','cob_remesas','V','Dec 20 1994  1:48:26:000PM','pe_pro_banc.sp')
insert into ad_procedure values(4001,'sp_mercado','cob_remesas','V','Dec 20 1994  1:48:26:000PM','pe_merca.sp')
insert into ad_procedure values(4002,'sp_prodfin','cob_remesas','V','Dec 20 1994  1:48:26:000PM','pe_profinal.sp')
insert into ad_procedure values(4003,'sp_rubros','cob_remesas','V','Dec 20 1994  1:48:26:000PM','pe_rubro.sp')
insert into ad_procedure values(4004,'sp_cosub','cob_remesas','V','Dec 20 1994  1:48:26:000PM','pe_cosub.sp')
insert into ad_procedure values(4005,'sp_corubros','cob_remesas','V','Dec 20 1994  1:48:26:000PM','pe_cobrubro.sp')
insert into ad_procedure values(4006,'sp_serv_contratado','cob_remesas','V','Dec 20 1994  1:48:26:000PM','pe_serv.sp')
insert into ad_procedure values(4008,'sp_det_serv_pe','cob_remesas','V','Dec 20 1994  1:48:26:000PM','peinacsu.sp')
insert into ad_procedure values(4009,'sp_ins_serv_pe','cob_remesas','V','Dec 20 1994  1:48:26:000PM','peinser.sp')
go
insert into ad_procedure values(4010,'sp_help_serv_pe','cob_remesas','V','Dec 20 1994  1:48:26:000PM','peheserv.sp')
insert into ad_procedure values(4011,'sp_tip_rng_pe','cob_remesas','V','Dec 20 1994  1:48:26:000PM','petirang.sp')
insert into ad_procedure values(4012,'sp_rango_pe','cob_remesas','V','Dec 20 1994  1:48:26:000PM','perango.sp')
insert into ad_procedure values(4013,'sp_help_rango_pe','cob_remesas','V','Dec 20 1994  1:48:26:000PM','peherang.sp')
insert into ad_procedure values(4014,'sp_help_cosub','cob_remesas','V','Dec 20 1994  1:48:26:000PM','pecosubs.sp')
insert into ad_procedure values(4015,'sp_basico_pe','cob_remesas','V','Dec 20 1994  1:48:26:000PM','pebasico.sp')
insert into ad_procedure values(4016,'sp_promon','cob_remesas','V','Dec 20 1994  1:48:26:000PM','pe_promo.sp')
insert into ad_procedure values(4017,'sp_help_rubros','cob_remesas','V','Dec 20 1994  1:48:26:000PM','pe_corubro1.sp')
insert into ad_procedure values(4018,'sp_corango_pe','cob_remesas','V','Dec 20 1994  1:48:26:000PM','pecorango.sp')
insert into ad_procedure values(4019,'sp_consulta_personalizacion','cob_remesas','V','Dec 20 1994  1:48:26:000PM','pe_convalct.sp')
insert into ad_procedure values(4021,'sp_personaliza_costos','cob_remesas','V','Dec 20 1994  1:48:26:000PM','pe_genvalct.sp')
insert into ad_procedure values(4022,'sp_consulta_costos','cob_remesas','V','Dec 20 1994  1:48:26:000PM','peconcos.sp')
insert into ad_procedure values(4023,'sp_tr_costos','cob_remesas','V','Dec 20 1994  1:48:26:000PM','pecostos.sp')
insert into ad_procedure values(4024,'sp_reg_cambios_costos','cob_remesas','V','Dec 20 1994  1:48:26:000PM','pelogcos.sp')
insert into ad_procedure values(4025,'sp_registra_personalizacion','cob_remesas','V','Dec 20 1994  1:48:26:000PM','pelogvar.sp')
go
insert into ad_procedure values(4026,'sp_help_costos','cob_remesas','V','Dec 20 1994  1:48:26:000PM','pehecos.sp')
go
insert into ad_procedure values(4027,'sp_help2_costos','cob_remesas','V','Dec 20 1994  1:48:26:000PM','pehecos2.sp')
go
insert into ad_procedure values(4028,'sp_limite','cob_remesas','V','Dec 20 1994  1:48:26:000PM','pelimite.sp')
go
insert into ad_procedure values(4029,'sp_contrato_servicios','cob_remesas','V','Dec 20 1994  1:48:26:000PM','pevalcon.sp')
go
insert into ad_procedure values(4030,'sp_personaliza_cuenta',     'cob_remesas','V','Dec 20 1994  1:48:26:000PM','pepercta.sp')
insert into ad_procedure values(4031,'sp_valor_contratado',       'cob_remesas','V',getdate(),'peconval.sp')
insert into ad_procedure values(4032,'sp_con_costot_no_linea',    'cob_remesas','V',getdate(),'peconoli.sp')
insert into ad_procedure values(4033,'sp_con_costot_linea',       'cob_remesas','V',getdate(),'pecocost.sp')
insert into ad_procedure values(4034,'sp_costos_total',           'cob_remesas','V',getdate(),'pecostot.sp')
insert into ad_procedure values(4035,'sp_corango_ma',             'cob_remesas','V',getdate(),'pecoranm.sp')

insert into ad_procedure values(4036,'sp_categoria_profinal',     'cob_remesas','V',getdate(),'pecatpro.sp')
insert into ad_procedure values(4037,'sp_cons_var_costos',        'cob_remesas','V',getdate(),'convarco.sp')
insert into ad_procedure values(4038,'sp_ciclo_profinal',         'cob_remesas','V',getdate(),'pecicpro.sp')
insert into ad_procedure values(4039,'sp_capitalizacion_profinal','cob_remesas','V',getdate(),'pecappro.sp')
go

insert into ad_procedure values(4040,'sp_conc_ext_gmf',           'cob_remesas','V',getdate(),'recexgmf.sp')
insert into ad_procedure values(4041,'sp_conc_ext_gmf',           'cob_remesas','V',getdate(),'recexgmf.sp')
insert into ad_procedure values(4042,'sp_conc_ext_gmf',           'cob_remesas','V',getdate(),'recexgmf.sp')
insert into ad_procedure values(4043,'sp_costos_especiales',           'cob_remesas','V',getdate(),'pecosesp.sp')
insert into ad_procedure values(4044,'sp_costos_especiales_per',           'cob_remesas','V',getdate(),'pecosper.sp')
insert into ad_procedure values(4045,'sp_mant_especiales',           'cob_remesas','V',getdate(),'permanesp.s')
insert into ad_procedure values(4046,'sp_concepto_tran',          'cob_remesas','V',getdate(),'conctrn.sp')
insert into ad_procedure values(4047,'sp_conc_ext_gmf',           'cob_remesas','V',getdate(),'recexgmf.sp')
insert into ad_procedure values(4048,'sp_calcula_gmf',            'cob_ahorros','V',getdate(),'ahcalgmf.sp')
insert into ad_procedure values(4049,'sp_upd_gmf_ac',             'cob_ahorros','V',getdate(),'ahcupgmf.sp')
go


/* FRC-AHO-017-CobroComisiones CMU 01/12/09*/
insert into ad_procedure values(4050,'sp_cobcom_profinal',        'cob_remesas','V',getdate(),'peparcom.sp')
insert into ad_procedure values(4051,'sp_producto_contractual',   'cob_remesas','V',getdate(),'peprocon.sp')
insert into ad_procedure values(4054,'sp_topes_oficina',        'cob_remesas','V',getdate(),'petopeofi.sp')
insert into ad_procedure values(4055,'sp_parametro_extracto',   'cob_remesas','V',getdate(),'peparext.sp')
insert into ad_procedure values(4056,'sp_control_manejo_extracto',        'cob_remesas','V',getdate(),'peconext.sp')
insert into ad_procedure values(4060,'sp_mantenimiento_std',   'cob_remesas','V',getdate(),'pe_subtd.sp')
insert into ad_procedure values(4061,'sp_cambio_categoria',        'cob_remesas','V',getdate(),'ahcamcat.sp')
insert into ad_procedure values(4062,'sp_aut_retiro_oficina',   'cob_remesas','V',getdate(),'ahretofi.sp')
insert into ad_procedure values(4063,'sp_activa_cta_provisional',   'cob_remesas','V',getdate(),'ahaccupr.sp')
insert into ad_procedure values(4064,'sp_ah_trn_depo_inicial',        'cob_remesas','V',getdate(),'ahtdepini.sp')
insert into ad_procedure values(4065,'sp_valida_tiempo_activa',   'cob_remesas','V',getdate(),'ahvalact.sp')

insert into ad_procedure values(420,'sp_cons_productoban',   'cob_remesas','V',getdate(),'consproban.sp')

insert into ad_procedure values(422,'sp_caradicionales',   'cob_remesas','V',getdate(),'caradi.sp')

insert into ad_procedure values(2940,'sp_contrato_producto','cob_remesas','V',getdate(),'contra_prod.sp')
go



