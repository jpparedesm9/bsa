-- Junio 2021
select * from cob_conta..cb_solicitud_reportes_reg where  sr_reporte = 'ESTCTA'

update cob_conta..cb_solicitud_reportes_reg
set sr_mes     = 06,
    sr_anio    = 2021,
    sr_status  = 'I'
where  sr_reporte = 'ESTCTA'

select * from cob_conta..cb_solicitud_reportes_reg where  sr_reporte = 'ESTCTA'