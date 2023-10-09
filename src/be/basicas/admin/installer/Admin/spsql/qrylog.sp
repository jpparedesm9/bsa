use cob_distrib
go



if exists (select * from sysobjects where name = 'sp_qrylog')

  drop proc sp_qrylog

go



create proc sp_qrylog

(

    @i_logid  int,

    @i_delta  int = 50

)

as

declare

    @w_minid int,

    @w_maxid int

begin

    select @w_minid = min(lg_id)

    from di_log

    

    select @w_maxid = max(lg_id)

    from di_log

    

    if @i_logid >= @w_maxid

        return 0

    

    if @i_logid != -1

        if @i_logid > @i_delta

            select @w_minid = @i_logid - @i_delta

    

    select @w_maxid = @w_minid + 2*@i_delta

    

    select lg_id, lg_operacion, lg_objeto

    from di_log

    where lg_id between @w_minid and @w_maxid

    order by lg_id

    

    select pa_id, pa_nombre, pa_tipodato, pa_longitud,

           pa_varchar, pa_int, pa_smallint, pa_tinyint, pa_money,

           pa_datetime, pa_float, pa_real, pa_smalldatetime, pa_smallmoney, pa_varbinary

    from di_parametro

    where pa_id between @w_minid and @w_maxid

    order by pa_id

    

    return 0

end

go

