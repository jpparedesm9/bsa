/************************************************************************/
/*                 Descripcion                                          */
/*  Script para creacion de tablas de Dependencias de Plazo Fijo        */
/************************************************************************/
/*                                                                      */
/*  Fecha         Autor               Comentario                        */
/*  15/07/2016    Oscar Saavedra      Instalador Version Davivienda     */
/************************************************************************/
use cob_conta
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

print '-->Tabla: cb_area'
if not exists (select 1 from sysobjects where name = 'cb_area' and type = 'U') begin
   create table cb_area(
   ar_empresa                               tinyint            not null,
   ar_area                                  smallint           not null,
   ar_descripcion                           descripcion        not null,
   ar_area_padre                            smallint           null,
   ar_estado                                char(1)            not null,
   ar_fecha_estado                          datetime           null,
   ar_nivel_area                            tinyint            not null,
   ar_consolida                             char(1)            not null,
   ar_movimiento                            char(1)            not null)
end
go

print '-->Tabla: cb_boc'
if not exists (select 1 from sysobjects where name = 'cb_boc' and type = 'U') begin	
   create table cb_boc( 
   bo_fecha                                 smalldatetime      not null,
   bo_cuenta                                cuenta             not null,
   bo_oficina                               int                not null,
   bo_cliente                               int                not null,
   bo_val_opera                             money              not null,
   bo_val_conta                             money              not null,
   bo_diferencia                            money              not null,
   bo_producto                              int                null)
end
go

print '-->Tabla: cb_boc_det'
if not exists (select 1 from sysobjects where name = 'cb_boc_det' and type = 'U') begin
   create table cb_boc_det(
   bod_fecha                                smalldatetime      not null,
   bod_cuenta                               cuenta             not null,
   bod_oficina                              int                not null,
   bod_cliente                              int                not null,
   bod_banco                                cuenta             not null,
   bod_concepto                             catalogo           not null,
   bod_admisible                            char(1)            not null,
   bod_calificacion                         catalogo           not null,
   bod_clase_cartera                        catalogo           not null,
   bod_val_opera                            money              not null,
   bod_producto                             int                null)
end
go

print '-->Tabla: cb_boc_det_respaldo'
if not exists (select 1 from sysobjects where name = 'cb_boc_det_respaldo' and type = 'U') begin
   create table cb_boc_det_respaldo(
   bod_secuencial                           int                null,
   bod_fecha                                smalldatetime      not null,
   bod_cuenta                               cuenta             not null,
   bod_oficina                              int                not null,
   bod_cliente                              int                not null,
   bod_banco                                cuenta             not null,
   bod_concepto                             catalogo           not null,
   bod_admisible                            char(1)            not null,
   bod_calificacion                         catalogo           not null,
   bod_clase_cartera                        catalogo           not null,
   bod_val_opera                            money              not null,
   bod_producto                             int                null)
end
go

print '-->Tabla: cb_boc_log'
if not exists (select 1 from sysobjects where name = 'cb_boc_log' and type = 'U') begin
   create table cb_boc_log(
   bl_fecha                                 smalldatetime      not null,
   bl_error                                 varchar(255)       not null,
   bl_producto                              int                null)
end
go

print '-->Tabla: cb_boc_respaldo'
if not exists (select 1 from sysobjects where name = 'cb_boc_respaldo' and type = 'U') begin
   create table cb_boc_respaldo(
   bo_secuencial                            int                null,
   bo_fecha                                 smalldatetime      not null,
   bo_cuenta                                cuenta             not null,
   bo_oficina                               int                not null,
   bo_cliente                               int                not null,
   bo_val_opera                             money              not null,
   bo_val_conta                             money              not null,
   bo_diferencia                            money              not null,
   bo_producto                              int                null)
end
go

print '-->Tabla: cb_conc_retencion'
if not exists (select 1 from sysobjects where name = 'cb_conc_retencion' and type = 'U') begin
   create table cb_conc_retencion(
   cr_empresa                               tinyint            not null,
   cr_codigo                                char(4)            not null,
   cr_descripcion                           varchar(30)        not null,
   cr_base                                  money              null,
   cr_porcentaje                            float              null,
   cr_debcred                               char(1)            not null,
   cr_tipo                                  char(1)            not null)
end
go

print '-->Tabla: cb_corte'
if not exists (select 1 from sysobjects where name = 'cb_corte' and type = 'U') begin
   create table cb_corte(
   co_corte                                 int                not null,
   co_periodo                               int                not null,
   co_empresa                               tinyint            not null,
   co_fecha_ini                             datetime           not null,
   co_fecha_fin                             datetime           not null,
   co_estado                                char(1)            not null,
   co_tipo_corte                            tinyint            null)
end
go

print '-->Tabla: cb_cotizacion'
if not exists (select 1 from sysobjects where name = 'cb_cotizacion' and type = 'U') begin
   create table cb_cotizacion(
   ct_moneda                                tinyint            not null,
   ct_fecha                                 datetime           not null,
   ct_valor                                 money              null,
   ct_compra                                money              not null,
   ct_venta                                 money              not null,
   ct_factor1                               float              null,
   ct_factor2                               float              null)
end
go

print '-->Tabla: cb_cuenta'
if not exists (select 1 from sysobjects where name = 'cb_cuenta' and type = 'U') begin
   create table cb_cuenta(
   cu_empresa                               tinyint            not null,
   cu_cuenta                                cuenta_contable    not null,
   cu_cuenta_padre                          cuenta_contable    null,
   cu_nombre                                char(80)           not null,
   cu_descripcion                           char(255)          null,
   cu_estado                                char(1)            not null,
   cu_movimiento                            char(1)            not null,
   cu_nivel_cuenta                          tinyint            not null,
   cu_categoria                             char(1)            not null,
   cu_fecha_estado                          datetime           null,
   cu_moneda                                tinyint            not null,
   cu_sinonimo                              char(20)           null,
   cu_acceso                                char(1)            null,
   cu_presupuesto                           char(1)            null)
end
go

print '-->Tabla: cb_cuenta_proceso'
if not exists (select 1 from sysobjects where name = 'cb_cuenta_proceso' and type = 'U') begin
   create table cb_cuenta_proceso(
   cp_proceso                               int                not null,
   cp_empresa                               tinyint            not null,
   cp_cuenta                                cuenta_contable    not null,
   cp_oficina                               smallint           null,
   cp_area                                  smallint           null,
   cp_imprima                               char(1)            null,
   cp_condicion                             char(4)            null,
   cp_texto                                 descripcion        null,
   cp_quiebre                               char(10)           null)
end
go

print '-->Tabla: cb_det_perfil'
if not exists (select 1 from sysobjects where name = 'cb_det_perfil' and type = 'U') begin
   create table cb_det_perfil(
   dp_empresa                               tinyint            not null,
   dp_producto                              tinyint            not null,
   dp_perfil                                varchar(20)        not null,
   dp_asiento                               smallint           not null,
   dp_cuenta                                varchar(40)        null,
   dp_area                                  varchar(10)        not null,
   dp_debcred                               char(1)            not null,
   dp_codval                                int                not null,
   dp_tipo_tran                             char(1)            not null,
   dp_origen_dest                           char(1)            null,
   dp_constante                             varchar(3)         null,
   dp_fuente                                char(1)            null)
end
go

print '-->Tabla: cb_empresa'
if not exists (select 1 from sysobjects where name = 'cb_empresa' and type = 'U') begin
   create table cb_empresa(
   em_empresa                               tinyint            not null,
   em_ruc                                   varchar(13)        not null,
   em_descripcion                           varchar(64)        not null,
   em_replegal                              varchar(64)        null,
   em_contgen                               varchar(64)        null,
   em_moneda_base                           tinyint            not null,
   em_abreviatura                           char(16)           null,
   em_direccion                             varchar(64)        not null,
   em_matcontgen                            char(10)           not null,
   em_revisor                               varchar(64)        not null,
   em_matrevisor                            char(10)           not null,
   em_emp_revisor                           descripcion        null,
   em_nit_emprev                            varchar(13)        null,
   em_mat_revisor                           char(10)           null)
end
go

print '-->Tabla: cb_exencion_ciudad'
if not exists (select 1 from sysobjects where name = 'cb_exencion_ciudad' and type = 'U') begin
   create table cb_exencion_ciudad(
   ec_empresa                               tinyint            not null,
   ec_impuesto                              char(1)            not null,
   ec_concepto                              char(4)            not null,
   ec_debcred                               char(1)            not null,
   ec_ciudad                                int                not null,
   ec_ofi_orig                              char(1)            null,
   ec_ofi_dest                              char(1)            null)
end
go

print '-->Tabla: cb_exencion_producto'
if not exists (select 1 from sysobjects where name = 'cb_exencion_producto' and type = 'U') begin
   create table cb_exencion_producto(
   ep_empresa                               tinyint            not null,
   ep_regimen                               catalogo           not null,
   ep_producto                              tinyint            not null,
   ep_impuesto                              char(1)            not null,
   ep_concepto                              char(4)            not null)
end
go

print '-->Tabla: cb_ica'
if not exists (select 1 from sysobjects where name = 'cb_ica' and type = 'U') begin
   create table cb_ica(
   ic_empresa                               tinyint            not null,
   ic_codigo                                char(4)            not null,
   ic_descripcion                           varchar(255)       not null,
   ic_base                                  money              null,
   ic_porcentaje                            float              null,
   ic_ciudad                                int                null,
   ic_debcred                               char(1)            not null)
end
go

print '-->Tabla: cb_iva'
if not exists (select 1 from sysobjects where name = 'cb_iva' and type = 'U') begin
   create table cb_iva(
   iva_empresa                              tinyint            not null,
   iva_codigo                               char(4)            not null,
   iva_descripcion                          varchar(150)       not null,
   iva_base                                 money              null,
   iva_porcentaje                           float              null,
   iva_descontado                           char(1)            null,
   iva_des_porcen                           float              null,
   iva_debcred                              char(1)            not null,
   iva_porc_espec                           float              not null)
end
go
 
print '-->Tabla: cb_iva_pagado'
if not exists (select 1 from sysobjects where name = 'cb_iva_pagado' and type = 'U') begin
   create table cb_iva_pagado(
   ip_empresa                               tinyint            not null,
   ip_codigo                                char(4)            not null,
   ip_descripcion                           varchar(150)       not null,
   ip_porcentaje                            float              null,
   ip_debcred                               char(1)            not null,
   ip_base                                  money              null)
end
go

print '-->Tabla: cb_oficina'
if not exists (select 1 from sysobjects where name = 'cb_oficina' and type = 'U') begin
   create table cb_oficina(
   of_empresa                               tinyint            not null,
   of_oficina                               smallint           not null,
   of_descripcion                           descripcion        not null,
   of_oficina_padre                         smallint           null,
   of_estado                                char(1)            not null,
   of_fecha_estado                          datetime           null,
   of_organizacion                          tinyint            not null,
   of_consolida                             char(1)            not null,
   of_movimiento                            char(1)            not null,
   of_codigo                                descripcion        null)
end
go

print '-->Tabla: cb_parametro'
if not exists (select 1 from sysobjects where name = 'cb_parametro' and type = 'U') begin
   create table cb_parametro(
   pa_empresa                               tinyint            not null,
   pa_parametro                             varchar(10)        not null,
   pa_descripcion                           descripcion        not null,
   pa_stored                                varchar(20)        not null,
   pa_transaccion                           int                not null)
end
go

print '-->Tabla: cb_perfil'
if not exists (select 1 from sysobjects where name = 'cb_perfil' and type = 'U') begin
   create table cb_perfil(
   pe_empresa                               tinyint            not null,
   pe_producto                              tinyint            not null,
   pe_perfil                                varchar(20)        not null,
   pe_descripcion                           descripcion        not null)
end
go

print '-->Tabla: cb_periodo'
if not exists (select 1 from sysobjects where name = 'cb_periodo' and type = 'U') begin
   create table cb_periodo(
   pe_periodo                               int                not null,
   pe_empresa                               tinyint            not null,
   pe_fecha_inicio                          datetime           not null,
   pe_fecha_fin                             datetime           not null,
   pe_estado                                char(1)            not null,
   pe_tipo_periodo                          char(10)           not null)
end
go

print '-->Tabla: cb_producto'
if not exists (select 1 from sysobjects where name = 'cb_producto' and type = 'U') begin
   create table cb_producto(
   pr_empresa                               tinyint            not null,
   pr_producto                              tinyint            not null,
   pr_online                                char(1)            not null,
   pr_estado                                char(1)            not null,
   pr_resumen                               char(1)            not null,
   pr_fecha_mod                             datetime           not null)
end
go

print '-->Tabla: cb_regimen_fiscal'
if not exists (select 1 from sysobjects where name = 'cb_regimen_fiscal' and type = 'U') begin
   create table cb_regimen_fiscal(
   rf_codigo                                catalogo           not null,
   rf_descripcion                           descripcion        not null,
   rf_iva                                   char(1)            not null,
   rf_timbre                                char(1)            not null,
   rf_renta                                 char(1)            not null,
   rf_ica                                   char(1)            not null,
   rf_iva_des                               char(1)            not null,
   rf_iva_cobrado                           char(1)            not null,
   rf_estampillas                           char(1)            not null,
   rf_3xm                                   char(1)            not null,
   rf_estado                                char(1)            not null,
   rf_retencion_iva                         char(1)            not null,
   rf_naturaleza                            char(1)            not null,
   rf_grancontribuyente                     char(1)            not null,
   rf_autorretenedor                        char(1)            not null)
end
go

print '-->Tabla: cb_relofi'
if not exists (select 1 from sysobjects where name = 'cb_relofi' and type = 'U') begin
   create table cb_relofi(
   re_filial                                tinyint            not null,
   re_empresa                               tinyint            not null,
   re_ofadmin                               smallint           not null,
   re_ofconta                               smallint           not null)
end
go

print '-->Tabla: cb_relparam'
if not exists (select 1 from sysobjects where name = 'cb_relparam' and type = 'U') begin
   create table cb_relparam(
   re_empresa                               tinyint            not null,
   re_parametro                             varchar(10)        not null,
   re_clave                                 varchar(20)        not null,
   re_substring                             cuenta             not null,
   re_producto                              tinyint            null,
   re_tipo_area                             varchar(10)        null,
   re_origen_dest                           char(1)            null)
end
go

print '-->Tabla: cb_saldo'
if not exists (select 1 from sysobjects where name = 'cb_saldo' and type = 'U') begin
   create table cb_saldo(
   sa_empresa                               tinyint            not null,
   sa_cuenta                                cuenta_contable    not null,
   sa_oficina                               smallint           not null,
   sa_area                                  smallint           not null,
   sa_corte                                 int                not null,
   sa_periodo                               int                not null,
   sa_saldo                                 money              null,
   sa_saldo_me                              money              null,
   sa_debito                                money              null,
   sa_credito                               money              null,
   sa_debito_me                             money              null,
   sa_credito_me                            money              null)
end
go

print '-->Tabla: cb_seqnos'
if not exists (select 1 from sysobjects where name = 'cb_seqnos' and type = 'U') begin
   create table cb_seqnos(
   bdatos                                   varchar(30)        null,
   tabla                                    varchar(30)        not null,
   siguiente                                int                null,
   pkey                                     varchar(30)        null,
   empresa                                  tinyint            null)
end
go

print '-->Tabla: cb_seqnos_comprobante'
if not exists (select 1 from sysobjects where name = 'cb_seqnos_comprobante' and type = 'U') begin
   create table cb_seqnos_comprobante(
   sc_empresa                               tinyint            not null,
   sc_fecha                                 datetime           not null,
   sc_tabla                                 varchar(30)        not null,
   sc_actual                                int                not null,
   sc_modulo                                tinyint            not null,
   sc_oficina                               smallint           null)
end
go

print '-->Tabla: cb_tipo_area'
if not exists (select 1 from sysobjects where name = 'cb_tipo_area' and type = 'U') begin
   create table cb_tipo_area(
   ta_empresa                               tinyint            not null,
   ta_producto                              tinyint            not null,
   ta_tiparea                               varchar(10)        not null,
   ta_utiliza_valor                         char(1)            not null,
   ta_area                                  smallint           null,
   ta_descripcion                           descripcion        null,
   ta_ofi_central                           smallint           null)
end
go

print ''
print 'Fin Ejecucion Creacion de Tablas de Dependencias de Plazo Fijo : ' + convert(varchar(60),getdate(),109)
print ''