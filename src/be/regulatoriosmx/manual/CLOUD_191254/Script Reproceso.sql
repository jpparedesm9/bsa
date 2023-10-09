use cob_conta
go
if not exists(select 1 from cb_solicitud_reportes_reg where sr_reporte = 'BUROM')
begin 
     insert into cb_solicitud_reportes_reg (sr_fecha, sr_reporte, sr_mes, sr_anio, sr_status)
     values ('2022-11-02', 'BUROM', 10, 2022, 'I')
end
else
   update cb_solicitud_reportes_reg set
   sr_fecha  ='2022-11-02',
   sr_mes    = 10,
   sr_anio   = 2022,
   sr_status = 'I'
   where sr_reporte = 'BUROM'



select *  from cb_solicitud_reportes_reg where sr_reporte = 'BUROM'


exec cob_conta_super..sp_genera_buro 
@i_param1  = '10/31/2022'
  

 update cb_solicitud_reportes_reg set
 sr_status = 'P'
 where sr_reporte = 'BUROM'