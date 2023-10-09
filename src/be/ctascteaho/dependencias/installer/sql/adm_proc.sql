use cobis
go

delete from ad_procedure
 where pd_procedure in (5047,1126,79,1115)
   and pd_base_datos = 'cobis'
go
insert into ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (5047,'sp_oficina','cobis','V',getdate(),'oficina.sp')

INSERT INTO ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (1126, 'sp_clasoser', 'cobis', 'V', getdate(), 'clasoser.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (79, 'sp_cons_param_inicio', 'cobis', 'V', getdate(), 'par.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1115, 'sp_direccion_cons', 'cobis', 'V', getdate(), 'cccineg.sp')

go

