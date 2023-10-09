
/*DECLARE @w_return INT, @w_id_grupo INT , @o_grupo INT*/
/*
EXEC @w_id_grupo = cob_pac..sp_grupo_busin @i_comportamiento_pago='0',
@i_dia_reunion='1',
@i_dir_reunion=' ',
@i_estado='V',
@i_fecha_modificacion='07/01/2017 00:00:00.000',
@i_fecha_registro='06/05/2017 00:00:00.000',
@i_grupo=0,
@i_hora_reunion='06/05/2017 01:30:00.000',
@i_nombre='AGRICOLAS UNIDOS',
@i_num_ciclo='0',
@i_oficial=3,
@i_gr_tipo='S',
@i_gr_cta_grupal='123123',
@i_gr_sucursal=1,
@i_gr_titular1=0,
@i_gr_titular2=0,
@i_gr_tiene_ctagr='S',
@t_trn=800,
@i_operacion='I',
@o_grupo=0,
@s_srv='CTSSRV',
@s_user='admuser',
@s_term='pc01cap79.cobiscorp.int',
@s_ofi=1,
@s_rol=3,
@s_ssn=97263,
@s_lsrv='CTSSRV',
@s_date='05/19/2017',
--@s_sesn=1249,
@s_org='U'--,--,
--@s_culture='es_EC'
--@o_grupo = @w_id_grupo

PRINT 'Paso 1'
*/
--- ingreso de entes

--EXEC @w_return = cob_pac..sp_miembro_grupo_busin @i_ente=8,
cob_pac..sp_miembro_grupo_busin @i_ente=8,
@i_grupo=1,
@i_fecha_asociacion='06/05/2017 00:00:00.000',
@i_rol='P',
@i_estado='V',
@i_calif_interna='A',
@i_cg_ahorro_voluntario=23.0,
@i_cg_lugar_reunion=null,
@t_trn=810,
@i_operacion='I',
@s_srv='CTSSRV',
@s_user='admuser',
@s_term='pc01cap79.cobiscorp.int',
@s_ofi=1,
@s_rol=3,
@s_ssn=97379,
@s_lsrv='CTSSRV',
@s_date='05/19/2017',
@s_sesn=1249,
@s_org='U',
@s_culture='es_EC'
go

--- ingreso de entes
--EXEC @w_return = cob_pac..sp_miembro_grupo_busin @i_ente=9,
cob_pac..sp_miembro_grupo_busin @i_ente=9,
@i_grupo=1,
@i_fecha_asociacion='06/05/2017 00:00:00.000',
@i_rol='T',
@i_estado='V',
@i_calif_interna='A',
@i_cg_ahorro_voluntario=23.0,
@i_cg_lugar_reunion=null,
@t_trn=810,
@i_operacion='I',
@s_srv='CTSSRV',
@s_user='admuser',
@s_term='pc01cap79.cobiscorp.int',
@s_ofi=1,
@s_rol=3,
@s_ssn=97379,
@s_lsrv='CTSSRV',
@s_date='05/19/2017',
@s_sesn=1249,
@s_org='U',
@s_culture='es_EC'

go
