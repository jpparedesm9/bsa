use cob_conta
go

if exists (select * from sysobjects where name = 'sp_balof')
	drop proc sp_balof
go

create proc sp_balof (
	@i_empresa		tinyint 	= null,
	@i_fecha		datetime	= null,
	@i_oficina		smallint	= null
)
as
declare @w_estado		    char(1),
	    @w_corte		    int,
	    @w_periodo		    int,
  	    @w_fecha_ant	datetime,
	    @w_corte_ant	int,
	    @w_periodo_ant	int,
	    @w_estado_ant   char(1),
	    @w_cortefp		    int,
		@w_rowcount		smallint
 

truncate table cb_balof_tmp

select	@w_corte = co_corte,@w_periodo=co_periodo,@w_estado = co_estado
from    cb_corte
where   co_empresa = @i_empresa
and     co_periodo >= 0
and     co_corte >= 0
and     co_fecha_ini >= @i_fecha
and     co_fecha_fin <= @i_fecha
select @w_rowcount = @@rowcount

set transaction isolation level READ UNCOMMITTED

if @w_rowcount = 0
begin
   print "ERROR (1): Corte de la fecha de reporte no encontrado"
   return 1
end

if @w_estado = 'A' 
begin
	insert into cb_balof_tmp select sa_oficina,sa_area,sa_cuenta,cu_nombre,cu_moneda,cu_movimiento,sa_saldo,sa_debito,sa_credito,sa_saldo_me,sa_debito_me,sa_credito_me,0,0,0,0,0,0
    from cob_conta..cb_saldo,cob_conta..cb_cuenta
	where sa_empresa=@i_empresa and sa_periodo=@w_periodo and sa_corte=@w_corte and sa_oficina=@i_oficina and sa_area>=0 and sa_cuenta>=''
	and   sa_empresa = cu_empresa and sa_cuenta = cu_cuenta
	if @@error <> 0
	begin
	   print "ERROR: En insercion de datos en cb_balof_tmp"
	   return 1
	end
end
else
begin
	insert into cb_balof_tmp select hi_oficina,hi_area,hi_cuenta,cu_nombre,cu_moneda,cu_movimiento,hi_saldo,hi_debito,hi_credito,hi_saldo_me,hi_debito_me,hi_credito_me,0,0,0,0,0,0
    from cob_conta_his..cb_hist_saldo,cob_conta..cb_cuenta
	where hi_empresa=@i_empresa and hi_periodo=@w_periodo and hi_corte=@w_corte and hi_oficina=@i_oficina and hi_area>=0 and hi_cuenta>=''
	and   hi_empresa = cu_empresa and hi_cuenta = cu_cuenta
	if @@error <> 0
	begin
	   print "ERROR: En insercion de datos en cb_balof_tmp"
	   return 1
	end
end

select  @w_fecha_ant = dateadd(dd,-1,@i_fecha)
select	@w_corte_ant = co_corte,@w_periodo_ant = co_periodo,@w_estado_ant = co_estado
from    cb_corte
where   co_empresa = @i_empresa
and     co_periodo >= 0
and     co_corte >= 0
and     co_fecha_ini >= @w_fecha_ant
and     co_fecha_fin <= @w_fecha_ant
select @w_rowcount = @@rowcount

set transaction isolation level READ UNCOMMITTED

if @w_rowcount = 0
begin
   print "ERROR (2): Corte correspondiente al día anterior a la fecha de reporte no encontrado"
   return 1
end

select @w_cortefp = max(co_corte)
from   cob_conta..cb_corte
where  co_empresa = @i_empresa
and    co_periodo = @w_periodo_ant
and    co_corte   > 0
select @w_rowcount = @@rowcount

set transaction isolation level READ UNCOMMITTED

if @w_rowcount = 0
begin
   print "ERROR (3): Máximo corte para el período anterior no encontrado"
   return 1
end

if  @w_cortefp = @w_corte_ant
begin
	update cb_balof_tmp
	set   bp_saldo_ant = sf_saldo,bp_debito_ant=sf_debito,bp_credito_ant=sf_credito,
	      bp_saldo_me_ant=sf_saldo_me,bp_debito_me_ant=sf_debito_me,bp_credito_me_ant=sf_credito_me
	from  cob_conta..cb_saldo_fp
	where sf_empresa=@i_empresa and sf_periodo=@w_periodo_ant and sf_corte=@w_corte_ant and sf_oficina=@i_oficina and sf_area>=0 and sf_cuenta>=''
	and   sf_oficina = bp_oficina and sf_area=bp_area and sf_cuenta = bp_cuenta
	if @@error <> 0
	begin
	   print "ERROR: En actualizacion de datos en cb_balof_tmp"
	   return 1
	end
end
else
begin
	update cb_balof_tmp
	set   bp_saldo_ant = hi_saldo,bp_debito_ant=hi_debito,bp_credito_ant=hi_credito,
	      bp_saldo_me_ant=hi_saldo_me,bp_debito_me_ant=hi_debito_me,bp_credito_me_ant=hi_credito_me
	from  cob_conta_his..cb_hist_saldo
	where hi_empresa=@i_empresa and hi_periodo=@w_periodo_ant and hi_corte=@w_corte_ant and hi_oficina=@i_oficina and hi_area>=0 and hi_cuenta>=''
	and   hi_oficina = bp_oficina and hi_area=bp_area and hi_cuenta = bp_cuenta
	if @@error <> 0
	begin
	   print "ERROR: En actualizacion de datos en cb_balof_tmp"
	   return 1
	end
end
return 0
go

