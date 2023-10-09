/*************************************************/
---No Bug: AHO-H81677
---Título de la Historia: ELIMINAR CONTROLES Y FUNCIONALIDADES APLICADOS A COLOMBIA
---Fecha: 23/Ago/2016
--Descripción del la Historia: Funcionalidades especificas que apliquen solo a la version BANCAMIA
--                             deben ocultarse de acuerdo a un parametro.
--Descripción de la Solución: Se crea el parametro 
--Autor: Walther Toledo
/*************************************************/
use cobis
go
-- --> /Ahorros/ah_param.sql
delete from cl_parametro where pa_nemonico='OCUCOL' and pa_producto = 'AHO'
insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_producto)
values ('PARAMETRO OCULTAR FUNCIONALIDADES VERSION COLOMBIA', 'OCUCOL', 'C', 'S', 'AHO')

go

/*************************************************/
USE cob_remesas
go
-- --> /remesas/re_table.sql
alter TABLE re_accion_nd alter column an_impuesto CHAR(1) null
go

alter TABLE re_accion_nd_cca523 alter column an_impuesto CHAR(1) null
go

