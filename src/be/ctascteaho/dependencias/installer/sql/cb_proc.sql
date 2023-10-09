use cobis
go
-- ----------------------------------------------------------------------------------------------------------------------
-- ----------------------------------------------------CONTABILIDAD------------------------------------------------------
-- ----------------------------------------------------------------------------------------------------------------------
delete cobis..ad_procedure 
 where pd_base_datos = 'cob_conta' 
   and pd_procedure in (6436)
   
insert into ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (6436,'sp_perfil','cob_conta','V',getdate(),'perfil.sp')

go

