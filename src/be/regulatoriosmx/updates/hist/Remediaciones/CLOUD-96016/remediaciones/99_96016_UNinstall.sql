USE cob_conta_super
GO

IF EXISTS(SELECT 1 FROM sysobjects WHERE name = 'sb_mov_mes_tmp')
	DROP TABLE sb_mov_mes_tmp
GO

use cob_conta_super
go

if exists(select 1 from sysobjects where name = 'sp_mov_contable_mes')
    drop proc sp_mov_contable_mes
go

