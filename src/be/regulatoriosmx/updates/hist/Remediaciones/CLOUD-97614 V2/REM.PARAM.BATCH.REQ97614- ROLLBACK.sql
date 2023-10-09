
use cobis 
go 

update cobis..ba_batch set 
ba_nombre           = 'GENERACION ARCHIVO DEPOSITO',
ba_descripcion      = 'GENERACION ARCHIVO DEPOSITO',
ba_tipo_batch       = 'R',
ba_ente_procesado   = 'ARCHIVOS',
ba_arch_resultado   = 'archivos',
ba_arch_fuente      = 'cob_cartera..sp_santander_gen_orden_dep',
ba_impresora        = 'lp'
where ba_batch = 7190


update cobis..ba_sarta_batch set 
sb_habilitado = 'N'
where sb_sarta = 12 and sb_batch = 7190


INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 7190, 0, 1, 'ORIGEN', 'C', 'VBATCH')
GO

INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (12, 7190, 23, 1, 'ORIGEN', 'C', 'VBATCH')
GO