/************************************************************************/
/*  Archivo               : rango_prorroga.sp                           */
/*  Stored procedure      : sp_rango_prorroga                           */
/*  Base de datos         : cob_pfijo                                   */
/*  Producto              : Plazo_fijo                                  */
/*  Disenado por          : Oscar Saavedra                              */
/*  Fecha de documentacion: 20 de Septiembre de 2016                    */
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
/*  Este programa procesa el mantenimiento de la tabla que tiene        */
/*  especificaciones generales de tipos de depositos                    */
/*                                                                      */
/*  - Insercion de pf_rango_prorroga                                    */
/*  - Actualizacion de pf_rango_prorroga                                */
/*  - Eliminacion de pf_rango_prorroga                                  */
/*  - Search de la tabla pf_rango_prorroga                              */
/*  - Query sobre pf_rango_prorroga                                     */
/*  - Help a la tabla pf_rango_prorroga                                 */
/*                                                                      */
/************************************************************************/
/*                          MODIFICACIONES                              */
/*  FECHA          AUTOR              RAZON                             */
/*  20/Sept/2016   Oscar Saavedra     Emision Inicial DPF - S84168      */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS ON
go

SET QUOTED_IDENTIFIER ON
go

if exists (select 1 from sysobjects where name = 'sp_rango_prorroga')
   drop proc sp_rango_prorroga
go

create proc sp_rango_prorroga(
@s_ssn                    int          = null,
@s_user                   login        = null,
@s_term                   varchar(30)  = null,
@s_date                   datetime     = null,
@s_srv                    varchar(30)  = null,
@s_lsrv                   varchar(30)  = null,
@s_ofi                    smallint     = null,
@s_rol                    smallint     = null,
@t_debug                  char(1)      = 'N',
@t_file                   varchar(10)  = null,
@t_from                   varchar(32)  = null,
@t_trn                    smallint     = null,
@i_operacion              char(1),
@i_tipo                   char(1)      = null,
@i_rango_prorroga         int          = null,
@i_mnemonico              varchar(5)   = null,
@i_descripcion            varchar(30)  = null,
@i_prorroga_min           smallint     = null,
@i_prorroga_max           smallint     = null,
@i_modo                   smallint     = 0,
@i_valor                  varchar(20)  = null)
with encryption
as
declare
@w_return                 int,
@w_sp_name                varchar(32),
@w_rango_prorroga         int,
@w_mnemonico              varchar(5),
@w_descripcion            varchar(30),
@w_prorroga_min           smallint,
@w_prorroga_max           smallint, 
@w_fecha_crea             datetime,
@w_fecha_mod              datetime,
@w_rango_max              int,
@v_descripcion            varchar(30),
@v_prorroga_min           smallint,
@v_prorroga_max           smallint,
@v_fecha_mod              datetime

select @w_sp_name = 'sp_rango_prorroga'

if @i_operacion not in ('I','U','S','Q','H','D') begin
   exec cobis..sp_cerror
   @t_debug = @t_debug,
   @t_file  = @t_file,
   @t_from  = @w_sp_name,
   @i_num   = 141008
   return 1
end

if @i_operacion = 'I' begin
   if @t_trn <> 14172 begin
      exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 141040
      return 1
   end

   if @i_prorroga_min > @i_prorroga_max begin
      exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 148009
      return 1
   end

   if exists (select 1 from pf_rango_prorroga where rp_mnemonico = @i_mnemonico) begin
      exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 148001
      return 1
   end
   	
   if exists(select 1 from pf_rango_prorroga where @i_prorroga_min between rp_prorroga_min and rp_prorroga_max) begin
      exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 148007
      return 1
   end
	
   if exists(select 1 from pf_rango_prorroga where @i_prorroga_max between rp_prorroga_min and rp_prorroga_max) begin
      exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 148008
      return 1
   end
   
   begin tran
   
   exec @w_return = cobis..sp_cseqnos
   @t_debug     = @t_debug,
   @t_file      = @t_file,
   @t_from      = @w_sp_name,
   @i_tabla     = 'pf_rango_prorroga',
   @o_siguiente = @w_rango_prorroga out
   
   if @w_return <> 0
      return @w_return
     
   insert into cob_pfijo..pf_rango_prorroga(
   rp_tipo_rango,      rp_mnemonico,   rp_descripcion,  rp_prorroga_min,
   rp_prorroga_max,    rp_fecha_crea,  rp_fecha_mod)
   values(
   @w_rango_prorroga,  @i_mnemonico,   @i_descripcion,  @i_prorroga_min,
   @i_prorroga_max,    @s_date,        @s_date)
   
   if @@error <> 0 begin
      exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 148002
      return 1
   end
   
   insert into ts_rango_prorroga(
   secuencial,       tipo_transaccion,  clase,              fecha,         usuario,          terminal,
   srv,              lsrv,              rango_prorroga,     mnemonico,     descripcion,      prorroga_min,
   prorroga_max,     fecha_crea,        fecha_mod,          ofi)
   values(
   @s_ssn,           @t_trn,            'N',                @s_date,       @s_user,          @s_term,
   @s_srv,           @s_lsrv,           @w_rango_prorroga,  @i_mnemonico,  @i_descripcion,   @i_prorroga_min,
   @i_prorroga_max,  @s_date,           @s_date,            @s_ofi)
   
   if @@error <> 0 begin
      exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 143005
      return 1
   end

   if @@trancount > 0
      commit tran
     
   return 0   
end

if @i_operacion = 'U' begin
   if @t_trn <> 14272 begin
      exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 141040
      return 1
   end

   select
   @w_mnemonico        = rp_mnemonico,
   @w_descripcion      = rp_descripcion,
   @w_prorroga_min     = rp_prorroga_min,
   @w_prorroga_max     = rp_prorroga_max,
   @w_fecha_mod        = rp_fecha_mod
   from  cob_pfijo..pf_rango_prorroga
   where rp_tipo_rango = @i_rango_prorroga
   
   if @@rowcount = 0 begin
      exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 148003
      return 1
   end

   if @i_prorroga_min > @i_prorroga_max begin
      exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 148009
      return 1
   end
   	
   if exists(select 1 from pf_rango_prorroga where @i_prorroga_min between rp_prorroga_min and rp_prorroga_max and rp_tipo_rango <> @i_rango_prorroga) begin
      exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 148007
      return 1
   end

   if exists(select 1 from pf_rango_prorroga where @i_prorroga_max between rp_prorroga_min and rp_prorroga_max and rp_tipo_rango <> @i_rango_prorroga) begin
      exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 148008
      return 1
   end
   
   select
   @v_descripcion  = @w_descripcion,
   @v_prorroga_min = @w_prorroga_min,
   @v_prorroga_max = @w_prorroga_max,
   @v_fecha_mod    = @w_fecha_mod
   
   if @w_descripcion = @i_descripcion begin
      select
      @w_descripcion = NULL,
      @v_descripcion = NULL
   end
   else begin
      select @w_descripcion = @i_descripcion
   end
   
   if @w_prorroga_min = @i_prorroga_min begin
      select
      @w_prorroga_min = NULL,
      @v_prorroga_min = NULL
   end
   else begin
      select @w_prorroga_min = @i_prorroga_min
   end
   
   if @w_prorroga_max = @i_prorroga_max begin
      select
      @w_prorroga_max = NULL,
      @v_prorroga_max = NULL
   end
   else begin
      select @w_prorroga_max = @i_prorroga_max
   end
   
   if @w_fecha_mod = @s_date begin
      select
      @w_fecha_mod = NULL,
      @v_fecha_mod = NULL
   end
   else begin
      select @w_fecha_mod = @s_date 
   end
   
   begin tran
   
   update cob_pfijo..pf_rango_prorroga
   set    rp_descripcion  = @i_descripcion,
          rp_prorroga_min = @i_prorroga_min,
          rp_prorroga_max = @i_prorroga_max,
          rp_fecha_mod    = @s_date
   where  rp_tipo_rango   = @i_rango_prorroga
   
   if @@error <> 0 begin
      exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 148004
      return 1
   end
   
   insert into ts_rango_prorroga(
   secuencial,       tipo_transaccion,  clase,              fecha,         usuario,          terminal,
   srv,              lsrv,              rango_prorroga,     mnemonico,     descripcion,      prorroga_min,
   prorroga_max,     fecha_crea,        fecha_mod,          ofi)
   values(
   @s_ssn,           @t_trn,            'P',                @s_date,       @s_user,          @s_term,
   @s_srv,           @s_lsrv,           @i_rango_prorroga,  @w_mnemonico,  @v_descripcion,   @v_prorroga_min,
   @v_prorroga_max,  null,              @v_fecha_mod,       @s_ofi)
   
   if @@error <> 0 begin
      exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 143005
      return 1
   end
   
   insert into ts_rango_prorroga(
   secuencial,       tipo_transaccion,  clase,              fecha,         usuario,          terminal,
   srv,              lsrv,              rango_prorroga,     mnemonico,     descripcion,      prorroga_min,
   prorroga_max,     fecha_crea,        fecha_mod,          ofi)
   values(
   @s_ssn,           @t_trn,            'A',                @s_date,       @s_user,          @s_term,
   @s_srv,           @s_lsrv,           @i_rango_prorroga,  @w_mnemonico,  @w_descripcion,   @w_prorroga_min,
   @w_prorroga_max,  null,              @w_fecha_mod,       @s_ofi)
   
   if @@error <> 0 begin
      exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 143005
      return 1
   end

   if @@trancount > 0
      commit tran
     
   return 0   
end

if @i_operacion = 'D' begin
   if @t_trn <> 14372 begin
      exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 141040
      return 1
   end
   
   select
   @w_mnemonico        = rp_mnemonico,
   @w_descripcion      = rp_descripcion,
   @w_prorroga_min     = rp_prorroga_min,
   @w_prorroga_max     = rp_prorroga_max,
   @w_fecha_crea       = rp_fecha_crea,
   @w_fecha_mod        = rp_fecha_mod
   from  cob_pfijo..pf_rango_prorroga
   where rp_tipo_rango = @i_rango_prorroga
   
   if @@rowcount = 0 begin
      exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 148003
      return 1
   end
   
    if exists (select 1 from pf_auxiliar_tip where at_tipo = 'PRO' and at_valor = @w_mnemonico and at_estado = 'A') begin
      exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 148010
      return 1
   end
   
   if exists (select 1 from cob_pfijo..pf_tasa, cob_pfijo..pf_rango_prorroga where ta_prorroga = rp_mnemonico and rp_tipo_rango = @i_rango_prorroga) begin
      exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 148011
      return 1
   end
   
    if exists (select 1 from cob_pfijo..pf_tasa_variable, cob_pfijo..pf_rango_prorroga where tv_prorroga = rp_mnemonico and rp_tipo_rango = @i_rango_prorroga) begin
      exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 148012
      return 1
   end
   
   begin tran
   
   delete
   from  cob_pfijo..pf_rango_prorroga
   where rp_tipo_rango = @i_rango_prorroga
   
   if @@error <> 0 begin
      exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 148006
      return 1
   end
   
   insert into ts_rango_prorroga(
   secuencial,       tipo_transaccion,  clase,              fecha,         usuario,          terminal,
   srv,              lsrv,              rango_prorroga,     mnemonico,     descripcion,      prorroga_min,
   prorroga_max,     fecha_crea,        fecha_mod,          ofi)
   values(
   @s_ssn,           @t_trn,            'B',                @s_date,       @s_user,          @s_term,
   @s_srv,           @s_lsrv,           @i_rango_prorroga,  @w_mnemonico,  @w_descripcion,   @w_prorroga_min,
   @w_prorroga_max,  null,              @w_fecha_mod,       @s_ofi)
   
   if @@error <> 0 begin
      exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 143005
      return 1
   end
   
   if @@trancount > 0
      commit tran
     
   return 0   
end

if @i_operacion = 'S' begin
   if @t_trn <> 14572 begin
      exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 141040
      return 1
   end
   
   set rowcount 20
   if @i_modo = 0 begin
      select
      'COD. PRORROGA'  = rp_mnemonico,
      'DESCRIPCION'    = rp_descripcion,
      'RANGO MINIMO'   = rp_prorroga_min,
      'RANGO MAXIMO'   = rp_prorroga_max,
	  'SECUENCIAL'     = rp_tipo_rango
      from  cob_pfijo..pf_rango_prorroga
      order by rp_mnemonico
   end
   
   if @i_modo = 1 begin
      select
      'COD. PRORROGA'  = rp_mnemonico,
      'DESCRIPCION'    = rp_descripcion,
      'RANGO MINIMO'   = rp_prorroga_min,
      'RANGO MAXIMO'   = rp_prorroga_max,
	  'SECUENCIAL'     = rp_tipo_rango
      from  cob_pfijo..pf_rango_prorroga
      where rp_mnemonico > @i_mnemonico
      order by rp_mnemonico
   end
   
   set rowcount 0 
   return 0 
end

if @i_operacion = 'Q' begin
   if @t_trn <> 14472 begin
      exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 141040
      return 1
   end
   
   select
   rp_mnemonico,
   substring(rp_descripcion,1,30),
   rp_prorroga_min,
   rp_prorroga_max
   from  cob_pfijo..pf_rango_prorroga
   where rp_tipo_rango = @i_rango_prorroga
   
   if @@rowcount = 0 begin
      exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 148003
      return 1
   end
   
   return 0  
end

if @i_operacion = 'H' begin
   if @t_trn <> 14672 begin
      exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 141040
      return 1
   end
   
   if @i_tipo = 'A' begin
      set rowcount 20
      if @i_modo = 0 begin
         select
         'COD. PRORROGA'  = rp_mnemonico,
         'DESCRIPCION'    = rp_descripcion,
         'RANGO MINIMO'   = rp_prorroga_min,
         'RANGO MAXIMO'   = rp_prorroga_max,
	     'SECUENCIAL'     = rp_tipo_rango
         from  cob_pfijo..pf_rango_prorroga
         order by rp_tipo_rango
     end
      if @i_modo = 1 begin
         select
         'COD. PRORROGA'  = rp_mnemonico,
         'DESCRIPCION'    = rp_descripcion,
         'RANGO MINIMO'   = rp_prorroga_min,
         'RANGO MAXIMO'   = rp_prorroga_max,
	     'SECUENCIAL'     = rp_tipo_rango
         from  cob_pfijo..pf_rango_prorroga
         where rp_tipo_rango > @i_rango_prorroga
         order by rp_tipo_rango
     end
     set rowcount 0
     return 0
   end
   
   if @i_tipo = 'B' begin
      set rowcount 20
      if @i_modo = 0 begin
         select
         'COD. PRORROGA'  = rp_mnemonico,
         'DESCRIPCION'    = rp_descripcion,
         'RANGO MINIMO'   = rp_prorroga_min,
         'RANGO MAXIMO'   = rp_prorroga_max,
	     'SECUENCIAL'     = rp_tipo_rango
         from  cob_pfijo..pf_rango_prorroga
         where rp_descripcion like @i_valor
         order by rp_descripcion
     end
     set rowcount 0
     return 0
   end
   
   if @i_tipo = 'V' begin
      set rowcount 20
     
      select      
      substring(rp_descripcion,1,30),
      rp_prorroga_min,
      rp_prorroga_max,
	  rp_mnemonico
      from  cob_pfijo..pf_rango_prorroga
      where rp_mnemonico = @i_mnemonico
      order by rp_descripcion
     
      if @@rowcount = 0 begin
         exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 148003
         return 1
      end
     
     set rowcount 0
     return 0
   end
end
go
