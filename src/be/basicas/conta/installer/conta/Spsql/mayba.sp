/************************************************************************/
/*   Stored procedure:     sp_mayba                               */
/*   Base de datos:        cob_conta                                  */
/************************************************************************/
/*                                  IMPORTANTE                          */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'MACOSA'                                                           */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de MACOSA o su representante.                */
/************************************************************************/
/*                            PROPOSITO                                 */
/************************************************************************/
 
use cob_conta
go
 
if exists (select 1 from sysobjects where name = 'sp_mayba')
   drop proc sp_mayba
go
 
create proc sp_mayba (
	@i_empresa		        tinyint 	= null,
	@i_fecha		        datetime	= null,
    @i_fecha_ant            datetime	= null,
	@i_oficina		        smallint	= null,
    @i_nivel_cuenta         tinyint     = null,
    @i_nivel                tinyint     = null

)
as
declare @w_estado		    char(1),
	    @w_corte		    int,
	    @w_periodo		    int,
  	    @w_fecha_ant	    datetime,
	    @w_corte_ant	    int,
	    @w_periodo_ant	    int,
	    @w_estado_ant       char(1),
	    @w_cortefp		    int,
	    @w_fin_mes_ant	    datetime,  --REQ 271 Fecha Mes Anterior
	    @w_corte_fin_mes_ant	int,   --REQ 271 Corte Mes Anterior
	    @w_periodo_fin_mes_ant	int    --REQ 271 Periodo Mes Anterior

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

select	@w_corte = co_corte,@w_periodo=co_periodo,@w_estado = co_estado
from    cb_corte
where   co_empresa = @i_empresa
and     co_periodo >= 0
and     co_corte >= 0
and     co_fecha_ini >= @i_fecha
and     co_fecha_fin <= @i_fecha

if @@rowcount = 0
begin
   print 'ERROR (1): Corte de la fecha de reporte no encontrado'
   return 1
end

/* REQ 271 CALCULA EL PERIODO Y CORTE DE LA FECHA FINAL DEL MES ANTERIOR */
select @w_fin_mes_ant = dateadd(dd,-(datepart(dd,@i_fecha)),@i_fecha)

set transaction isolation level READ UNCOMMITTED
select @w_corte_fin_mes_ant   = co_corte,
       @w_periodo_fin_mes_ant = co_periodo
from  cb_corte
where co_empresa = @i_empresa
and   co_periodo >= 0
and   co_corte >= 0
and   co_fecha_ini >= @w_fin_mes_ant
and   co_fecha_fin <= @w_fin_mes_ant
if @@rowcount = 0
begin
   print 'ERROR (2): Corte de la Fecha Fin Mes Anterior no encontrado'
   return 1
end

/* REQ 271 SALDOS MES ANTERIOR */
Select 
'oficina' = of_oficina,
'cuenta' = cu_cuenta,
'saldo_mes_ant' = sum(convert(float,isnull(hi_saldo,0))),
'debito_mes_ant' = sum(convert(float,isnull(hi_debito,0))),  
'credito_mes_ant'= sum(convert(float,isnull(hi_credito,0)))
into #ctas_mes_anterior
from cob_conta..cb_hist_saldo_tmp, cb_cuenta,cb_oficina,cb_jerarquia
where hi_empresa = convert(tinyint,@i_empresa)
and hi_periodo = convert(int,@w_periodo_fin_mes_ant)
and hi_corte = convert(int,@w_corte_fin_mes_ant)
and cu_empresa = convert(tinyint,@i_empresa)
and hi_cuenta = cu_cuenta
and cu_nivel_cuenta <= convert(tinyint,@i_nivel_cuenta)
and of_empresa = convert(tinyint,@i_empresa)
and of_organizacion = convert(tinyint,@i_nivel)
and je_empresa = convert(tinyint,@i_empresa)
and je_oficina_padre = of_oficina
and hi_oficina = je_oficina
and (of_oficina = @i_oficina or @i_oficina = 0)
group by of_oficina,cu_cuenta, cu_nombre

select count(*) from #ctas_mes_anterior

if @w_estado = 'A' 
begin
	insert into cb_mayba_tmp(
        mt_oficina,
	mt_cuenta,
	mt_nombre,
	mt_saldo,
	mt_saldo_me,
        mt_debito,
        mt_debito_me,
        mt_credito,
        mt_credito_me)
        select 
        of_oficina,
		cu_cuenta,
		cu_nombre,
		sum(convert(float,isnull(sa_saldo,0))),
		sum(convert(float,isnull(sa_saldo_me,0))),
		sum(convert(float,isnull(sa_debito,0))),
		sum(convert(float,isnull(sa_debito_me,0))),
	    sum(convert(float,isnull(sa_credito,0))),
	    sum(convert(float,isnull(sa_credito_me,0)))
	    from cb_saldo, cb_cuenta,cb_oficina,cb_jerarquia
         where sa_empresa = convert(tinyint,@i_empresa)
         and sa_periodo = convert(int,@w_periodo)
         and sa_corte = convert(int,@w_corte)
         and sa_cuenta = cu_cuenta
         and cu_empresa = convert(tinyint,@i_empresa)
         and cu_nivel_cuenta <= convert(tinyint,@i_nivel_cuenta)
         and of_empresa = convert(tinyint,@i_empresa)
         and of_organizacion = convert(tinyint,@i_nivel)
         and je_empresa = convert(tinyint,@i_empresa)
         and je_oficina_padre = of_oficina
         and sa_oficina = je_oficina
         and (of_oficina = @i_oficina or @i_oficina = 0)
         group by of_oficina,cu_cuenta, cu_nombre

	if @@error <> 0
	begin
	   print 'ERROR: En insercion de datos en cb_mayba_tmp'
	   return 1
	end
end
else
begin

--print @w_periodo
--print @w_corte
--print @i_nivel_cuenta
--print @i_nivel
--print @i_oficina

	insert into cb_mayba_tmp (
    mt_oficina,
	mt_cuenta,
	mt_nombre,
	mt_saldo,
	mt_saldo_me,
    mt_debito,
    mt_debito_me,
    mt_credito,
    mt_credito_me) 
    Select 
	of_oficina,
	cu_cuenta,
	cu_nombre,
	sum(convert(float,isnull(hi_saldo,0))),
	sum(convert(float,isnull(hi_saldo_me,0))),
	sum(convert(float,isnull(hi_debito,0))),
	sum(convert(float,isnull(hi_debito_me,0))),
	sum(convert(float,isnull(hi_credito,0))),
	sum(convert(float,isnull(hi_credito_me,0)))
    from cob_conta..cb_hist_saldo_tmp, cb_cuenta,cb_oficina,cb_jerarquia
	where hi_empresa = convert(tinyint,@i_empresa)
  		and hi_periodo = convert(int,@w_periodo)
  		and hi_corte = convert(int,@w_corte)
  		and cu_empresa = convert(tinyint,@i_empresa)
  		and hi_cuenta = cu_cuenta
  		and cu_nivel_cuenta <= convert(tinyint,@i_nivel_cuenta)
  		and of_empresa = convert(tinyint,@i_empresa)
  		and of_organizacion = convert(tinyint,@i_nivel)
  		and je_empresa = convert(tinyint,@i_empresa)
  		and je_oficina_padre = of_oficina
  		and hi_oficina = je_oficina
  		and (of_oficina = @i_oficina or @i_oficina = 0)
		group by of_oficina,cu_cuenta, cu_nombre

	if @@error <> 0
	begin
	   print 'ERROR: En insercion de datos en cb_balof_tmp'
	   return 1
	end
end

/* REQ 271 EXCLUIR CUENTAS CANCELADAS */
update cb_mayba_tmp set
mt_cuenta = '0'
from cb_mayba_tmp, cb_cuenta, #ctas_mes_anterior
where mt_cuenta = cu_cuenta
and   mt_cuenta = cuenta
and   mt_oficina = oficina
and   cu_estado = 'C'
and   round(mt_saldo,2) = 0
and   round(mt_saldo,2) = round(saldo_mes_ant,2)
and   (round(mt_debito,2) - round(debito_mes_ant,2)) = 0
and   (round(mt_credito,2) - round(credito_mes_ant,2)) = 0

if @@error <> 0
begin
   print 'ERROR: Identificando cuentas canceladas cb_mayba_tmp'
   return 1
end

delete from cb_mayba_tmp where mt_cuenta = '0'
if @@error <> 0
begin
   print 'ERROR: Eliminando cuentas canceladas cb_mayba_tmp'
   return 1
end

return 0
 
go

