
use cob_conta_super
go

if not exists(select 1 from  cob_conta..cb_solicitud_reportes_reg where sr_reporte = 'BXO' )
   insert into cob_conta..cb_solicitud_reportes_reg (sr_fecha    , sr_reporte, sr_mes, sr_anio, sr_status)
                                              values('04/30/2019','BXO'    ,4    , 2019   , 'I')

exec sp_banxico
   @i_param1 = '04/30/2019'