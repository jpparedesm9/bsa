use cobis
go



if exists (select * from sysobjects where name = 'sp_genrol')

    drop proc sp_genrol

go

create proc sp_genrol

as

    select ro_rol, ro_descripcion, ro_time_out

    from ad_rol

    where ro_estado = 'V'

    order by ro_rol

return 0

go

