use cobis
go



if exists (select * from sysobjects where name = 'rp_rol')

    drop proc rp_rol

go



create proc rp_rol (

    @login                  varchar(30),

    @i_rol                  tinyint = 0,

    @i_filas                int = 80

)

as

set rowcount @i_filas





select ur_rol,convert(varchar(40),ro_descripcion),ro_time_out

from ad_usuario_rol,ad_rol

where ur_login = @login

      and ro_estado = 'V'

      and ur_estado = 'V'

      and ur_rol > @i_rol

      and ur_rol=ro_rol

order by ur_rol

return 0

go

