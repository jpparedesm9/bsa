/************************************************************************/
/*      Archivo:              camb_masivo_tasas.sp                      */
/*      Base de datos:        cob_pfijo                                 */
/*      Producto:             Plazo Fijo                                */
/*      Disenado por:         Katty Tamayo                              */
/*      Fecha de escritura:   22-Feb-2005                               */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      'MACOSA', representantes exclusivos para el Ecuador de la       */
/*      'NCR CORPORATION'.                                              */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/************************************************************************/
/*                              PROPOSITO                               */
/*      Este procedimiento almacenado cambia las tasa maxima, minima y  */
/*      vigente de forma masiva.                                        */
/************************************************************************/
/*                           MODIFICACIONES                             */
/*      FECHA           AUTOR              RAZON                        */
/*      22-Feb-2005     K. Tamayo          Emision Inicial              */
/*      03-Nov-2005     L. Im              Estado tipo de deposito      */
/*      07-Oct-2016     N. Martillo        Nuevos campos Momento,       */
/*                                         segmento, ivc, prorroga      */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'sp_camb_masivo_tasas')
   drop proc sp_camb_masivo_tasas
go

create proc sp_camb_masivo_tasas(
@s_ssn            int          = null,
@s_user           login        = null,
@s_sesn           int          = null,
@s_term           varchar(30)  = null,
@s_date           datetime     = null,
@s_srv            varchar(30)  = null,
@s_lsrv           varchar(30)  = null,
@s_rol            smallint     = null,
@s_ofi            smallint     = null,
@s_org_err        char(1)      = null,
@s_error          int          = null,
@s_sev            tinyint      = null,
@s_msg            descripcion  = null,
@s_org            char(1)      = null,
@t_debug          char(1)      = 'N',
@t_file           varchar(14)  = null,
@t_from           varchar(32)  = null,
@t_trn            smallint     = null,
@i_operacion      char(1),
@i_modo           tinyint,
@i_tipo_deposito  varchar(5)   = null,
@i_moneda         tinyint      = null,
@i_tipo_monto     varchar(10)  = null,
@i_tipo_plazo     varchar(10)  = null,
@i_momento        varchar(10)  = null,
@i_tipo_prorroga  varchar(10)  = null,
@i_segmento       varchar(10)  = null,
@i_ivc            varchar(10)  = null,
@i_tasa_minima    float        = null,
@i_tasa_maxima    float        = null,
@i_tasa_vigente   float        = null,
@i_tipo_tasa      char(1)      = 'N',    -- Tipo de tasa (N)ormal / (P)recancelacion
@i_param1         varchar(255) = null,   -- Parametro 1
@i_param2         varchar(255) = null,   -- Parametro 2 
@i_param3         varchar(255) = null,   -- Parametro 3 
@i_param4         varchar(255) = null,   -- Parametro 4 
@i_param5         varchar(255) = null,   -- Parametro 5 
@i_param6         varchar(255) = null,   -- Parametro 6 
@i_param7         varchar(255) = null,   -- Parametro 7 
@i_param8         varchar(255) = null,   -- Parametro 8 
@i_param9         varchar(255) = null,   -- Parametro 9 
@i_param10        varchar(255) = null,   -- Parametro 10,
@i_flag           char(1)      = 'N',    --LIM 03/NOV/2005
@i_tipo           char(1)      = 'N',
@i_id             int          = 0
)
with encryption
as
declare
@w_sp_name         varchar(32),
@w_tipo_deposito   varchar(5),
@w_moneda          tinyint,
@w_tipo_monto      varchar(10),
@w_tipo_plazo      varchar(10),
@w_tasa_minima     float,
@w_tasa_maxima     float,
@w_tasa_vigente    float,
@w_fecha_mod       datetime,
@v_tasa_minima     float,
@v_tasa_maxima     float,
@v_tasa_vigente    float,
@v_fecha_mod       datetime,
@w_cont            int,
@w_cadena          varchar(255),   -- registro de proceso 
@w_parametro       tinyint,        -- contador numero de campos 
@w_posicion        smallint,       -- posicion del separador 
@w_token           varchar(255),   -- campo de proceso
@w_siguiente_hist  int,            --CVA
@w_ta_usuario      login,          --CVA
@w_return          int,            --CVA
@w_fecha_mod_ant   datetime,       --CVA
@w_rowcount        int,            --LIM 03/NOV/2005
@w_momento         catalogo,       --NMA
@w_segmento        catalogo,       --NMA
@w_ivc             catalogo,       --NMA
@w_tipo_prorroga   catalogo        --NMA



select @w_sp_name = 'sp_camb_masivo_tasas'

if (@t_trn <> 14546 and @i_operacion = 'S') or
   (@t_trn <> 14240 and @i_operacion = 'U') 
begin
   exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 141112
   return 1
end


if @i_operacion = 'S' 
begin

   create table #TasasMasivas(
   tm_id          int         identity,
   tm_mnemonico   varchar(5)  null,
   tm_moneda      tinyint     null,
   tm_tipo_monto  varchar(10) null,
   tm_tipo_plazo  varchar(10) null,
   tm_momento     catalogo    null,
   tm_segmento    catalogo    null,
   tm_ivc         catalogo    null,
   tm_prorroga    catalogo    null,
   tm_tasa_min    float       null,
   tm_tasa_max    float       null,
   tm_vigente     float       null)
   
   insert into #TasasMasivas
   select      td_mnemonico,
            ta_moneda,
            ta_tipo_monto,
            ta_tipo_plazo,
            ta_momento,
            ta_segmento,
            ta_ivc,
            ta_prorroga,
            ta_tasa_min,
            ta_tasa_max,
            ta_vigente
        from pf_tasa,
             pf_tipo_deposito    
        where ta_moneda     = isnull(@i_moneda, ta_moneda)
          and ta_tipo_plazo = isnull(@i_tipo_plazo,ta_tipo_plazo)
          and ta_tipo_monto = isnull(@i_tipo_monto,ta_tipo_monto)
          and ta_momento    = isnull(@i_momento,ta_momento)
          and ((ta_segmento = @i_segmento)      or (@i_segmento is null))
          and ((ta_ivc      = @i_ivc)           or (@i_ivc is null))
          and ((ta_prorroga = @i_tipo_prorroga) or (@i_tipo_prorroga is null))
          and td_mnemonico  = ta_tipo_deposito
          and ((td_estado   = 'A' and @i_flag = 'S') or @i_flag <> 'S')
          and ta_tipo       = @i_tipo_tasa
        order by ta_tipo_deposito, ta_moneda, ta_tipo_monto, ta_tipo_plazo, ta_momento, ta_segmento, ta_ivc, ta_prorroga
          
   
   set rowcount 20

 
   select      'Selección'     = 0,
               'Tipo Depósito' = tm_mnemonico,
               'Moneda'        = tm_moneda,
               'Monto'         = tm_tipo_monto,
               'Plazo'         = tm_tipo_plazo,
               'Momento'       = tm_momento,
               'Segmento'      = tm_segmento,
               'IVC'           = tm_ivc,
               'Prórroga'      = tm_prorroga,
               'Tasa Mínima'   = tm_tasa_min,
               'Tasa Máxima'   = tm_tasa_max,
               'Tasa Vigente'  = tm_vigente
        from #TasasMasivas  
        where tm_id > @i_id
        order by tm_id

     if @@rowcount = 0 begin
      exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 141036
      return 1
      end

   if OBJECT_ID(N'tempdb..#TasasVigentes', N'U') is not null
      drop table #TasasVigentes
   
   set rowcount 0
   return 0
end

if @i_operacion = 'U' 
begin
   select @w_cont = 1
   ----------------------------------
   -- Lazo para proceso de registros
   ----------------------------------
   while @w_cont <= 10
   begin
      select @w_cadena = case @w_cont 
                           when 1  then @i_param1
                           when 2  then @i_param2
                           when 3  then @i_param3
                           when 4  then @i_param4
                           when 5  then @i_param5
                           when 6  then @i_param6
                           when 7  then @i_param7
                           when 8  then @i_param8
                           when 9  then @i_param9
                           when 10 then @i_param10
                         end
        
      ------------------------------------
      -- si la cadena es no nula procesar
      ------------------------------------
      if @w_cadena is not null
      begin
         select @w_parametro = 0

         while @w_parametro < 10     /* 5 columnas del grid */
         begin
              select @w_parametro = @w_parametro + 1
              select @w_posicion  = charindex('@', @w_cadena)

              if @w_posicion <= 0 or datalength(rtrim(@w_cadena)) <= 0 
                 break

              select @w_token     = substring(@w_cadena, 1, @w_posicion-1)

              if @w_parametro = 1
                 select @i_tipo_deposito    = convert(varchar(5),@w_token)
              if @w_parametro = 2
                 select @i_moneda           = convert(tinyint,@w_token)
              if @w_parametro = 3
                 select @i_tipo_monto       = convert(varchar(10),@w_token)
              if @w_parametro = 4
                 select @i_tipo_plazo       = convert(varchar(10),@w_token)
              if @w_parametro = 5
                 select @i_momento          = convert(varchar(10),@w_token)
              if @w_parametro = 6 begin
                 if @w_token = ''
                    select @i_segmento      = null
                 else
                    select @i_segmento      = convert(varchar(10),@w_token)
                 end
              if @w_parametro = 7 begin
                 if @w_token = ''
                    select @i_ivc           = null
                 else
                    select @i_ivc           = convert(varchar(10),@w_token)
                 end
              if @w_parametro = 8 begin
                 if @w_token = ''
                    select @i_tipo_prorroga = null
                 else
                    select @i_tipo_prorroga = convert(varchar(10),@w_token)
                 end
              if @w_posicion <= 0 or datalength(rtrim(@w_cadena)) <= 0 
                 break
              
              select @w_cadena = substring(@w_cadena, @w_posicion + 1, datalength(rtrim(@w_cadena)))

         end
 
         -- Valores para transaccion de Servicios  y verificacion de la existencia --
         select @w_tipo_deposito = td_mnemonico,
                @w_tipo_plazo    = ta_tipo_plazo,
                @w_tipo_monto    = ta_tipo_monto,
                @w_moneda        = ta_moneda,
                @w_momento       = ta_momento,
                @w_segmento      = ta_segmento,
                @w_ivc           = ta_ivc,
                @w_tipo_prorroga = ta_prorroga,
                @w_tasa_vigente  = ta_vigente,
                @w_tasa_minima   = ta_tasa_min,
                @w_tasa_maxima   = ta_tasa_max,
                @w_fecha_mod     = ta_fecha_mod,
                @w_ta_usuario    = ta_usuario,     --CVA
                @w_fecha_mod_ant = isnull(ta_fecha_mod,ta_fecha_crea)  --CVA
         from pf_tasa,
              pf_tipo_deposito    
         where ta_moneda     = @i_moneda
           and ta_tipo_plazo = @i_tipo_plazo
           and ta_tipo_monto = @i_tipo_monto
           and ta_momento    = @i_momento
           and (ta_segmento   = @i_segmento or @i_segmento is null)
           and (ta_ivc        = @i_ivc or @i_ivc is null)
           and (ta_prorroga   = @i_tipo_prorroga or @i_tipo_prorroga is null)
           and td_mnemonico  = @i_tipo_deposito
           and td_mnemonico  = ta_tipo_deposito
           and ((td_estado   = 'A' and @i_flag = 'S') or @i_flag <> 'S')
           and ta_tipo       = @i_tipo_tasa
            
         select @w_rowcount = @@rowcount

         if @w_rowcount = 0
         begin
            exec cobis..sp_cerror
                 @t_debug        = @t_debug,
                 @t_file         = @t_file,
                 @t_from         = @w_sp_name,
                 @i_num          = 141055
            return 1    
         end
         else begin
            select @v_tasa_minima  = @w_tasa_minima, 
                   @v_tasa_maxima  = @w_tasa_maxima,
                   @v_tasa_vigente = @w_tasa_vigente,
                   @v_fecha_mod    = @w_fecha_mod

             if @w_tasa_minima = @i_tasa_minima
                select @w_tasa_minima = null, 
                       @v_tasa_minima = null
             else
                select @w_tasa_minima = @i_tasa_minima
               
             if @w_tasa_maxima = @i_tasa_maxima
                select @w_tasa_maxima = null, 
                       @v_tasa_maxima = null
             else
                select @w_tasa_maxima = @i_tasa_maxima
               
             if @w_tasa_vigente = @i_tasa_vigente
                select @w_tasa_vigente = null,
                       @v_tasa_vigente = null
             else
                select @w_tasa_vigente = @i_tasa_vigente
    
             if @w_fecha_mod = @s_date   
                select @w_fecha_mod = null, 
                       @v_fecha_mod = null
             else
                select @w_fecha_mod = @s_date          

             begin tran
             

             update pf_tasa
             set ta_tasa_min  = @i_tasa_minima,
                 ta_tasa_max  = @i_tasa_maxima,
                 ta_vigente   = @i_tasa_vigente,
                 ta_fecha_mod = @s_date,
                 ta_usuario   = @s_user --CCR
             where ta_tipo_deposito = @i_tipo_deposito
               and ta_moneda        = @i_moneda 
               and ta_tipo_plazo    = @i_tipo_plazo
               and ta_tipo_monto    = @i_tipo_monto
               and ta_momento       = @i_momento
               and (ta_segmento   = @i_segmento or @i_segmento is null)
               and (ta_ivc        = @i_ivc or @i_ivc is null)
               and (ta_prorroga   = @i_tipo_prorroga or @i_tipo_prorroga is null)
               and ta_tipo          = @i_tipo_tasa
                
            if @@error <> 0 
            begin
                  exec cobis..sp_cerror
                       @t_debug = @t_debug,
                       @t_file  = @t_file,
                       @t_from  = @w_sp_name,
                       @i_num   = 145010
                  return 1    
            end 
                
            --datos anteriores--
            insert into ts_tasa 
                   (secuencial,      tipo_transaccion, clase,           fecha,
                    usuario,         terminal,         srv,             lsrv,
                    tipo_deposito,   moneda,           tipo_plazo,      tipo_monto,
                    momento,         segmento,         ivc,             prorroga,
                    tasa_min,        tasa_max,         vigente,         fecha_crea,    
                    fecha_mod)
            values (@s_ssn,          @t_trn,           'P',             @s_date,
                    @s_user,         @s_term,          @s_srv,          @s_lsrv,
                    @i_tipo_deposito,@i_moneda,        @i_tipo_plazo,   @i_tipo_monto,
                    @i_momento,      @i_segmento,      @i_ivc,          @i_tipo_prorroga,
                    @v_tasa_minima,  @v_tasa_maxima,   @v_tasa_vigente, null,          
                    @v_fecha_mod)
                
            if @@error <> 0 
            begin
                  exec cobis..sp_cerror
                       @t_debug = @t_debug,
                       @t_file  = @t_file,
                       @t_from  = @w_sp_name,
                       @i_num   = 143005
                  return 1    
            end 
                  
            --datos modificados--
            insert into ts_tasa 
                   (secuencial,      tipo_transaccion, clase,           fecha,
                    usuario,         terminal,         srv,             lsrv,
                    tipo_deposito,   moneda,           tipo_plazo,      tipo_monto,
                    momento,         segmento,         ivc,             prorroga,
                    tasa_min,        tasa_max,         vigente,         fecha_crea,    
                    fecha_mod)
            values (@s_ssn,          @t_trn,           'A',             @s_date,
                    @s_user,         @s_term,          @s_srv,          @s_lsrv,
                    @i_tipo_deposito,@i_moneda,        @i_tipo_plazo,   @i_tipo_monto,
                    @i_momento,      @i_segmento,      @i_ivc,          @i_tipo_prorroga,
                    @w_tasa_minima,  @w_tasa_maxima,   @w_tasa_vigente, null,          
                    @w_fecha_mod)
                
            if @@error <> 0 
            begin
                  exec cobis..sp_cerror
                       @t_debug = @t_debug,
                       @t_file  = @t_file,
                       @t_from  = @w_sp_name,
                       @i_num   = 143005
                  return 1    
            end 

            --CVA Set-26-2005 Incluir historico de tasas
            exec @w_return = cobis..sp_cseqnos
                 @t_debug     = @t_debug,
                 @t_file      = @t_file,
                 @t_from      = @w_sp_name,
                 @i_tabla     = 'pf_hist_tasa',
                 @o_siguiente = @w_siguiente_hist out

           insert into pf_hist_tasa (
                  ht_secuencial,           ht_tipo_deposito,              ht_moneda,
                  ht_tipo_monto,           ht_tipo_plazo,                 ht_momento,                 
                  ht_segmento,             ht_ivc,                        ht_prorroga,
                  ht_tasa_min,
                  ht_tasa_max,             ht_vigente,                    ht_tasa_min_ant,
                  ht_tasa_max_ant,         ht_vigente_ant,                ht_estado,
                  ht_fecha_crea,           ht_usuario,                    ht_usuario_ant,
                  ht_fecha_crea_ant,       ht_tipo) 
           values(@w_siguiente_hist,       @i_tipo_deposito,              @i_moneda,
                  @i_tipo_monto,           @i_tipo_plazo,                 @i_momento,
                  @i_segmento,             @i_ivc,                        @i_tipo_prorroga,
                  @i_tasa_minima,
                  @i_tasa_maxima,          @i_tasa_vigente,               @v_tasa_minima,
                  @v_tasa_maxima,          @v_tasa_vigente,               'V',
                  @s_date,                 @s_user,                       @w_ta_usuario,
                  @w_fecha_mod_ant,        @i_tipo)
           if @@error <> 0
           begin
                  exec cobis..sp_cerror
                     @t_debug = @t_debug,
                     @t_file  = @t_file,
                     @t_from  = @w_sp_name,
                     @i_num   = 143057
                return 1
           end 

           commit tran
         end

      end --@w_cadena is null--

      select @w_cont = @w_cont + 1
   end  --while--
end


return 0
go   
