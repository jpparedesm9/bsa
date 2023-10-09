use master
go



if exists (select * from sysobjects where name = 'sp_recmail')

    drop proc sp_recmail

go

create proc sp_recmail (

    @i_server varchar(20),

    @i_login  varchar(15),

    @s_sesn   int,

    @i_check  char(1) = 'S'

) as



if (@i_check = 'S')

begin

    update cobis..in_login

    set lo_mail = 'S'

    where lo_server = @i_server

        and lo_login = @i_login

        and lo_sesion = @s_sesn

    if @@rowcount = 0

    begin

        raiserror 44444 'Usuario no registrado'

        return 1

    end

end



raiserror 44441 'n'

select i_server = @i_server,

       i_login = @i_login

select respuesta = 'Usted ha sido registrado para correo en '

       + @i_server

return

go

