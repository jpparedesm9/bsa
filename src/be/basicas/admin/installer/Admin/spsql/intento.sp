use cobis
go



if exists (select * from sysobjects where name = 'sp_intento')

    drop proc sp_intento

go

create proc sp_intento (

    @i_login    varchar(30),

    @i_server    varchar(30)

)

as

declare @w_fecha_ant datetime,

    @w_intervalo_maximo int,

    @w_veces_intento_max tinyint,

    @w_intentos tinyint,

    @w_estado char(1)



select @w_intervalo_maximo = -5,

    @w_veces_intento_max = 2



select @w_fecha_ant = dateadd(minute, @w_intervalo_maximo, getdate())



select @w_intentos = count(*)

from in_intento

where in_login = @i_login

      and in_fecha > @w_fecha_ant



insert into in_intento values

            (@i_login, @i_server, getdate())

select @w_estado = us_estado

from ad_usuario

where us_login = @i_login



if (@w_estado != 'V')

    return 1



if (@w_intentos >= @w_veces_intento_max)

begin

    /* Bloquear al usuario */

    update ad_usuario 

    set us_estado = 'B'

    where us_login = @i_login



    return 1

end



return 0

go

