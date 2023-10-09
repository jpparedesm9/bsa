use cob_conta_super
go
print 'Inicio:' + convert(varchar(30),getdate())
--Ni un minuto
select 'sb_info_gen_xml_refacturacion_N' = count(*) from sb_info_gen_xml_refacturacion
select 'info_reprt_factura_generada' = count(*) from sb_info_reprt_factura_generada

update sb_info_gen_xml_refacturacion 
set timbrado = 'S'
from sb_info_reprt_factura_generada
WHERE banco = g_banco AND mes_facturacion = g_mes AND anio_facturacion = g_anio

select 'sb_info_gen_xml_refacturacion_N' = count(*) from sb_info_gen_xml_refacturacion where timbrado = 'N'
select 'sb_info_gen_xml_refacturacion_S' = count(*) from sb_info_gen_xml_refacturacion where timbrado = 'S'

print 'Fin:' + convert(varchar(30),getdate())
go
