/*****************************************************************************/
--No Historia				 : H80491
--Título de la Historia		 : Paso de datos de Ahorros a cob_cuenta_super
--Fecha					     : 08/16/2016
--Descripción del Problema	 : Se requiere de un proceso que realice el paso 
--                             de los datos de transacciones monetarias y de 
--                             servicios hacia la base cob_externos para 
--                             realizar proceso de reportes
--Descripción de la Solución : Alteracion de tabla ex_dato_cliente
--Autor						 : Jorge Salazar Andrade
--Instalador                 : cobext_table.sql
/*****************************************************************************/

use cob_externos
go
ALTER TABLE [dbo].[ex_dato_cliente] ADD [dc_perf_tran] money NULL
ALTER TABLE [dbo].[ex_dato_cliente] ADD [dc_riesgo] [catalogo] NULL 
go

