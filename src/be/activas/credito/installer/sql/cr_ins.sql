/**********************************************************************/
/*   Archivo:         cr_ins.sql                                      */
/*   Data base:       cobis                                           */
/**********************************************************************/
/*                     IMPORTANTE                                     */
/*   Esta aplicacion es parte de los  paquetes bancarios              */
/*   propiedad de COBISCORP.                                          */
/*   Su uso no autorizado queda  expresamente  prohibido              */
/*   asi como cualquier alteracion o agregado hecho  por              */
/*   alguno de sus usuarios sin el debido consentimiento              */
/*   por escrito de COBISCORP.                                        */
/*   Este programa esta protegido por la ley de derechos              */
/*   de autor y por las convenciones  internacionales de              */
/*   propiedad intelectual.  Su uso  no  autorizado dara              */
/*   derecho a COBISCORP para obtener ordenes  de secuestro           */
/*   o  retencion  y  para  perseguir  penalmente a  los              */
/*   autores de cualquier infraccion.                                 */
/**********************************************************************/
/*                      PROPOSITO                                     */
/*   Insercion de informacion relacionada a procesos de Credito       */
/**********************************************************************/
/*                      MODIFICACIONES                                */
/*   FECHA              AUTOR                  RAZON                  */
/*   31-08-2017         Paul Clavijo           Emision Inicial        */
/**********************************************************************/

USE cobis
GO

SET NOCOUNT ON
GO


PRINT '<<<<< Creación de Ambiente Openpay >>>>>'

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

PRINT '--- Eliminación en cts_usuario_externo'
DELETE FROM cobis..cts_usuario_externo
WHERE ue_id_aplicacion = @w_ap_id_aplicacion

PRINT '--- Eliminación en cts_relacion_confianza'
DELETE FROM cobis.dbo.cts_relacion_confianza
WHERE rc_id_relacion = @w_rc_id_relacion

PRINT '--- Eliminación en cts_aplicacion'
DELETE FROM cobis.dbo.cts_aplicacion
WHERE ap_id_aplicacion = @w_ap_id_aplicacion

PRINT '--- Eliminación en ad_usuario_rol'
DELETE FROM cobis..ad_usuario_rol
WHERE ur_login = @w_us_login

PRINT '--- Eliminación en ad_rol'
DELETE FROM cobis..ad_rol
WHERE ro_descripcion = @w_ro_descripcion

PRINT '--- Eliminación en ad_usuario'
DELETE FROM cobis..ad_usuario
WHERE us_login = @w_us_login

PRINT '--- Eliminación en cl_funcionario'
DELETE FROM cobis..cl_funcionario
WHERE fu_login = @w_us_login


PRINT '--- Creación en cl_funcionario'

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


PRINT '--- Creación en ad_usuario'

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


PRINT '--- Creación en ad_rol'

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


PRINT '--- Creación en ad_usuario_rol'

INSERT INTO cobis..ad_usuario_rol
(   ur_login, ur_rol, ur_fecha_aut, ur_autorizante, ur_estado,
    ur_fecha_ult_mod, ur_tipo_horario
)
VALUES
(   @w_us_login, @w_ro_rol, GETDATE(), 1, 'V',
    GETDATE(), 1
)


PRINT '--- Creación en cts_aplicacion'

INSERT INTO cobis.dbo.cts_aplicacion
	(ap_id_aplicacion, ap_nombre, ap_terminal, ap_estado)
VALUES
	(@w_ap_id_aplicacion, 'Openpay', @w_ap_terminal, 'V')


PRINT '--- Creación en cts_relacion_confianza'

SELECT @w_rc_secuencial = ISNULL(MAX(rc_secuencial), 0) + 1
FROM cobis.dbo.cts_relacion_confianza

INSERT INTO cobis.dbo.cts_relacion_confianza
    (rc_secuencial, rc_id_relacion, rc_usuario, rc_rol, rc_oficina, rc_terminal, rc_servidor, rc_id_sesion, rc_id_sesion_cts, rc_estado)
VALUES
    (@w_rc_secuencial, @w_rc_id_relacion, @w_us_login, @w_ro_rol, 1, @w_ap_terminal, 'CTSSRV', NULL, NULL, 'V')


PRINT '--- Creación en cts_usuario_externo'

INSERT INTO cobis..cts_usuario_externo
    (ue_id_aplicacion, ue_usuario, ue_rol, ue_id_relacion, ue_estado)
values
    (@w_ap_id_aplicacion, @w_us_login, @w_ro_rol, @w_rc_id_relacion, 'V')

GO

PRINT '--- Registrar variable CLINROCLIN'
DECLARE @w_codigo INT
SELECT @w_codigo = max(vb_codigo_variable) +1 FROM cob_workflow..wf_variable

if not exists (select 1 from cob_workflow..wf_variable where vb_abrev_variable     = 'CLINROCLIN')
begin
   INSERT INTO wf_variable (vb_codigo_variable, vb_nombre_variable, vb_abrev_variable, vb_desc_variable, vb_tipo_datos, vb_val_variable, vb_id_programa, vb_type, vb_subType, vb_catalogo, vb_expresion_validacion, vb_seudo_catalogo, vb_value_min, vb_value_operator, vb_value_max)
   VALUES (@w_codigo, 'Cliente Nro Ciclo Individual', 'CLINROCLIN', 'Cliente Número Ciclo Individual', 'INT', '0', NULL, 'CRE', 'ORI', '', NULL, NULL, NULL, '0', NULL)
 end
go


SET NOCOUNT OFF
GO
--Creacion de usuario para Buro
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
	@w_us_login = 'buromovil',
	@w_ap_id_aplicacion = 150,
	@w_ap_terminal = 'BUROMOVL',
	@w_rc_id_relacion = 150,
	@w_ro_descripcion = 'CORRESPONSAL NO BANCARIO'



PRINT '<<<<< Creación de Ambiente BuroMovil >>>>>'


PRINT '--- Eliminación en cts_usuario_externo'

DELETE FROM cobis..cts_usuario_externo
WHERE ue_id_aplicacion = @w_ap_id_aplicacion



PRINT '--- Eliminación en cts_relacion_confianza'

DELETE FROM cobis.dbo.cts_relacion_confianza
WHERE rc_id_relacion = @w_rc_id_relacion



PRINT '--- Eliminación en cts_aplicacion'

DELETE FROM cobis.dbo.cts_aplicacion
WHERE ap_id_aplicacion = @w_ap_id_aplicacion



PRINT '--- Eliminación en ad_usuario_rol'

DELETE FROM cobis..ad_usuario_rol
WHERE ur_login = @w_us_login



PRINT '--- Eliminación en ad_rol'

DELETE FROM cobis..ad_rol
WHERE ro_descripcion = @w_ro_descripcion



PRINT '--- Eliminación en ad_usuario'

DELETE FROM cobis..ad_usuario
WHERE us_login = @w_us_login



PRINT '--- Eliminación en cl_funcionario'

DELETE FROM cobis..cl_funcionario
WHERE fu_login = @w_us_login



PRINT '--- Creación en cl_funcionario'

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


PRINT '--- Creación en ad_usuario'

INSERT INTO cobis..ad_usuario
(
	us_filial, us_oficina, us_nodo, us_login, us_fecha_asig,
    us_creador, us_fecha_ult_mod, us_fecha_ult_pwd, us_estado
)
VALUES
(
	1, 1101, 1, @w_us_login, GETDATE(),
    1, GETDATE(), GETDATE(), 'V'
)
INSERT INTO cobis..ad_usuario
(
	us_filial, us_oficina, us_nodo, us_login, us_fecha_asig,
    us_creador, us_fecha_ult_mod, us_fecha_ult_pwd, us_estado
)
VALUES
(
	1, 9001, 1, @w_us_login, GETDATE(),
    1, GETDATE(), GETDATE(), 'V'
)



PRINT '--- Creación en ad_rol'

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



PRINT '--- Creación en ad_usuario_rol'

INSERT INTO cobis..ad_usuario_rol
(   ur_login, ur_rol, ur_fecha_aut, ur_autorizante, ur_estado,
    ur_fecha_ult_mod, ur_tipo_horario
)
VALUES
(   @w_us_login, @w_ro_rol, GETDATE(), 1, 'V',
    GETDATE(), 1
)



PRINT '--- Creación en cts_aplicacion'

INSERT INTO cobis.dbo.cts_aplicacion
	(ap_id_aplicacion, ap_nombre, ap_terminal, ap_estado)
VALUES
	(@w_ap_id_aplicacion, 'BuroMovil', @w_ap_terminal, 'V')



PRINT '--- Creación en cts_relacion_confianza'

SELECT @w_rc_secuencial = ISNULL(MAX(rc_secuencial), 0) + 1
FROM cobis.dbo.cts_relacion_confianza

INSERT INTO cobis.dbo.cts_relacion_confianza
    (rc_secuencial, rc_id_relacion, rc_usuario, rc_rol, rc_oficina, rc_terminal, rc_servidor, rc_id_sesion, rc_id_sesion_cts, rc_estado)
VALUES
    (@w_rc_secuencial, @w_rc_id_relacion, @w_us_login, @w_ro_rol, 1, @w_ap_terminal, 'CTSSRV', NULL, NULL, 'V')



PRINT '--- Creación en cts_usuario_externo'

INSERT INTO cobis..cts_usuario_externo
    (ue_id_aplicacion, ue_usuario, ue_rol, ue_id_relacion, ue_estado)
values
    (@w_ap_id_aplicacion, @w_us_login, @w_ro_rol, @w_rc_id_relacion, 'V')

INSERT INTO cobis..ad_servicio_autorizado
(
	ts_servicio, ts_rol, ts_producto, ts_tipo, 
	ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod
)
VALUES
(
	'CustomerDataManagementService.ReportsManagement.HistoricalCreditReport', @w_ro_rol, 1, 'R',
	0, GETDATE(), 'V', GETDATE()
)
INSERT INTO cobis..ad_servicio_autorizado
(
	ts_servicio, ts_rol, ts_producto, ts_tipo, 
	ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod
)
VALUES
(
	'HTM.API.HumanTask.GetCredencials', @w_ro_rol, 1, 'R',
	0, GETDATE(), 'V', GETDATE()
)

GO
SET NOCOUNT OFF
GO

