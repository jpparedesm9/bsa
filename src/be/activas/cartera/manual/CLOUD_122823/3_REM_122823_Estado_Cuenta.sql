use cob_credito
go

TRUNCATE TABLE cob_credito..cr_rfc_int_error 
go

SELECT *
INTO resultado_xml_08132019
FROM cob_credito..cr_resultado_xml 
WHERE substring(convert(nVARCHAR(max),linea), 1, 100) LIKE '%XAXX010101000%'

SELECT '>>>> resultado_xml_08132019 '
SELECT count(1)
FROM resultado_xml_08132019

SELECT '>>>> Antes cr_resultado_xml '
SELECT count(1)
FROM cr_resultado_xml

DELETE cob_credito..cr_resultado_xml 
WHERE substring(convert(nVARCHAR(max),linea), 1, 100) LIKE '%XAXX010101000%'

SELECT '>>>> Despues cr_resultado_xml '
SELECT count(1)
FROM cr_resultado_xml 