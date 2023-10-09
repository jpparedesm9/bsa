-- Autor: KVI
-- Fecha: 01/06/2023
-- Instalador: \\bsa\src\be\clientes\installer\sql\cl_parametros.sql

-- PARAMETRO VIGENCIA REGISTROS EVALUACION CLIENTE -- Requerimiento #205892 OT Reporte Riesgo individual nva evaluacion
use cobis
go

delete cl_parametro where pa_nemonico = 'VREC17'

insert into dbo.cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('VIGENCIA REGISTROS EVALUACION CLIENTE EN017', 'VREC17', 'I', null, null, null, 3, null, null, null, 'CLI')

go
