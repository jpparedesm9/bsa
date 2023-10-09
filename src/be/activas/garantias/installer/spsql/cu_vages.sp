use cob_custodia
go
if exists(select 1 from sysobjects where name = 'sp_val_garest')
   drop proc sp_val_garest
go

create proc sp_val_garest
as
declare	@w_oficina_ini 	smallint,
	@w_oficina 	smallint,
	@w_rango	smallint

select	@w_oficina  	= max(of_oficina),
	@w_oficina_ini	= 0,
	@w_rango	= 1
from	cobis..cl_oficina

create table #cr_val_custodia
(
codigo_externo		varchar(64),
contador		int
)
create nonclustered index val_custodia_k1 on #cr_val_custodia (codigo_externo)

while (@w_oficina_ini <= @w_oficina + @w_rango)
begin
if exists (select 1 from cobis..cl_oficina where of_oficina = @w_oficina_ini)
begin
   insert into #cr_val_custodia
   select	cu_codigo_externo,
	(select	count(1)
	from	cob_credito..cr_gar_propuesta,
		cob_credito..cr_tramite,
		cob_cartera..ca_operacion
	where	gp_garantia 	= cu_custodia.cu_codigo_externo
	and	tr_tramite	= gp_tramite
	and	op_tramite	= tr_tramite
	and	tr_tipo		in ('O','R')
	and 	op_estado	not in (99,0,3,6)
	)
   from	 cob_custodia..cu_custodia
   where cu_tipo 	!= 	'6210'
   and	 cu_estado 	= 	'V'
   and	 cu_oficina	= 	@w_oficina_ini
   group by cu_codigo_externo
   having 		(select	count(1)
	from	cob_credito..cr_gar_propuesta,
		cob_credito..cr_tramite,
		cob_cartera..ca_operacion
	where	gp_garantia 	= cu_custodia.cu_codigo_externo
	and	tr_tramite	= gp_tramite
	and	op_tramite	= tr_tramite
	and	tr_tipo		in ('O','R')
	and 	op_estado	not in (99,0,3,6)
	)=0
   union
   select cu_codigo_externo,
	  1
   from	  cob_custodia..cu_custodia
   where  cu_tipo 	!= 	'6210'
   and	  cu_estado 	= 	'V'
   and 	  cu_oficina	= 	@w_oficina_ini
   and	  cu_valor_inicial= 0

   select	@w_oficina_ini = @w_oficina_ini + @w_rango
   print   'PROCESADA OFI: @w_oficina_fin ' + cast(@w_oficina_ini as varchar)
end
else
begin
   select	@w_oficina_ini = @w_oficina_ini + @w_rango
end
end

update  cob_custodia..cu_custodia
set 	cu_estado 	= 'X'
from	#cr_val_custodia
where	codigo_externo 	= cu_codigo_externo 

update  cob_credito..cr_gar_propuesta
set	gp_est_garantia = 'X'
from	#cr_val_custodia
where	gp_garantia	= codigo_externo 

update 	cu_custodia
set 	cu_valor_inicial   	= 0, 
	cu_valor_cobertura   	= 0, 
	cu_acum_ajuste     	= 0,
	cu_disponible    	= 0, 
	cu_valor_actual    	= 0, 
	cu_valor_accion    	= 0, 		
	cu_vlr_cuantia     	= 0
where  	cu_valor_inicial		is null
and	cu_valor_actual			is null

update 	cu_custodia
set 	cu_valor_inicial   	= 0, 
	cu_valor_cobertura   	= 0, 
	cu_acum_ajuste     	= 0,
	cu_disponible    	= 0, 
	cu_valor_actual    	= 0, 
	cu_valor_accion    	= 0, 		
	cu_vlr_cuantia     	= 0
where  	cu_porcentaje_cobertura = 0


update 	cu_custodia
set 	cu_valor_inicial   	= cu_valor_inicial, 
	cu_valor_cobertura   	= cu_valor_inicial,
	cu_acum_ajuste     	= cu_valor_inicial, 
	cu_disponible    	= (cu_valor_inicial*cu_porcentaje_cobertura)/100, 
	cu_valor_actual    	= (cu_valor_inicial*cu_porcentaje_cobertura)/100
where  	cu_valor_actual		is null

update 	cu_custodia
set 	cu_valor_inicial   	= cu_valor_actual*(100/cu_porcentaje_cobertura), 
	cu_valor_cobertura   	= cu_valor_actual*(100/cu_porcentaje_cobertura),
	cu_acum_ajuste     	= cu_valor_actual*(100/cu_porcentaje_cobertura),
	cu_disponible    	= cu_valor_actual,
	cu_valor_actual    	= cu_valor_actual
where  	cu_valor_inicial	is null


go
