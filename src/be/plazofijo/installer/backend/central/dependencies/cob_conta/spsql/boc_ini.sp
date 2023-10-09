/*boc_ini.sp*************************************************************/
/*   Stored procedure:     sp_boc_ini                                   */
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
/************************************************************************/
 
use cob_conta
go
 
if exists (select 1 from sysobjects where name = 'sp_boc_ini')
   drop proc sp_boc_ini
go

CREATE  proc sp_boc_ini
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

select distinct cuenta = re_substring
into #cuentas
from cob_conta..cb_det_perfil, cb_relparam
where dp_perfil   = @i_perfil
and   dp_cuenta   = re_parametro
and   dp_empresa  = re_empresa
and   dp_producto = re_producto


/* Inserta las cuentas que no tienen asociado un parametro */
insert into #cuentas
select distinct cuenta = dp_cuenta
from cob_conta..cb_det_perfil
where dp_perfil   = @i_perfil
and   substring (dp_cuenta, 1,1) in ('1','2','3','4','5','6','8')

create table #oficinas(
oficina smallint not null)

select 
cliente = sa_ente, 
saldo   = sa_debito - sa_credito
into #saldos
from cob_conta_tercero..ct_sasiento
where 1=2

select @w_cuenta = ''

while 1=1 begin  -- LAZO DE CUENTAS

   set rowcount 1

   select @w_cuenta = cuenta
   from   #cuentas
   where  cuenta > @w_cuenta
   order by cuenta

   if @@rowcount = 0 begin
      set rowcount 0
      break
   end

   set rowcount 0
   
   truncate table #oficinas
   
   insert into #oficinas
   select of_oficina
   from cob_conta..cb_oficina
   where of_empresa = @i_empresa
   and   of_movimiento = 'S'

   
   /* DETERMINO SI ES CUENTA DE TERCERO */
   if exists (select * from cob_conta..cb_cuenta_proceso where cp_proceso in (6003, 6095) and cp_cuenta = @w_cuenta)
      select @w_tercero = 'S'
   else
      select @w_tercero = 'N'
  
   select @w_oficina = 0
   
   while 2=2 begin -- LAZO DE OFICINAS
   
      set rowcount 1
      
      select @w_oficina = oficina
      from #oficinas
      
      if @@rowcount = 0 begin
         set rowcount 0
         break
      end
      
      set rowcount 0
      
      delete #oficinas
      where oficina = @w_oficina            

      if @w_tercero = 'S' begin
      
         insert into #saldos
         select 
         cliente = st_ente, 
         saldo   = sum(isnull(st_saldo, 0))
         from cob_conta_tercero..ct_saldo_tercero
         where st_cuenta  = @w_cuenta
         and   st_corte   = @w_corte
         and   st_periodo = @w_periodo
         and   st_oficina = @w_oficina
         group by st_ente
         having sum(isnull(st_saldo, 0)) <> 0
         
         if @@error <> 0 begin
            select @o_msg = 'ERROR AL INSERTAR SALDOS EN TABLA TEMPORAL SICREDITO'
            return 710001
         end
         
         insert into #saldos
         select 
         cliente = sa_ente, 
         saldo   = sum(isnull(sa_debito,0) - isnull(sa_credito,0))
         from cob_conta_tercero..ct_sasiento,  cob_conta_tercero..ct_scomprobante
         where sa_cuenta       = @w_cuenta
         and   sa_oficina_dest = @w_oficina
         and   sa_fecha_tran   between dateadd(dd,1,@w_fecha_fm) and @i_fecha
         and   sa_comprobante  = sc_comprobante
         and   sa_fecha_tran   = sc_fecha_tran
         and   sa_producto     = sc_producto
         and   sa_empresa      = sc_empresa
         and   sc_empresa      = @i_empresa
         and   sc_estado       <> 'A'
         group by sa_ente
         having sum(isnull(sa_debito,0) - isnull(sa_credito,0)) <> 0
         
         if @@error <> 0 begin
            select @o_msg = 'ERROR AL INSERTAR MOVIMIENTOS EN TABLA TEMPORAL SICREDITO'
            return 710001
         end

      end else begin  --la cuenta no es de tercero

         insert into #saldos
         select
         cliente = 0,
         saldo   = isnull(sum(sa_debito -sa_credito), 0)
         from cob_conta_tercero..ct_scomprobante (nolock),
              cob_conta_tercero..ct_sasiento (nolock)
         where sa_cuenta       = @w_cuenta
         and   sa_oficina_dest = @w_oficina
         and   sa_fecha_tran   <= @i_fecha
         and   sa_fecha_tran   in (select co_fecha_ini
                                   from cob_conta..cb_corte
                                   where co_estado in ('A', 'V'))
         and   sa_comprobante  = sc_comprobante
         and   sa_fecha_tran   = sc_fecha_tran
         and   sa_producto     = sc_producto
         and   sa_empresa      = sc_empresa
         and   sc_empresa      = @i_empresa
         and   sc_estado       = 'B'      
         
         if @@error <> 0 begin
            select @o_msg = 'ERROR AL INSERTAR MOVIMIENTOS EN TABLA TEMPORAL SICREDITO'
            return 710001
         end         
      
         if @w_estado_hoy in ('V', 'C')
         begin
            insert into #saldos
            select 
            cliente = 0,
            saldo   = isnull(sum(hi_saldo), 0) 
            from cob_conta_his..cb_hist_saldo
            where hi_corte   = @w_corte_hoy
            and   hi_periodo = @w_periodo_hoy
            and   hi_oficina = @w_oficina 
            and   hi_cuenta  = @w_cuenta
         end
         else
         begin
            insert into #saldos
            select 
            cliente = 0,
            saldo   = isnull(sum(sa_saldo), 0) 
            from cob_conta..cb_saldo
            where sa_corte   = @w_corte_hoy
            and   sa_periodo = @w_periodo_hoy
            and   sa_oficina = @w_oficina 
            and   sa_cuenta  = @w_cuenta
         end         

         if @@error <> 0 begin
            select @o_msg = 'ERROR LA REGISTRAR LOS RESULTADOS EN LA TABLA DEL BOC SICREDITO'
            return 710001
         end
            
      end
 
      insert into #boc (
      bo_cuenta,                 bo_oficina,                           bo_cliente,                           
      bo_banco,                  bo_concepto,                          bo_val_opera,              
      bo_val_conta)
      select
      @w_cuenta,                 @w_oficina,                           cliente,
      '',                        '',                                   0,
      sum(saldo) 
      from #saldos
      group by cliente
      
      if @@error <> 0 begin
         select @o_msg = 'ERROR LA REGISTRAR LOS RESULTADOS EN LA TABLA DEL BOC SICREDITO'
         return 710001
      end
     
      truncate table #saldos
      
   end --lazo de oficinas
   
end -- lazo de cuentas

return 0

go


