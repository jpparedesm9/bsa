/************************************************************************/
/*                 Descripcion                                          */
/*  Script para creacion de tablas de Dependencias de Plazo Fijo        */
/************************************************************************/
/*                                                                      */
/*  Fecha         Autor               Comentario                        */
/*  15/07/2016    Oscar Saavedra      Instalador Version Davivienda     */
/************************************************************************/
use cob_externos
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

print '-->Tabla: ex_dato_cuota_pry'
if not exists (select 1 from sysobjects where name = 'ex_dato_cuota_pry' and type = 'U') begin
   create table ex_dato_cuota_pry(
   dc_fecha                                 smalldatetime      NOT NULL,
   dc_banco                                 varchar(24)        NOT NULL,
   dc_toperacion                            varchar(10)        NOT NULL,
   dc_aplicativo                            tinyint            NOT NULL,
   dc_num_cuota                             int                NOT NULL,
   dc_fecha_vto                             smalldatetime      NOT NULL,
   dc_estado                                char(1)            NOT NULL,
   dc_valor_pry                             money              NOT NULL)
end
go

print '-->Tabla: ex_dato_deudores'
if not exists (select 1 from sysobjects where name = 'ex_dato_deudores' and type = 'U') begin
   create table ex_dato_deudores(
   de_fecha                                 smalldatetime      NOT NULL,
   de_banco                                 varchar(24)        NOT NULL,
   de_toperacion                            varchar(10)        NOT NULL,
   de_aplicativo                            tinyint            NOT NULL,
   de_cliente                               int                NOT NULL,
   de_rol                                   char(1)            NOT NULL)
end
go

print '-->Tabla: ex_dato_pasivas'
if not exists (select 1 from sysobjects where name = 'ex_dato_pasivas' and type = 'U') begin
   create table ex_dato_pasivas(
   dp_fecha                                 datetime           NOT NULL,
   dp_banco                                 varchar(24)        NOT NULL,
   dp_toperacion                            varchar(10)        NOT NULL,
   dp_aplicativo                            tinyint            NOT NULL,
   dp_categoria_producto                    varchar(10)        NOT NULL,
   dp_naturaleza_cliente                    char(1)            NOT NULL,
   dp_cliente                               int                NOT NULL,
   dp_documento_tipo                        char(2)            NULL,
   dp_documento_numero                      varchar(24)        NULL,
   dp_oficina                               smallint           NOT NULL,
   dp_oficial                               smallint           NOT NULL,
   dp_moneda                                tinyint            NOT NULL,
   dp_monto                                 money              NOT NULL,
   dp_tasa                                  float              NULL,
   dp_modalidad                             char(1)            NULL,
   dp_plazo_dias                            int                NULL,
   dp_fecha_apertura                        datetime           NOT NULL,
   dp_fecha_radicacion                      datetime           NOT NULL,
   dp_fecha_vencimiento                     datetime           NULL,
   dp_num_renovaciones                      int                NULL,
   dp_estado                                tinyint            NOT NULL,
   dp_razon_cancelacion                     varchar(10)        NULL,
   dp_num_cuotas                            smallint           NOT NULL,
   dp_periodicidad_cuota                    smallint           NOT NULL,
   dp_saldo_disponible                      money              NOT NULL,
   dp_saldo_int                             money              NOT NULL,
   dp_saldo_camara12h                       money              NOT NULL,
   dp_saldo_camara24h                       money              NOT NULL,
   dp_saldo_camara48h                       money              NOT NULL,
   dp_saldo_remesas                         money              NOT NULL,
   dp_condicion_manejo                      char(1)            NULL,
   dp_exen_gmf                              char(1)            NULL,
   dp_fecha_ini_exen_gmf                    datetime           NULL,
   dp_fecha_fin_exen_gmf                    datetime           NULL,
   dp_tesoro_nacional                       char(1)            NULL,
   dp_ley_exen                              varchar(10)        NULL,
   dp_tasa_variable                         char(1)            NULL,
   dp_referencial_tasa                      catalogo           NULL,
   dp_signo_spread                          char(1)            NULL,
   dp_spread                                float              NULL,
   dp_signo_puntos                          char(1)            NULL,
   dp_puntos                                float              NULL,
   dp_signo_tasa_ref                        char(1)            NULL,
   dp_puntos_tasa_ref                       float              NULL)
end
go

print '-->Tabla: ex_dato_rubro_pry'
if not exists (select 1 from sysobjects where name = 'ex_dato_rubro_pry' and type = 'U') begin
   create table ex_dato_rubro_pry(
   dr_fecha                                 smalldatetime      NOT NULL,
   dr_banco                                 varchar(24)        NOT NULL,
   dr_toperacion                            varchar(10)        NOT NULL,
   dr_aplicativo                            tinyint            NOT NULL,
   dr_num_cuota                             int                NOT NULL,
   dr_concepto                              varchar(10)        NOT NULL,
   dr_estado                                varchar(1)         NOT NULL,
   dr_valor_pry                             money              NOT NULL)
end
go

print '-->Tabla: ex_dato_transaccion'
if not exists (select 1 from sysobjects where name = 'ex_dato_transaccion' and type = 'U') begin
   create table ex_dato_transaccion(
   dt_fecha                                 smalldatetime      NOT NULL,
   dt_secuencial                            int                NOT NULL,
   dt_banco                                 varchar(24)        NOT NULL,
   dt_toperacion                            varchar(10)        NOT NULL,
   dt_aplicativo                            tinyint            NOT NULL,
   dt_fecha_trans                           smalldatetime      NOT NULL,
   dt_tipo_trans                            varchar(10)        NOT NULL,
   dt_reversa                               varchar(1)         NOT NULL,
   dt_naturaleza                            varchar(1)         NOT NULL,
   dt_canal                                 varchar(10)        NOT NULL,
   dt_oficina                               smallint           NULL,
   dt_secuencial_caja                       int                NULL,
   dt_usuario                               login              NULL,
   dt_terminal                              varchar(20)        NULL,
   dt_fecha_hora                            datetime           NULL)
end
go

print '-->Tabla: ex_dato_transaccion_det'
if not exists (select 1 from sysobjects where name = 'ex_dato_transaccion_det' and type = 'U') begin
   create table ex_dato_transaccion_det(
   dd_fecha                                 smalldatetime      NOT NULL,
   dd_secuencial                            int                NOT NULL,
   dd_banco                                 varchar(24)        NOT NULL,
   dd_toperacion                            varchar(10)        NOT NULL,
   dd_aplicativo                            tinyint            NOT NULL,
   dd_concepto                              varchar(10)        NOT NULL,
   dd_moneda                                int                NOT NULL,
   dd_cotizacion                            float              NOT NULL,
   dd_monto                                 money              NOT NULL,
   dd_codigo_valor                          cuenta             NULL)
end
go


print ''
print 'Fin Ejecucion Creacion de Tablas de Dependencias de Plazo Fijo : ' + convert(varchar(60),getdate(),109)
print ''