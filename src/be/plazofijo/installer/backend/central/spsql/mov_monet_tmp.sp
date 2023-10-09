/************************************************************************/
/*      Archivo:                movmotmp.sp                             */
/*      Stored procedure:       sp_mov_monet_tmp                        */
/*      Base de datos:          cob_pfijo                               */
/*      Producto:               Plazo Fijo                              */
/*      Disenado por:           Myriam Davila / Juan Jose Lam           */
/*      Fecha de documentacion: 18-Nov-1994                             */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      'MACOSA', representantes exclusivos para el Ecuador de la       */
/*      'NCR CORPORATION'.                                              */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/*                              PROPOSITO                               */
/*      Este programa procesa las transacciones de INSERT y DELETE a    */
/*      la tabla temporal de movimientos monetarios 'pf_mov_monet_tmp'. */
/*                                                                      */
/*                              MODIFICACIONES                          */
/*      FECHA      AUTOR              RAZON                             */
/*      19-Nov-94  Ricardo Valencia   Creacion                          */
/*      18-Ago-95  Carolina Alvarado  Insercion (campos de tabla)       */
/*                Validacion de productos           */
/*      21-Dic-98  Dolores Guerrero   Se guarda campo de impuesto capit.*/
/*                 Gabriela Estupinan me                                */
/*      03-May-2005 N. Silva          Correcciones e Identacion general */
/*      08-Oct-2005 Luis Im           Guardar oficina destino y         */
/*                                    beneficiario externo              */
/*      18-Nov-2005 Luis Im           Guardar cod. banco ach            */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'sp_mov_monet_tmp')
   drop proc sp_mov_monet_tmp
go

create proc sp_mov_monet_tmp (
      @s_ssn                  int             = NULL,
      @s_user                 login           = NULL,
      @s_sesn                 int             = NULL,
      @s_term                 varchar(30)     = NULL,
      @s_date                 datetime        = NULL,
      @s_srv                  varchar(30)     = NULL,
      @s_lsrv                 varchar(30)     = NULL,
      @s_ofi                  smallint        = NULL,
      @s_rol                  smallint        = NULL,
      @t_debug                char(1)         = 'N',
      @t_file                 varchar(10)     = NULL,
      @t_from                 varchar(32)     = NULL,
      @t_trn                  smallint        = NULL,

      @i_operacion            char(1),
      @i_num_banco            cuenta          = NULL,
      @i_beneficiario         int             = NULL,
      @i_moneda               int             = NULL,
      @i_sub_secuencia        tinyint         = NULL,
      @i_tipo                 char(1)         = NULL,
      @i_producto             catalogo        = NULL,
      @i_cuenta               cuenta          = NULL,
      @i_valor                money           = NULL, 
      @i_val_renta            money           = 0,    --NYM DPF00015 ICA
      @i_valor_ext            money           = NULL,
      @i_impuesto_capital_me  money           = 0,
      @i_cotizacion           money           = 0,
      @i_tipo_cotiza          char(1)         = 'N',
      @i_empresa              tinyint         = 1,
      @i_tipo_cliente         char(1)         = 'M',
      @i_autorizado           char(1)         = 'N',
      @i_ttransito            smallint        = NULL, --gap DP00008
      @i_fecha_valor          datetime        = NULL,
      @i_cta_corresp          cuenta          = NULL,
      @i_cod_corresp          catalogo        = NULL,
      @i_benef_corresp        varchar(245)    = NULL,
      @i_ofic_corresp         int             = NULL,
      @i_transaccion          int             = NULL,
      @i_secuencia            int             = NULL,
      @i_secuencial           int             = NULL,
      @i_revordpago           char(1)         = 'N',
      @i_op_operacion         int             = NULL,
      @i_tr_sec_mov           int             = NULL,  -- GAR para atar con transferencia
      @i_sec_emicheq          int             = NULL,
      @i_estado               char(1)         = NULL,
      @i_num_cheque           int             = NULL,
      @i_tipo_cuenta_ach      char(1)         = NULL,
      @i_banco_ach            smallint        = NULL,  -- LIM 19/NOV/2005
      @i_beneficiario_ext     varchar(245)    = NULL,  -- LIM 08/OCT/2005
      @i_oficina_dest         int             = NULL,  -- LIM 08/OCT/2005
      @i_secuencial_ext       int             = NULL,  -- LIM 18/NOV/2005
      @i_tipo_pago            catalogo        = NULL,
      @i_val_ica              money           = 0,     -- NYM DPF00015 ICA
      @i_subtipo              int             = NULL,  -- GAL 08/SEP/2009 - INTERFAZ - CHQCOM
      @i_secuencial_lote      int             = NULL   -- GAL 08/SEP/2009 - INTERFAZ - CHQCOM
)   
with encryption
as
declare
      @w_sp_name                      varchar(32),
      @w_impuesto                     money,
      @w_operacionpf                  int,
      @w_valor_ext                    money,         
      @w_valor                        money,         
      @w_cotizacion_conta             money,         
      @w_cotizacion_venta_billete     money, 
      @w_cotizacion_compra_billete    money, 
      @w_cotizacion                   money,         
      @w_tipo_cotiza                  char(1),       
      @w_moneda_base                  tinyint,
      @w_cod_clte                     int,        --LIM 08/OCT/2005 
      @w_return                       int         --LIM 08/OCT/2005    

select @w_sp_name = 'sp_mov_monet_tmp'

/*----------------------------------------------*/
/** Verificacion de Transaccion para Insercion **/
/*----------------------------------------------*/
if ( @i_operacion <> 'I' or  @t_trn <> 14127 ) and
   ( @i_operacion <> 'D' or  @t_trn <> 14327 )
begin
   exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 141040
   return 1
end

select @w_moneda_base = em_moneda_base
  from cob_conta..cb_empresa
 where em_empresa = @i_empresa

if @@rowcount = 0
begin
   exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name, 
        @i_num   = 601018
   return  1
end      

----------------------------
-- Fusion y Fraccionamiento
----------------------------
if @i_revordpago = 'N'
begin
    select @w_operacionpf = ot_operacion
    from pf_operacion_tmp
    where ot_num_banco = @i_num_banco 
      and ot_usuario = @s_user 
      and ot_sesion = @s_sesn
               
    if @@rowcount = 0
    begin
        select @w_operacionpf = op_operacion
        from pf_operacion
        where op_num_banco = @i_num_banco
       
        if @@rowcount = 0
        begin
           exec cobis..sp_cerror
                @t_debug = @t_debug,
                @t_file  = @t_file,
                @t_from  = @w_sp_name,
                @i_num   = 141051
           return 1
        end
    end
end
else
   select @w_operacionpf = @i_op_operacion

           
---------------------------------------------------------      
-- Insercion de movimientos monetarios en tabla temporal
---------------------------------------------------------
If @i_operacion = 'I'
begin
   select @w_impuesto = @i_val_renta

   ----------------------------
   -- Verificacion del producto
   ----------------------------
   if @i_producto not in('CFUS','IFUS', 'CFRA','IFRA','CEND','IEND', 'RFUS','RFRA') --fusfra 05/11/2000 KTA GB-GAPDP00049, GB-GAPDP00051
   begin
      if not exists (select 1 from pf_fpago
                      where fp_mnemonico = @i_producto
                        and fp_estado = 'A')
      begin
         exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 141062
         return 1
      end  
   end

   begin tran
      -------------------------------------------------------------------
      -- Calculo del valor en moneda nacional de acuerdo a la cotizacion
      -------------------------------------------------------------------
      if @i_moneda <> @w_moneda_base
      begin
         if @i_valor = @i_valor_ext
         begin
            set rowcount 1
            select @w_cotizacion_compra_billete = co_compra_billete ,
                   @w_cotizacion_venta_billete  = co_venta_billete,
                   @w_cotizacion_conta          = co_conta
              from cob_pfijo..pf_cotizacion
             where co_moneda = @i_moneda
               and co_fecha = (select max(co_fecha)
                                 from cob_pfijo..pf_cotizacion
                                where co_moneda = @i_moneda)
            set rowcount 0
         
            if @i_cotizacion = 0       
               select @w_cotizacion = @w_cotizacion_conta
            else
               select @w_cotizacion = isnull(@i_cotizacion, @w_cotizacion_conta)
                 
            select @w_valor       = @i_valor_ext * @w_cotizacion,
                   @w_valor_ext   = @i_valor,
                   @w_cotizacion  = @w_cotizacion,
                   @w_tipo_cotiza = 'V'
         end
         else
            select @w_valor       = @i_valor,
                   @w_valor_ext   = @i_valor_ext,
                   @w_cotizacion  = @i_cotizacion,
                   @w_tipo_cotiza = @i_tipo_cotiza -- Se aumenta cotiz y tipo

      end
      else
      begin
         select @w_valor_ext = 0,
                @w_valor = @i_valor
      end

    if ((@i_secuencial_ext is not null) and @i_tipo_cliente = 'E')
    begin   
      set rowcount 1
      --CVA Ene-13-06 inclusion de i_tipo_pago para vueltos
      if @i_tipo_pago is not null
      begin
         select @w_cod_clte = dt_beneficiario 
          from pf_det_pago_tmp
         where dt_operacion  = @w_operacionpf
           and dt_usuario    = @s_user
              and dt_sesion     = @s_sesn
              and dt_secuencia  = @i_secuencia
           and dt_tipo       = @i_tipo_pago

      end
      else     
         select @w_cod_clte = dt_beneficiario 
          from pf_det_pago_tmp
         where dt_operacion = @w_operacionpf
           and dt_usuario   = @s_user
              and dt_sesion    = @s_sesn
             and dt_secuencia  = @i_secuencia
           
            set rowcount 0

           select @i_beneficiario = @w_cod_clte

      delete   pf_cliente_externo_tmp
          where   ct_secuencial = @i_secuencial_ext
           and ct_usuario    = @s_user 
           and ct_sesion     = @s_sesn
      

    end

      insert pf_mov_monet_tmp
                (mt_usuario         , mt_sesion         , mt_operacion                  , mt_sub_secuencia,
                 mt_producto        , mt_cuenta         , mt_valor                      , mt_beneficiario,
                 mt_impuesto        , mt_moneda         , mt_valor_ext                  , mt_tipo,    
                 mt_fecha_crea      , mt_fecha_mod      , mt_impuesto_capital_me        , mt_tipo_cliente,
                 mt_autorizado      , mt_cotizacion     , mt_tipo_cotiza                , mt_ttransito, 
                 mt_fecha_valor     , mt_cta_corresp    , mt_cod_corresp                , mt_benef_corresp,
                 mt_ofic_corresp    , mt_tran           , mt_secuencia                  , mt_secuencial,
                 mt_sec_mov         , mt_estado         , mt_sec_emis_cheq              , mt_num_cheque,                
                 mt_tipo_cuenta_ach , mt_cod_banco_ach  , mt_oficina                    , mt_ica,             -- LIM 19/NOV/2005
                 mt_subtipo_ins     , mt_secuencial_lote)                                           -- GAL 08/SEP/2009 - INTERFAZ - CHQCOM
         values (@s_user            , @s_sesn           , @w_operacionpf                , @i_sub_secuencia,
                 @i_producto        , @i_cuenta         , @w_valor                      , @i_beneficiario,
                 @w_impuesto        , @i_moneda         , @w_valor_ext                  , @i_tipo,
                 @s_date            , @s_date           , @i_impuesto_capital_me        , @i_tipo_cliente,
                 @i_autorizado      , @i_cotizacion     , @i_tipo_cotiza                , @i_ttransito,
                 @i_fecha_valor     , @i_cta_corresp    , @i_cod_corresp                , @i_benef_corresp,
                 @i_ofic_corresp    , @i_transaccion    , @i_secuencia                  , @i_secuencial,
                 @i_tr_sec_mov      , @i_estado         , @i_sec_emicheq                , @i_num_cheque,
                 @i_tipo_cuenta_ach , @i_banco_ach      , isnull(@i_oficina_dest,@s_ofi), @i_val_ica,   -- LIM 08/OCT/2005
                 @i_subtipo         , @i_secuencial_lote)                                            -- GAL 08/SEP/2009 - INTERFAZ - CHQCOM
                                  
      if @@error <> 0
      begin
         exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 143022
         return 1
      end

   commit tran
   return 0
end

-----------------------------------------
-- Eliminacion de movimientos monetarios
-----------------------------------------
If @i_operacion = 'D'
begin
   begin tran
      delete from pf_mov_monet_tmp
       where mt_usuario   = @s_user
         and mt_sesion    = @s_sesn
    and mt_operacion = @w_operacionpf

   if @@error <> 0
   begin
      exec cobis..sp_cerror
           @t_debug = @t_debug,
           @t_file  = @t_file,
           @t_from  = @w_sp_name,
           @i_num   = 147022
      return 1
   end

  commit tran
  return 0
end 
go

