/************************************************************************/
/*  Archivo               : tasa_variable.sp                            */
/*  Stored procedure      : sp_tasa_variable                            */
/*  Base de datos         : cob_pfijo                                   */
/*  Producto              : Plazo Fijo                                  */
/*  Disenado por          : Hada Jessica Perez                          */
/*  Fecha de documentacion: 16-Jul-98                                   */
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
/*  Este script administra la tasa variable por producto de             */
/*  plazo fijo en la tabla pf_tasa_variable                             */
/*                                                                      */
/************************************************************************/
/*                          MODIFICACIONES                              */
/*  FECHA         AUTOR              RAZON                              */
/*  13/Jun/2016   N. Silva           Porting DAVIVIENDA                 */
/*  22/Sep/2016   O. Saavedra        DPF-S84168 Tasas Diferenciales      */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS ON
go

SET QUOTED_IDENTIFIER ON
go

if exists (select 1 from sysobjects where name = 'sp_tasa_variable' and type = 'P')
   drop proc sp_tasa_variable
go

create proc sp_tasa_variable(
@s_ssn                    int          = null,
@s_user                   login        = null,
@s_sesn                   int          = null,
@s_term                   varchar(30)  = null,
@s_date                   datetime     = null,
@s_srv                    varchar(30)  = null,
@s_lsrv                   varchar(30)  = null,
@s_ofi                    smallint     = null,
@s_rol                    smallint     = null,
@t_trn                    smallint     = null,
@t_debug                  char(1)      = 'N',
@t_file                   varchar(14)  = null,
@t_from                   varchar(32)  = null,
@i_operacion              char(1),
@i_mnemonico_prod         catalogo,
@i_mnemonico_tasa         catalogo     = null,
@i_tipo_monto             catalogo     = null,
@i_tipo_plazo             catalogo     = null, 
@i_spread_max             float        = null,
@i_spread_min             float        = null,
@i_spread_vigente         float        = null,
@i_operador               char(1)      = null,
@i_moneda                 int          = null,
@i_modo                   smallint     = 0,
@i_tipo                   char(1)      = 'N',
@i_plazo                  int          = null,
@i_momento                varchar(10)  = null,
@i_prorroga               varchar(10)  = null,
@i_segmento               varchar(10)  = null,
@i_ivc                    varchar(10)  = null,
@i_monto                  money        = null,
@i_batch                  char(1)      = 'N',
@i_tasa_max               float        = null,
@i_tasa_min               float        = null,
@i_flag_tipo_deposito     char(1)      = 'N',
@i_modifica               char(1)      = 'N',
@i_id                     int          = 0,
@i_tipo_pago              varchar(10)  = null,
@o_operador               char(1)      = '+'  out,
@o_spread_vigente         float        = 0    out,
@o_tasa_max               float        = 0    out,
@o_tasa_min               float        = 0    out)
with encryption
as
declare
@w_return                 int,
@w_sp_name                varchar(30),
@w_codigo                 int,
@w_tipo_plazo             varchar(5),
@w_tipo_deposito          int,        
@w_tipo_monto             varchar(5), 
@w_operador               char(1),    
@w_spread_vigente         float,      
@w_siguiente_hist         int,
@w_tv_spread_min          float,     
@w_tv_spread_max          float,     
@w_tv_spread_vigente      float,     
@w_tv_fecha_mod           datetime,  
@v_tv_spread_min          float,     
@v_tv_spread_max          float,     
@v_tv_spread_vigente      float,     
@v_tv_fecha_mod           datetime,  
@w_tv_tasa_min            float,     
@w_tv_tasa_max            float,     
@v_tv_tasa_min            float,     
@v_tv_tasa_max            float,     
@w_pl_mnemonico_min       catalogo,
@w_pl_mnemonico_max       catalogo,
@w_hv_spread_vigente      float,
@w_hv_spread_max          float,     
@w_hv_spread_min          float,     
@w_hv_tasa_min            float,     
@w_hv_tasa_max            float,     
@w_hv_operador            char(1),   
@w_hv_usuario             login,     
@v_hv_spread_vigente      float,     
@v_hv_spread_max          float,     
@v_hv_spread_min          float,     
@v_hv_tasa_min            float,     
@v_hv_tasa_max            float,     
@v_hv_operador            char(1),   
@v_hv_usuario             login,     
@w_hv_spread_min_ant      float,
@w_hv_spread_max_ant      float,      
@w_hv_spread_vigente_ant  float,  
@w_hv_tasa_min_ant        float,      
@w_hv_tasa_max_ant        float,      
@w_hv_usuario_ant         login,      
@w_plazo_min              smallint,
@w_plazo_max              smallint

select @w_sp_name ='sp_tasa_variable'

if (@t_trn <> 14148 and @i_operacion = 'I') or (@t_trn <> 14237 and @i_operacion = 'U') or
   (@t_trn <> 14317 and @i_operacion = 'D') or (@t_trn <> 14415 and @i_operacion = 'Q') or
   (@t_trn <> 14518 and @i_operacion = 'S') or (@t_trn <> 14615 and @i_operacion = 'H') begin
   exec cobis..sp_cerror
   @t_debug = @t_debug,
   @t_file  = @t_file,
   @t_from  = @w_sp_name,
   @i_num   = 141040
   return 1
end    

if @i_operacion = 'I' begin

   select @w_codigo = null
   from   pf_tasa_variable
   where  tv_mnemonico_prod = @i_mnemonico_prod 
   and    tv_moneda         = @i_moneda
   and    tv_tipo_plazo     = @i_tipo_plazo
   and    tv_tipo_monto     = @i_tipo_monto
   and    tv_momento        = @i_momento
   and   (tv_prorroga       = @i_prorroga or @i_prorroga is null)
   and   (tv_segmento       = @i_segmento or @i_segmento is null)
   and   (tv_ivc            = @i_ivc      or @i_ivc      is null)
   
   if @@rowcount <> 0 begin
      exec cobis..sp_cerror
      @t_debug  = @t_debug,
      @t_file   = @t_file,
      @t_from   = @w_sp_name,
      @i_num    = 141074
      return 1
   end

   begin tran

   insert pf_tasa_variable(
   tv_mnemonico_prod, tv_mnemonico_tasa,   tv_tipo_monto,     tv_tipo_plazo, 
   tv_spread_max,     tv_spread_min,       tv_spread_vigente, tv_moneda,           
   tv_estado,         tv_fecha_crea,       tv_fecha_mod,      tv_operador, 
   tv_tasa_min,       tv_tasa_max,         tv_usuario,        tv_segmento,
   tv_ivc,            tv_prorroga,         tv_momento)   
   values(
   @i_mnemonico_prod, @i_mnemonico_tasa,   @i_tipo_monto,     @i_tipo_plazo, 
   @i_spread_max,     @i_spread_min,       @i_spread_vigente, @i_moneda, 
   'I',               @s_date,             @s_date,           @i_operador, 
   @i_tasa_min,       @i_tasa_max,         @s_user,           @i_segmento,
   @i_ivc,            @i_prorroga,         @i_momento)

   if @@error <> 0 begin
      exec cobis..sp_cerror
      @t_debug  = @t_debug,
      @t_file   = @t_file,
      @t_from   = @w_sp_name,
      @i_num   = 143047
      return 1
   end
   
   exec @w_return = cobis..sp_cseqnos
   @t_debug       = @t_debug,
   @t_file        = @t_file,
   @t_from        = @w_sp_name,
   @i_tabla       = 'pf_hist_tasa_variable',
   @o_siguiente   = @w_siguiente_hist out

   insert pf_hist_tasa_variable (
   hv_secuencial,         hv_moneda,             hv_tipo_monto,      hv_tipo_plazo,     
   hv_spread_min,         hv_spread_max,         hv_spread_vigente,  hv_spread_min_ant,             
   hv_spread_max_ant,     hv_spread_vigente_ant, hv_estado,          hv_operador,       
   hv_fecha_crea,         hv_mnemonico_prod,     hv_mnemonico_tasa,  hv_tasa_min,       
   hv_tasa_max,           hv_tasa_min_ant,       hv_tasa_max_ant,    hv_usuario,        
   hv_usuario_ant,        hv_segmento,           hv_ivc,             hv_prorroga,
   hv_momento)
   values(
   @w_siguiente_hist,     @i_moneda,             @i_tipo_monto,      @i_tipo_plazo,  
   @i_spread_min,         @i_spread_max,         @i_spread_vigente,  null,                         
   null,                  null,                  'V',                @i_operador,        
   @s_date,               @i_mnemonico_prod,     @i_mnemonico_tasa,  @i_tasa_min,           
   @i_tasa_max,           null,                  null,               @s_user,                       
   null,                  @i_segmento,           @i_ivc,             @i_prorroga,
   @i_momento)

   if @@error <> 0 begin
      exec cobis..sp_cerror
      @t_debug  = @t_debug,
      @t_file   = @t_file,
      @t_from   = @w_sp_name,
      @i_num    = 143058
      return 1
   end
   
   insert into ts_hist_tasa_variable(
   secuencial,            tipo_transaccion,        clase,               fecha,                 
   usuario,               terminal,                srv,                 lsrv,                       
   secuencial_historico,  mnemonico_prod,          moneda,              tipo_monto,
   tipo_plazo,            spread_min,              spread_max,          spread_vigente,           
   spread_min_ant,        spread_max_ant,          spread_vigente_ant,  estado,                               
   operador,              mnemonico_tasa,          fecha_creacion,      tasa_min,
   tasa_max,              tasa_min_ant,            tasa_max_ant,        usuario_ant,
   momento,               prorroga,                segmento,            ivc)
   values(
   @s_ssn,                14161,                   'N',                 @s_date,                      
   @s_user,               @s_term,                 @s_srv,              @s_lsrv,    
   @w_siguiente_hist,     @i_mnemonico_prod,       @i_moneda,           @i_tipo_monto,
   @i_tipo_plazo,         @i_spread_min,           @i_spread_max,       @i_spread_vigente,      
   null,                  null,                    null,                'V',                                  
   @i_operador,           @i_mnemonico_tasa,       @s_date,             @i_tasa_min,
   @i_tasa_max,           null,                    null,                null,
   @i_momento,            @i_prorroga,             @i_segmento,         @i_ivc)        

   if @@error <> 0 begin
      exec cobis..sp_cerror
      @t_debug  = @t_debug,
      @t_file   = @t_file,
      @t_from   = @w_sp_name,
      @i_num    = 143005
      return 1
   end 
   commit tran    
end

if @i_operacion = 'U' begin
   select
   @w_tv_spread_min        = tv_spread_min,
   @w_tv_spread_max        = tv_spread_max,
   @w_tv_spread_vigente    = tv_spread_vigente,
   @w_tv_fecha_mod         = isnull(tv_fecha_mod,tv_fecha_crea),
   @w_tv_tasa_min          = tv_tasa_min,
   @w_tv_tasa_max          = tv_tasa_max,
   @w_hv_usuario_ant       = tv_usuario
   from  pf_tasa_variable       
   where tv_mnemonico_prod = @i_mnemonico_prod
   and   tv_mnemonico_tasa = @i_mnemonico_tasa
   and   tv_moneda         = @i_moneda
   and   tv_tipo_monto     = @i_tipo_monto
   and   tv_tipo_plazo     = @i_tipo_plazo  
   and   tv_estado         = 'I'
   and   tv_momento        = @i_momento
   and  (tv_prorroga       = @i_prorroga or @i_prorroga is null)
   and  (tv_segmento       = @i_segmento or @i_segmento is null)
   and  (tv_ivc            = @i_ivc      or @i_ivc      is null)

   if @@rowcount = 0 begin
      exec cobis..sp_cerror
      @t_debug  = @t_debug,
      @t_file   = @t_file,
      @t_from   = @w_sp_name,
      @i_num    = 141159
      return 1    
   end
   
   select
   @v_tv_spread_min         = @w_tv_spread_min,
   @v_tv_spread_max         = @w_tv_spread_max,
   @v_tv_spread_vigente     = @w_tv_spread_vigente,
   @v_tv_fecha_mod          = @w_tv_fecha_mod,
   @v_tv_tasa_min           = @w_tv_tasa_min,
   @v_tv_tasa_max           = @w_tv_tasa_max,
   @w_hv_spread_min_ant     = @w_tv_spread_min,
   @w_hv_spread_max_ant     = @w_tv_spread_max,
   @w_hv_spread_vigente_ant = @w_tv_spread_vigente,
   @w_hv_tasa_min_ant       = @w_tv_tasa_min,
   @w_hv_tasa_max_ant       = @w_tv_tasa_max
        
   if @w_tv_spread_min = @i_spread_min
      select @w_tv_spread_min = null, @v_tv_spread_min = null
   else
      select @w_tv_spread_min = @i_spread_min
     
   if @w_tv_spread_max = @i_spread_max
      select @w_tv_spread_max = null, @v_tv_spread_max = null
   else
      select @w_tv_spread_max = @i_spread_max

   if @w_tv_spread_vigente = @i_spread_vigente
      select @w_tv_spread_vigente = null, @v_tv_spread_vigente = null
   else
      select @w_tv_spread_vigente = @i_spread_vigente

   if @w_tv_fecha_mod = @s_date
      select @w_tv_fecha_mod = null, @v_tv_fecha_mod = null
   else
      select @w_tv_fecha_mod = @s_date

   if @w_tv_tasa_min = @i_tasa_min
      select @w_tv_tasa_min = null, @v_tv_tasa_min = null
   else
      select @w_tv_tasa_min = @i_tasa_min

   if @w_tv_tasa_max = @i_tasa_max
      select @w_tv_tasa_max = null, @v_tv_tasa_max = null
   else
      select @w_tv_tasa_max = @i_tasa_max

   begin tran

   update pf_tasa_variable
   set    tv_spread_max     = @i_spread_max,
          tv_spread_min     = @i_spread_min,
          tv_spread_vigente = @i_spread_vigente,
          tv_operador       = @i_operador,
          tv_moneda         = @i_moneda,
          tv_tipo_monto     = @i_tipo_monto,
          tv_tipo_plazo     = @i_tipo_plazo,
          tv_fecha_mod      = @s_date,
          tv_tasa_min       = @i_tasa_min,
          tv_tasa_max       = @i_tasa_max,
          tv_usuario        = @s_user
   where  tv_mnemonico_prod = @i_mnemonico_prod
   and    tv_mnemonico_tasa = @i_mnemonico_tasa
   and    tv_moneda         = @i_moneda
   and    tv_tipo_monto     = @i_tipo_monto
   and    tv_tipo_plazo     = @i_tipo_plazo
   and    tv_momento        = @i_momento
   and   (tv_prorroga       = @i_prorroga or @i_prorroga is null)
   and   (tv_segmento       = @i_segmento or @i_segmento is null)
   and   (tv_ivc            = @i_ivc      or @i_ivc      is null)
   and    tv_estado         = 'I'
      
   if @@error <> 0 begin
      exec cobis..sp_cerror
      @t_debug  = @t_debug,
      @t_file   = @t_file,
      @t_from   = @w_sp_name,
      @i_num   = 145010
      return 1    
   end
   
   if @v_tv_fecha_mod is null begin
      select
	  @w_siguiente_hist        = hv_secuencial,
      @w_hv_spread_vigente     = hv_spread_vigente,
      @w_hv_spread_max         = hv_spread_max,
      @w_hv_spread_min         = hv_spread_min,
      @w_hv_tasa_min           = hv_tasa_min,
      @w_hv_tasa_max           = hv_tasa_max,
      @w_hv_operador           = hv_operador,
      @w_hv_usuario            = hv_usuario
      from  pf_hist_tasa_variable
      where hv_mnemonico_prod  = @i_mnemonico_prod
      and   hv_mnemonico_tasa  = @i_mnemonico_tasa
      and   hv_moneda          = @i_moneda 
      and   hv_tipo_plazo      = @i_tipo_plazo
      and   hv_tipo_monto      = @i_tipo_monto
      and   hv_fecha_crea      = @s_date
      and   hv_momento         = @i_momento
      and  (hv_prorroga        = @i_prorroga or @i_prorroga is null)
      and  (hv_segmento        = @i_segmento or @i_segmento is null)
      and  (hv_ivc             = @i_ivc      or @i_ivc      is null)
	  
	  select
	  @v_hv_spread_vigente     = @w_hv_spread_vigente,
      @v_hv_spread_max         = @w_hv_spread_max,
      @v_hv_spread_min         = @w_hv_spread_min,
      @v_hv_tasa_min           = @w_hv_tasa_min,
      @v_hv_tasa_max           = @w_hv_tasa_max,
      @v_hv_operador           = @w_hv_operador,
      @v_hv_usuario            = @w_hv_usuario

      if @w_hv_spread_vigente = @i_spread_vigente
         select @w_hv_spread_vigente = null, @v_hv_spread_vigente = null
      else
         select @w_hv_spread_vigente = @i_spread_vigente

      if @w_hv_spread_max = @i_spread_max
         select @w_hv_spread_max = null, @v_hv_spread_max = null
      else
         select @w_hv_spread_max = @i_spread_max

      if @w_hv_spread_min = @i_spread_min
         select @w_hv_spread_min = null, @v_hv_spread_min = null
      else
         select @w_hv_spread_min = @i_spread_min

      if @w_hv_tasa_min = @i_tasa_min
         select @w_hv_tasa_min = null, @v_hv_tasa_min = null
      else
         select @w_hv_tasa_min = @i_tasa_min

      if @w_hv_tasa_max = @i_tasa_max
         select @w_hv_tasa_max = null, @v_hv_tasa_max = null
      else
         select @w_hv_tasa_max = @i_tasa_max

      if @w_hv_operador = @i_operador
         select @w_hv_operador = null, @v_hv_operador = null
      else
         select @w_hv_operador = @i_operador

      if @w_hv_usuario = @s_user
         select @w_hv_usuario = null, @v_hv_usuario = null
      else
         select @w_hv_usuario = @s_user

      update pf_hist_tasa_variable
      set    hv_spread_vigente = @i_spread_vigente,
             hv_spread_max     = @i_spread_max,
             hv_spread_min     = @i_spread_min,
             hv_tasa_min       = @i_tasa_min,
             hv_tasa_max       = @i_tasa_max,
             hv_operador       = @i_operador
      where  hv_secuencial     = @w_siguiente_hist
      
	  if @@error <> 0 begin
         exec cobis..sp_cerror
         @t_debug        = @t_debug,
         @t_file         = @t_file,
         @t_from         = @w_sp_name,
         @i_num          = 145051
         return 1
      end
	  
	  insert into ts_hist_tasa_variable(
      secuencial,                   tipo_transaccion,                     clase,
      fecha,                        usuario,                              terminal,
      srv,                          lsrv,                                 secuencial_historico,
      mnemonico_prod,               moneda,                               tipo_monto,
      tipo_plazo,                   spread_min,                           spread_max,
      spread_vigente,               spread_min_ant,                       spread_max_ant,
      spread_vigente_ant,           estado,                               operador,
      mnemonico_tasa,               fecha_creacion,                       tasa_min,
      tasa_max,                     tasa_min_ant,                         tasa_max_ant,
      usuario_ant,                  segmento,                             ivc,
	  prorroga,                     momento)
      values(
	  @s_ssn,                       14243,                                'P',
      @s_date,                      @s_user,                              @s_term,
      @s_srv,                       @s_lsrv,                              @w_siguiente_hist,
      @i_mnemonico_prod,            @i_moneda,                            @i_tipo_monto,
      @i_tipo_plazo,                @v_hv_spread_min,                     @v_hv_spread_max,
      @v_hv_spread_vigente,         null,                                 null,
      null,                         'V',                                  @v_hv_operador,
      @i_mnemonico_tasa,            @s_date,                              @v_hv_tasa_min,
      @v_hv_tasa_max,               null,                                 null,
      null,                         @i_segmento,                          @i_ivc,
	  @i_prorroga,                  @i_momento)

	  if @@error <> 0 begin
         exec cobis..sp_cerror
         @t_debug        = @t_debug,
         @t_file         = @t_file,
         @t_from         = @w_sp_name,
         @i_num          = 143005
         return 1
      end 

	  insert into ts_hist_tasa_variable(
      secuencial,                   tipo_transaccion,                     clase,
      fecha,                        usuario,                              terminal,
      srv,                          lsrv,                                 secuencial_historico,
      mnemonico_prod,               moneda,                               tipo_monto,
      tipo_plazo,                   spread_min,                           spread_max,
      spread_vigente,               spread_min_ant,                       spread_max_ant,
      spread_vigente_ant,           estado,                               operador,
      mnemonico_tasa,               fecha_creacion,                       tasa_min,
      tasa_max,                     tasa_min_ant,                         tasa_max_ant,
      usuario_ant,                  segmento,                             ivc,
	  prorroga,                     momento)
      values(
      @s_ssn,                       14243,                                'A',
      @s_date,                      @s_user,                              @s_term,
      @s_srv,                       @s_lsrv,                              @w_siguiente_hist,
      @i_mnemonico_prod,            @i_moneda,                            @i_tipo_monto,
      @i_tipo_plazo,                @w_hv_spread_min,                     @w_hv_spread_max,
      @w_hv_spread_vigente,         null,                                 null,
      null,                         'V',                                  @w_hv_operador,
      @i_mnemonico_tasa,            @s_date,                              @w_hv_tasa_min,
      @w_hv_tasa_max,               null,                                 null,
      null,                         @i_segmento,                          @i_ivc,
	  @i_prorroga,                  @i_momento)   
           
	  if @@error <> 0 begin
         exec cobis..sp_cerror
         @t_debug        = @t_debug,
         @t_file         = @t_file,
         @t_from         = @w_sp_name,
         @i_num          = 143005
         return 1
      end 
   end
   else begin
   
      exec @w_return = cobis..sp_cseqnos
      @t_debug       = @t_debug,
      @t_file        = @t_file,
      @t_from        = @w_sp_name,
      @i_tabla       = 'pf_hist_tasa_variable',
      @o_siguiente   = @w_siguiente_hist out

      insert into pf_hist_tasa_variable(
      hv_secuencial,              hv_moneda,              hv_tipo_monto,
      hv_tipo_plazo,              hv_spread_min,          hv_spread_max,
      hv_spread_vigente,          hv_spread_min_ant,      hv_spread_max_ant,
      hv_spread_vigente_ant,      hv_estado,              hv_operador,
      hv_fecha_crea,              hv_mnemonico_prod,      hv_mnemonico_tasa,
      hv_tasa_min,                hv_tasa_max,            hv_tasa_min_ant,
      hv_tasa_max_ant,            hv_usuario,             hv_usuario_ant,
      hv_fecha_crea_ant,          hv_segmento,            hv_ivc,
      hv_prorroga,                hv_momento)
      values(
      @w_siguiente_hist,          @i_moneda,              @i_tipo_monto,
      @i_tipo_plazo,              @i_spread_min,          @i_spread_max,
      @i_spread_vigente,          @w_hv_spread_min_ant,   @w_hv_spread_max_ant,
      @w_hv_spread_vigente_ant,   'V',                    @i_operador,
      @s_date,                    @i_mnemonico_prod,      @i_mnemonico_tasa,
      @i_tasa_min,                @i_tasa_max,            @w_hv_tasa_min_ant,
      @w_hv_tasa_max_ant,         @s_user,                @w_hv_usuario_ant,
      @w_tv_fecha_mod,            @i_segmento,            @i_ivc,
	  @i_prorroga,                @i_momento)

	  if @@error <> 0 begin
         exec cobis..sp_cerror
         @t_debug        = @t_debug,
         @t_file         = @t_file,
         @t_from         = @w_sp_name,
         @i_num          = 143058
         return 1
      end
	  
	  insert into ts_hist_tasa_variable(
      secuencial,                   tipo_transaccion,                     clase,
      fecha,                        usuario,                              terminal,
      srv,                          lsrv,                                 secuencial_historico,
      mnemonico_prod,               moneda,                               tipo_monto,
      tipo_plazo,                   spread_min,                           spread_max,
      spread_vigente,               spread_min_ant,                       spread_max_ant,
      spread_vigente_ant,           estado,                               operador,
      mnemonico_tasa,               fecha_creacion,                       tasa_min,
      tasa_max,                     tasa_min_ant,                         tasa_max_ant,
      usuario_ant,                  segmento,                             ivc,
	  prorroga,                     momento)
      values(
      @s_ssn,                       14161,                                'N',
      @s_date,                      @s_user,                              @s_term,
      @s_srv,                       @s_lsrv,                              @w_siguiente_hist,
      @i_mnemonico_prod,            @i_moneda,                            @i_tipo_monto,
      @i_tipo_plazo,                @i_spread_min,                        @i_spread_max,
      @i_spread_vigente,            @w_hv_spread_min_ant,                 @w_hv_spread_max_ant,
      @w_hv_spread_vigente_ant,     'V',                                  @i_operador,
      @i_mnemonico_tasa,            @s_date,                              @i_tasa_min,
      @i_tasa_max,                  @w_hv_tasa_min_ant,                   @w_hv_tasa_max_ant,
      @w_hv_usuario_ant,            @i_segmento,                          @i_ivc,
	  @i_prorroga,                  @i_momento)  
   end
   commit tran
end

if @i_operacion = 'D' begin

   select @w_codigo = null
   from   pf_tasa_variable
   where  tv_mnemonico_prod = @i_mnemonico_prod
   and    tv_mnemonico_tasa = @i_mnemonico_tasa
   and    tv_moneda         = @i_moneda
   and    tv_tipo_monto     = @i_tipo_monto
   and    tv_tipo_plazo     = @i_tipo_plazo
   and    tv_momento        = @i_momento
   and   (tv_prorroga       = @i_prorroga or @i_prorroga is null)
   and   (tv_segmento       = @i_segmento or @i_segmento is null)
   and   (tv_ivc            = @i_ivc      or @i_ivc      is null)
   and    tv_estado         = 'I'

   if @@rowcount = 0 begin
      exec cobis..sp_cerror
      @t_debug  = @t_debug,
      @t_file   = @t_file,
      @t_from   = @w_sp_name,
      @i_num    = 141159
      return 1    
   end
     
   begin tran
   
   delete pf_tasa_variable
   where  tv_mnemonico_prod = @i_mnemonico_prod 
   and    tv_mnemonico_tasa = @i_mnemonico_tasa 
   and    tv_moneda         = @i_moneda         
   and    tv_tipo_monto     = @i_tipo_monto
   and    tv_tipo_plazo     = @i_tipo_plazo
   and    tv_momento        = @i_momento
   and   (tv_prorroga       = @i_prorroga or @i_prorroga is null)
   and   (tv_segmento       = @i_segmento or @i_segmento is null)
   and   (tv_ivc            = @i_ivc      or @i_ivc      is null)
   and    tv_estado         = 'I'

   if @@error <> 0 begin
      exec cobis..sp_cerror
      @t_debug        = @t_debug,
      @t_file         = @t_file,
      @t_from         = @w_sp_name,
      @i_num          = 147010
      return 1    
   end
   
   exec @w_return = cobis..sp_cseqnos
   @t_debug       = @t_debug,
   @t_file        = @t_file,
   @t_from        = @w_sp_name,
   @i_tabla       = 'pf_hist_tasa_variable',
   @o_siguiente   = @w_siguiente_hist out

   update pf_hist_tasa_variable
   set    hv_estado = 'E'
   where  hv_mnemonico_prod = @i_mnemonico_prod
   and    hv_mnemonico_tasa = @i_mnemonico_tasa 
   and    hv_moneda         = @i_moneda 
   and    hv_tipo_plazo     = @i_tipo_plazo
   and    hv_tipo_monto     = @i_tipo_monto
   and    hv_momento        = @i_momento
   and   (hv_prorroga       = @i_prorroga or @i_prorroga is null)
   and   (hv_segmento       = @i_segmento or @i_segmento is null)
   and   (hv_ivc            = @i_ivc      or @i_ivc      is null)

   if @@error <> 0 begin
      exec cobis..sp_cerror
      @t_debug        = @t_debug,
      @t_file         = @t_file,
      @t_from         = @w_sp_name,
      @i_num          = 145051
      return 1
   end
   
   insert into ts_hist_tasa_variable(
   secuencial,                   tipo_transaccion,                     clase,
   fecha,                        usuario,                              terminal,
   srv,                          lsrv,                                 secuencial_historico,
   mnemonico_prod,               moneda,                               tipo_monto,
   tipo_plazo,                   spread_min,                           spread_max,
   spread_vigente,               spread_min_ant,                       spread_max_ant,
   spread_vigente_ant,           estado,                               operador,
   mnemonico_tasa,               fecha_creacion,                       tasa_min,
   tasa_max,                     tasa_min_ant,                         tasa_max_ant,
   usuario_ant,                  segmento,                             ivc,
   prorroga,                     momento)
   values(
   @s_ssn,                       14243,                                'B',
   @s_date,                      @s_user,                              @s_term,
   @s_srv,                       @s_lsrv,                              @w_siguiente_hist,
   @i_mnemonico_prod,            @i_moneda,                            @i_tipo_monto,
   @i_tipo_plazo,                null,                                 null,
   null,                         null,                                 null,
   null,                         'E',                                  null,
   @i_mnemonico_tasa,            @s_date,                              null,
   null,                         null,                                 null,
   null,                         @i_segmento,                          @i_ivc,
   @i_prorroga,                  @i_momento)
   
   if @@error <> 0 begin
      exec cobis..sp_cerror
      @t_debug        = @t_debug,
      @t_file         = @t_file,
      @t_from         = @w_sp_name,
      @i_num          = 143005
      return 1
   end 
   commit tran
end

if @i_operacion in ('Q','H') begin
   if @i_mnemonico_prod is not null begin
      select @w_tipo_deposito = td_tipo_deposito
      from   pf_tipo_deposito
      where  td_mnemonico = @i_mnemonico_prod
      and  ((td_estado    = 'A' and @i_flag_tipo_deposito = 'S') or @i_flag_tipo_deposito = 'N')

      if @@rowcount = 0 begin
         exec cobis..sp_cerror
         @t_debug        = @t_debug,
         @t_file         = @t_file,
         @t_from         = @w_sp_name,
         @i_num          = 141115
         return 141115
      end
   end
   
   select @w_tipo_monto    = mo_mnemonico
   from   pf_monto, pf_auxiliar_tip
   where  @i_monto        >= mo_monto_min
   and    @i_monto        <= mo_monto_max
   and    mo_mnemonico     = at_valor
   and    at_tipo          = 'MOT'
   and    at_tipo_deposito = @w_tipo_deposito
   and    at_moneda        = @i_moneda
   and    at_estado        = 'A'

   if @@rowcount = 0 begin
      exec cobis..sp_cerror
      @t_debug        = @t_debug,
      @t_file         = @t_file,
      @t_from         = @w_sp_name,
      @i_num          = 141053
      return 141053
   end

   select @w_tipo_plazo    = pl_mnemonico
   from   pf_plazo, pf_auxiliar_tip
   where  @i_plazo        >= pl_plazo_min
   and    @i_plazo        <= pl_plazo_max
   and    pl_mnemonico     = at_valor 
   and    at_tipo          = 'PLA'
   and    at_tipo_deposito = @w_tipo_deposito
   and    at_moneda        = @i_moneda
   and    at_estado        = 'A'

   if @@rowcount = 0 begin
      exec cobis..sp_cerror
      @t_debug        = @t_debug,
      @t_file         = @t_file,
      @t_from         = @w_sp_name,
      @i_num          = 141054
      return 141054
   end
   
   if @i_momento = 'P' begin
      select @w_tipo_plazo    = rp_mnemonico
      from   pf_rango_prorroga, pf_auxiliar_tip
      where  @i_prorroga     >= rp_prorroga_min
      and    @i_prorroga     <= rp_prorroga_max
      and    rp_descripcion   = at_valor 
      and    at_tipo          = 'PRO'
      and    at_tipo_deposito = @w_tipo_deposito
      and    at_moneda        = @i_moneda
      and    at_estado        = 'A'
      
      if @@rowcount = 0 begin
         exec cobis..sp_cerror
         @t_debug        = @t_debug,
         @t_file         = @t_file,
         @t_from         = @w_sp_name,
         @i_num          = 148003
         return 148003
      end
   end
end

if @i_operacion = 'Q' begin
   if @i_batch = 'N' begin
      select
	  'DESC MONEDA' = mo_descripcion,
      'TASA REF'    = tv_mnemonico_tasa,
      'SPREAD MIN'  = tv_spread_min,
      'SPREAD MAX'  = tv_spread_max,
      'SPREAD'      = tv_spread_vigente,
      'MONEDA'      = tv_moneda,
      'DESC TASA'   = null,
      'OPERADOR'    = tv_operador,
      'TASA MIN'    = tv_tasa_min,
      'TASA MAX'    = tv_tasa_max
      from  cob_pfijo..pf_tasa_variable, cobis..cl_moneda
	  where tv_mnemonico_prod = @i_mnemonico_prod
      and   tv_moneda         = @i_moneda 
      and   tv_moneda         = mo_moneda        
      and   tv_estado         = 'I'
      and   tv_tipo_monto     = @w_tipo_monto 
      and   tv_tipo_plazo     = @w_tipo_plazo
      --and   tv_momento        = @i_momento
      and  (tv_momento        = @i_momento  or @i_momento  is null)
      and  (tv_prorroga       = @i_prorroga or @i_prorroga is null)
      and  (tv_segmento       = @i_segmento or @i_segmento is null)
      and  (tv_ivc            = @i_ivc      or @i_ivc      is null)
   end
   else begin
      select
	  @w_spread_vigente       = tv_spread_vigente,
      @w_operador             = tv_operador,
      @w_tv_tasa_max          = tv_tasa_max,
      @w_tv_tasa_min          = tv_tasa_min
      from  cob_pfijo..pf_tasa_variable
      where tv_mnemonico_prod = @i_mnemonico_prod
      and   tv_moneda         = @i_moneda 
      and   tv_estado         = 'I'
      and   tv_tipo_monto     = @w_tipo_monto 
      and   tv_tipo_plazo     = @w_tipo_plazo
      --and   tv_momento        = @i_momento
	  and  (tv_momento        = @i_momento  or @i_momento  is null)
      and  (tv_prorroga       = @i_prorroga or @i_prorroga is null)
      and  (tv_segmento       = @i_segmento or @i_segmento is null)
      and  (tv_ivc            = @i_ivc      or @i_ivc      is null)
   end

   if @@rowcount <> 1 begin
      exec cobis..sp_cerror
      @t_debug  = @t_debug,
      @t_file   = @t_file,
      @t_from   = @w_sp_name,
      @i_num    = 141055
      return 141055
   end

   select
   @o_operador       = @w_operador, 
   @o_spread_vigente = @w_spread_vigente,
   @o_tasa_max       = @w_tv_tasa_max,    
   @o_tasa_min       = @w_tv_tasa_min 
   return 0
end


if @i_operacion = 'S' begin

   create table #tasa(
   id                 int            identity,
   tv_mnemonico_tasa  varchar(10)    null,
   tv_moneda          tinyint        null,
   tv_tipo_monto      varchar(10)    null,
   tv_momento         varchar(10)    null,
   tv_prorroga        varchar(10)    null,
   tv_tipo_plazo      varchar(10)    null,
   tv_spread_min      float          null,
   tv_spread_max      float          null,
   tv_spread_vigente  float          null,
   tv_operador        char(1)        null,
   mo_descripcion     varchar(64)    null,
   tv_tasa_min        float          null,
   tv_tasa_max        float          null,
   tv_tipo_pago       varchar(10)    null,
   tv_segmento        varchar(10)    null,
   tv_ivc             varchar(10)    null)

   insert into #tasa
   select
   tv_mnemonico_tasa,
   tv_moneda,
   tv_tipo_monto,
   tv_momento,
   tv_prorroga,
   tv_tipo_plazo,
   tv_spread_min,
   tv_spread_max,
   tv_spread_vigente,
   tv_operador,
   mo_descripcion,
   tv_tasa_min,
   tv_tasa_max,
   tv_tipo_pago,
   tv_segmento,
   tv_ivc
   from  cob_pfijo..pf_tasa_variable, cobis..cl_moneda
   where tv_mnemonico_prod = @i_mnemonico_prod
   and   tv_moneda         = mo_moneda
   order by tv_moneda, tv_mnemonico_prod, tv_mnemonico_tasa, tv_tipo_monto, tv_tipo_plazo, tv_tipo_pago 
   
   set rowcount 20

   select
   'TASA REF'   = tv_mnemonico_tasa,
   'MONEDA'     = tv_moneda,
   'MONTO'      = tv_tipo_monto,
   'MOMENTO'    = tv_momento,
   'PRORROGA'   = tv_prorroga,
   'PLAZO'      = tv_tipo_plazo,
   'SPREAD MIN' = tv_spread_min,
   'SPREAD MAX' = tv_spread_max,
   'SPREAD'     = tv_spread_vigente,
   'OPERADOR'   = tv_operador,
   'DESC MONEDA'= mo_descripcion,
   'TASA MIN'   = tv_tasa_min,
   'TASA MAX'   = tv_tasa_max,
   'ID'         = id,
   'PER PAGO'   = tv_tipo_pago,
   'SEGMENTO'   = tv_segmento,
   'IVC'        = tv_ivc
   from #tasa
   where id > @i_id
   order by id

   drop table #tasa
   return 0
end

if @i_operacion = 'H' begin
   set rowcount 20      
   select
   'TIPO TASA '             = tv_mnemonico_tasa, 
   'SPREAD MIN'             = tv_spread_min,
   'SPREAD MAX'             = tv_spread_max, 
   'SPREAD VIG'             = tv_spread_vigente,
   'OPERADOR'               = tv_operador,
   'DESC TASA'              = null,
   'TASA MIN'               = tv_tasa_min,
   'TASA MAX'               = tv_tasa_max
   from  cob_pfijo..pf_tasa_variable, cobis..cl_moneda
   where tv_mnemonico_prod  = @i_mnemonico_prod
   and   tv_moneda          = mo_moneda
   and   tv_moneda          = @i_moneda
   and   (tv_mnemonico_tasa = @i_mnemonico_tasa or @i_tipo = 'A')
   and   tv_estado          = 'I'
   and   tv_tipo_monto      = @w_tipo_monto
   and   tv_tipo_plazo      = @w_tipo_plazo
   and   tv_momento         = @i_momento
   and  (tv_prorroga        = @i_prorroga or @i_prorroga is null)
   and  (tv_segmento        = @i_segmento or @i_segmento is null)
   and  (tv_ivc             = @i_ivc      or @i_ivc      is null)
    
   if @@rowcount = 0 begin
      exec cobis..sp_cerror
      @t_debug  = @t_debug,
      @t_file   = @t_file,
      @t_from   = @w_sp_name,
      @i_num    = 141155
      return 1
   end  
end


return 0
go
