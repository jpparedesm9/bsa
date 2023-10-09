use cob_conta_super
go 

--1- CORRECCION TASA 
update sb_dato_operacion set 
do_tasa = do_tasa_com
where do_fecha between '09/19/2019' and '09/20/2019'
go

--instalador referencia src/be/regulatoriosmx/installer/sql/reg_tabla.sql

--tablas tti 
IF OBJECT_ID ('dbo.sb_ods_balanactivos_tti') IS NOT NULL
	DROP TABLE dbo.sb_ods_balanactivos_tti
GO

CREATE TABLE dbo.sb_ods_balanactivos_tti
	(
	ob_num_cuenta       VARCHAR (25) NULL,
	ob_cod_cta_cont     VARCHAR (25) NULL,
	ob_cod_divisa       CHAR (3) NULL,
	ob_fec_data         VARCHAR (10) NULL,
	ob_cod_pais         TINYINT NULL,
	ob_cod_centro_cont  SMALLINT NULL,
	ob_cod_entidad      TINYINT NULL,
	ob_imp_sdo_cont_mo  MONEY NULL,
	ob_imp_sdo_cont_ml  MONEY NULL,
	ob_registro_archivo VARCHAR (1000) NULL
	)
GO

--instalador referencia src/be/regulatoriosmx/installer/sql/reg_tabla.sql

IF OBJECT_ID ('dbo.sb_ods_movresultados_tti') IS NOT NULL
	DROP TABLE dbo.sb_ods_movresultados_tti
GO

CREATE TABLE dbo.sb_ods_movresultados_tti
	(
	om_num_cuenta       VARCHAR (25) NULL,
	om_cod_cta_cont     VARCHAR (25) NULL,
	om_cod_divisa       CHAR (3) NULL,
	om_fec_data         VARCHAR (10) NULL,
	om_cod_pais         TINYINT NULL,
	om_cod_centro_cont  SMALLINT NULL,
	om_cod_entidad      TINYINT NULL,
	om_imp_ie_mo        MONEY NULL,
	om_imp_ie_ml        MONEY NULL,
	om_registro_archivo VARCHAR (1000) NULL
	)
GO

--instalador C:\Iss\bsa\src\be\activas\cartera\installer\sql\Param_Conta_MX
delete cobis..ba_batch where ba_batch in (75221,75231)

INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (75221, 'ARCHIVO ODS-2 DE BALANCE DE ACTIVOS TTI', 'ARCHIVO ODS-2 DE BALANCE DE ACTIVOS TTI', 'SP', '01/19/2018 05:08:09', 36, 'P', 1, 'REGULATORIOS', 'BMXP_VAL_ACT_TTI', 'cob_conta_super..sp_ods_balance_activos_tti', 1, NULL, 'CTSSRV', 'S', 'C:\Cobis\VBatch\Regulatorios\Objetos\', 'C:\Cobis\VBatch\Regulatorios\listados\')
GO

INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (75231, 'ARCHIVO ODS-3 DE MOVIMIENTOS-RESULTADOS TTI', 'ARCHIVO ODS-3 DE MOVIMIENTOS-RESULTADOS TTI', 'SP', '01/19/2018 05:08:09', 36, 'P', 1, 'REGULATORIOS', 'BMXP_MOV_RES_TTI', 'cob_conta_super..sp_ods_mov_resultados_tti', 1, NULL, 'CTSSRV', 'S', 'C:\Cobis\VBatch\Regulatorios\Objetos\', 'C:\Cobis\VBatch\Regulatorios\listados\')
GO



--EJECUCION PROCESOS 


exec sp_ods_saldos_oper_tti       '09/19/2019'
go

exec sp_ods_saldos_oper_tti       '09/20/2019'
go

