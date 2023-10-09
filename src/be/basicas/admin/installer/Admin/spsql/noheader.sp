use cobis
go



if exists (select * from sysobjects where name = 'sp_noheader')

    drop proc sp_noheader

go

create proc sp_noheader

as

    raiserror 44440 'h'

/*    select 'OK' */

go

