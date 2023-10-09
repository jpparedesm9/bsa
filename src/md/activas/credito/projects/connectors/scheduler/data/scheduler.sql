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
	@w_us_login = 'scheduler',
	@w_ap_id_aplicacion = 200,
	@w_ap_terminal = 'SCHEDULER',
	@w_rc_id_relacion = 200,
	@w_ro_descripcion = 'SCHEDULER CTS'



PRINT '<<<<< Creación de Ambiente Scheduler >>>>>'



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
	(@w_ap_id_aplicacion, 'SCHEDULER CTS', @w_ap_terminal, 'V')



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



SET NOCOUNT OFF
GO


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
@w_ro_descripcion VARCHAR(64),
@w_rol_max        int 

SELECT
	@w_us_login = 'oxxo',
	@w_ap_id_aplicacion = 300 ,
	@w_ap_terminal = 'OXXO',
	@w_rc_id_relacion = 300,
	@w_ro_descripcion = 'CORRESPONSAL OXXO'



PRINT '<<<<< Creación de Corresponsal Oxxo >>>>>'


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
select @w_rol_max = max(isnull(ro_rol,0)) +1 from cobis..ad_rol 

if @w_ro_rol <> @w_rol_max begin
   update cobis..cl_seqnos set
   siguiente = isnull(@w_rol_max, 1)
   where tabla = 'ad_rol'
   and bdatos = 'cobis'
   select @w_ro_rol = @w_rol_max   
end

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
	(@w_ap_id_aplicacion, 'Oxxo', @w_ap_terminal, 'V')



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

SET NOCOUNT OFF
GO