
if exists(select 1 from  cob_conta..cb_solicitud_reportes_reg where sr_reporte = 'BUROM ' )
                 update cob_conta..cb_solicitud_reportes_reg
         set sr_status  = 'I', sr_mes =8, sr_anio = 2018
where sr_reporte = 'BUROM '  
else
   insert into cob_conta..cb_solicitud_reportes_reg (sr_fecha    , sr_reporte, sr_mes, sr_anio, sr_status)
                                              values('09/01/2018','BUROM'    ,8    , 2018   , 'I')

exec cob_conta_super..sp_genera_buro
                 @i_param1 = '08/31/2018'


