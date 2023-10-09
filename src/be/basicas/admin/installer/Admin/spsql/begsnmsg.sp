/* sp_begin_sendmsg */

/* Envio de mensaje no solicitado */

use cobis
go

if exists (select * from sysobjects where name = 'sp_begin_sendmsg')

    drop proc sp_begin_sendmsg

go

create proc sp_begin_sendmsg

    (

    @i_toserver    varchar(30),            /* Servidor en el que se encuentra el usuario a */

                                           /* recibir el mensaje */

    @i_touser    varchar(30)     = null    /* Usuario que recibira el mensaje via mail */

    )

as

raiserror 44441 's' /* submit */

select i_tipo        = 'm',

       i_toserver    = @i_toserver,

       i_touser      = @i_touser,

       i_proc        = 'cobis..sp_rmtmail'    /* PTO 1996-06-30 */

go



