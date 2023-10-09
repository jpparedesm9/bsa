/************************************************************************/
/*                 Descripcion                                          */
/*  Script para creacion de Indices Dependencientes de Plazo Fijo       */
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
GO

SET QUOTED_IDENTIFIER ON
GO

print '*********************************'
print '*****  CREACION DE INDICES ******'
print '*********************************'
print ''
print 'Inicio Ejecucion Creacion de Indices de Dependencias de Plazo Fijo : ' + convert(varchar(60),getdate(),109)
print ''

print '--> Indice: [cco_boc].[cco_boc_Key]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[cco_boc]') and name = N'cco_boc_Key')
Begin
   CREATE UNIQUE NONCLUSTERED INDEX [cco_boc_Key] ON [dbo].[cco_boc]([bo_empresa] ASC, [bo_producto] ASC, [bo_fecha] ASC, [bo_cuenta] ASC, [bo_oficina] ASC, [bo_area] ASC, [bo_tipo] ASC)
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
End
go

print '--> Indice: [cco_boc].[cco_boc_OPT2KEY]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[cco_boc]') and name = N'cco_boc_OPT2KEY')
begin
   CREATE NONCLUSTERED INDEX [cco_boc_OPT2KEY] ON [dbo].[cco_boc]([bo_fecha] ASC, [bo_producto] ASC, [bo_tipo] ASC, [bo_empresa] ASC)
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
End
go

print '--> Indice: [cco_boc_det].[cco_boc_det_Key]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[cco_boc_det]') and name = N'cco_boc_det_Key')
Begin
   CREATE UNIQUE NONCLUSTERED INDEX [cco_boc_det_Key] ON [dbo].[cco_boc_det]([bo_fecha] ASC, [bo_empresa] ASC, [bo_producto] ASC, [bo_operacion] ASC, [bo_cuenta] ASC, [bo_oficina] ASC, [bo_area] ASC, [bo_tipo] ASC)
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
End    
go

print '--> Indice: [cco_error_conaut].[cco_boc_det_Key]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[cco_error_conaut]') and name = N'i_cco_error_conaut')
Begin
   CREATE NONCLUSTERED INDEX [i_cco_error_conaut] ON [dbo].[cco_error_conaut]([ec_empresa] ASC, [ec_producto] ASC, [ec_fecha_conta] ASC, [ec_tran_modulo] ASC)
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
End
go

print '--> Indice: [cco_error_conaut_his].[i_cco_error_conaut_his]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[cco_error_conaut_his]') and name = N'i_cco_error_conaut_his')
Begin
   CREATE NONCLUSTERED INDEX [i_cco_error_conaut_his] ON [dbo].[cco_error_conaut_his]([eh_empresa] ASC, [eh_producto] ASC, [eh_fecha_conta] ASC)
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 75) ON [PRIMARY]
End
go

print ''
print 'Fin Ejecucion Creacion de Indices de Dependencias de Plazo Fijo : ' + convert(varchar(60),getdate(),109)
print ''