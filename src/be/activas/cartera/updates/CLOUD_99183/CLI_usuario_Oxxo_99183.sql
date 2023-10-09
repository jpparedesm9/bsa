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
	


-- Permisos para la transaccion con el rol 
-- seccion para el ingreso de un nuevo sp
declare 
@w_sec_tn_trn_code int,
@w_sec_pd_procedure int

select @w_sec_tn_trn_code=775061
select @w_sec_pd_procedure = 775061

delete from cobis..cl_ttransaccion where tn_trn_code = @w_sec_tn_trn_code and tn_descripcion = 'CORRESPONSAL OXXO'
INSERT INTO cobis..cl_ttransaccion(tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga) 
VALUES(@w_sec_tn_trn_code, 'CORRESPONSAL OXXO', @w_sec_tn_trn_code, 'CORRESPONSAL OXXO')

delete from cobis..ad_procedure where pd_procedure = @w_sec_pd_procedure and pd_stored_procedure ='sp_corresponsal_consulta' 
INSERT INTO cobis..ad_procedure(pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo) 
VALUES(@w_sec_pd_procedure, 'sp_corresponsal_consulta', 'cob_cartera', 'V', getdate(), 'sp_corr_con.sp')

delete from cobis..ad_pro_transaccion where pt_transaccion=@w_sec_tn_trn_code and pt_procedure = @w_sec_pd_procedure
INSERT INTO cobis..ad_pro_transaccion(pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial) 
VALUES(7, 'R', 0, @w_sec_tn_trn_code, 'V', getdate(), @w_sec_pd_procedure, NULL)

delete from cobis..ad_tr_autorizada where ta_transaccion = @w_sec_tn_trn_code and ta_rol=@w_ro_rol
INSERT INTO cobis..ad_tr_autorizada(ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
VALUES(7, 'R', 0, @w_sec_tn_trn_code, @w_ro_rol, getdate(), 1, 'V', getdate())
                                       
GO


GO
SET NOCOUNT OFF
GO
