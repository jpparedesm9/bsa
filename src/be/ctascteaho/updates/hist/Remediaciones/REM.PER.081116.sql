
---Fecha					: 08/11/2016 
--Descripción del Problema	: DATA INICIAL PARA RANGO DE EDADES
--Autor						: Karen Meza
/***********************************************************************************************************/
use cob_remesas
go

--data inicial rango edades
IF exists (SELECT 1 FROM sysobjects WHERE name = 'pe_pro_rango_edad' )
  DELETE FROM pe_pro_rango_edad  
go

INSERT INTO pe_pro_rango_edad (re_codigo, re_descripcion, re_rango_ini, re_rango_fin, re_estado)
VALUES (1, 'MENOR DE EDAD', 0, 17, 'V')

INSERT INTO pe_pro_rango_edad (re_codigo, re_descripcion, re_rango_ini, re_rango_fin, re_estado)
VALUES (2, 'MAYOR DE EDAD', 18, 100, 'V')

INSERT INTO pe_pro_rango_edad (re_codigo, re_descripcion, re_rango_ini, re_rango_fin, re_estado)
VALUES (3, 'TODOS', 0, 100, 'V')

go    