use cobis
go

if exists (select * from sysobjects where name = 'sp_begin_debug')

    drop proc sp_begin_debug

go

create proc sp_begin_debug

    (

    @t_file        varchar(14) = NULL,             /* Nombre del archivo a ser generado */

    @t_tabs        tinyint=null                    /*  Numero de tabs para identacion de datos */

    )

as

declare @w_tabs    tinyint

declare @w_date char(60)



if @t_file is NOT NULL

begin

    select @w_date = convert(char(60), getdate(), 109)

    if @t_tabs is null

        select @w_tabs = @@nestlevel - 1

    else

        select @w_tabs = @t_tabs - 1

    raiserror 44441 'd' /* Debug */

    select t_file        = @t_file,

           t_tabs        = @w_tabs,

           t_date        = @w_date

end

go

