
use cob_conta 
go

declare @w_cta_gar_liq   cuenta  ,
        @w_cuenta        varchar(100),
        @w_fecha_fm      datetime,
        @w_corte         int ,
        @w_periodo       int ,
        @i_fecha         datetime
        
declare 
@w_cliente int,
@w_cotizacion money ,
@w_asiento int,
@w_comprobante int,
@w_max_oficina int , 
@w_max_area int,
@w_max_asientos int,
@w_msg varchar(255),
@w_fecha_proceso datetime ,
@w_oficina int, 
@w_tot_debito money, 
@w_tot_credito money,
@w_tot_debito_me money,
@w_tot_credito_me money,
@w_operacioca int, 
@w_error int,
@w_commit char(1),
@w_diferencia_boc money


select 
@w_cotizacion = 1,
@w_commit = 'N'



select @w_cta_gar_liq = pa_char
from   cobis..cl_parametro with (nolock)
where  pa_producto = 'CCA'
and    pa_nemonico = 'CTGARL'

select @w_fecha_proceso = '06/25/2019',
       @i_fecha         = '06/25/2019'


select @w_cuenta =  @w_cta_gar_liq  


while exists( select 1 from cobis..cl_dias_feriados where df_ciudad = 999 and df_fecha = @w_fecha_proceso) 
select @w_fecha_proceso =dateadd(dd,-1,@w_fecha_proceso)

select @w_fecha_fm = dateadd(dd,1-datepart(dd,@w_fecha_proceso),@w_fecha_proceso)
select @w_fecha_fm = dateadd(mm,1,@w_fecha_fm)
select @w_fecha_fm = dateadd(dd,-1,@w_fecha_fm)

select @w_corte = co_corte,
@w_periodo = co_periodo
from cob_conta..cb_corte
where co_fecha_ini = @w_fecha_fm

select 
'cliente'         = st_ente ,
'oficina'         = st_oficina,
'saldo_contable'  = st_saldo * (-1),
'saldo_operativo' = convert(money,0),
'marca' = 'C'
into #saldos_cuentas_garantias 
from cob_conta_tercero..ct_saldo_tercero
where st_cuenta   = @w_cuenta
and   st_periodo  = @w_periodo
and   st_corte    = @w_corte

insert into #saldos_cuentas_garantias 
select 
'cliente'        = dc_cliente, 
'oficina'        = convert(int, 0),
'saldo_contable' = convert(money,0),
'saldo_operativo'= sum(isnull(dc_gl_pag_valor,0)),
'marca' = 'O'
from cob_conta_super..sb_dato_custodia
where dc_fecha                     = @i_fecha
and   dc_gl_pag_estado             = 'CB'
and   isnull(dc_gl_dev_estado,'X') <> 'D'
group by dc_cliente

select 
mcliente      = op_cliente ,
max_operacion = max(op_operacion) 
into #max_operaciones 
from cob_cartera..ca_operacion a,
     cob_credito..cr_tramite_grupal
where op_cliente in ( select cliente from #saldos_cuentas_garantias )
and   op_operacion         = tg_operacion
and   tg_referencia_grupal <> tg_prestamo
and   tg_monto             > 0
group by op_cliente


update #saldos_cuentas_garantias set 
oficina = op_oficina 
from cob_cartera..ca_operacion , #max_operaciones 
where cliente = mcliente 
and op_operacion = max_operacion 
and marca = 'O'


select *
into #cb_boc_alinieamiento
from cob_conta..cb_boc 
where 1 = 19


insert into #cb_boc_alinieamiento( 
bo_fecha       , 
bo_cuenta      ,
bo_oficina     ,
bo_cliente     ,
bo_val_opera   ,
bo_val_conta   ,
bo_diferencia  ,
bo_producto )   
select 
'fecha'           = @w_fecha_proceso,
'cuenta'          = @w_cuenta,
'oficina'         = oficina,
'cliente'         = cliente,
'saldo_operativo' = sum(saldo_operativo),
'saldo_contable'  = sum(saldo_contable),
'diferencia'      = sum(saldo_contable) - sum(saldo_operativo),
'producto'        = 19
from #saldos_cuentas_garantias
group by cliente,oficina


---ALINEAMINENTO


select @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso


select @w_cliente = 0

select * into #asientos from cob_conta_tercero..ct_sasiento_tmp
where 1 = 2

while (1=1) begin

   select top 1 @w_cliente = bo_cliente 
   from #cb_boc_alinieamiento
   where bo_cliente > @w_cliente
   and   bo_diferencia <> 0
   order by bo_cliente

   if @@rowcount = 0 break

   print '@w_cliente' + convert(varchar(10), @w_cliente)

   --verificar suma de las diferencia den cero
   --
   select @w_diferencia_boc = sum(bo_diferencia) 
   from #cb_boc_alinieamiento where bo_cliente = @w_cliente
   
   if @w_diferencia_boc <> 0 goto SIGUIENTE
   
   truncate table #asientos

    /* RESERVAR UN RANGO DE COMPROBANTES */
    exec @w_error = cob_conta..sp_cseqcomp
    @i_tabla = 'cb_scomprobante', 
    @i_empresa = 1,
    @i_fecha = @w_fecha_proceso,
    @i_modulo = 7,
    @i_modo = 0, -- Numera por EMPRESA-FECHA-PRODUCTO
    @o_siguiente = @w_comprobante out

    if @w_error <> 0 begin
       select @w_msg = 'ERROR: AL GENERAR NUMERO DE COMPROBANTE'
       goto ERROR
    end 
    
    
    insert into #asientos( 
    sa_producto, sa_fecha_tran, sa_comprobante,
    sa_empresa, sa_asiento, sa_cuenta,
    sa_oficina_dest, sa_area_dest, 
    sa_credito,
    sa_debito, 
    sa_credito_me,
    sa_debito_me, 
    sa_concepto, sa_cotizacion, sa_tipo_doc,
    sa_tipo_tran, sa_moneda, sa_opcion,
    sa_ente, sa_con_rete, sa_base,
    sa_valret, sa_con_iva, sa_valor_iva,
    sa_iva_retenido, sa_con_ica, sa_valor_ica,
    sa_con_timbre, sa_valor_timbre, sa_con_iva_reten,
    sa_con_ivapagado, sa_valor_ivapagado, sa_documento,
    sa_mayorizado, sa_con_dptales, sa_valor_dptales,
    sa_posicion, 
    sa_debcred, 
    sa_oper_banco, sa_cheque, sa_doc_banco, 
    sa_fecha_est, sa_detalle, sa_error)
    select 
    7, @w_fecha_proceso, @w_comprobante,
    1, 0, bo_cuenta, 
    bo_oficina, 1090, 
    case when bo_diferencia < 0 then abs(bo_diferencia) else 0 end,
    case when bo_diferencia > 0 then abs(bo_diferencia) else 0 end,
    0,
    0,
    'ALINEAMIENTO', @w_cotizacion, 'N',
    'A', cu_moneda, 0, 
    bo_cliente, 'N', 0,
    0, 'N', 0, 
    0, 'N', 0, 
    'N', 0, 'N',
    'N', 0, 'ALINEAMIENTO',
    'N', null, null,
    'S', 
    case when bo_diferencia < 0 then '2' else '1' end, 
    null, null, null, 
    null, null, 'N' 
   from #cb_boc_alinieamiento, cb_cuenta 
   where bo_cuenta = cu_cuenta 
   and abs(bo_diferencia) >= 0.01
   and bo_cliente = @w_cliente 

   if @@error <> 0 begin 
      select @w_msg = 'ERROR: AL INSERTAR LOS ASIENTOS'
     goto ERROR
   end 

   select @w_asiento = 0

   update #asientos set 
   sa_asiento = @w_asiento, 
   @w_asiento = @w_asiento +1


   --datos 
   select 
   @w_max_oficina = max(sa_oficina_dest),
   @w_max_area = max(sa_area_dest),
   @w_max_asientos = max(sa_asiento),
   @w_tot_debito = sum(sa_debito),
   @w_tot_credito = sum(sa_credito),
   @w_tot_debito_me = sum(sa_debito_me),
   @w_tot_credito_me = sum(sa_credito_me)
   from #asientos

   --- 
    
   if @@trancount = 0 begin 
      select @w_commit = 'S'
      begin tran 
   end 

   insert into cob_conta_tercero..ct_scomprobante_tmp with (rowlock) (
   sc_producto, sc_comprobante, sc_empresa,
   sc_fecha_tran, sc_oficina_orig, sc_area_orig,
   sc_digitador, sc_descripcion, sc_fecha_gra, 
   sc_perfil, sc_detalles, sc_tot_debito,
   sc_tot_credito, sc_tot_debito_me, sc_tot_credito_me,
   sc_automatico, sc_reversado, sc_estado,
   sc_mayorizado, sc_observaciones, sc_comp_definit,
   sc_usuario_modulo, sc_tran_modulo, sc_error)
   values (
   7, @w_comprobante, 1,
   @w_fecha_proceso, @w_max_oficina, @w_max_area,
   'CONSOLA', 'ALINEAMIENTO', getdate(), 
   'CCA_EST', @w_max_asientos, @w_tot_debito,
   @w_tot_credito, @w_tot_debito_me, @w_tot_credito_me,
   7, 'N', 'I',
   'N', null, null,
   'sa', 0, 'N')

   if @@error <> 0 begin 
      select @w_msg = 'ERROR: AL INSERTAR DETALLE DE COMPROBANTES'
      goto ERROR
   end 

   insert into cob_conta_tercero..ct_sasiento_tmp
   select * from #asientos

   if @w_commit = 'S' begin 
      select @w_commit = 'N'
      commit tran 
   end 


   goto SIGUIENTE 

   ERROR:
        print @w_msg 

   if @w_commit = 'S' begin 
     select @w_commit = 'N'
     rollback tran 
   end 
   
   SIGUIENTE: 
end

go

drop table #asientos

go

