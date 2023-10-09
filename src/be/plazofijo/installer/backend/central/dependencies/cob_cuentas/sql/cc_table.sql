/************************************************************************/
/*                 Descripcion                                          */
/*  Script para creacion de tablas de Dependencias de Plazo Fijo        */
/************************************************************************/
/*                                                                      */
/*  Fecha         Autor               Comentario                        */
/*  15/07/2016    Oscar Saavedra      Instalador Version Davivienda     */
/************************************************************************/
use cob_cuentas

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

print '-->Tabla: cc_cheque'
if not exists (select 1 from sysobjects where name = 'cc_cheque' and type = 'U') begin
   create table cc_cheque(
   cq_cuenta                                int                not null,
   cq_cheque                                int                not null,
   cq_estado_actual                         char(1)            not null,
   cq_estado_anterior                       char(1)            null,
   cq_fecha_reg                             datetime           not null,
   cq_valor                                 money              null,
   cq_origen                                char(1)            null,
   cq_transferido                           char(1)            null,
   cq_hora                                  datetime           not null,
   cq_usuario                               login              null,
   np_causa                                 char(3)            null,
   np_clase                                 char(1)            null,
   np_filial                                tinyint            null,
   np_oficina                               smallint           null,
   np_fecha_can                             datetime           null,
   np_fecha_tope                            datetime           null,
   np_acreditado                            char(1)            null,
   cf_fecha_pago                            datetime           null,
   pt_justificado                           char(1)            null,
   pt_fecha_jus                             datetime           null,
   pt_comentario                            descripcion        null,
   pt_valor_multa                           money              null,
   pt_valor_cobrado                         money              null,
   pt_num_veces                             tinyint            null,
   ge_oficina_pago                          smallint           null,
   df_tdeficiencia                          char(1)            null,
   ge_tipo_ben                              char(1)            null)
end
go

print '-->Tabla: cc_chequera'
if not exists (select 1 from sysobjects where name = 'cc_chequera' and type = 'U') begin
   create table cc_chequera(
   ch_cuenta                                int                not null,
   ch_chequera                              int                not null,
   ch_inicial                               int                not null,
   ch_numero                                int                not null,
   ch_fecha_emision                         datetime           null,
   ch_fecha_eimprenta                       datetime           null,
   ch_fecha_rimprenta                       datetime           null,
   ch_fecha_roficina                        datetime           null,
   ch_fecha_entrega                         datetime           null,
   ch_tipo_chequera                         varchar(5)         not null,
   ch_emisor                                char(1)            not null,
   ch_autorizante                           login              not null,
   ch_ofi_emision                           smallint           not null,
   ch_ofi_entrega                           smallint           not null,
   ch_estado                                char(1)            not null,
   ch_estado_anterior                       char(1)            not null,
   ch_chq_ini_dev                           int                null,
   ch_chq_fin_dev                           int                null,
   ch_control_chq                           int                null,
   ch_estado_eimprenta                      char(1)            null,
   ch_ssn                                   int                null,
   ch_tipo_cobro                            char(1)            null,
   ch_etiqueta                              varchar(64)        not null,
   ch_domicilio                             char(1)            null)
end
go

print '-->Tabla: cc_chq_beneficiario'
if not exists (select 1 from sysobjects where name = 'cc_chq_beneficiario' and type = 'U') begin
   create table cc_chq_beneficiario(
   cb_cuenta                                int                not null,
   cb_cheque                                int                not null,
   cb_tipo                                  char(1)            not null,
   cb_beneficiario                          varchar(40)        not null,
   cb_causa                                 varchar(3)         not null,
   cb_referencia                            varchar(20)        null)
end
go

print '-->Tabla: cc_cta_gerencia'
if not exists (select 1 from sysobjects where name = 'cc_cta_gerencia' and type = 'U') begin
   create table cc_cta_gerencia(
   cg_oficina                               smallint           not null,
   cg_moneda                                tinyint            not null,
   cg_cuenta                                varchar(24)        not null)
end
go

print '-->Tabla: cc_ctacte'
if not exists (select 1 from sysobjects where name = 'cc_ctacte' and type = 'U') begin
   create table cc_ctacte(
   cc_ctacte                                int                not null,
   cc_cta_banco                             char(16)           not null,
   cc_filial                                tinyint            not null,
   cc_oficina                               smallint           not null,
   cc_oficial                               smallint           not null,
   cc_nombre                                char(64)           not null,
   cc_fecha_aper                            datetime           not null,
   cc_cliente                               int                not null,
   cc_ced_ruc                               char(13)           not null,
   cc_estado                                char(1)            not null,
   cc_cliente_ec                            int                not null,
   cc_direccion_ec                          tinyint            not null,
   cc_descripcion_ec                        char(120)          not null,
   cc_tipo_dir                              char(1)            not null,
   cc_cobro_ec                              char(1)            not null,
   cc_agen_ec                               smallint           not null,
   cc_parroquia                             smallint           not null,
   cc_zona                                  char(3)            not null,
   cc_man_firmas                            char(1)            not null,
   cc_ciclo                                 char(1)            not null,
   cc_categoria                             char(1)            not null,
   cc_creditos_mes                          money              not null,
   cc_debitos_mes                           money              not null,
   cc_creditos_hoy                          money              not null,
   cc_debitos_hoy                           money              not null,
   cc_disponible                            money              not null,
   cc_12h                                   money              not null,
   cc_12h_dif                               money              not null,
   cc_24h                                   money              not null,
   cc_24h_dif                               money              not null,
   cc_48h                                   money              not null,
   cc_72h_diferido                          money              not null,
   cc_remesas                               money              not null,
   cc_rem_hoy                               money              not null,
   cc_rem_diferido                          money              not null,
   cc_fecha_ult_mov                         datetime           not null,
   cc_fecha_ult_mov_int                     datetime           not null,
   cc_fecha_ult_upd                         datetime           not null,
   cc_fecha_prx_corte                       datetime           not null,
   cc_cred_24h                              char(1)            not null,
   cc_cred_rem                              char(1)            not null,
   cc_dias_sob                              smallint           not null,
   cc_dias_sob_cont                         smallint           not null,
   cc_retenidos                             int                not null,
   cc_retenciones                           money              not null,
   cc_certificados                          smallint           not null,
   cc_protestos                             int                not null,
   cc_prot_justificados                     smallint           not null,
   cc_prot_periodo_ant                      smallint           not null,
   cc_sobregiros                            tinyint            not null,
   cc_anulados                              smallint           not null,
   cc_revocados                             smallint           not null,
   cc_bloqueos                              smallint           not null,
   cc_num_blqmonto                          smallint           not null,
   cc_suspensos                             smallint           not null,
   cc_condiciones                           smallint           not null,
   cc_uso_sobregiro                         smallint           not null,
   cc_uso_remesa                            smallint           not null,
   cc_num_chq_defectos                      smallint           not null,
   cc_producto                              tinyint            not null,
   cc_tipo                                  char(1)            not null,
   cc_moneda                                tinyint            not null,
   cc_default                               int                not null,
   cc_tipo_def                              char(1)            not null,
   cc_rol_ente                              char(1)            not null,
   cc_chequeras                             int                not null,
   cc_cheque_inicial                        int                not null,
   cc_tipo_promedio                         char(1)            not null,
   cc_historico_seq                         int                not null,
   cc_saldo_ult_corte                       money              not null,
   cc_fecha_ult_corte                       datetime           not null,
   cc_fecha_ult_capi                        datetime           not null,
   cc_saldo_ayer                            money              not null,
   cc_monto_blq                             money              not null,
   cc_promedio1                             money              not null,
   cc_promedio2                             money              not null,
   cc_promedio3                             money              not null,
   cc_promedio4                             money              not null,
   cc_promedio5                             money              not null,
   cc_promedio6                             money              not null,
   cc_personalizada                         char(1)            not null,
   cc_prom_disponible                       money              not null,
   cc_contador_trx                          int                not null,
   cc_cta_funcionario                       char(1)            not null,
   cc_mercantil                             char(1)            not null,
   cc_cta_ahomerc                           char(16)           not null,
   cc_tipocta                               char(1)            not null,
   cc_saldo_interes                         money              not null,
   cc_num_cta_asoc                          tinyint            not null,
   cc_num_chq_pag_merc                      smallint           not null,
   cc_prod_banc                             smallint           not null,
   cc_origen                                varchar(3)         not null,
   cc_contador_firma                        int                not null,
   cc_fecha_prx_capita                      datetime           not null,
   cc_dep_ini                               tinyint            not null,
   cc_telefono                              char(12)           not null,
   cc_int_hoy                               money              not null,
   cc_rtefte                                char(1)            not null,
   cc_extracto                              char(1)            not null,
   cc_contragarantia                        char(12)           not null,
   cc_embargada_ilim                        char(1)            not null,
   cc_embargada_fijo                        char(1)            not null,
   cc_deb_mes_ant                           money              not null,
   cc_cred_mes_ant                          money              not null,
   cc_num_deb_mes                           int                not null,
   cc_num_cred_mes                          int                not null,
   cc_num_deb_mes_ant                       int                not null,
   cc_num_cred_mes_ant                      int                not null,
   cc_marca_inusual                         char(1)            not null,
   cc_rtefte_anio                           money              not null,
   cc_iva_anio                              money              not null,
   cc_baseiva_anio                          money              not null,
   cc_interes_anio                          money              not null,
   cc_clase_clte                            char(1)            not null,
   cc_puntos                                int                not null,
   cc_fecha_ult_canje_ptos                  datetime           not null,
   cc_negociada                             char(1)            not null,
   cc_lim_sobregiro                         tinyint            not null,
   cc_saldo_rtefte                          money              not null,
   cc_rtefte_hoy                            money              not null,
   cc_ctitularidad                          char(2)            not null,
   cc_int_recalc_sob                        money              not null,
   cc_nxmil                                 char(1)            not null,
   cc_marca_suspen                          char(1)            not null,
   cc_tctahabiente                          char(2)            not null,
   cc_reqaut_DTN                            char(1)            null,
   cc_imprimirex                            char(1)            null,
   cc_paquete                               int                null)
end
go

print '-->Tabla: cc_fecha_valor'
if not exists (select 1 from sysobjects where name = 'cc_fecha_valor' and type = 'U') begin
   create table cc_fecha_valor(
   fv_transaccion                           smallint           not null,
   fv_cuenta                                int                not null,
   fv_referencia                            varchar(24)        not null,
   fv_rubro                                 varchar(10)        not null,
   fv_costo                                 money              not null,
   fv_causa                                 varchar(3)         null,
   fv_ssn_sus                               int                null) 
end
go

print '-->Tabla: cc_ofi_safe'
if not exists (select 1 from sysobjects where name = 'cc_ofi_safe' and type = 'U') begin
   create table cc_ofi_safe(
   co_oficina                               smallint           not null,
   co_estado                                char(1)            not null,
   co_off_line                              char(1)            not null)
end
go

print '-->Tabla: cc_tran_servicio'
if not exists (select 1 from sysobjects where name = 'cc_tran_servicio' and type = 'U') begin
   create table cc_tran_servicio(
   ts_secuencial                            int                not null,
   ts_ssn_branch                            int                null,
   ts_cod_alterno                           int                null,
   ts_tipo_transaccion                      smallint           not null,
   ts_clase                                 varchar(3)         null,
   ts_tsfecha                               datetime           not null,
   ts_tabla                                 tinyint            null,
   ts_usuario                               descripcion        null,
   ts_terminal                              descripcion        null,
   ts_correccion                            char(1)            null,
   ts_ssn_corr                              int                null,
   ts_reentry                               char(1)            null,
   ts_origen                                char(1)            null,
   ts_nodo                                  varchar(30)        null,
   ts_referencia                            varchar(15)        null,
   ts_remoto_ssn                            int                null,
   ts_cheque_rec                            int                null,
   ts_ctacte                                int                null,
   ts_cta_banco                             cuenta             null,
   ts_filial                                tinyint            null,
   ts_oficina                               smallint           null,
   ts_oficial                               smallint           null,
   ts_fecha_aper                            datetime           null,
   ts_cliente                               int                null,
   ts_ced_ruc                               numero             null,
   ts_estado                                char(1)            null,
   ts_direccion_ec                          tinyint            null,
   ts_descripcion_ec                        direccion          null,
   ts_ciclo                                 char(1)            null,
   ts_categoria                             char(1)            null,
   ts_producto                              tinyint            null,
   ts_tipo                                  char(1)            null,
   ts_indicador                             tinyint            null,
   ts_moneda                                tinyint            null,
   ts_default                               int                null,
   ts_tipo_def                              char(1)            null,
   ts_rol_ente                              char(1)            null,
   ts_tipo_promedio                         char(1)            null,
   ts_numero                                smallint           null,
   ts_fecha                                 datetime           null,
   ts_autorizante                           descripcion        null,
   ts_causa                                 varchar(5)         null,
   ts_servicio                              varchar(3)         null,
   ts_saldo                                 money              null,
   ts_fecha_uso                             datetime           null,
   ts_monto                                 money              null,
   ts_fecha_ven                             datetime           null,
   ts_filial_aut                            tinyint            null,
   ts_ofi_aut                               smallint           null,
   ts_autoriz_aut                           descripcion        null,
   ts_filial_anula                          tinyint            null,
   ts_ofi_anula                             smallint           null,
   ts_autoriz_anula                         descripcion        null,
   ts_cheque_desde                          int                null,
   ts_cheque_hasta                          int                null,
   ts_chequera                              smallint           null,
   ts_num_cheques                           smallint           null,
   ts_departamento                          smallint           null,
   ts_cta_gir                               cuenta             null,
   ts_endoso                                int                null,
   ts_cod_banco                             varchar(10)        null,
   ts_corresponsal                          varchar(10)        null,
   ts_propietario                           varchar(10)        null,
   ts_carta                                 int                null,
   ts_sec_correccion                        int                null,
   ts_cheque                                int                null,
   ts_cta_banco_dep                         cuenta             null,
   ts_oficina_pago                          smallint           null,
   ts_contratado                            money              null,
   ts_valor                                 money              null,
   ts_ocasional                             money              null,
   ts_banco                                 smallint           null,
   ts_ccontable                             varchar(20)        null,
   ts_cta_funcionario                       char(1)            null,
   ts_mercantil                             char(1)            null,
   ts_cta_asociada                          cuenta             null,
   ts_tipocta                               char(1)            null,
   ts_fecha_eimp                            datetime           null,
   ts_fecha_rimp                            datetime           null,
   ts_fecha_rofi                            datetime           null,
   ts_tipo_chequera                         varchar(5)         null,
   ts_stick_imp                             char(15)           null,
   ts_tipo_imp                              char(1)            null,
   ts_tarjcred                              varchar(20)        null,
   ts_aporte_iess                           money              null,
   ts_descuento_iess                        money              null,
   ts_fonres_iess                           money              null,
   ts_agente                                varchar(30)        null,
   ts_nombre                                direccion          null,
   ts_vale                                  char(8)            null,
   ts_autorizacion                          char(10)           null,
   ts_tasa                                  float              null,
   ts_estado_eimprenta                      char(1)            null,
   ts_oficina_cta                           smallint           null,
   ts_hora                                  datetime           null,
   ts_estado_corr                           char(1)            null,
   ts_contragarantia                        char(12)           null,
   ts_tipo_embargo                          char(1)            null,
   ts_causa1                                varchar(100)       null,
   ts_fondos                                char(1)            null,
   ts_liberacion                            datetime           null,
   ts_nombre1                               varchar(64)        null,
   ts_fecha_vigencia                        datetime           null,
   ts_prx_fecha_proc                        datetime           null,
   ts_error                                 varchar(64)        null,
   ts_producto1                             char(3)            null,
   ts_convenio                              int                null,
   ts_codigo_cta                            char(5)            null,
   ts_credito                               varchar(16)        null,
   ts_deposito                              money              null,
   ts_clase_clte                            char(1)            null,
   ts_prod_banc                             tinyint            null,
   ts_tarj_debito                           varchar(24)        null,
   ts_negociada                             char(1)            null,
   ts_oficio                                varchar(8)         null,
   ts_oficio_lev                            varchar(8)         null,
   ts_lim_sobregiro                         tinyint            null,
   ts_tgarantia                             char(1)            null,
   ts_tipo_sobregiro                        char(1)            null,
   ts_tipo_dias_sob                         char(2)            null,
   ts_nxmil                                 char(1)            null,
   ts_efectivo                              money              null,
   ts_canal                                 smallint           null,
   ts_calificacion                          char(1)            null,
   ts_tctahabiente                          char(2)            null)
end
go

print '-->Tabla: cc_trn_chqg_gmf'
if not exists (select 1 from sysobjects where name = 'cc_trn_chqg_gmf' and type = 'U') begin
   create table cc_trn_chqg_gmf(
   tc_producto                              char(3)            not null,
   tc_causal                                varchar(3)         not null,
   tc_impuesto                              char(1)            not null)
end
go

print ''
print 'Fin Ejecucion Creacion de Tablas de Dependencias de Plazo Fijo : ' + convert(varchar(60),getdate(),109)
print ''