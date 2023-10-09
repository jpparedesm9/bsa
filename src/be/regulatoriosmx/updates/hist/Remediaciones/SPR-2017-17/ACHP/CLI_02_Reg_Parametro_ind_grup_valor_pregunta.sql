-- Se compia del archivo: $/COB/Desarrollos/DEV_SaaSMX/Remediaciones/SPR-2017-14/POV
-- Solo el ingreso lo de mas si esta ejecutado
-- Problema: No se muesta el deudor en el  cuestionario
use cobis
go

delete cobis..cl_parametro where pa_nemonico = 'RVDGR' and pa_producto = 'CRE'
INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_tinyint, pa_producto) VALUES
('RESULTADO VER DATOS GRP','RVDGR' , 'T',10, 'CRE')

delete cobis..cl_parametro where pa_nemonico = 'RVDIN' and pa_producto = 'CRE'
INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_tinyint, pa_producto) VALUES
('RESULTADO VER DATOS IND','RVDIN' , 'T',7, 'CRE')
go

delete from cobis..cl_parametro where pa_nemonico = 'ESTVIG' and pa_producto = 'CLI'
INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico,pa_tipo,pa_char, pa_producto) VALUES
('ESTADO VIGENTE' ,'ESTVIG', 'C','V','CLI')
go
