/************************************************************************/
/*  Archivo               :  copia_tipodepo.sp                          */
/*  Stored procedure      :  sp_copia_tipodepo                          */
/*  Base de datos         :  cob_pfijo                                  */
/*  Producto              :  Plazo_fijo                                 */
/*  Disenado por          :  N. Silva                                   */
/*  Fecha de documentacion:  17-Mar-2015                                */
/************************************************************************/
/*                          IMPORTANTE                                  */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  'MACOSA', representantes exclusivos para el Ecuador de la           */
/*  'NCR CORPORATION'.                                                  */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier alteracion o agregado hecho por alguno de sus             */
/*  usuarios sin el debido consentimiento por escrito de la             */
/*  Presidencia Ejecutiva de MACOSA o su representante.                 */
/************************************************************************/
/*                          PROPOSITO                                   */
/*  Copia la parametrizacion de un tipo de deposito creando uno nuevo   */
/************************************************************************/
/*                          MODIFICACIONES                              */
/*  FECHA        AUTOR                RAZON                             */
/*  17-Mar-2015  N. Silva             Emision Inicial                   */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'sp_copia_tipodepo')
   drop proc sp_copia_tipodepo
go

create proc sp_copia_tipodepo (
       @s_ssn                  int          = null,
       @s_user                 login        = null,
       @s_term                 varchar(30)  = null,
       @s_date                 datetime     = null,
       @s_srv                  varchar(30)  = null,
       @s_lsrv                 varchar(30)  = null,                                       
       @s_ofi                  smallint     = null,
       @s_rol                  smallint     = null,
       @t_debug                char(1)      = 'N',
       @t_file                 varchar(10)  = null,
       @t_from                 varchar(32)  = null,
       @t_trn                  smallint     = null,
       @i_tipo_deposito        tinyint      = null,  --tipo deposito a copiar
       @i_mnemonico            varchar(5)   = null,  --nuevo mnemonico
       @i_descripcion          varchar(30)  = null   --nueva descripcion
)
with encryption
as
declare @w_sp_name              varchar(32),
        @w_return               int,
        @w_error                int,
        @w_td_mnemonico         varchar(5),
        @w_td_tasa_variable     char(1),
        @w_tipo_deposito        int
          
select @w_sp_name       = 'sp_copia_tipodepo',
       @w_error         = 0

if @t_trn <> 14134 
begin
   exec cobis..sp_cerror
        @t_debug     = @t_debug,
        @t_file      = @t_file,
        @t_from      = @w_sp_name,
        @i_num       = 141112
   return 1
end

-------------------------------------
-- Obtener datos de Tipo de Deposito
-------------------------------------
select @w_td_mnemonico     = td_mnemonico,
       @w_td_tasa_variable = td_tasa_variable
from pf_tipo_deposito
where td_tipo_deposito = @i_tipo_deposito
 
if @@rowcount = 0
begin
   exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 141115
   return 141115
end


if exists (select td_mnemonico from pf_tipo_deposito
           where td_mnemonico = @i_mnemonico)
begin
      exec cobis..sp_cerror
           @t_debug = @t_debug,
           @t_file  = @t_file,
           @t_from  = @w_sp_name,
           @i_num   = 141116
      return 141116
end

exec @w_return = cobis..sp_cseqnos   
     @t_debug     = @t_debug,
     @t_file      = @t_file,
     @t_from      = @w_sp_name,
     @i_tabla     = 'pf_tipo_deposito',
     @o_siguiente = @w_tipo_deposito out

if @w_return <> 0
   return @w_return
   
begin tran

   insert into pf_tipo_deposito (
          td_tipo_deposito,      td_mnemonico,         td_descripcion,
          td_forma_pago,         td_capitalizacion,    td_dias_reverso,
          td_base_calculo,       td_fecha_crea,        td_fecha_mod,
          td_estado,             td_mantiene_stock,    td_stock,
          td_emision_inicial,    td_prorroga_aut,      td_dias_gracia,
          td_num_dias_gracia,    td_num_prorrogas,     td_anio_comercial,
          td_tasa_variable,      td_tasa_efectiva,     td_retiene_impto,
          td_tran_sabado,        td_paga_comision,     td_cupon,
          td_cambio_tasa,        td_incr_decr,         td_area_contable,
          td_tipo_persona,       td_dias_reales,       td_tipo_tasa_var,          
          td_tipo_banca,         td_periodo_tasa,      td_tasa_precancela,
          td_encaje_legal)
   select @w_tipo_deposito,      @i_mnemonico,         @i_descripcion,
          td_forma_pago,         td_capitalizacion,    td_dias_reverso,
          td_base_calculo,       td_fecha_crea,        td_fecha_mod,
          'A',                   td_mantiene_stock,    td_stock,
          td_emision_inicial,    td_prorroga_aut,      td_dias_gracia,
          td_num_dias_gracia,    td_num_prorrogas,     td_anio_comercial,
          td_tasa_variable,      td_tasa_efectiva,     td_retiene_impto,
          td_tran_sabado,        td_paga_comision,     td_cupon,
          td_cambio_tasa,        td_incr_decr,         td_area_contable,
          td_tipo_persona,       td_dias_reales,       td_tipo_tasa_var, 
          td_tipo_banca,         td_periodo_tasa,      td_tasa_precancela,
          td_encaje_legal
   from cob_pfijo..pf_tipo_deposito
   where td_tipo_deposito = @i_tipo_deposito

   if @@error <> 0
   begin
      select @w_error = 143034
      goto ERROR
   end
   
   ----------------------------------------------------
   -- Inserta rangos de plazo, monto, moneda, categoria
   ----------------------------------------------------
   insert into pf_auxiliar_tip (
          at_tipo_deposito, at_moneda,     at_tipo,     at_valor,
          at_estado,        at_fecha_crea, at_fecha_elim)
   select @w_tipo_deposito, at_moneda,     at_tipo,     at_valor,
          'A',              @s_date,       @s_date     
   from cob_pfijo..pf_auxiliar_tip
   where at_tipo_deposito = @i_tipo_deposito   
     and at_estado        = 'A' 

   if @@error <> 0
   begin
      select @w_error = 143036
      goto ERROR
   end
   
   -------------------------
   -- Insercion de limites
   -------------------------
   insert into pf_limite (
          li_secuencial, li_tipo_deposito, li_moneda    , li_tipo_reg, 
          li_valor     , li_limite_max   , li_limite_min, li_usa_limites,
          li_fecha_crea, li_fecha_elim )
   select li_secuencial, @w_tipo_deposito, li_moneda    , li_tipo_reg, 
          li_valor     , li_limite_max   , li_limite_min, li_usa_limites,
          @s_date      , @s_date
     from cob_pfijo..pf_limite
    where li_tipo_deposito = @i_tipo_deposito
    
   if @@error <> 0
   begin
      select @w_error = 143005
      goto ERROR
   end
   
   -------------------------------------------
   -- Asociacion de Tasas al Tipo de Deposito
   -------------------------------------------
   if isnull(@w_td_tasa_variable,'N') = 'N'
   begin
      insert into pf_tasa (
             ta_tipo_deposito, ta_moneda,   ta_tipo_monto, ta_tipo_plazo,
             ta_tasa_min,      ta_tasa_max, ta_vigente,    ta_fecha_crea,
             ta_fecha_mod,     ta_tasa_mer, ta_usuario,    ta_tipo,
             ta_tipo_pago)
      select @i_mnemonico,     ta_moneda  , ta_tipo_monto, ta_tipo_plazo,
             ta_tasa_min,      ta_tasa_max, ta_vigente,    @s_date,
             @s_date,          ta_tasa_mer, @s_user,       ta_tipo,
             ta_tipo_pago  
      from cob_pfijo..pf_tasa
      where ta_tipo_deposito = @w_td_mnemonico
             
      if @@error <> 0
      begin
         select @w_error = 143010
         goto ERROR
      end
   end
   else begin
      insert into pf_tasa_variable (
             tv_mnemonico_prod, tv_mnemonico_tasa, tv_tipo_monto,     tv_tipo_plazo,
             tv_spread_max,     tv_spread_min,     tv_spread_vigente, tv_moneda,
             tv_estado,         tv_fecha_crea,     tv_fecha_mod,      tv_operador,
             tv_tasa_max,       tv_tasa_min,       tv_usuario,        tv_tipo_pago)
      select @i_mnemonico,      tv_mnemonico_tasa, tv_tipo_monto,     tv_tipo_plazo,
             tv_spread_max,     tv_spread_min,     tv_spread_vigente, tv_moneda,
             'A',               @s_date,           @s_date,           tv_operador,
             tv_tasa_max,       tv_tasa_min,       @s_user,           tv_tipo_pago
      from cob_pfijo..pf_tasa_variable
      where tv_mnemonico_prod = @w_td_mnemonico
             
      if @@error <> 0
      begin
         select @w_error = 143047
         goto ERROR
      end
   end   
commit tran
return 0


ERROR:
    rollback tran
    exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = @w_error
    return 1

go



