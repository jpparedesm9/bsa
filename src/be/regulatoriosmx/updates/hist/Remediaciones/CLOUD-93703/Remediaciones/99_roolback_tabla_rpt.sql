use cob_conta_super
go
if exists(select 1 from sysobjects where name = 'sb_estcta_cab_tmp ')
    drop table sb_estcta_cab_tmp
go


if exists(select 1 from sysobjects where name = 'sb_info_cre_tmp ')
    drop table sb_info_cre_tmp
go

if exists(select 1 from sysobjects where name = 'sb_movimientos_tmp ')
    drop table sb_movimientos_tmp
go

if exists(select 1 from sysobjects where name = 'sb_amortizacion_tmp ')
    drop table sb_amortizacion_tmp
go

