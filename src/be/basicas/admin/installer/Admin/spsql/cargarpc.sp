use cobis
go

if exists (select * from sysobjects where name = 'sp_cargarpc')

    drop proc sp_cargarpc

go

create proc sp_cargarpc

(

    @i_nombre varchar(32)

)

as

/* select @i_nombre */

if exists (select id from sysobjects where name = @i_nombre)

    select name,type, length  from syscolumns

    where  syscolumns.id = (select id from sysobjects

        where name = @i_nombre)

else

    Raiserror  99999  'No existe el Stored Procedure'

go



use master

go

if exists (select * from sysobjects where name = 'sp_cargarpc')

    drop proc sp_cargarpc

go

create proc sp_cargarpc

(

    @i_nombre varchar(32)

)

as

/* select @i_nombre */

if exists (select id from sysobjects where name = @i_nombre)

    select name,type, length  from syscolumns

    where  syscolumns.id = (select id from sysobjects

        where name = @i_nombre)

else

    Raiserror  99999  'No existe el Stored Procedure'

go

