use cobis
go
-- ----------------------------------------------------------------------------------------------------------------------
----------------------------------------------------SERVICIOS BANCACARIOS------------------------------------------------
-- ----------------------------------------------------------------------------------------------------------------------
delete ad_procedure 
 where pd_base_datos = 'cob_sbancarios' 
   and pd_procedure in (29265)
   
INSERT INTO ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (29265, 'sp_bus_subtipos', 'cob_sbancarios', 'V', getdate(), 'b_subtip.sp')


go

