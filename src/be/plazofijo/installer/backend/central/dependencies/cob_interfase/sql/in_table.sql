/************************************************************************/
/*                 Descripcion                                          */
/*  Script para creacion de tablas de Dependencias de Plazo Fijo        */
/************************************************************************/
/*                                                                      */
/*  Fecha         Autor               Comentario                        */
/*  15/07/2016    Oscar Saavedra      Instalador Version Davivienda     */
/************************************************************************/
use cob_interfase
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

print '-->Tabla: in_interfases'
if not exists (select 1 from sysobjects where name = 'in_interfases' and type = 'U') begin
   create table in_interfases(
   in_fecha                                 datetime           NULL,
   in_secuencial                            int                NULL,
   in_tipo_transaccion                      smallint           NULL,
   in_usuario                               login              NULL,
   in_terminal                              descripcion        NULL,
   in_sesn                                  int                NULL,
   in_srv                                   varchar(30)        NULL,
   in_lsrv                                  varchar(30)        NULL,
   in_ofi                                   tinyint            NULL,
   in_ssn_corr                              int                NULL,
   in_tabla                                 tinyint            NULL,
   in_cuenta_01                             cuenta             NULL,
   in_cuenta_02                             cuenta             NULL,
   in_catalogo_01                           catalogo           NULL,
   in_catalogo_02                           catalogo           NULL,
   in_login_01                              login              NULL,
   in_login_02                              login              NULL,
   in_descripcion_01                        descripcion        NULL,
   in_tinyint_01                            tinyint            NULL,
   in_tinyint_02                            tinyint            NULL,
   in_tinyint_03                            tinyint            NULL,
   in_int_01                                int                NULL,
   in_int_02                                int                NULL,
   in_int_03                                int                NULL,
   in_smallint_01                           smallint           NULL,
   in_smallint_02                           smallint           NULL,
   in_smallint_03                           smallint           NULL,
   in_smalldatetime_01                      smalldatetime      NULL,
   in_smalldatetime_02                      smalldatetime      NULL,
   in_datetime_01                           datetime           NULL,
   in_datetime_02                           datetime           NULL,
   in_float_01                              float              NULL,
   in_float_02                              float              NULL,
   in_money_01                              money              NULL,
   in_money_02                              money              NULL,
   in_money_03                              money              NULL,
   in_money_04                              money              NULL,
   in_money_05                              money              NULL,
   in_money_06                              money              NULL,
   in_money_07                              money              NULL,
   in_money_08                              money              NULL,
   in_money_09                              money              NULL,
   in_char1_01                              char(1)            NULL,
   in_char1_02                              char(1)            NULL,
   in_char3_01                              char(3)            NULL,
   in_char2_01                              char(2)            NULL,
   in_char30_01                             char(30)           NULL,
   in_char16_01                             char(16)           NULL,
   in_char14_01                             char(14)           NULL,
   in_varchar255_01                         varchar(255)       NULL,
   in_varchar120_01                         varchar(120)       NULL,
   in_varchar30_01                          varchar(30)        NULL,
   in_varchar12_01                          varchar(12)        NULL,
   in_varchar4_01                           varchar(4)         NULL,
   in_varchar3_01                           varchar(3)         NULL,
   in_varchar3_02                           varchar(3)         NULL,
   in_varchar5_01                           varchar(5)         NULL,
   in_varchar9_01                           varchar(9)         NULL,
   in_estado_01                             estado             NULL)
end
go

print ''
print 'Fin Ejecucion Creacion de Tablas de Dependencias de Plazo Fijo : ' + convert(varchar(60),getdate(),109)
print ''