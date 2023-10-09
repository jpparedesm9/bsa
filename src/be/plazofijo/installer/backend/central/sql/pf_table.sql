/************************************************************************/
/*                 Descripcion                                          */
/*  Script para creacion de tablas                                      */
/************************************************************************/
/*                                                                      */
/*  Fecha         Autor               Comentario                        */
/*  07/07/2016    Oscar Saavedra      Instalador Version Davivienda     */
/************************************************************************/
use cob_pfijo
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
print 'Inicio Ejecucion Creacion de Tablas Plazo Fijo : ' + convert(varchar(60),getdate(),109)
print ''

print '-->Tabla: pf_npreimpreso'
if exists (select 1 from sysobjects where name = 'pf_npreimpreso' and type = 'U')
   drop table pf_npreimpreso

create table pf_npreimpreso(
np_operacion                             int                not null,
np_secuencial                            tinyint            not null,
np_preimpreso                            int                not null,
np_observacion                           descripcion        null,
np_cupon                                 cuenta             null,
np_preimpreso_cupon                      int                null,
np_toperacion                            catalogo           not null,
np_hora                                  varchar(5)         null,
np_usuario                               descripcion        null,
np_fecha                                 datetime           null)
go

print '-->Tabla: pf_errores_migracion'
if exists (select 1 from sysobjects where name = 'pf_errores_migracion' and type = 'U')
   drop table pf_errores_migracion

create table pf_errores_migracion(
num_banco                                cuenta             not null,
operacion                                int                not null,
descripcion                              varchar(80)        not null,
campo                                    varchar(80)        null,
calculado                                money              null,
real                                     money              null,
diferencia                               money              null,
dias                                     int                null)
go

print '-->Tabla: pf_temp_anular'
if exists (select 1 from sysobjects where name = 'pf_temp_anular' and type = 'U')
   drop table pf_temp_anular

create table pf_temp_anular(
ta_num_banco                             cuenta             not null,
ta_oficina                               smallint           not null)
go

print '-->Tabla: pf_instruccion'
if exists (select 1 from sysobjects where name = 'pf_instruccion' and type = 'U')
   drop table pf_instruccion

create table pf_instruccion(
in_operacion                             int                not null,
in_instruccion                           varchar(255)       not null,
in_estadoxren                            char(1)            null,
in_fecha_crea                            datetime           null,
in_fecha_mod                             datetime           null)
go

print '-->Tabla: pf_temp_gasto'
if exists (select 1 from sysobjects where name = 'pf_temp_gasto' and type = 'U')
   drop table pf_temp_gasto

create table pf_temp_gasto(
op_moneda                                tinyint            null,
op_toperacion                            catalogo           null,
op_oficina                               smallint           null,
op_num_banco                             cuenta             null,
op_monto                                 money              null,
op_tasa                                  float              null,
op_fecha_valor                           datetime           null,
op_fecha_ven                             datetime           null,
op_base_calculo                          smallint           null,
COSTO_DIARIO                             float              null)
go

print '-->Tabla: pf_bloqueo_legal'
if exists (select 1 from sysobjects where name = 'pf_bloqueo_legal' and type = 'U')
   drop table pf_bloqueo_legal

create table pf_bloqueo_legal(
bl_operacion                             int                not null,
bl_secuencial                            tinyint            not null,
bl_valor_embgdo_juzgado                  money              not null,
bl_valor_embgdo_banco                    money              not null,
bl_tipo_bloq_legal                       catalogo           not null,
bl_fecha_oficio                          datetime           not null,
bl_num_oficio                            varchar(30)        not null,
bl_autoridad                             varchar(64)        not null,
bl_usuario                               login              not null,
bl_fecha_crea                            datetime           not null,
bl_fecha_mod                             datetime           null,
bl_observacion                           varchar(64)        null,
bl_motivo_blqlegal                       catalogo           not null,
bl_valor_int_embgdo_banco                money              null,
bl_valor_int_embgdo_aplicado             money              null,
bl_estado                                varchar(5)         not null,
bl_oficina                               int                not null,
bl_ente                                  int                null)
go

print '-->Tabla: pf_hist_tasa'
if exists (select 1 from sysobjects where name = 'pf_hist_tasa' and type = 'U')
   drop table pf_hist_tasa

create table pf_hist_tasa(
ht_secuencial                            int                not null,
ht_tipo_deposito                         varchar(5)         not null,
ht_moneda                                tinyint            not null,
ht_tipo_monto                            varchar(10)        not null,
ht_tipo_plazo                            varchar(10)        not null,
ht_tasa_min                              float              not null,
ht_tasa_max                              float              not null,
ht_vigente                               float              not null,
ht_tasa_min_ant                          float              null,
ht_tasa_max_ant                          float              null,
ht_vigente_ant                           float              null,
ht_estado                                char(1)            null,
ht_fecha_crea                            datetime           not null,
ht_usuario                               login              null,
ht_usuario_ant                           login              null,
ht_fecha_crea_ant                        datetime           null,     
ht_tipo                                  char(1)            not null,
ht_tipo_pago                             varchar(10)        null,
ht_segmento                              catalogo           null,
ht_ivc                                   catalogo           null,
ht_prorroga                              catalogo           null,
ht_momento                               catalogo           null)
go

print '-->Tabla: pf_hist_tasa_variable'
if exists (select 1 from sysobjects where name = 'pf_hist_tasa_variable' and type = 'U')
   drop table pf_hist_tasa_variable

create table pf_hist_tasa_variable(
hv_secuencial                            int                not null,
hv_moneda                                tinyint            not null,
hv_tipo_monto                            varchar(5)         not null,
hv_tipo_plazo                            varchar(5)         not null,
hv_tasa_min                              float              not null,
hv_tasa_max                              float              not null,
hv_spread_min                            float              not null,
hv_spread_max                            float              not null,
hv_spread_vigente                        float              not null,
hv_tasa_min_ant                          float              null,
hv_tasa_max_ant                          float              null,
hv_spread_min_ant                        float              null,
hv_spread_max_ant                        float              null,
hv_spread_vigente_ant                    float              null,
hv_estado                                char(1)            null,
hv_operador                              char(1)            not null,
hv_fecha_crea                            datetime           not null,
hv_mnemonico_prod                        varchar(5)         not null,
hv_mnemonico_tasa                        catalogo           not null,
hv_usuario                               login              null,
hv_usuario_ant                           login              null,
hv_fecha_crea_ant                        datetime           null,
hv_tipo_pago                             varchar(10)        null,
hv_segmento                              catalogo           null,
hv_ivc                                   catalogo           null,
hv_prorroga                              catalogo           null,
hv_momento                               catalogo           null)
go

print '-->Tabla: pf_total_acrue'
if exists (select 1 from sysobjects where name = 'pf_total_acrue' and type = 'U')
   drop table pf_total_acrue

create table pf_total_acrue(
ta_fecha                                 datetime           not null,
ta_oficina                               int                not null,
ta_moneda                                smallint           not null,
ta_toperacion                            catalogo           not null,
ta_ente                                  int                not null,
ta_provision_diaria                      money              null,
ta_provision_vencida                     money              null,
ta_num_dias                              int                null,
ta_fecha_inicio                          datetime           null,
ta_fecha_fin                             datetime           null,
ta_interes_ini                           money              null,
ta_interes_fin                           money              null,
ta_contabilizado                         char(1)            null)
go

print '-->Tabla: pf_total_acrue_his'
if exists (select 1 from sysobjects where name = 'pf_total_acrue_his' and type = 'U')
   drop table pf_total_acrue_his

create table pf_total_acrue_his(
ta_fecha                                 datetime           not null,
ta_oficina                               int                not null,
ta_moneda                                smallint           not null,
ta_toperacion                            catalogo           not null,
ta_ente                                  int                not null,
ta_provision_diaria                      money              null,
ta_provision_vencida                     money              null,
ta_num_dias                              int                null,
ta_fecha_inicio                          datetime           null,
ta_fecha_fin                             datetime           null,
ta_interes_ini                           money              null,
ta_interes_fin                           money              null,
ta_contabilizado                         char(1)            null)
go

print '-->Tabla: pf_aux'
if exists (select 1 from sysobjects where name = 'pf_aux' and type = 'U')
   drop table pf_aux

create table pf_aux(
pa_varchar                               varchar(800)       null)
go
 
print '-->Tabla: pf_aut_spread'
if exists (select 1 from sysobjects where name = 'pf_aut_spread' and type = 'U')
   drop table pf_aut_spread

create table pf_aut_spread(
as_secuencial                            int                not null,
as_operacion                             int                not null,
as_spread                                float              not null,
as_operador                              char(1)            null,
as_fecha                                 datetime           not null,
as_estado                                char(1)            not null,
as_usuario                               login              not null)
go

print '-->Tabla: pf_operacion_renov'
if exists (select 1 from sysobjects where name = 'pf_operacion_renov' and type = 'U')
   drop table pf_operacion_renov

create table pf_operacion_renov(
or_num_banco                             cuenta             not null,
or_operacion                             int                not null,
or_ente                                  int                not null,
or_toperacion                            catalogo           not null,
or_categoria                             catalogo           not null,
or_estado                                catalogo           not null,
or_producto                              tinyint            not null,
or_oficina                               smallint           not null,
or_moneda                                tinyint            not null,
or_num_dias                              smallint           not null,
or_base_calculo                          smallint           not null,
or_monto                                 money              not null,
or_monto_pg_int                          money              not null,
or_monto_pgdo                            money              not null,
or_monto_blq                             money              not null,
or_tasa                                  float              not null,
or_tasa_efectiva                         float              not null,
or_int_ganado                            money              not null,
or_int_estimado                          money              not null,
or_residuo                               float              not null,
or_int_pagados                           money              not null,
or_int_provision                         float              not null,
or_total_int_ganados                     money              not null,
or_total_int_pagados                     money              not null,
or_total_int_estimado                    money              not null,
or_total_int_retenido                    money              not null,
or_total_retencion                       money              not null,
or_fpago                                 catalogo           not null,
or_ppago                                 catalogo           null,
or_dia_pago                              smallint           null,
or_casilla                               tinyint            null,
or_direccion                             tinyint            null,
or_telefono                              varchar(8)         null,
or_historia                              smallint           null,
or_duplicados                            tinyint            not null,
or_renovaciones                          smallint           not null,
or_incremento                            money              not null,
or_mon_sgte                              smallint           not null,
or_pignorado                             char(1)            not null,
or_renova_todo                           char(1)            not null,
or_imprime                               char(1)            not null,
or_retenido                              char(1)            not null,
or_retienimp                             char(1)            not null,
or_totalizado                            char(1)            not null,
or_tcapitalizacion                       char(1)            not null,
or_oficial                               login              not null,
or_accion_sgte                           catalogo           null,
or_preimpreso                            int                null,
or_tipo_plazo                            catalogo           not null,
or_tipo_monto                            catalogo           not null,
or_causa_mod                             catalogo           not null,
or_descripcion                           varchar(255)       not null,
or_fecha_valor                           datetime           not null,
or_fecha_ven                             datetime           not null,
or_fecha_cancela                         datetime           null,
or_fecha_ingreso                         datetime           not null,
or_fecha_pg_int                          datetime           not null,
or_fecha_ult_pg_int                      datetime           null,
or_ult_fecha_calculo                     datetime           null,
or_fecha_crea                            datetime           not null,
or_fecha_mod                             datetime           null,
or_fecha_total                           datetime           null,
or_puntos                                float              not null,
or_total_int_acumulado                   money              not null,
or_tasa_mer                              float              not null,
or_ced_ruc                               cuenta             null,
or_plazo_ant                             smallint           null,
or_fecven_ant                            datetime           null,
or_tot_int_est_ant                       money              null,
or_fecha_ord_act                         datetime           null,
or_mantiene_stock                        char(1)            null,
or_stock                                 int                null,
or_emision_inicial                       int                null,
or_moneda_pg                             char(2)            null,
or_impuesto                              float              not null,
or_num_imp_orig                          tinyint            null,
or_impuesto_capital                      money              not null,
or_retiene_imp_capital                   char(1)            not null,
or_ley                                   char(1)            null,
or_reestruc                              char(1)            null,
or_fecha_real                            datetime           null,
or_ult_fecha_cal_tasa                    datetime           null,
or_num_dias_gracia                       int                not null,
or_prorroga_aut                          char(1)            null,
or_tasa_variable                         char(1)            not null,
or_mnemonico_tasa                        catalogo           null,
or_modalidad_tasa                        char(1)            null,
or_periodo_tasa                          smallint           null,
or_descr_tasa                            descripcion        null,
or_operador                              char(1)            null,
or_spread                                float              null,
or_estatus_prorroga                      char(1)            null,
or_num_prorroga                          int                null,
or_anio_comercial                        char(1)            null,
or_flag_tasaefec                         char(1)            null,
or_renovada                              char(1)            null,
or_estado_renov                          char(3)            null,
or_operacion_cont                        smallint           null,
or_plazo_cont                            int                null,
or_oficial_principal                     login              null,
or_tipo_tasa_var                         char(1)            null,
or_plazo_orig                            int                null,
or_ult_fecha_calven                      datetime           null,
or_int_prov_vencida                      float              null,
or_int_total_prov_vencida                money              null,
or_sec_incre                             int                null,
or_fecha_ult_renov                       datetime           null,
or_sucursal                              smallint           null,
or_incremento_suspenso                   money              null,
or_oficial_secundario                    login              null,
or_captador                              login              null,
or_bloqueo_legal                         char(1)            null,
or_monto_blqlegal                        money              null,
or_dias_reales                           char(1)            null,
or_inactivo                              char(1)            null,
or_localizado                            char(1)            null,
or_fecha_localizacion                    smalldatetime      null,
or_fecha_no_localiza                     smalldatetime      null,
or_origen_fondos                         catalogo           null,
or_proposito_cuenta                      catalogo           null,
or_producto_bancario1                    catalogo           null,
or_producto_bancario2                    catalogo           null,
or_aprobado                              char(1)            null,
or_oficina_apertura                      smallint           null,
or_oficial_apertura                      login              null,
or_toperacion_apertura                   catalogo           null,
or_tipo_plazo_apertura                   catalogo           null,
or_tipo_monto_apertura                   catalogo           null)
go
 
print '-->Tabla: pf_incre_op'
if exists (select 1 from sysobjects where name = 'pf_incre_op' and type = 'U')
   drop table pf_incre_op

create table pf_incre_op(
io_secuencial                            int                not null,
io_num_banco                             cuenta             not null,
io_operacion                             int                not null,
io_ente                                  int                not null,
io_toperacion                            catalogo           not null,
io_categoria                             catalogo           not null,
io_estado                                catalogo           not null,
io_producto                              tinyint            not null,
io_oficina                               smallint           not null,
io_moneda                                tinyint            not null,
io_num_dias                              smallint           not null,
io_base_calculo                          smallint           not null,
io_monto                                 money              not null,
io_monto_pg_int                          money              not null,
io_monto_pgdo                            money              not null,
io_monto_blq                             money              not null,
io_tasa                                  float              not null,
io_tasa_efectiva                         float              not null,
io_int_ganado                            money              not null,
io_int_estimado                          money              not null,
io_residuo                               float              not null,
io_int_pagados                           money              not null,
io_int_provision                         float              not null,
io_total_int_ganados                     money              not null,
io_total_int_pagados                     money              not null,
io_total_int_estimado                    money              not null,
io_total_int_retenido                    money              not null,
io_total_retencion                       money              not null,
io_fpago                                 catalogo           not null,
io_ppago                                 catalogo           null,
io_dia_pago                              smallint           null,
io_casilla                               tinyint            null,
io_direccion                             tinyint            null,
io_telefono                              varchar(8)         null,
io_historia                              smallint           null,
io_duplicados                            tinyint            not null,
io_renovaciones                          smallint           not null,
io_incre                                 char(1)            null,
io_incremento                            money              not null,
io_sec_incre                             int                null,
io_mon_sgte                              smallint           not null,
io_pignorado                             char(1)            not null,
io_renova_todo                           char(1)            not null,
io_imprime                               char(1)            not null,
io_retenido                              char(1)            not null,
io_retienimp                             char(1)            not null,
io_totalizado                            char(1)            not null,
io_tcapitalizacion                       char(1)            not null,
io_oficial                               login              not null,
io_accion_sgte                           catalogo           null,
io_preimpreso                            int                null,
io_tipo_plazo                            catalogo           not null,
io_tipo_monto                            catalogo           not null,
io_causa_mod                             catalogo           not null,
io_descripcion                           varchar(255)       not null,
io_fecha_valor                           datetime           not null,
io_fecha_ven                             datetime           not null,
io_fecha_cancela                         datetime           null,
io_fecha_ingreso                         datetime           not null,
io_fecha_pg_int                          datetime           not null,
io_fecha_ult_pg_int                      datetime           null,
io_ult_fecha_calculo                     datetime           null,
io_fecha_crea                            datetime           not null,
io_fecha_mod                             datetime           null,
io_fecha_total                           datetime           null,
io_puntos                                float              not null,
io_total_int_acumulado                   money              not null,
io_tasa_mer                              float              not null,
io_ced_ruc                               varchar(35)        null,
io_plazo_ant                             smallint           null,
io_fecven_ant                            datetime           null,
io_tot_int_est_ant                       money              null,
io_fecha_ord_act                         datetime           null,
io_mantiene_stock                        char(1)            null,
io_stock                                 int                null,
io_emision_inicial                       int                null,
io_moneda_pg                             char(2)            null,
io_impuesto                              float              not null,
io_num_imp_orig                          tinyint            null,
io_impuesto_capital                      money              not null,
io_retiene_imp_capital                   char(1)            not null,
io_ley                                   char(1)            null,
io_reestruc                              char(1)            null,
io_fecha_real                            datetime           null,
io_ult_fecha_cal_tasa                    datetime           null,
io_num_dias_gracia                       int                not null,
io_prorroga_aut                          char(1)            null,
io_tasa_variable                         char(1)            not null,
io_mnemonico_tasa                        catalogo           null,
io_modalidad_tasa                        char(1)            null,
io_periodo_tasa                          smallint           null,
io_descr_tasa                            descripcion        null,
io_operador                              char(1)            null,
io_spread                                float              null,
io_estatus_prorroga                      char(1)            null,
io_num_prorroga                          int                null,
io_anio_comercial                        char(1)            null,
io_flag_tasaefec                         char(1)            null,
io_renovada                              char(1)            null,
io_int_ajuste                            money              null,
io_int_prov_vencida                      money              null,
io_int_total_prov_vencida                money              null,
io_residuo_prov                          float              null,
io_tasa_ant                              float              null,
io_cambio_tasa                           char(1)            null,
io_estado_inc                            char(3)            not null,
io_fecha_aplicacion                      datetime           not null,
io_plazo_cont                            catalogo           null,
io_oficial_principal                     login              null,
io_tipo_tasa_var                         char(1)            null,
io_plazo_orig                            int                null,
io_ult_fecha_calven                      datetime           null,
io_camb_oper                             int                null,
io_localizado                            char(1)            null,
io_fecha_localizacion                    smalldatetime      null,
io_fecha_no_localiza                     smalldatetime      null,
io_sucursal                              smallint           null)
go
 
print '-->Tabla: pf_incremento'
if exists (select 1 from sysobjects where name = 'pf_incremento' and type = 'U')
   drop table pf_incremento

create table pf_incremento(
in_operacion                             int                not null,
in_ente                                  int                not null,
in_toperacion                            catalogo           not null,
in_categoria                             catalogo           not null,
in_estado_op                             catalogo           not null,
in_producto                              tinyint            not null,
in_oficina                               smallint           not null,
in_moneda                                tinyint            not null,
in_num_dias                              smallint           not null,
in_monto                                 money              not null,
in_monto_pg_int                          money              not null,
in_monto_pgdo                            money              not null,
in_monto_blq                             money              not null,
in_tasa                                  float              not null,
in_tasa_efectiva                         float              not null,
in_int_ganado                            money              not null,
in_int_estimado                          money              not null,
in_residuo                               float              not null,
in_int_pagados                           money              not null,
in_int_provision                         float              not null,
in_total_int_ganados                     money              not null,
in_total_int_pagados                     money              not null,
in_total_int_estimado                    money              not null,
in_total_int_retenido                    money              not null,
in_total_retencion                       money              not null,
in_fpago                                 catalogo           not null,
in_mon_sgte                              smallint           not null,
in_renovaciones                          smallint           not null,
in_incremento                            money              not null,
in_sec_incremento                        int                not null,
in_tipo_plazo                            catalogo           not null,
in_impuesto                              float              not null,
in_impuesto_capital                      money              not null,
in_retiene_imp_capital                   char(1)            not null,
in_tasa_variable                         char(1)            not null,
in_fecha_incremento                      datetime           not null,
in_estado_inc                            char(1)            not null,
in_plazo                                 int                not null,
in_descripcion                           varchar(64)        null,
in_oficial                               login              not null,
in_int_vencido                           money              null,
in_ppago                                 catalogo           null)
go
 
print '-->Tabla: pf_intereses_canc'
if exists (select 1 from sysobjects where name = 'pf_intereses_canc' and type = 'U')
   drop table pf_intereses_canc
   
create table pf_intereses_canc(
pc_num_banco                             varchar(24)        null,
pc_estado                                varchar(10)        null,
pc_fecha_can                             datetime           null,
pc_num_id                                varchar(30)        null,
pc_nombre                                varchar(255)       null,
pc_tipo_op                               varchar(30)        null,
pc_valor                                 money              null,
pc_oficina                               smallint           null)
go

print '-->Tabla: pf_cuotas_his'
if exists (select 1 from sysobjects where name = 'pf_cuotas_his' and type = 'U')
   drop table pf_cuotas_his

create table pf_cuotas_his(
ch_ente                                  int                not null,
ch_operacion                             int                not null,
ch_cuota                                 tinyint            not null,
ch_fecha_pago                            datetime           not null,
ch_valor_cuota                           money              not null,
ch_retencion                             money              null,
ch_capital                               money              not null,
ch_fecha_crea                            datetime           not null,
ch_moneda                                tinyint            not null,
ch_oficina                               smallint           not null,
ch_num_dias                              int                not null,
ch_estado                                char(1)            not null,
ch_fecha_ult_pago                        datetime           not null,
ch_tasa                                  float              not null,
ch_ppago                                 catalogo           null,
ch_base_calculo                          int                not null,
ch_fecha_grab                            datetime           null,
ch_valor_neto                            money              null,
ch_retenido                              char(1)            null)
go
 
print '-->Tabla: sb_data_bcp'
if exists (select 1 from sysobjects where name = 'sb_data_bcp' and type = 'U')
   drop table sb_data_bcp

create table sb_data_bcp(
dt_data                                  varchar(1000)      null)
go
 
print '-->Tabla: pf_reporte_gmf_cdt_det'
if exists (select 1 from sysobjects where name = 'pf_reporte_gmf_cdt_det' and type = 'U')
   drop table pf_reporte_gmf_cdt_det

create table pf_reporte_gmf_cdt_det(
rgc_nro_cdt                              cuenta             null,
rgc_concepto                             catalogo           null,
rgc_tran                                 int                null,
rgc_tipo_tran                            catalogo           null,
rgc_valor                                money              null)
go
 
print '-->Tabla: pf_cambio_oper'
if exists (select 1 from sysobjects where name = 'pf_cambio_oper' and type = 'U')
   drop table pf_cambio_oper

create table pf_cambio_oper(
co_secuencial                            int                not null,
co_operacion                             int                not null,
co_num_banco                             cuenta             not null,
co_oficina                               int                null,
co_oficina_ant                           int                null,
co_toperacion                            catalogo           null,
co_toperacion_ant                        catalogo           null,
co_funcionario                           login              null,
co_oficial_prin                          login              null,
co_oficial_prin_ant                      login              null,
co_fecha                                 datetime           null,
co_contabiliza                           char(1)            not null,
co_contabilizado                         char(1)            not null,
co_fecha_valor                           datetime           null,
co_fecha_valop                           datetime           null,
co_fecha_valop_ant                       datetime           null,
co_base_calculo                          int                null,
co_base_calculo_ant                      int                null,
co_oficina_ope                           int                null,
co_oficina_ope_ant                       int                null,
co_tcapitalizacion                       char(1)            null,
co_tcapitalizacion_ant                   char(1)            null,
co_oficial_sec                           login              null,
co_oficial_sec_ant                       login              null,
co_estado                                char(1)            null,
co_fecha_ven_ant                         datetime           null,
co_fecha_ven                             datetime           null,
co_tasa                                  float              null,
co_tasa_ant                              float              null,
co_instruccion_especial                  descripcion        null,
co_fpago                                 catalogo           null,
co_ppago                                 catalogo           null,
co_categoria                             catalogo           null,
co_categoria_ant                         catalogo           null,
co_dia_pago                              smallint           null,
co_dia_pago_ant                          smallint           null,
co_fpago_ant                             catalogo           null,
co_ppago_ant                             catalogo           null,
co_num_dias                              smallint           null,
co_num_dias_ant                          smallint           null,
co_plazo_orig                            int                null,
co_plazo_orig_ant                        int                null,
co_dias_reales                           char(1)            null,
co_dias_reales_ant                       char(1)            null,
co_titulares                             varchar(100)       null,
co_titulares_ant                         varchar(100)       null,
co_firmantes                             varchar(100)       null,
co_firmantes_ant                         varchar(100)       null,
co_fideicomiso                           varchar(15)        null,
co_fideicomiso_ant                       varchar(15)        null,
co_desmaterializa_ant                    char(1)            null,
co_desmaterializa                        char(1)            null)
go
 
print '-->Tabla: pf_reporte_gmf_cdt'
if exists (select 1 from sysobjects where name = 'pf_reporte_gmf_cdt' and type = 'U')
   drop table pf_reporte_gmf_cdt

create table pf_reporte_gmf_cdt(
codigo_ofi                               int                null,
desc_ofi                                 varchar(100)       null,
nombre_titular                           varchar(255)       null,
ident_titular                            varchar(255)       null,
estado_cdt                               varchar(10)        null,
nro_cdt                                  varchar(50)        null,
fecha_aper_cdt                           datetime           null,
fecha_canc_cdt                           datetime           null,
vlr_cdt                                  money              null,
int_pagados                              money              null,
ret_practicada                           money              null,
base_gmf_int                             money              null,
base_gmf_cap                             money              null,
valor_gmf_cap                            money              null,
valor_gmf_int                            money              null,
opciones                                 varchar(10)        null)
go

print '-->Tabla: pf_transferencias_tmp'
if exists (select 1 from sysobjects where name = 'pf_transferencias_tmp' and type = 'U')
   drop table pf_transferencias_tmp

create table pf_transferencias_tmp(
tr_cod_transf                            int                not null,
tr_cod_operacion                         int                not null,
tr_moneda                                tinyint            not null,
tr_fecha                                 datetime           not null,
tr_cod_corresp                           catalogo           not null,
tr_cta_corresp                           cuenta             not null,
tr_benef_corresp                         varchar(64)        null,
tr_ofic_corresp                          int                not null,
tr_estado                                char(1)            not null,
tr_monto                                 money              null,
tr_accion                                char(1)            null,
tr_sec_pago                              int                null,
tr_act_sec                               char(1)            null,
tr_sec_mov                               int                null,
tr_act_sec_mm                            char(1)            null,
tr_usuario                               login              null,
tr_sesion                                int                null,
tr_tipo_pago                             char(1)            null,
tr_porcentaje                            float              null)
go
 
print '-->Tabla: pf_reporte_gmf_che'
if exists (select 1 from sysobjects where name = 'pf_reporte_gmf_che' and type = 'U')
   drop table pf_reporte_gmf_che

create table pf_reporte_gmf_che(
codigo_ofi                               int                null,
desc_ofi                                 varchar(100)       null,
nro_cheque                               varchar(50)        null,
fecha_emision                            datetime           null,
nom_beneficiario                         varchar(255)       null,
ide_beneficiario                         varchar(24)        null,
vlr_cheque                               money              null,
concepto                                 varchar(255)       null,
destino_cheque                           varchar(255)       null,
base_gmf                                 money              null,
valor_gmf                                money              null,
estado                                   varchar(24)        null,
usuario                                  varchar(50)        null)
go
 
print '-->Tabla: pf_prov_dia'
if exists (select 1 from sysobjects where name = 'pf_prov_dia' and type = 'U')
   drop table pf_prov_dia

create table pf_prov_dia(
pd_fecha_proceso                         datetime           null,
pd_operacion                             int                null,
pd_oficina                               smallint           null,
pd_toperacion                            catalogo           null,
pd_monto                                 money              null,
pd_tasa                                  float              null,
pd_base_cal                              smallint           null,
pd_valor                                 money              null,
pd_valor_calc                            decimal(30,16)     null)
go
 
print '-->Tabla: pf_cuadre_auxiliar'
if exists (select 1 from sysobjects where name = 'pf_cuadre_auxiliar' and type = 'U')
   drop table pf_cuadre_auxiliar

create table pf_cuadre_auxiliar(
ca_fecha_proceso                         datetime           null,
ca_tipo_deposito                         catalogo           null,
ca_oficina                               smallint           null,
ca_moneda                                tinyint            null,
ca_capital                               money              null,
ca_interes                               money              null,
ca_num_reg                               int                null)
go
 
print '-->Tabla: pf_error_conta'
if exists (select 1 from sysobjects where name = 'pf_error_conta' and type = 'U')
   drop table pf_error_conta

create table pf_error_conta(
ec_fecha                                 datetime           null,
ec_moneda                                tinyint            not null,
ec_ofi_orig                              smallint           not null,
ec_ofi_dest                              smallint           not null,
ec_perfil                                varchar(10)        not null,
ec_valor                                 money              not null,
ec_valor_me                              money              not null,
ec_descripcion                           varchar(255)       not null,
ec_tipo_tran                             descripcion        null,
ec_cuenta                                cuenta             null,
ec_area                                  int                null)
go
 
print '-->Tabla: pf_centralizada'
if exists (select 1 from sysobjects where name = 'pf_centralizada' and type = 'U')
   drop table pf_centralizada

create table pf_centralizada(
ce_empresa                               tinyint            null,
ce_parametro                             varchar(15)        null,
ce_clave                                 varchar(20)        null,
ce_oficina                               smallint           null,
ce_area                                  int                null)
go
 
print '-->Tabla: pf_convivencia_credito'
if exists (select 1 from sysobjects where name = 'pf_convivencia_credito' and type = 'U')
   drop table pf_convivencia_credito

create table pf_convivencia_credito(
cc_fecha_proceso                         datetime           not null,
cc_operacion_pf                          varchar(11)        not null,
cc_operacion_cre                         varchar(11)        not null,
cc_tasa                                  float              not null,
cc_fecha_mod                             datetime           not null)
go
 
print '-->Tabla: pf_rubro_op'
if exists (select 1 from sysobjects where name = 'pf_rubro_op' and type = 'U')
   drop table pf_rubro_op

create table pf_rubro_op(
ro_num_banco                             cuenta             not null,
ro_operacion                             int                not null,
ro_toperacion                            catalogo           not null,
ro_moneda                                smallint           not null,
ro_tipo_monto                            catalogo           not null,
ro_tipo_plazo                            catalogo           not null,
ro_concepto                              catalogo           not null,
ro_mnemonico_tasa                        catalogo           null,
ro_operador                              char(1)            null,
ro_modalidad_tasa                        char(1)            null,
ro_periodo_tasa                          smallint           null,
ro_descr_tasa                            descripcion        null,
ro_spread                                float              null,
ro_valor                                 float              not null)
go
 
print '-->Tabla: pf_rubro_op_renov'
if exists (select 1 from sysobjects where name = 'pf_rubro_op_renov' and type = 'U')
   drop table pf_rubro_op_renov

create table pf_rubro_op_renov(
ror_num_banco                            cuenta             not null,
ror_operacion                            int                not null,
ror_toperacion                           catalogo           not null,
ror_moneda                               smallint           not null,
ror_tipo_monto                           catalogo           not null,
ror_tipo_plazo                           catalogo           not null,
ror_concepto                             catalogo           not null,
ror_mnemonico_tasa                       catalogo           null,
ror_operador                             char(1)            null,
ror_modalidad_tasa                       char(1)            null,
ror_periodo_tasa                         smallint           null,
ror_descr_tasa                           descripcion        null,
ror_spread                               float              null,
ror_valor                                float              not null,
ror_estado                               catalogo           null)
go
 
print '-->Tabla: pf_rubro_op_i'
if exists (select 1 from sysobjects where name = 'pf_rubro_op_i' and type = 'U')
   drop table pf_rubro_op_i

create table pf_rubro_op_i(
roi_num_banco                            cuenta             not null,
roi_operacion                            int                not null,
roi_toperacion                           catalogo           not null,
roi_moneda                               smallint           not null,
roi_tipo_monto                           catalogo           not null,
roi_tipo_plazo                           catalogo           not null,
roi_concepto                             catalogo           not null,
roi_mnemonico_tasa                       catalogo           null,
roi_operador                             char(1)            null,
roi_modalidad_tasa                       char(1)            null,
roi_periodo_tasa                         smallint           null,
roi_descr_tasa                           descripcion        null,
roi_spread                               float              null,
roi_valor                                float              not null)
go
 
print '-->Tabla: pf_rubro_op_tmp'
if exists (select 1 from sysobjects where name = 'pf_rubro_op_tmp' and type = 'U')
   drop table pf_rubro_op_tmp

create table pf_rubro_op_tmp(
rot_usuario                              login              null,
rot_sesion                               int                not null,
rot_num_banco                            cuenta             not null,
rot_operacion                            int                not null,
rot_toperacion                           catalogo           not null,
rot_moneda                               smallint           not null,
rot_tipo_monto                           catalogo           not null,
rot_tipo_plazo                           catalogo           not null,
rot_concepto                             catalogo           not null,
rot_mnemonico_tasa                       catalogo           null,
rot_operador                             char(1)            null,
rot_modalidad_tasa                       char(1)            null,
rot_periodo_tasa                         smallint           null,
rot_descr_tasa                           descripcion        null,
rot_spread                               float              null,
rot_valor                                float              not null)
go
 
print '-->Tabla: pf_his_mensual'
if exists (select 1 from sysobjects where name = 'pf_his_mensual' and type = 'U')
   drop table pf_his_mensual

create table pf_his_mensual(
hm_fecha                                 datetime           not null,
hm_num_banco                             cuenta             not null,
hm_operacion                             int                not null,
hm_ente                                  int                not null,
hm_toperacion                            catalogo           not null,
hm_categoria                             catalogo           not null,
hm_estado                                catalogo           not null,
hm_producto                              tinyint            not null,
hm_oficina                               smallint           not null,
hm_moneda                                tinyint            not null,
hm_num_dias                              smallint           not null,
hm_base_calculo                          smallint           not null,
hm_monto                                 money              not null,
hm_monto_pg_int                          money              not null,
hm_monto_pgdo                            money              not null,
hm_monto_blq                             money              not null,
hm_tasa                                  float              not null,
hm_tasa_efectiva                         float              not null,
hm_int_ganado                            money              not null,
hm_int_estimado                          money              not null,
hm_residuo                               float              not null,
hm_int_pagados                           money              not null,
hm_int_provision                         float              not null,
hm_total_int_ganados                     money              not null,
hm_total_int_pagados                     money              not null,
hm_total_int_estimado                    money              not null,
hm_total_int_retenido                    money              not null,
hm_total_retencion                       money              not null,
hm_fpago                                 catalogo           not null,
hm_ppago                                 catalogo           null,
hm_dia_pago                              smallint           null,
hm_casilla                               tinyint            null,
hm_direccion                             tinyint            null,
hm_telefono                              varchar(16)        null,
hm_historia                              smallint           null,
hm_duplicados                            tinyint            not null,
hm_renovaciones                          smallint           not null,
hm_incremento                            money              null,
hm_mon_sgte                              smallint           not null,
hm_pignorado                             char(1)            not null,
hm_renova_todo                           char(1)            not null,
hm_imprime                               char(1)            not null,
hm_retenido                              char(1)            not null,
hm_retienimp                             char(1)            not null,
hm_totalizado                            char(1)            not null,
hm_tcapitalizacion                       char(1)            not null,
hm_oficial                               login              not null,
hm_accion_sgte                           catalogo           null,
hm_preimpreso                            int                null,
hm_tipo_plazo                            catalogo           not null,
hm_tipo_monto                            catalogo           not null,
hm_causa_mod                             catalogo           not null,
hm_descripcion                           varchar(255)       not null,
hm_fecha_valor                           datetime           not null,
hm_fecha_ven                             datetime           not null,
hm_fecha_cancela                         datetime           null,
hm_fecha_ingreso                         datetime           not null,
hm_fecha_pg_int                          datetime           not null,
hm_fecha_ult_pg_int                      datetime           null,
hm_ult_fecha_calculo                     datetime           null,
hm_fecha_crea                            datetime           not null,
hm_fecha_mod                             datetime           null,
hm_fecha_total                           datetime           null,
hm_puntos                                float              not null,
hm_total_int_acumulado                   money              not null,
hm_tasa_mer                              float              not null,
hm_ced_ruc                               varchar(30)        null,
hm_plazo_ant                             smallint           null,
hm_fecven_ant                            datetime           null,
hm_tot_int_est_ant                       money              null,
hm_fecha_ord_act                         datetime           null,
hm_mantiene_stock                        char(1)            null,
hm_stock                                 int                null,
hm_emision_inicial                       int                null,
hm_moneda_pg                             char(2)            null,
hm_impuesto                              float              not null,
hm_num_imp_orig                          tinyint            null,
hm_impuesto_capital                      money              not null,
hm_retiene_imp_capital                   char(1)            not null,
hm_ley                                   char(1)            null,
hm_reestruc                              char(1)            null,
hm_fecha_real                            datetime           null,
hm_ult_fecha_cal_tasa                    datetime           null,
hm_num_dias_gracia                       int                not null,
hm_prorroga_aut                          char(1)            null,
hm_tasa_variable                         char(1)            not null,
hm_mnemonico_tasa                        catalogo           null,
hm_modalidad_tasa                        char(1)            null,
hm_periodo_tasa                          smallint           null,
hm_descr_tasa                            descripcion        null,
hm_operador                              char(1)            null,
hm_spread                                float              null,
hm_estatus_prorroga                      char(1)            null,
hm_num_prorroga                          int                null,
hm_anio_comercial                        char(1)            null,
hm_flag_tasaefec                         char(1)            null,
hm_comision                              money              null,
hm_porc_comision                         float              null,
hm_cupon                                 char(1)            null,
hm_categoria_cupon                       catalogo           null,
hm_custodia                              char(1)            null,
hm_nueva_tasa                            float              null,
hm_incremento_prorroga                   money              null,
hm_puntos_prorroga                       float              null,
hm_scontable                             catalogo           null,
hm_captador                              login              null,
hm_aprobado                              char(1)            null,
hm_bloqueo_legal                         char(1)            null,
hm_monto_blqlegal                        money              null,
hm_ult_fecha_calven                      datetime           null,
hm_prov_pendiente                        float              null,
hm_residuo_prov                          float              null,
hm_int_total_prov_vencida                float              null,
hm_int_prov_vencida                      float              null,
hm_tipo_tasa_var                         char(1)            null,
hm_oficial_principal                     login              null,
hm_oficial_secundario                    login              null,
hm_origen_fondos                         catalogo           null,
hm_proposito_cuenta                      catalogo           null,
hm_producto_bancario1                    catalogo           null,
hm_producto_bancario2                    catalogo           null,
hm_revision_tasa                         char(1)            null,
hm_dias_reales                           char(1)            null,
hm_plazo_orig                            int                null,
hm_sec_incre                             int                null,
hm_renovada                              char(1)            null,
hm_int_ajuste                            float              null,
hm_tasa_ant                              float              null,
hm_cambio_tasa                           char(1)            null,
hm_plazo_cont                            int                null,
hm_incre                                 char(1)            null,
hm_tasa_min                              float              null,
hm_tasa_max                              float              null,
hm_camb_oper                             int                null,
hm_fecha_ult_renov                       datetime           null,
hm_fecha_ult_pago_int_ant                datetime           null,
hm_ente_corresp                          int                null,
hm_contador_firma                        int                null,
hm_condiciones                           smallint           null,
hm_localizado                            char(1)            null,
hm_fecha_localizacion                    smalldatetime      null,
hm_fecha_no_localiza                     smalldatetime      null,
hm_inactivo                              char(1)            null,
hm_dias_hold                             int                null,
hm_sucursal                              smallint           null,
hm_incremento_suspenso                   money              null,
hm_oficina_apertura                      smallint           null,
hm_oficial_apertura                      login              null,
hm_toperacion_apertura                   catalogo           null,
hm_tipo_plazo_apertura                   catalogo           null,
hm_tipo_monto_apertura                   catalogo           null)
go
 
print '-->Tabla: pf_cambio_tasa'
if exists (select 1 from sysobjects where name = 'pf_cambio_tasa' and type = 'U')
   drop table pf_cambio_tasa

create table pf_cambio_tasa(
ct_operacion                             int                not null,
ct_fecha_crea                            datetime           not null,
ct_num_banco                             cuenta             null,
ct_tasa_ant                              float              not null,
ct_tasa_act                              float              not null,
ct_fecha_mod                             datetime           null,
ct_estado                                char(1)            null,
ct_login                                 login              null)
go
 
print '-->Tabla: pf_aux_neg'
if exists (select 1 from sysobjects where name = 'pf_aux_neg' and type = 'U')
   drop table pf_aux_neg

create table pf_aux_neg(
Cuenta                                   cuenta             null,
Tipo_de_DPF                              varchar(100)       null,
Tasa                                     float              null,
Monto                                    money              null,
Puntos                                   float              null,
No_de_DPF                                int                null,
Tasa_Base                                float              null,
Spread                                   float              null,
Titular                                  varchar(100)       null,
Saldo_Disponible                         money              null,
Login_Usuario                            login              null,
Tipo_Operacion                           varchar(50)        null,
Fecha                                    datetime           null,
secuencial                               int                not null)
go
 
print '-->Tabla: pf_tran_servicio'
if exists (select 1 from sysobjects where name = 'pf_tran_servicio' and type = 'U')
   drop table pf_tran_servicio

create table pf_tran_servicio(
ts_fecha                                 datetime           not null,
ts_secuencial                            int                not null,
ts_clase                                 char(1)            not null,
ts_alterno                               alterno            null,
ts_tipo_transaccion                      smallint           not null,
ts_usuario                               login              not null,
ts_terminal                              descripcion        not null,
ts_sesn                                  int                null,
ts_srv                                   varchar(30)        null,
ts_lsrv                                  varchar(30)        null,
ts_ofi                                   smallint            null,
ts_correccion                            char(1)            null,
ts_ssn_corr                              int                null,
ts_tabla                                 tinyint            null,
ts_cuenta_01                             cuenta             null,
ts_cuenta_02                             cuenta             null,
ts_numero                                numero             null,
ts_catalogo_01                           catalogo           null,
ts_catalogo_02                           catalogo           null,
ts_catalogo_03                           catalogo           null,
ts_catalogo_04                           catalogo           null,
ts_catalogo_05                           catalogo           null,
ts_catalogo_06                           catalogo           null,
ts_catalogo_07                           catalogo           null,
ts_catalogo_08                           catalogo           null,
ts_catalogo_09                           catalogo           null,
ts_login_01                              login              null,
ts_login_02                              login              null,
ts_descripcion_01                        descripcion        null,
ts_tinyint_01                            tinyint            null,
ts_tinyint_02                            tinyint            null,
ts_tinyint_03                            tinyint            null,
ts_tinyint_04                            tinyint            null,
ts_tinyint_05                            tinyint            null,
ts_tinyint_06                            tinyint            null,
ts_tinyint_07                            tinyint            null,
ts_int_01                                int                null,
ts_int_02                                int                null,
ts_int_03                                int                null,
ts_int_04                                int                null,
ts_int_05                                int                null,
ts_smallint_01                           smallint           null,
ts_smallint_02                           smallint           null,
ts_smallint_03                           smallint           null,
ts_smallint_04                           smallint           null,
ts_smallint_05                           smallint           null,
ts_smallint_06                           smallint           null,
ts_smallint_07                           smallint           null,
ts_smallint_08                           smallint           null,
ts_datetime_01                           datetime           null,
ts_datetime_02                           datetime           null,
ts_datetime_03                           datetime           null,
ts_datetime_04                           datetime           null,
ts_datetime_05                           datetime           null,
ts_datetime_06                           datetime           null,
ts_datetime_07                           datetime           null,
ts_datetime_08                           datetime           null,
ts_float_01                              float              null,
ts_float_02                              float              null,
ts_float_03                              float              null,
ts_float_04                              float              null,
ts_float_05                              float              null,
ts_float_06                              float              null,
ts_money_01                              money              null,
ts_money_02                              money              null,
ts_money_03                              money              null,
ts_money_04                              money              null,
ts_money_05                              money              null,
ts_money_06                              money              null,
ts_money_07                              money              null,
ts_money_08                              money              null,
ts_money_09                              money              null,
ts_money_10                              money              null,
ts_money_11                              money              null,
ts_money_12                              money              null,
ts_money_13                              money              null,
ts_money_14                              money              null,
ts_char1_01                              char(1)            null,
ts_char1_02                              char(1)            null,
ts_char1_03                              char(1)            null,
ts_char1_04                              char(1)            null,
ts_char1_05                              char(1)            null,
ts_char1_06                              char(1)            null,
ts_char1_07                              char(1)            null,
ts_char1_08                              char(1)            null,
ts_char1_09                              char(1)            null,
ts_char1_10                              char(1)            null,
ts_char1_11                              char(1)            null,
ts_char3_01                              char(3)            null,
ts_varchar255_01                         varchar(255)       null,
ts_varchar30_01                          varchar(30)        null,
ts_varchar4_01                           varchar(4)         null,
ts_varchar3_01                           varchar(3)         null,
ts_varchar5_01                           varchar(4)         null,
ts_char1_12                              char(1)            null)
go
 
print '-->Tabla: pf_fraccion_cdt'
if exists (select 1 from sysobjects where name = 'pf_fraccion_cdt' and type = 'U')
   drop table pf_fraccion_cdt

create table pf_fraccion_cdt(
CDT_PADRE                                varchar(24)        null,
GMF                                      money              null,
FECHA_FRACCION                           varchar(11)        null,
BENEF_PADRE1                             int                null,
NOMBRE_PADRE1                            varchar(100)       null,
DOC_PADRE1                               varchar(20)        null,
BENEF_PADRE2                             int                null,
NOMBRE_PADRE2                            varchar(100)       null,
DOC_PADRE2                               varchar(20)        null,
BENEF_PADRE3                             int                null,
NOMBRE_PADRE3                            varchar(100)       null,
DOC_PADRE3                               varchar(20)        null,
MONTO_PADRE                              money              null,
CDT_HIJO                                 varchar(24)        null,
MONTO_HIJO                               money              null,
BENEF_HIJO1                              int                null,
NOMBRE_HIJO1                             varchar(50)        null,
DOC_HIJO1                                varchar(20)        null,
BENEF_HIJO2                              int                null,
NOMBRE_HIJO2                             varchar(50)        null,
DOC_HIJO2                                varchar(20)        null,
BENEF_HIJO3                              int                null,
NOMBRE_HIJO3                             varchar(50)        null,
DOC_HIJO3                                varchar(20)        null)
go
 
print '-->Tabla: pf_archivo_dcv_z'
if exists (select 1 from sysobjects where name = 'pf_archivo_dcv_z' and type = 'U')
   drop table pf_archivo_dcv_z

create table pf_archivo_dcv_z(
dz_valor_nominal                         numeric(18,0)      null,
dz_ag_colocador                          varchar(4)         null,
dz_ag_comprador                          varchar(4)         null,
dz_forma_pago                            char(1)            null,
dz_valor_comprar                         numeric(18,0)      null,
dz_sebra_compra                          varchar(20)        null,
dz_isin                                  varchar(12)        null,
dz_fungible                              varchar(10)        null,
dz_cta_inver                             varchar(8)         null,
dz_tipo_doc                              catalogo           null,
dz_num_doc                               varchar(20)        null,
dz_relacion                              char(1)            null,
dz_estado                                char(1)            null,
dz_op_deceval                            varchar(15)        null,
dz_operacion                             varchar(120)       null)
go
 
print '-->Tabla: tmp_bloqueocdt'
if exists (select 1 from sysobjects where name = 'tmp_bloqueocdt' and type = 'U')
   drop table tmp_bloqueocdt

create table tmp_bloqueocdt(
cadena                                   varchar(2000)      not null)
go
 
print '-->Tabla: pf_desbloqueo_tmp'
if exists (select 1 from sysobjects where name = 'pf_desbloqueo_tmp' and type = 'U')
   drop table pf_desbloqueo_tmp

create table pf_desbloqueo_tmp(
de_operacion                             varchar(15)        null,
de_cedula                                varchar(15)        null)
go
 
print '-->Tabla: pf_desbloqueo_tmp2'
if exists (select 1 from sysobjects where name = 'pf_desbloqueo_tmp2' and type = 'U')
   drop table pf_desbloqueo_tmp2

create table pf_desbloqueo_tmp2(
det_fecha                                datetime           null,
det_operacion                            varchar(15)        null,
det_cedula                               varchar(15)        null,
det_observacion                          varchar(60)        null,
det_estado                               char(1)            null)
go
 
print '-->Tabla: reporte_desbloqueo'
if exists (select 1 from sysobjects where name = 'reporte_desbloqueo' and type = 'U')
   drop table reporte_desbloqueo

create table reporte_desbloqueo(
cadena                                   varchar(2000)      not null)
go
 
print '-->Tabla: tiempo'
if exists (select 1 from sysobjects where name = 'tiempo' and type = 'U')
   drop table tiempo

create table tiempo(
Batch                                    smallint           null,
Consecutivo                              int                null,
Texto                                    nvarchar(300)      null,
FechaHora                                datetime           null)
go
 
print '-->Tabla: pf_enajenacion'
if exists (select 1 from sysobjects where name = 'pf_enajenacion' and type = 'U')
   drop table pf_enajenacion

create table pf_enajenacion(
en_operacion                             int                not null,
en_secuencial                            int                not null,
en_fecha                                 datetime           not null,
en_ente                                  int                not null,
en_valor_enajenado                       money              not null,
en_descripcion                           varchar(100)       null,
en_usuario                               login              null,
en_oficina                               smallint           null)
go
 
print '-->Tabla: pf_envios_dcv'
if exists (select 1 from sysobjects where name = 'pf_envios_dcv' and type = 'U')
   drop table pf_envios_dcv

create table pf_envios_dcv(
ed_archivo                               descripcion        not null,
ed_fecha                                 datetime           not null,
ed_secuencial                            int                not null,
ed_estado                                char(1)            not null,
ed_tot_op                                int                not null,
ed_tot_apr                               int                null,
ed_tot_rec                               int                null,
ed_archivo_out                           descripcion        null)
go
 
print '-->Tabla: pf_fpago'
if exists (select 1 from sysobjects where name = 'pf_fpago' and type = 'U')
   drop table pf_fpago

create table pf_fpago(
fp_tipo_fpago                            int                not null,
fp_mnemonico                             catalogo           not null,
fp_descripcion                           varchar(30)        not null,
fp_ttransito                             smallint           not null,
fp_automatico                            char(1)            not null,
fp_fecha_crea                            datetime           not null,
fp_fecha_modi                            datetime           not null,
fp_estado                                char(1)            not null,
fp_producto                              tinyint            null,
fp_area_contable                         int                null,
fp_compensa                              char(1)            null,
fp_pago_recep                            catalogo           not null,
fp_exonera_gmf                           char(1)            null)
go
 
print '-->Tabla: pf_det_envios_dcv'
if exists (select 1 from sysobjects where name = 'pf_det_envios_dcv' and type = 'U')
   drop table pf_det_envios_dcv

create table pf_det_envios_dcv(
de_archivo                               descripcion        not null,
de_fecha                                 datetime           not null,
de_operacion                             int                not null,
de_op_deceval                            cuenta             null,
de_observacion                           descripcion        null,
de_fungible                              varchar(10)        null,
de_estado                                catalogo           not null,
de_isin                                  varchar(12)        null)
go
 
print '-->Tabla: pf_compensa_ope'
if exists (select 1 from sysobjects where name = 'pf_compensa_ope' and type = 'U')
   drop table pf_compensa_ope

create table pf_compensa_ope(
co_num_banco                             cuenta             not null,
co_operacion                             int                not null,
co_ente                                  int                not null,
co_toperacion                            catalogo           not null,
co_tipo_plazo                            catalogo           null)
go
 
print '-->Tabla: pf_archivo_deceval'
if exists (select 1 from sysobjects where name = 'pf_archivo_deceval' and type = 'U')
   drop table pf_archivo_deceval

create table pf_archivo_deceval(
ad_registro                              varchar(800)       null)
go
 
print '-->Tabla: pf_compensa_mov'
if exists (select 1 from sysobjects where name = 'pf_compensa_mov' and type = 'U')
   drop table pf_compensa_mov

create table pf_compensa_mov(
cm_operacion                             int                not null,
cm_tran                                  int                not null,
cm_secuencia                             int                not null,
cm_secuencial                            int                not null,
cm_sub_secuencia                         tinyint            not null,
cm_fecha_aplicacion                      datetime           null,
cm_producto                              catalogo           not null,
cm_cuenta                                cuenta             null,
cm_valor                                 money              not null,
cm_estado                                char(1)            null,
cm_tipo                                  char(1)            not null,
cm_beneficiario                          int                null,
cm_impuesto                              money              null,
cm_moneda                                smallint           null,
cm_valor_ext                             money              null,
cm_fecha_crea                            datetime           not null,
cm_fecha_mod                             datetime           null,
cm_oficina                               int                null,
cm_impuesto_capital_me                   money              null,
cm_fecha_real                            datetime           null,
cm_secuencia_emis_che                    int                null,
cm_user                                  login              null,
cm_tipo_cliente                          char(1)            null,
cm_autorizado                            char(1)            null,
cm_cotizacion                            money              null,
cm_tipo_cotiza                           char(1)            null)
go
 
print '-->Tabla: pf_feriados_oficina'
if exists (select 1 from sysobjects where name = 'pf_feriados_oficina' and type = 'U')
   drop table pf_feriados_oficina

create table pf_feriados_oficina(
fo_tipo_deposito                         int                not null,
fo_moneda                                int                not null,
fo_oficina                               int                not null,
fo_cod_dia                               varchar(2)         null,
fo_estado                                char(1)            not null,
fo_fecha_modificacion                    datetime           null,
fo_usuario                               login              null)
go
 
print '-->Tabla: pf_funcionario'
if exists (select 1 from sysobjects where name = 'pf_funcionario' and type = 'U')
   drop table pf_funcionario

create table pf_funcionario(
fu_secuencial                            int                not null,
fu_funcionario                           login              not null,
fu_tautorizacion                         catalogo           not null,
fu_estado                                char(1)            not null,
fu_fecha_crea                            datetime           not null,
fu_fecha_elim                            datetime           null,
fu_func_relacionado                      login              null)
go
 
print '-->Tabla: pf_auxtip_ofi'
if exists (select 1 from sysobjects where name = 'pf_auxtip_ofi' and type = 'U')
   drop table pf_auxtip_ofi

create table pf_auxtip_ofi(
desc_moneda                              varchar(30)        null,
descripcion                              varchar(30)        null,
moneda                                   varchar(2)         null,
valor                                    catalogo           null,
cod_dia                                  varchar(2)         null)
go
 
print '-->Tabla: pf_transaccion'
if exists (select 1 from sysobjects where name = 'pf_transaccion' and type = 'U')
   drop table pf_transaccion

create table pf_transaccion(
tr_operacion                             int                not null,
tr_secuencial                            int                not null,
tr_banco                                 cuenta             not null,
tr_fecha_mov                             datetime           not null,
tr_fecha_ref                             datetime           not null,
tr_ofi_usu                               smallint           null,
tr_ofi_oper                              smallint           null,
tr_tran                                  int                not null,
tr_tipo_trn                              catalogo           not null,
tr_reverso                               char(1)            not null,
tr_secuencia                             int                null,
tr_comprobante                           int                null,
tr_fecha_cont                            datetime           null,
tr_usuario                               login              null,
tr_terminal                              varchar(15)        null,
tr_estado                                varchar(3)         not null,
tr_descripcion                           descripcion        null,
tr_fecha_real                            datetime           not null)
go
 
print '-->Tabla: pf_fusfra'
if exists (select 1 from sysobjects where name = 'pf_fusfra' and type = 'U')
   drop table pf_fusfra

create table pf_fusfra(
fu_operacion                             int                not null,
fu_secuencial                            int                not null,
fu_tasa                                  float              not null,
fu_plazo                                 smallint           not null,
fu_fecha_valor                           datetime           null,
fu_oficial_apertura                      login              not null,
fu_oficial_fusion                        login              not null,
fu_estado                                catalogo           null,
fu_estado_ant                            catalogo           null,
fu_renova_todo                           char(1)            null,
fu_monto                                 money              not null,
fu_monto_pg_int                          money              not null,
fu_monto_fusionar                        money              null,
fu_fecha_crea                            datetime           not null,
fu_fecha_mod                             datetime           null,
fu_descripcion                           varchar(255)       not null,
fu_operacion_new                         int                null,
fu_impuesto                              float              null,
fu_tot_int_ganado                        money              null,
fu_tot_int_pagados                       money              null,
fu_tot_int_retenido                      money              null,
fu_tot_int_acumulado                     money              null,
fu_mnemonico                             char(5)            null,
fu_moneda_pg                             char(2)            null,
fu_oficina_apertura                      smallint           null,
fu_oficina_fusion                        smallint           null,
fu_preimpreso                            int                null,
fu_toperacion                            catalogo           null,
fu_nomlar                                varchar(96)        null)
go
 
print '-->Tabla: pf_transaccion_det'
if exists (select 1 from sysobjects where name = 'pf_transaccion_det' and type = 'U')
   drop table pf_transaccion_det

create table pf_transaccion_det(
td_operacion                             int                not null,
td_secuencial                            int                not null,
td_concepto                              catalogo           not null,
td_codvalor                              int                not null,
td_moneda                                tinyint            not null,
td_aux                                   varchar(30)        null,
td_monto                                 money              not null)
go
 
print '-->Tabla: pf_firmas_autorizadas_tmp'
if exists (select 1 from sysobjects where name = 'pf_firmas_autorizadas_tmp' and type = 'U')
   drop table pf_firmas_autorizadas_tmp

create table pf_firmas_autorizadas_tmp(
ft_usuario                               login              null,
ft_sesion                                int                not null,
ft_operacion                             int                not null,
ft_ente                                  int                not null,
ft_estado                                char(1)            not null,
ft_fecha_crea                            datetime           not null,
ft_fecha_mod                             datetime           null,
ft_ced_ruc                               numero             null,
ft_rol                                   catalogo           null)
go
 
print '-->Tabla: pf_plazo_contable'
if exists (select 1 from sysobjects where name = 'pf_plazo_contable' and type = 'U')
   drop table pf_plazo_contable

create table pf_plazo_contable(
pc_plazo_cont                            catalogo           not null,
pc_plazo_min                             int                not null,
pc_plazo_max                             int                not null,
pc_descripcion                           descripcion        not null)
go
 
print '-->Tabla: pf_firmas_autorizadas'
if exists (select 1 from sysobjects where name = 'pf_firmas_autorizadas' and type = 'U')
   drop table pf_firmas_autorizadas

create table pf_firmas_autorizadas(
fi_operacion                             int                not null,
fi_ente                                  int                not null,
fi_estado                                char(1)            not null,
fi_fecha_crea                            datetime           not null,
fi_fecha_mod                             datetime           null,
fi_ced_ruc                               numero             null,
fi_rol                                   catalogo           null)
go
 
print '-->Tabla: pf_secuenciales'
if exists (select 1 from sysobjects where name = 'pf_secuenciales' and type = 'U')
   drop table pf_secuenciales

create table pf_secuenciales(
se_operacion                             int                not null,
se_secuencial                            int                not null)
go
 
print '-->Tabla: pf_condfirmas'
if exists (select 1 from sysobjects where name = 'pf_condfirmas' and type = 'U')
   drop table pf_condfirmas

create table pf_condfirmas(
cf_operacion                             int                not null,
cf_condicion                             tinyint            not null,
cf_fecha_crea                            datetime           not null,
cf_estado                                char(1)            not null,
cf_fecha_mod                             datetime           null)
go
 
print '-->Tabla: pf_equivalencias'
if exists (select 1 from sysobjects where name = 'pf_equivalencias' and type = 'U')
   drop table pf_equivalencias

create table pf_equivalencias(
eq_modulo                                tinyint            not null,
eq_tabla                                 catalogo           null,
eq_val_pfijo                             catalogo           null,
eq_val_pfi_ini                           descripcion        null,
eq_val_pfi_fin                           descripcion        null,
eq_val_interfaz                          catalogo           null,
eq_descripcion                           descripcion        null)
go
 
print '-->Tabla: pf_condfirmas_tmp'
if exists (select 1 from sysobjects where name = 'pf_condfirmas_tmp' and type = 'U')
   drop table pf_condfirmas_tmp

create table pf_condfirmas_tmp(
ci_usuario                               login              null,
ci_sesion                                int                not null,
ci_operacion                             int                not null,
ci_condicion                             tinyint            not null,
ci_fecha_crea                            datetime           not null,
ci_fecha_mod                             datetime           null)
go
 
print '-->Tabla: pf_det_condfirmas'
if exists (select 1 from sysobjects where name = 'pf_det_condfirmas' and type = 'U')
   drop table pf_det_condfirmas

create table pf_det_condfirmas(
df_operacion                             int                not null,
df_condicion                             tinyint            not null,
df_ente                                  int                not null,
df_estado                                char(1)            not null,
df_descondi                              char(1)            not null,
df_fecha_crea                            datetime           not null,
df_fecha_mod                             datetime           null)
go
 
print '-->Tabla: pf_det_condfirmas_tmp'
if exists (select 1 from sysobjects where name = 'pf_det_condfirmas_tmp' and type = 'U')
   drop table pf_det_condfirmas_tmp

create table pf_det_condfirmas_tmp(
di_usuario                               login              null,
di_sesion                                int                not null,
di_operacion                             int                not null,
di_condicion                             tinyint            not null,
di_ente                                  int                not null,
di_descondi                              char(1)            not null,
di_fecha_crea                            datetime           not null,
di_fecha_mod                             datetime           null)
go
 
print '-->Tabla: pf_nueva_renovacion'
if exists (select 1 from sysobjects where name = 'pf_nueva_renovacion' and type = 'U')
   drop table pf_nueva_renovacion

create table pf_nueva_renovacion(
re_operacion                             int                not null,
re_num_banco                             cuenta             not null,
re_valor_renovado                        money              not null,
re_valor_utilizado                       money              not null,
re_estado                                char(1)            null,
re_oficina                               smallint           not null,
re_moneda                                tinyint            not null,
re_flag                                  char(1)            null)
go
 
print '-->Tabla: pf_autorizacion'
if exists (select 1 from sysobjects where name = 'pf_autorizacion' and type = 'U')
   drop table pf_autorizacion

create table pf_autorizacion(
au_operacion                             int                not null,
au_autoriza                              login              not null,
au_adicional                             float              null,
au_oficina                               smallint           not null,
au_tautorizacion                         catalogo           not null,
au_fecha_crea                            datetime           not null,
au_num_banco                             cuenta             null,
au_oficial                               login              not null,
au_spread                                float              null,
au_tasa_base                             float              null,
au_tasa                                  float              null,
au_secuencial                            int                null)
go
 
print '-->Tabla: pf_det_pago'
if exists (select 1 from sysobjects where name = 'pf_det_pago' and type = 'U')
   drop table pf_det_pago

create table pf_det_pago(
dp_operacion                             int                not null,
dp_secuencia                             int                not null,
dp_ente                                  int                not null,
dp_forma_pago                            catalogo           not null,
dp_cuenta                                cuenta             null,
dp_tipo                                  catalogo           not null,
dp_monto                                 money              null,
dp_porcentaje                            float              null,
dp_estado_xren                           char(1)            not null,
dp_estado                                char(1)            not null,
dp_fecha_crea                            datetime           not null,
dp_fecha_mod                             datetime           null,
dp_moneda_pago                           smallint           null,
dp_descripcion                           varchar(255)       null,
dp_oficina                               int                null,
dp_tipo_cliente                          char(1)            null,
dp_benef_chq                             varchar(255)       null,
dp_secuencial                            int                null,
dp_tipo_cuenta_ach                       char(1)            null,
dp_banco_ach                             descripcion        null,
dp_cod_banco_ach                         smallint           null)
go
 
print '-->Tabla: pf_beneficiario'
if exists (select 1 from sysobjects where name = 'pf_beneficiario' and type = 'U')
   drop table pf_beneficiario

create table pf_beneficiario(
be_operacion                             int                not null,
be_ente                                  int                not null,
be_rol                                   catalogo           not null,
be_fecha_crea                            datetime           not null,
be_fecha_mod                             datetime           null,
be_estado_xren                           char(1)            not null,
be_estado                                char(1)            not null,
be_ced_ruc                               cuenta             null,
be_tipo                                  char(1)            null,
be_condicion                             char(1)            null,
be_secuencia                             smallint           null)
go
 
print '-->Tabla: pf_cancelacion_tmp'
if exists (select 1 from sysobjects where name = 'pf_cancelacion_tmp' and type = 'U')
   drop table pf_cancelacion_tmp

create table pf_cancelacion_tmp(
cn_operacion                             int                not null,
cn_tsecuencial                           int                not null,
cn_secpin                                int                null,
cn_funcionario                           login              not null,
cn_oficina                               smallint           not null,
cn_pen_monto                             money              null,
cn_pen_porce                             float              null,
cn_solicitante                           int                not null,
cn_tipo                                  char(1)            not null,
cn_estado                                char(1)            not null,
cn_fpago                                 catalogo           not null,
cn_fecha_ven                             datetime           not null,
cn_fecha_pg_int                          datetime           not null,
cn_accion_sgte                           catalogo           null,
cn_estado_op                             catalogo           not null,
cn_autorizado                            login              null,
cn_comentario                            varchar(60)        null,
cn_valor                                 money              not null,
cn_fecha_crea                            datetime           not null,
cn_monto_pg_int                          money              not null,
cn_int_ganado                            money              not null,
cn_int_pagados                           money              not null,
cn_int_vencido                           money              null,
cn_total_int_pagados                     money              not null,
cn_fecha_ult_pg_int                      datetime           not null,
cn_fecha_mod                             datetime           null,
cn_oficina_ant                           smallint           null,
cn_usuario                               login              not null,
cn_sesion                                int                not null)
go
 
print '-->Tabla: pf_cancelacion'
if exists (select 1 from sysobjects where name = 'pf_cancelacion' and type = 'U')
   drop table pf_cancelacion

create table pf_cancelacion(
ca_operacion                             int                not null,
ca_secuencial                            int                not null,
ca_secpin                                int                null,
ca_funcionario                           login              not null,
ca_oficina                               smallint           not null,
ca_pen_monto                             money              null,
ca_pen_porce                             float              null,
ca_solicitante                           int                not null,
ca_tipo                                  char(1)            not null,
ca_estado                                char(1)            not null,
ca_fpago                                 catalogo           not null,
ca_fecha_ven                             datetime           not null,
ca_fecha_pg_int                          datetime           not null,
ca_accion_sgte                           catalogo           null,
ca_estado_op                             catalogo           not null,
ca_autorizado                            login              null,
ca_comentario                            varchar(60)        null,
ca_valor                                 money              not null,
ca_fecha_crea                            datetime           not null,
ca_monto_pg_int                          money              not null,
ca_int_ganado                            money              not null,
ca_int_pagados                           money              not null,
ca_int_vencido                           money              null,
ca_total_int_pagados                     money              not null,
ca_fecha_ult_pg_int                      datetime           not null,
ca_fecha_mod                             datetime           null,
ca_oficina_ant                           smallint           null,
ca_pen_capital                           money              null,
ca_pen_cap_porce                         float              null)
go
 
print '-->Tabla: pf_cuotas'
if exists (select 1 from sysobjects where name = 'pf_cuotas' and type = 'U')
   drop table pf_cuotas

create table pf_cuotas(
cu_ente                                  int                not null,
cu_operacion                             int                not null,
cu_cuota                                 tinyint            not null,
cu_fecha_pago                            datetime           not null,
cu_valor_cuota                           money              not null,
cu_retencion                             money              null,
cu_capital                               money              null,
cu_fecha_crea                            datetime           not null,
cu_moneda                                tinyint            not null,
cu_oficina                               smallint           not null,
cu_fecha_caja                            datetime           null,
cu_num_cupon                             cuenta             null,
cu_num_impr_orig                         tinyint            null,
cu_estado                                catalogo           not null,
cu_preimpreso                            int                null,
cu_fecha_mod                             datetime           null,
cu_valor_neto                            money              not null,
cu_retenido                              char(1)            not null,
cu_forma_pago                            catalogo           null,
cu_custodia                              char(1)            null,
cu_estado_ant                            catalogo           null,
cu_fecha_ult_pago                        datetime           null,
cu_num_dias                              int                null,
cu_tasa                                  float              null,
cu_ppago                                 catalogo           null,
cu_base_calculo                          smallint           null)
go
 
print '-->Tabla: pf_tipo_deposito'
if exists (select 1 from sysobjects where name = 'pf_tipo_deposito' and type = 'U')
   drop table pf_tipo_deposito

create table pf_tipo_deposito(
td_tipo_deposito                         int                not null,
td_mnemonico                             varchar(5)         not null,
td_descripcion                           varchar(30)        not null,
td_forma_pago                            catalogo           not null,
td_capitalizacion                        catalogo           not null,
td_dias_reverso                          tinyint            not null,
td_base_calculo                          catalogo           not null,
td_estado                                char(1)            not null,
td_fecha_crea                            datetime           not null,
td_fecha_mod                             datetime           not null,
td_mantiene_stock                        char(1)            null,
td_stock                                 int                null,
td_emision_inicial                       int                null,
td_anio_comercial                        char(1)            null,
td_num_dias_gracia                       int                null,
td_dias_gracia                           char(1)            null,
td_prorroga_aut                          char(1)            null,
td_num_prorrogas                         int                null,
td_tasa_variable                         char(1)            null,
td_tasa_efectiva                         char(1)            null,
td_retiene_impto                         char(1)            not null,
td_tran_sabado                           char(1)            not null,
td_paga_comision                         char(1)            null,
td_cupon                                 char(1)            not null,
td_cambio_tasa                           char(1)            not null,
td_incr_decr                             char(1)            not null,
td_area_contable                         int                not null,
td_tipo_persona                          catalogo           not null,
td_tipo_tasa_var                         char(1)            null,
td_dias_reales                           char(1)            null,
td_tipo_banca                            catalogo           null,
td_desmaterializa                        char(1)            null,
td_num_serie                             varchar(12)        null,
td_periodo_tasa                          smallint           null,     
td_tasa_precancela                       char(1)            null,
td_encaje_legal                          char(1)            null)
go
 
print '-->Tabla: pf_beneficiario_tmp'
if exists (select 1 from sysobjects where name = 'pf_beneficiario_tmp' and type = 'U')
   drop table pf_beneficiario_tmp

create table pf_beneficiario_tmp(
bt_operacion                             int                not null,
bt_usuario                               login              not null,
bt_sesion                                int                not null,
bt_ente                                  int                not null,
bt_rol                                   catalogo           not null,
bt_fecha_crea                            datetime           not null,
bt_fecha_mod                             datetime           null,
bt_tipo                                  char(1)            null,
bt_condicion                             char(1)            null,
bt_secuencia                             smallint           null,
bt_imprime                               char(1)            null)
go
 
print '-->Tabla: pf_cliente_externo'
if exists (select 1 from sysobjects where name = 'pf_cliente_externo' and type = 'U')
   drop table pf_cliente_externo

create table pf_cliente_externo(
ce_secuencial                            int                not null,
ce_nombre                                varchar(100)       not null,
ce_cedula                                numero             null,
ce_direccion                             varchar(100)       null)
go
 
print '-->Tabla: pf_cliente_externo_tmp'
if exists (select 1 from sysobjects where name = 'pf_cliente_externo_tmp' and type = 'U')
   drop table pf_cliente_externo_tmp

create table pf_cliente_externo_tmp(
ct_usuario                               login              not null,
ct_sesion                                int                not null,
ct_secuencial                            int                not null,
ct_nombre                                varchar(100)       not null,
ct_cedula                                numero             null,
ct_direccion                             varchar(100)       null)
go
 
print '-->Tabla: pf_det_pago_tmp'
if exists (select 1 from sysobjects where name = 'pf_det_pago_tmp' and type = 'U')
   drop table pf_det_pago_tmp

create table pf_det_pago_tmp(
dt_operacion                             int                not null,
dt_usuario                               login              not null,
dt_sesion                                int                not null,
dt_beneficiario                          int                not null,
dt_tipo                                  catalogo           not null,
dt_forma_pago                            catalogo           not null,
dt_cuenta                                cuenta             null,
dt_monto                                 money              null,
dt_porcentaje                            float              null,
dt_fecha_crea                            datetime           not null,
dt_fecha_mod                             datetime           null,
dt_moneda_pago                           smallint           null,
dt_descripcion                           varchar(255)       null,
dt_oficina                               int                null,
dt_tipo_cliente                          char(1)            null,
dt_benef_chq                             varchar(64)        null,
dt_secuencia                             int                null,
dt_tipo_cuenta_ach                       char(1)            null,
dt_banco_ach                             descripcion        null,
dt_cod_banco_ach                         smallint           null)
go
 
print '-->Tabla: pf_det_cheque_tmp'
if exists (select 1 from sysobjects where name = 'pf_det_cheque_tmp' and type = 'U')
   drop table pf_det_cheque_tmp

create table pf_det_cheque_tmp(
ct_operacion                             int                not null,
ct_secuencial                            int                not null,
ct_secuencia                             int                null,
ct_subsecuencia                          int                null,
ct_usuario                               login              not null,
ct_sesion                                int                not null,
ct_banco                                 catalogo           null,
ct_cuenta                                cuenta             null,
ct_cheque                                int                null,
ct_descripcion                           varchar(255)       null,
ct_valor                                 money              not null,
ct_fecha_crea                            datetime           not null,
ct_fecha_mod                             datetime           null,
ct_nombre_banco                          descripcion        null,
ct_benef_chq                             varchar(64)        null)
go
 
print '-->Tabla: pf_condicion'
if exists (select 1 from sysobjects where name = 'pf_condicion' and type = 'U')
   drop table pf_condicion

create table pf_condicion(
cd_operacion                             int                not null,
cd_condicion                             tinyint            not null,
cd_comentario                            varchar(60)        null,
cd_fecha_crea                            datetime           not null,
cd_estado_xren                           char(1)            not null,
cd_estado                                char(1)            not null,
cd_fecha_mod                             datetime           null)
go
 
print '-->Tabla: pf_condicion_tmp'
if exists (select 1 from sysobjects where name = 'pf_condicion_tmp' and type = 'U')
   drop table pf_condicion_tmp

create table pf_condicion_tmp(
ct_usuario                               login              null,
ct_sesion                                int                not null,
ct_operacion                             int                not null,
ct_condicion                             tinyint            not null,
ct_comentario                            varchar(60)        null,
ct_fecha_crea                            datetime           not null,
ct_fecha_mod                             datetime           null)
go
 
print '-->Tabla: pf_maestro_aux'
if exists (select 1 from sysobjects where name = 'pf_maestro_aux' and type = 'U')
   drop table pf_maestro_aux

create table pf_maestro_aux(
mp_fecha                                 datetime           null,
mp_territorial                           descripcion        null,
mp_zona                                  descripcion        null,
mp_tran                                  descripcion        null,
mp_num_banco                             cuenta             null,
mp_titular                               varchar(254)       null,
mp_tipo_ente                             catalogo           null,
mp_tipo_id                               catalogo           null,
mp_ced_ruc                               varchar(40)        null,
mp_monto                                 money              null,
mp_desc_tipo_tasa                        descripcion        null,
mp_mnemonico_tasa                        descripcion        null,
mp_periodo_pago                          descripcion        null,
mp_spread                                descripcion        null,
mp_base_calculo                          smallint           null,
mp_fecha_valor                           datetime           null,
mp_tasa_efectiva                         float              null,
mp_fecha_ven                             datetime           null,
mp_estado                                descripcion        null,
mp_toperacion                            descripcion        null,
mp_total_int_ganados                     money              null,
mp_total_int_pagados                     money              null,
mp_oficina                               int                null,
mp_desc_oficina                          descripcion        null,
mp_oficina_cap                           int                null,
mp_ente                                  int                null,
mp_dias_reales                           descripcion        null,
mp_tasa                                  float              null,
mp_fecha_cont_ing                        datetime           null,
mp_es_fecha_valor                        varchar(5)         null,
mp_fecha_ingreso                         datetime           null,
mp_fecha_cancela                         datetime           null,
mp_num_dias                              int                null,
mp_num_prorroga                          int                null,
mp_renovaciones                          int                null,
mp_retenido                              char(5)            null,
mp_bloqueo_legal                         char(5)            null,
mp_fpago                                 descripcion        null,
mp_int_ganado                            money              null,
mp_int_pagados                           money              null,
mp_int_estimado                          money              null,
mp_total_int_estimado                    money              null,
mp_captador                              varchar(40)        null,
mp_tipo_cia                              varchar(10)        null,
mp_desmaterializado                      varchar(10)        null,
mp_isin                                  varchar(50)        null,
mp_tipo_compania                         varchar(10)        null,
mp_dia_pago                              int                null,
mp_puntos                                varchar(10)        null,
mp_tasa_mer                              float              null)
go
 
print '-->Tabla: pf_conversion'
if exists (select 1 from sysobjects where name = 'pf_conversion' and type = 'U')
   drop table pf_conversion

create table pf_conversion(
cv_oficina                               smallint           not null,
cv_codigo_ofi                            catalogo           not null,
cv_operacion                             int                not null,
cv_linea                                 int                not null,
cv_toperacion                            catalogo           not null,
cv_moneda                                smallint           not null)
go
 
print '-->Tabla: pf_maestro'
if exists (select 1 from sysobjects where name = 'pf_maestro' and type = 'U')
   drop table pf_maestro

create table pf_maestro(
Fecha_Reporte                            descripcion        null,
Territorial                              descripcion        null,
Zona                                     descripcion        null,
Transaccion                              descripcion        null,
Num_Deposito                             cuenta             null,
Titular                                  varchar(254)       null,
Tipo_Cliente                             catalogo           null,
Tipo_id                                  catalogo           null,
Num_Id                                   varchar(40)        null,
Valor_Nominal                            money              null,
Tipo_Tasa                                descripcion        null,
Nemonico_tasa                            descripcion        null,
Periodo_pago                             descripcion        null,
Spread                                   descripcion        null,
Base_calculo                             smallint           null,
Fecha_apertura                           descripcion        null,
Tasa_efectiva                            descripcion        null,
Fecha_vencimiento                        descripcion        null,
Estado                                   descripcion        null,
Tipo_Producto                            descripcion        null,
Total_int_ganados                        money              null,
Total_int_pagados                        money              null,
Cod_oficina_captadora                    int                null,
Desc_oficina                             descripcion        null,
Oficina_Recaudadora                      int                null,
Codigo_cliente                           int                null,
Dias_reales                              descripcion        null,
Tasa                                     descripcion        null,
Fecha_cont_ing                           descripcion        null,
Fecha_valor                              varchar(5)         null,
Fecha_ingreso                            descripcion        null,
Fecha_cancela                            descripcion        null,
Plazo                                    int                null,
Num_prorroga                             int                null,
Num_renovaciones                         int                null,
Bloqueado                                char(5)            null,
Bloqueo_legal                            char(5)            null,
Forma_pago                               descripcion        null,
Int_ganado                               money              null,
Int_pagados                              money              null,
Int_estimado                             money              null,
Total_int_estimado                       money              null,
Captador                                 varchar(40)        null,
Tipo_compania                            varchar(10)        null,
Desmaterializado                         varchar(10)        null,
Isin                                     varchar(50)        null,
Tipo_Compania                            varchar(10)        null,
mp_dia_pago                              int                null,
mp_puntos                                varchar(10)        null,
mp_tasa_mer                              float              null,
Cantidad_Traslados                       smallint           null,
Oficina_Origen                           int                null,
Oficina_Destino                          int                null,
Tipo_Traslado                            varchar(64)        null,
Estado_Ope_Traslado                      varchar(64)        null,
Monto_Ope_Traslado                       money              null,
Usuario_Solicitud                        login              null,
Oficina_Solicitud                        int                null,
Fecha_Solicitud                          datetime           null,
Estado_Traslado                          varchar(64)        null,
Usuario_Autorizador                      login              null,
Oficina_Autorizacion                     int                null,
Fecha_Autorizacion                       datetime           null,
Causal_Rechazo                           varchar(64)        null)
go
 
print '-->Tabla: pf_conversion_ticket'
if exists (select 1 from sysobjects where name = 'pf_conversion_ticket' and type = 'U')
   drop table pf_conversion_ticket

create table pf_conversion_ticket(
ct_oficina                               smallint           not null,
ct_secuencial                            int                not null)
go
 
print '-->Tabla: pf_maestro_plan_pagos'
if exists (select 1 from sysobjects where name = 'pf_maestro_plan_pagos' and type = 'U')
   drop table pf_maestro_plan_pagos

create table pf_maestro_plan_pagos(
fecha                                    descripcion        null,
Territorial                              descripcion        null,
Zona                                     descripcion        null,
Oficina                                  int                null,
num_banco                                cuenta             null,
fecha_pago                               descripcion        null,
monto                                    money              null,
interes                                  money              null,
otros                                    money              null,
total                                    money              null,
Tipo_Compania                            varchar(10)        null,
Estado                                   varchar(10)        null,
Estado_Op                                varchar(10)        null)
go
 
print '-->Tabla: pf_det_condicion'
if exists (select 1 from sysobjects where name = 'pf_det_condicion' and type = 'U')
   drop table pf_det_condicion

create table pf_det_condicion(
dc_operacion                             int                not null,
dc_condicion                             tinyint            not null,
dc_ente                                  int                not null,
dc_estado_xren                           char(1)            not null,
dc_estado                                char(1)            not null,
dc_fecha_crea                            datetime           not null,
dc_fecha_mod                             datetime           null)
go
 
print '-->Tabla: pf_maestro_plan_pagos_aux'
if exists (select 1 from sysobjects where name = 'pf_maestro_plan_pagos_aux' and type = 'U')
   drop table pf_maestro_plan_pagos_aux

create table pf_maestro_plan_pagos_aux(
mp_fecha                                 datetime           null,
mp_territorial                           descripcion        null,
mp_zona                                  descripcion        null,
mp_oficina                               int                null,
mp_num_banco                             cuenta             null,
mp_fecha_pago                            datetime           null,
mp_monto                                 money              null,
mp_interes                               money              null,
mp_otros                                 money              null,
mp_total                                 money              null,
mp_tipo_compania                         varchar(10)        null,
mp_estado                                varchar(10)        null,
mp_estado_op                             varchar(10)        null)
go
 
print '-->Tabla: pf_det_condicion_tmp'
if exists (select 1 from sysobjects where name = 'pf_det_condicion_tmp' and type = 'U')
   drop table pf_det_condicion_tmp

create table pf_det_condicion_tmp(
dt_usuario                               login              null,
dt_sesion                                int                not null,
dt_operacion                             int                not null,
dt_condicion                             tinyint            not null,
dt_ente                                  int                not null,
dt_fecha_crea                            datetime           not null,
dt_fecha_mod                             datetime           null)
go
 
print '-->Tabla: pf_emision_cheque'
if exists (select 1 from sysobjects where name = 'pf_emision_cheque' and type = 'U')
   drop table pf_emision_cheque

create table pf_emision_cheque(
ec_fecha_mov                             datetime           not null,
ec_secuencial                            int                not null,
ec_secuencia                             int                not null,
ec_sub_secuencia                         int                not null,
ec_tran                                  int                not null,
ec_operacion                             int                not null,
ec_numero                                int                null,
ec_moneda                                tinyint            not null,
ec_valor                                 money              not null,
ec_descripcion                           varchar(255)       null,
ec_fecha_emision                         datetime           null,
ec_fecha_crea                            datetime           not null,
ec_fecha_mod                             datetime           null,
ec_tipo                                  char(3)            null,
ec_cuenta                                cuenta             null,
ec_banco                                 catalogo           null,
ec_estado                                catalogo           null,
ec_fpago                                 catalogo           null,
ec_fecha_real                            datetime           null,
ec_caja                                  char(1)            null,
ec_fecha_caja                            datetime           null,
ec_nombre_banco                          descripcion        null,
ec_benef_chq                             varchar(255)       null,
ec_secuencial_lote                       int                null,
ec_fecha_inicial                         varchar(10)        null,
ec_fecha_final                           varchar(10)        null,
ec_monto_cal                             money              null,
ec_tasa_cal                              float              null,
ec_subtipo_ins                           int                null)
go
 
print '-->Tabla: pf_errorlog'
if exists (select 1 from sysobjects where name = 'pf_errorlog' and type = 'U')
   drop table pf_errorlog

create table pf_errorlog(
er_fecha_proc                            datetime           not null,
er_error                                 int                null,
er_usuario                               login              null,
er_tran                                  int                null,
er_cuenta                                cuenta             null,
er_descripcion                           mensaje            null,
er_cta_pagrec                            cuenta             null)
go
 
print '-->Tabla: pf_historia'
if exists (select 1 from sysobjects where name = 'pf_historia' and type = 'U')
   drop table pf_historia

create table pf_historia(
hi_operacion                             int                not null,
hi_secuencial                            smallint           not null,
hi_fecha                                 datetime           not null,
hi_trn_code                              smallint           not null,
hi_valor                                 money              null,
hi_funcionario                           login              null,
hi_oficina                               smallint           null,
hi_observacion                           descripcion        null,
hi_fecha_crea                            datetime           not null,
hi_fecha_mod                             datetime           null,
hi_tasa                                  float              null,
hi_cupon                                 tinyint            null,
hi_fecha_back                            datetime           null,
hi_fecha_anterior                        datetime           null,
hi_saldo_capital                         money              null,
hi_secuencia                             int                null)
go
 
print '-->Tabla: pf_hist_secuen_ticket'
if exists (select 1 from sysobjects where name = 'pf_hist_secuen_ticket' and type = 'U')
   drop table pf_hist_secuen_ticket

create table pf_hist_secuen_ticket(
hs_num_banco                             cuenta             not null,
hs_operacion                             int                not null,
hs_secuencial                            int                not null,
hs_secuencia                             tinyint            not null,
hs_fpago                                 catalogo           not null,
hs_valor                                 money              not null,
hs_estado                                char(1)            not null,
hs_moneda                                smallint           not null,
hs_valor_ext                             money              not null,
hs_fecha_crea                            datetime           not null,
hs_fecha_modificacion                    datetime           null,
hs_oficina                               smallint           not null,
hs_subsecuencia                          int                null)
go
 
print '-->Tabla: pf_monto'
if exists (select 1 from sysobjects where name = 'pf_monto' and type = 'U')
   drop table pf_monto

create table pf_monto(
mo_tipo_monto                            int                not null,
mo_mnemonico                             catalogo           not null,
mo_descripcion                           varchar(60)        not null,
mo_monto_min                             money              not null,
mo_monto_max                             money              not null,
mo_fecha_crea                            datetime           not null,
mo_fecha_mod                             datetime           null)
go
 
print '-->Tabla: pf_mov_monet'
if exists (select 1 from sysobjects where name = 'pf_mov_monet' and type = 'U')
   drop table pf_mov_monet

create table pf_mov_monet(
mm_operacion                             int                not null,
mm_tran                                  int                not null,
mm_secuencia                             int                not null,
mm_secuencial                            int                not null,
mm_sub_secuencia                         tinyint            not null,
mm_fecha_aplicacion                      datetime           null,
mm_producto                              catalogo           not null,
mm_cuenta                                cuenta             null,
mm_valor                                 money              not null,
mm_estado                                char(1)            null,
mm_tipo                                  char(1)            not null,
mm_beneficiario                          int                null,
mm_impuesto                              money              null,
mm_moneda                                smallint           null,
mm_valor_ext                             money              null,
mm_fecha_crea                            datetime           not null,
mm_fecha_mod                             datetime           null,
mm_oficina                               int                null,
mm_impuesto_capital_me                   money              null,
mm_fecha_real                            datetime           null,
mm_secuencia_emis_che                    int                null,
mm_user                                  login              null,
mm_tipo_cliente                          char(1)            null,
mm_autorizado                            char(1)            null,
mm_cotizacion                            money              null,
mm_tipo_cotiza                           char(1)            null,
mm_ttransito                             smallint           null,
mm_fecha_valor                           datetime           null,
mm_renovado                              char(1)            null,
mm_cta_corresp                           cuenta             null,
mm_cod_corresp                           catalogo           null,
mm_benef_corresp                         varchar(255)       null,
mm_ofic_corresp                          int                null,
mm_incremento                            char(1)            null,
mm_num_cheque                            int                null,
mm_sec_mov                               int                null,
mm_usuario                               login              null,
mm_tipo_cuenta_ach                       char(1)            null,
mm_banco_ach                             descripcion        null,
mm_penaliza                              money              null,
mm_ssn_branch                            int                null,
mm_oficina_pago                          int                null,
mm_cod_banco_ach                         smallint           null,
mm_subtipo_ins                           int                null,
mm_secuencial_lote                       int                null,
mm_emerg_eco                             money              null,
mm_ica                                   money              null,
mm_snn_central                           int                null,
mm_snn_rev_central                       int                null)
go
 
print '-->Tabla: pf_mov_monet_prob'
if exists (select 1 from sysobjects where name = 'pf_mov_monet_prob' and type = 'U')
   drop table pf_mov_monet_prob

create table pf_mov_monet_prob(
pr_operacion                             int                not null,
pr_secuencia                             int                not null,
pr_subsecuencia                          int                not null,
pr_motivo                                catalogo           not null,
pr_banco                                 catalogo           null,
pr_cuenta                                cuenta             null,
pr_cheque                                int                null,
pr_valor                                 money              not null,
pr_estado                                char(1)            null,
pr_fecha_crea                            datetime           null,
pr_fecha_mod                             datetime           null)
go
 
print '-->Tabla: pf_reporte_venc_cab'
if exists (select 1 from sysobjects where name = 'pf_reporte_venc_cab' and type = 'U')
   drop table pf_reporte_venc_cab

create table pf_reporte_venc_cab(
rvc_mes                                  varchar(64)        null,
rvc_regional                             varchar(64)        null,
rvd_nom_regional                         varchar(64)        null,
rvc_zona                                 varchar(64)        null,
rvc_nom_zona                             varchar(64)        null,
rvc_oficina                              varchar(64)        null,
rvc_nom_oficina                          varchar(64)        null,
rvc_cant_rang1                           varchar(64)        null,
rvc_val_rang1                            varchar(64)        null,
rvc_cant_rang2                           varchar(64)        null,
rvc_val_rang2                            varchar(64)        null,
rvc_cant_rang3                           varchar(64)        null,
rvc_val_rang3                            varchar(64)        null,
rvc_cant_rang4                           varchar(64)        null,
rvc_val_rang4                            varchar(64)        null,
rvc_cantidad                             varchar(64)        null,
rvc_monto                                varchar(64)        null)
go
 
print '-->Tabla: pf_mov_monet_tmp'
if exists (select 1 from sysobjects where name = 'pf_mov_monet_tmp' and type = 'U')
   drop table pf_mov_monet_tmp

create table pf_mov_monet_tmp(
mt_usuario                               login              null,
mt_sesion                                int                not null,
mt_operacion                             int                not null,
mt_sub_secuencia                         tinyint            not null,
mt_producto                              catalogo           not null,
mt_cuenta                                cuenta             null,
mt_valor                                 money              not null,
mt_tipo                                  char(1)            not null,
mt_beneficiario                          int                null,
mt_impuesto                              money              null,
mt_moneda                                int                null,
mt_valor_ext                             money              null,
mt_fecha_crea                            datetime           not null,
mt_fecha_mod                             datetime           null,
mt_impuesto_capital_me                   money              null,
mt_tipo_cliente                          char(1)            null,
mt_autorizado                            char(1)            null,
mt_cotizacion                            money              null,
mt_tipo_cotiza                           char(1)            null,
mt_ttransito                             smallint           null,
mt_fecha_valor                           datetime           null,
mt_cta_corresp                           cuenta             null,
mt_cod_corresp                           catalogo           null,
mt_benef_corresp                         varchar(255)       null,
mt_ofic_corresp                          int                null,
mt_tran                                  int                null,
mt_secuencia                             int                null,
mt_secuencial                            int                null,
mt_oficina                               int                null,
mt_sec_emis_cheq                         int                null,
mt_estado                                char(1)            null,
mt_num_cheque                            int                null,
mt_sec_mov                               int                null,
mt_tipo_cuenta_ach                       char(1)            null,
mt_banco_ach                             descripcion        null,
mt_cod_banco_ach                         smallint           null,
mt_subtipo_ins                           int                null,
mt_secuencial_lote                       int                null,
mt_ica                                   money              null)
go
 
print '-->Tabla: pf_reporte_venc_det'
if exists (select 1 from sysobjects where name = 'pf_reporte_venc_det' and type = 'U')
   drop table pf_reporte_venc_det

create table pf_reporte_venc_det(
rvd_mes                                  varchar(24)        null,
rvd_regional                             int                null,
rvd_nom_regional                         varchar(64)        null,
rvd_zona                                 int                null,
rvd_nom_zona                             varchar(64)        null,
rvd_oficina                              int                null,
rvd_nom_oficina                          varchar(64)        null,
rvd_cant_rang1                           int                null,
rvd_val_rang1                            money              null,
rvd_cant_rang2                           int                null,
rvd_val_rang2                            money              null,
rvd_cant_rang3                           int                null,
rvd_val_rang3                            money              null,
rvd_cant_rang4                           int                null,
rvd_val_rang4                            money              null,
rvd_cantidad                             int                null,
rvd_monto                                money              null)
go
 
print '-->Tabla: pf_auxiliar_tip'
if exists (select 1 from sysobjects where name = 'pf_auxiliar_tip' and type = 'U')
   drop table pf_auxiliar_tip

create table pf_auxiliar_tip(
at_tipo_deposito                         smallint           not null,
at_moneda                                smallint           not null,
at_tipo                                  catalogo           not null,
at_valor                                 catalogo           not null,
at_estado                                char(1)            not null,
at_fecha_crea                            datetime           not null,
at_fecha_elim                            datetime           not null,
at_porcentaje                            money              null)
go
 
print '-->Tabla: pf_limite'
if exists (select 1 from sysobjects where name = 'pf_limite' and type = 'U')
   drop table pf_limite

create table pf_limite(
li_secuencial                            int                not null,
li_tipo_deposito                         smallint           not null,
li_moneda                                smallint           not null,
li_tipo_reg                              catalogo           not null,
li_valor                                 catalogo           not null,
li_limite_max                            float              not null,
li_limite_min                            float              not null,
li_usa_limites                           char(1)            not null,
li_fecha_crea                            datetime           not null,
li_fecha_elim                            datetime           null)
go
 
print '-->Tabla: pf_operacion'
if exists (select 1 from sysobjects where name = 'pf_operacion' and type = 'U')
   drop table pf_operacion

create table pf_operacion(
op_num_banco                             cuenta             not null,
op_operacion                             int                not null,
op_ente                                  int                not null,
op_toperacion                            catalogo           not null,
op_categoria                             catalogo           not null,
op_estado                                catalogo           not null,
op_producto                              tinyint            not null,
op_oficina                               smallint           not null,
op_moneda                                tinyint            not null,
op_num_dias                              smallint           not null,
op_base_calculo                          smallint           not null,
op_monto                                 money              not null,
op_monto_pg_int                          money              not null,
op_monto_pgdo                            money              not null,
op_monto_blq                             money              not null,
op_tasa                                  float              not null,
op_tasa_efectiva                         float              not null,
op_int_ganado                            money              not null,
op_int_estimado                          money              not null,
op_residuo                               float              not null,
op_int_pagados                           money              not null,
op_int_provision                         float              not null,
op_total_int_ganados                     money              not null,
op_total_int_pagados                     money              not null,
op_total_int_estimado                    money              not null,
op_total_int_retenido                    money              not null,
op_total_retencion                       money              not null,
op_fpago                                 catalogo           not null,
op_ppago                                 catalogo           null,
op_dia_pago                              smallint           null,
op_casilla                               tinyint            null,
op_direccion                             tinyint            null,
op_telefono                              varchar(16)        null,
op_historia                              smallint           null,
op_duplicados                            tinyint            not null,
op_renovaciones                          smallint           not null,
op_incremento                            money              null,
op_mon_sgte                              smallint           not null,
op_pignorado                             char(1)            not null,
op_renova_todo                           char(1)            not null,
op_imprime                               char(1)            not null,
op_retenido                              char(1)            not null,
op_retienimp                             char(1)            not null,
op_totalizado                            char(1)            not null,
op_tcapitalizacion                       char(1)            not null,
op_oficial                               login              not null,
op_accion_sgte                           catalogo           null,
op_preimpreso                            int                null,
op_tipo_plazo                            catalogo           not null,
op_tipo_monto                            catalogo           not null,
op_causa_mod                             catalogo           not null,
op_descripcion                           varchar(255)       not null,
op_fecha_valor                           datetime           not null,
op_fecha_ven                             datetime           not null,
op_fecha_cancela                         datetime           null,
op_fecha_ingreso                         datetime           not null,
op_fecha_pg_int                          datetime           not null,
op_fecha_ult_pg_int                      datetime           null,
op_ult_fecha_calculo                     datetime           null,
op_fecha_crea                            datetime           not null,
op_fecha_mod                             datetime           null,
op_fecha_total                           datetime           null,
op_puntos                                float              not null,
op_total_int_acumulado                   money              not null,
op_tasa_mer                              float              not null,
op_ced_ruc                               varchar(30)        null,
op_plazo_ant                             smallint           null,
op_fecven_ant                            datetime           null,
op_tot_int_est_ant                       money              null,
op_fecha_ord_act                         datetime           null,
op_mantiene_stock                        char(1)            null,
op_stock                                 int                null,
op_emision_inicial                       int                null,
op_moneda_pg                             char(2)            null,
op_impuesto                              float              not null,
op_num_imp_orig                          tinyint            null,
op_impuesto_capital                      money              not null,
op_retiene_imp_capital                   char(1)            not null,
op_ley                                   char(1)            null,
op_reestruc                              char(1)            null,
op_fecha_real                            datetime           null,
op_ult_fecha_cal_tasa                    datetime           null,
op_num_dias_gracia                       int                not null,
op_prorroga_aut                          char(1)            null,
op_tasa_variable                         char(1)            not null,
op_mnemonico_tasa                        catalogo           null,
op_modalidad_tasa                        char(1)            null,
op_periodo_tasa                          smallint           null,
op_descr_tasa                            descripcion        null,
op_operador                              char(1)            null,
op_spread                                float              null,
op_estatus_prorroga                      char(1)            null,
op_num_prorroga                          int                null,
op_anio_comercial                        char(1)            null,
op_flag_tasaefec                         char(1)            null,
op_comision                              money              null,
op_porc_comision                         float              null,
op_cupon                                 char(1)            null,
op_categoria_cupon                       catalogo           null,
op_custodia                              char(1)            null,
op_nueva_tasa                            float              null,
op_incremento_prorroga                   money              null,
op_puntos_prorroga                       float              null,
op_scontable                             catalogo           null,
op_captador                              login              null,
op_aprobado                              char(1)            null,
op_bloqueo_legal                         char(1)            null,
op_monto_blqlegal                        money              null,
op_ult_fecha_calven                      datetime           null,
op_prov_pendiente                        float              null,
op_residuo_prov                          float              null,
op_int_total_prov_vencida                float              null,
op_int_prov_vencida                      float              null,
op_tipo_tasa_var                         char(1)            null,
op_oficial_principal                     login              null,
op_oficial_secundario                    login              null,
op_origen_fondos                         catalogo           null,
op_proposito_cuenta                      catalogo           null,
op_producto_bancario1                    catalogo           null,
op_producto_bancario2                    catalogo           null,
op_revision_tasa                         char(1)            null,
op_dias_reales                           char(1)            null,
op_plazo_orig                            int                null,
op_sec_incre                             int                null,
op_renovada                              char(1)            null,
op_int_ajuste                            float              null,
op_tasa_ant                              float              null,
op_cambio_tasa                           char(1)            null,
op_plazo_cont                            int                null,
op_incre                                 char(1)            null,
op_tasa_min                              float              null,
op_tasa_max                              float              null,
op_camb_oper                             int                null,
op_fecha_ult_renov                       datetime           null,
op_fecha_ult_pago_int_ant                datetime           null,
op_ente_corresp                          int                null,
op_contador_firma                        int                null,
op_condiciones                           smallint           null,
op_localizado                            char(1)            null,
op_fecha_localizacion                    smalldatetime      null,
op_fecha_no_localiza                     smalldatetime      null,
op_inactivo                              char(1)            null,
op_dias_hold                             int                null,
op_sucursal                              smallint           null,
op_incremento_suspenso                   money              null,
op_oficina_apertura                      smallint           null,
op_oficial_apertura                      login              null,
op_toperacion_apertura                   catalogo           null,
op_tipo_plazo_apertura                   catalogo           null,
op_tipo_monto_apertura                   catalogo           null,
op_amortiza_periodo                      money              null,
op_total_amortizado                      money              null,
op_fideicomiso                           varchar(15)        null,
op_pago_interes                          char(1)            null,
op_monto_int_blqlegal                    money              null,
op_desmaterializa                        char(1)            null,
op_ica                                   varchar(1)         null,
op_total_ica                             money              null,
op_autoretenedor                         varchar(1)         null,
op_fecha_autoret                         datetime           null,
op_isin                                  varchar(30)        null,
op_fungible                              varchar(30)        null)
go
 
print '-->Tabla: pf_operacion_his'
if exists (select 1 from sysobjects where name = 'pf_operacion_his' and type = 'U')
   drop table pf_operacion_his

create table pf_operacion_his(
oh_num_banco                             cuenta             not null,
oh_operacion                             int                not null,
oh_retienimp                             char(1)            null,
oh_tasa                                  float              null,
oh_base_calculo                          smallint           not null,
oh_categoria                             catalogo           not null,
oh_num_dias                              smallint           not null,
oh_tcapitalizacion                       char(1)            not null,
oh_oficial_secundario                    login              null,
oh_fecha_valor                           datetime           not null,
oh_int_estimado                          money              not null,
oh_total_int_estimado                    money              not null,
oh_fecha_ven                             datetime           not null,
oh_fecha_ult_pg_int                      datetime           null,
oh_tasa_efectiva                         float              not null,
oh_tasa_mer                              float              not null,
oh_int_ganado                            money              not null,
oh_total_int_ganados                     money              not null,
oh_ente_corresp                          int                null,
oh_descripcion                           varchar(255)       not null,
oh_fecha_pg_int                          datetime           not null,
oh_localizado                            char(1)            null,
oh_fecha_localizacion                    smalldatetime      null,
oh_fecha_no_localiza                     smalldatetime      null,
oh_puntos                                float              not null,
oh_spread                                float              null,
oh_operador                              char(1)            null,
oh_casilla                               tinyint            null,
oh_direccion                             tinyint            null,
oh_sucursal                              smallint           null,
oh_fpago                                 catalogo           not null,
oh_ppago                                 catalogo           null,
oh_dia_pago                              smallint           null,
oh_dias_reales                           char(1)            null,
oh_inactivo                              char(1)            null,
oh_instruccion_especial                  varchar(255)       null,
oh_ente                                  int                null,
oh_telefono                              varchar(16)        null,
oh_oficina                               smallint           not null,
oh_oficial                               login              not null,
oh_monto                                 money              not null,
oh_fideicomiso                           varchar(15)        null)
go
 
print '-->Tabla: pf_endoso_cond'
if exists (select 1 from sysobjects where name = 'pf_endoso_cond' and type = 'U')
   drop table pf_endoso_cond

create table pf_endoso_cond(
ec_operacion                             int                null,
ec_ente                                  int                null,
ec_fecha_crea                            varchar(40)        null,
ec_condicion                             smallint           null)
go
 
print '-->Tabla: pf_endoso_prop'
if exists (select 1 from sysobjects where name = 'pf_endoso_prop' and type = 'U')
   drop table pf_endoso_prop

create table pf_endoso_prop(
en_operacion                             int                not null,
en_ente                                  int                not null,
en_historia                              int                not null,
en_rol                                   catalogo           not null,
en_fecha_crea                            varchar(30)        not null)
go
 
print '-->Tabla: pf_det_lote'
if exists (select 1 from sysobjects where name = 'pf_det_lote' and type = 'U')
   drop table pf_det_lote

create table pf_det_lote(
dl_lote                                  cuenta             not null,
dl_num_banco                             cuenta             not null,
dl_operacion                             int                not null,
dl_estado                                catalogo           not null,
dl_monto                                 money              not null,
dl_interes                               money              not null,
dl_impuesto                              money              not null,
dl_preimpreso                            int                null)
go
 
print '-->Tabla: pf_det_lote_tmp'
if exists (select 1 from sysobjects where name = 'pf_det_lote_tmp' and type = 'U')
   drop table pf_det_lote_tmp

create table pf_det_lote_tmp(
dt_usuario                               login              null,
dt_sesion                                int                not null,
dt_lote                                  cuenta             not null,
dt_num_banco                             cuenta             not null,
dt_preimpreso                            int                null)
go
 
print '-->Tabla: pf_operacion_tmp'
if exists (select 1 from sysobjects where name = 'pf_operacion_tmp' and type = 'U')
   drop table pf_operacion_tmp

create table pf_operacion_tmp(
ot_usuario                               login              null,
ot_sesion                                int                not null,
ot_num_banco                             cuenta             not null,
ot_operacion                             int                not null,
ot_operacion_new                         int                not null,
ot_toperacion                            catalogo           not null,
ot_categoria                             catalogo           not null,
ot_oficina                               smallint           not null,
ot_moneda                                tinyint            not null,
ot_casilla                               tinyint            null,
ot_direccion                             tinyint            null,
ot_num_dias                              smallint           not null,
ot_monto                                 money              not null,
ot_tasa                                  float              not null,
ot_tasa_efectiva                         float              not null,
ot_int_estimado                          money              not null,
ot_total_int_estimado                    money              not null,
ot_fpago                                 catalogo           not null,
ot_ppago                                 catalogo           null,
ot_dia_pago                              smallint           null,
ot_base_calculo                          smallint           not null,
ot_oficial                               login              not null,
ot_descripcion                           varchar(255)       not null,
ot_fecha_valor                           datetime           not null,
ot_fecha_ven                             datetime           not null,
ot_fecha_pg_int                          datetime           not null,
ot_fecha_total                           datetime           not null,
ot_accion_sgte                           catalogo           not null,
ot_fecha_ingreso                         datetime           not null,
ot_retienimp                             char(1)            not null,
ot_tcapitalizacion                       char(1)            not null,
ot_tipo_plazo                            catalogo           not null,
ot_tipo_monto                            catalogo           not null,
ot_impuesto                              float              not null,
ot_impuesto_capital                      money              not null,
ot_retiene_imp_capital                   char(1)            not null,
ot_num_dias_gracia                       int                null,
ot_prorroga_aut                          char(1)            null,
ot_tasa_variable                         char(1)            not null,
ot_mnemonico_tasa                        catalogo           null,
ot_modalidad_tasa                        char(1)            null,
ot_periodo_tasa                          smallint           null,
ot_descr_tasa                            descripcion        null,
ot_operador                              char(1)            null,
ot_spread                                float              null,
ot_flag_tasaefec                         char(1)            null,
ot_tot_int_ganados                       money              not null,
ot_tot_int_retenido                      money              not null,
ot_tot_int_acumulado                     money              not null,
ot_preimpreso                            int                null,
ot_int_ganado                            money              not null,
ot_int_pagados                           money              not null,
ot_tot_int_pagados                       money              not null,
ot_tot_int_provision                     float              not null,
ot_tot_int_est_ant                       money              null,
ot_residuo                               float              not null,
ot_fecha_ult_pg_int                      datetime           null,
ot_fecven_ant                            datetime           null,
ot_fecha_ord_act                         datetime           null,
ot_ult_fecha_calculo                     datetime           null,
ot_imprime                               char(1)            null,
ot_plazo_ant                             smallint           null,
ot_puntos                                float              not null,
ot_estatus_prorroga                      char(1)            null,
ot_num_prorroga                          int                null,
ot_anio_comercial                        char(1)            null,
ot_porc_comision                         float              null,
ot_cupon                                 char(1)            not null,
ot_categoria_cupon                       catalogo           null,
ot_custodia                              char(1)            null,
ot_captador                              login              null,
ot_oficial_principal                     login              null,
ot_oficial_secundario                    login              null,
ot_origen_fondos                         catalogo           null,
ot_proposito_cuenta                      catalogo           null,
ot_producto_bancario1                    catalogo           null,
ot_producto_bancario2                    catalogo           null,
ot_revision_tasa                         char(1)            null,
ot_dias_reales                           char(1)            null,
ot_ente_corresp                          int                null,
ot_plazo_orig                            float              null,
ot_sucursal                              smallint           null,
ot_inactivo                              char(1)            null,
ot_incremento_suspenso                   money              null,
ot_localizado                            char(1)            null,
ot_fecha_localizacion                    smalldatetime      null,
ot_fecha_no_localiza                     smalldatetime      null,
ot_dias_hold                             int                null,
ot_aprobado                              char(1)            null,
ot_telefono                              varchar(16)        null,
ot_oficina_apertura                      smallint           null,
ot_oficial_apertura                      login              null,
ot_toperacion_apertura                   catalogo           null,
ot_amortiza_periodo                      money              null,
ot_fideicomiso                           varchar(15)        null,
ot_desmaterializa                        char(1)            null,
ot_ica                                   varchar(1)         null)
go
 
print '-->Tabla: pf_pignoracion'
if exists (select 1 from sysobjects where name = 'pf_pignoracion' and type = 'U')
   drop table pf_pignoracion

create table pf_pignoracion(
pi_operacion                             int                not null,
pi_producto                              catalogo           not null,
pi_cuenta                                cuenta             null,
pi_valor                                 money              not null,
pi_tasa                                  float              not null,
pi_funcionario                           login              not null,
pi_oficina                               smallint           not null,
pi_spread                                float              null,
pi_motivo                                catalogo           not null,
pi_fecha_crea                            datetime           not null,
pi_fecha_mod                             datetime           null,
pi_observacion                           descripcion        null,
pi_cuenta_gar                            cuenta             null)
go
 
print '-->Tabla: pf_plazo'
if exists (select 1 from sysobjects where name = 'pf_plazo' and type = 'U')
   drop table pf_plazo

create table pf_plazo(
pl_tipo_plazo                            int                not null,
pl_mnemonico                             catalogo           not null,
pl_descripcion                           varchar(30)        not null,
pl_plazo_min                             smallint           not null,
pl_plazo_max                             smallint           not null,
pl_fecha_crea                            datetime           not null,
pl_fecha_mod                             datetime           null,
pl_plazo_contable                        catalogo           not null)
go
 
print '-->Tabla: pf_ppago'
if exists (select 1 from sysobjects where name = 'pf_ppago' and type = 'U')
   drop table pf_ppago

create table pf_ppago(
pp_codigo                                char(3)            not null,
pp_descripcion                           descripcion        not null,
pp_factor_en_meses                       tinyint            not null,
pp_estado                                char(1)            not null,
pp_fecha_crea                            datetime           not null,
pp_fecha_mod                             datetime           null,
pp_factor_dias                           smallint           null)
go
 
print '-->Tabla: pf_prorroga_aut'
if exists (select 1 from sysobjects where name = 'pf_prorroga_aut' and type = 'U')
   drop table pf_prorroga_aut

create table pf_prorroga_aut(
pa_operacion                             int                not null,
pa_renovacion                            smallint           not null,
pa_incremento                            money              not null,
pa_tasa                                  float              not null,
pa_plazo                                 smallint           not null,
pa_fecha_valor                           datetime           null,
pa_oficial                               login              not null,
pa_estado                                char(1)            null,
pa_estado_ant                            catalogo           null,
pa_renova_todo                           char(1)            null,
pa_monto                                 money              not null,
pa_int_vencido                           money              null,
pa_monto_renovar                         money              null,
pa_fecha_crea                            datetime           not null,
pa_fecha_mod                             datetime           null,
pa_descripcion                           descripcion        null,
pa_operacion_new                         int                null,
pa_impuesto                              money              null,
pa_tot_int                               money              null,
pa_moneda_pg                             char(2)            null,
pa_oficina_ant                           smallint           null,
pa_oficina                               smallint           null,
pa_vuelto                                money              null,
pa_retiene_imp_capital                   char(1)            null,
pa_fecha_pg_int                          datetime           null,
pa_int_pagados                           money              null,
pa_total_int_pagados                     money              null,
pa_fecha_ult_pg_int                      datetime           null)
go
 
print '-->Tabla: pf_reg_control'
if exists (select 1 from sysobjects where name = 'pf_reg_control' and type = 'U')
   drop table pf_reg_control

create table pf_reg_control(
rc_fecha_inicio_dia                      datetime           not null,
rc_fecha_final_dia                       datetime           not null,
rc_fecha_proc_cont                       datetime           not null,
rc_fecha_fin_mes                         datetime           not null)
go
 
print '-->Tabla: tmp_plano'
if exists (select 1 from sysobjects where name = 'tmp_plano' and type = 'U')
   drop table tmp_plano

create table tmp_plano(
orden                                    int                not null,
cadena                                   varchar(2000)      not null)
go
 
print '-->Tabla: pf_renovacion'
if exists (select 1 from sysobjects where name = 'pf_renovacion' and type = 'U')
   drop table pf_renovacion

create table pf_renovacion(
re_operacion                             int                not null,
re_renovacion                            smallint           not null,
re_incremento                            money              not null,
re_tasa                                  float              not null,
re_plazo                                 smallint           not null,
re_fecha_valor                           datetime           null,
re_oficial                               login              not null,
re_estado                                char(1)            null,
re_estado_ant                            catalogo           null,
re_renova_todo                           char(1)            null,
re_monto                                 money              not null,
re_int_vencido                           money              null,
re_monto_renovar                         money              null,
re_fecha_crea                            datetime           not null,
re_fecha_mod                             datetime           null,
re_descripcion                           descripcion        null,
re_operacion_new                         int                null,
re_impuesto                              money              null,
re_tot_int                               money              null,
re_moneda_pg                             char(2)            null,
re_oficina_ant                           smallint           null,
re_oficina                               smallint           null,
re_vuelto                                money              null,
re_retiene_imp_capital                   char(1)            null,
re_fecha_pg_int                          datetime           null,
re_int_pagados                           money              null,
re_total_int_pagados                     money              null,
re_fecha_ult_pg_int                      datetime           null,
re_ente_corresp                          int                null,
re_dia_pago                              tinyint            null,
re_dias_reales                           char(1)            null,
re_ppago                                 catalogo           null,
re_fpago                                 catalogo           null,
re_spread_fijo                           float              null,
re_operador_fijo                         char(1)            null,
re_plazo_orig                            int                null,
re_casilla                               tinyint            null,
re_direccion                             tinyint            null,
re_sucursal                              smallint           null,
re_oficial_principal                     login              null,
re_oficial_secundario                    login              null,
re_localizado                            char(1)            null,
re_fecha_localizado                      datetime           null,
re_fecha_no_localizado                   datetime           null,
re_inactivo                              char(1)            null,
re_desmaterializa                        char(1)            null,
re_puntos                                float              null,
re_tasa_base                             float              null)
go
 
print '-->Tabla: tmp_transacciones'
if exists (select 1 from sysobjects where name = 'tmp_transacciones' and type = 'U')
   drop table tmp_transacciones

create table tmp_transacciones(
Mes                                      nvarchar(60)       null,
Producto                                 varchar(2)         not null,
Tipo_Tran                                varchar(64)        not null,
Concepto                                 catalogo           null,
Descrip_concepto                         descripcion        null,
Num_registros                            int                null,
valor                                    money              null,
Estado                                   varchar(1)         not null)
go
 
print '-->Tabla: pf_retencion'
if exists (select 1 from sysobjects where name = 'pf_retencion' and type = 'U')
   drop table pf_retencion

create table pf_retencion(
rt_operacion                             int                not null,
rt_secuencial                            tinyint            not null,
rt_valor                                 money              not null,
rt_int_retencion                         float              not null,
rt_suspendida                            char(1)            not null,
rt_motivo                                catalogo           not null,
rt_fecha_crea                            datetime           not null,
rt_fecha_mod                             datetime           null,
rt_cupon                                 tinyint            null,
rt_cuenta                                cuenta             null,
rt_producto                              catalogo           null,
rt_observacion                           descripcion        null,
rt_funcionario                           login              null)
go
 
print '-->Tabla: pf_retencion_tmp'
if exists (select 1 from sysobjects where name = 'pf_retencion_tmp' and type = 'U')
   drop table pf_retencion_tmp

create table pf_retencion_tmp(
et_usuario                               login              null,
et_sesion                                int                not null,
et_operacion                             int                not null,
et_secuencial                            tinyint            null,
et_valor                                 money              not null,
et_motivo                                catalogo           null,
et_cupon                                 tinyint            null,
et_cuenta                                cuenta             null,
et_producto                              tinyint            null)
go
 
print '-->Tabla: pf_custodia_tmp'
if exists (select 1 from sysobjects where name = 'pf_custodia_tmp' and type = 'U')
   drop table pf_custodia_tmp

create table pf_custodia_tmp(
st_usuario                               login              null,
st_sesion                                int                not null,
st_operacion                             int                not null,
st_cupon                                 tinyint            null,
st_procesado                             char(1)            null)
go
 
print '-->Tabla: pf_tasa'
if exists (select 1 from sysobjects where name = 'pf_tasa' and type = 'U')
   drop table pf_tasa

create table pf_tasa(
ta_tipo_deposito                         varchar(5)         not null,
ta_moneda                                tinyint            not null,
ta_tipo_monto                            varchar(10)        not null,
ta_tipo_plazo                            varchar(10)        not null,
ta_tasa_min                              float              not null,
ta_tasa_max                              float              not null,
ta_vigente                               float              not null,
ta_fecha_crea                            datetime           not null,
ta_fecha_mod                             datetime           null,
ta_tasa_mer                              float              not null,
ta_usuario                               login              null,
ta_tipo                                  char(1)            not null,
ta_tipo_pago                             varchar(10)        null,
ta_segmento                              catalogo           null,
ta_ivc                                   catalogo           null,
ta_prorroga                              catalogo           null,
ta_momento                               catalogo           null)
go
 
print '-->Tabla: pf_tasa_variable'
if exists (select 1 from sysobjects where name = 'pf_tasa_variable' and type = 'U')
   drop table pf_tasa_variable

create table pf_tasa_variable(
tv_mnemonico_prod                        varchar(5)         not null,
tv_mnemonico_tasa                        catalogo           not null,
tv_tipo_monto                            catalogo           not null,
tv_tipo_plazo                            catalogo           not null,
tv_spread_max                            float              not null,
tv_spread_min                            float              not null,
tv_spread_vigente                        float              not null,
tv_moneda                                smallint           not null,
tv_estado                                char(1)            null,
tv_fecha_crea                            datetime           null,
tv_fecha_mod                             datetime           null,
tv_operador                              char(1)            not null,
tv_tasa_max                              float              not null,
tv_tasa_min                              float              not null,
tv_usuario                               login              null,
tv_tipo_pago                             varchar(10)        null,
tv_segmento                              catalogo           null,
tv_ivc                                   catalogo           null,
tv_prorroga                              catalogo           null,
tv_momento                               catalogo           null)
go
 
print '-->Tabla: pf_estadistica'
if exists (select 1 from sysobjects where name = 'pf_estadistica' and type = 'U')
   drop table pf_estadistica

create table pf_estadistica(
es_tipo_deposito                         catalogo           not null,
es_moneda                                int                not null,
es_nivel                                 varchar(1)         not null,
es_valor_nivel                           varchar(10)        not null,
es_mes                                   tinyint            not null,
es_cantidad                              int                not null,
es_monto                                 money              not null,
es_plazo_pponderado                      int                not null,
es_tasa_pponderada                       float              not null,
es_anio                                  int                null)
go
 
print '-->Tabla: pf_tranperfil'
if exists (select 1 from sysobjects where name = 'pf_tranperfil' and type = 'U')
   drop table pf_tranperfil

create table pf_tranperfil(
tp_tran                                  smallint           not null,
tp_estado                                char(1)            not null,
tp_perfil                                varchar(10)        not null,
tp_tipo_trn                              catalogo           null,
tp_trn_rec                               catalogo           null)
go
 
print '-->Tabla: pf_tran_provision'
if exists (select 1 from sysobjects where name = 'pf_tran_provision' and type = 'U')
   drop table pf_tran_provision

create table pf_tran_provision(
tp_operacion                             int                not null,
tp_moneda                                tinyint            not null,
tp_monto                                 money              not null,
tp_oficina                               smallint           not null,
tp_tipo_plazo                            catalogo           not null,
tp_fecha_tran                            datetime           not null,
tp_int_provision                         float              not null,
tp_total_int_ganados                     money              not null,
tp_total_int_pagados                     money              not null,
tp_total_int_estimado                    money              not null,
tp_tasa                                  money              not null)
go
 
print '-->Tabla: pf_sasiento'
if exists (select 1 from sysobjects where name = 'pf_sasiento' and type = 'U')
   drop table pf_sasiento

create table pf_sasiento(
sa_fecha_tran                            datetime           not null,
sa_comprobante                           int                not null,
sa_empresa                               tinyint            not null,
sa_asiento                               smallint           not null,
sa_cuenta                                varchar(20)        not null,
sa_oficina_dest                          int                not null,
sa_area_dest                             int                not null,
sa_credito                               money              not null,
sa_debito                                money              not null,
sa_concepto                              varchar(150)       not null,
sa_credito_me                            money              not null,
sa_debito_me                             money              not null,
sa_cotizacion                            money              not null,
sa_tipo_doc                              char(1)            not null,
sa_tipo_tran                             char(1)            not null,
sa_moneda                                tinyint            not null,
sa_opcion                                tinyint            null,
sa_fecha_est                             datetime           null,
sa_estado                                char(1)            null,
sa_ente                                  int                null,
sa_param_imp                             catalogo           null)
go
 
print '-->Tabla: pf_scomprobante'
if exists (select 1 from sysobjects where name = 'pf_scomprobante' and type = 'U')
   drop table pf_scomprobante

create table pf_scomprobante(
sc_comprobante                           int                not null,
sc_empresa                               tinyint            not null,
sc_fecha_tran                            datetime           not null,
sc_oficina_orig                          int                not null,
sc_area_orig                             int                not null,
sc_fecha_gra                             datetime           not null,
sc_digitador                             descripcion        not null,
sc_descripcion                           descripcion        not null,
sc_perfil                                varchar(10)        not null,
sc_detalles                              smallint           not null,
sc_tot_debito                            money              not null,
sc_tot_credito                           money              not null,
sc_tot_debito_me                         money              not null,
sc_tot_credito_me                        money              not null,
sc_estado                                estado             not null)
go
 
print '-->Tabla: pf_sasiento_his'
if exists (select 1 from sysobjects where name = 'pf_sasiento_his' and type = 'U')
   drop table pf_sasiento_his

create table pf_sasiento_his(
sa_fecha_tran                            datetime           not null,
sa_comprobante                           int                not null,
sa_empresa                               tinyint            not null,
sa_asiento                               smallint           not null,
sa_cuenta                                varchar(20)        not null,
sa_oficina_dest                          int                not null,
sa_area_dest                             int                not null,
sa_credito                               money              not null,
sa_debito                                money              not null,
sa_concepto                              varchar(150)       not null,
sa_credito_me                            money              not null,
sa_debito_me                             money              not null,
sa_cotizacion                            money              not null,
sa_tipo_doc                              char(1)            not null,
sa_tipo_tran                             char(1)            not null,
sa_moneda                                tinyint            not null,
sa_opcion                                tinyint            null,
sa_fecha_est                             datetime           null,
sa_estado                                char(1)            null,
sa_ente                                  int                null,
sa_param_imp                             catalogo           null)
go
 
print '-->Tabla: pf_scomprobante_his'
if exists (select 1 from sysobjects where name = 'pf_scomprobante_his' and type = 'U')
   drop table pf_scomprobante_his

create table pf_scomprobante_his(
sc_comprobante                           int                not null,
sc_empresa                               tinyint            not null,
sc_fecha_tran                            datetime           not null,
sc_oficina_orig                          int                not null,
sc_area_orig                             int                not null,
sc_fecha_gra                             datetime           not null,
sc_digitador                             descripcion        not null,
sc_descripcion                           descripcion        not null,
sc_perfil                                varchar(10)        not null,
sc_detalles                              smallint           not null,
sc_tot_debito                            money              not null,
sc_tot_credito                           money              not null,
sc_tot_debito_me                         money              not null,
sc_tot_credito_me                        money              not null,
sc_estado                                estado             not null)
go
 
print '-->Tabla: pf_secuen_ticket'
if exists (select 1 from sysobjects where name = 'pf_secuen_ticket' and type = 'U')
   drop table pf_secuen_ticket

create table pf_secuen_ticket(
st_num_banco                             cuenta             not null,
st_operacion                             int                not null,
st_secuencial                            int                not null,
st_secuencia                             int                not null,
st_fpago                                 catalogo           not null,
st_valor                                 money              not null,
st_estado                                char(1)            not null,
st_moneda                                smallint           not null,
st_valor_ext                             money              not null,
st_fecha_crea                            datetime           not null,
st_fecha_modificacion                    datetime           null,
st_oficina                               smallint           not null,
st_subsecuencia                          int                null)
go
 
print '-->Tabla: pf_temp'
if exists (select 1 from sysobjects where name = 'pf_temp' and type = 'U')
   drop table pf_temp

create table pf_temp(
tp_oficina                               smallint           not null,
tp_moneda                                smallint           not null,
tp_toperacion                            catalogo           not null,
tp_estado                                catalogo           null,
tp_plazo                                 catalogo           null)
go
 
print '-->Tabla: pf_relacion_comp'
if exists (select 1 from sysobjects where name = 'pf_relacion_comp' and type = 'U')
   drop table pf_relacion_comp

create table pf_relacion_comp(
rc_num_banco                             cuenta             not null,
rc_comp                                  int                not null,
rc_cod_tran                              int                not null,
rc_tran                                  catalogo           not null,
rc_estado                                char(1)            not null,
rc_secuencia                             int                null,
rc_numero                                int                null,
rc_fecha_tran                            datetime           null)
go
 
print '-->Tabla: pf_tasa_var_p'
if exists (select 1 from sysobjects where name = 'pf_tasa_var_p' and type = 'U')
   drop table pf_tasa_var_p

create table pf_tasa_var_p(
pt_fecha                                 datetime           null,
pt_operacion                             int                null,
pt_trn                                   int                null,
pt_puntos                                float              null,
pt_operador_puntos                       char(1)            null,
pt_spread                                float              null,
pt_operador_spread                       char(1)            null,
pt_tasa_nominal                          float              null,
pt_tasa_efectiva                         float              null,
pf_tasa_ref                              float              null)
go

print '-->Tabla: pf_rango_prorroga'
if exists (select 1 from sysobjects where name = 'pf_rango_prorroga' and type = 'U')
   drop table pf_rango_prorroga

create table pf_rango_prorroga(
rp_tipo_rango                            int                not null,
rp_mnemonico                             catalogo           not null,
rp_descripcion                           varchar(30)        not null,
rp_prorroga_min                          smallint           not null,
rp_prorroga_max                          smallint           not null,
rp_fecha_crea                            datetime           not null,
rp_fecha_mod                             datetime           null)
go

print '-->Tabla: Archivo Carga Tasas Masivas'
if exists (select 1 from sysobjects where name = 'pf_archivo_carga_tasas' and type = 'U')
   drop table pf_archivo_carga_tasas
   
create table pf_archivo_carga_tasas(
cat_secuencial_archivo          int                  null,
cat_nombre_archivo              varchar(255)         null,
cat_estado                      char(1)              null,
cat_fecha_vigencia              datetime             null,
cat_numero_registros            int                  null,
cat_fecha_registros             date                 null,
cat_hora_registros              time(7)              null,
cat_fecha_modificacion          datetime             null,
cat_usuario                     varchar(14)          null,
cat_terminal                    varchar(30)          null,
cat_observacion                 varchar(255)         null)
go

print '-->Tabla: Carga Tasas Masivas Temporal'
if exists (select 1 from sysobjects where name = 'pf_tasas_masivas_tmp' and type = 'U')
   drop table pf_tasas_masivas_tmp

create table pf_tasas_masivas_tmp(
tmt_tipo_deposito               varchar(10)          null,
tmt_momento                     varchar(10)          null,
tmt_moneda                      smallint             null,
tmt_plazo_min                   smallint             null,
tmt_plazo_max                   smallint             null,
tmt_monto_min                   money                null,
tmt_monto_max                   money                null,
tmt_tipo_segmento               varchar(10)          null,
tmt_segmento                    varchar(20)          null,
tmt_tipo_ivc                    varchar(10)          null,
tmt_ivc                         varchar(20)          null,
tmt_prorroga_min                smallint             null,
tmt_prorroga_max                smallint             null,
tmt_tasa_referencial            varchar(10)          null,
tmt_operador                    char(1)              null,
tmt_spread                      float                null,
tmt_tasa_min                    float                null,
tmt_tasa_max                    float                null,
tmt_tasa_vigente                float                null)
go

print '-->Tabla: Carga Tasas Masivas'
if exists (select 1 from sysobjects where name = 'pf_tasas_masivas' and type = 'U')
   drop table pf_tasas_masivas
   
create table pf_tasas_masivas(
tm_secuencial_archivo           int                  null,
tm_secuencial                   int                  null,
tm_tipo_tasa                    varchar(25)          null,
tm_tipo_deposito                varchar(10)          null,
tm_momento                      varchar(10)          null,
tm_moneda                       smallint             null,
tm_tipo_plazo                   varchar(10)          null,
tm_plazo_min                    smallint             null,
tm_plazo_max                    smallint             null,
tm_tipo_monto                   varchar(10)          null,
tm_monto_min                    money                null,
tm_monto_max                    money                null,
tm_tipo_segmento                varchar(10)          null,
tm_segmento                     varchar(20)          null,
tm_tipo_ivc                     varchar(10)          null,
tm_ivc                          varchar(20)          null,
tm_prorroga                     varchar(20)          null,
tm_prorroga_min                 smallint             null,
tm_prorroga_max                 smallint             null,
tm_tasa_referencial             varchar(10)          null,
tm_operador                     char(1)              null,
tm_spread                       float                null,
tm_tasa_min                     float                null,
tm_tasa_max                     float                null,
tm_tasa_vigente                 float                null,
tm_fecha_registro               datetime             null,
tm_estado                       char(1)              null)
go

print '-->Tabla: Log Errores Tasas'
if exists (select 1 from sysobjects where name = 'pf_tasas_error' and type = 'U')
   drop table pf_tasas_error
   
create table pf_tasas_error(
te_secuencial_archivo           int                  null,
te_secuencial                   int                  null,
te_fecha                        date                 null,
te_hora                         time(7)              null,
te_codigo_error                 int                  null,
te_desc_error                   varchar(140)         null,
te_numero_registros             int                  null,
te_nombre_campo                 varchar(140)         null,
te_valor_campo                  varchar(140)         null)
go

use cobis
go

SET NOCOUNT ON
go

SET ANSI_NULLS ON
go

SET QUOTED_IDENTIFIER ON
go

print '-->Tabla: ba_secuencial_neg'
if exists (select 1 from sysobjects where name = 'ba_secuencial_neg' and type = 'U')
   drop table ba_secuencial_neg

create table ba_secuencial_neg (
sn_numero                                int                not null)
go

insert into ba_secuencial_neg values (0)
go 

print '-->Tabla: dpf_desembargo'
if exists (select 1 from cobis..sysobjects where name = 'dpf_desembargo' and type = 'U')
   drop table cobis..dpf_desembargo
   
create table cobis..dpf_desembargo(
secuencial                               int                null,
sec_interno                              int                null,
productoint                              int                null,
cuenta                                   varchar(20)        null)

print '-->tabla: dpf_reverso'
if exists (select 1 from cobis..sysobjects where name = 'dpf_reverso' and type = 'U')
   drop table cobis..dpf_reverso

create table cobis..dpf_reverso(
secuencial                               int                null,
sec_interno                              int                null,
productoint                              int                null,
cuenta                                   varchar(20)        null,
monto                                    money              null)

print ''
print 'Fin Ejecucion Creacion de Tablas Plazo Fijo : ' + convert(varchar(60),getdate(),109)
print ''

print 'Creacion de Tablas Plazo Fijo en cob_externos : ' + convert(varchar(60),getdate(),109)

--use cob_externos
--go
--
--print '-->Tabla: ex_rep_dpf_reporte_gmf_cdt'
--if exists (select 1 from sysobjects where name = 'ex_rep_dpf_reporte_gmf_cdt' and type = 'U')
--   drop table ex_rep_dpf_reporte_gmf_cdt
--
--create table ex_rep_dpf_reporte_gmf_cdt(
--codigo_ofi                               int                null,
--desc_ofi                                 varchar(100)       null,
--nombre_titular                           varchar(255)       null,
--ident_titular                            varchar(255)       null,
--estado_cdt                               varchar(10)        null,
--nro_cdt                                  varchar(50)        null,
--fecha_aper_cdt                           datetime           null,
--fecha_canc_cdt                           datetime           null,
--vlr_cdt                                  money              null,
--int_pagados                              money              null,
--base_gmf_int                             money              null,
--base_gmf_cap                             money              null,
--valor_gmf_cap                            money              null,
--valor_gmf_int                            money              null,
--opciones                                 varchar(10)        null)
--go
--
--print '-->Tabla: ex_rep_dpf_reporte_gmf_cdt_det'
--if exists (select 1 from sysobjects where name = 'ex_rep_dpf_reporte_gmf_cdt_det' and type = 'U')
--   drop table ex_rep_dpf_reporte_gmf_cdt_det
--
--create table ex_rep_dpf_reporte_gmf_cdt_det(
--rgc_concepto                             catalogo           null,
--rgc_tran                                 int                null,
--rgc_tipo_tran                            catalogo           null,
--rgc_valor                                money              null)
--go
--
--
 