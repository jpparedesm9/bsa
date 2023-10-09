USE cobis
GO

SET NOCOUNT ON
GO

DECLARE
	@w_us_login VARCHAR(10),
	@w_ro_rol INT,
	@w_ap_id_aplicacion INT,
	@w_ap_terminal VARCHAR(10),
	@w_rc_secuencial INT,
	@w_rc_id_relacion INT,
	@w_fu_funcionario INT,
	@w_ro_descripcion VARCHAR(64)

SELECT
	@w_us_login = 'openpay',
	@w_ap_id_aplicacion = 100,
	@w_ap_terminal = 'OPENPAY',
	@w_rc_id_relacion = 100,
	@w_ro_descripcion = 'CORRESPONSAL NO BANCARIO'



PRINT '<<<<< Creaci�n de Ambiente Openpay >>>>>'



----------------------------------------------------------------------------------
-- Eliminaci�n de: Loan.ConciliationManagement.RegisterLoanPayment
----------------------------------------------------------------------------------
PRINT '--- Eliminaci�n de servicio Loan.ConciliationManagement.RegisterLoanPayment'

IF EXISTS (SELECT 1 FROM cobis..ad_servicio_autorizado WHERE ts_servicio = 'Loan.ConciliationManagement.RegisterLoanPayment')
	DELETE cobis..ad_servicio_autorizado WHERE ts_servicio = 'Loan.ConciliationManagement.RegisterLoanPayment'

if EXISTS (select 1 from cobis..cts_serv_catalog where csc_service_id = 'Loan.ConciliationManagement.RegisterLoanPayment')
	DELETE cobis..cts_serv_catalog WHERE csc_service_id = 'Loan.ConciliationManagement.RegisterLoanPayment'



PRINT '--- Eliminaci�n en cts_usuario_externo'

DELETE FROM cobis..cts_usuario_externo
WHERE ue_id_aplicacion = @w_ap_id_aplicacion



PRINT '--- Eliminaci�n en cts_relacion_confianza'

DELETE FROM cobis.dbo.cts_relacion_confianza
WHERE rc_id_relacion = @w_rc_id_relacion



PRINT '--- Eliminaci�n en cts_aplicacion'

DELETE FROM cobis.dbo.cts_aplicacion
WHERE ap_id_aplicacion = @w_ap_id_aplicacion



PRINT '--- Eliminaci�n en ad_usuario_rol'

DELETE FROM cobis..ad_usuario_rol
WHERE ur_login = @w_us_login



PRINT '--- Eliminaci�n en ad_rol'

DELETE FROM cobis..ad_rol
WHERE ro_descripcion = @w_ro_descripcion



PRINT '--- Eliminaci�n en ad_usuario'

DELETE FROM cobis..ad_usuario
WHERE us_login = @w_us_login



PRINT '--- Eliminaci�n en cl_funcionario'

DELETE FROM cobis..cl_funcionario
WHERE fu_login = @w_us_login



PRINT '--- Creaci�n en cl_funcionario'

EXEC cobis..sp_cseqnos @i_tabla = 'cl_funcionario', @o_siguiente = @w_fu_funcionario out

INSERT INTO cobis..cl_funcionario
(   fu_funcionario, fu_nombre, fu_sexo, fu_dinero, fu_nomina,
    fu_departamento, fu_oficina, fu_cargo, fu_secuencial, fu_jefe,
    fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_fec_inicio,
    fu_fec_final, fu_clave, fu_estado, fu_offset
)
VALUES
(   @w_fu_funcionario, @w_us_login, 'M', NULL, NULL,
    1, 1, 1, 1, 1,
    NULL, GETDATE(), @w_us_login, NULL, GETDATE(),
    GETDATE(), NULL, 'V', NULL
)


PRINT '--- Creaci�n en ad_usuario'

INSERT INTO cobis..ad_usuario
(
	us_filial, us_oficina, us_nodo, us_login, us_fecha_asig,
    us_creador, us_fecha_ult_mod, us_fecha_ult_pwd, us_estado
)
VALUES
(
	1, 1, 1, @w_us_login, GETDATE(),
    1, GETDATE(), GETDATE(), 'V'
)



PRINT '--- Creaci�n en ad_rol'

--SELECT @w_ro_rol = ISNULL(MAX(ro_rol), 0) + 1
--FROM cobis..ad_rol
EXEC cobis..sp_cseqnos @i_tabla = 'ad_rol', @o_siguiente = @w_ro_rol out

INSERT INTO cobis..ad_rol
(
	ro_rol, ro_filial, ro_descripcion, ro_fecha_crea, ro_creador,
	ro_estado, ro_fecha_ult_mod, ro_time_out, ro_admin_seg, ro_departamento, ro_oficina
)
VALUES
(
	@w_ro_rol, 1, @w_ro_descripcion, GETDATE(), 1,
	'V', GETDATE(), 900, NULL, NULL, NULL
)

--UPDATE cobis..cl_seqnos 
--SET siguiente = @w_ro_rol 
--WHERE tabla  = 'ad_rol' 



PRINT '--- Creaci�n en ad_usuario_rol'

INSERT INTO cobis..ad_usuario_rol
(   ur_login, ur_rol, ur_fecha_aut, ur_autorizante, ur_estado,
    ur_fecha_ult_mod, ur_tipo_horario
)
VALUES
(   @w_us_login, @w_ro_rol, GETDATE(), 1, 'V',
    GETDATE(), 1
)



PRINT '--- Creaci�n en cts_aplicacion'

INSERT INTO cobis.dbo.cts_aplicacion
	(ap_id_aplicacion, ap_nombre, ap_terminal, ap_estado)
VALUES
	(@w_ap_id_aplicacion, 'Openpay', @w_ap_terminal, 'V')



PRINT '--- Creaci�n en cts_relacion_confianza'

SELECT @w_rc_secuencial = ISNULL(MAX(rc_secuencial), 0) + 1
FROM cobis.dbo.cts_relacion_confianza

INSERT INTO cobis.dbo.cts_relacion_confianza
    (rc_secuencial, rc_id_relacion, rc_usuario, rc_rol, rc_oficina, rc_terminal, rc_servidor, rc_id_sesion, rc_id_sesion_cts, rc_estado)
VALUES
    (@w_rc_secuencial, @w_rc_id_relacion, @w_us_login, @w_ro_rol, 1, @w_ap_terminal, 'CTSSRV', NULL, NULL, 'V')



PRINT '--- Creaci�n en cts_usuario_externo'

INSERT INTO cobis..cts_usuario_externo
    (ue_id_aplicacion, ue_usuario, ue_rol, ue_id_relacion, ue_estado)
values
    (@w_ap_id_aplicacion, @w_us_login, @w_ro_rol, @w_rc_id_relacion, 'V')



PRINT '--- Creaci�n de servicio Loan.ConciliationManagement.RegisterLoanPayment'

INSERT INTO cobis..cts_serv_catalog 
(
	csc_service_id,                                    csc_class_name,                                                                
    csc_method_name,                                   csc_description,
    csc_trn,                                           csc_support_offline,
    csc_component,                                     csc_procedure_validation
	)
VALUES
(
	'Loan.ConciliationManagement.RegisterLoanPayment',	'cobiscorp.ecobis.assets.cloud.service.IConciliationManagement',
	'registerLoanPayment',								'Servicio de escucha de notificaci�n de Openpay',  
	NULL,                                               NULL,
	NULL,												'N'
)   

INSERT INTO cobis..ad_servicio_autorizado
(
	ts_servicio, ts_rol, ts_producto, ts_tipo, 
	ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod
)
VALUES
(
	'Loan.ConciliationManagement.RegisterLoanPayment', @w_ro_rol, 1, 'R',
	0, GETDATE(), 'V', GETDATE()
)

GO



SET NOCOUNT OFF
GO
