use cobis
go



if exists (select * from sysobjects where name = 'sp_end_debug')

    drop proc sp_end_debug

go

create proc sp_end_debug

as

declare @w_null int

select @w_null = null

go

