/************************************************************************/
/*  Archivo               : tasa.sp                                     */
/*  Stored procedure      : sp_tasa                                     */
/*  Base de datos         : cob_pfijo                                   */
/*  Producto              : Plazo_fijo                                  */
/*  Disenado por          : Miryam Davila                               */
/*  Fecha de documentacion: 24/Oct/94                                   */
/************************************************************************/
/*                          IMPORTANTE                                  */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  'MACOSA', representantes exclusivos para el Ecuador de la           */
/*  'NCR CORPORATION'.                                                  */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier alteracion o agregado hecho por alguno de sus             */
/*  usuarios sin el debido consentimiento por escrito de la             */
/*  Presidencia Ejecutiva de MACOSA o su representante.                 */
/*                          PROPOSITO                                   */
/*  Este programa procesa el mantenimiento de la tabla pf_tasa          */
/*  Insercion de tasa                                                   */
/*  Actualizacion de tasa                                               */
/*  Eliminacion de tasa                                                 */
/*  Search de la tabla pf_tasa                                          */
/*  Query sobre pf_tasa                                                 */
/*  Help a la tabla pf_tasa                                             */
/************************************************************************/
/*                      MODIFICACIONES                                  */
/*  FECHA           AUTOR           RAZON                               */
/*  24/Oct/1994     R. Serrano      Emision Inicial                     */
/*  21/Ago/1995     C. Alvarado     Ingreso - Tipo/Deposito             */
/*  13/Jun/2016     N. Silva        Porting DAVIVIENDA                  */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS ON
go

SET QUOTED_IDENTIFIER ON
go

if exists (select 1 from sysobjects where name = 'sp_tasa')
   drop proc sp_tasa
go


create proc sp_tasa (
        @s_ssn                  int         = null,
        @s_user                 login       = null,
        @s_term                 varchar(30) = null,
        @s_date                 datetime    = null,
        @s_srv                  varchar(30) = null,
        @s_lsrv                 varchar(30) = null,
        @s_ofi                  smallint    = null,
        @s_rol                  smallint    = null,
        @t_debug                char(1)     = 'N',
        @t_file                 varchar(10) = null,
        @t_from                 varchar(32) = null,
        @t_trn                  int         = null,
        @i_operacion            char(1),
        @i_tipo_deposito        varchar(6),
        @i_tipo_monto           varchar(10) = null, 
        @i_tipo_plazo           varchar(10) = null,
        @i_moneda               tinyint     = null,
        @i_tasa_min             float       = null,  
        @i_tasa_max             float       = null,
        @i_vigente              float       = null,
        @i_dias                 smallint    = null,
        @i_monto                money       = null,
        @i_modo                 smallint    = 0,
        @i_flag_tipo_deposito   char(1)        = 'N',
        @i_tipo_tasa            char(1)     = 'N',   --Tipo de tasa --(N)ormal --(P)recancelacion --Promerica
        @i_id                   int         = 0
)
with encryption
as
declare @w_sp_name              varchar(32),
        @w_codigo               int,
        @w_return               int,
        @w_tipo_deposito        varchar(6),
        @w_moneda               int,
        @w_tipo_monto           varchar(6),
        @w_tipo_plazo           varchar(6),
        @w_tasa_min             float,
        @w_tasa_max             float,
        @w_vigente              float,
        @w_fecha_crea           datetime,
        @w_fecha_mod            datetime,
        @v_tasa_min             float,
        @v_tasa_max             float,
        @v_vigente              float,
        @v_fecha_crea           datetime,
        @v_fecha_mod            datetime,
        @w_siguiente_hist       int,     --GAR 11-mar-2005 DP00126
        @w_estado               char(1), --GAR 11-mar-2005 DP00126        
        @w_ht_usuario_ant       login,   --GAR --Para el usuario que ingresa o modifica la tasa
        @w_ht_vigente           float,   --GAR 11-mar-2005 DP00126-- Para la actualizaci¢n de la tabla pf_hist_tasa
        @w_ht_tasa_max          float, 
        @w_ht_tasa_min          float,  
        @w_ht_usuario           login,  
        @v_ht_vigente           float,  
        @v_ht_tasa_max          float,  
        @v_ht_tasa_min          float,  
        @v_ht_usuario           login,  
        @w_ht_vigente_ant       float,   -- Para conservar los valores anteriores de la tabla pf_tasa
        @w_ht_tasa_max_ant      float,  
        @w_ht_tasa_min_ant      float,  
        @w_fecha_mod_ant        datetime,  --CVA
        @w_tipo                 char(1),
        @w_msg                  varchar(255)

select @w_sp_name = 'sp_tasa'


if @i_operacion not in ('I','U','D','S','Q','H')
begin
    exec cobis..sp_cerror
       @t_debug    = @t_debug,
       @t_file    = @t_file,
       @t_from    = @w_sp_name,
       @i_num    = 141008
    return 1
end


if (@t_trn <> 14610 and @i_operacion = 'H') or
   (@t_trn <> 14110 and @i_operacion = 'I') or
   (@t_trn <> 14210 and @i_operacion = 'U') or
   (@t_trn <> 14310 and @i_operacion = 'D') or
   (@t_trn <> 14410 and @i_operacion = 'Q') or
   (@t_trn <> 14510 and @i_operacion = 'S')
begin
     exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 141040
     return 1
end



--- Insert ---
if @i_operacion = 'I'
begin
     select @w_codigo = null
     from pf_tipo_deposito
     where td_mnemonico = @i_tipo_deposito
       and ((td_estado = 'A' and @i_flag_tipo_deposito = 'S') or @i_flag_tipo_deposito = 'N')

     if @@rowcount = 0
     begin
        exec cobis..sp_cerror
             @t_debug        = @t_debug,
             @t_file         = @t_file,
             @t_from         = @w_sp_name,
             @i_num          = 141115
        return 1
     end 

     select @w_codigo = null
     from cobis..cl_moneda
     where mo_moneda = @i_moneda

     if @@rowcount = 0
     begin
          exec cobis..sp_cerror
               @t_debug        = @t_debug,
               @t_file         = @t_file,
               @t_from         = @w_sp_name,
               @i_num          = 141013
          return 1
     end

     select @w_codigo = null
     from pf_auxiliar_tip, 
          pf_tipo_deposito
     where at_moneda        = @i_moneda
       and at_tipo_deposito = td_tipo_deposito
       and td_mnemonico     = @i_tipo_deposito
       and at_tipo          = 'MOT'
       and at_valor         = @i_tipo_monto

     if @@rowcount = 0
     begin
          exec cobis..sp_cerror
               @t_debug        = @t_debug,
               @t_file         = @t_file,
               @t_from         = @w_sp_name,
               @i_num          = 141121
          return 1
     end

     select @w_codigo = null
     from pf_auxiliar_tip,  
          pf_tipo_deposito
     where at_moneda        = @i_moneda
       and at_tipo_deposito = td_tipo_deposito
       and td_mnemonico     = @i_tipo_deposito
       and at_tipo          = 'PLA' 
       and at_valor         = @i_tipo_plazo

     if @@rowcount = 0 and @i_tipo_tasa <> 'P'  --tasa (P)recancelacion
     begin
          exec cobis..sp_cerror
               @t_debug        = @t_debug,
               @t_file         = @t_file,
               @t_from         = @w_sp_name,
               @i_num          = 141121
          return 1
     end  

     if exists (select 1 from pf_tasa 
                where ta_tipo_deposito = @i_tipo_deposito
                  and ta_moneda        = @i_moneda
                  and ta_tipo_plazo    = @i_tipo_plazo  
                  and ta_tipo_monto    = @i_tipo_monto  
                  and ta_tipo          = @i_tipo_tasa) 
     begin           
           exec cobis..sp_cerror
                @t_debug        = @t_debug,
                @t_file         = @t_file,
                @t_from         = @w_sp_name,
                @i_num          = 141074 
           return 1    
      end

      begin tran

      insert into pf_tasa   
             (ta_tipo_deposito,  ta_moneda,     ta_tipo_plazo,  ta_tipo_monto,
              ta_tasa_min,       ta_tasa_max,   ta_tasa_mer,    ta_vigente,
              ta_fecha_crea,     ta_fecha_mod,  ta_usuario,     ta_tipo)
      values( @i_tipo_deposito,  @i_moneda,     @i_tipo_plazo,  @i_tipo_monto,
              @i_tasa_min,       @i_tasa_max,   @i_vigente,     @i_vigente, 
              @s_date,           @s_date,       @s_user,        @i_tipo_tasa) 
      
      if @@error <> 0 
      begin
           exec cobis..sp_cerror
                @t_debug        = @t_debug,
                @t_file         = @t_file,
                @t_from         = @w_sp_name,                
                @i_num          = 143010
           return 1
      end

      /* Transaccion de servicio  */
      insert into ts_tasa 
             (secuencial,       tipo_transaccion, clase,         fecha,
              usuario,          terminal,         srv,           lsrv,
              tipo_deposito,    moneda,           tipo_plazo,    tipo_monto,
              tasa_min,         tasa_max,         vigente,       fecha_crea,     
              fecha_mod,        tipo)
      values (@s_ssn,           @t_trn,           'N',           @s_date,
              @s_user,          @s_term,          @s_srv,        @s_lsrv,
              @i_tipo_deposito, @i_moneda,        @i_tipo_plazo, @i_tipo_monto,
              @i_tasa_min,      @i_tasa_max,      @i_vigente,    @s_date,       
              @s_date,          @i_tipo_tasa)

      if @@error <> 0
      begin
           exec cobis..sp_cerror
                @t_debug        = @t_debug,
                @t_file         = @t_file,
                @t_from         = @w_sp_name,
                @i_num          = 143005
          return 1
      end

      ----------------------------------------------------
      --Historico de Tasas --GAR 11-mar-2005 DP00126
      ----------------------------------------------------
      select @w_estado = 'V'
 
      exec @w_return = cobis..sp_cseqnos
           @t_debug     = @t_debug,
           @t_file      = @t_file,
           @t_from      = @w_sp_name,
           @i_tabla     = 'pf_hist_tasa',
           @o_siguiente = @w_siguiente_hist out

      if @w_return <> 0
         return @w_return

      --------------------------------------------------
      --Inserto en el historico de tasas --GAR 11-mar-2005 DP00126
      --------------------------------------------------
      insert into pf_hist_tasa 
            (ht_secuencial,           ht_tipo_deposito,              ht_moneda,
             ht_tipo_monto,           ht_tipo_plazo,                 ht_tasa_min,
             ht_tasa_max,             ht_vigente,                    ht_tasa_min_ant,
             ht_tasa_max_ant,         ht_vigente_ant,                ht_estado,
             ht_fecha_crea,           ht_usuario,                    ht_usuario_ant,
             ht_fecha_crea_ant,       ht_tipo)
      values(@w_siguiente_hist,       @i_tipo_deposito,              @i_moneda,
             @i_tipo_monto,           @i_tipo_plazo,                 @i_tasa_min,
             @i_tasa_max,             @i_vigente,                    null,
             null,                    null,                          @w_estado,
             @s_date,                 @s_user,                       null,
             null,                    @i_tipo_tasa)

      if @@error <> 0
      begin
          exec cobis..sp_cerror
               @t_debug        = @t_debug,
               @t_file         = @t_file,
               @t_from         = @w_sp_name,
               @i_num          = 143057
          return 1
      end 
      
      commit tran

      return 0
end

 
--- Update ---
if @i_operacion = 'U'
begin
    
    /* Valores para transaccion de Servicios  y verificacion de la existencia */
    /* de la tasa a modificar  */

    select  @w_tasa_min       = ta_tasa_min,
            @w_tasa_max       = ta_tasa_max,
            @w_vigente        = ta_vigente, 
            @w_fecha_mod      = ta_fecha_mod,
            @w_ht_usuario_ant = ta_usuario, --GAR 11-mar-2005 DP00126
            @w_fecha_mod_ant  = isnull(ta_fecha_mod,ta_fecha_crea) --CVA
    from pf_tasa
    where ta_tipo_deposito= @i_tipo_deposito 
      and ta_moneda       = @i_moneda  
      and ta_tipo_plazo   = @i_tipo_plazo
      and ta_tipo_monto   = @i_tipo_monto
      and ta_tipo         = @i_tipo_tasa
    

    if @@rowcount = 0
    begin
         exec cobis..sp_cerror
              @t_debug        = @t_debug,
              @t_file         = @t_file,
              @t_from         = @w_sp_name,
              @i_num          = 141055
         return 1    
    end
      
    select @v_tasa_min           = @w_tasa_min, 
           @v_tasa_max           = @w_tasa_max,
           @v_vigente            = @w_vigente,
           @v_fecha_mod          = @w_fecha_mod,
           @w_ht_vigente_ant     = @w_vigente,   
           @w_ht_tasa_max_ant    = @w_tasa_max,  
           @w_ht_tasa_min_ant    = @w_tasa_min   

    if @w_tasa_min = @i_tasa_min
          select @w_tasa_min = null, @v_tasa_min = null, @w_ht_tasa_min_ant = null    --LIM 31/ENE/2006 ht_tasa_min_ant
    else
       select @w_tasa_min = @i_tasa_min

    if @w_tasa_max = @i_tasa_max
       select @w_tasa_max = null, @v_tasa_max = null, @w_ht_tasa_max_ant = null    --LIM 31/ENE/2006 ht_tasa_max_ant
    else
       select @w_tasa_max = @i_tasa_max

    if @w_vigente = @i_vigente
       select @w_vigente = null, @v_vigente = null, @w_ht_vigente_ant = null         --LIM 31/ENE/2006 ht_vigente_ant
    else
       select @w_vigente = @i_vigente
    
    if @w_fecha_mod = @s_date   
       select @w_fecha_mod = null, @v_fecha_mod = null
    else
       select @w_fecha_mod = @s_date          

    begin tran

    update pf_tasa
    set ta_tasa_min  = @i_tasa_min,
        ta_tasa_max  = @i_tasa_max,
        ta_vigente   = @i_vigente,
        ta_fecha_mod = @s_date,
        ta_usuario   = @s_user
    where ta_tipo_deposito = @i_tipo_deposito 
      and ta_moneda        = @i_moneda 
      and ta_tipo_plazo    = @i_tipo_plazo  
      and ta_tipo_monto    = @i_tipo_monto
     
     if @@error <> 0 
     begin
         exec cobis..sp_cerror
           @t_debug        = @t_debug,
           @t_file         = @t_file,
           @t_from         = @w_sp_name,
           @i_num          = 145010
         return 1    
     end 
   
     /* transaccion servicio - tasa con los datos anteriores */  
     insert into ts_tasa 
            (secuencial,       tipo_transaccion,  clase,         fecha,
             usuario,          terminal,          srv,           lsrv,
             tipo_deposito,    moneda,            tipo_plazo,    tipo_monto,
             tasa_min,         tasa_max,          vigente,       fecha_crea,     
             fecha_mod,        tipo)
     values (@s_ssn,           @t_trn,            'P',           @s_date,
             @s_user,          @s_term,           @s_srv,        @s_lsrv,
             @i_tipo_deposito, @i_moneda,         @i_tipo_plazo, @i_tipo_monto,
             @v_tasa_min,      @v_tasa_max,       @v_vigente,    null,           
             @v_fecha_mod,     @i_tipo_tasa)

    if @@error <> 0 
    begin
          exec cobis..sp_cerror
               @t_debug        = @t_debug,
               @t_file         = @t_file,
               @t_from         = @w_sp_name,
               @i_num          = 143005
          return 1    
    end 
     
    /* transaccion de servicio - tasa con los datos modificados */
     insert into ts_tasa 
            (secuencial,       tipo_transaccion,  clase,         fecha,
             usuario,          terminal,          srv,           lsrv,
             tipo_deposito,    moneda,            tipo_plazo,    tipo_monto,
             tasa_min,         tasa_max,          vigente,       fecha_crea,    
             fecha_mod,        tipo)
     values (@s_ssn,           @t_trn,            'A',           @s_date,
             @s_user,          @s_term,           @s_srv,        @s_lsrv,
             @i_tipo_deposito, @i_moneda,         @i_tipo_plazo, @i_tipo_monto,
             @w_tasa_min,      @w_tasa_max,       @w_vigente,    null,
             @w_fecha_mod,     @i_tipo_tasa)

    if @@error <> 0 
    begin
          exec cobis..sp_cerror
               @t_debug        = @t_debug,
               @t_file         = @t_file,
               @t_from         = @w_sp_name,
               @i_num          = 143005
          return 1    
    end 

    --- CCR insercion en historico siempre que haya modificacion --

    exec @w_return    = cobis..sp_cseqnos
         @t_debug     = @t_debug,
         @t_file      = @t_file,
         @t_from      = @w_sp_name,
         @i_tabla     = 'pf_hist_tasa',
         @o_siguiente = @w_siguiente_hist out
    select @w_estado = 'V'
    
    insert into pf_hist_tasa
           (ht_secuencial,      ht_tipo_deposito,   ht_moneda,          ht_tipo_monto,
            ht_tipo_plazo,      ht_tasa_min,        ht_tasa_max,        ht_vigente,
            ht_tasa_min_ant,    ht_tasa_max_ant,    ht_vigente_ant,     ht_estado,
            ht_fecha_crea,      ht_usuario,         ht_usuario_ant,     ht_fecha_crea_ant,
            ht_tipo)
    values (@w_siguiente_hist,  @i_tipo_deposito,   @i_moneda,          @i_tipo_monto,
            @i_tipo_plazo,      @i_tasa_min,        @i_tasa_max,        @i_vigente,
            @w_ht_tasa_min_ant, @w_ht_tasa_max_ant, @w_ht_vigente_ant,  @w_estado,
            @s_date,            @s_user,            @w_ht_usuario_ant,  @w_fecha_mod_ant, 
            @i_tipo_tasa)
    if @@error <> 0
    begin
        exec cobis..sp_cerror
            @t_debug        = @t_debug,
            @t_file         = @t_file,
            @t_from         = @w_sp_name,
            @i_num          = 143057
        return 1
     end

    commit tran
    return 0
  
end /* fin de if @i_operacion = U */   

-- Delete ---
if @i_operacion = 'D'
begin
      /* valores para transaccion de servicios */
     select @w_tasa_min   = ta_tasa_min,
            @w_tasa_max   = ta_tasa_max,
            @w_vigente    = ta_vigente,
            @w_fecha_crea = ta_fecha_crea,
            @w_fecha_mod  = ta_fecha_mod
     from pf_tasa
     where ta_tipo_deposito = @i_tipo_deposito  
       and ta_moneda        = @i_moneda 
       and ta_tipo_plazo    = @i_tipo_plazo  
       and ta_tipo_monto    = @i_tipo_monto
       and ta_tipo          = @i_tipo_tasa

     if @@rowcount = 0
     begin
         exec cobis..sp_cerror
              @t_debug        = @t_debug,
              @t_file         = @t_file,
              @t_from         = @w_sp_name,
              @i_num          = 141055
         return 1    
     end
 
     begin tran
 
     delete from pf_tasa
     where ta_tipo_deposito = @i_tipo_deposito 
       and ta_moneda        = @i_moneda
       and ta_tipo_plazo    = @i_tipo_plazo 
       and ta_tipo_monto    = @i_tipo_monto
       and ta_tipo          = @i_tipo_tasa
   
     if @@error <> 0
     begin
          exec cobis..sp_cerror
               @t_debug        = @t_debug,
               @t_file         = @t_file,
               @t_from         = @w_sp_name,
               @i_num          = 147010
           return 1    
     end 
   
     insert into ts_tasa 
           (secuencial,       tipo_transaccion, clase,        fecha,
            usuario,          terminal,         srv,          lsrv,
            tipo_deposito,    moneda,           tipo_plazo,   tipo_monto, 
            tasa_min,         tasa_max,         vigente,      fecha_crea,
            fecha_mod,        tipo)
     values(@s_ssn,           @t_trn,           'B',           @s_date,
            @s_user,          @s_term,          @s_srv,        @s_lsrv,
            @i_tipo_deposito, @i_moneda,        @i_tipo_plazo, @i_tipo_monto,
            @w_tasa_min,      @w_tasa_max,      @w_vigente,    @w_fecha_crea,
            @w_fecha_mod,     @i_tipo_tasa)

    if @@error <> 0 
    begin
         exec cobis..sp_cerror
           @t_debug        = @t_debug,
           @t_file         = @t_file,
           @t_from         = @w_sp_name,
           @i_num          = 143005
         return 1    
     end 

     ----------------------------------------------------
     --Historico de Tasas --GAR 11-mar-2005 DP00126
     ----------------------------------------------------
      exec @w_return = cobis..sp_cseqnos
           @t_debug     = @t_debug,
           @t_file      = @t_file,
           @t_from      = @w_sp_name,
           @i_tabla     = 'pf_hist_tasa',
           @o_siguiente = @w_siguiente_hist out

     update pf_hist_tasa
     set ht_estado = 'E'
     where ht_tipo_deposito = @i_tipo_deposito  
       and ht_moneda        = @i_moneda 
       and ht_tipo_plazo    = @i_tipo_plazo
       and ht_tipo_monto    = @i_tipo_monto
       and ht_tipo          = @i_tipo_tasa

     if @@error <> 0
     begin
        exec cobis..sp_cerror
            @t_debug        = @t_debug,
            @t_file         = @t_file,
            @t_from         = @w_sp_name,
            @i_num          = 145050
        return 1
     end
    
  commit tran
  return 0

end /* end de if operacion = D */


--- Search ---
if @i_operacion = 'S'
begin 
 
   if @i_modo = 0
      select @i_id     = 0,
             @i_moneda = 0

   create table #tasa (
      id              int     identity,
      mo_descripcion  varchar(20) null,  
      ta_tipo_monto   varchar(10) null,
      ta_tipo_plazo   varchar(10) null,
      ta_tasa_min     float       null,
      ta_tasa_max     float       null,
      ta_vigente      float       null,
      ta_moneda       tinyint     null
   )

   insert into #tasa
   select substring(a.mo_descripcion,1,20),
          ta_tipo_monto, 
          ta_tipo_plazo, 
          ta_tasa_min,
          ta_tasa_max,
          ta_vigente,
          ta_moneda
  from pf_tasa, 
       pf_monto,
       pf_plazo, 
       cobis..cl_moneda a          
   where ta_tipo_deposito = @i_tipo_deposito
     and ta_moneda        = mo_moneda          
     and mo_mnemonico     = ta_tipo_monto
     and pl_mnemonico     = ta_tipo_plazo
     and ta_tipo          = @i_tipo_tasa
   order by ta_moneda, mo_monto_min, pl_plazo_min


   set rowcount 20

   select 'MONEDA'     = mo_descripcion,
          'MONTO'      = ta_tipo_monto, 
          'PLAZO'      = ta_tipo_plazo, 
          'MINIMA'     = ta_tasa_min,
          'MAXIMA'     = ta_tasa_max,
          'VIGENTE'    = ta_vigente,
          'COD.MONEDA' = ta_moneda,
          'ID'         = id
   from #tasa
   where id > @i_id
   order by id

   /*
   if @@rowcount = 0 and @i_modo = 1
   begin
        exec cobis..sp_cerror
             @t_debug      = @t_debug,
             @t_file       = @t_file,
             @t_from       = @w_sp_name,
             @i_num        = 141036
       return 1
   end
   */

   return 0     

end /* end del if 'Search' */


/** Query **/
if @i_operacion = 'Q'
begin 

    select 'COD.MONTO'    = mo_tipo_monto,
           'DESC.MONTO'   = convert(char(20),mo_descripcion),
           'MONTO MINIMO' = mo_monto_min,
           'MONTO MAXIMO' = mo_monto_max,
           'COD.PLAZO'    = pl_tipo_plazo,
           'DESC.PLAZO'   = convert(char(20),pl_descripcion),
           'PLAZO MINIMO' = pl_plazo_min,
           'PLAZO MAXIMO' = pl_plazo_max,
           'TASA MINIMA'  = ta_tasa_min,
           'TASA MAXIMA'  = ta_tasa_max,
           'TASA VIGENTE' = ta_vigente
    from pf_tasa, 
         pf_plazo, 
         pf_monto
    where ta_tipo_deposito = @i_tipo_deposito
      and ta_moneda     = @i_moneda
      and ta_tipo_plazo = @i_tipo_plazo 
      and ta_tipo_plazo = pl_mnemonico 
      and ta_tipo_monto = @i_tipo_monto 
      and ta_tipo_monto = mo_mnemonico
      and ta_tipo       = @i_tipo_tasa 
     
    if @@rowcount <> 1
    begin
       exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 141043
       return 1
    end

    return 0
end


/** Help **/

if @i_operacion = 'H'
begin
     select @w_tipo_plazo = pl_mnemonico  
     from pf_plazo
     where @i_dias between pl_plazo_min and pl_plazo_max

     if @@rowcount = 0 
     begin
          exec cobis..sp_cerror
               @t_debug  = @t_debug,
               @t_file   = @t_file,
               @t_from   = @w_sp_name,
               @i_num    = 141054
          return 1
     end 

     select @w_tipo_monto = mo_mnemonico  
     from pf_monto
     where @i_monto between mo_monto_min and mo_monto_max

     if @@rowcount = 0 
     begin
          exec cobis..sp_cerror
               @t_debug = @t_debug,
               @t_file  = @t_file,
               @t_from  = @w_sp_name,
               @i_num   = 141053
          return 1
     end 

     select 'Tasa Vigente' = ta_vigente
     from pf_tasa
     where ta_tipo_plazo    = @w_tipo_plazo 
       and ta_tipo_monto    = @w_tipo_monto
       and ta_tipo_deposito = @i_tipo_deposito  
       and ta_moneda        = @i_moneda
       and ta_tipo          = @i_tipo_tasa

     if @@rowcount = 0 
     begin
          exec cobis..sp_cerror
               @t_debug  = @t_debug,
               @t_file   = @t_file,
               @t_from   = @w_sp_name,
               @i_num    = 141055
          return 1
     end 
     return 0
end

go

