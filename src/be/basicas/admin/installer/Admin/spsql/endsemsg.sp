use cobis
go



if exists (select * from sysobjects where name = 'sp_end_secure_sendmsg')

    drop proc sp_end_secure_sendmsg

go

create proc sp_end_secure_sendmsg (

    @i_wait        char(1)        = 'N'

)

as

    if (@i_wait = 'S') or (@i_wait = 's')

    begin

        raiserror 44441 'w' /* Wait */

        select null

    end

    select 'Mensaje auxiliar'

go

