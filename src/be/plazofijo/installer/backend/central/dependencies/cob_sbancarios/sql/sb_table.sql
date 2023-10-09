/************************************************************************/
/*                 Descripcion                                          */
/*  Script para creacion de tablas de Dependencias de Plazo Fijo        */
/************************************************************************/
/*                                                                      */
/*  Fecha         Autor               Comentario                        */
/*  15/07/2016    Oscar Saavedra      Instalador Version Davivienda     */
/************************************************************************/
use cob_sbancarios
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

print '-->Tabla: sb_ctas_comercl'
if not exists (select 1 from sysobjects where name = 'sb_ctas_comercl' and type = 'U') begin
   create table sb_ctas_comercl(
   pcc_secuencial                           int                not null,
   pcc_banco                                smallint           not null,
   pcc_cuenta                               varchar(15)        not null,
   pcc_subtipo                              int                null,
   pcc_nemonico                             varchar(10)        null)
end
go

print '-->Tabla: sb_impresion_lotes'
if not exists (select 1 from sysobjects where name = 'sb_impresion_lotes' and type = 'U') begin
   create table sb_impresion_lotes(
   il_secuencial                            int                not null,
   il_idlote                                int                not null,
   il_archivo                               descripcion        not null,
   il_oficina_origen                        smallint           not null,
   il_oficina_destino                       smallint           not null,
   il_area_origen                           smallint           not null,
   il_estado                                estado             not null,
   il_func_solicitante                      smallint           not null,
   il_fecha_solicitud                       datetime           not null,
   il_func_imprime                          smallint           null,
   il_fecha_impresion                       datetime           null,
   il_func_autorizante                      smallint           null,
   il_producto                              tinyint            not null,
   il_instrumento                           smallint           not null,
   il_subtipo                               int                not null,
   il_serie_literal                         varchar(10)        null,
   il_serie_numerica                        money              null,
   il_valor                                 money              null,
   il_beneficiario                          descripcion        null,
   il_tipo_benef                            estado             null,
   il_sec_origen                            int                null,
   il_idseries                              int                null,
   il_campo1                                varchar(20)        null,
   il_campo2                                varchar(20)        null,
   il_campo3                                varchar(20)        null,
   il_campo4                                varchar(20)        null,
   il_campo5                                varchar(20)        null,
   il_campo6                                varchar(20)        null,
   il_campo7                                varchar(20)        null,
   il_campo8                                varchar(20)        null,
   il_campo9                                varchar(20)        null,
   il_campo10                               varchar(20)        null,
   il_campo11                               varchar(20)        null,
   il_campo12                               varchar(20)        null,
   il_campo13                               varchar(20)        null,
   il_campo14                               varchar(20)        null,
   il_campo15                               varchar(20)        null,
   il_campo16                               varchar(20)        null,
   il_campo17                               varchar(20)        null,
   il_campo18                               varchar(20)        null,
   il_campo19                               varchar(20)        null,
   il_campo20                               varchar(20)        null,
   il_campo21                               varchar(20)        null,
   il_campo22                               varchar(20)        null,
   il_campo23                               varchar(20)        null,
   il_campo24                               varchar(20)        null,
   il_campo25                               varchar(20)        null,
   il_campo26                               varchar(20)        null,
   il_campo27                               varchar(20)        null,
   il_campo28                               varchar(20)        null,
   il_campo29                               varchar(20)        null,
   il_campo30                               varchar(20)        null,
   il_campo31                               varchar(20)        null,
   il_campo32                               varchar(20)        null,
   il_campo33                               varchar(20)        null,
   il_campo34                               varchar(20)        null,
   il_campo35                               varchar(20)        null,
   il_campo36                               varchar(20)        null,
   il_campo37                               varchar(20)        null,
   il_campo38                               varchar(20)        null,
   il_campo39                               varchar(20)        null,
   il_campo40                               varchar(20)        null,
   il_campo41                               varchar(20)        null,
   il_campo42                               varchar(20)        null,
   il_campo43                               varchar(20)        null,
   il_campo44                               varchar(20)        null,
   il_campo45                               varchar(20)        null,
   il_campo46                               descripcion        null,
   il_campo47                               descripcion        null,
   il_campo48                               descripcion        null,
   il_campo49                               descripcion        null,
   il_campo50                               descripcion        null,
   il_recuperado_bh                         estado             null,
   il_referencia                            int                null,
   il_banco                                 smallint           null,
   il_desc_banco                            descripcion        null,
   il_moneda                                tinyint            null,
   il_num_cuenta                            descripcion        null)
end
go

print '-->Tabla: sb_inventario_ins'
if not exists (select 1 from sysobjects where name = 'sb_inventario_ins' and type = 'U') begin
   create table sb_inventario_ins(
   ii_oficina                               smallint           not null,
   ii_producto                              tinyint            not null,
   ii_instrumento                           smallint           not null,
   ii_sub_tipo                              int                not null,
   ii_serie_literal                         varchar(10)        null,
   ii_serie_desde                           money              not null,
   ii_serie_hasta                           money              not null,
   ii_area                                  smallint           not null,
   ii_func_area                             smallint           null,
   ii_asignacion                            char(1)            not null,
   ii_disponible                            int                not null,
   ii_reservado                             int                not null)
end
go

print '-->Tabla: sb_plant_implot'
if not exists (select 1 from sysobjects where name = 'sb_plant_implot' and type = 'U') begin
   create table sb_plant_implot(
   pi_producto                              tinyint            not null,
   pi_instrumento                           smallint           not null,
   pi_subtipo                               int                not null,
   pi_archivo                               char(15)           not null)
end
go

print '-->Tabla: sb_puntos_reorden'
if not exists (select 1 from sysobjects where name = 'sb_puntos_reorden' and type = 'U') begin
   create table sb_puntos_reorden(
   pr_secuencial                            int                not null,
   pr_oficina                               smallint           not null,
   pr_area                                  smallint           not null,
   pr_func_area                             smallint           null,
   pr_fecha_creacion                        datetime           not null,
   pr_func_creador                          smallint           not null,
   pr_fecha_modif                           datetime           not null,
   pr_func_modif                            smallint           not null,
   pr_producto                              tinyint            not null,
   pr_instrumento                           smallint           not null,
   pr_sub_tipo                              int                not null,
   pr_maximo                                int                not null,
   pr_minimo                                int                not null,
   pr_actual                                int                not null,
   pr_cant_fin_dia                          int                not null,
   pr_fecha_conta                           datetime           null,
   pr_ingreso                               int                not null,
   pr_egreso                                int                not null)
end
go

print '-->Tabla: sb_seqnos'
if not exists (select 1 from sysobjects where name = 'sb_seqnos' and type = 'U') begin
   create table sb_seqnos(
   tabla                                    varchar(30)        not null,
   siguiente                                int                not null)
end
go

print '-->Tabla: sb_subtipos_ins'
if not exists (select 1 from sysobjects where name = 'sb_subtipos_ins' and type = 'U') begin
   create table sb_subtipos_ins(
   si_cod_subtipo                           int                not null,
   si_nombre                                varchar(64)        not null,
   si_estado                                char(1)            not null,
   si_cod_producto                          tinyint            not null,
   si_cod_instrumento                       smallint           not null,
   si_forma_calc                            tinyint            not null,
   si_valor_unitario                        money              null,
   si_negociable                            char(1)            not null,
   si_num_automatica                        char(1)            not null,
   si_beneficiario                          char(1)            not null,
   si_enlace_cc                             char(1)            not null,
   si_datos_cheque                          char(1)            not null,
   si_param_oficina                         char(1)            not null)
end
go

print '-->Tabla: sb_subtipos_oficina'
if not exists (select 1 from sysobjects where name = 'sb_subtipos_oficina' and type = 'U') begin
   create table sb_subtipos_oficina(
   so_cod_subtipo                           int                not null,
   so_oficina                               smallint           not null,
   so_secuencial                            int                not null)
end
go

print '-->Tabla: sb_tran_servicio'
if not exists (select 1 from sysobjects where name = 'sb_tran_servicio' and type = 'U') begin
   create table sb_tran_servicio(
   ts_secuencial                            int                null,
   ts_cod_alterno                           int                null,
   ts_tipo_transaccion                      smallint           not null,
   ts_clase                                 char(1)            not null,
   ts_fecha                                 datetime           null,
   ts_hora                                  varchar(10)        null,
   ts_usuario                               login              null,
   ts_terminal                              descripcion        null,
   ts_oficina                               smallint           null,
   ts_tabla                                 varchar(30)        null,
   ts_lsrv                                  varchar(30)        null,
   ts_srv                                   varchar(30)        null,
   ts_tinyint01                             tinyint            null,
   ts_tinyint02                             tinyint            null,
   ts_tinyint03                             tinyint            null,
   ts_tinyint04                             tinyint            null,
   ts_smallint01                            smallint           null,
   ts_smallint02                            smallint           null,
   ts_smallint03                            smallint           null,
   ts_smallint04                            smallint           null,
   ts_smallint05                            smallint           null,
   ts_int01                                 int                null,
   ts_int02                                 int                null,
   ts_int03                                 int                null,
   ts_int04                                 int                null,
   ts_int05                                 int                null,
   ts_money01                               money              null,
   ts_money02                               money              null,
   ts_money03                               money              null,
   ts_money04                               money              null,
   ts_money05                               money              null,
   ts_money06                               money              null,
   ts_float01                               float              null,
   ts_float02                               float              null,
   ts_char101                               char(1)            null,
   ts_char102                               char(1)            null,
   ts_char103                               char(1)            null,
   ts_char104                               char(1)            null,
   ts_char105                               char(1)            null,
   ts_char106                               char(1)            null,
   ts_char107                               char(1)            null,
   ts_char108                               char(1)            null,
   ts_char109                               char(1)            null,
   ts_char110                               char(1)            null,
   ts_char111                               char(1)            null,
   ts_texto                                 varchar(254)       null,
   ts_vchar1001                             varchar(10)        null,
   ts_vchar1002                             varchar(10)        null,
   ts_vchar3001                             varchar(30)        null,
   ts_vchar6401                             varchar(64)        null,
   ts_vchar6402                             varchar(64)        null,
   ts_vchar25501                            varchar(255)       null,
   ts_vchar25502                            varchar(255)       null,
   ts_fecha01                               datetime           null,
   ts_fecha02                               datetime           null)
end
go

print '-->Tabla: sb_utilizados_ins'
if not exists (select 1 from sysobjects where name = 'sb_utilizados_ins' and type = 'U') begin
   create table sb_utilizados_ins(
   ui_secuencial                            int                not null,
   ui_oficina                               smallint           not null,
   ui_producto                              tinyint            not null,
   ui_instrumento                           smallint           not null,
   ui_sub_tipo                              int                not null,
   ui_serie_literal                         varchar(10)        null,
   ui_serie_desde                           money              not null,
   ui_serie_hasta                           money              not null,
   ui_prod_destino                          tinyint            not null,
   ui_funcionario                           smallint           not null,
   ui_fecha_util                            datetime           not null)
end
go

print ''
print 'Fin Ejecucion Creacion de Tablas de Dependencias de Plazo Fijo : ' + convert(varchar(60),getdate(),109)
print ''