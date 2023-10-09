use cobis
go



if exists (select * from sysobjects where name = 'sp_sendmail')

    drop proc sp_sendmail

go

create proc sp_sendmail

(

    @i_toserver    varchar(30) = NULL,

    @i_touser    varchar(30),

    @i_mensaje    varchar(255), /* PTO 1995-06-30 80->255 */

    @t_trn        int

)

as

    exec cobis..sp_begin_submit @i_toserver, @i_touser, 'sp_rmtmail'

    select i_key = 'I',

           i_mensaje = @i_mensaje

    exec cobis..sp_end_submit

    select 'Mensaje enviado a' + @i_touser

return 0

go

