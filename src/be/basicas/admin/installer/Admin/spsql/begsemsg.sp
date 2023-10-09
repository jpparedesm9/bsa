/* sp_begin_secure_sendmsg */

/* Envio de mensaje no solicitado guardando los parametros */

use cobis
go

if exists (select * from sysobjects where name = 'sp_begin_secure_sendmsg')

    drop proc sp_begin_secure_sendmsg

go

create proc sp_begin_secure_sendmsg

    (

    @i_touser    varchar(30)         /* Usuario que recibira el mensaje via mail */

    )

as

raiserror 44441 'g' /* Secure send message  */

select i_tipo        = 'g',

       i_touser      = @i_touser

go

