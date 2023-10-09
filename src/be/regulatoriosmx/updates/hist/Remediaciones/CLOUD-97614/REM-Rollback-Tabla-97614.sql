USE cobis
GO

IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE COLUMN_NAME = 'gr_gar_liquida' AND TABLE_NAME = 'cl_grupo')
BEGIN

ALTER TABLE cobis..cl_grupo
DROP COLUMN gr_gar_liquida

END

IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE COLUMN_NAME = 'ts_gar_liquida' AND TABLE_NAME = 'cl_tran_servicio')
BEGIN

ALTER TABLE cobis..cl_tran_servicio 
DROP COLUMN ts_gar_liquida 

END




--crear Vista
IF OBJECT_ID ('dbo.ts_grupo') IS NOT NULL
	DROP VIEW dbo.ts_grupo
GO

CREATE VIEW ts_grupo (
                      secuencial,    tipo_transaccion,    clase,              fecha,    --1
                      terminal,      srv,                 lsrv,                         --2
                      grupo,         nombre,              representante,      compania, --3
                      oficial,       fecha_registro,      fecha_modificacion, ruc,      --4					  
                      vinculacion,   tipo_vinculacion,    max_riesgo,         riesgo,   --5					  
                      usuario,       reservado,           tipo_grupo,         estado,   --6					  
                      dir_reunion,   dia_reunion,         hora_reunion,       comportamiento_pago,--7					  
                      num_ciclo                                                         --8
) as
select                ts_secuencial, ts_tipo_transaccion, ts_clase,           ts_fecha,    --1
                      ts_terminal,   ts_srv,              ts_lsrv,                         --2
                      ts_grupo,      ts_nombre,           ts_rep_legal,       ts_ente,     --3
                      ts_jefe_agenc, ts_fecha_emision,    ts_fecha_expira,    ts_cedruc,   --4					  
                      ts_garantia,   ts_tipo,             ts_promedio_ventas, ts_pasivo,   --5					  
                      ts_usuario,    ts_ingresos,         ts_proposito,       ts_grado_soc,--6					  
                      ts_direc,      ts_camara,           ts_fpas_finan,      ts_telefono, --7
                      ts_escritura                                                         --8
from    cl_tran_servicio
where   ts_tipo_transaccion = 800					  

GO
				  