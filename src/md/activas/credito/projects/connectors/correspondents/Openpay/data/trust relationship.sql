DECLARE
	@w_application_id		INT,
	@i_login_ext			VARCHAR(14),
	@i_login				VARCHAR(14),
    @w_cobis_role           TINYINT,
	@i_relationship_id		INT,
    @i_cts_relationship_id	INT,
	@w_terminal				VARCHAR(10)

SELECT
	@w_application_id = 100,
	@i_login_ext = 'openpay_usr',
	@i_login = 'admuser',
	@w_cobis_role = 3,
	@i_relationship_id = 100,
	@w_terminal = 'OPENPAY'

INSERT INTO cobis.dbo.cts_usuario_externo
    (ue_id_aplicacion, ue_usuario, ue_rol, ue_id_relacion, ue_estado)
VALUES
    (@w_application_id, @i_login_ext, @w_cobis_role, @i_relationship_id, 'V')

SELECT @i_cts_relationship_id = MAX(rc_secuencial) + 1
FROM cobis.dbo.cts_relacion_confianza

INSERT INTO cobis.dbo.cts_relacion_confianza
    (rc_secuencial, rc_id_relacion, rc_usuario, rc_rol, rc_oficina, rc_terminal, rc_servidor, rc_id_sesion, rc_id_sesion_cts, rc_estado)
VALUES
    (@i_cts_relationship_id, @i_relationship_id, @i_login, @w_cobis_role, 1, @w_terminal, 'CTSSRV', NULL, NULL, 'V')

INSERT INTO cobis.dbo.cts_aplicacion
	(ap_id_aplicacion, ap_nombre, ap_terminal, ap_estado)
VALUES
	(@w_application_id, 'Openpay', @w_terminal, 'V')

/*
select top 10 * from cobis.dbo.cts_usuario_externo
select top 10 * from cobis.dbo.cts_relacion_confianza
select top 10 * from cobis.dbo.cts_aplicacion

delete from cobis.dbo.cts_usuario_externo
where ue_id_aplicacion = 100
delete from cobis.dbo.cts_relacion_confianza
where rc_id_relacion = 100
delete from cobis.dbo.cts_aplicacion
WHERE ap_id_aplicacion = 100
*/
