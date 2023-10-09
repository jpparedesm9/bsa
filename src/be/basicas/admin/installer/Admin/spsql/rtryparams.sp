use cobis
go



if exists (select * from sysobjects where name = 'sp_rty_param')

   DROP procedure sp_rty_param

go



create proc sp_rty_param

(

    @i_proc        int,

    @i_server     varchar(32)

)

as

select 'Nombre'=pa_nomparam,

       'Valor'=case pa_tipodato

            when  47 then pa_varchar

            when  39 then pa_varchar

            when  56 then convert(varchar(255), pa_int)

            when  52 then convert(varchar(255), pa_smallint)

            when  48 then convert(varchar(255), pa_tinyint)

            when  60 then convert(varchar(255), pa_money)

            when  61 then convert(varchar(255), pa_datetime)

            when  62 then convert(varchar(255), pa_float)

            when  59 then convert(varchar(255), pa_real)

            when  58 then convert(varchar(255), pa_smalldatetime)

            when 122 then convert(varchar(255), pa_smallmoney)

            end,

       'Output'=pa_tipo_io,

       'Tipo de Dato'=pa_tipodato

from re_parametro

where pa_server = @i_server and pa_proc = @i_proc

return 0

go

