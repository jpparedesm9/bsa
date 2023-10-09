use cob_conta
go

if not exists(select 1
              from cob_conta..cb_solicitud_reportes_reg 
              where sr_reporte = 'ESTCTA')
begin              
    insert into cob_conta..cb_solicitud_reportes_reg (sr_fecha, sr_reporte, sr_mes, sr_anio, sr_status)
    values ('03/14/2022', 'ESTCTA', 2, 2022, 'I')
end
else 
begin
   update cob_conta..cb_solicitud_reportes_reg set
   sr_mes = 2,
   sr_anio= 2022,
   sr_status = 'I'
   where sr_reporte = 'ESTCTA'
end  

select * from cob_conta..cb_solicitud_reportes_reg

exec cob_conta_super..sp_xml_estado_cuenta 
    @i_param1           =  '02/28/2022' -- FECHA DE PROCESO


update cob_conta..cb_solicitud_reportes_reg set
sr_status = 'P'
where sr_reporte = 'ESTCTA'

select * from cob_conta..cb_solicitud_reportes_reg    
