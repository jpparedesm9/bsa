/*boc_ini.sp*************************************************************/
/*   Stored procedure:     sp_boc_ini_opt                               */
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
/*   BOC de doble via.                                                  */
/*   Feb-2020                AZU             Optimizacion               */
/************************************************************************/
 
use cob_conta
go
 
if exists (select 1 from sysobjects where name = 'sp_boc_ini_opt')
   drop proc sp_boc_ini_opt
go

CREATE  proc sp_boc_ini_opt
    @i_empresa     tinyint,
    @i_fecha       datetime,
    @i_producto    smallint,
    @i_perfil      varchar(10),
    @o_msg         varchar(50)    out

as
 
declare 
    @w_fecha_fm      datetime,
    @w_corte         int, 
    @w_periodo       smallint,
    @w_cuenta        cuenta,
    @w_fecha         datetime,
    @w_corte_hoy     smallint,
    @w_periodo_hoy   smallint,
    @w_oficina       int,
    @w_tercero       char(1),
    @w_estado_hoy    char(1)
  
select @w_fecha_fm = dateadd(dd, -1*datepart(dd,@i_fecha), @i_fecha)

select 
@w_corte    = co_corte,
@w_periodo  = co_periodo
from cob_conta..cb_corte
where co_fecha_ini = @w_fecha_fm
and   co_empresa   = @i_empresa

select 
@w_corte_hoy    = co_corte,
@w_periodo_hoy  = co_periodo,
@w_estado_hoy   = co_estado
from cob_conta..cb_corte
where co_fecha_ini = @i_fecha
and   co_empresa   = @i_empresa

create table #cuentas_opt (
cuenta              varchar(20) null,
cuenta_tercero      char(1)     null
)

insert into #cuentas_opt (cuenta, cuenta_tercero)
select distinct cuenta = re_substring,  'N'
from cob_conta..cb_det_perfil, cb_relparam
where dp_perfil   = @i_perfil
and   dp_cuenta   = re_parametro
and   dp_empresa  = re_empresa
and   dp_producto = re_producto

/* Inserta las cuentas que no tienen asociado un parametro */
insert into #cuentas_opt (cuenta, cuenta_tercero)
select distinct cuenta = dp_cuenta, 'N'
from cob_conta..cb_det_perfil
where dp_perfil   = @i_perfil
and   substring (dp_cuenta, 1,1) in ('1','2','3','4','5','6','8')

update #cuentas_opt 
set cuenta_tercero = 'S'
from cob_conta..cb_cuenta_proceso 
where cp_proceso in (6003, 6095) 
and   cp_cuenta = cuenta

select 
cliente = sa_ente, 
oficina = 0,
cuenta  = convert(varchar(20),''),
saldo   = sa_debito - sa_credito
into #saldos_boc
from cob_conta_tercero..ct_sasiento
where 1=2

create table #oficinas
(oficina   int null)

insert into #oficinas (oficina)
select of_oficina
from cob_conta..cb_oficina
where of_empresa = @i_empresa
and   of_movimiento = 'S'

--SALDOS POR TERCERO DEL CORTE ANTERIOR
insert into #saldos_boc
select 
cliente = st_ente, 
oficina = oficina,
cuenta  = cuenta,
saldo   = sum(isnull(st_saldo, 0))
from cob_conta_tercero..ct_saldo_tercero, #cuentas_opt, #oficinas
where st_cuenta         = cuenta
and   st_corte          = @w_corte
and   st_periodo        = @w_periodo
and   st_oficina        = oficina
and   cuenta_tercero    = 'S'
group by st_ente, oficina, cuenta
having sum(isnull(st_saldo, 0)) <> 0

--MOVIMIENTOS DEL MES
insert into #saldos_boc
select 
cliente = sa_ente, 
oficina = oficina,
cuenta  = cuenta,
saldo   = sum(isnull(sa_debito,0) - isnull(sa_credito,0))
from cob_conta_tercero..ct_sasiento,  cob_conta_tercero..ct_scomprobante, #cuentas_opt, #oficinas
where sa_cuenta              = cuenta
and   sa_oficina_dest        = oficina
and   cuenta_tercero         = 'S'
and   sa_fecha_tran          between dateadd(dd,1,@w_fecha_fm) and @i_fecha
and   sa_comprobante         = sc_comprobante
and   sa_fecha_tran          = sc_fecha_tran
and   sa_producto            = sc_producto
and   sa_empresa             = sc_empresa
and   sc_empresa             = @i_empresa
and   sc_estado              <> 'A'
group by sa_ente, oficina, cuenta	         
having sum(isnull(sa_debito,0) - isnull(sa_credito,0)) <> 0

insert into #saldos_boc
select
cliente = 0,
oficina = oficina,
cuenta  = cuenta,
saldo   = isnull(sum(sa_debito -sa_credito), 0)
from cob_conta_tercero..ct_scomprobante (nolock), cob_conta_tercero..ct_sasiento (nolock), #oficinas, #cuentas_opt
where sa_cuenta              = cuenta
and   sa_oficina_dest        = oficina
and   cuenta_tercero         = 'N'
and   sa_fecha_tran          <= @i_fecha
and   sa_fecha_tran          in (select co_fecha_ini
                                 from cob_conta..cb_corte
                                 where co_estado in ('A', 'V'))
and   sa_comprobante         = sc_comprobante
and   sa_fecha_tran          = sc_fecha_tran
and   sa_producto            = sc_producto
and   sa_empresa             = sc_empresa
and   sc_empresa             = @i_empresa
and   sc_estado              = 'B'   
group by oficina, cuenta   

if @w_estado_hoy in ('V', 'C')
begin
   insert into #saldos_boc
   select 
   cliente = 0,
   oficina = oficina,
   cuenta  = cuenta,
   saldo   = isnull(sum(hi_saldo), 0) 
   from cob_conta_his..cb_hist_saldo, #oficinas, #cuentas_opt
   where hi_corte          = @w_corte_hoy
   and   hi_periodo        = @w_periodo_hoy
   and   hi_oficina        = oficina 
   and   hi_cuenta         = cuenta
   and   cuenta_tercero    = 'N'
   group by oficina, cuenta 
end
else
begin
   insert into #saldos_boc
   select 
   cliente = 0,
   oficina = oficina,
   cuenta  = cuenta,
   saldo   = isnull(sum(sa_saldo), 0) 
   from cob_conta..cb_saldo, #oficinas, #cuentas_opt
   where sa_corte         = @w_corte_hoy
   and   sa_periodo       = @w_periodo_hoy
   and   sa_oficina       = oficina 
   and   sa_cuenta        = cuenta
   and   cuenta_tercero   = 'N'
   group by oficina, cuenta 
end         

insert into #boc (
bo_cuenta,                 bo_oficina,                           bo_cliente,                           
bo_banco,                  bo_concepto,                          bo_val_opera,              
bo_val_conta)
select
cuenta,                    oficina,                              cliente,
'',                        '',                                   0,
sum(saldo) 
from #saldos_boc
group by cliente, oficina, cuenta

if @@error <> 0 begin
   select @o_msg = 'ERROR LA REGISTRAR LOS RESULTADOS EN LA TABLA DEL BOC SICREDITO'
   return 710001
end

return 0

GO

