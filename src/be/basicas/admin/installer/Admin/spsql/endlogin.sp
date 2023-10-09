use master
go



if exists (select * from sysobjects where name = 'sp_endlogin')

    drop proc sp_endlogin

go

create proc sp_endlogin (

    @i_server    varchar(20),

    @i_login    varchar(10),

    @s_sesn        int

) as



    update cobis..in_login

    set lo_fecha_out = getdate()

    where lo_server = @i_server

          and lo_login  = @i_login

          and lo_sesion = @s_sesn



    raiserror 44441 'e'

    select    i_server = @i_server,

        i_login = @i_login

    select respuesta = 'Usuario ' + @i_login +

            ' se ha desconectado de ' + @i_server

    return

go

