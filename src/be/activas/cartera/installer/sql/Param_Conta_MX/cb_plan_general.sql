Use cob_conta
go

declare @w_empresa	       int,
		@w_area_car	       int
		
if exists (select 1 from cob_conta..sysobjects where name = 'cb_plan_general')
begin
	select @w_empresa = pa_tinyint from cobis..cl_parametro where pa_nemonico = 'EMP' and pa_producto = 'ADM'
	
	delete from cob_conta..cb_plan_general where pg_empresa = @w_empresa 

	--******* Plan Cuentas Cartera *******
	-- Cuenta         | Área           | Oficina
	-- Cartera        | Comercial      | Todas excepto Centralizadora
	
	select @w_area_car = pa_smallint from cobis..cl_parametro where pa_nemonico = 'ARC' and pa_producto = 'CCA'

	IF OBJECT_ID('tempdb..#cuentas_cartera') IS NOT NULL
       DROP TABLE #cuentas_cartera

	create table #cuentas_cartera (cuenta cuenta not null)
	
	insert into #cuentas_cartera
	select distinct re_substring
	from cob_conta..cb_cuenta, cob_conta..cb_relparam
	where cu_cuenta = re_substring
	and cu_movimiento = 'S'
	and re_producto   = '7'
	union
	select distinct dp_cuenta
	from cob_conta..cb_cuenta, cob_conta..cb_det_perfil
	where cu_cuenta = dp_cuenta
	and cu_movimiento = 'S'
	and dp_producto   = '7'
	union 
    select distinct cu_cuenta from cob_conta..cb_cuenta
	where ( cu_cuenta like '1391506190%' or cu_cuenta like '6291016190%')
	and cu_movimiento  ='S'
	

	insert into cob_conta..cb_plan_general 
    select @w_empresa,cuenta,of_oficina, @w_area_car,
      replace(convert(varchar(30),(convert(varchar(5), @w_empresa) + 
                                   convert(varchar(15),cuenta) + 
                                   convert(varchar(8), of_oficina) + 
                                   convert(varchar(8), @w_area_car))), ' ','')
    from #cuentas_cartera, cb_oficina 
	where of_movimiento = 'S'
	and   of_oficina  not in ( select je_oficina from cb_jerarquia where je_oficina_padre = 9000)  --Oficina Centralizadora 
	
	
/*	--******* Plan Cuentas Módulos diferentes a Cartera *******
	-- Cuenta                | Área       | Oficina
	-- Todas excepto Cartera | Todas      | Todas
	
	IF OBJECT_ID('tempdb..#cuentas_otros_mod') IS NOT NULL
      DROP TABLE #cuentas_otros_mod
	
	create table #cuentas_otros_mod (cuenta cuenta not null)
	
	insert into #cuentas_otros_mod
	select cu_cuenta 
	from cob_conta..cb_cuenta
	where cu_movimiento = 'S'
	and   cu_cuenta     not in (select cuenta from #cuentas_cartera)
	
    insert into cob_conta..cb_plan_general 
    select @w_empresa,cuenta,of_oficina, ar_area,
      replace(convert(varchar(30),(convert(varchar(5), @w_empresa) + 
                                   convert(varchar(15),cuenta) + 
                                   convert(varchar(8), of_oficina) + 
                                   convert(varchar(8), ar_area) )), ' ','')
    from #cuentas_otros_mod, cb_oficina, cob_conta..cb_area
    where of_movimiento = 'S'
    and   ar_movimiento = 'S'*/

	
end
else
	print 'NO EXISTE TABLA cb_plan_general'
go
