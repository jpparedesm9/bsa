use cob_conta_super
go
------------------------------>>>>>>>>>>>>>>>>>>>>>>>>---------------------------------------
-----------CONSULTA PARA: 05_REM_152243_152490_scriptGeneracionXML_1x1_timbrado_junio.sql
select count(*) --- debe haber alrededor de: 6640 --- tiempo estimado 4h
from sb_info_gen_xml_refacturacion
WHERE anio_facturacion = '2019' AND mes_facturacion = '06' AND timbrado = 'S' AND procesado = 'S'

-----------CONSULTA PARA: 07_REM_152243_152490_scriptGeneracionXML_1x1_timbrado_agosto.sql
select count(*) --- debe haber alrededor de: 31848
from sb_info_gen_xml_refacturacion
WHERE anio_facturacion = '2019' AND mes_facturacion = '08' AND timbrado = 'S' AND procesado = 'S'
go

--Total Archivos para entregar al cliente: 38486 