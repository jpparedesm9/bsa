/************************************************************************/
/*                 Descripcion                                          */
/*  Script para creacion de tablas de Dependencias de Plazo Fijo        */
/************************************************************************/
/*                                                                      */
/*  Fecha         Autor               Comentario                        */
/*  15/07/2016    Oscar Saavedra      Instalador Version Davivienda     */
/************************************************************************/
use cob_remesas
go

SET NOCOUNT ON
go

SET ANSI_NULLS ON
go

SET QUOTED_IDENTIFIER ON
go

print '********************************'
print '*****  CREACION DE TABLAS ******'
print '********************************'
print ''
print 'Inicio Ejecucion Creacion de Tablas de Dependencias de Plazo Fijo : ' + convert(varchar(60),getdate(),109)
print ''

print '-->Tabla: pe_costo'
if not exists (select 1 from sysobjects where name = 'pe_costo' and type = 'U') begin
   create table pe_costo(
   co_secuencial                            int                not null,
   co_servicio_per                          smallint           not null,
   co_categoria                             catalogo           not null,
   co_tipo_rango                            tinyint            not null,
   co_grupo_rango                           smallint           not null,
   co_rango                                 tinyint            not null,
   co_val_medio                             real               not null,
   co_minimo                                real               not null,
   co_maximo                                real               not null,
   co_fecha_vigencia                        smalldatetime      not null)
end
go

print '-->Tabla: pa_gestion_paquete'
if not exists (select 1 from sysobjects where name = 'pa_gestion_paquete' and type = 'U') begin
   create table pa_gestion_paquete(
   gp_numpq                                 int                not null,
   gp_prod_cobis_pq                         tinyint            not null,
   gp_prod_banc_pq                          smallint           not null,
   gp_estado_pq                             char(2)            not null,
   gp_categoria_pq                          catalogo           not null,
   gp_fecha_alta                            datetime           not null,
   gp_oficial                               smallint           not null,
   gp_oficina_pq                            smallint           not null,
   gp_fecha_canc                            datetime           null,
   gp_origen                                varchar(3)         null,
   gp_cod_canc                              varchar(3)         null,
   gp_ciclo                                 char(3)            not null,
   gp_tipo_dir                              char(1)            not null,
   gp_direccion_ec                          smallint           not null,
   gp_resumen_mag                           char(1)            not null,
   gp_giro                                  char(1)            not null,
   gp_gerencia                              char(1)            not null,
   gp_ctahabiente                           varchar(2)         not null,
   gp_fecha_proc                            datetime           null)
end
go

print '-->Tabla: pa_bonificacion_cargos'
if not exists (select 1 from sysobjects where name = 'pa_bonificacion_cargos' and type = 'U') begin
   create table pa_bonificacion_cargos(
   bc_numpq                                 int                not null,
   bc_prod_cobis                            tinyint            not null,
   bc_prod_bancario                         smallint           not null,
   bc_servicio                              int                not null,
   bc_rubro                                 varchar(10)        not null,
   bc_porc_bonificacion                     real               not null,
   bc_fec_alta                              datetime           not null,
   bc_fec_ini                               datetime           not null,
   bc_fec_vto                               datetime           null,
   bc_estado                                char(1)            not null)
end
go

print '-->Tabla: pe_mercado'
if not exists (select 1 from sysobjects where name = 'pe_mercado' and type = 'U') begin
   create table pe_mercado(
   me_pro_bancario                          smallint           not null,
   me_tipo_ente                             catalogo           not null,
   me_mercado                               smallint           not null,
   me_estado                                char (1)           not null,
   me_fecha_estado                          smalldatetime      not null) 
end
go


print '-->Tabla: pe_pro_final'
if not exists (select 1 from sysobjects where name = 'pe_pro_final' and type = 'U') begin
   create table pe_pro_final(
   pf_pro_final                             smallint           not null,
   pf_filial                                tinyint            not null,
   pf_sucursal                              smallint           not null,
   pf_mercado                               smallint           not null,
   pf_producto                              tinyint            not null,
   pf_moneda                                tinyint            not null,
   pf_tipo                                  char(1)            not null,
   pf_descripcion                           descripcion        not null)
end
go

print '-->Tabla: pe_rango'
if not exists (select 1 from sysobjects where name = 'pe_rango' and type = 'U') begin
   create table pe_rango (
   ra_tipo_rango                            tinyint            not null,
   ra_grupo_rango                           smallint           not null,
   ra_rango                                 tinyint            not null,
   ra_desde                                 money              null,
   ra_hasta                                 money              null,
   ra_estado                                catalogo           null)
end
go

print '-->Tabla: pe_servicio_dis'
if not exists (select 1 from sysobjects where name = 'pe_servicio_dis' and type = 'U') begin
   create table pe_servicio_dis (
   sd_servicio_dis                         smallint            not null,
   sd_descripcion                          descripcion         not null,
   sd_nemonico                             varchar(10)         null,
   sd_estado                               char(1)             not null,
   sd_costo_interno                        money               not null,
   sd_num_rubro                            tinyint             null,
   sd_historico                            char(1)             null)
end
go

print '-->Tabla: pe_servicio_per'
if not exists (select 1 from sysobjects where name = 'pe_servicio_per' and type = 'U') begin
   create table pe_servicio_per(
   sp_pro_final                             smallint           not null,
   sp_servicio_dis                          smallint           not null,
   sp_rubro                                 catalogo           not null,
   sp_servicio_per                          smallint           not null,
   sp_tipo_rango                            tinyint            not null,
   sp_grupo_rango                           smallint           not null)
end
go

print '-->Tabla: pe_tipo_rango'
if not exists (select 1 from sysobjects where name = 'pe_tipo_rango' and type = 'U') begin
   create table pe_tipo_rango(
   tr_tipo_rango                            tinyint            not null,
   tr_descripcion                           descripcion        not null,
   tr_tipo_atributo                         catalogo           null,
   tr_moneda                                tinyint            null,
   tr_estado                                char(1)            null)
end
go

print '-->Tabla: pe_val_contratado'
if not exists (select 1 from sysobjects where name = 'pe_val_contratado' and type = 'U') begin
   create table pe_val_contratado(
   vc_secuencial                            int                not null,
   vc_tipo_default                          char(1)            not null,
   vc_rol                                   char(1)            not null,
   vc_producto                              tinyint            not null,
   vc_codigo                                int                not null,
   vc_servicio_per                          smallint           not null,
   vc_categoria                             catalogo           not null,
   vc_tipo_rango                            tinyint            not null,
   vc_grupo_rango                           smallint           not null,
   vc_rango                                 tinyint            not null,
   vc_valor_con                             real               not null,
   vc_tipo_variacion                        char(1)            not null,
   vc_signo                                 char(1)            null,
   vc_fecha                                 smalldatetime      not null,
   vc_fecha_venc                            smalldatetime      not null,
   vc_estado                                char(1)            null)
end
go

print '-->Tabla: pe_var_servicio'
if not exists (select 1 from sysobjects where name = 'pe_var_servicio' and type = 'U') begin
   create table pe_var_servicio(
   vs_servicio_dis                          smallint           not null,
   vs_rubro                                 catalogo           not null,
   vs_descripcion                           descripcion        not null,
   vs_estado                                char(1)            not null,
   vs_signo                                 char(1)            null,
   vs_tipo_dato                             char(1)            not null)
end
go

print '-->Tabla: re_banco'
if not exists (select 1 from sysobjects where name = 're_banco' and type = 'U') begin
   create table re_banco(
   ba_banco                                 tinyint not null,
   ba_descripcion                           varchar(64) not null,
   ba_estado                                estado not null,
   ba_filial                                tinyint null,
   ba_nit                                   numero null,
   ba_ente                                  int null)
end
go

print '-->Tabla: re_caja'
if not exists (select 1 from sysobjects where name = 're_caja' and type = 'U') begin
   create table re_caja(
   cj_fecha                                 datetime           not null,
   cj_filial                                tinyint            not null,
   cj_oficina                               smallint           not null,
   cj_rol                                   smallint           not null,
   cj_operador                              char(14)           not null,
   cj_moneda                                tinyint            not null,
   cj_transaccion                           int                not null,
   cj_causa                                 varchar(9)         null,
   cj_numero                                smallint           not null,
   cj_efectivo                              money              not null,
   cj_cheque                                money              not null,
   cj_chq_locales                           money              not null,
   cj_chq_ot_plaza                          money              not null,
   cj_otros                                 money              not null,
   cj_interes                               money              not null,
   cj_ajuste_int                            money              not null,
   cj_ajuste_cap                            money              not null,
   cj_nodo                                  char(30)           not null,
   cj_tipo                                  char(2)            not null,
   cj_ssn                                   int                not null,
   cj_id_cierre                             tinyint            not null,
   cj_id_caja                               int                not null)
end
go

print '-->Tabla: re_cheque_rec'
if not exists (select 1 from sysobjects where name = 're_cheque_rec' and type = 'U') begin
   create table re_cheque_rec(
   cr_cheque_rec                            int                not null,
   cr_fecha_ing                             datetime           not null,
   cr_fecha_efe                             datetime           null,
   cr_status                                char(1)            not null,
   cr_cta_depositada                        int                not null,
   cr_valor                                 money              not null,
   cr_codbanco                              char(12)           null,
   cr_banco_p                               tinyint            null,
   cr_oficina_p                             smallint           null,
   cr_ciudad_p                              int                null,
   cr_cta_girada                            cuenta             null,
   cr_num_cheque                            int                not null,
   cr_oficina                               smallint           not null,
   cr_producto                              tinyint            not null,
   cr_moneda                                tinyint            not null,
   cr_endoso                                int                null,
   cr_cau_devolucion                        varchar(3)         null,
   cr_procedencia                           char(1)            not null,
   cr_num_papeleta                          int                null,
   cr_tipo_cheque                           char(1)            not null,
   cr_mensaje                               varchar(64)        null,
   cr_estado                                char(1)            null,
   cr_entregado                             char(1)            null,
   cr_fecha_entrega                         datetime           null,
   cr_hora_entrega                          datetime           null,
   cr_usuario_entrega                       login              null,
   cr_sec_cab                               int                null,
   cr_sec_det                               int                null,
   cr_comision                              money              null,
   cr_portes                                money              null,
   cr_iva                                   money              null,
   cr_portes_dev                            money              null,
   cr_iva_dev                               money              null,
   cr_procesado                             char(1)            null,
   cr_num_titulo                            varchar(10)        null,
   cr_digito46                              tinyint            null,
   cr_tipo_compensa                         char(1)            null)
end
go

print '-->Tabla: re_cierre'
if not exists (select 1 from sysobjects where name = 're_cierre' and type = 'U') begin
   create table re_cierre(
   ci_filial                                tinyint            not null,
   ci_oficina                               smallint           not null,
   ci_fecha                                 datetime           not null,
   ci_id_caja                               int                not null,
   ci_id_cierre                             int                not null,
   ci_tipo                                  char(1)            not null,
   ci_usuario                               varchar(32)        not null,
   ci_moneda                                tinyint            not null,
   ci_hora_ini                              datetime           not null,
   ci_hora_fin                              datetime           null,
   ci_efectivo_ini                          money              not null,
   ci_efectivo_fin                          money              null)
end
go

print '-->Tabla: re_concep_exen_gmf'
if not exists (select 1 from sysobjects where name = 're_concep_exen_gmf' and type = 'U') begin
   create table re_concep_exen_gmf(
   ce_concepto                              smallint           not null,
   ce_descripc                              varchar(65)        not null,
   ce_tope                                  char(1)            not null,
   ce_vlr_tope                              money              not null,
   ce_tasa                                  float              not null,
   ce_producto                              tinyint            not null,
   ce_tipo_per                              char(1)            not null,
   ce_titular                               char(1)            not null,
   ce_otra_exen                             char(1)            not null,
   ce_nemonico                              char(5)            not null,
   ce_otro_conc                             smallint           null)
end
go

print '-->Tabla: re_conversion'
if not exists (select 1 from sysobjects where name = 're_conversion' and type = 'U') begin
   create table re_conversion(
   cv_filial                                tinyint            not null,
   cv_oficina                               smallint           not null,
   cv_producto                              tinyint            not null,
   cv_moneda                                tinyint            not null,
   cv_tipo                                  char(1)            not null,
   cv_tipo_cta                              smallint           not null,
   cv_codigo_cta                            char(6)            not null,
   cv_num_actual                            int                not null,
   cv_cta_anterior                          varchar(1)         null,
   cv_fin_stock                             int                null)
end
go

print '-->Tabla: re_cuenta_contractual'
if not exists (select 1 from sysobjects where name = 're_cuenta_contractual' and type = 'U') begin
   create table re_cuenta_contractual(
   cc_modulo                                tinyint            not null,
   cc_profinal                              tinyint            not null,
   cc_cta_banco                             cuenta             not null,
   cc_plazo                                 tinyint            not null,
   cc_cuota                                 money              not null,
   cc_periodicidad                          catalogo           not null,
   cc_monto_final                           money              null,
   cc_intereses                             money              null,
   cc_ptos_premio                           float              null,
   cc_estado                                char(1)            not null,
   cc_categoria                             char(1)            not null,
   cc_fecha_crea                            datetime           null,
   cc_periodos_incump                       tinyint            null,
   cc_prodbanc                              tinyint            null)
end
go

print '-->Tabla: re_equivalencia'
if not exists (select 1 from sysobjects where name = 're_equivalencia' and type = 'U') begin
   create table re_equivalencia(
   eq_secuencial                            int                null,
   eq_producto                              int                null,
   eq_codbanco                              int                null,
   eq_cta_original                          varchar(20)        null,
   eq_cta_cobis                             varchar(15)        null)
end
go

print '-->Tabla: re_mantenimiento_cupo_cb'
if not exists (select 1 from sysobjects where name = 're_mantenimiento_cupo_cb' and type = 'U') begin
   create table re_mantenimiento_cupo_cb(
   cc_cta_banco                             cuenta             not null,
   cc_valor_cupo                            money              not null,
   cc_dias_vigencia                         smallint           not null,
   cc_fecha_vencimiento                     datetime           not null,
   cc_tipo_mov                              char(1)            not null,
   cc_oficina_reg                           smallint           not null,
   cc_usuario_reg                           login              not null,
   cc_fecha_ingreso                         datetime           not null,
   cc_hora_ingreso                          datetime           not null)
end
go

print '-->Tabla: re_ofi_banco'
if not exists (select 1 from sysobjects where name = 're_ofi_banco' and type = 'U') begin
   create table re_ofi_banco(
   ob_banco                                 tinyint            not null,
   ob_oficina                               smallint           not null,
   ob_ciudad                                int                not null,
   ob_descripcion                           varchar(64)        not null,
   ob_fecha                                 datetime           null,
   ob_direccion                             direccion          null,
   ob_telefono                              varchar(12)        null,
   ob_ofi_cobis                             smallint           null,
   ob_identificacion                        varchar(8)         null)
end
go

print '-->Tabla: re_saldos_caja'
if not exists (select 1 from sysobjects where name = 're_saldos_caja' and type = 'U') begin
   create table re_saldos_caja(
   sc_filial                                tinyint            not null,
   sc_oficina                               smallint           not null,
   sc_id                                    int                not null,
   sc_moneda                                tinyint            not null,
   sc_saldo                                 money              not null)
end
go

print '-->Tabla: re_trans_alerta'
if not exists (select 1 from sysobjects where name = 're_trans_alerta' and type = 'U') begin
   create table re_trans_alerta(
   ta_transaccion                           smallint           not null,
   ta_fecha_cre                             datetime           not null,
   ta_fecha_mod                             datetime           null,
   ta_alerta                                char(1)            not null,
   ta_oficina                               smallint           not null,
   ta_usuario                               login              not null,
   ta_estado                                char(1)            not null)
end
go

print '-->Tabla: re_trn_grupo'
if not exists (select 1 from sysobjects where name = 're_trn_grupo' and type = 'U') begin
   create table re_trn_grupo(
   tg_nivel                                 tinyint            not null,
   tg_grupo                                 tinyint            not null,
   tg_transaccion                           smallint           not null,
   tg_afecta_efectivo                       char(1)            not null,
   tg_afecta_signo                          char(1)            not null,
   tg_indicador                             tinyint            not null,
   tg_tabla_catalogo                        varchar(30)        null)
end
go

print '-->Tabla: cm_ingreso'
if not exists (select 1 from sysobjects where name = 'cm_ingreso' and type = 'U') begin
   create table cm_ingreso (
   in_banco                                 smallint           NOT NULL,
   in_monto                                 money              NOT NULL,
   in_total_ingresado                       money              NOT NULL,
   in_diferencia                            money              NOT NULL,
   in_fecha                                 datetime           NOT NULL,
   in_estado                                char(1)            NOT NULL,
   in_cheques                               int                NOT NULL,
   in_moneda                                tinyint            NOT NULL,
   in_usuario                               login              NOT NULL,
   in_tipo_compensa                         char(1)            NULL)
end
go

print '-->Tabla: cm_cheques'
if not exists (select 1 from sysobjects where name = 'cm_cheques' and type = 'U') begin
   create table cm_cheques (
   cq_banco                                 smallint           NOT NULL,
   cq_fecha                                 datetime           NOT NULL,
   cq_contador                              int                NOT NULL,
   cq_cuenta                                cuenta             NOT NULL,
   cq_cheque                                int                NOT NULL,
   cq_valor                                 money              NOT NULL,
   cq_clase                                 char(1)            NOT NULL,
   cq_estado                                char(1)            NOT NULL,
   cq_moneda                                tinyint            NOT NULL,
   cq_usuario                               login              NOT NULL,
   cq_causa                                 varchar(64)        NOT NULL,
   cq_oficina                               smallint           NULL,
   cq_tipo_equip                            char(1)            NULL,
   cq_titulo                                char(1)            NOT NULL,
   cq_fecha_dev                             datetime           NULL,
   cq_num_titulo                            varchar(10)        NULL,
   cq_oficina_dest                          smallint           NULL,
   cq_digito46                              tinyint            NULL,
   cq_tipo_compensa                         char(1)            NULL)
end
go

print ''
print 'Fin Ejecucion Creacion de Tablas de Dependencias de Plazo Fijo : ' + convert(varchar(60),getdate(),109)
print ''