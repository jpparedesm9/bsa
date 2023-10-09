/*mov_ofi.sp*************************************************************/
/*   Stored procedure:     sp_saltercero                                */
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

set ansi_nulls off
go
 
if exists (select 1 from sysobjects where name = 'sp_mov_ofi')
   drop proc sp_mov_ofi
go

create proc sp_mov_ofi
(
    @i_empresa        tinyint,
    @i_fecha          datetime
)
as

declare 
    @w_fecha_fm       smalldatetime,
    @w_corte          smallint,
    @w_periodo        smallint,
    @w_cuenta         varchar(14),
    @w_concepto       varchar(60),
    @w_descripcion    varchar(60),
    @w_tr_banco       char(24),
    @w_con_iva        char(4),
    @w_valor_iva      money,
    @w_re_area        smallint,
    @w_credito_me     money,
    @w_debito_me      money,
    @w_cotizacion     money,
    @w_cod_producto   tinyint,
    @w_dp_debcred     char(1),
    @w_comprobante    int,
    @w_asiento        int,
    @w_error          int,
    @w_ente           int,
    @w_saldo          money,
    @w_credito        money,
    @w_debito         money,
    @w_oficina_dest   smallint,
    @w_oficina_orig   smallint,
    @w_valor_base     money,
    @w_mensaje        varchar(60),
    @w_moneda_as      tinyint,
    @w_total          varchar(20),
    @w_user           descripcion,
    @w_perfil         varchar(20),
    @w_tot_debito     money,
    @w_tot_credito    money,
    @w_tot_debito_me  money,
    @w_tot_credito_me money,
    @w_credito_tmp    money


select @w_concepto     = 'ASIENTO AJUSTE OFICINAS'
select @w_descripcion  = 'COMPROBANTE AJUSTE OFICINAS'
select @w_re_area      = 31
select @w_credito_me   = 0
select @w_debito_me    = 0
select @w_credito      = 0
select @w_debito       = 0
select @w_cotizacion   = 1
select @w_cod_producto = 6
select @w_dp_debcred   = 1
select @w_moneda_as    = 0
select @w_user         = 'conbatch'
select @w_perfil = ''


select @w_fecha_fm = dateadd(dd, 1-datepart(dd,@i_fecha), @i_fecha) --calcular el primer dia del mes
select @w_fecha_fm = dateadd(mm, 1, @w_fecha_fm)                    --determinar el primer dia del mes siguiente
select @w_fecha_fm = dateadd(dd,-1, @w_fecha_fm)                    --determinar el fin de mes anterior
select @w_fecha_fm = dateadd(mm,-1, @w_fecha_fm)                    --determinar el fin de mes anterior

select 
@w_corte    = co_corte,
@w_periodo  = co_periodo
from cob_conta..cb_corte
where co_fecha_ini = @w_fecha_fm
and   co_empresa   = @i_empresa

select distinct cuenta = bo_cuenta
into #cuentas
from cb_boc_respaldo

select 
cuenta  = sa_cuenta, 
oficina = sa_oficina_dest, 
cliente = sa_ente, 
saldo   = sa_debito - sa_credito
into #saldos
from cob_conta_tercero..ct_sasiento
where 1=2

create table #mov_ofi
(
mv_fecha            datetime, 
mv_cuenta           varchar(14), 
mv_oficina_orig     smallint,   
mv_oficina_dest     smallint,
mv_ente             int,  
mv_saldo_op         money, 
mv_saldo_con        money
)

select *
into #saldo
from #mov_ofi
where 1 = 2

select @w_cuenta = ''

select distinct do_codigo_cliente, do_oficina
into #clientes
from cob_credito..cr_dato_operacion
where do_estado_contable in (1,2,4)
and   do_tipo_reg = 'D'
--and   do_fecha    = @i_fecha

select cod_cliente = do_codigo_cliente
into #cliente_2ofi
from #clientes
group by do_codigo_cliente
having count(1) > 1

create nonclustered index clientes on #clientes (do_codigo_cliente, do_oficina)

delete #clientes
from #cliente_2ofi
where do_codigo_cliente = cod_cliente

while 1=1 begin

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

   insert into #mov_ofi   
   select
   @i_fecha,                             @w_cuenta,                 st_oficina,   do_oficina,
   st_ente,                              0,                         isnull(sum(isnull(st_saldo, 0)),0)
   from cob_conta_tercero..ct_saldo_tercero with (index = ct_saldo_tercero_Key_cuenta),
        #clientes
   where st_cuenta  = @w_cuenta
   and   st_corte   = @w_corte
   and   st_periodo = @w_periodo
   and   st_oficina <> do_oficina
   and   st_ente    = do_codigo_cliente
   group by st_oficina, do_oficina, st_ente

   insert into #mov_ofi

   select 

   cuenta  = @w_cuenta, 

   oficina = sa_oficina_dest, 

   cliente = sa_ente, 

   saldo   = sum(isnull(sa_debito,0) - isnull(sa_credito,0))

   from cob_conta_tercero..ct_sasiento,  cob_conta_tercero..ct_scomprobante

   where sa_cuenta       = @w_cuenta

   and   sa_fecha_tran  <= @i_fecha

   and   sa_fecha_tran   > @w_fecha_fm

   and   sa_comprobante  = sc_comprobante

   and   sa_fecha_tran   = sc_fecha_tran

   and   sa_producto     = sc_producto

   and   sa_empresa      = sc_empresa

   and   sc_estado       <> 'A'

   --and   sa_mayorizado   = 'S'

   group by sa_oficina_dest, sa_ente

   having sum(isnull(sa_debito,0) - isnull(sa_credito,0)) <> 0


   insert into #saldo
   select mv_fecha,
          mv_cuenta,
          mv_oficina_orig,
          mv_oficina_dest,
          mv_ente,
          sum(mv_saldo_op),
          sum(mv_saldo_con)
   from #mov_ofi
   group by mv_fecha, mv_cuenta, mv_oficina_orig,
          mv_oficina_dest, mv_ente
   
   while 1 = 1
   begin
      select @w_ente = mv_ente,
             @w_oficina_dest = mv_oficina_dest,
             @w_oficina_orig = mv_oficina_orig,
             @w_saldo        = mv_saldo_con 
      from #saldo
      where abs(mv_saldo_con) > 0

      if @@rowcount = 0
         break

      delete from #saldo
      where mv_ente = @w_ente
      and   mv_oficina_dest = @w_oficina_dest 
      and   mv_oficina_orig  = @w_oficina_orig

      select @w_asiento = 0

      exec @w_error = cob_conta..sp_cseqcomp      
      @i_tabla     = 'cb_scomprobante',       
      @i_empresa   = 1,      
      @i_fecha     = @i_fecha,      
      @i_modulo    = @w_cod_producto,      
      @i_modo      = 0, -- Numera por EMPRESA-FECHA-PRODUCTO      
      @o_siguiente = @w_comprobante out

      if @w_error <> 0
      begin
         goto ERROR1
      end

      if @w_saldo < 0
      begin
          select @w_saldo = @w_saldo * -1
          select @w_credito = 0
          select @w_debito  = @w_saldo
      end
      else
      begin
          select @w_credito = @w_saldo
          select @w_debito  = 0
      end

      if @w_credito > 0
          select @w_dp_debcred = 2
           
      select @w_asiento = @w_asiento +1

      exec @w_error = cob_conta..sp_sasiento      
      @i_operacion      = 'I',      
      @i_fecha_tran     = @i_fecha,      
      @i_comprobante    = @w_comprobante,      
      @i_empresa        = 1,      
      @i_asiento        = @w_asiento,      
      @i_ente           = @w_ente,      
      @i_documento      = @w_tr_banco,      
      @i_base           = @w_valor_base,      
      @i_con_iva        = @w_con_iva,      
      @i_valor_iva      = @w_valor_iva,      
      @i_cuenta         = @w_cuenta,      
      @i_oficina_dest   = @w_oficina_orig,      
      @i_area_dest      = @w_re_area,      
      @i_credito        = @w_credito,      
      @i_debito         = @w_debito,      
      @i_concepto       = @w_concepto,      
      @i_credito_me     = @w_credito_me,      
      @i_debito_me      = @w_debito_me,      
      @i_moneda         = @w_moneda_as,      
      @i_cotizacion     = @w_cotizacion,      
      @i_tipo_doc       = 'N',      
      @i_tipo_tran      = 'A',      
      @i_producto       = @w_cod_producto,      
      @i_debcred        = @w_dp_debcred,      
      @o_desc_error     = @w_mensaje out      
      
      if @w_error !=0 begin         
         select          @w_mensaje = '(sp_sasiento) '+ isnull(@w_mensaje, '')         
         goto ERROR1      
      end

      select @w_credito_tmp = @w_debito
      select @w_debito  = @w_credito
      select @w_credito  = @w_credito_tmp

      if @w_credito > 0
          select @w_dp_debcred = 2

      select @w_asiento = @w_asiento +1

      exec @w_error = cob_conta..sp_sasiento      
      @i_operacion      = 'I',      
      @i_fecha_tran     = @i_fecha,      
      @i_comprobante    = @w_comprobante,      
      @i_empresa        = 1,      
      @i_asiento        = @w_asiento,      
      @i_ente           = @w_ente,      
      @i_documento      = @w_tr_banco,      
      @i_base           = @w_valor_base,      
      @i_con_iva        = @w_con_iva,      
      @i_valor_iva      = @w_valor_iva,      
      @i_cuenta         = @w_cuenta,      
      @i_oficina_dest   = @w_oficina_dest,      
      @i_area_dest      = @w_re_area,      
      @i_credito        = @w_credito,      
      @i_debito         = @w_debito,      
      @i_concepto       = @w_concepto,      
      @i_credito_me     = @w_credito_me,      
      @i_debito_me      = @w_debito_me,      
      @i_moneda         = @w_moneda_as,      
      @i_cotizacion     = @w_cotizacion,      
      @i_tipo_doc       = 'N',      
      @i_tipo_tran      = 'A',      
      @i_producto       = @w_cod_producto,      
      @i_debcred        = @w_dp_debcred,      
      @o_desc_error     = @w_mensaje out      
      
      if @w_error !=0 begin         
      select             @w_mensaje = '(sp_sasiento) '+ isnull(@w_mensaje, '')            
      goto ERROR1      
      end

      exec @w_error = cob_conta..sp_scomprobante      
      @i_operacion      = 'I',      
      @i_producto       = @w_cod_producto,      
      @i_comprobante    = @w_comprobante,      
      @i_empresa        = 1,      
      @i_fecha_tran     = @i_fecha,      
      @i_oficina_orig   = @w_oficina_orig,      
      @i_area_orig      = @w_re_area,      
      @i_digitador      = @w_user,      
      @i_descripcion    = @w_descripcion,      
      @i_perfil         = @w_perfil,      
      @i_detalles       = @w_asiento,      
      @i_tot_debito     = @w_saldo,      
      @i_tot_credito    = @w_saldo,      
      @i_tot_debito_me  = @w_debito_me,      
      @i_tot_credito_me = @w_credito_me,      
      @i_automatico     = @w_cod_producto,      
      @i_reversado      = 'N',      
      @i_estado         = 'I',      
      @i_tran_modulo    = @w_total,      
      @o_desc_error     = @w_mensaje out      
      
      if @w_error !=0 begin         
         select @w_mensaje = '(sp_scomprobante) ' + isnull(@w_mensaje, '')         
         goto ERROR1      
      end
   end
   
   select @w_asiento = 0

   delete from #saldo
end

return 0

ERROR1:
   return 1

go

