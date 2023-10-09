
use cob_conta
go

declare @w_empresa int, @w_fecha datetime

select @w_empresa = pa_tinyint,
       @w_fecha   = getdate()
from cobis..cl_parametro 
where pa_nemonico = 'EMP' 
and pa_producto = 'ADM'

exec cob_conta..sp_cb_jerar1_ej
@i_empresa = @w_empresa

exec cob_conta..sp_cb_jerar2_ej
@i_empresa = @w_empresa,
@i_fecha_fin = @w_fecha

go

