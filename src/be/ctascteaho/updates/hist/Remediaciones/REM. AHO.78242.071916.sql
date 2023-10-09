/************************************************/
---No Bug: 78242
---Título del Bug: Back Office - De Totales por Operador
---Fecha: 19/Julio/2016
--Descripción del Problema: El nombre físico del sp estaba incorrecto
--Descripción de la Solución: Se registra sp con el nombre correcto del físico
--Autor: Tania Baidal
/**************************************************/

--Dependencias/sql/cc_proc.sql
use cobis
go

delete from ad_procedure
 where pd_procedure in (94,99,2597)

insert into ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (94,'sp_tr_tot_caj_adm','cob_cuentas','V',getdate(),'tot_caj_adm.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (99,'sp_tr_cons_tot_ofi_adm','cob_cuentas','V', getdate(),'tot_ofi_adm.sp')

INSERT INTO ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (2597, 'sp_query_excep_sipla', 'cob_cuentas', 'V', getdate(), 'que_exc_sip.sp')