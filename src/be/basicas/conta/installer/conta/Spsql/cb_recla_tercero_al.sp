/************************************************************************/
/*   Archivo:                sp_recla_tercero_al                        */
/*   Stored Procedure:       cb_recla_tercero_al.sp                     */
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
/*   inconsistecias en la reclasificacion de terceros de desmebolsos    */
/*   de alianzas.                                                       */
/************************************************************************/
/*                           MODIFICACION                               */
/*    FECHA               AUTOR             RAZÓN                       */
/*  31-Oct-2013     Jorge Tellez C        Emision Inicial               */
/************************************************************************/
use cob_conta
go

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

if exists (select 1 from sysobjects where name = 'sp_recla_terceros_al')
   drop proc sp_recla_terceros_al
go

create proc sp_recla_terceros_al
@i_param1        int,            --> Empresa 1
@i_param2        int,            --> Proceso 6156
@i_param3        datetime        --> fecha de ingreso , para procesar a una fecha determinada 
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
@w_saldo_deb     money,
@w_saldo_cre     money,
@w_valor_db_cr   money,
@w_comprobante   int,
@w_error         int,
@w_cuenta        varchar(30),
@w_perfil        varchar(100),
@w_producto       varchar(4)

select @w_error = 0

--select @w_fecha = co_fecha_ini from cob_conta..cb_corte where co_estado = 'A'
select @w_fecha = @i_param3

-------------------------------------------------
-- Tabla para leer cuenta - proceso - por cliente
-------------------------------------------------
select 
@w_cuenta   = cp_cuenta,     -- '19900500005'
@w_perfil   = cp_texto,      -- 'DES_ACT'
@w_producto = cp_condicion   -- (cartera '7')
from cob_conta..cb_cuenta_proceso
where cp_proceso = @i_param2  -- 6156

-- select 
--@w_cuenta   = '19900500005',
--@w_perfil   = 'DES_ACT',
--@w_producto = '7'

select @w_comprobante = 0

select distinct *
into #universo
from cob_conta_tercero..ct_scomprobante,
     cob_conta_tercero..ct_sasiento
where sc_comprobante = sa_comprobante
and   sc_fecha_tran  = sa_fecha_tran
and   sc_producto    = sa_producto
and   sc_empresa     = sa_empresa
and   sc_estado      = 'P'
and   sc_fecha_tran  = @i_param3    -- Fecha de la cual se ajustara
and   sc_perfil      = @w_perfil    -- Toma el perfil DES_ACT
and   sc_producto    = @w_producto  -- Toma el producot de cartera '7'
and   sa_cuenta      = @w_cuenta    -- 19049500934 cuenta de desembolso a NCAH
and   sa_doc_banco   is not null    -- Este campo es el codigo de ente relacionado a la alianza 
and   sa_doc_banco   in ( select convert( varchar(20), al_ente) 
                         from cobis..cl_alianza, cobis..cl_ente
                         where al_ente = en_ente                   )

delete #universo
from cob_conta_super..ct_scomprob_tmp_al_his
where sc_fecha_tran  = st_fecha_tran
and   sc_producto    = st_producto
and   sc_comprobante = st_comprobante
and   sc_empresa     = st_empresa
and   sa_area_dest   = st_area_dest

select distinct sa_oficina_dest oficina, sa_area_dest area
into #oficinas 
from #universo

while 1 = 1 begin

   --select @w_comprobante = @w_comprobante + 1
   select top 1 @w_oficina = oficina, @w_area = area from #oficinas
   if @@rowcount = 0 break

   exec @w_error = cob_conta..sp_cseqcomp
   @i_tabla     = 'cb_scomprobante', 
   @i_empresa   = @i_param1,
   @i_fecha     = @w_fecha,
   @i_modulo    = 6, 
   @i_modo      = 0, 
   @o_siguiente = @w_comprobante out
      
   if @w_error <> 0 begin
      print ' ERROR AL GENERAR NUMERO COMPROBANTE.. ' 
      goto siguiente
   end

   insert into cob_conta_super..ct_scomprob_tmp_al_his 
       ( st_fecha_tran,    st_producto,     st_comprobante,    st_empresa, st_oficina, st_area_dest, st_fecha_ing )
   select distinct sc_fecha_tran, sc_producto, sc_comprobante, sc_empresa, @w_oficina, @w_area,      getdate()  
   from #universo
   where sa_oficina_dest = @w_oficina
   and   sa_area_dest    = @w_area
   
   if @@error <> 0 begin
      print 'ERROR AL INSERTAR EN HIS, OFICINA: ' + convert(varchar(10), @w_oficina)
      rollback tran
      goto siguiente
   end 

   delete #oficinas where oficina = @w_oficina and area = @w_area
 
   select  @w_detalles  = count(1), 
           @w_saldo_deb = abs(sum(abs(sa_debito))),--debitos 
           @w_saldo_cre = abs(sum(abs(sa_credito))),--creditos
           @w_saldo_me  = abs(sum(abs(sa_credito_me)))
   from #universo
   where sa_oficina_dest = @w_oficina
   and   sa_area_dest    = @w_area

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
   select distinct 
   6,                  @w_fecha,             @w_comprobante,
   sa_empresa,         row_number() over(order by sa_ente),    sa_cuenta,
   sa_oficina_dest,    sa_area_dest,         sa_debito,
   sa_credito,         sa_concepto+ '. RECLA_AL.' ,          sa_credito_me,
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
   sa_detalle,         sa_error
   from #universo
   where sa_oficina_dest = @w_oficina
   and   sa_area_dest    = @w_area

   if @@error <> 0 begin
      print 'ERROR AL INSERTAR ASIENTO1, OFICINA: ' + convert(varchar(10), @w_oficina)
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
   6,                  @w_fecha,             @w_comprobante,
   sa_empresa,         row_number() over(order by sa_ente)+@w_detalles,     sa_cuenta,
   sa_oficina_dest,    sa_area_dest,         sa_credito,
   sa_debito,          sa_concepto+ '. RECLA_AL.',          sa_credito_me,
   sa_debito_me,       sa_cotizacion,        sa_tipo_doc,
   sa_tipo_tran,       sa_moneda,            sa_opcion,
   sa_doc_banco,       sa_con_rete,          sa_base,
   sa_valret,          sa_con_iva,           sa_valor_iva,
   sa_iva_retenido,    sa_con_ica,           sa_valor_ica,
   sa_con_timbre,      sa_valor_timbre,      sa_con_iva_reten,
   sa_con_ivapagado,   sa_valor_ivapagado,   sa_documento,
   sa_mayorizado,      sa_con_dptales,       sa_valor_dptales,
   sa_posicion,        sa_debcred,           sa_oper_banco,
   sa_cheque,          sa_ente,              sa_fecha_est, 
   sa_detalle,         sa_error
   from #universo
   where sa_oficina_dest = @w_oficina
   and   sa_area_dest    = @w_area
   
   if @@error <> 0 begin
      print 'ERROR AL INSERTAR ASIENTO2, OFICINA: ' + convert(varchar(10), @w_oficina)
      rollback tran
      goto siguiente
   end
   select @w_detalles = @w_detalles * 2

   --Obtiene el valor del comprobante
   select w_valor_db_cr = 0

   if @w_saldo_cre > 0
      select @w_valor_db_cr = @w_saldo_cre

   if @w_saldo_deb > 0
      select @w_valor_db_cr = @w_saldo_deb

   --select  @w_comprobante, @w_detalles , @w_saldo, @w_saldo_me, @w_area, @w_saldo_deb, @w_saldo_cre
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
   @w_fecha,         @w_oficina,       @w_area,   
   getdate(),        'conta_batch',    'COMPROBANTE RECLASIFICACION DES-ALIANZA ' + @w_cuenta + ' CCA_000353',
   'DESC_ALT_A',     @w_detalles,      @w_valor_db_cr,   
   @w_valor_db_cr,   @w_saldo_me,      @w_saldo_me,
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

return 0
go
