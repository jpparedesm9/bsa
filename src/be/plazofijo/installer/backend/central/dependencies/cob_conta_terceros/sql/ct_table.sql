/************************************************************************/
/*                 Descripcion                                          */
/*  Script para creacion de tablas de Dependencias de Plazo Fijo        */
/************************************************************************/
/*                                                                      */
/*  Fecha         Autor               Comentario                        */
/*  15/07/2016    Oscar Saavedra      Instalador Version Davivienda     */
/************************************************************************/
use cob_conta_tercero

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

print '-->Tabla: ct_saldo_tercero'
if not exists (select 1 from sysobjects where name = 'ct_saldo_tercero' and type = 'U') begin
   create table ct_saldo_tercero(
   st_empresa                               int                not null,
   st_periodo                               int                not null,
   st_corte                                 int                not null,
   st_cuenta                                cuenta_contable    not null,
   st_oficina                               smallint           not null,
   st_area                                  smallint           not null,
   st_ente                                  int                not null,
   st_saldo                                 money              not null,
   st_saldo_me                              money              not null,
   st_mov_debito                            money              not null,
   st_mov_credito                           money              not null,
   st_mov_debito_me                         money              not null,
   st_mov_credito_me                        money              not null)
end
go

print '-->Tabla: ct_sasiento'
if not exists (select 1 from sysobjects where name = 'ct_sasiento' and type = 'U') begin
   create table ct_sasiento(
   sa_producto                              tinyint            not null,
   sa_comprobante                           int                not null,
   sa_empresa                               tinyint            not null,
   sa_fecha_tran                            datetime           not null,
   sa_asiento                               int                not null,
   sa_cuenta                                char(14)           not null,
   sa_oficina_dest                          smallint           not null,
   sa_area_dest                             smallint           not null,
   sa_credito                               money              null,
   sa_debito                                money              null,
   sa_concepto                              varchar(160)       not null,
   sa_credito_me                            money              null,
   sa_debito_me                             money              null,
   sa_cotizacion                            money              null,
   sa_tipo_doc                              char(1)            not null,
   sa_tipo_tran                             char(1)            not null,
   sa_moneda                                tinyint            null,
   sa_opcion                                tinyint            null,
   sa_ente                                  int                null,
   sa_con_rete                              char(4)            null,
   sa_base                                  money              null,
   sa_valret                                money              null,
   sa_con_iva                               char(4)            null,
   sa_valor_iva                             money              null,
   sa_iva_retenido                          money              null,
   sa_con_ica                               char(4)            null,
   sa_valor_ica                             money              null,
   sa_con_timbre                            char(4)            null,
   sa_valor_timbre                          money              null,
   sa_con_iva_reten                         char(4)            null,
   sa_con_ivapagado                         char(4)            null,
   sa_valor_ivapagado                       money              null,
   sa_documento                             char(24)           null,
   sa_mayorizado                            char(1)            not null,
   sa_origen_mvto                           varchar(20)        null,
   sa_con_dptales                           char(4)            null,
   sa_valor_dptales                         money              null,
   sa_posicion                              char(1)            null,
   sa_debcred                               char(1)            null,
   sa_oper_banco                            char(4)            null,
   sa_cheque                                varchar(64)        null,
   sa_doc_banco                             char(20)           null,
   sa_fecha_est                             datetime           null,
   sa_detalle                               smallint           null,
   sa_error                                 char(1)            null,
   sa_fecha_fin_difer                       datetime           null,
   sa_plazo_difer                           int                null,
   sa_desc_difer                            varchar(160)       null,
   sa_fecha_fin_difer_fiscal                datetime           null,
   sa_plazo_difer_fiscal                    int                null)
end
go

print '-->Tabla: ct_sasiento_tmp'
if not exists (select 1 from sysobjects where name = 'ct_sasiento_tmp' and type = 'U') begin
   create table ct_sasiento_tmp(
   sa_producto                              tinyint            not null,
   sa_comprobante                           int                not null,
   sa_empresa                               tinyint            not null,
   sa_fecha_tran                            datetime           not null,
   sa_asiento                               int                not null,
   sa_cuenta                                cuenta_contable    not null,
   sa_oficina_dest                          smallint           not null,
   sa_area_dest                             smallint           not null,
   sa_credito                               money              null,
   sa_debito                                money              null,
   sa_concepto                              descripcion        not null,
   sa_credito_me                            money              null,
   sa_debito_me                             money              null,
   sa_cotizacion                            money              null,
   sa_tipo_doc                              char(1)            not null,
   sa_tipo_tran                             char(1)            not null,
   sa_moneda                                tinyint            null,
   sa_opcion                                tinyint            null,
   sa_ente                                  int                null,
   sa_con_rete                              char(4)            null,
   sa_base                                  money              null,
   sa_valret                                money              null,
   sa_con_iva                               char(4)            null,
   sa_valor_iva                             money              null,
   sa_iva_retenido                          money              null,
   sa_con_ica                               char(4)            null,
   sa_valor_ica                             money              null,
   sa_con_timbre                            char(4)            null,
   sa_valor_timbre                          money              null,
   sa_con_iva_reten                         char(4)            null,
   sa_con_ivapagado                         char(4)            null,
   sa_valor_ivapagado                       money              null,
   sa_documento                             char(24)           null,
   sa_mayorizado                            char(1)            not null,
   sa_origen_mvto                           varchar(20)        null,
   sa_con_dptales                           char(4)            null,
   sa_valor_dptales                         money              null,
   sa_posicion                              char(1)            null,
   sa_debcred                               char(1)            null,
   sa_oper_banco                            char(4)            null,
   sa_cheque                                varchar(64)        null,
   sa_doc_banco                             char(20)           null,
   sa_fecha_est                             datetime           null,
   sa_detalle                               smallint           null,
   sa_error                                 char(1)            null,
   sa_fecha_fin_difer                       datetime           null,
   sa_plazo_difer                           int                null,
   sa_desc_difer                            descripcion        null,
   sa_fecha_fin_difer_fiscal                datetime           null,
   sa_plazo_difer_fiscal                    int                null)
end
go

print '-->Tabla: ct_scomprobante'
if not exists (select 1 from sysobjects where name = 'ct_scomprobante' and type = 'U') begin
   create table ct_scomprobante(
   sc_producto                              tinyint            not null,
   sc_comprobante                           int                not null,
   sc_empresa                               tinyint            not null,
   sc_fecha_tran                            datetime           not null,
   sc_oficina_orig                          smallint           not null,
   sc_area_orig                             smallint           not null,
   sc_fecha_gra                             datetime           not null,
   sc_digitador                             varchar(160)       not null,
   sc_descripcion                           varchar(160)       not null,
   sc_perfil                                varchar(20)        not null,
   sc_detalles                              int                not null,
   sc_tot_debito                            money              not null,
   sc_tot_credito                           money              not null,
   sc_tot_debito_me                         money              not null,
   sc_tot_credito_me                        money              not null,
   sc_automatico                            int                null,
   sc_reversado                             char(1)            not null,
   sc_estado                                char(1)            not null,
   sc_mayorizado                            char(1)            not null,
   sc_observaciones                         varchar(160)       null,
   sc_comp_definit                          int                null,
   sc_usuario_modulo                        varchar(160)       not null,
   sc_causa_error                           char(30)           null,
   sc_comp_origen                           int                null,
   sc_tran_modulo                           varchar(20)        null,
   sc_error                                 char(1)            null)
end
go

print '-->Tabla: ct_scomprobante_tmp'
if not exists (select 1 from sysobjects where name = 'ct_scomprobante_tmp' and type = 'U') begin
   create table ct_scomprobante_tmp(
   sc_producto                              tinyint            not null,
   sc_comprobante                           int                not null,
   sc_empresa                               tinyint            not null,
   sc_fecha_tran                            datetime           not null,
   sc_oficina_orig                          smallint           not null,
   sc_area_orig                             smallint           not null,
   sc_fecha_gra                             datetime           not null,
   sc_digitador                             descripcion        not null,
   sc_descripcion                           descripcion        not null,
   sc_perfil                                varchar(20)        not null,
   sc_detalles                              int                not null,
   sc_tot_debito                            money              not null,
   sc_tot_credito                           money              not null,
   sc_tot_debito_me                         money              not null,
   sc_tot_credito_me                        money              not null,
   sc_automatico                            int                null,
   sc_reversado                             char(1)            not null,
   sc_estado                                char(1)            not null,
   sc_mayorizado                            char(1)            not null,
   sc_observaciones                         descripcion        null,
   sc_comp_definit                          int                null,
   sc_usuario_modulo                        descripcion        not null,
   sc_causa_error                           char(30)           null,
   sc_comp_origen                           int                null,
   sc_tran_modulo                           varchar(20)        null,
   sc_error                                 char(1)            null)
end
go

print ''
print 'Fin Ejecucion Creacion de Tablas de Dependencias de Plazo Fijo : ' + convert(varchar(60),getdate(),109)
print ''
