/************************************************************************/
/*                 Descripcion                                          */
/*  Script para creacion de tablas de Dependencias de Plazo Fijo        */
/************************************************************************/
/*                                                                      */
/*  Fecha         Autor               Comentario                        */
/*  15/07/2016    Oscar Saavedra      Instalador Version Davivienda     */
/************************************************************************/
use cob_ccontable
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

print '-->Tabla: cco_boc'
if not exists (select 1 from sysobjects where name = 'cco_boc' and type = 'U') begin
   create table cco_boc(
   bo_empresa                               tinyint            NOT NULL,
   bo_producto                              tinyint            NOT NULL,
   bo_fecha                                 datetime           NOT NULL,
   bo_cuenta                                cuenta             NOT NULL,
   bo_oficina                               smallint           NOT NULL,
   bo_area                                  smallint           NOT NULL,
   bo_moneda                                tinyint            NOT NULL,
   bo_val_opera_mn                          money              NOT NULL,
   bo_val_opera_me                          money              NULL,
   bo_val_conta_mn                          money              NULL,
   bo_val_conta_me                          money              NULL,
   bo_diferencia_mn                         money              NULL,
   bo_diferencia_me                         money              NULL,
   bo_tipo                                  char(1)            NOT NULL)
end
go

print '-->Tabla: cco_boc_det'
if not exists (select 1 from sysobjects where name = 'cco_boc_det' and type = 'U') begin
   create table cco_boc_det(
   bo_empresa                               tinyint            NOT NULL,
   bo_producto                              tinyint            NOT NULL,
   bo_fecha                                 datetime           NOT NULL,
   bo_cuenta                                cuenta             NOT NULL,
   bo_oficina                               smallint           NOT NULL,
   bo_area                                  smallint           NOT NULL,
   bo_operacion                             cuenta             NOT NULL,
   bo_adicional                             descripcion        NOT NULL,
   bo_moneda                                tinyint            NOT NULL,
   bo_val_opera_mn                          money              NOT NULL,
   bo_val_opera_me                          money              NULL,
   bo_val_conta_mn                          money              NULL,
   bo_val_conta_me                          money              NULL,
   bo_diferencia_mn                         money              NULL,
   bo_diferencia_me                         money              NULL,
   bo_tipo                                  char(1)            NOT NULL)
end

print '-->Tabla: cco_error_conaut'
if not exists (select 1 from sysobjects where name = 'cco_error_conaut' and type = 'U') begin
   create table cco_error_conaut(
   ec_secuencial                            numeric(8, 0) IDENTITY(1,1) NOT NULL,
   ec_empresa                               tinyint            NOT NULL,
   ec_producto                              tinyint            NOT NULL,
   ec_fecha_conta                           datetime           NOT NULL,
   ec_numerror                              int                NOT NULL,
   ec_fecha                                 datetime           NOT NULL,
   ec_tran_modulo                           varchar(20)        NOT NULL,
   ec_asiento                               int                NOT NULL,
   ec_mensaje                               descripcion        NOT NULL,
   ec_perfil                                varchar(20)        NULL,
   ec_oficina                               smallint           NULL,
   ec_valor                                 money              NULL,
   ec_comprobante                           int                NULL)
end

print '-->Tabla: cco_error_conaut_his'
if not exists (select 1 from sysobjects where name = 'cco_error_conaut_his' and type = 'U') begin
   create table cco_error_conaut_his(
   eh_empresa                               tinyint            NOT NULL,
   eh_producto                              tinyint            NOT NULL,
   eh_fecha_conta                           datetime           NOT NULL,
   eh_secuencial                            int                NOT NULL,
   eh_fecha                                 datetime           NOT NULL,
   eh_tran_modulo                           varchar(20)        NOT NULL,
   eh_asiento                               int                NOT NULL,
   eh_numerror                              int                NULL,
   eh_mensaje                               descripcion        NOT NULL,
   eh_perfil                                varchar(20)        NULL,
   eh_oficina                               smallint           NULL,
   eh_valor                                 money              NULL,
   eh_comprobante                           int                NULL)
end

print ''
print 'Fin Ejecucion Creacion de Tablas de Dependencias de Plazo Fijo : ' + convert(varchar(60),getdate(),109)
print '' 