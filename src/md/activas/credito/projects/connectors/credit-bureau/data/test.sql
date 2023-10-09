SELECT * FROM cob_credito.dbo.cr_interface_buro
WHERE ib_cliente = 5878

DELETE FROM cob_credito.dbo.cr_buro_cuenta
WHERE bc_id_cliente = 5878
DELETE FROM cob_credito.dbo.cr_buro_resumen_reporte
WHERE br_id_cliente = 5878
DELETE FROM cob_credito.dbo.cr_interface_buro
WHERE ib_cliente = 5878


SELECT * FROM cobis.dbo.cl_ente
where en_ente = 3282

SELECT top 10 * FROM cobis.dbo.cl_direccion
where di_ente = 3282

SELECT TOP 10 * FROM cobis.dbo.cl_parroquia
WHERE pq_ciudad = 45

EXEC cobis..sp_info_cliente_buro @i_codigo_cliente=15,@i_operacion='Q',@i_sub_tipo='4',@s_srv='CTSSRV',@s_user='admuser',
@s_term='pc01tec109.cobiscorp.int',@s_ofi=1,@s_rol=3,@s_ssn=2663170,@s_lsrv='CTSSRV',@s_date='06/09/2017',@s_sesn=7141,@s_org='U'

UPDATE cobis.dbo.cl_ente
SET p_s_apellido = 'PEREZ'
where en_ente = 15

UPDATE cobis.dbo.cl_direccion
set di_parroquia = 6759
where di_ente = 15
AND di_direccion = 2

SELECT * FROM cobis..cl_parametro
where pa_nemonico = 'OBCDS'

UPDATE cobis..cl_parametro
SET pa_int = 1  -- SIN SIMULACIÓN
where pa_nemonico = 'OBCDS'
