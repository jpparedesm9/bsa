/************************************************************************/
/*                 Descripcion                                          */
/*  Script para creacion de tablas                                      */
/************************************************************************/
/*                                                                      */
/*  Fecha         Autor               Comentario                        */
/*  20/10/2016    Nancy Martillo      Instalador Version Davivienda para*/
/*                                    tablas de reportes                */
/************************************************************************/
use cob_reportes
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
print 'Inicio Ejecucion Creacion de Tablas para reportes : ' + convert(varchar(60),getdate(),109)
print ''

print '-->Tabla: rep_dpf_bloqueos'
if exists (select 1 from sysobjects where name = 'rep_dpf_bloqueos' and type = 'U')
   drop table rep_dpf_bloqueos

create table rep_dpf_bloqueos(
bl_regional              smallint               null,
bl_des_regional          descripcion            null,
bl_zona                  smallint               null,
bl_des_zona              descripcion            null,
bl_oficina               smallint               null,
bl_des_oficina           descripcion            null,
bl_toperacion            catalogo               null,
bl_fecha_valor           datetime               null,
bl_num_banco             cuenta                 null,
bl_descripcion           varchar(255)           null,
bl_oficial_principal     varchar(80)            null,
bl_monto                 money                  null,
bl_monto_mn              money                  null,
bl_motivo_ret            descripcion            null,
bl_valor_bloq            money                  null,
bl_valor_bloq_mn         money                  null,
bl_funcionario           login                  null,
bl_fecha_crea            datetime               null,
bl_moneda                tinyint                null,
bl_desc_moneda           descripcion            null)
go

print '-->Tabla: rep_dpf_loger'
if exists (select 1 from sysobjects where name = 'rep_dpf_loger' and type = 'U')
   drop table rep_dpf_loger

create table rep_dpf_loger(
lo_fecha_proc              datetime           null,
lo_cuenta                  cuenta             null,
lo_nombre                  varchar(255)       null,
lo_id_error                int                null,
lo_mensaje_error           varchar(132)       null,
lo_descripcion             mensaje            null,
lo_cta_pagrec              cuenta             null,
lo_tran                    int                null,
lo_usuario                 login              null)
go


print '*********************************'
print '*****  CREACION DE INDICES ******'
print '*********************************'
print ''
print 'Inicio Ejecucion Creacion de Indices para Tablas de Reportes : ' + convert(varchar(60),getdate(),109)
print ''

print '--> Indice: [rep_dpf_loger].[rep_dpf_loger_Key]'
if exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[rep_dpf_loger]') and name = N'rep_dpf_loger_Key')
   drop index [rep_dpf_loger_Key] on [rep_dpf_loger] with (ONLINE = OFF)

CREATE CLUSTERED INDEX [rep_dpf_loger_Key] ON [dbo].[rep_dpf_loger](lo_fecha_proc ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =100) ON [PRIMARY];
go