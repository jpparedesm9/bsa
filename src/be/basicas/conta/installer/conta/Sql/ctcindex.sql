-----------<CREACION INDICES>---------------------
USE [cob_conta_tercero]
GO
 
set nocount on
go
 
print '--> Indice: [ct_saldo_tercero].[ct_saldo_tercero_Key]'
CREATE UNIQUE NONCLUSTERED INDEX [ct_saldo_tercero_Key] ON [dbo].[ct_saldo_tercero]
(
	[st_corte] ASC,
	[st_periodo] ASC,
	[st_cuenta] ASC,
	[st_oficina] ASC,
	[st_area] ASC,
	[st_ente] ASC,
	[st_empresa] ASC
)
INCLUDE ( 	[st_saldo]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90)
GO

print '--> Indice: [ct_saldo_tercero].[ct_saldo_tercero_Key_cuenta]'
CREATE NONCLUSTERED INDEX [ct_saldo_tercero_Key_cuenta] ON [dbo].[ct_saldo_tercero]
(
	[st_cuenta] ASC,
	[st_periodo] ASC,
	[st_corte] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90)
GO

print '--> Indice: [ct_saldo_tercero].[ct_saldo_tercero_Key_ente]'
CREATE NONCLUSTERED INDEX [ct_saldo_tercero_Key_ente] ON [dbo].[ct_saldo_tercero]
(
	[st_ente] ASC,
	[st_periodo] ASC,
	[st_corte] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90)
GO

