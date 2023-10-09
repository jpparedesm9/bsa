/************************************************************************/
/*                 Descripcion                                          */
/*  Script para creacion de tablas de Dependencias de Plazo Fijo        */
/************************************************************************/
/*                                                                      */
/*  Fecha         Autor               Comentario                        */
/*  15/07/2016    Oscar Saavedra      Instalador Version Davivienda     */
/************************************************************************/
use cob_ahorros
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

print '-->Tabla: ah_cuenta'
if not exists (select 1 from sysobjects where name = 'ah_cuenta' and type = 'U') begin
   create table ah_cuenta(
   ah_cuenta                                int                not null,
   ah_cta_banco                             char(16)           not null,
   ah_estado                                char(1)            not null,
   ah_control                               int                not null,
   ah_filial                                tinyint            not null,
   ah_oficina                               smallint           not null,
   ah_producto                              tinyint            not null,
   ah_tipo                                  char(1)            not null,
   ah_moneda                                tinyint            not null,
   ah_fecha_aper                            smalldatetime      not null,
   ah_oficial                               smallint           not null,
   ah_cliente                               int                not null,
   ah_ced_ruc                               char(15)           not null,
   ah_nombre                                char(60)           not null,
   ah_categoria                             char(1)            not null,
   ah_tipo_promedio                         char(1)            not null,
   ah_capitalizacion                        char(1)            not null,
   ah_ciclo                                 char(1)            not null,
   ah_suspensos                             smallint           not null,
   ah_bloqueos                              smallint           not null,
   ah_condiciones                           smallint           not null,
   ah_monto_bloq                            money              not null,
   ah_num_blqmonto                          smallint           not null,
   ah_cred_24                               char(1)            not null,
   ah_cred_rem                              char(1)            not null,
   ah_tipo_def                              char(1)            not null,
   ah_default                               int                not null,
   ah_rol_ente                              char(1)            not null,
   ah_disponible                            money              not null,
   ah_12h                                   money              not null,
   ah_12h_dif                               money              not null,
   ah_24h                                   money              not null,
   ah_48h                                   money              not null,
   ah_remesas                               money              not null,
   ah_rem_hoy                               money              not null,
   ah_interes                               money              not null,
   ah_interes_ganado                        money              not null,
   ah_saldo_libreta                         money              not null,
   ah_saldo_interes                         money              not null,
   ah_saldo_anterior                        money              not null,
   ah_saldo_ult_corte                       money              not null,
   ah_saldo_ayer                            money              not null,
   ah_creditos                              money              not null,
   ah_debitos                               money              not null,
   ah_creditos_hoy                          money              not null,
   ah_debitos_hoy                           money              not null,
   ah_fecha_ult_mov                         smalldatetime      not null,
   ah_fecha_ult_mov_int                     smalldatetime      not null,
   ah_fecha_ult_upd                         smalldatetime      not null,
   ah_fecha_prx_corte                       smalldatetime      not null,
   ah_fecha_ult_corte                       smalldatetime      not null,
   ah_fecha_ult_capi                        smalldatetime      not null,
   ah_fecha_prx_capita                      smalldatetime      not null,
   ah_linea                                 smallint           not null,
   ah_ult_linea                             smallint           not null,
   ah_cliente_ec                            int                not null,
   ah_direccion_ec                          tinyint            not null,
   ah_descripcion_ec                        char(120)          not null,
   ah_tipo_dir                              char(1)            not null,
   ah_agen_ec                               smallint           not null,
   ah_parroquia                             int                not null,
   ah_zona                                  smallint           not null,
   ah_prom_disponible                       money              not null,
   ah_promedio1                             money              not null,
   ah_promedio2                             money              not null,
   ah_promedio3                             money              not null,
   ah_promedio4                             money              not null,
   ah_promedio5                             money              not null,
   ah_promedio6                             money              not null,
   ah_personalizada                         char(1)            not null,
   ah_contador_trx                          int                not null,
   ah_cta_funcionario                       char(1)            not null,
   ah_tipocta                               char(1)            not null,
   ah_prod_banc                             smallint           not null,
   ah_origen                                char(3)            not null,
   ah_numlib                                int                not null,
   ah_dep_ini                               tinyint            not null,
   ah_contador_firma                        int                not null,
   ah_telefono                              char(12)           not null,
   ah_int_hoy                               money              not null,
   ah_tasa_hoy                              real               not null,
   ah_min_dispmes                           money              not null,
   ah_fecha_ult_ret                         smalldatetime      not null,
   ah_cliente1                              int                not null,
   ah_nombre1                               char(64)           not null,
   ah_cedruc1                               char(13)           not null,
   ah_sector                                smallint           not null,
   ah_monto_imp                             money              not null,
   ah_monto_consumos                        money              not null,
   ah_ctitularidad                          char(1)            not null,
   ah_promotor                              smallint           not null,
   ah_int_mes                               money              not null,
   ah_tipocta_super                         char(1)            not null,
   ah_direccion_dv                          tinyint            not null,
   ah_descripcion_dv                        varchar(64)        not null,
   ah_tipodir_dv                            char(1)            not null,
   ah_parroquia_dv                          int                not null,
   ah_zona_dv                               smallint           not null,
   ah_agen_dv                               smallint           not null,
   ah_cliente_dv                            int                not null,
   ah_traslado                              char(1)            not null,
   ah_aplica_tasacorp                       char(1)            not null,
   ah_monto_emb                             money              not null,
   ah_monto_ult_capi                        money              not null,
   ah_saldo_mantval                         money              not null,
   ah_cuota                                 money              not null,
   ah_creditos2                             money              not null,
   ah_creditos3                             money              not null,
   ah_creditos4                             money              not null,
   ah_creditos5                             money              not null,
   ah_creditos6                             money              not null,
   ah_debitos2                              money              not null,
   ah_debitos3                              money              not null,
   ah_debitos4                              money              not null,
   ah_debitos5                              money              not null,
   ah_debitos6                              money              not null,
   ah_tasa_ayer                             real               not null,
   ah_estado_cuenta                         char(1)            not null,
   ah_permite_sldcero                       char(1)            not null,
   ah_rem_ayer                              money              not null,
   ah_numsol                                int                not null,
   ah_patente                               char(40)           not null,
   ah_fideicomiso                           varchar(15)        null,
   ah_nxmil                                 char(1)            null,
   ah_clase_clte                            char(1)            null,
   ah_deb_mes_ant                           money              null,
   ah_cred_mes_ant                          money              null,
   ah_num_deb_mes                           int                null,
   ah_num_cred_mes                          int                null,
   ah_num_con_mes                           int                null,
   ah_num_deb_mes_ant                       int                null,
   ah_num_cred_mes_ant                      int                null,
   ah_num_con_mes_ant                       int                null,
   ah_fecha_ult_proceso                     datetime           null)
end

print '-->Tabla: ah_lincredito'
if not exists (select 1 from sysobjects where name = 'ah_lincredito' and type = 'U') begin
   create table ah_lincredito(
   lc_cuenta                                int                not null,
   lc_secuencial                            smallint           not null,
   lc_tipo                                  char (1)           not null,
   lc_fecha_aut                             smalldatetime      not null,
   lc_monto_aut                             money              not null,
   lc_fecha_uso                             smalldatetime      null,
   lc_monto_uso                             money              null,
   lc_fecha_ven                             smalldatetime      not null,
   lc_filial                                tinyint            not null,
   lc_oficina                               smallint           not null,
   lc_autorizante                           login              not null)
end

print '-->Tabla: ah_val_suspenso'
if not exists (select 1 from sysobjects where name = 'ah_val_suspenso' and type = 'U') begin  
   create table ah_val_suspenso(
   vs_cuenta                                int                not null,
   vs_secuencial                            int                not null,
   vs_servicio                              char(3)            not null,
   vs_valor                                 money              not null,
   vs_oficina                               smallint           not null,
   vs_fecha                                 smalldatetime      not null,
   vs_hora                                  smalldatetime      not null,
   vs_ssn                                   int                not null,
   vs_estado                                char(1)            not null,
   vs_procesada                             char(1)            not null,
   vs_clave                                 int                not null,
   vs_impuesto                              char(1)            not null)
end

print '-->Tabla: ah_exenta_gmf'
if not exists (select 1 from sysobjects where name = 'ah_exenta_gmf' and type = 'U') begin
   create table ah_exenta_gmf(
   eg_cuenta                                int                not null,
   eg_cta_banco                             char(16)           not null,
   eg_marca                                 char(1)            not null,
   eg_fecha_marca                           datetime           not null,
   eg_fecha_actua                           datetime           null,
   eg_fecha_valor                           datetime           null,
   eg_mes_01                                money              null,
   eg_mes_02                                money              null,
   eg_mes_03                                money              null,
   eg_mes_04                                money              null,
   eg_mes_05                                money              null,
   eg_mes_06                                money              null,
   eg_mes_07                                money              null,
   eg_mes_08                                money              null,
   eg_mes_09                                money              null,
   eg_mes_10                                money              null,
   eg_mes_11                                money              null,
   eg_mes_12                                money              null,
   eg_concepto                              smallint           not null,
   eg_usuario                               varchar            (20) null,
   eg_oficina_marca                         int                null,
   eg_oficina_actua                         int                null,
   eg_fecha_desm                            datetime           null,
   eg_usuario_desm                          varchar(20)        null,
   eg_oficina_desm                          int                null)
end

print '-->Tabla: ah_tran_monet'
if not exists (select 1 from sysobjects where name = 'ah_tran_monet' and type = 'U') begin
   create table ah_tran_monet(
   tm_fecha                                 smalldatetime      null,
   tm_secuencial                            int                not null,
   tm_ssn_branch                            int                null,
   tm_cod_alterno                           int                null,
   tm_tipo_tran                             int                not null,
   tm_filial                                tinyint            null,
   tm_oficina                               smallint           not null,
   tm_usuario                               varchar(30)        not null,
   tm_terminal                              varchar(10)        not null,
   tm_correccion                            char(1)            null,
   tm_sec_correccion                        int                null,
   tm_origen                                char(1)            null,
   tm_nodo                                  descripcion        null,
   tm_reentry                               char(1)            null,
   tm_signo                                 char(1)            null,
   tm_fecha_ult_mov                         smalldatetime      null,
   tm_cta_banco                             cuenta             null,
   tm_valor                                 money              null,
   tm_chq_propios                           money              null,
   tm_chq_locales                           money              null,
   tm_chq_ot_plazas                         money              null,
   tm_remoto_ssn                            int                null,
   tm_moneda                                tinyint            null,
   tm_efectivo                              money              null,
   tm_indicador                             tinyint            null,
   tm_causa                                 char(3)            null,
   tm_departamento                          smallint           null,
   tm_saldo_lib                             money              null,
   tm_saldo_contable                        money              null,
   tm_saldo_disponible                      money              null,
   tm_saldo_interes                         money              null,
   tm_fecha_efec                            smalldatetime      null,
   tm_interes                               money              null,
   tm_control                               int                null,
   tm_ctadestino                            cuenta             null,
   tm_tipo_xfer                             char(2)            null,
   tm_estado                                char(1)            null,
   tm_concepto                              varchar(40)        null,
   tm_oficina_cta                           smallint           null,
   tm_hora                                  smalldatetime      null,
   tm_banco                                 smallint           null,
   tm_valor_comision                        money              null,
   tm_prod_banc                             smallint           not null,
   tm_categoria                             char(1)            not null,
   tm_monto_imp                             money              null,
   tm_tipo_exonerado_imp                    varchar(2)         null,
   tm_serial                                varchar(30)        null,
   tm_tipocta_super                         char(1)            not null,
   tm_turno                                 smallint           null,
   tm_cheque                                int                null,
   tm_forma_pg                              char(4)            null,
   tm_canal                                 smallint           null,
   tm_stand_in                              char(1)            null,
   tm_oficial                               smallint           null,
   tm_clase_clte                            char(1)            null,
   tm_cliente                               int                null,
   tm_base_gmf                              money              null)
end

print '-->Tabla: ah_his_cierre'
if not exists (select 1 from sysobjects where name = 'ah_his_cierre' and type = 'U') begin
   create table ah_his_cierre (
   hc_secuencial                            int                not null,
   hc_cuenta                                int                not null,
   hc_causa                                 varchar(3)         not null,
   hc_orden                                 char(1)            not null,
   hc_saldo                                 money              null,
   hc_fecha                                 smalldatetime      not null,
   hc_filial                                tinyint            not null,
   hc_oficina                               smallint           not null,
   hc_autorizante                           login              null,
   hc_ssn_branch                            int                null,
   hc_forma_pg                              char(4)            null,
   hc_estado                                char(1)            null,
   hc_fecha_r_saldo                         smalldatetime      null,
   hc_oficina_r                             smallint           null,
   hc_usuario_pg                            login              null,
   hc_observacion                           varchar(50)        null,
   hc_observacion1                          varchar(50)        null,
   hc_fecha_act                             smalldatetime      null,
   hc_nombre_rt                             varchar(30)        null,
   hc_sec_ord_pago                          int                null)
end

print '-->Tabla: ah_ctabloqueada'
if not exists (select 1 from sysobjects where name = 'ah_ctabloqueada' and type = 'U') begin
   create table ah_ctabloqueada (
   cb_cuenta                                int                not null,
   cb_secuencial                            int                not null,
   cb_tipo_bloqueo                          varchar(3)         not null,
   cb_fecha                                 smalldatetime      not null,
   cb_hora                                  smalldatetime      not null,
   cb_autorizante                           login              null,
   cb_solicitante                           descripcion        not null,
   cb_oficina                               smallint           not null,
   cb_estado                                estado             null,
   cb_causa                                 varchar(3)         not null,
   cb_sec_asoc                              int                null,
   cb_observacion                           varchar(120)       null)
end

print '-->Tabla: ah_errorlog'
if not exists (select 1 from sysobjects where name = 'ah_errorlog' and type = 'U') begin
   create table ah_errorlog(
   er_fecha_proc                              datetime         not null,
   er_error                                   int              null,
   er_usuario                                 varchar(14)      null,
   er_tran                                    int              null,
   er_cuenta                                  varchar(24)      null,
   er_descripcion                             varchar(240)     null,
   er_cta_pagrec                              varchar(24)      null,
   er_programa                                varchar(24)      null)
end 

print ''
print 'Fin Ejecucion Creacion de Tablas de Dependencias de Plazo Fijo : ' + convert(varchar(60),getdate(),109)
print ''