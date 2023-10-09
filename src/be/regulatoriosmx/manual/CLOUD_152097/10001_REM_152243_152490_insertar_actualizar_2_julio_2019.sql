--****************************************************************************************************************
use cob_conta
go

print 'Inicio:' + convert(VARCHAR(30),getdate())
select 'antes', * from cb_solicitud_reportes_reg where sr_reporte = 'ESTCTA'
update cb_solicitud_reportes_reg
set sr_fecha  = getdate(),
    sr_mes    = 07,
    sr_anio   = 2019,
    sr_status = 'I'
where sr_reporte = 'ESTCTA'

print 'Fin actualizar reporte'
-------------------------------------------------------------------->>>>>>>>>>>>>>>>>>>>>>>>>
-------------------------------------------------------------------->>>>>>>>>>>>>>>>>>>>>>>>>
use cob_conta_super
go

--select * from cob_conta_super..sb_operacion_tmp
truncate table sb_operacion_tmp
insert sb_operacion_tmp
--select count(*)
select banco 
  from cob_conta_super..sb_info_gen_xml_refacturacion G, 
       cob_conta..cb_solicitud_reportes_reg R
 where timbrado = 'N' and procesado = 'N' 
   and mes_facturacion = sr_mes 
   and anio_facturacion = sr_anio
   and sr_reporte = 'ESTCTA'

select 'num_registro_a_generar' = count(*) from cob_conta_super..sb_operacion_tmp

print 'Fin:' + convert(VARCHAR(30),getdate())
go
