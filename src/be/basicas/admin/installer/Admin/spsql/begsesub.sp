use cobis
go

if exists (select * from sysobjects where name = 'sp_begin_secure_submit')

    drop proc sp_begin_secure_submit

go

create proc sp_begin_secure_submit

    (

    @i_toserver    varchar(30) /* Servidor al que se envia la trans */

    )

as

raiserror 44441 'b' /* Secure submit */

select i_tipo        = 't',

       i_toserver    = @i_toserver

go



