

use cobis
go

----------------------- PRODUCTO 2 -----------------------

delete from ad_procedure
 where pd_procedure in ( 7067105 )
   and pd_base_datos = 'cobis'
go

INSERT INTO ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (7067105, 'sp_tr_consulta_homini', 'cobis', 'V', getdate(), 'cltrconhom.sp')

go

