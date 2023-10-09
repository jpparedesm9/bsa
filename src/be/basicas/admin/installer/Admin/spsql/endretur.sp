use cobis
go



if exists (select * from sysobjects where name = 'sp_end_return')

    drop proc sp_end_return

go

create proc sp_end_return

as

declare @w_null int

select @w_null = null

go

