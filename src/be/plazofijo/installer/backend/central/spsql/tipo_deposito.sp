/************************************************************************/
/*  Archivo               : tipo_deposito.sp                            */
/*  Stored procedure      : sp_tipo_deposito                            */
/*  Base de datos         : cob_pfijo                                   */
/*  Producto              : Plazo_fijo                                  */
/*  Disenado por          : Carolina Alvarado                           */
/*  Fecha de documentacion: 9/Ago/95                                    */
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
/*  Este programa procesa el mantenimiento de la tabla                  */
/*  que tiene especificaciones generales de tipos de depositos          */
/*  Insercion de pf_tipo_deposito                                       */
/*  Actualizacion de pf_tipo_deposito                                   */
/*  Eliminacion de pf_tipo_deposito                                     */
/*  Search de la tabla pf_tipo_deposito                                 */
/*  Query sobre pf_tipo_deposito                                        */
/*  Help a la tabla pf_tipo_deposito                                    */
/*                                                                      */
/************************************************************************/
/*                          MODIFICACIONES                              */
/*  FECHA        AUTOR                RAZON                             */
/*  06-Nov-1998  G. Estupinian      Insercion en pf_conversion          */ 
/*  12-Abr-2000  X. Cartagena       Insercion de Tasa Variable          */  
/*  24-Ago-2007  N. Silva           Tipo Banca, correcciones            */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS ON
go

SET QUOTED_IDENTIFIER ON
go

if exists (select 1 from sysobjects where name = 'sp_tipo_deposito')
   drop proc sp_tipo_deposito
go

create proc sp_tipo_deposito (
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
       @i_operacion            char(1),     
       @i_tipo                 char(1)      = null,
       @i_tipo_deposito        tinyint      = null,
       @i_mnemonico            varchar(10)  = null,
       @i_descripcion          varchar(30)  = null,
       @i_forma_pago           catalogo     = null,             
       @i_capitalizacion       char(1)      = 'N', 
       @i_dias_reverso         tinyint      = 0,
       @i_base_calculo         catalogo     = null,             
       @i_modo                 smallint     = 0, 
       @i_valor                char(1)      = '%',    
       @i_indicador            char(1)      = null,
       @i_emision_inicial      int          = 0,
       @i_num_dias_gracia      int          = null,
       @i_dias_gracia          char(1)      = null,
       @i_prorroga_aut         char(1)      = null,
       @i_num_prorroga         int          = 0, 
       @i_comercial            char(1)      = 'N',
       @i_tasavar              char(1)      = 'N',
       @i_tasaefec             char(1)      = 'N',
       @i_retiene_impto        char(1)      = 'N',
       @i_tran_sabado          char(1)      = 'N',  
       @i_periodo_tasa         smallint     = null, --Periodo en meses del cambio de tasa cuando td_tipo_tasa_var = 'P'eriodica
       @i_paga_comision        char(1)      = 'N',
       @i_cupon                char(1)      = 'N',  -- GES 06/15/01 CUZ-020-008
       @i_cambio_tasa          char(1)      = 'N', 
       @i_incr_decr            char(1)      = 'N',  -- GES 07/23/01 CUZ-024-002
	   @i_num_serie            varchar(12)  = null,
       @i_tipo_persona         catalogo     = null,
       @i_dias_reales          char(1)      = 'N', 
       @i_tipo_tasa_var        char(1)      = null,
       @i_valor_1              char(20)     = null,
       @i_estado               char(1)      = 'A',
       @i_flag_tipo_deposito   char(1)      = 'N',
       @i_tipo_banca           catalogo     = null,
       @i_tasa_precancela      char(1)      = 'N',
       @i_empresa              tinyint      = 1,
       @i_area_contable        int          = null
)
with encryption
as
declare @w_sp_name              varchar(32),
        @w_descripcion          varchar(30),
        @w_forma_pago           catalogo,
        @w_estado               char(1),
        @w_return               int,
        @w_mnemonico            varchar(10),
        @w_capitalizacion       char(1),  
        @w_dias_reverso         tinyint,
        @w_base_calculo         catalogo,  
        @w_moneda               smallint,  
        @w_tipo_reg             catalogo,
        @w_valor                varchar(5),
        @w_fecha_crea           datetime,
        @w_fecha_mod            datetime,
        @w_codigo               char(1),
        @w_tipo_deposito        tinyint, 
        @v_mnemonico            varchar(10),
        @v_descripcion          varchar(30),
        @v_fecha_crea           datetime,
        @v_fecha_mod            datetime,
        @v_forma_pago           catalogo,
        @v_capitalizacion       char(1),  
        @v_dias_reverso         tinyint,
        @v_base_calculo         catalogo, 
        @w_stock                int,
        @v_stock                int,
        @w_emision_inicial      int,
        @v_emision_inicial      int, 
        @w_mantiene_stock       char(1),
        @v_mantiene_stock       char(1),
        @w_papel_vendido        int,
        @w_num_dias_gracia      int,       -- 06-Abr-2000 Inicio Prorroga
        @w_dias_gracia          char(1),   
        @w_prorroga_aut         char(1),   
        @w_anio_comercial       char(1),   -- 04/04/2000 Fecha Comercial
        @w_tasavar              char(1),   -- 12-Abr-2000 Tasa Variable
        @w_tasaefec             char(1),   -- 12-Abr-2000 Tasa Efectiva
        @w_retiene_impto        char(1),   
        @w_tran_sabado          char(1),   
        @w_cupon                char(1),   
        @w_cambio_tasa          char(1),  
        @w_incr_decr            char(1),  
        @w_area_contable        int,      
        @v_num_dias_gracia      int,       
        @v_dias_gracia          char(1),   
        @v_prorroga_aut         char(1),   -- 06-Abr-2000 Fin Prorroga
        @v_anio_comercial       char(1),   -- 04/04/2000 Fecha Comercial
        @v_tasavar              char(1),   -- 12-Abr-2000 Tasa Variable
        @v_tasaefec             char(1),   -- 12-Abr-2000 Tasa Efectiva
        @v_retiene_impto        char(1),   -- GES 04/09/01 CUZ-004-022
        @v_tran_sabado          char(1),  
        @w_paga_comision        char(1),  
        @v_paga_comision        char(1),  
        @v_cupon                char(1),  
        @v_cambio_tasa          char(1),  
        @v_incr_decr            char(1),  
        @v_area_contable        int,      
        @w_tipo_persona         catalogo,  
        @v_tipo_persona         catalogo, 
        @w_dias_reales          char(1),  
        @v_dias_reales          char(1),  
        @w_tipo_tasa_var        char(1),  
        @v_tipo_tasa_var        char(1),  
        @w_estado_aux           char(1),
        @w_accion               char(1),
        @w_num_prorrogas        int,
        @w_tipo_banca           catalogo,
        @w_periodo_tasa         smallint,  
        @v_periodo_tasa         smallint,
        @w_tasa_precancela      char(1),
        @v_tasa_precancela      char(1),
        @w_encaje_legal         char(1),
        @v_encaje_legal         char(1),
        @w_msg                  varchar(240),
        @w_error                int,
		@w_num_serie            varchar(12),
		@v_num_serie            varchar(12),
		@w_estado_archivo       char(1)

select @w_sp_name       = 'sp_tipo_deposito',
       @w_papel_vendido = 0,
       @w_error         = 0              

if (@t_trn <> 14134 or @i_operacion not in ('I','Y')) and
   (@t_trn <> 14234 or @i_operacion <> 'U') and
   (@t_trn <> 14334 or @i_operacion <> 'D') and
   (@t_trn <> 14434 or @i_operacion <> 'Q') and
   (@t_trn <> 14434 or @i_operacion <> 'W') and
   (@t_trn <> 14534 or @i_operacion <> 'S') and
   (@t_trn <> 14634 or @i_operacion <> 'H')
begin
   exec cobis..sp_cerror
        @t_debug     = @t_debug,
        @t_file      = @t_file,
        @t_from      = @w_sp_name,
        @i_num       = 141112
  return 1
end

if isnull(@i_tipo_persona,'') = ''
   select @i_tipo_persona = 'N'

----------
-- Insert 
----------
if @i_operacion = 'I'
begin
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
  
      insert into pf_tipo_deposito
                  ( td_tipo_deposito            , td_mnemonico               , td_descripcion,
                    td_forma_pago               , td_capitalizacion          , td_dias_reverso,
                    td_base_calculo             , td_fecha_crea              , td_fecha_mod,
                    td_estado                   , td_mantiene_stock          , td_stock,
                    td_emision_inicial          , td_prorroga_aut            , td_dias_gracia,
                    td_num_dias_gracia          , td_num_prorrogas           , td_anio_comercial,
                    td_tasa_variable            , td_tasa_efectiva           , td_retiene_impto,
                    td_tran_sabado              , td_paga_comision           , td_cupon,
                    td_cambio_tasa              , td_incr_decr               , td_area_contable,
                    td_tipo_persona             , td_dias_reales             , td_tipo_tasa_var,          -- GAR 23-mar-2005 Opciones Tasa Variable GB
                    td_tipo_banca               , td_periodo_tasa            , td_tasa_precancela,
                    td_encaje_legal             , td_num_serie)                                           
             values(@w_tipo_deposito            , @i_mnemonico               , @i_descripcion,
                    @i_forma_pago               , @i_capitalizacion          , @i_dias_reverso,
                    @i_base_calculo             , @s_date                    , @s_date,
                    'A'                         , @i_indicador               , @i_emision_inicial,
                    @i_emision_inicial          , isnull(@i_prorroga_aut,'N'), isnull(@i_dias_gracia,'N'),  -- 06-Abr-2000 Prorroga automatica
                    isnull(@i_num_dias_gracia,0), @i_num_prorroga            , @i_comercial,              -- 04/04/2000 Fecha Comercial
                    @i_tasavar                  , @i_tasaefec                , @i_retiene_impto,          -- GES 04/06/01 CUZ-004-007
                    @i_tran_sabado              , @i_paga_comision           , @i_cupon, 
                    @i_cambio_tasa              , @i_incr_decr               , @i_area_contable,  
                    @i_tipo_persona             , @i_dias_reales             , @i_tipo_tasa_var,          -- GAR 23-mar-2005 Opciones Tasa Variable GB
                    @i_tipo_banca               , @i_periodo_tasa            , @i_tasa_precancela,
                    'N'                         , @i_num_serie)

      if @@error <> 0
      begin
            exec cobis..sp_cerror
                 @t_debug = @t_debug,
                 @t_file  = @t_file,
                 @t_from  = @w_sp_name,
                 @i_num   = 143034
            return 1
      end
      
      ---------------------------
      -- Transaccion de servicio
      ---------------------------
      insert into ts_tipo_deposito 
            (secuencial        , tipo_transaccion, clase           , fecha,
             usuario           , terminal        , srv             , lsrv,
             tipo_deposito     , mnemonico       , descripcion     , forma_pago,   
             capitalizacion    , dias_reverso    , base_calculo    , fecha_crea,
             fecha_mod         , estado          , mantiene_stock  , emision_inicial,
             stock             , anio_comercial  , tasa_variable   , tasa_efectiva,
             retiene_impto     , tran_sabado     , paga_comision   , cupon,
             cambio_tasa       , incr_decr       , area_contable   , tipo_persona, --GAR 25-feb-2005 DP0004
             dias_reales       , tipo_tasa_var   , periodo_tasa    , ofi,
             num_serie) --GAR 23-mar-2005   Opciones Tasa Variable GB
      values(@s_ssn            , @t_trn          , 'N'             , @s_date,
             @s_user           , @s_term         , @s_srv          , @s_lsrv,
             @w_tipo_deposito  , @i_mnemonico    , @i_descripcion  , @i_forma_pago,       
             @i_capitalizacion , @i_dias_reverso , @i_base_calculo , @s_date,
             @s_date           , 'A'             , @i_indicador    , @i_emision_inicial,
             @i_emision_inicial, @i_comercial    , @i_tasavar      , @i_tasaefec, 
             @i_retiene_impto  , @i_tran_sabado  , @i_paga_comision, @i_cupon, 
             @i_cambio_tasa    , @i_incr_decr    , @i_area_contable, @i_tipo_persona, 
             @i_dias_reales    , @i_tipo_tasa_var, @i_periodo_tasa , @s_ofi,
             @i_num_serie) --GAR 23-mar-2005 Opciones Tasa Variable GB

      if @@error <> 0
      begin
            exec cobis..sp_cerror
                 @t_debug        = @t_debug,
                 @t_file         = @t_file,
                 @t_from         = @w_sp_name,
                 @i_num          = 143005               
            return 1
      end

      commit tran

      select @w_tipo_deposito 

      return 0
end

----------
-- Update
----------
if @i_operacion = 'U'
begin 
 
   select @w_descripcion     = td_descripcion,
          @w_forma_pago      = td_forma_pago,
          @w_capitalizacion  = td_capitalizacion,
          @w_dias_reverso    = td_dias_reverso,
          @w_base_calculo    = td_base_calculo,
          @w_fecha_mod       = td_fecha_mod,
          @w_stock           = td_stock,
          @w_mantiene_stock  = td_mantiene_stock,
          @w_emision_inicial = td_emision_inicial,
          @w_prorroga_aut    = td_prorroga_aut,     -- 06-Abr-2000 Inicio Prorroga
          @w_dias_gracia     = td_dias_gracia,
          @w_num_dias_gracia = td_num_dias_gracia,  -- 06-Abr-2000 Fin Prorroga
          @w_anio_comercial  = td_anio_comercial,   --04/04/2000 Fecha Comercial
          @w_tasavar         = td_tasa_variable,    --12-Abr-2000 Tasa Variable
          @w_tasaefec        = td_tasa_efectiva,    --12-Abr-2000 Tasa Efec.
          @w_retiene_impto   = td_retiene_impto, 
          @w_tran_sabado     = td_tran_sabado, 
          @w_paga_comision   = td_paga_comision, 
          @w_cupon           = td_cupon,   
          @w_cambio_tasa     = td_cambio_tasa,
          @w_incr_decr       = td_incr_decr,  
          @w_area_contable   = td_area_contable,  
          @w_tipo_persona    = td_tipo_persona,    
          @w_dias_reales     = td_dias_reales,     
          @w_tipo_deposito   = td_tipo_deposito,   
          @w_tipo_tasa_var   = td_tipo_tasa_var,   
          @w_periodo_tasa    = td_periodo_tasa,
          @w_tasa_precancela = td_tasa_precancela,
          @w_encaje_legal    = td_encaje_legal,
          @w_num_serie       = td_num_serie
    from pf_tipo_deposito
    where td_mnemonico = @i_mnemonico 
      and td_estado = 'A'
    
    if @@rowcount = 0
    begin
        exec cobis..sp_cerror
             @t_debug        = @t_debug,
             @t_file         = @t_file,
             @t_from         = @w_sp_name,
             @i_num          = 141115
        return 1    
    end
      
    select @v_descripcion     = @w_descripcion,
           @v_forma_pago      = @w_forma_pago,
           @v_capitalizacion  = @w_capitalizacion,
           @v_dias_reverso    = @w_dias_reverso,
           @v_base_calculo    = @w_base_calculo,
           @v_fecha_mod       = @w_fecha_mod,
           @v_stock           = @w_stock,
           @v_mantiene_stock  = @w_mantiene_stock,
           @v_emision_inicial = @w_emision_inicial,
           @v_prorroga_aut    = @w_prorroga_aut, 
           @v_dias_gracia     = @w_dias_gracia,
           @v_num_dias_gracia = @w_num_dias_gracia,
           @v_anio_comercial  = @w_anio_comercial,
           @v_tasavar         = @w_tasavar, 
           @v_retiene_impto   = @w_retiene_impto,  
           @v_tran_sabado     = @w_tran_sabado,    
           @v_paga_comision   = @w_paga_comision,  
           @v_cupon           = @w_cupon,          
           @v_cambio_tasa     = @w_cambio_tasa,    
           @v_incr_decr       = @w_incr_decr,      
           @v_area_contable   = @w_area_contable,  
           @v_tipo_persona    = @w_tipo_persona,   
           @v_dias_reales     = @w_dias_reales,    
           @v_tipo_tasa_var   = @w_tipo_tasa_var,
           @v_num_serie       = @w_num_serie		   

   if @w_descripcion = @i_descripcion
      select @w_descripcion = null, @v_descripcion = null
   else
      select @w_descripcion = @i_descripcion
                          
   if @w_forma_pago = @i_forma_pago
      select @w_forma_pago = null, @v_forma_pago = null
   else
      select @w_forma_pago = @i_forma_pago

   if @w_capitalizacion = @i_capitalizacion
      select @w_capitalizacion = null, @v_capitalizacion = null
   else
      select @w_capitalizacion = @i_capitalizacion
     
   if @w_dias_reverso = @i_dias_reverso  
      select @w_dias_reverso = null, @v_dias_reverso = null
   else
      select @w_dias_reverso = @i_dias_reverso  

   if @w_base_calculo = @i_base_calculo  
      select @w_base_calculo = null, @v_base_calculo = null
   else
      select @w_base_calculo = @i_base_calculo 
 
   if @w_fecha_mod = @s_date
      select @w_fecha_mod = null, @v_fecha_mod = null
   else
      select @w_fecha_mod = @s_date 

   if @v_mantiene_stock = 'S' 
        select @w_papel_vendido = @v_emision_inicial - @v_stock
   else
        select @w_papel_vendido = 0
   select @w_stock = @i_emision_inicial - @w_papel_vendido

   if @w_mantiene_stock = @i_indicador
      select @w_mantiene_stock = null, @v_mantiene_stock = null
   else
      select @w_mantiene_stock = @i_indicador 

   if @w_emision_inicial = @i_emision_inicial
      select @w_emision_inicial = null, @v_emision_inicial = null
   else
      select @w_emision_inicial = @i_emision_inicial 

   if @w_prorroga_aut = @i_prorroga_aut
      select @w_prorroga_aut = null, @v_prorroga_aut = null
   else
      select @w_prorroga_aut = @i_prorroga_aut

   if @w_dias_gracia = @i_dias_gracia
      select @w_dias_gracia = null, @v_dias_gracia = null
   else
      select @w_dias_gracia = @i_dias_gracia

   if @w_num_dias_gracia = @i_num_dias_gracia
      select @w_num_dias_gracia = null, @v_num_dias_gracia = null
   else
      select @w_num_dias_gracia = @i_num_dias_gracia
   
   if @w_anio_comercial = @i_comercial      --04/04/2000  Fecha Comercial
       select @w_anio_comercial = null, @v_anio_comercial = null
   else
       select @w_anio_comercial = @i_comercial --04/04/2000 Fecha Comercial 

   if @w_tasavar = @i_tasavar      --12-Abr-2000 Tasa Variable
       select @w_tasavar = null, @v_tasavar = null
   else
       select @w_tasavar = @i_tasavar --12-Abr-2000 Tasa Variable 

   -- GES 04/09/01 CUZ-004-013 Se aumenta flag de retencion de impuestos
   if @w_retiene_impto = @i_retiene_impto
      select @w_retiene_impto = null, @v_retiene_impto = null
   else
      select @w_retiene_impto = @i_retiene_impto 

   -- GES 05/10/01 CUZ-009-014 Flag para transacciones en dia no laborable 
   if @w_tran_sabado = @i_tran_sabado
      select @w_tran_sabado = null, @v_tran_sabado = null
   else
      select @w_tran_sabado = @i_tran_sabado 

   if @w_paga_comision = @i_paga_comision
      select @w_paga_comision = null, @v_paga_comision = null
   else
      select @w_paga_comision = @i_paga_comision 
   
   -- GES 06/15/01 CUZ-020-014 Flag para indicar si maneja cupon     
   if @w_cupon = @i_cupon
      select @w_cupon = null, @v_cupon = null
   else
      select @w_cupon = @i_cupon

   -- WSM 6/7/01 DP-00027-10      
   if @w_cambio_tasa = @i_cambio_tasa
      select @w_cambio_tasa = null, @v_cambio_tasa = null
   else
      select @w_cambio_tasa = @i_cambio_tasa

   -- GES 07/23/01 CUZ-024-006 Permitir incrementos o decrementos

   if @w_incr_decr = @i_incr_decr
      select @w_incr_decr = null, @v_incr_decr = null
   else
      select @w_incr_decr = @i_incr_decr

   -- GES 08/27/01 CUZ-027-0011 Area contable

   if @w_area_contable = @i_area_contable
      select @w_area_contable = null, @v_area_contable = null
   else
      select @w_area_contable = @i_area_contable
   -- GAR 25-feb-2005 DP0004
   if @w_tipo_persona = @i_tipo_persona
      select @w_tipo_persona = null, @v_tipo_persona = null
   else
      select @w_tipo_persona = @i_tipo_persona
   
   --GAR 23-mar-2005 Dias Reales GB
   if @w_dias_reales = @i_dias_reales
      select @w_dias_reales = null, @v_dias_reales = null
   else
      select @w_dias_reales = @i_dias_reales

   --GAR 23-mar-2005 Opciones Tasa Variable GB
   if @w_tipo_tasa_var = @i_tipo_tasa_var
      select @w_tipo_tasa_var = null, @v_tipo_tasa_var = null
   else
      select @w_tipo_tasa_var = @i_tipo_tasa_var

   if @w_periodo_tasa = @i_periodo_tasa
      select @w_periodo_tasa = null, @v_periodo_tasa = null
   else
      select @w_periodo_tasa = @i_periodo_tasa

   if @w_tasa_precancela = @i_tasa_precancela
      select @w_tasa_precancela = null, @v_tasa_precancela = null
   else begin
      select @w_tasa_precancela = @i_tasa_precancela
      if exists(select 1 from cob_pfijo..pf_operacion where op_toperacion = @i_mnemonico and op_estado not in ('CAN','ANU'))             
         select @w_msg   = '[' + @w_sp_name + '] ' + 'Existen operaciones activas, no se permite modificar tasa precancelacion',
                @w_error = 141117
   end
   select @w_encaje_legal = 'N'
   
   if @w_num_serie = @i_num_serie
      select @w_num_serie = null, @v_num_serie = null
   else
      select @w_num_serie = @i_num_serie
   --Validaciones--
   if @w_error <> 0 
   begin
         exec cobis..sp_cerror
               @t_from = @w_sp_name,
               @i_num  = @w_error,
               @i_msg  = @w_msg 
        return 1    
   end 

   begin tran

   -- modificacion de los datos --
   update pf_tipo_deposito
   set td_descripcion     = @i_descripcion,
       td_forma_pago      = @i_forma_pago,
       td_capitalizacion  = @i_capitalizacion,
       td_dias_reverso    = @i_dias_reverso,
       td_base_calculo    = @i_base_calculo,
       td_fecha_mod       = @s_date,
       td_mantiene_stock  = @i_indicador,
       td_stock           = @w_stock,
       td_emision_inicial = @i_emision_inicial,
       td_prorroga_aut    = isnull(@i_prorroga_aut,'N'),  
       td_dias_gracia     = isnull(@i_dias_gracia,'N'),   
       td_num_dias_gracia = isnull(@i_num_dias_gracia,0), 
       td_num_prorrogas   = @i_num_prorroga,              
       td_anio_comercial  = @i_comercial,                 
       td_tasa_variable   = @i_tasavar,                   
       td_tasa_efectiva   = @i_tasaefec,                  
       td_retiene_impto   = @i_retiene_impto,             
       td_tran_sabado     = @i_tran_sabado,               
       td_paga_comision   = @i_paga_comision,             
       td_cupon           = @i_cupon,                  
       td_cambio_tasa     = @i_cambio_tasa,               
       td_incr_decr       = @i_incr_decr,                 
       td_area_contable   = @i_area_contable,             
       td_tipo_persona    = @i_tipo_persona,              
       td_dias_reales     = @i_dias_reales,               
       td_tipo_tasa_var   = @i_tipo_tasa_var,             
       td_tipo_banca      = @i_tipo_banca,
       td_periodo_tasa    = @i_periodo_tasa,
       td_tasa_precancela = @i_tasa_precancela,
       td_encaje_legal    = 'N',
       td_num_serie       = @i_num_serie
   where td_mnemonico = @i_mnemonico
     
   if @@error <> 0 
   begin
          exec cobis..sp_cerror
               @t_debug        = @t_debug,
               @t_file         = @t_file,
               @t_from         = @w_sp_name,
               @i_num          = 145034
          return 1    
    end 
  
    insert into ts_tipo_deposito
          (secuencial       , tipo_transaccion   , clase, fecha,
           usuario          , terminal           , srv               , lsrv,
           tipo_deposito    , mnemonico          , descripcion       , forma_pago,
           capitalizacion   , dias_reverso       , base_calculo      , fecha_crea,
           fecha_mod        , estado             , mantiene_stock    , emision_inicial,
           stock            , anio_comercial     , tasa_variable     , tasa_efectiva, 
           retiene_impto    , tran_sabado        , paga_comision     , cupon,   
           cambio_tasa      , incr_decr          , area_contable     , tipo_persona,  
           dias_reales      , tipo_tasa_var      , periodo_tasa      , ofi,
           num_serie) 
    values(@s_ssn           , @t_trn             , 'P'               , @s_date,
           @s_user          , @s_term            , @s_srv            , @s_lsrv,
           @w_tipo_deposito , null               , @v_descripcion    , @v_forma_pago  ,
           @v_capitalizacion, @v_dias_reverso    , @v_base_calculo   , null,
           @v_fecha_mod,null, @v_mantiene_stock  , @v_emision_inicial,
           @v_stock         , @v_anio_comercial  , @v_tasavar        , @v_tasaefec,  
           @v_retiene_impto , @v_tran_sabado     , @v_paga_comision  , @v_cupon,   
           @v_cambio_tasa   , @v_incr_decr       , @v_area_contable  , @v_tipo_persona,  
           @v_dias_reales   , @v_tipo_tasa_var   , @v_periodo_tasa   , @s_ofi,
           @v_num_serie)  

    if @@error <> 0 
    begin
         exec cobis..sp_cerror
              @t_debug        = @t_debug,
              @t_file         = @t_file,
              @t_from         = @w_sp_name,
              @i_num          = 143005
         return 1    
    end 

    insert into ts_tipo_deposito
          (secuencial       , tipo_transaccion   , clase            , fecha,
           usuario          , terminal           , srv              , lsrv,
           tipo_deposito    , mnemonico          , descripcion      , forma_pago,
           capitalizacion   , dias_reverso       , base_calculo     , fecha_crea,
           fecha_mod        , estado             , mantiene_stock   , emision_inicial,
           stock            , anio_comercial     , tasa_variable    , tasa_efectiva,  
           retiene_impto    , tran_sabado        , paga_comision    , cupon,   
           cambio_tasa      , incr_decr          , area_contable    , tipo_persona,  
           dias_reales      , tipo_tasa_var      , periodo_tasa     , ofi,
           num_serie) 
    values(@s_ssn           , @t_trn             , 'A'              , @s_date,
           @s_user          , @s_term            , @s_srv           , @s_lsrv,
           @w_tipo_deposito , null               , @w_descripcion   , @w_forma_pago,
           @w_capitalizacion, @w_dias_reverso    , @w_base_calculo  , null,
           @w_fecha_mod     , null               , @w_mantiene_stock, @w_emision_inicial, 
           @w_stock         , @w_anio_comercial  , @w_tasavar       , @w_tasaefec, 
           @w_retiene_impto , @w_tran_sabado     , @w_paga_comision , @w_cupon,            
           @w_cambio_tasa   , @w_incr_decr       , @w_area_contable , @w_tipo_persona,
           @w_dias_reales   , @w_tipo_tasa_var   , @w_periodo_tasa  , @s_ofi,
           @w_num_serie)  

    if @@error <> 0 
    begin
          exec cobis..sp_cerror
               @t_debug = @t_debug,
               @t_file  = @t_file,
               @t_from  = @w_sp_name,
               @i_num   = 143005
          return 1    
    end 

    commit tran

    return 0
end -- fin de if @i_operacion = U --   

----------
-- Delete
----------
if @i_operacion = 'D'
begin
    if @i_estado = 'A'
       select @w_estado_aux = 'E', @w_accion = 'B'
    else
       select @w_estado_aux = 'A', @w_accion = 'H'
    
    select @w_descripcion     = td_descripcion,
           @w_mnemonico       = td_mnemonico, 
           @w_forma_pago      = td_forma_pago,
           @w_capitalizacion  = td_capitalizacion,
           @w_dias_reverso    = td_dias_reverso,
           @w_base_calculo    = td_base_calculo,
           @w_fecha_crea      = td_fecha_crea,
           @w_fecha_mod       = td_fecha_mod,
           @w_estado          = td_estado,
           @w_mantiene_stock  = td_mantiene_stock,
           @w_stock           = td_stock,
           @w_emision_inicial = td_emision_inicial,
           @w_anio_comercial  = td_anio_comercial,
           @w_tasavar         = td_tasa_variable,
           @w_tasaefec        = td_tasa_efectiva,
           @w_retiene_impto   = td_retiene_impto,
           @w_tran_sabado     = td_tran_sabado,  
           @w_cupon           = td_cupon,  
           @w_cambio_tasa     = td_cambio_tasa,
           @w_incr_decr       = td_incr_decr, 
           @w_area_contable   = td_area_contable,
           @w_tipo_persona    = td_tipo_persona,
           @w_dias_reales     = td_dias_reales,
           @w_tipo_deposito   = td_tipo_deposito,
           @w_tipo_tasa_var   = td_tipo_tasa_var,
           @w_periodo_tasa    = td_periodo_tasa,
           @w_tasa_precancela = td_tasa_precancela,
           @w_encaje_legal    = td_encaje_legal,
           @w_num_serie       = td_num_serie		   
     from pf_tipo_deposito
     where td_mnemonico = @i_mnemonico           
       and td_estado       = @i_estado

      if @@rowcount = 0
      begin
           exec cobis..sp_cerror
                @t_debug = @t_debug,
                @t_file  = @t_file,
                @t_from  = @w_sp_name,
                @i_num   = 141115
           return 1    
      end

      if @w_mantiene_stock = 'S' and @w_stock > 0 and @i_estado ='A'
      begin
           exec cobis..sp_cerror
                @t_debug = @t_debug,
                @t_file  = @t_file,
                @t_from  = @w_sp_name,
                @i_num   = 141148
           return 1    
      end 

      begin tran  

      -- borrar el tipo de deposito  --
      update pf_tipo_deposito 
      set td_estado= @w_estado_aux,
          td_fecha_mod = @s_date
      where td_mnemonico = @i_mnemonico
        and td_estado    = @i_estado

      if @@error <> 0
      begin
           exec cobis..sp_cerror
                @t_debug = @t_debug,
                @t_file  = @t_file,
                @t_from  = @w_sp_name,
                @i_num   = 147034
           return 1    
     end 
  
     -- transaccion de servicios - pf_tipo_deposito --
     insert into ts_tipo_deposito
            (secuencial       , tipo_transaccion , clase            , fecha,
             usuario          , terminal         , srv              , lsrv,
             tipo_deposito    , mnemonico        , descripcion      , forma_pago,
             capitalizacion   , dias_reverso     , base_calculo     , fecha_crea,
             fecha_mod        , estado           , mantiene_stock   , emision_inicial,
             stock            , anio_comercial   , retiene_impto    , tran_sabado,
             cupon            , cambio_tasa      , incr_decr        , area_contable, 
             tipo_persona     , dias_reales      , tipo_tasa_var    , periodo_tasa,
             ofi              , num_serie)
     values (@s_ssn           , @t_trn           , @w_accion        , @s_date,
             @s_user          , @s_term          , @s_srv           , @s_lsrv,
             @w_tipo_deposito , @w_mnemonico     , @w_descripcion   , @w_forma_pago,
             @w_capitalizacion, @w_dias_reverso  , @w_base_calculo  , @w_fecha_crea,
             @w_fecha_mod     , @w_estado        , @w_mantiene_stock, @w_emision_inicial, 
             @w_stock         , @w_anio_comercial, @w_retiene_impto , @w_tran_sabado, 
             @w_cupon         , @w_cambio_tasa   , @w_incr_decr     , @w_area_contable, 
             @w_tipo_persona  , @w_dias_reales   , @w_tipo_tasa_var , @w_periodo_tasa,
             @s_ofi           , @w_num_serie)

     -- si no se puede insertar, error --
     if @@error <> 0 
     begin
          exec cobis..sp_cerror
               @t_debug = @t_debug,
               @t_file  = @t_file,
               @t_from  = @w_sp_name,
               @i_num   = 143005
          return 1    
     end 
      
      -- Borrar en auxiliares de tipos de depositos --
      
      while (1 = 1)
      begin
         set rowcount 1
         select @w_moneda     = at_moneda,
                @w_tipo_reg   = at_tipo,
                @w_valor      = at_valor,
                @w_fecha_crea = at_fecha_crea,
                @w_estado     = at_estado       
           from pf_auxiliar_tip
           where at_tipo_deposito = @i_tipo_deposito
         and at_estado = @i_estado

         if @@rowcount = 0
            break
        
         update pf_auxiliar_tip
            set at_estado = @w_estado_aux
          where at_tipo_deposito = @i_tipo_deposito 
            and at_moneda        = @w_moneda
            and at_tipo          = @w_tipo_reg
            and at_valor         = @w_valor
            
         if @@error <> 0
         begin
              exec cobis..sp_cerror
                   @t_debug = @t_debug,
                   @t_file  = @t_file,
                   @t_from  = @w_sp_name,
                   @i_num   = 147036
              return 1
         end
        

     insert into ts_auxiliar_tip
            (secuencial      , tipo_transaccion, clase      , fecha,
             usuario         , terminal        , srv        , lsrv,
             tipo_deposito   , moneda          , tipo       , valor,
             fecha_crea      , fecha_elim      , estado     , ofi)    
     values (@s_ssn          , @t_trn          , @w_accion  , @s_date,
             @s_user         , @s_term         , @s_srv     , @s_lsrv,
             @i_tipo_deposito, @w_moneda       , @w_tipo_reg, @w_valor,
             @w_fecha_crea   , @s_date         , @w_estado  , @s_ofi)
     if @@error <> 0
     begin
          exec cobis..sp_cerror
               @t_debug = @t_debug,
               @t_file  = @t_file,
               @t_from  = @w_sp_name,
               @i_num   = 143005
          return 1
     end
  end   
  commit tran
  return 0
end -- end de if operacion = D --

----------
-- Search 
----------
if @i_operacion = 'S' begin 
 
   select @i_tipo_deposito  = case @i_modo when 0 then 0 else @i_tipo_deposito end
   
   set rowcount 20
   select
   'TIPO DE DPF'            = td_mnemonico,         
   'DESCRIPCION'            = substring(td_descripcion,1,30),
   'MANT. INVENTARIO'       = td_mantiene_stock,
   'EMISION INICIAL'        = td_emision_inicial,
   'DISPONIBLE'             = td_stock,
   'FORMA DE PAGO'          = td_forma_pago,                 
   'CAPITALIZA'             = td_capitalizacion,
   'CODIGO'                 = td_tipo_deposito, 
   'NUMERO PRORROGAS'       = td_num_prorrogas, 
   'FECHA COMERCIAL'        = td_anio_comercial,
   'TASA VARIABLE'          = td_tasa_variable,
   'TASA EFECTIVA'          = td_tasa_efectiva, 
   'RETIENE IMPUESTO'       = td_retiene_impto,
   'TRN. DIA NO LABORABLE'  = td_tran_sabado, 
   'PAGA COMISION'          = isnull(td_paga_comision,'N'), 
   'MANEJA CUPON'           = td_cupon, 
   'CAMBIO TASA'            = td_cambio_tasa, 
   'INCREMENTO/DISMINUCION' = td_incr_decr, 
   'AREA CONTABLE'          = td_area_contable, 
   'TIPO PERSONA'           = td_tipo_persona,
   'DIAS CALENDARIO'        = td_dias_reales, 
   'TIPO TASA VARIABLE'     = td_tipo_tasa_var,
   'PERIODO TASA VAR.'      = td_periodo_tasa,
   'APLICA TASA PRECANCELA' = td_tasa_precancela,
   'ENCAJE LEGAL'           = td_encaje_legal,
   'NUMERO SERIE'           = td_num_serie,
   'BASE DE CALCULO'        = td_base_calculo   
   from  pf_tipo_deposito
   where ((td_estado = 'A' and @i_flag_tipo_deposito = 'S') or @i_flag_tipo_deposito = 'N')
   and   isnull(td_mantiene_stock,'N') like  @i_valor
   and   td_tipo_deposito > @i_tipo_deposito   
   order by td_tipo_deposito

   set rowcount 0 
   return 0   
end 

---------
-- Query
---------
If @i_operacion = 'Q'
begin 
   select td_mnemonico,         
          substring(td_descripcion,1,30),
          td_forma_pago,
          td_capitalizacion,
          td_dias_reverso,
          td_base_calculo,
          td_mantiene_stock,
          td_stock,
          td_emision_inicial,
          td_prorroga_aut,
          td_dias_gracia,
          td_num_dias_gracia,
          td_num_prorrogas, 
          td_anio_comercial,
          td_tasa_variable, 
          td_tasa_efectiva, 
          td_retiene_impto, 
          td_tran_sabado,   
          td_paga_comision ,
          td_cupon,         
          td_cambio_tasa,   
          td_incr_decr,     
          td_area_contable, 
          td_tipo_persona, 
          td_dias_reales, 
          td_tipo_tasa_var,
          td_periodo_tasa,
          td_tasa_precancela,
          td_encaje_legal,
          td_num_serie		  
    from  pf_tipo_deposito
   where td_mnemonico = @i_mnemonico 
     and ((td_estado = 'A' and @i_flag_tipo_deposito = 'S') or @i_flag_tipo_deposito = 'N')
     
   if @@rowcount > 0
   begin
        exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file,
             @t_from  = @w_sp_name,
             @i_num   = 141116
        return 1
   end
   return 0
end

------------------------------------------------------------
-- consultar todos los registro incluidos los de estado 'E'
------------------------------------------------------------
if @i_operacion = 'W' 
begin
     --se devolveran los siguientes valores:
     --N el tipo de deposito no existe para el nemonico dado
     --A el tipo de deposito existe para el nemonico dado y esta en estado 'A'
     --E el tipo de deposito existe para el nemonico dado y esta en estado 'E'

     if exists(select 1 from pf_tipo_deposito
                where td_mnemonico = @i_mnemonico)
     begin
          select td_estado
          from pf_tipo_deposito
          where td_mnemonico = @i_mnemonico
     end
     else
          select 'N'    
   
     return 0
end

--------
-- Help
--------
if @i_operacion = 'H'
begin
   if @i_tipo = 'A'
   begin

       select @i_tipo_deposito = case @i_modo
                                   when 0 then 0
                                   else @i_tipo_deposito
                                 end 
       set rowcount 20

       select 'TIPO DE DPF'           = td_mnemonico,          
              'DESCRIPCION'           = substring(td_descripcion,1,30),
              'FORMA DE PAGO'         = td_forma_pago,
              'CAPITALIZA'            = td_capitalizacion,
              'DIAS REVERSO'          = td_dias_reverso,
              'BASE CALCULO'          = td_base_calculo,
              'CODIGO'                = td_tipo_deposito,
              'EMISION INICIAL'       = td_emision_inicial,
              'MANT. STOCK'           = td_mantiene_stock,
              'STOCK'                 = td_stock,           --10  
              'PRORROGA AUT.'         = td_prorroga_aut, 
              'DIAS GRACIA'           = td_dias_gracia,
              'NUM. DIAS GRACIA'      = td_num_dias_gracia,
              'NUMERO PRORROGAS'      = td_num_prorrogas, 
              'FECHA COMERCIAL'       = td_anio_comercial,
              'TASA VARIABLE'         = td_tasa_variable,
              'TASA EFECTIVA'         = td_tasa_efectiva,
              'RETIENE IMPUESTO'      = td_retiene_impto,
              'TRN. DIA NO LABORABLE' = td_tran_sabado,  
              'PAGA COMISION'         = td_paga_comision,   --20
              'MANEJA CUPON'          = td_cupon, 
              'CAMBIO TASA'           = td_cambio_tasa,
              'INCRE./DISMIN.'        = td_incr_decr,  
              'AREA CONTABLE'         = td_area_contable,
              'TIPO PERSONA'          = td_tipo_persona,
              'DIAS CALENDARIO'       = td_dias_reales,
              'TIPO TASA VARIABLE'    = td_tipo_tasa_var,
              'PERIODO TASA VAR.'     = td_periodo_tasa,
              'APLICA TASA PRECANCELA'= td_tasa_precancela,
              'ENCAJE LEGAL'          = td_encaje_legal,
			  'NUMERO DE SERIE'       = td_num_serie
      from pf_tipo_deposito
      where ((td_estado = 'A' and @i_flag_tipo_deposito = 'S') or @i_flag_tipo_deposito = 'N' )
        and td_tipo_deposito > @i_tipo_deposito
      order by td_tipo_deposito

      set rowcount 0 
      return 0   
   end
 
   if @i_tipo = 'V'
   begin
      select @w_descripcion      = substring(td_descripcion,1,30),
             @w_capitalizacion   = td_capitalizacion,
             @w_forma_pago       = td_forma_pago,
             @w_base_calculo     = td_base_calculo,
             @w_dias_reverso     = td_dias_reverso,        
             @w_mantiene_stock   = td_mantiene_stock,
             @w_stock            = td_stock,
             @w_emision_inicial  = td_emision_inicial,
             @w_prorroga_aut     = td_prorroga_aut,
             @w_dias_gracia      = td_dias_gracia,    --10
             @w_num_dias_gracia  = td_num_dias_gracia,
             @w_num_prorrogas    = td_num_prorrogas,
             @w_anio_comercial   = td_anio_comercial,
             @w_tasavar          = td_tasa_variable,
             @w_tasaefec         = td_tasa_efectiva,        
             @w_retiene_impto    = td_retiene_impto,
             @w_tran_sabado      = td_tran_sabado,
             @w_paga_comision    = td_paga_comision,
             @w_cupon            = td_cupon,
             @w_cambio_tasa      = td_cambio_tasa,    --20
             @w_incr_decr        = td_incr_decr,
             @w_area_contable    = td_area_contable,
             @w_tipo_persona     = td_tipo_persona,
             @w_dias_reales      = td_dias_reales,
             @w_tipo_tasa_var    = td_tipo_tasa_var,
             @w_periodo_tasa     = td_periodo_tasa, 
             @w_tasa_precancela  = td_tasa_precancela,
             @w_encaje_legal     = td_encaje_legal,
			 @w_num_serie        = td_num_serie
        from pf_tipo_deposito
       where td_mnemonico    = @i_mnemonico
         and ((td_estado = 'A' and @i_flag_tipo_deposito = 'S') or @i_flag_tipo_deposito = 'N' )
         
      if @@rowcount = 0
      begin
           exec cobis..sp_cerror
                @t_debug = @t_debug,
                @t_file  = @t_file,
                @t_from  = @w_sp_name,
                @i_num   = 141115
           return 141115
      end

      select distinct top 1 @w_moneda = ta_moneda    
      from cob_pfijo..pf_tasa
      where ta_tipo_deposito    = @i_mnemonico
        and isnull(ta_tipo,'N') = 'N' 
      
      select @w_descripcion   , @w_capitalizacion, @w_forma_pago     , @w_base_calculo,
             @w_dias_reverso  , @w_mantiene_stock, @w_stock          , @w_emision_inicial,
             @w_prorroga_aut  , @w_dias_gracia   , @w_num_dias_gracia, @w_num_prorrogas,
             @w_anio_comercial, @w_tasavar       , @w_tasaefec       , @w_retiene_impto,
             @w_tran_sabado   , @w_paga_comision , @w_cupon          , @w_cambio_tasa,
             @w_incr_decr     , @w_area_contable , @w_tipo_persona   , @w_dias_reales,
             @w_tipo_tasa_var , @w_periodo_tasa  , @w_tasa_precancela, @w_moneda,
             @w_encaje_legal  , @w_num_serie
    
      select at_valor
      from pf_tipo_deposito, pf_auxiliar_tip
      where td_mnemonico     = @i_mnemonico 
        and at_tipo_deposito = td_tipo_deposito
        and at_tipo          = 'CAT'
        and at_estado        = 'A'

      -- CVA Ago-18-06 Para obtener las oficinas asociadas al tipo de dpf
      select at_valor
      from pf_tipo_deposito, pf_auxiliar_tip
      where td_mnemonico     = @i_mnemonico 
        and at_tipo_deposito = td_tipo_deposito
        and at_tipo          = 'OFI'
        and at_estado        = 'A'
        and at_valor         = convert(varchar(10),@s_ofi)             
      return 0
   end


   if @i_tipo = 'B'
   begin
         select 'TIPO DE DPF'           = td_mnemonico,          
                'DESCRIPCION'           = substring(td_descripcion,1,30),
                'FORMA DE PAGO'         = td_forma_pago,
                'CAPITALIZA'            = td_capitalizacion,
                'DIAS REVERSO'          = td_dias_reverso,
                'BASE CALCULO'          = td_base_calculo,
                'CODIGO'                = td_tipo_deposito,
                'EMISION INICIAL'       = td_emision_inicial,
                'MANT. STOCK'           = td_mantiene_stock,
                'STOCK'                 = td_stock,                                   --10
                'PRORROGA AUT.'         = td_prorroga_aut, 
                'DIAS GRACIA'           = td_dias_gracia,
                'NUM. DIAS GRACIA'      = td_num_dias_gracia,
                'NUMERO PRORROGAS'      = td_num_prorrogas, 
                'FECHA COMERCIAL'       = td_anio_comercial,
                'TASA VARIABLE'         = td_tasa_variable,
                'TASA EFECTIVA'         = td_tasa_efectiva,
                'RETIENE IMPUESTO'      = td_retiene_impto,
                'TRN. DIA NO LABORABLE' = td_tran_sabado,  
                'PAGA COMISION'         = td_paga_comision ,                          --20
                'MANEJA CUPON'          = td_cupon, 
                'CAMBIO TASA'           = td_cambio_tasa, 
                'INCREM./DISMIN.'       = td_incr_decr, 
                'AREA CONTABLE'         = td_area_contable,
                'TIPO PERSONA'          = td_tipo_persona, 
                'DIAS CALENDARIO'       = td_dias_reales,
                'TIPO TASA VARIABLE'    = td_tipo_tasa_var,
                'PERIODO TASA VAR.'     = td_periodo_tasa,
                'APLICA TASA PRECANCELA'= td_tasa_precancela,
                'ENCAJE LEGAL'          = td_encaje_legal,
				'NUMERO DE SERIE'       = td_num_serie
           from pf_tipo_deposito
          where ((td_estado = 'A' and @i_flag_tipo_deposito = 'S') or @i_flag_tipo_deposito = 'N' )
            and td_descripcion like @i_valor_1
          order by td_descripcion
        
         if @@rowcount = 0
         begin
              exec cobis..sp_cerror
                   @t_debug = @t_debug,
                   @t_file  = @t_file,
                   @t_from  = @w_sp_name,
                   @i_num   = 141115
              return 1
         end
      
         return 0
   end

   ---------------------------------------
   -- Trae todos sin considerar el estado
   ---------------------------------------
   if @i_tipo = 'M'
   begin

      select @i_tipo_deposito = case @i_modo
                                  when 0 then 0
                                  else @i_tipo_deposito
                                end 

      set rowcount 20

       select 'TIPO DE DPF'       = td_mnemonico,
              'DESCRIPCION'       = substring(td_descripcion,1,30),
              'FORMA DE PAGO'     = td_forma_pago,
              'CAPITALIZA'        = td_capitalizacion,
              'DIAS REVERSO'      = td_dias_reverso,         --5
              'BASE CALCULO'      = td_base_calculo,
              'CODIGO'            = td_tipo_deposito,
              'EMISION INICIAL.'  = td_emision_inicial,
              'MANT. STOCK'       = td_mantiene_stock,
              'STOCK'             = td_stock,                --10
              'PRORROGA AUT.'     = td_prorroga_aut,
              'DIAS GRACIA'       = td_dias_gracia,
              'NUM. DIAS GRACIA'  = td_num_dias_gracia,
              'NUMERO PRORROGAS'  = td_num_prorrogas,
              'FECHA COMERCIAL'   = td_anio_comercial,       --15
              'TASA VARIABLE'     = td_tasa_variable,
              'TASA EFECTIVA'     = td_tasa_efectiva,
              'RETIENE IMPUESTO'  = td_retiene_impto,
              'TRN. DIA NO LABORABLE' = td_tran_sabado,
              'PAGA COMISION'     = td_paga_comision,        --20
              'MANEJA CUPON'      = td_cupon,
              'CAMBIO TASA'       = td_cambio_tasa,
              'INCREM./DISMIN.'   = td_incr_decr,
              'AREA CONTABLE'     = td_area_contable,
              'TIPO PERSONA'      = td_tipo_persona,         --25
              'DIAS CALENDARIO'   = td_dias_reales,
              'TIPO TASA VARIABLE'= td_tipo_tasa_var,
              'ESTADO'            = td_estado,
              'TIPO BANCA'        = td_tipo_banca,
              'PERIODO TASA VAR.' = td_periodo_tasa,
              'APLICA TASA PRECANCELA'= td_tasa_precancela,
              'ENCAJE LEGAL'      = td_encaje_legal,
			  'NUMERO DE SERIE'       = td_num_serie
      from pf_tipo_deposito
      where td_tipo_deposito > @i_tipo_deposito
      order by td_tipo_deposito

      set rowcount 0
      return 0
   end
   
   --------------------------------------------
   -- Muestra todos incluidos los de estado 'E'
   --------------------------------------------
   if @i_tipo = 'N' begin
      if exists(select 1 from pf_tipo_deposito where td_mnemonico = @i_mnemonico) begin
         select substring(td_descripcion,1,30),
         td_capitalizacion,
         td_forma_pago,
         td_base_calculo,
         td_dias_reverso,          --5
         td_mantiene_stock,
         td_stock,
         td_emision_inicial,
         td_prorroga_aut,
         td_dias_gracia,           --10
         td_num_dias_gracia,
         td_num_prorrogas,
         td_anio_comercial,
         td_tasa_variable,
         td_tasa_efectiva,         --15
         td_retiene_impto,
         td_tran_sabado,
         td_paga_comision,
         td_cupon,
         td_cambio_tasa,           --20
         td_incr_decr,
         td_area_contable,
         td_tipo_persona,
         td_dias_reales,
         td_tipo_tasa_var,         --25
         td_estado,
         td_tipo_banca,
         td_periodo_tasa,
         td_tasa_precancela,
         td_tipo_deposito,
         td_encaje_legal,
         td_num_serie
		 from pf_tipo_deposito
		 where td_mnemonico = @i_mnemonico
		 
		 select distinct @w_estado_archivo = cat_estado
         from  cob_pfijo..pf_tasas_masivas, cob_pfijo..pf_archivo_carga_tasas
         where cat_secuencial_archivo = tm_secuencial_archivo
		 and   tm_tipo_deposito       = @i_mnemonico
		 
		 if @@rowcount > 0 and @w_estado_archivo is not null begin
		    if @w_estado_archivo in ('I', 'V')
			   select @w_error = 148037
			   
		    if @w_estado_archivo in ('A')
			   select @w_error = 148038
		 
            select @w_msg = mensaje
            from   cobis..cl_errores
            where  numero = @w_error
			
            if @w_msg is not null
			   print @w_msg
		 end
      end
      else begin
	     exec cobis..sp_cerror
         @t_debug    = @t_debug,
         @t_file     = @t_file,
         @t_from     = @w_sp_name,
         @i_num      = 141115
         return 1
      end
      return 0
   end

   if @i_tipo = 'R' --areas contables
   begin

         select @i_area_contable = case @i_modo 
                                     when 0 then 0
                                     else @i_area_contable
                                   end  


         select top 20 
                'Area'        = ar_area,
                'Descripción' = ar_descripcion
         from cob_conta..cb_area
         where ar_empresa = @i_empresa    
           and ar_estado     = 'V'
           and ar_movimiento = 'S'
           and ar_area    > @i_area_contable
         order by ar_area

         if @@rowcount = 0
         begin
               exec cobis..sp_cerror
                    @t_debug = @t_debug,
                    @t_file  = @t_file,
                    @t_from  = @w_sp_name,
                    @i_num   = 141111
               return 1
         end
    end


end

--Copia la parametrizacion de otro tipo de deposito para crear uno nuevo--
if @i_operacion = 'Y' 
begin

     exec @w_return = sp_copia_tipodepo
          @s_srv           = @s_srv,
          @s_user          = @s_user,
          @s_date          = @s_date,
          @t_trn           = @t_trn,
          @i_tipo_deposito = @i_tipo_deposito,
          @i_mnemonico     = @i_mnemonico,
          @i_descripcion   = @i_descripcion
    
    if @w_return <> 0
       return @w_return

    return 0
end

go



