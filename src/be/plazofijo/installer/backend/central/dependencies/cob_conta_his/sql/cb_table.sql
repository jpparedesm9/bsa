/************************************************************************/
/*                 Descripcion                                          */
/*  Script para creacion de tablas de Dependencias de Plazo Fijo        */
/************************************************************************/
/*                                                                      */
/*  Fecha         Autor               Comentario                        */
/*  15/07/2016    Oscar Saavedra      Instalador Version Davivienda     */
/************************************************************************/
use cob_conta_his
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

print '-->Tabla: cb_hist_saldo'
if not exists (select 1 from sysobjects where name = 'cb_hist_saldo' and type = 'U') begin
   create table cb_hist_saldo(
   hi_empresa                               tinyint            NOT NULL,
   hi_cuenta                                char(14)           NOT NULL,
   hi_oficina                               smallint           NOT NULL,
   hi_area                                  smallint           NOT NULL,
   hi_corte                                 int                NOT NULL,
   hi_periodo                               int                NOT NULL,
   hi_saldo                                 money              NULL,
   hi_saldo_me                              money              NULL,
   hi_debito                                money              NULL,
   hi_credito                               money              NULL,
   hi_debito_me                             money              NULL,
   hi_credito_me                            money              NULL)
end
go

print ''
print 'Fin Ejecucion Creacion de Tablas de Dependencias de Plazo Fijo : ' + convert(varchar(60),getdate(),109)
print ''