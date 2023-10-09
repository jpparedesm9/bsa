Use cob_cartera
go

IF OBJECT_ID ('dbo.ca_buscar_operaciones_tmp') IS NOT NULL
	DROP TABLE dbo.ca_buscar_operaciones_tmp
GO

CREATE TABLE dbo.ca_buscar_operaciones_tmp
	(
	bot_usuario           login NULL,
	bot_operacion         INT NULL,
	bot_moneda            INT NULL,
	bot_fecha_ini         DATETIME NULL,
	bot_lin_credito       cuenta NULL,
	bot_estado            TINYINT NULL,
	bot_migrada           cuenta NULL,
	bot_toperacion        catalogo NULL,
	bot_oficina           SMALLINT NULL,
	bot_oficial           SMALLINT NULL,
	bot_cliente           INT NULL,
	bot_tramite           INT NULL,
	bot_banco             cuenta NULL,
	bot_fecha_reajuste    DATETIME NULL,
	bot_tipo              CHAR (1) COLLATE Latin1_General_BIN NULL,
	bot_reajuste_especial CHAR (1) COLLATE Latin1_General_BIN NULL,
	bot_reajustable       CHAR (1) COLLATE Latin1_General_BIN NULL,
	bot_monto             MONEY NULL,
	bot_monto_aprobado    MONEY NULL,
	bot_anterior          cuenta NULL,
	bot_fecha_ult_proceso DATETIME NULL,
	bot_nro_red           VARCHAR (24) COLLATE Latin1_General_BIN NULL,
	bot_ref_exterior      cuenta NULL,
	bot_num_deuda_ext     cuenta NULL,
	bot_num_comex         cuenta NULL,
	bot_tipo_linea        catalogo NULL,
	bot_nombre            descripcion NULL,
	bot_fecha_fin         DATETIME NULL
	)
GO

CREATE NONCLUSTERED INDEX bot_operacion_1
	ON dbo.ca_buscar_operaciones_tmp (bot_operacion)
GO

CREATE NONCLUSTERED INDEX bot_operacion_2
	ON dbo.ca_buscar_operaciones_tmp (bot_usuario)
GO



use cobis
go

declare @w_rol integer

select @w_rol = ro_rol from ad_rol
where ro_descripcion='MENU POR PROCESOS'


DELETE FROM cobis..cl_ttransaccion
WHERE tn_trn_code = 7130 

DELETE FROM cobis..ad_procedure
WHERE pd_procedure = 7057 

DELETE FROM cobis..cl_ttransaccion
WHERE tn_trn_code = 7130 

DELETE FROM cobis..ad_pro_transaccion
WHERE pt_producto = 7 AND pt_tipo = 'R' AND pt_moneda = 0 AND pt_transaccion = 7130

DELETE FROM cobis..ad_tr_autorizada
WHERE ta_producto = 7 AND ta_tipo = 'R' AND ta_moneda = 0 AND ta_transaccion = 7130 

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (7, 'R', 0, 7130, @w_rol, getdate(), 3, 'V', getdate())

INSERT INTO cobis..ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (7057, 'sp_buscar_operaciones', 'cob_cartera', 'V', getdate(), 'busopera.sp')

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (7, 'R', 0, 7130, 'V', getdate(), 7057, NULL)

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (7130, 'BUSQUEDA GENERAL DE OPERACIONES', '7130', 'BUSQUEDA GENERAL DE OPERACIONES')


GO

use cobis
go

declare @w_rol integer

select @w_rol = ro_rol from cobis..ad_rol
where ro_descripcion='MENU POR PROCESOS'

DELETE FROM cobis..ad_servicio_autorizado WHERE ts_servicio = 'Loan.LoanMaintenance.LoanSearchStatus'

DELETE FROM cobis..cts_serv_catalog WHERE csc_service_id = 'Loan.LoanMaintenance.LoanSearchStatus'

--Inserta en la tabla el servicio realizado
insert into cobis..cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name,csc_description, csc_trn)
values('Loan.LoanMaintenance.LoanSearchStatus','cobiscorp.ecobis.assets.cloud.service.ILoanMaintenance','loanSearchStatus','loanSearchStatus',7131)

--Autoriza el servicio realizado
insert into cobis..ad_servicio_autorizado (ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut,ts_rol, ts_estado,ts_fecha_ult_mod)
values('Loan.LoanMaintenance.LoanSearchStatus',7,'R',0,getdate(),@w_rol ,'V',getdate())




delete  FROM cobis..ad_servicio_autorizado WHERE ts_servicio = 'Loan.LoanMaintenance.SearchLoanCustomer'

delete  FROM cobis..cts_serv_catalog WHERE csc_service_id = 'Loan.LoanMaintenance.SearchLoanCustomer'


INSERT INTO cobis..ad_servicio_autorizado (ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
VALUES ('Loan.LoanMaintenance.SearchLoanCustomer', 7, 'R', 0,getdate(),@w_rol ,'V',getdate())
GO


INSERT INTO cobis..cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
VALUES ('Loan.LoanMaintenance.SearchLoanCustomer', 'cobiscorp.ecobis.assets.cloud.service.ILoanMaintenance', 'searchLoanCustomer', 'searchLoanCustomer', 7130)
GO


USE cobis
GO
print 'cobis..cl_errores ' 

delete from cobis..cl_errores where numero in (701172,701173,701174,701175,701176)

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (701172, 0, 'No existen mas préstamos')

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (701173, 0, 'Para búsqueda por oficina ingresar (línea de credito y/o fecha de desembolso) o préstamo migrada')

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (701174, 0, 'Para búsqueda por regional ingresar (fecha desembolso y opcionalmente línea de credito)')

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (701175, 0, 'Para búsqueda por ruta ingresar la fecha desembolso')

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (701176, 0, 'Ingrese al menos un criterio de busqueda principal')

go

USE cobis
GO

print 'cobis..cew_menu ' 

update cobis..cew_menu
set me_url ='views/ASSTS/CMMNS/T_LOANSEARCHSWA_959/1.0.0/VC_LOANSEARHC_144959_TASK.html?menu=3'
where  me_name ='MNU_ASSETS_CLAUSE' 


DELETE FROM dbo.cts_interceptor_transaction
WHERE trn = 7131 AND interceptor_id = 6 

DELETE cobis..cts_interceptor WHERE interceptor_id = 6

