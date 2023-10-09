-----------<CREACION INDICES>---------------------
USE [cob_conta_his]
GO
 
set nocount on
go
 
print '--> Indice: [cb_hist_saldo].[cb_hist_saldo_key]'

CREATE UNIQUE NONCLUSTERED INDEX [cb_hist_saldo_key] ON [dbo].[cb_hist_saldo]
(
	[hi_corte] ASC,
	[hi_periodo] ASC,
	[hi_oficina] ASC,
	[hi_area] ASC,
	[hi_cuenta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90)
GO



