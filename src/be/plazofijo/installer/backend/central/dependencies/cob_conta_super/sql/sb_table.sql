/************************************************************************/
/*                 Descripcion                                          */
/*  Script para creacion de tablas de Dependencias de Plazo Fijo        */
/************************************************************************/
/*                                                                      */
/*  Fecha         Autor               Comentario                        */
/*  15/07/2016    Oscar Saavedra      Instalador Version Davivienda     */
/************************************************************************/
use cob_conta_super

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

print '-->Tabla: sb_calendario_proyec'
if not exists (select 1 from sysobjects where name = 'sb_calendario_proyec' and type = 'U') begin
   create table sb_calendario_proyec(
   cp_fecha_proc                            datetime           not null,
   cp_tipo_info                             varchar(10)        not null,
   cp_fecha_ing                             datetime           not null)
end
go

print '-->Tabla: sb_dato_operacion'
if not exists (select 1 from sysobjects where name = 'sb_dato_operacion' and type = 'U') begin
   create table sb_dato_operacion(
   do_fecha                                 datetime           not null,
   do_banco                                 varchar(24)        not null,
   do_tipo_operacion                        varchar(10)        not null,
   do_aplicativo                            tinyint            not null,
   do_codigo_cliente                        int                not null,
   do_oficina                               smallint           not null,
   do_moneda                                tinyint            not null,
   do_monto                                 money              not null,
   do_tasa                                  float              null,
   do_modalidad                             char(1)            null,
   do_codigo_destino                        varchar(10)        not null,
   do_clase_cartera                         varchar(10)        not null,
   do_fecha_concesion                       datetime           not null,
   do_fecha_vencimiento                     datetime           not null,
   do_saldo_cap                             money              not null,
   do_saldo_int                             money              not null,
   do_saldo_otros                           money              not null,
   do_saldo_int_contingente                 money              not null,
   do_saldo                                 money              not null,
   do_linea_credito                         varchar(24)        null,
   do_periodicidad_cuota                    smallint           null,
   do_edad_mora                             int                null,
   do_estado_cartera                        tinyint            null,
   do_plazo_dias                            int                null,
   do_num_cuotas                            smallint           null,
   do_valor_mora                            money              null,
   do_valor_cuota                           money              null,
   do_fecha_pago                            datetime           null,
   do_cuotas_pag                            smallint           null,
   do_valor_ult_pago                        money              null,
   do_num_cuotaven                          smallint           null,
   do_saldo_cuotaven                        money              null,
   do_fecha_castigo                         datetime           null,
   do_num_acta                              varchar(24)        null,
   do_clausula                              char(1)            null,
   do_moneda_op                             tinyint            null,
   do_reestructuracion                      char(1)            null,
   do_fecha_reest                           datetime           null,
   do_nat_reest                             catalogo           null,
   do_num_reest                             tinyint            null,
   do_no_renovacion                         int                not null,
   do_estado_contable                       tinyint            not null,
   do_situacion_cliente                     catalogo           null,
   do_calificacion                          varchar(10)        null,
   do_probabilidad_default                  float              null,
   do_calificacion_mr                       varchar(10)        null,
   do_proba_incum                           float              null,
   do_perd_incum                            float              null,
   do_tipo_emp_mr                           char(2)            null,
   do_tipo_garantias                        varchar(10)        null,
   do_valor_garantias                       money              null,
   do_admisible                             char(1)            null,
   do_prov_cap                              money              null,
   do_prov_int                              money              null,
   do_prov_cxc                              money              null,
   do_prov_con_int                          money              null,
   do_prov_con_cxc                          money              null,
   do_prov_con_cap                          money              null,
   do_tipo_reg                              char(1)            not null,
   do_edad_cod                              tinyint            not null,
   do_oficial                               smallint           not null,
   do_fecha_ult_pago                        datetime           null,
   do_naturaleza                            varchar(2)         null,
   do_fuente_recurso                        varchar(10)        null,
   do_categoria_producto                    varchar(10)        null,
   do_fecha_prox_vto                        datetime           null,
   do_op_anterior                           varchar(24)        null,
   do_calif_reest                           catalogo           null,
   do_num_cuotas_reest                      int                null,
   do_tramite                               int                null,
   do_nota_int                              tinyint            null,
   do_fecha_ini_mora                        datetime           null,
   do_gracia_mora                           smallint           null,
   do_estado_cobranza                       catalogo           null,
   do_saldo_otr_contingente                 money              null,
   do_tasa_mora                             float              null,
   do_tasa_com                              float              null,
   do_entidad_convenio                      varchar(10)        null,
   do_fecha_cambio_linea                    datetime           null,
   do_valor_nominal                         money              null,
   do_emision                               varchar(20)        null,
   do_sujcred                               varchar(10)        null,
   do_cap_vencido                           money              null,
   do_valor_proxima_cuota                   money              null,
   do_saldo_total_Vencido                   money              null,
   do_saldo_otr                             money              null,
   do_saldo_cap_total                       money              null,
   do_regional                              varchar(64)        null,
   do_dias_mora_365                         int                null,
   do_normalizado                           char(1)            null,
   do_tipo_norm                             int                null,
   do_banco_padre                           cuenta             null,
   do_fecha_ven_orig                        datetime           null,
   do_fecha_can_ant                         datetime           null,
   do_cuota_int_esp                         money              null,
   do_cuota_iva_esp                         money              null,          
   do_fecha_ini_desp                        datetime           null,
   do_fecha_fin_desp                        datetime           null,
   do_renovacion_grupal                     int                null,
   do_renovacion_ind                        int                null
   )
end
go

print '-->Tabla: sb_dato_pasivas'
if not exists (select 1 from sysobjects where name = 'sb_dato_pasivas' and type = 'U') begin
   create table sb_dato_pasivas(
   dp_fecha                                 datetime           not null,
   dp_banco                                 varchar(24)        not null,
   dp_toperacion                            varchar(10)        not null,
   dp_aplicativo                            tinyint            not null,
   dp_categoria_producto                    varchar(10)        not null,
   dp_naturaleza_cliente                    char(1)            not null,
   dp_cliente                               int                not null,
   dp_oficina                               smallint           not null,
   dp_oficial                               smallint           not null,
   dp_moneda                                tinyint            not null,
   dp_monto                                 money              not null,
   dp_tasa                                  float              null,
   dp_modalidad                             char(1)            null,
   dp_plazo_dias                            int                null,
   dp_fecha_apertura                        datetime           not null,
   dp_fecha_radicacion                      datetime           not null,
   dp_fecha_vencimiento                     datetime           null,
   dp_num_renovaciones                      int                null,
   dp_estado                                tinyint            not null,
   dp_razon_cancelacion                     varchar(10)        null,
   dp_num_cuotas                            smallint           not null,
   dp_periodicidad_cuota                    smallint           not null,
   dp_saldo_disponible                      money              not null,
   dp_saldo_int                             money              not null,
   dp_saldo_camara12h                       money              not null,
   dp_saldo_camara24h                       money              not null,
   dp_saldo_camara48h                       money              not null,
   dp_saldo_remesas                         money              not null,
   dp_condicion_manejo                      char(1)            null,
   dp_exen_gmf                              char(1)            null,
   dp_fecha_ini_exen_gmf                    datetime           null,
   dp_fecha_fin_exen_gmf                    datetime           null,
   dp_tesoro_nacional                       char(1)            null,
   dp_ley_exen                              varchar(10)        null,
   dp_tasa_variable                         char(1)            null,
   dp_referencial_tasa                      catalogo           null,
   dp_signo_spread                          char(1)            null,
   dp_spread                                float              null,
   dp_signo_puntos                          char(1)            null,
   dp_puntos                                float              null,
   dp_signo_tasa_ref                        char(1)            null,
   dp_puntos_tasa_ref                       float              null)
end
go

print '-->Tabla: sb_equivalencias'
if not exists (select 1 from sysobjects where name = 'sb_equivalencias' and type = 'U') begin
   create table sb_equivalencias(
   eq_catalogo                              catalogo           not null,
   eq_valor_cat                             descripcion        not null,
   eq_valor_arch                            descripcion        not null,
   eq_descripcion                           descripcion        not null,
   eq_estado                                estado             not null)
end

print '-->Tabla: sb_errorlog'
if not exists (select 1 from sysobjects where name = 'sb_errorlog' and type = 'U') begin
   create table sb_errorlog(
   er_fecha                                 datetime           not null,
   er_fecha_proc                            datetime           not null,
   er_fuente                                descripcion        not null,
   er_origen_error                          varchar(255)       not null,
   er_descrp_error                          varchar(255)       not null)
end
go

print '-->Tabla: tmp_error'
if not exists (select 1 from sysobjects where name = 'tmp_error' and type = 'U') begin
   create table tmp_error(
   registro                                 varchar(800)       NULL)
end
go

print ''
print 'Fin Ejecucion Creacion de Tablas de Dependencias de Plazo Fijo : ' + convert(varchar(60),getdate(),109)
print ''