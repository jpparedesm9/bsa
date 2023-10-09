use cob_conta
go
if not exists(select 1 from cb_solicitud_reportes_reg where sr_reporte = 'BUROM')
begin 
     insert into cb_solicitud_reportes_reg (sr_fecha, sr_reporte, sr_mes, sr_anio, sr_status)
     values ('2021-09-03', 'BUROM', 8, 2021, 'I')
end
else
   update cb_solicitud_reportes_reg set
   sr_fecha  ='2021-09-03',
   sr_mes    = 8,
   sr_anio   = 2021,
   sr_status = 'I'
   where sr_reporte = 'BUROM'



select *  from cb_solicitud_reportes_reg where sr_reporte = 'BUROM'


exec cob_conta_super..sp_genera_buro 
@i_param1  = '08/31/2021'
  

 update cb_solicitud_reportes_reg set
 sr_status = 'P'
 where sr_reporte = 'BUROM'