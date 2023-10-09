use cobis
go



if exists (select * from sysobjects where name = 'sp_end_resubmit')

    drop proc sp_end_resubmit

go

create proc sp_end_resubmit

as

declare @w_null int

select @w_null = null

go



