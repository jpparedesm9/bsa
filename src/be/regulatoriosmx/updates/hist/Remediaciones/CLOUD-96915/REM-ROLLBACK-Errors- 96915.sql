
USE cobis
GO
--rollback 
delete FROM  cobis..cl_parametro WHERE pa_nemonico IN('NDCCAB','NDCCCE') AND 
pa_producto='CRE'
--REM rolback Sandino
delete FROM  cobis..cl_parametro WHERE pa_nemonico IN('OAA') AND 
pa_producto='CWF'

delete from cobis..cl_errores  where numero IN (2109004,2109005,2109006)

go