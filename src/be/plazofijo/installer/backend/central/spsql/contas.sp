/************************************************************************/
/*  Archivo               : contas.sp                                   */
/*  Stored procedure      : sp_contas                                   */
/*  Base de datos         : cob_pfijo                                   */
/*  Producto              : Plazo_fijo                                  */
/*  Disenado por          : Myriam Davila                               */
/*  Fecha de documentacion: 24/Nov/94                                   */
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
/*  Este programa realiza la consulta de las tasas vigentes             */
/*  ya sea dado tipo de operacion, moneda y tipo de plazo o tipo        */
/*  de monto.                                                           */
/*                      MODIFICACIONES                                  */
/*  FECHA               AUTOR              RAZON                        */
/*  24/Nov/94           R. Serrano         Emision Inicial              */
/*  24/Nov/2015         M. Jimenez         Correcciones                 */
/*  26/Sep/2016         O. Saavedra        DPF-S84160 Consulta Tasas    */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS ON
go

SET QUOTED_IDENTIFIER ON
go

if exists (select 1 from sysobjects where name = 'sp_contas')
   drop proc sp_contas
go

create proc sp_contas (
@s_ssn                    int         = null,
@s_user                   login       = null,
@s_term                   varchar(30) = null,
@s_date                   datetime    = null,
@s_srv                    varchar(30) = null,
@s_lsrv                   varchar(30) = null,
@s_ofi                    smallint    = null,
@s_rol                    smallint    = null,
@t_debug                  char(1)     = 'N',
@t_file                   varchar(10) = null,
@t_from                   varchar(32) = null,
@t_trn                    smallint,
@i_operacion              char(1),
@i_toperacion             catalogo,
@i_moneda                 tinyint, 
@i_tipo_monto             varchar(10)  = null,
@i_tipo_plazo             varchar(10)  = null,
@i_modo                   smallint     = 0,
@i_tipo_tasa              char(1)      = 'N',
@i_momento                varchar(10)  = null,
@i_id                     int          = 0)
with encryption
as
declare 
@w_sp_name                varchar(32),
@w_existe                 char(1)

select @w_sp_name = 'sp_contas'

if @t_trn <> 14804 begin
   exec cobis..sp_cerror
   @t_debug = @t_debug,
   @t_file  = @t_file,
   @t_from  = @w_sp_name,
   @i_num   = 141018
   return 1
end

if @i_operacion = 'P' begin
   select @i_tipo_monto = case @i_modo when 0 then '' else @i_tipo_monto end 
 
   set rowcount 20
   select
   'TIPO DE MONTO'        = ta_tipo_monto, 
   'TASA VIGENTE'         = ta_vigente 
   from  pf_tasa 
   where ta_tipo_deposito = @i_toperacion
   and   ta_moneda        = @i_moneda 
   and   ta_tipo_plazo    = @i_tipo_plazo 
   and   ta_tipo_monto    > @i_tipo_monto
   and   ta_tipo          = @i_tipo_tasa
   order by ta_tipo_monto
   
   if @@rowcount = 0 begin
      exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 141036
      return 1
   end

   set rowcount 0 
   return 0   
end 

if @i_operacion = 'M' begin
   select @i_tipo_plazo = case @i_modo when 0 then '' else @i_tipo_plazo end 
   
   set rowcount 20
   select
   'TIPO DE PLAZO'        = ta_tipo_plazo, 
   'TASA VIGENTE'         = ta_vigente 
   from  pf_tasa 
   where ta_tipo_deposito = @i_toperacion
   and   ta_moneda        = @i_moneda 
   and   ta_tipo_monto    = @i_tipo_monto
   and   ta_tipo          = @i_tipo_tasa 
   and   ta_tipo_plazo    > @i_tipo_plazo
   order by ta_tipo_plazo
   
   if @@rowcount = 0 begin
      exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 141036
      return 1
   end
   
   set rowcount 0 
   return 0   
end

if @i_operacion = 'F' begin
   select @i_tipo_plazo = case @i_modo when 0 then '' else @i_tipo_plazo end 

   set rowcount 20
   
   select @w_existe = td_tasa_variable
   from   pf_tipo_deposito
   where  td_mnemonico = @i_toperacion
   
   if @w_existe = 'S' begin
      if OBJECT_ID(N'tempdb..#tasa', N'U') is not null
         drop table #tasa

      create table #tasa(
	  id                    int           identity,
      tv_mnemonico_tasa     varchar(10)   null,
      tv_moneda             tinyint       null,
      tv_tipo_monto         varchar(10)   null,
      tv_tipo_plazo         varchar(10)   null,
      tv_spread_min         float         null,
      tv_spread_max         float         null,
      tv_spread_vigente     float         null,
      tv_operador           char(1)       null,
      mo_descripcion        varchar(64)   null,
      tv_tasa_min           float         null,
      tv_tasa_max           float         null,
      tv_tipo_pago          varchar(10)   null)   

      insert into #tasa
      select
      tv_mnemonico_tasa,
      tv_moneda,
      tv_tipo_monto,
      tv_tipo_plazo,
      tv_spread_min,
      tv_spread_max,
      tv_spread_vigente,
      tv_operador,
      mo_descripcion,
      tv_tasa_min,
      tv_tasa_max,
      tv_tipo_pago
      from  cob_pfijo..pf_tasa_variable, cobis..cl_moneda
      where tv_mnemonico_prod = @i_toperacion
      and   tv_moneda         = mo_moneda
      order by tv_moneda, tv_mnemonico_prod, tv_mnemonico_tasa, tv_tipo_monto, tv_tipo_plazo, tv_tipo_pago 
   
      select
	  'TIPO DE PLAZO'      = tv_tipo_plazo,
      'FORMA DE PAGO'      = ta_tipo_pago,
      'TASA VIGENTE'       = tv_spread_vigente
      from #tasa, pf_tasa 
      where id > 0
      and ta_tipo_deposito = @i_toperacion
      and ta_moneda        = tv_moneda
      and ta_tipo_monto    = tv_tipo_monto
      and ta_tipo_plazo    = tv_tipo_plazo
      order by id
	  
      if @@rowcount = 0 begin
         exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 141036
         return 1
      end
   end
   else begin
      select
      'TIPO DE PLAZO'        = ta_tipo_plazo, 
      'FORMA DE PAGO'        = ta_tipo_pago,
      'TASA VIGENTE'         = ta_vigente 
      from  pf_tasa 
      where ta_tipo_deposito = @i_toperacion
      and   ta_moneda        = @i_moneda 
      and   ta_tipo_monto    = @i_tipo_monto
      and   ta_tipo          = @i_tipo_tasa 
      and   ta_tipo_plazo    > @i_tipo_plazo
      order by ta_tipo_plazo, isnull(ta_tipo_pago,'0')
	  
      if @@rowcount = 0 begin
         exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 141036
         return 1
      end
   end
   
   set rowcount 0
   return 0
end

if @i_operacion = 'T' begin

   if OBJECT_ID(N'tempdb..#TasasVigentes', N'U') is not null
      drop table #TasasVigentes

   create table #TasasVigentes(
   tv_id              int            identity,
   tv_tipo_deposito   varchar(10)    null,
   tv_momento         varchar(10)    null,
   tv_moneda          int            null,
   tv_tipo_monto      varchar(10)    null,
   tv_desc_monto      varchar(60)    null,
   tv_monto_min       money          null,
   tv_monto_max       money          null,
   tv_tipo_plazo      varchar(10)    null,
   tv_desc_plazo      varchar(60)    null,
   tv_plazo_min       smallint       null,
   tv_plazo_max       smallint       null,
   tv_prorroga        varchar(10)    null,
   tv_desc_prorroga   varchar(60)    null,
   tv_prorroga_min    smallint       null,
   tv_prorroga_max    smallint       null,
   tv_segmento        varchar(10)    null,
   tv_ivc             varchar(10)    null,
   tv_tasa_min        float          null,
   tv_tasa_max        float          null,
   tv_vigente         float          null,
   tv_nemonico_tasa   varchar(10)    null,
   tv_operador        char(1)        null,
   tv_spread_min      float          null,
   tv_spread_max      float          null)

   insert into #TasasVigentes
   select
   tv_mnemonico_prod,
   tv_momento,
   tv_moneda,
   tv_tipo_monto,
   pf_monto.mo_descripcion,
   mo_monto_min,
   mo_monto_max,
   tv_tipo_plazo,
   pl_descripcion,
   pl_plazo_min,
   pl_plazo_max,
   tv_prorroga,
   rp_descripcion,
   rp_prorroga_min,
   rp_prorroga_max,
   tv_segmento,
   tv_ivc,
   tv_tasa_min,
   tv_tasa_max,
   null,
   tv_mnemonico_tasa,
   tv_operador,
   tv_spread_min,
   tv_spread_max
   from  pf_tasa_variable left join pf_rango_prorroga on tv_prorroga   = rp_mnemonico
                               join pf_monto          on tv_tipo_monto = mo_mnemonico
                               join pf_plazo          on tv_tipo_plazo = pl_mnemonico
                               join cobis..cl_moneda  on tv_moneda     = mo_moneda
   where (tv_mnemonico_prod = @i_toperacion or @i_toperacion is null)
   and   (tv_moneda         = @i_moneda     or @i_moneda     is null)
   and   (tv_momento        = @i_momento    or @i_momento    is null)
   union
   select
   ta_tipo_deposito,
   ta_momento,
   ta_moneda,
   ta_tipo_monto,
   pf_monto.mo_descripcion,
   mo_monto_min,
   mo_monto_max,
   ta_tipo_plazo,
   pl_descripcion,
   pl_plazo_min,
   pl_plazo_max,
   ta_prorroga,
   rp_descripcion,
   rp_prorroga_min,
   rp_prorroga_max,
   ta_segmento,
   ta_ivc,
   ta_tasa_min,
   ta_tasa_max,
   ta_vigente,
   null,
   null,
   null,
   null
   from  pf_tasa left join pf_rango_prorroga on ta_prorroga   = rp_mnemonico
                      join pf_monto          on ta_tipo_monto = mo_mnemonico
   				      join pf_plazo          on ta_tipo_plazo = pl_mnemonico
   				      join cobis..cl_moneda  on ta_moneda     = mo_moneda
   where (ta_tipo_deposito = @i_toperacion or @i_toperacion is null)
   and   (ta_moneda        = @i_moneda     or @i_moneda     is null)
   and   (ta_momento       = @i_momento    or @i_momento is null)
   
   set rowcount 20
   
   select
   'TIPO DE DEPOSITO' = tv_tipo_deposito,
   'MOMENTO'          = tv_momento,
   'MONEDA'           = tv_moneda,
   'MONTO'            = tv_tipo_monto,
   'DESC. MONTO'      = tv_desc_monto,
   'MONTO MIN'        = tv_monto_min,
   'MONTO MAX'        = tv_monto_max,
   'PLAZO'            = tv_tipo_plazo,
   'DESC. PLAZO'      = tv_desc_plazo,
   'PLAZO MIN'        = tv_plazo_min,
   'PLAZO MAX'        = tv_plazo_max,
   'PRORROGA'         = tv_prorroga,
   'DESC. PRORROGA'   = tv_desc_prorroga,
   'ID'               = tv_id,
   'RANGO MIN'        = tv_prorroga_min,
   'RANGO MAX'        = tv_prorroga_max,
   'SEGMENTO'         = tv_segmento,
   'DESC. SEGMENTO'   = (select distinct c.valor from cobis..cl_tabla t, cobis..cl_catalogo as c where t.codigo = c.tabla and c.codigo = tv_segmento and t.tabla = 'pf_segmento'),
   'IVC'              = tv_ivc,
   'DESC IVC'         = (select distinct c.valor from cobis..cl_tabla t, cobis..cl_catalogo as c where t.codigo = c.tabla and c.codigo = tv_ivc and t.tabla = 'pf_ivc'),
   'TASA MIN'         = tv_tasa_min,
   'TASA MAX'         = tv_tasa_max,
   'TASA VIGENTE'     = tv_vigente,
   'TASA REFERENCIA'  = tv_nemonico_tasa,
   'OPERADOR'         = tv_operador,
   'SPREAD MIN'       = tv_spread_min,
   'SPREAD MAX'       = tv_spread_max
   from  #TasasVigentes
   where tv_id > @i_id
   order by tv_id
   
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
go
