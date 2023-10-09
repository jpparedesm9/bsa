use cobis
go



if exists (select * from sysobjects where name = 'sp_rty_status')

   drop procedure sp_rty_status

go



create proc sp_rty_status

(

    @i_operacion    char(1),

    @o_status    char(1) out

)

as

declare @w_status    char(1)



if @i_operacion = 'U'

begin

    if @o_status in ('H','D')

    begin

        update re_rty_status

        set rs_status = @o_status,

            rs_fecha = getdate()

        if @@error = 0

            return 0

    end

    select @i_operacion = 'H'

end

if @i_operacion = 'H'

begin

    select @w_status = rs_status

    from re_rty_status

    select @o_status = isnull(@w_status, 'H')

    return 0

end

return 1

go

