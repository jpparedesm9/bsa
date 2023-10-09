use cobis
go



if exists (select * from sysobjects where name = 'sp_rty_mensaje')

   drop procedure sp_rty_mensaje

go



create proc sp_rty_mensaje

(

    @i_server    varchar(30),

    @i_proc        int

)

as



select 'Sec.' = me_sec,

       'Num.' = me_num_error,

       'Mensaje' = me_txt_error

from  re_mensaje

where me_server = @i_server

      and me_proc = @i_proc

order by me_sec



return 0

go

