-- Autor: WToledo
-- Fecha: 25/05/2023
-- Instalador: \\src\be\clientes\installer\sql\cl_table.sql

use cobis
go

IF OBJECT_ID ('rte_eval_grp_en017') IS NOT NULL
	DROP TABLE rte_eval_grp_en017
GO

IF OBJECT_ID ('rte_eval_grp_en017_hist') IS NOT NULL
	DROP TABLE rte_eval_grp_en017_hist
GO

IF OBJECT_ID ('rte_eval_grp_en017_rpt') IS NOT NULL
	DROP TABLE rte_eval_grp_en017_rpt
GO

