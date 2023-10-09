/************************************************************************/
/*  Archivo               : ppago.sp                                    */
/*  Stored procedure      : sp_ppago                                    */
/*  Base de datos         : cob_pfijo                                   */
/*  Producto              : Plazo_fijo                                  */
/*  Disenado por          : Myriam Davila                               */
/*  Fecha de documentacion: 17/Nov/94                                   */
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
/*  Este programa procesa el mantenimiento de la tabla pf_ppago         */
/*  Insercion de pf_ppago                                               */
/*  Actualizacion de pf_ppago                                           */
/*  Search de la tabla pf_ppago                                         */
/*  Query sobre pf_ppago                                                */
/*  Help a la tabla pf_ppago                                            */
/************************************************************************/
/*                        MODIFICACIONES                                */
/*  FECHA          AUTOR            RAZON                               */
/*  17/Nov/94      R. Serrano       Emision Inicial                     */
/*  13-Jun-94      N. Silva         Porting BMI                         */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'sp_ppago')
   drop proc sp_ppago
go


create proc sp_ppago (
       @s_ssn               int         = null,
       @s_user              login       = null,
       @s_term              varchar(30) = null,
       @s_date              datetime    = null,
       @s_srv               varchar(30) = null,
       @s_lsrv              varchar(30) = null,
       @s_ofi               smallint    = null,
       @s_rol               smallint    = null,
       @t_debug             char(1)     = 'N',
       @t_file              varchar(10) = null,
       @t_from              varchar(32) = null,
       @t_trn               smallint    = null,
       @i_operacion         char(1),
       @i_tipo              char(1)     = null,
       @i_codigo            char(3)     = null,
       @i_descripcion       descripcion = null,
       @i_factor            tinyint     = null,
       @i_modo              smallint    = 0,
       @i_formato_fecha     int         = 0     
)
with encryption
as
declare @w_sp_name          varchar(32),
        @w_descripcion      descripcion,
        @w_factor           tinyint,
        @w_estado           char(1),
        @w_fecha_mod        datetime,
        @w_fecha_crea       datetime,
        @w_aux              tinyint,
        @v_descripcion      descripcion,
        @v_factor           tinyint,
        @v_estado           char(1),
        @v_fecha_mod        datetime,
        @v_fecha_crea       datetime

select @w_sp_name = 'sp_ppago'

if @i_operacion  not in  ('I','U','S','Q','H', 'D')
begin
   exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 141008
   return 1
end


if (@i_operacion = 'I' and @t_trn <> 14121) or
   (@i_operacion = 'U' and @t_trn <> 14221) or
   (@i_operacion = 'D' and @t_trn <> 14321) or
   (@i_operacion = 'S' and @t_trn <> 14521) or
   (@i_operacion = 'Q' and @t_trn <> 14421) or
   (@i_operacion = 'H' and @t_trn <> 14621)
begin
   exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 141040
   return 1
end


--Insert--
if @i_operacion = 'I'
begin
   if exists (select pp_codigo
              from pf_ppago     
              where pp_codigo = @i_codigo and pp_estado <> 'E')
   begin
      exec cobis..sp_cerror
           @t_debug = @t_debug,
           @t_file  = @t_file,
           @t_from  = @w_sp_name,
           @i_num   = 149121
      return 1
   end        
   
   select @w_aux = 0
   
   if exists (select pp_codigo 
              from pf_ppago     
              where pp_codigo = @i_codigo and pp_estado = 'E')
      select @w_aux = 1 --registro ya existente que estaba en estado 'E'
   else
      select @w_aux = 0 --registro nuevo
   
   if @w_aux = 0
   begin
   
      begin tran
      
      insert into pf_ppago 
            ( pp_codigo,
              pp_descripcion,
              pp_factor_en_meses,
              pp_fecha_crea,
              pp_fecha_mod,
              pp_estado,
              pp_factor_dias)
      values( @i_codigo,
              @i_descripcion,
              @i_factor,
              @s_date,
              @s_date,
              'A',
              @i_factor * 30)
   
   
      if @@error <> 0
      begin
           exec cobis..sp_cerror
                @t_debug = @t_debug,
                @t_file  = @t_file,
                @t_from  = @w_sp_name,
                @i_num   = 143021
           return 1
      end
   
      insert into ts_ppago
             (secuencial, tipo_transaccion, clase, fecha,
              usuario, terminal, srv, lsrv,
              codigo,descripcion,factor_en_meses,
              fecha_crea,fecha_mod,estado)
      values (@s_ssn, @t_trn, 'N', @s_date,
              @s_user, @s_term, @s_srv, @s_lsrv,
              @i_codigo,@i_descripcion,@i_factor,
              @s_date,@s_date,'A')
   
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
   end
   else 
   begin
      select @t_trn = 14221
   
      select @w_descripcion = pp_descripcion,
             @w_factor      = pp_factor_en_meses, 
             @w_fecha_mod   = pp_fecha_mod,
             @w_estado      = pp_estado
      from pf_ppago
      where  pp_codigo = @i_codigo and pp_estado = 'E'
   
      if @@rowcount = 0
      begin
         exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 141054
         return 1    
      end
   
      select @v_descripcion = @w_descripcion,
             @v_factor      = @w_factor, 
             @v_fecha_mod   = @w_fecha_mod,
             @v_estado      = @w_estado
   
      if @w_descripcion = @i_descripcion
         select @w_descripcion = null,
                @v_descripcion = null
      else
         select @w_descripcion = @i_descripcion
   
      if @w_factor = @i_factor
         select @w_factor = null, 
                @v_factor = null
      else
         select @w_factor = @i_factor
   
      if @w_fecha_mod = @s_date
         select @w_fecha_mod = null, 
                @v_fecha_mod = null
      else
         select @w_fecha_mod = @s_date
   
   
      begin tran
   
      update pf_ppago
      set pp_descripcion     = @i_descripcion,
          pp_factor_en_meses = @i_factor,
          pp_fecha_mod       = @s_date,
          pp_estado          = 'A',
          pp_factor_dias     = @i_factor * 30
      where pp_codigo = @i_codigo 
        and pp_estado = 'E'
   
      if @@rowcount <> 1
      begin
           exec cobis..sp_cerror
                @t_debug = @t_debug,
                @t_file  = @t_file,
                @t_from  = @w_sp_name,
                @i_num   = 145021
           return 1
      end
   
      insert into ts_ppago
            (secuencial  , tipo_transaccion, clase          , fecha,
             usuario     , terminal        , srv            , lsrv,
             codigo      , descripcion     , factor_en_meses, fecha_crea,
             fecha_mod   , estado)
     values (@s_ssn      , @t_trn          , 'P'            , @s_date,
             @s_user     , @s_term         , @s_srv         , @s_lsrv,
             @i_codigo   , @v_descripcion  , @v_factor      , null,
             @v_fecha_mod, @w_estado)
   
      if @@rowcount <> 1
      begin
           exec cobis..sp_cerror
                @t_debug = @t_debug,
                @t_file  = @t_file,
                @t_from  = @w_sp_name,
                @i_num   = 143005
           return 1
      end
      
      insert into ts_ppago 
            (secuencial   , tipo_transaccion, clase          , fecha,
             usuario      , terminal        , srv            , lsrv,
             codigo       , descripcion     , factor_en_meses, fecha_crea,
             fecha_mod    , estado)
      values (@s_ssn      , @t_trn          , 'A'            , @s_date,
              @s_user     , @s_term         , @s_srv         , @s_lsrv,
              @i_codigo   , @w_descripcion  , @w_factor      , null,
              @w_fecha_mod, 'A')
   
   
      if @@rowcount <> 1
      begin
         exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 143005
         return 1
      end
      
      commit tran
   end
   
   return 0
end


--Update--
if @i_operacion = 'U'
begin
   select @w_descripcion = pp_descripcion,
          @w_factor      = pp_factor_en_meses, 
          @w_fecha_mod   = pp_fecha_mod
   from pf_ppago
   where pp_codigo = @i_codigo and pp_estado = 'A'
   

   if @@rowcount = 0
   begin
      exec cobis..sp_cerror
           @t_debug = @t_debug,
           @t_file  = @t_file,
           @t_from  = @w_sp_name,
           @i_num   = 141054
      return 1
   end
    
   select @v_descripcion  = @w_descripcion,
          @v_factor       = @w_factor, 
          @v_fecha_mod    = @w_fecha_mod

   if @w_descripcion = @i_descripcion
      select @w_descripcion = null, 
             @v_descripcion = null
   else
      select @w_descripcion = @i_descripcion
                        
   if @w_factor = @i_factor
      select @w_factor = null, 
             @v_factor = null
   else
      select @w_factor = @i_factor

   if @w_fecha_mod = @s_date
      select @w_fecha_mod = null, 
             @v_fecha_mod = null
   else
      select @w_fecha_mod = @s_date
    

   begin tran

   update pf_ppago
      set pp_descripcion     = @i_descripcion,
          pp_factor_en_meses = @i_factor,
          pp_fecha_mod       = @s_date,
          pp_factor_dias     = @i_factor * 30
   where pp_codigo = @i_codigo 
     and pp_estado = 'A'
   
   if @@error <> 0 
   begin
         exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 145021
         return 1
   end
    
   insert into ts_ppago 
          (secuencial  , tipo_transaccion, clase          , fecha,
           usuario     , terminal        , srv            , lsrv,
           codigo      , descripcion     , factor_en_meses, fecha_crea,
           fecha_mod   , estado)
   values (@s_ssn      , @t_trn          , 'P'            , @s_date,
           @s_user     , @s_term         , @s_srv         , @s_lsrv,
           @i_codigo   , @v_descripcion  , @v_factor      , null,
           @v_fecha_mod, null)

   if @@error <> 0 
   begin
      exec cobis..sp_cerror
           @t_debug = @t_debug,
           @t_file  = @t_file,
           @t_from  = @w_sp_name,
           @i_num   = 143005
      return 1
   end

   insert into ts_ppago 
          (secuencial , tipo_transaccion, clase          , fecha,
           usuario    , terminal        , srv            , lsrv,
           codigo     , descripcion     , factor_en_meses, fecha_crea,
           fecha_mod  , estado)
    values(@s_ssn     , @t_trn          , 'A'            , @s_date,
           @s_user    , @s_term         , @s_srv         , @s_lsrv,
          @i_codigo   , @w_descripcion  , @w_factor      , null,
          @w_fecha_mod, null)


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
  
end --fin de if @i_operacion = U--


--Delete--
if @i_operacion = 'D'
begin
   select @w_descripcion = pp_descripcion,
          @w_factor      = pp_factor_en_meses,
          @w_fecha_crea  = pp_fecha_crea,
          @w_fecha_mod   = pp_fecha_mod,
          @w_estado      = pp_estado
   from pf_ppago
   where pp_codigo = @i_codigo 
     and pp_estado = 'A'

   if @@rowcount = 0 
   begin
         exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 141054
         return 1
   end
  -- verifica Existencia de relaciones de  frecuencia con tipos de deposito
  if exists (select 1 from pf_auxiliar_tip where at_valor = @i_codigo)
  begin
	exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 149122
         return 1
  end
  
   begin tran
 
      update pf_ppago 
      set pp_estado    = 'E',
          pp_fecha_mod = @s_date
      where pp_codigo  = @i_codigo
        and pp_estado <> 'E'
      
      
      if @@rowcount <> 1
      begin
            exec cobis..sp_cerror
                 @t_debug = @t_debug,
                 @t_file  = @t_file,
                 @t_from  = @w_sp_name,
                 @i_num   = 147021
            return 1
      end

      insert into ts_ppago 
             (secuencial  , tipo_transaccion, clase          , fecha,
              usuario     , terminal        , srv            , lsrv,
              codigo      , descripcion     , factor_en_meses, fecha_crea,
              fecha_mod   , estado)
      values (@s_ssn      , @t_trn          , 'B'            , @s_date,
              @s_user     , @s_term         , @s_srv         , @s_lsrv,
              @i_codigo   , @w_descripcion  , @w_factor      , @w_fecha_crea,
              @w_fecha_mod, @w_estado)
      
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
end 


--Search--
if @i_operacion = 'S'
begin 
   select @i_codigo = case @i_modo 
                        when 0 then ''
                        else @i_codigo
                      end 
    
   set rowcount 20
   
   select 'FREC.'                 = pp_codigo,
          'DESCRIPCION '          = substring(pp_descripcion,1,64),
          'FACTOR'                = pp_factor_en_meses,
          'FECHA DE CREACION'     = convert (char(10),pp_fecha_crea,@i_formato_fecha),
          'FECHA DE MODIFICACION' = convert (char(10),pp_fecha_mod,@i_formato_fecha)
     from pf_ppago 
    where pp_estado = 'A'
      and pp_codigo > @i_codigo
    order by pp_codigo
   
   set rowcount 0 
   return 0   
end


--Query--
if @i_operacion = 'Q'
begin 
   select 'DESCRIPCION ' = substring(pp_descripcion,1,64),
          'FACTOR'       = pp_factor_en_meses
     from pf_ppago 
    where pp_codigo = @i_codigo 
      and pp_estado = 'A'
   
   if @@rowcount <> 1
   begin
      exec cobis..sp_cerror
           @t_debug = @t_debug,
           @t_file  = @t_file,
           @t_from  = @w_sp_name,
           @i_num   = 141071
      return 1
   end
   
   return 0

end


--Help--
if @i_operacion = 'H'
begin
   if @i_tipo = 'A'
   begin
      set rowcount 20
      
      select @i_codigo = case @i_modo
                           when 0 then ''
                           else @i_codigo
                         end    

      select 'FREC.'        = pp_codigo,
             'DESCRIPCION ' = substring(pp_descripcion,1,64),
             'FACTOR'       = pp_factor_en_meses
        from pf_ppago 
       where pp_estado = 'A'
         and pp_codigo > @i_codigo

      set rowcount 0 
      return 0   
   end
   
   if @i_tipo = 'V'
   begin
      select 'DESCRIPCION ' = pp_descripcion,
             'FACTOR'       = pp_factor_en_meses
        from pf_ppago 
       where pp_codigo = @i_codigo 
         and pp_estado = 'A'
   
      if @@rowcount = 0
      begin
         exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 141071
         return 1
      end

      return 0
   end
end
go
