use cob_conta_super
go

IF OBJECT_ID ('sb_ods_balanactivos_ttj') IS NOT NULL
	drop table sb_ods_balanactivos_ttj
go

create table sb_ods_balanactivos_ttj
	(
	ob_num_cuenta      varchar (25),
	ob_cod_cta_cont    varchar (25),
	ob_cod_divisa      varchar (50),
	ob_fec_data        varchar (10),
	ob_cod_pais        varchar (50),
	ob_cod_centro_cont varchar (50),
	ob_cod_entidad     varchar (50),
	ob_imp_sdo_cont_mo varchar (50),
	ob_imp_sdo_cont_ml varchar (50)
	)
go


IF OBJECT_ID ('sb_ods_movresultados_ttj') IS NOT NULL
	drop table sb_ods_movresultados_ttj
go

create table sb_ods_movresultados_ttj
	(
	om_num_cuenta      varchar (25),
	om_cod_cta_cont    varchar (25),
	om_cod_divisa      varchar (50),
	om_fec_data        varchar (10),
	om_cod_pais        varchar (50),
	om_cod_centro_cont varchar (50),
	om_cod_entidad     varchar (50),
	om_imp_ie_mo       varchar (50),
	om_imp_ie_ml       varchar (50)
	)
go



IF OBJECT_ID ('sb_ods_plancuentas_ttj') IS NOT NULL
	drop table sb_ods_plancuentas_ttj
go

create table dbo.sb_ods_plancuentas_ttj
	(
	op_cod_cta_cont   varchar (25),
	op_cod_entidad    varchar (50),
	op_des_cta_cont   varchar (64),
	op_tip_cta_cont   varchar (2),
	op_tip_divisa     varchar (50),
	op_cls_sdo        varchar (50),
	op_cod_est_sdo    varchar (50),
	op_tip_acceso     varchar (50),
	op_cod_est_cuenta varchar (50),
	op_fec_alta       varchar (10),
	op_fec_baja       varchar (10),
	op_fec_data       varchar (10),
	op_cod_cargabal   varchar (20)
	)
go




IF OBJECT_ID ('sb_ods_saldos_cont_ttj') IS NOT NULL
	DROP table sb_ods_saldos_cont_ttj
go

create table sb_ods_saldos_cont_ttj
	(
	os_cod_cta_cont    varchar (24),
	os_cod_centro_cont varchar (20),
	os_cod_divisa      varchar (3),
	os_cod_entidad     varchar (20),
	os_tip_divisa      varchar (20),
	os_sdo_mo          varchar (20),
	os_sdo_ml          varchar (20),
	os_sdo_med_mo      varchar (20),
	os_sdo_med_ml      varchar (20),
	os_sdo_mes_mo      varchar (20),
	os_sdo_mes_ml      varchar (20),
	os_fecha_corte     varchar (10),
	os_cod_area_cont   varchar (20),
	os_des_area_cont   varchar (50)
	)
go

IF OBJECT_ID ('dbo.sb_riesgo_hrc_ttj') IS NOT NULL
	DROP table dbo.sb_riesgo_hrc_ttj
go

create table dbo.sb_riesgo_hrc_ttj
	(
	rh_fec_info                     varchar (30),
	rh_num_cred                     varchar (25),
	rh_num_cliente_operativo        varchar (64),
	rh_desc_nombre_cliente          varchar (255),
	rh_cod_entidad                  varchar (4),
	rh_desc_entidad                 varchar (30),
	rh_desc_sistema_origen          varchar (10),
	rh_num_suc_titular              varchar (20),
	rh_cod_producto                 varchar (2),
	rh_cod_subproducto              varchar (4),
	rh_desc_producto                varchar (25),
	rh_desc_subproducto             varchar (20),
	rh_flg_revolvente               varchar (10),
	rh_flg_tratamiento_contable     varchar (10),
	rh_cod_tipo_amortiza            varchar (10),
	rh_desc_tipo_amortiza           varchar (30),
	rh_num_cta_cheques              varchar (25),
	rh_fec_formaliza                varchar (30),
	rh_fec_vencimiento              varchar (30),
	rh_cod_tasa                     varchar (9),
	rh_desc_tasa                    varchar (15),
	rh_flg_tasa_variable            varchar (10),
	rh_fec_prox_revisa_tasa         varchar (30),
	rh_cod_periodo_revisa_tasa      varchar (1),
	rh_pct_tasa_cobr                varchar (50),
	rh_num_puntos_spread            varchar (10),
	rh_fec_ult_amort_incump_cap     varchar (30),
	rh_fec_ult_amort_incump_int     varchar (30),
	rh_num_doctos_vencidos          varchar (5),
	rh_cod_periodo_capital          varchar (10),
	rh_desc_periodo_capital         varchar (10),
	rh_cod_periodo_intereses        varchar (10),
	rh_desc_periodo_intereses       varchar (10),
	rh_cod_bloqueo                  varchar (10),
	rh_desc_bloqueo                 varchar (1),
	rh_cod_moneda                   varchar (3),
	rh_imp_concedido                varchar (30),
	rh_imp_limite_credito           varchar (30),
	rh_imp_disponible               varchar (30),
	rh_imp_total_riesgo_sistema     varchar (30),
	rh_imp_cap_noexig               varchar (30),
	rh_imp_cap_exig                 varchar (30),
	rh_imp_int_noexig               varchar (30),
	rh_imp_int_exig                 varchar (30),
	rh_imp_int_suspen               varchar (30),
	rh_imp_inversion                varchar (30),
	rh_imp_total_riesgo             varchar (30),
	rh_fec_traspaso_vencido         varchar (30),
	rh_num_linea_madre              varchar (64),
	rh_flg_mora_sistema             varchar (10),
	rh_fec_prox_corte               varchar (30),
	rh_cod_pais_origen              varchar (10),
	rh_cod_pais_residencia          varchar (10),
	rh_cod_tipo_persona             varchar (32),
	rh_cod_sector_economico         varchar (10),
	rh_cod_unidad_negocio           varchar (1),
	rh_cod_unidad_negocio_ope_ori   varchar (1),
	rh_cod_sector_contable          varchar (1),
	rh_cod_actividad_economica      varchar (10),
	rh_desc_rfc                     varchar (255),
	rh_desc_pais_origen             varchar (64),
	rh_desc_pais_residencia         varchar (64),
	rh_desc_sector_economico        varchar (200),
	rh_desc_tipo_persona            varchar (64),
	rh_desc_unidad_negocio          varchar (64),
	rh_cod_localidad_dom_primario   varchar (64),
	rh_desc_actividad_economica_esp varchar (200),
	rh_fec_prox_corte_prin          varchar (30),
	rh_fec_prox_corte_int           varchar (30),
	rh_fec_formaliza_ult_disp       varchar (30),
	rh_imp_seguro_desempleo         varchar (30),
	rh_imp_seguro_vida              varchar (30),
	rh_flg_garantia                 varchar (30),
	rh_pct_tasa_base                varchar (50),
	rh_imp_pag_adelantado           varchar (30),
	rh_num_ult_recibo_facturado     varchar (10),
	rh_cod_bloq_disposicion         varchar (1),
	rh_imp_pago_domiciliado         varchar (20),
	rh_fec_cobranza                 varchar (10),
	rh_pct_cat                      varchar (50),
	rh_desc_tipo_solicitud          varchar (15),
	rh_desc_canal                   varchar (15),
	rh_fec_vencimiento_renovacion   varchar (10),
	rh_fec_nacimiento               varchar (30),
	rh_cod_estado_civil             varchar (10),
	rh_cod_genero                   varchar (10),
	rh_imp_ingreso_dispersion       varchar (10),
	rh_flg_dispersion_ult_3m        varchar (10),
	rh_cod_tipo_interviniente       varchar (1),
	rh_cod_finalidad_credito        varchar (64),
	rh_cod_periodo_capital1         varchar (10),
	rh_cod_periodo_capital2         varchar (10),
	rh_num_dias_atraso              varchar (10),
	rh_num_plazo_remanente_dias     varchar (10),
	rh_integrantes_grupo            varchar (10),
	rh_ciclo_individual             varchar (10),
	rh_ciclo_grupal                 varchar (10)
	)
go

create clustered index idx1
	on dbo.sb_riesgo_hrc_ttj (rh_num_cred)
go








