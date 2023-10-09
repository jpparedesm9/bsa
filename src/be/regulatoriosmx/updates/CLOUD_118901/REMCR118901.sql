/**********************************************************************************************************************/
--No Bug                     : NA
--Título de la Historia      : Requerimiento #118901: Reporte HRC LCR
--Fecha                      : 25/06/2019
--Descripción del Problema   : No existe tabla para almacenar HRC de LCR para reporte
--Descripción de la Solución : Crear tabla
--Autor                      : Paul Ortiz Vera
/**********************************************************************************************************************/
--------------------------------------------------------------------------------------------
-- CREAR TABLA
--------------------------------------------------------------------------------------------
use cob_conta_super
go

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
    rh_desc_subproducto             varchar(20)  null,
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

use cob_conta_super
go


IF OBJECT_ID ('dbo.sb_riesgo_hrc_lcr') IS NOT NULL
    DROP TABLE dbo.sb_riesgo_hrc_lcr
GO

create table sb_riesgo_hrc_lcr(
   FECHA_INFO                    varchar(30)  null,
   NUM_CRED                      varchar(25)  null,
   NUM_CLIENTE_OPERATIVO         varchar(64)  null,
   DESC_NOMBRE_CLIENTE           varchar(255) null,
   COD_ENTIDAD                   varchar(4)   null,
   DESC_ENTIDAD                  varchar(30)  null,
   DESC_SISTEMA_ORIG             varchar(10)  null,
   NUM_SUC_TITULAR               varchar(20)  null,
   COD_PRODUCTO                  varchar(2)   null,
   COD_SUBPRODUCTO               varchar(4)   null,
   DESC_PRODUCTO                 varchar(25)  null,
   DESC_SUBPRODUCTO              varchar(20)  null,
   FLG_REVOLVENTE                varchar(10)  null,
   FLG_TRATAMIENTO_CONTABLE      varchar(10)  null,
   COD_TIPO_AMORTIZA             varchar(10)  null,
   DESC_TIPO_AMORTIZA            varchar(30)  null,
   NUM_CTA_CHEQUES               varchar(25)  null,
   FEC_FORMALIZA                 varchar(30)  null,
   FEC_VENCIMIENTO               varchar(30)  null,
   COD_TASA                      varchar(9)   null,
   DESC_TASA                     varchar(15)  null,
   FLG_TASA_VARIABLE             varchar(10)  null,
   FEC_PROX_REVISA_TASA          varchar(30)  null,
   COD_PERIODO_REVISA_TASA       varchar(1)   null,
   PCT_TASA_COBR                 varchar(50)  null,
   NUM_PUNTOS_SPREAD             varchar(10)  null,
   FEC_ULT_AMORT_INCUMP_CAP      varchar(30)  null,
   FEC_ULT_AMORT_INCUMP_INT      varchar(30)  null,
   NUM_DOCTOS_VENCIDOS           varchar(5)   null,
   COD_PERIODO_CAPITAL           varchar(10)  null,
   DESC_PERIODO_CAPITAL          varchar(10)  null,
   COD_PERIODO_INTERESES         varchar(10)  null,
   DESC_PERIODO_INTERESES        varchar(10)  null,
   COD_BLOQUEO                   varchar(10)  null,
   DESC_BLOQUEO                  varchar(1)   null,
   COD_MONEDA                    varchar(3)   null,
   IMP_CONCEDIDO                 varchar(30)  null,
   IMP_LIMITE_CREDITO            varchar(30)  null,
   IMP_DISPONIBLE                varchar(30)  null,
   IMP_TOTAL_RIESGO_SISTEMA      varchar(30)  null,
   IMP_CAP_NOEXIG                varchar(30)  null,
   IMP_CAP_EXIG                  varchar(30)  null,
   IMP_INT_NOEXIG                varchar(30)  null,
   IMP_INT_EXIG                  varchar(30)  null,
   IMP_INT_SUSPEN                varchar(30)  null,
   IMP_INVERSION                 varchar(30)  null,
   IMP_TOTAL_RIESGO              varchar(30)  null,
   FEC_TRASPASO_VENCIDO          varchar(30)  null,
   NUM_LINEA_MADRE               varchar(64)  null,
   FLG_MORA_SISTEMA              varchar(10)  null,
   FEC_PROX_CORTE                varchar(30)  null,
   COD_PAIS_ORIGEN               varchar(10)  null,
   COD_PAIS_RESIDENCIA           varchar(10)  null,
   COD_TIPO_PERSONA              varchar(32)  null,
   COD_SECTOR_ECONOMICO          varchar(10)  null,
   COD_UNIDAD_NEGOCIO            varchar(1)   null,
   COD_UNIDAD_NEGOCIO_OPE_ORI    varchar(1)   null,
   COD_SECTOR_CONTABLE           varchar(1)   null,
   COD_ACTIVIDAD_ECONOMICA       varchar(10)  null,
   DESC_RFC                      varchar(255) null,
   DESC_PAIS_ORIGEN              varchar(64)  null,
   DESC_PAIS_RESIDENCIA          varchar(64)  null,
   DESC_SECTOR_ECONOMICO         varchar(200) null,
   DESC_TIPO_PERSONA             varchar(64)  null,
   DESC_UNIDAD_NEGOCIO           varchar(64)  null,
   COD_LOCALIDAD_DOM_PRIMARIO    varchar(64)  null,
   DESC_ACTIVIDAD_ECONOMICA_ESP  varchar(200) null,
   FEC_PROX_CORTE_PRIN           varchar(30)  null,
   FEC_PROX_CORTE_INT            varchar(30)  null,
   FEC_FORMALIZA_ULT_DISP        varchar(30)  null,
   IMP_SEGURO_DESEMPLEO          varchar(30)  null,
   IMP_SEGURO_VIDA               varchar(30)  null,
   FLG_GARANTIA                  varchar(30)  null,
   PCT_TASA_BASE                 varchar(50)  null,
   IMP_PAG_ADELANTADO            varchar(30)  null,
   NUM_ULT_RECIBO_FACTURADO      varchar(10)  null,
   COD_BLOQ_DISPOSICION          varchar(1)   null,
   IMP_PAGO_DOMICILIADO          varchar(20)  null,
   FEC_COBRANZA                  varchar(10)  null,
   PCT_CAT                       varchar(50)  null,
   DESC_TIPO_SOLICITUD           varchar(15)  null,
   DESC_CANAL                    varchar(15)  null,
   FEC_VENCIMIENTO_RENOVACION    varchar(10)  null,
   FEC_NACIMIENTO                varchar(30)  null,
   COD_ESTADO_CIVIL              varchar(10)  null,
   COD_GENERO                    varchar(10)  null,
   IMP_INGRESO_DISPERSION        varchar(10)  null,
   FLG_DISPERSION_ULT_3M         varchar(10)  null,
   COD_TIPO_INTERVINIENTE        varchar(1)   null,
   COD_FINALIDAD_CREDITO         varchar(64)  null,
   COD_PERIODO_CAPITAL_1         varchar(10)  null,
   DESC_PERIODO_CAPITAL_1        varchar(10)  null,
   NUM_DIAS_ATRASO               varchar(10)  null,
   NUM_PLAZO_REMANENTE_DIAS      varchar(10)  null
)
go

CREATE nonclustered INDEX sb_riesgo_hrc_lcr
	ON dbo.sb_riesgo_hrc_lcr (NUM_CRED)
GO 

--------------------------------------------------------------------------------------------
-- ACTUALIZAR SECTOR
--------------------------------------------------------------------------------------------
use cobis
go

declare @w_cod_sector  int
select @w_cod_sector = codigo from cobis..cl_tabla where tabla = 'cl_sector_economico'

if not exists(select * from cobis..cl_catalogo where valor = 'INDUSTRIA' and tabla = @w_cod_sector)
begin
   insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
   values (@w_cod_sector, 'VIII', 'INDUSTRIA', 'V')
end


--------------------------------------------------------------------------------------------
-- AGREGAR CAMPOS
--------------------------------------------------------------------------------------------
use cobis
go

--CAMBIAR TIPO DE DATO DE PUNTAJE
if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'acg_codigo_generica ' and TABLE_NAME = 'cl_actividad_generica')
begin
    alter table cobis..cl_actividad_generica add acg_codigo_generica  varchar(10) null
end
else
begin
	 alter table cobis..cl_actividad_generica alter column acg_codigo_generica  varchar(10) null
end

go
--------------------------------------------------------------------------------------------
-- ACTUALIZAR CAMPO CREADO
--------------------------------------------------------------------------------------------

update cobis..cl_actividad_generica
set acg_codigo_generica = 'III'
where acg_actividad_generica = 'COMERCIO'

update cobis..cl_actividad_generica
set acg_codigo_generica = 'IV'
where acg_actividad_generica = 'SERVICIO'

update cobis..cl_actividad_generica
set acg_codigo_generica = 'VIII'
where acg_actividad_generica = 'INDUSTRIA'


--------------------------------------------------------------------------------------------
-- CAMPOS CONSOLIDADOR
--------------------------------------------------------------------------------------------

use cob_externos
go
 
if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where table_name = 'ex_dato_operacion' and column_name = 'do_fecha_ult_vto')
	alter table ex_dato_operacion add do_fecha_ult_vto datetime null
else
   alter table ex_dato_operacion alter column do_fecha_ult_vto datetime null

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where table_name = 'ex_dato_operacion' and column_name = 'do_cuota_ult_vto')
	alter table ex_dato_operacion add do_cuota_ult_vto int null
else
   alter table ex_dato_operacion alter column do_cuota_ult_vto int null

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where table_name = 'ex_dato_operacion' and column_name = 'do_tipo_amortizacion')
	alter table ex_dato_operacion add do_tipo_amortizacion catalogo null
else
   alter table ex_dato_operacion alter column do_tipo_amortizacion catalogo null
 

use cob_conta_super
go

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where table_name = 'sb_dato_operacion' and column_name = 'do_fecha_ult_vto')
	alter table sb_dato_operacion add do_fecha_ult_vto datetime null
else
   alter table sb_dato_operacion alter column do_fecha_ult_vto datetime null

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where table_name = 'sb_dato_operacion' and column_name = 'do_cuota_ult_vto')
	alter table sb_dato_operacion add do_cuota_ult_vto int null
else
   alter table sb_dato_operacion alter column do_cuota_ult_vto int null

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where table_name = 'sb_dato_operacion' and column_name = 'do_tipo_amortizacion')
	alter table sb_dato_operacion add do_tipo_amortizacion catalogo null
else
   alter table sb_dato_operacion alter column do_tipo_amortizacion catalogo null

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where table_name = 'sb_dato_operacion_tmp' and column_name = 'do_fecha_ult_vto')
	alter table sb_dato_operacion_tmp add do_fecha_ult_vto datetime null
else
   alter table sb_dato_operacion_tmp alter column do_fecha_ult_vto datetime null

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where table_name = 'sb_dato_operacion_tmp' and column_name = 'do_cuota_ult_vto')
	alter table sb_dato_operacion_tmp add do_cuota_ult_vto int null
else
   alter table sb_dato_operacion_tmp alter column do_cuota_ult_vto int null

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where table_name = 'sb_dato_operacion_tmp' and column_name = 'do_tipo_amortizacion')
	alter table sb_dato_operacion_tmp add do_tipo_amortizacion catalogo null
else
   alter table sb_dato_operacion_tmp alter column do_tipo_amortizacion catalogo null

-----------
use cobis
go

--------------------------------------------------------------------------------------------
-- AGREGAR BATCH
--------------------------------------------------------------------------------------------
declare @w_servidor varchar(24)

select @w_servidor = pa_char from cobis..cl_parametro where pa_nemonico = 'SRVR'

--delete from cobis..ba_batch where ba_batch=36431

if not exists(select * from cobis..ba_batch where ba_batch = 36431)
begin
   insert into cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
   values (36431, 'GENERACION ARCHIVO 07 (HRC GLB)', 'GENERACION ARCHIVO 07 (HRC GLB)', 'SP', getdate(), 36, 'P', 1, 'REGULATORIOS', 'COBIS_HRC_GLB', 'cob_conta_super..sp_riesgo_hrc_glb', 1, null, @w_servidor, 'S', 'C:\Cobis\VBatch\Regulatorios\Objetos\', 'C:\Cobis\VBatch\Regulatorios\listados\')
end
go