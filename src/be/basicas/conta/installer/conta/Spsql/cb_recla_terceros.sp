/************************************************************************/
/*   Archivo:                sp_recla_terceros                          */
/*   Stored Procedure:       cb_recla_terceros.sp                       */
/*   Producto:               Contabilidad                               */
/************************************************************************/
/*                            IMPORTANTE                                */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   "COBISCORP S.A".                                                   */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de COBISCORP S.A o su representante.         */
/************************************************************************/
/*                            PROPOSITO                                 */
/*   Genera los asientos y comprobante contables cuando se presentan    */
/*   inconsistecias en la reclasificacion de terceros                   */
/************************************************************************/
/*                           MODIFICACION                               */
/*    FECHA               AUTOR             RAZÓN                       */
/*  02-Mar-2013           Oscar Saavedra    Emision Inicial             */
/*  16-Sep-2013           Ricardo Reyes     Terceros Seguros y Alianzas */
/*  25-Feb-2014           Edwin Jimenez     Terceros Seguros por fechas */
/************************************************************************/

use cob_conta
go

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

if exists (select 1 from sysobjects where name = 'sp_recla_terceros')
   drop proc sp_recla_terceros
go

create proc sp_recla_terceros
@i_param1        int,        --> Empresa
@i_param2        int,        --> Proceso
@i_param3        datetime,   --> Fecha contabilizacion
@i_param4        datetime    --> Fecha Proceso
as

declare
@w_fecha         datetime,
@w_corte         smallint,
@w_periodo       smallint,
@w_oficina       smallint,
@w_area          smallint,
@w_detalles      int,
@w_saldo         money,
@w_saldo_me      money,
@w_comprobante   int,
@w_error         int,
@w_ente_ms       int,
@w_cuenta        varchar(30),
@w_ced_ruc       varchar(30),
@w_fecha_proc    datetime,
@w_fecha_cont    datetime

select @w_error = 0

select 
@w_fecha = co_fecha_ini
from  cob_conta..cb_corte
where co_estado = 'A'

select
@w_fecha_proc = isnull(convert(datetime,@i_param4),fp_fecha),
@w_fecha_cont = convert(datetime,@i_param3)
from cobis..ba_fecha_proceso       

if @w_fecha_proc <> @w_fecha 
   select @w_fecha = @w_fecha_proc

select @w_fecha = dateadd(dd, -1, dateadd(dd, -1*datepart(dd, dateadd(mm, 1, @w_fecha)-1), dateadd(mm, 1, @w_fecha)))

-------------------------------------------------
-- Tabla para leer cuenta - proceso - por cliente
-------------------------------------------------

select ced_ruc=cp_texto, cuenta=cp_cuenta, estado='I'
into #ente_cuenta
from cob_conta..cb_cuenta_proceso
where cp_proceso = @i_param2

while 1 = 1 begin

   select top 1 
   @w_cuenta  = cuenta,
   @w_ente_ms = en_ente,
   @w_ced_ruc = en_ced_ruc
   from #ente_cuenta, cobis..cl_ente
   where ced_ruc = en_ced_ruc
   and   estado = 'I'

   if @@rowcount = 0 break

   select 
   @w_corte   = co_corte,
   @w_periodo = co_periodo
   from  cob_conta..cb_corte
   where co_fecha_ini = @w_fecha

   -------------------------------------------------
   -- Tabla para leer oficinas - area
   -------------------------------------------------
   
   select distinct st_oficina, st_area
   into #oficinas
   from  cob_conta_tercero..ct_saldo_tercero
   where st_corte   = @w_corte
   and   st_periodo = @w_periodo
   and   st_cuenta  = @w_cuenta 
   and   st_saldo  <> 0
   and   st_ente   <> @w_ente_ms

   select @w_comprobante = 0

   exec cob_interface..sp_errorcconta
   @t_trn         = 60025,
   @i_operacion   = 'D',
   @i_empresa     = 1,
   @i_fecha       = @w_fecha,
   @i_producto    = 6

   while 1 = 1 begin

      select @w_comprobante = @w_comprobante + 1
   
      exec @w_error = cob_conta..sp_cseqcomp
      @i_tabla     = 'cb_scomprobante', 
      @i_empresa   = @i_param1,
      @i_fecha     = @w_fecha_cont,
      @i_modulo    = 6,
      @i_modo      = 0, -- Numera por EMPRESA-FECHA-PRODUCTO
      @o_siguiente = @w_comprobante out
      if @w_error <> 0 begin
         print ' ERROR AL GENERAR NUMERO COMPROBANTE ' 
         goto siguiente
      end
     
      select top 1 
      @w_oficina  = st_oficina, 
      @w_area     = st_area
      from #oficinas
      if @@rowcount = 0 break

      delete #oficinas
      where st_oficina = @w_oficina
      and   st_area    = @w_area
   
      select 
      @w_detalles = count(1), 
      @w_saldo    = abs(sum(abs(st_saldo))),
      @w_saldo_me = abs(sum(abs(st_saldo_me)))
      from cob_conta_tercero..ct_saldo_tercero
      where st_corte   = @w_corte
      and   st_periodo = @w_periodo
      and   st_cuenta  = @w_cuenta 
      and   st_saldo  <> 0
      and   st_oficina = @w_oficina
      and   st_area    = @w_area
      and   st_ente    <> @w_ente_ms

      begin tran
   
      insert into cob_conta_tercero..ct_sasiento_tmp with (rowlock) (                                                                                                                                              
      sa_producto,        sa_fecha_tran,        sa_comprobante,
      sa_empresa,         sa_asiento,           sa_cuenta,
      sa_oficina_dest,    sa_area_dest,         sa_credito,
      sa_debito,          sa_concepto,          sa_credito_me,
      sa_debito_me,       sa_cotizacion,        sa_tipo_doc,
      sa_tipo_tran,       sa_moneda,            sa_opcion,
      sa_ente,            sa_con_rete,          sa_base,
      sa_valret,          sa_con_iva,           sa_valor_iva,
      sa_iva_retenido,    sa_con_ica,           sa_valor_ica,
      sa_con_timbre,      sa_valor_timbre,      sa_con_iva_reten,
      sa_con_ivapagado,   sa_valor_ivapagado,   sa_documento,
      sa_mayorizado,      sa_con_dptales,       sa_valor_dptales,
      sa_posicion,        sa_debcred,           sa_oper_banco,
      sa_cheque,          sa_doc_banco,         sa_fecha_est, 
      sa_detalle,         sa_error )
      select
      6,                  @w_fecha_cont,        @w_comprobante,
      @i_param1,          row_number() over(order by st_ente)+@w_detalles , st_cuenta,
      st_oficina,         st_area,              case when st_saldo > 0 then st_saldo else 0 end,
      case when st_saldo < 0 then abs(st_saldo) else 0 end,'COMPROBANTE RECLASIFICACION CUENTA ' + @w_cuenta + ' ORS_000572', case when st_saldo_me > 0 then st_saldo_me else 0 end,
      case when st_saldo_me < 0 then abs(st_saldo_me) else 0 end, 1, 'N',
      'A',                 0,                   0,
      st_ente,            null,                 null,
      null,               null,                 null,
      null,               null,                 null,
      null,               null,                 null,
      null,               null,                 null,
      'N',                null,                 null,
      'N',                case when st_saldo > 0 then '2' else '1' end,        null,
      null,               null,                 null,
      null,               'N' 
      from cob_conta_tercero..ct_saldo_tercero
      where st_corte   = @w_corte
      and   st_periodo = @w_periodo
      and   st_cuenta  = @w_cuenta 
      and   st_saldo   <> 0
      and   st_oficina = @w_oficina
      and   st_area    = @w_area
      and   st_ente    <> @w_ente_ms
      if @@error <> 0 begin
         print 'ERROR AL INSERTAR ASIENTO, OFICINA: ' + convert(varchar(10), @w_oficina)
         rollback tran
         goto siguiente
      end
   
      insert into cob_conta_tercero..ct_sasiento_tmp with (rowlock) (                                                                                                                                              
      sa_producto,        sa_fecha_tran,        sa_comprobante,
      sa_empresa,         sa_asiento,           sa_cuenta,
      sa_oficina_dest,    sa_area_dest,         sa_credito,
      sa_debito,          sa_concepto,          sa_credito_me,
      sa_debito_me,       sa_cotizacion,        sa_tipo_doc,
      sa_tipo_tran,       sa_moneda,            sa_opcion,
      sa_ente,            sa_con_rete,          sa_base,
      sa_valret,          sa_con_iva,           sa_valor_iva,
      sa_iva_retenido,    sa_con_ica,           sa_valor_ica,
      sa_con_timbre,      sa_valor_timbre,      sa_con_iva_reten,
      sa_con_ivapagado,   sa_valor_ivapagado,   sa_documento,
      sa_mayorizado,      sa_con_dptales,       sa_valor_dptales,
      sa_posicion,        sa_debcred,           sa_oper_banco,
      sa_cheque,          sa_doc_banco,         sa_fecha_est, 
      sa_detalle,         sa_error )
      select
      6,                  @w_fecha_cont,        @w_comprobante,
      @i_param1,          row_number() over(order by st_ente), st_cuenta,
      st_oficina,         st_area,              case when st_saldo > 0 then 0 else abs(st_saldo) end,
      case when st_saldo < 0 then 0 else abs(st_saldo) end,'COMPROBANTE RECLASIFICACION CUENTA ' + @w_cuenta + ' ORS_000572', case when st_saldo_me > 0 then 0 else st_saldo_me end,
      case when st_saldo_me < 0 then 0 else abs(st_saldo_me) end, 1, 'N',
      'A',                0,                    0,
      @w_ente_ms,         null,                 null,
      null,               null,                 null,
      null,               null,                 null,
      null,               null,                 null,
      null,               null,                 null,
      'N',                null,                 null,
      'N',                case when st_saldo > 0 then '1' else '2' end,        null,
      null,               null,                 null,
      null,               'N' 
      from cob_conta_tercero..ct_saldo_tercero
      where st_corte   = @w_corte
      and   st_periodo = @w_periodo
      and   st_cuenta  = @w_cuenta 
      and   st_saldo   <> 0
      and   st_oficina = @w_oficina
      and   st_area    = @w_area
      and   st_ente    <> @w_ente_ms

      if @@error <> 0 begin
         print 'ERROR AL INSERTAR ASIENTO, OFICINA: ' + convert(varchar(10), @w_oficina)
         rollback tran
         goto siguiente
      end  
   
      select @w_detalles = @w_detalles * 2
   
      insert into cob_conta_tercero..ct_scomprobante_tmp(
      sc_producto,      sc_comprobante,   sc_empresa,
      sc_fecha_tran,    sc_oficina_orig,  sc_area_orig,
      sc_fecha_gra,     sc_digitador,     sc_descripcion,
      sc_perfil,        sc_detalles,      sc_tot_debito,
      sc_tot_credito,   sc_tot_debito_me, sc_tot_credito_me,
      sc_automatico,    sc_reversado,     sc_estado,
      sc_mayorizado,    sc_observaciones, sc_comp_definit,
      sc_usuario_modulo,sc_causa_error,   sc_comp_origen,
      sc_tran_modulo,   sc_error )
      values(
      6,                @w_comprobante,   @i_param1,
      @w_fecha_cont,    @w_oficina,       @w_area,
      getdate(),        'conta_batch',    'COMPROBANTE RECLASIFICACION CUENTA ' + @w_cuenta + ' ORS_000572',
      'REC_109750',     @w_detalles,      @w_saldo,
      @w_saldo,         @w_saldo_me,      @w_saldo_me,
      6,                'N',              'I',
      'N',              NULL,             NULL,
      'sa',             NULL,             @w_comprobante,
      @w_comprobante,   'N')
      if @@error <> 0 begin
         print 'ERROR AL INSERTAR COMPROBANTE, OFICINA: ' + convert(varchar(10), @w_oficina)
         rollback tran
         goto siguiente
      end 
      commit tran
      siguiente:

   end -- While #oficinas

   update #ente_cuenta
   set estado = 'P'
   where ced_ruc = @w_ced_ruc 
   and   cuenta  = @w_cuenta  
   
   drop table #oficinas
   
end -- While #ente_cuenta

return 0
go
