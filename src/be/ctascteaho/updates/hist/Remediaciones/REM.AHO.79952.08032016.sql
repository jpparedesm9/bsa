/************************************************/
---No Story: 79952
---Título del Bug: AHO-H79952-Sp cascara para consulta de movimientos
---Fecha: 03/Agosto/2016
--Descripción del Problema: 
--Descripción de la Solución: 
--Autor: Nelson Guale
/**************************************************/

use cobis
go 

--CtasCteAho/Ahorros/BackEnd/sql/ah_param.sql

if exists(select 1 from cl_parametro where pa_producto = 'AHO' and pa_nemonico = 'MVMXDD')
	delete from cl_parametro where pa_producto = 'AHO' and pa_nemonico in ('MVMXDD')

INSERT INTO dbo.cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto) 
VALUES ('DIAS MAXIMOS CONSULTA MOVIMIENTOS', 'MVMXDD', 'T', NULL, 45, NULL, NULL, NULL, NULL, NULL, 'AHO')
go
