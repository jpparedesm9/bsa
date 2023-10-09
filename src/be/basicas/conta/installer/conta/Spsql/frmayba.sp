/************************************************************************/
/*   Stored procedure:     sp_mayba                                     */
/*   Base de datos:        cob_conta                                    */
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
/*  Extracción de información para generación del reporte de front end  */
/*  mayor y balance.                                                    */
/************************************************************************/
 
use cob_conta
go
 
if exists (select 1 from sysobjects where name = 'sp_extramov_mayba')
   drop proc sp_extramov_mayba
go
 
create proc sp_extramov_mayba (
   @i_empresa        tinyint   = null,
   @i_fecha          datetime  = null,
   @i_oficina        smallint  = 255,
   @i_nivel_cuenta   tinyint   = 6,
   @i_nivel          tinyint   = 1,
   @i_finperiodo     char(1)   = 'N',
   @i_fecha_finp     datetime  = null
)
as
declare 
@w_estado                char(1),
@w_corte                 int,
@w_periodo               int,
@w_fecha_ant             datetime,
@w_corte_ant             int,
@w_periodo_ant           int,
@w_estado_ant            char(1),
@w_cortefp               int,
@w_fin_mes_ant           datetime,
@w_corte_fin_mes_ant     int,
@w_periodo_fin_mes_ant   int

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

select	@w_corte = co_corte,@w_periodo=co_periodo,@w_estado = co_estado
from    cb_corte with(nolock)
where   co_empresa   = @i_empresa
and     co_periodo   >= 0
and     co_corte     >= 0
and     co_fecha_ini >= @i_fecha
and     co_fecha_fin <= @i_fecha

if @@rowcount = 0
begin
   print 'ERROR (1): Corte de la fecha de reporte no encontrado'
   return 1
end

truncate table cob_conta..cb_libromov_mayba

select @w_fin_mes_ant = dateadd(dd,-(datepart(dd,@i_fecha)),@i_fecha)

set transaction isolation level READ UNCOMMITTED

select 
@w_corte_fin_mes_ant   = co_corte,
@w_periodo_fin_mes_ant = co_periodo
from  cb_corte with(nolock)
where co_empresa   = @i_empresa
and   co_periodo   >= 0
and   co_corte     >= 0
and   co_fecha_ini >= @w_fin_mes_ant
and   co_fecha_fin <= @w_fin_mes_ant

if @@rowcount = 0
begin
   print 'ERROR (2): Corte de la Fecha Fin Mes Anterior no encontrado'
   return 1
end
   
if @i_finperiodo = 'S' begin
   select
   @w_corte_fin_mes_ant   = co_corte+1,
   @w_periodo_fin_mes_ant = co_periodo
   from  cb_corte with(nolock)
   where co_empresa   = @i_empresa
   and   co_periodo   >= 0
   and   co_corte     >= 0
   and   co_fecha_ini >= @i_fecha_finp
   and   co_fecha_fin <= @i_fecha_finp
   
   print @w_corte_fin_mes_ant
   print @w_periodo_fin_mes_ant
end

if exists (select 1 from cob_conta..sysobjects where name = 'cb_tmp_saldo')
   drop table cb_tmp_saldo

select * 
into cb_tmp_saldo 
from cob_conta_his..cb_hist_saldo with(nolock)
where hi_empresa = convert(tinyint,@i_empresa)
and   hi_periodo = convert(int,@w_periodo_fin_mes_ant)
and   hi_corte   = convert(int,@w_corte_fin_mes_ant)

insert into cb_tmp_saldo
select * 
from cob_conta_his..cb_hist_saldo with(nolock)
where hi_empresa = convert(tinyint,@i_empresa)
and   hi_periodo = convert(int,@w_periodo)
and   hi_corte   = convert(int,@w_corte)

--create index idx1 on cb_tmp_saldo(hi_cuenta, hi_oficina, hi_corte, hi_periodo)

Select 
'oficina'         = of_oficina,
'cuenta'          = cu_cuenta,
'saldo_mes_ant'   = convert(float,(isnull(sum(hi_saldo),0))),
'debito_mes_ant'  = convert(float,(isnull(sum(hi_debito),0))),
'credito_mes_ant' = convert(float,(isnull(sum(hi_credito),0)))
into #ctas_mes_anterior
from cob_conta..cb_tmp_saldo with(nolock), 
     cb_cuenta with(nolock), 
     cb_oficina with(nolock),
     cb_jerarquia with(nolock)
where hi_cuenta        = cu_cuenta
and hi_periodo       = convert(int,@w_periodo_fin_mes_ant)
and hi_corte         = convert(int,@w_corte_fin_mes_ant)
and hi_empresa       = convert(tinyint,@i_empresa)
and cu_empresa       = convert(tinyint,@i_empresa)
and cu_nivel_cuenta <= convert(tinyint,@i_nivel_cuenta)
and of_empresa       = convert(tinyint,@i_empresa)
and of_organizacion  = convert(tinyint,@i_nivel)
and je_empresa       = convert(tinyint,@i_empresa)
and je_oficina_padre = of_oficina
and hi_oficina       = je_oficina
and (of_oficina      = @i_oficina or @i_oficina = 0)
group by of_oficina,cu_cuenta, cu_nombre

select count(*) from #ctas_mes_anterior

if @w_estado = 'A' 
begin
   insert into cb_libromov_mayba(
   lm_oficina,      lm_cuenta,       lm_nombre,
   lm_saldo,
   lm_saldo_me,
   lm_debito,
   lm_debito_me,
   lm_credito,
   lm_credito_me)
   select 
   of_oficina,       cu_cuenta,       cu_nombre,
   convert(float,(isnull(sum(sa_saldo),0))),
   convert(float,(isnull(sum(sa_saldo_me),0))),
   convert(float,(isnull(sum(sa_debito),0))),
   convert(float,(isnull(sum(sa_debito_me),0))),
   convert(float,(isnull(sum(sa_credito),0))) ,
   convert(float,(isnull(sum(sa_credito_me),0)))
   from cb_saldo with(nolock), 
        cb_cuenta with(nolock),
        cb_oficina with(nolock),
        cb_jerarquia with(nolock)
   where sa_empresa     = convert(tinyint,@i_empresa)
   and sa_periodo       = convert(int,@w_periodo)
   and sa_corte         = convert(int,@w_corte)
   and sa_cuenta        = cu_cuenta
   and cu_empresa       = convert(tinyint,@i_empresa)
   and cu_nivel_cuenta <= convert(tinyint,@i_nivel_cuenta)
   and of_empresa       = convert(tinyint,@i_empresa)
   and of_organizacion  = convert(tinyint,@i_nivel)
   and je_empresa       = convert(tinyint,@i_empresa)
   and je_oficina_padre = of_oficina
   and sa_oficina       = je_oficina
   and (of_oficina      = @i_oficina or @i_oficina = 0)
   group by of_oficina,cu_cuenta, cu_nombre

   if @@error <> 0
   begin
      print 'ERROR: En insercion de datos en cb_mayba_tmp'
      return 1
   end
end
else
begin

   insert into cb_libromov_mayba (
   lm_oficina,      lm_cuenta,       lm_nombre,
   lm_saldo,
   lm_saldo_me,
   lm_debito,
   lm_debito_me,
   lm_credito,
   lm_credito_me)
   Select 
   of_oficina,      cu_cuenta,   cu_nombre,
   convert(float,(isnull(sum(hi_saldo),0))),
   convert(float,(isnull(sum(hi_saldo_me),0))),
   convert(float,(isnull(sum(hi_debito),0))),
   convert(float,(isnull(sum(hi_debito_me),0))),
   convert(float,(isnull(sum(hi_credito),0))) ,
   convert(float,(isnull(sum(hi_credito_me),0)))
   from cob_conta..cb_tmp_saldo with(nolock), 
        cb_cuenta with(nolock), 
        cb_oficina with(nolock),
        cb_jerarquia with(nolock)
   where hi_empresa     = convert(tinyint,@i_empresa)
   and hi_periodo       = convert(int,@w_periodo)
   and hi_corte         = convert(int,@w_corte)
   and cu_empresa       = convert(tinyint,@i_empresa)
   and hi_cuenta        = cu_cuenta
   and cu_nivel_cuenta <= convert(tinyint,@i_nivel_cuenta)
   and of_empresa       = convert(tinyint,@i_empresa)
   and of_organizacion  = convert(tinyint,@i_nivel)
   and je_empresa       = convert(tinyint,@i_empresa)
   and je_oficina_padre = of_oficina
   and hi_oficina       = je_oficina
   and (of_oficina      = @i_oficina or @i_oficina = 0)
   group by of_oficina,cu_cuenta, cu_nombre

   if @@error <> 0
   begin
      print 'ERROR: En insercion de datos en cb_balof_tmp'
      return 1
   end
end

update cb_libromov_mayba set
lm_saldo_anterior = saldo_mes_ant,
lm_debito  = lm_debito - debito_mes_ant,
lm_credito = lm_credito - credito_mes_ant
from cb_libromov_mayba with(rowlock), 
     cb_cuenta with(rowlock), 
     #ctas_mes_anterior
where lm_cuenta          = cu_cuenta
and   lm_cuenta          = cuenta
and   lm_oficina         = oficina

if @@error <> 0
begin
   print 'ERROR: actualizando saldo anterior'
   return 1
end

update cb_libromov_mayba set
lm_saldo_anterior = 0
from cb_libromov_mayba with(rowlock)
where lm_saldo_anterior IS NULL

if @@error <> 0
begin
   print 'ERROR: actualizando saldo anterior'
   return 1
end

update cb_libromov_mayba set
lm_cuenta = '0'
from cb_libromov_mayba with(rowlock), 
     cb_cuenta with(rowlock), 
     #ctas_mes_anterior
where lm_cuenta          = cu_cuenta
and   lm_cuenta          = cuenta
and   lm_oficina         = oficina
and   cu_estado          = 'C'
and   round(lm_saldo,2)  = 0
and   round(lm_saldo,2)  = round(saldo_mes_ant,2)
and   (round(lm_debito,2) - round(debito_mes_ant,2))   = 0
and   (round(lm_credito,2) - round(credito_mes_ant,2)) = 0

if @@error <> 0
begin
   print 'ERROR: Identificando cuentas canceladas cb_mayba_tmp'
   return 1
end

delete from cb_libromov_mayba where lm_cuenta = '0'
if @@error <> 0
begin
   print 'ERROR: Eliminando cuentas canceladas cb_mayba_tmp'
   return 1
end

return 0
 
go