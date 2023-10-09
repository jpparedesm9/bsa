use cobis
go



if exists (select * from sysobjects where name = 'sp_end_sendmsg')

    drop proc sp_end_sendmsg

go

create proc sp_end_sendmsg

as

declare @w_null int

select @w_null = null

select 'Mensaje auxiliar'

go



