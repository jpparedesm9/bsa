-- Autor: KVI
-- Fecha: 01/06/2023
-- Instalador: \\bsa\src\be\clientes\installer\sql\cl_parametros.sql

-- PARAMETRO VIGENCIA REGISTROS EVALUACION CLIENTE -- Requerimiento #205892 OT Reporte Riesgo individual nva evaluacion
use cobis
go

delete cl_parametro where pa_nemonico = 'VREC17'

go
