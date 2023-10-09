/* Agregar cuentas de las oficinas para seguros */

use cob_conta
go

declare @w_empresa        int,
@w_area_car        int
  
if exists (select 1 from cob_conta..sysobjects where name = 'cb_plan_general')
begin
	select @w_empresa = pa_tinyint from cobis..cl_parametro where pa_nemonico = 'EMP' and pa_producto = 'ADM'
	
	delete from cob_conta..cb_plan_general 
	where pg_empresa = @w_empresa and pg_cuenta IN (select distinct dp_cuenta
	from cob_conta..cb_cuenta, cob_conta..cb_det_perfil
	where cu_cuenta = dp_cuenta
	and cu_movimiento = 'S'
	and dp_producto   = '7'
	    and dp_perfil = 'CCA_SEG')
	
	select @w_area_car = pa_smallint from cobis..cl_parametro where pa_nemonico = 'ARC' and pa_producto = 'CCA'
	
	IF OBJECT_ID('tempdb..#cuentas_cartera') IS NOT NULL
	   DROP TABLE #cuentas_cartera
	
	create table #cuentas_cartera (cuenta cuenta not null)
	
	insert into #cuentas_cartera
	select distinct dp_cuenta
	from cob_conta..cb_cuenta, cob_conta..cb_det_perfil
	where cu_cuenta = dp_cuenta
	and cu_movimiento = 'S'
	and dp_producto   = '7'
	    and dp_perfil = 'CCA_SEG'
	
	
	insert into cob_conta..cb_plan_general 
	select @w_empresa,cuenta,of_oficina, @w_area_car,
	  replace(convert(varchar(30),(convert(varchar(5), @w_empresa) + 
	                               convert(varchar(15),cuenta) + 
	                               convert(varchar(8), of_oficina) + 
	                               convert(varchar(8), @w_area_car))), ' ','')
	from #cuentas_cartera, cb_oficina 
	where of_movimiento = 'S'
	and   of_oficina  not in ( select je_oficina from cb_jerarquia where je_oficina_padre = 9000)  --Oficina Centralizadora 

end
else
 print 'NO EXISTE TABLA cb_plan_general'
go