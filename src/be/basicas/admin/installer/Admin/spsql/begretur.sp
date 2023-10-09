use cobis
go

if exists (select * from sysobjects where name = 'sp_begin_return')

    drop proc sp_begin_return

go

create proc sp_begin_return

    (

    @i_key int /* Numero de la entrada de informacion registrada */

    )

as

raiserror 44441 'u' /* Return the saved buffer */

select    i_key    = @i_key

go

