use cob_credito
go

if exists (select * from sysobjects where id = object_id('sp_diario_operaciones_ex'))
    drop proc sp_diario_operaciones_ex
go

create proc sp_diario_operaciones_ex
   @i_param1   varchar(255) = null   
as
declare
@w_return	   int,
@w_fecha	   datetime

select @w_fecha = convert(datetime, @i_param1)

exec @w_return = cob_credito..sp_diario_operaciones
	 @i_fecha    = @w_fecha

return @w_return
go
