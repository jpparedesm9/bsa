USE cobis
go

declare @w_tabla int, @w_tabla_nombre varchar(30), @w_producto varchar(10)

select @w_tabla_nombre = 'ca_sub_producto_rep', @w_producto = 'CCA'

if not exists(select 1 from cl_tabla where tabla = @w_tabla_nombre)
begin
    print 'No existe'
	select @w_tabla = max(codigo) + 1 from cl_tabla
	insert into cl_tabla (codigo, tabla, descripcion) values (@w_tabla, 'ca_sub_producto_rep', 'Sub producto para reportes')
	
	update cobis..cl_seqnos
	set siguiente = @w_tabla + 1
	where tabla = 'cl_tabla'
	
end
else
begin
    print 'Ya existe'
	select @w_tabla = codigo from cl_tabla where tabla = @w_tabla_nombre
end

select * from cobis..cl_catalogo_pro WHERE cp_tabla = @w_tabla
delete cl_catalogo_pro where cp_tabla = @w_tabla
	
insert into cl_catalogo_pro (cp_producto, cp_tabla) values ('ADM', @w_tabla)
insert into cl_catalogo_pro (cp_producto, cp_tabla) values (@w_producto, @w_tabla)
	
select * from cl_catalogo where tabla = @w_tabla
delete cl_catalogo where tabla = @w_tabla
	
insert into cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type) values (@w_tabla, 'GRUPAL', '0001;Grupal', 'V', NULL, NULL, NULL)
insert into cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type) values (@w_tabla, 'INTERCICLO', '0003;Interciclo', 'V', NULL, NULL, NULL)
insert into cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type) values (@w_tabla, 'INDIVIDUAL', '0004;Credito individual simple', 'V', NULL, NULL, NULL)

go
----------------->>>>>>>>>>>>>>>>>----------------->>>>>>>>>>>>>>>>>----------------->>>>>>>>>>>>>>>>>----------------->>>>>>>>>>>>>>>>>----------------->>>>>>>>>>>>>>>>>
----------------->>>>>>>>>>>>>>>>>----------------->>>>>>>>>>>>>>>>>----------------->>>>>>>>>>>>>>>>>----------------->>>>>>>>>>>>>>>>>----------------->>>>>>>>>>>>>>>>>
use cob_conta_super
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
	rh_desc_subproducto             varchar (255),
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

----------------->>>>>>>>>>>>>>>>>----------------->>>>>>>>>>>>>>>>>----------------->>>>>>>>>>>>>>>>>----------------->>>>>>>>>>>>>>>>>----------------->>>>>>>>>>>>>>>>>
----------------->>>>>>>>>>>>>>>>>----------------->>>>>>>>>>>>>>>>>----------------->>>>>>>>>>>>>>>>>----------------->>>>>>>>>>>>>>>>>----------------->>>>>>>>>>>>>>>>>

if exists (select 1 from sysobjects where name = 'sb_riesgo_hrc' and type = 'U') 
   drop table sb_riesgo_hrc
go

create table sb_riesgo_hrc (
    rh_fec_info                     varchar(30)  null,
    rh_num_cred                     varchar(25)  null,
    rh_num_cliente_operativo        varchar(64)  null,
    rh_desc_nombre_cliente          varchar(255) null,
    rh_cod_entidad                  varchar(4)   null,
    rh_desc_entidad                 varchar(30)  null,
    rh_desc_sistema_origen          varchar(10)  null,
    rh_num_suc_titular              varchar(20)  null,
    rh_cod_producto                 varchar(2)   null,
    rh_cod_subproducto              varchar(4)   null,
    rh_desc_producto                varchar(25)  null,
    rh_desc_subproducto             varchar(255)  null,
    rh_flg_revolvente               varchar(10)  null,
    rh_flg_tratamiento_contable     varchar(10)  null,
    rh_cod_tipo_amortiza            varchar(10)  null,
    rh_desc_tipo_amortiza           varchar(30)  null,
    rh_num_cta_cheques              varchar(25)  null,
    rh_fec_formaliza                varchar(30)  null,
    rh_fec_vencimiento              varchar(30)  null,
    rh_cod_tasa                     varchar(9)   null,
    rh_desc_tasa                    varchar(15)  null,
    rh_flg_tasa_variable            varchar(10)  null,
    rh_fec_prox_revisa_tasa         varchar(30)  null,
    rh_cod_periodo_revisa_tasa      varchar(1)   null,
    rh_pct_tasa_cobr                varchar(50)  null,
    rh_num_puntos_spread            varchar(10)  null,
    rh_fec_ult_amort_incump_cap     varchar(30)  null,
    rh_fec_ult_amort_incump_int     varchar(30)  null,
    rh_num_doctos_vencidos          varchar(5)   null,
    rh_cod_periodo_capital          varchar(10)  null,
    rh_desc_periodo_capital         varchar(10)  null,
    rh_cod_periodo_intereses        varchar(10)  null,
    rh_desc_periodo_intereses       varchar(10)  null,
    rh_cod_bloqueo                  varchar(10)  null,
    rh_desc_bloqueo                 varchar(1)   null,
    rh_cod_moneda                   varchar(3)   null,
    rh_imp_concedido                varchar(30)  null,
    rh_imp_limite_credito           varchar(30)  null,
    rh_imp_disponible               varchar(30)  null,
    rh_imp_total_riesgo_sistema     varchar(30)  null,
    rh_imp_cap_noexig               varchar(30)  null,
    rh_imp_cap_exig                 varchar(30)  null,
    rh_imp_int_noexig               varchar(30)  null,
    rh_imp_int_exig                 varchar(30)  null,
    rh_imp_int_suspen               varchar(30)  null,
    rh_imp_inversion                varchar(30)  null,
    rh_imp_total_riesgo             varchar(30)  null,
    rh_fec_traspaso_vencido         varchar(30)  null,
    rh_num_linea_madre              varchar(64)  null,
    rh_flg_mora_sistema             varchar(10)  null,
    rh_fec_prox_corte               varchar(30)  null,
    rh_cod_pais_origen              varchar(10)  null,
    rh_cod_pais_residencia          varchar(10)  null,
    rh_cod_tipo_persona             varchar(32)  null,
    rh_cod_sector_economico         varchar(10)  null,
    rh_cod_unidad_negocio           varchar(1)   null,
    rh_cod_unidad_negocio_ope_ori   varchar(1)   null,
    rh_cod_sector_contable          varchar(1)   null,
    rh_cod_actividad_economica      varchar(10)  null,
    rh_desc_rfc                     varchar(255) null,
    rh_desc_pais_origen             varchar(64)  null,
    rh_desc_pais_residencia         varchar(64)  null,
    rh_desc_sector_economico        varchar(200) null,
    rh_desc_tipo_persona            varchar(64)  null,
    rh_desc_unidad_negocio          varchar(64)  null,
    rh_cod_localidad_dom_primario   varchar(64)  null,
    rh_desc_actividad_economica_esp varchar(200) null,
    rh_fec_prox_corte_prin          varchar(30)  null,
    rh_fec_prox_corte_int           varchar(30)  null,
    rh_fec_formaliza_ult_disp       varchar(30)  null,
    rh_imp_seguro_desempleo         varchar(30)  null,
    rh_imp_seguro_vida              varchar(30)  null,
    rh_flg_garantia                 varchar(30)  null,
    rh_pct_tasa_base                varchar(50)  null,
    rh_imp_pag_adelantado           varchar(30)  null,
    rh_num_ult_recibo_facturado     varchar(10)  null,
    rh_cod_bloq_disposicion         varchar(1)   null,
    rh_imp_pago_domiciliado         varchar(20)  null,
    rh_fec_cobranza                 varchar(10)  null,
    rh_pct_cat                      varchar(50)  null,
    rh_desc_tipo_solicitud          varchar(15)  null,
    rh_desc_canal                   varchar(15)  null,
    rh_fec_vencimiento_renovacion   varchar(10)  null,
    rh_fec_nacimiento               varchar(30)  null,
    rh_cod_estado_civil             varchar(10)  null,
    rh_cod_genero                   varchar(10)  null,
    rh_imp_ingreso_dispersion       varchar(10)  null,
    rh_flg_dispersion_ult_3m        varchar(10)  null,
    rh_cod_tipo_interviniente       varchar(1)   null,
    rh_cod_finalidad_credito        varchar(64)  null,
    rh_cod_periodo_capital1         varchar(10)  null,
    rh_cod_periodo_capital2         varchar(10)  null,
    rh_num_dias_atraso              varchar(10)  null,
    rh_num_plazo_remanente_dias     varchar(10)  null,
	rh_integrantes_grupo            varchar(10)  null,
	rh_ciclo_individual             varchar(10)  null,
	rh_ciclo_grupal                 varchar(10)  null
)
go

create clustered index idx1 on sb_riesgo_hrc(rh_num_cred)
go

