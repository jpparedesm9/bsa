/************************************************************************/
/*   Stored procedure:     sp_mayba    frmayba                          */
/*   Base de datos:        cob_conta                                    */
/************************************************************************/
/*                                  IMPORTANTE                          */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'MACOSA'                                                           */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de MACOSA o su representante.                */
/************************************************************************/
/*                            PROPOSITO                                 */
/*  Extracción de información para generación del reporte de front end  */
/*  mayor y balance.                                                    */
/************************************************************************/
 
use cob_conta
go
 
if exists (select 1 from sysobjects where name = 'sp_extramov_mayba')
   drop proc sp_extramov_mayba
go
 
create proc sp_extramov_mayba (
       @s_ssn               int             = NULL,
       @s_date              datetime        = NULL,
       @s_term              varchar(30)     = NULL,
       @s_sesn              int             = NULL,
       @s_srv               varchar(30)     = NULL,
       @s_lsrv              varchar(30)     = NULL,
       @s_user              varchar(30)     = NULL,
       @s_ofi               smallint        = NULL,
       @s_rol               smallint        = NULL,
       @s_ssn_corr          int             = NULL,
       @s_org               char(1)         = NULL,
       @s_ssn_branch        int             = NULL,
       @t_debug             char(1)         = NULL,
       @t_file              varchar(14)     = NULL,
       @t_trn               smallint        = NULL,
       @t_corr              char(1)         = 'N', 
       @t_ssn_corr          int             = NULL, 
       @i_empresa            tinyint,
       @i_oficina            smallint       = 255,
       @i_area               smallint       = 255,
       @i_fecha_ini          datetime       = null,
       @i_fecha_fin          DATETIME       = null,
       @i_nivel_cuenta       tinyint        = 99,
       @i_finperiodo         char(1)        = 'N',
       @i_operacion          char(1)        = null,
       @i_formato_fecha      smallint       = 103,
       @i_tipo_reporte       char(1)        = null
)
as
declare 
        @w_estado_ini                char(1),
        @w_corte_ini                 int,
        @w_periodo_ini               int,
        @w_estado_1                  char(1),
        @w_corte_1                   int,
        @w_periodo_1                 int,
        @w_estado_fin                char(1),
        @w_corte_fin                 int,
        @w_periodo_fin               INT,
        @w_fecha_fin_periodo         date,
        @w_periodo_final             int,
        @w_sp_name                   varchar(24),
        @w_error                     int,
        @w_cont                      int


create table #cb_libromov_mayba
(
	lm_oficina      smallint,
	lm_area         smallint,
	lm_cuenta       varchar (15),
	lm_nombre       varchar (255),
	lm_saldo_ini    float,
	lm_saldo_ini_me float,
	lm_saldo_fin    float,
	lm_saldo_fin_me float,
	lm_saldo_pro    float,
	lm_saldo_pro_me float,
	lm_debito       float,
	lm_debito_me    float,
	lm_credito      float,
	lm_credito_me   float,
	lm_user         varchar (15),
	lm_date         date,
	lm_secuencial   int
)       

CREATE CLUSTERED INDEX idx_cb_libromov_mayba on #cb_libromov_mayba (lm_cuenta)

select @w_sp_name = 'sp_extramov_mayba'

if (@t_trn <> 6002 and @i_operacion = 'I') or
   (@t_trn <> 6003 and @i_operacion = 'S')
begin
   exec cobis..sp_cerror
   @t_debug = @t_debug,
   @t_file	 = @t_file,
   @t_from	 = @w_sp_name,
   @i_num	 = 601077
   return 1
end

if @i_operacion = 'S' or @i_operacion = 'I'
begin
   select @w_periodo_final = co_periodo
   from cob_conta..cb_corte
   where co_estado = 'A'
   and co_empresa = @i_empresa
   
   if @w_periodo_final is null
   begin
      select @w_error = 609315
      goto ERROR
   end
 
   select @w_fecha_fin_periodo = MAX(co_fecha_ini)
   from cob_conta..cb_corte
   where co_empresa = @i_empresa
   and   co_periodo = @w_periodo_final - 1
/* VALIDA SI ES EL PRIMER PERIODO CONTABLE*/
   if @w_fecha_fin_periodo is null
   begin
      select @w_fecha_fin_periodo = MIN(co_fecha_ini)
      from cob_conta..cb_corte
      where co_empresa = @i_empresa
      and   co_periodo = @w_periodo_final 

      select @w_fecha_fin_periodo = dateadd(dd,-1, @w_fecha_fin_periodo)
   end
   
   select convert(varchar(10),@w_fecha_fin_periodo,@i_formato_fecha)
   --return 0
end

if @i_operacion = 'I'
begin

/* BORRAR REGISTROS DE BUSQUEDAS PREVIAS*/
   delete cob_conta..cb_libromov_mayba
   where lm_user = @s_user or lm_date < @s_date
   
   
   /* CONTROL DE FECHAS */
   if @i_fecha_ini >= @i_fecha_fin 
   begin
      select @w_error = 609316
      goto ERROR
   end
   
   /* DETERMINAR CORTE Y PERIODO INICIAL*/
   select	
   @w_corte_ini    = isnull(max(co_corte),0),
   @w_periodo_ini  = max(co_periodo),
   @w_estado_ini   = max(co_estado)
   from    cb_corte with(nolock)
   where   co_empresa   = @i_empresa
   and     co_fecha_ini >= @i_fecha_ini
   and     co_fecha_fin <= @i_fecha_ini
   
   if @w_corte_ini = 0 begin
      select @w_error = 609317
      goto ERROR
   end
   
   if @w_estado_ini = 'A' begin
      select @w_error = 609318
      goto ERROR
   end
   
   /* DETERMINAR CORTE Y PERIODO DEL DIA INICIO MAS 1 */
   select	
   @w_corte_1    = isnull(max(co_corte),0),
   @w_periodo_1  = max(co_periodo),
   @w_estado_1   = max(co_estado)
   from    cb_corte with(nolock)
   where   co_empresa   = @i_empresa
   and     co_fecha_fin = dateadd(dd,1,@i_fecha_ini)
   
   if @w_corte_ini = 0 begin
      select @w_error = 609319
      goto ERROR
   end
   
   /* DETERMINAR CORTE Y PERIODO FINAL*/
      select	
      @w_corte_fin    = isnull(max(co_corte),0),
      @w_periodo_fin  = max(co_periodo),
      @w_estado_fin   = max(co_estado)
      from    cb_corte with(nolock)
      where   co_empresa   = @i_empresa
      and     co_fecha_ini >= @i_fecha_fin
      and     co_fecha_fin <= @i_fecha_fin
      
      if @w_corte_fin = 0 begin
         select @w_error = 609320
         goto ERROR
      end
   
   if (isnull(@w_periodo_ini,0) != isnull(@w_periodo_fin,0) and (@i_fecha_ini <> @w_fecha_fin_periodo))
   begin
      select @w_error = 609321
      goto ERROR
   end
   
   if @i_finperiodo = 'S'
   begin
      if @i_fecha_ini <> @w_fecha_fin_periodo
      begin
         select @w_error = 609322
         goto ERROR
      end
      select @w_corte_ini    = @w_corte_ini + 1
   end 
   /* INSERTAR SALDOS INICIALES */
   select
   oficina    = hi_oficina,
   periodo    = hi_periodo,
   corte      = hi_corte,
   cuenta     = hi_cuenta,
   debito     = sum(hi_debito),
   credito    = sum(hi_credito),
   saldo      = sum(hi_saldo),
   debito_me  = sum(hi_debito_me),
   credito_me = sum(hi_credito_me),
   saldo_me   = sum(hi_saldo_me)
   into #saldos 
   from cob_conta_his..cb_hist_saldo with(nolock)
   where hi_empresa = @i_empresa
   and   hi_periodo = @w_periodo_ini
   and   hi_corte   = @w_corte_ini
   and   hi_oficina in (select je_oficina from cb_jerarquia where je_empresa = @i_empresa and je_oficina_padre = @i_oficina)
   and   hi_area    in (select ja_area    from cb_jerararea where ja_empresa = @i_empresa and ja_area_padre    = @i_area)
   group by hi_oficina, hi_periodo, hi_corte, hi_cuenta
   
   
   /* INSERTAR SALDOS INTERMEDIOS DE HISTORICOS */
   insert into #saldos
   select
   oficina    = hi_oficina,
   periodo    = hi_periodo,
   corte      = hi_corte,
   cuenta     = hi_cuenta,
   debito     = sum(hi_debito),
   credito    = sum(hi_credito),
   saldo      = sum(hi_saldo),
   debito_me  = sum(hi_debito_me),
   credito_me = sum(hi_credito_me),
   saldo_me   = sum(hi_saldo_me)
   from cob_conta_his..cb_hist_saldo with(nolock)
   where hi_empresa = @i_empresa
   and   hi_periodo = @w_periodo_fin
   and   hi_corte   between @w_corte_1 and @w_corte_fin
   and   hi_oficina in (select je_oficina from cb_jerarquia where je_empresa = @i_empresa and je_oficina_padre = @i_oficina)
   and   hi_area    in (select ja_area    from cb_jerararea where ja_empresa = @i_empresa and ja_area_padre    = @i_area)
   group by hi_oficina, hi_periodo, hi_corte, hi_cuenta
   
   
   
   /* INSERTAR SALDOS INTERMEDIOS DE COB_CONTA */
   if @w_estado_fin = 'A' begin
   
      insert into #saldos
      select
      oficina    = sa_oficina,
      periodo    = sa_periodo,
      corte      = sa_corte,
      cuenta     = sa_cuenta,
      debito     = sum(sa_debito),
      credito    = sum(sa_credito),
      saldo      = sum(sa_saldo),
      debito_me  = sum(sa_debito_me),
      credito_me = sum(sa_credito_me),
      saldo_me   = sum(sa_saldo_me)
      from cob_conta..cb_saldo with(nolock)
      where sa_empresa = @i_empresa
      and   sa_periodo = @w_periodo_fin
      and   sa_corte   = @w_corte_fin
      and   sa_oficina in (select je_oficina from cb_jerarquia where je_empresa = @i_empresa and je_oficina_padre = @i_oficina)
      and   sa_area    in (select ja_area    from cb_jerararea where ja_empresa = @i_empresa and ja_area_padre    = @i_area)
      group by sa_oficina, sa_periodo, sa_corte, sa_cuenta
   
   end
   
   begin tran
   
   if @i_tipo_reporte = 'O'
   begin
          insert into #cb_libromov_mayba
          select
          lm_oficina      = oficina,    
          lm_area         = @i_area,  
          lm_cuenta       = cuenta,       
          lm_nombre       = cu_nombre,
          lm_saldo_ini    = isnull(sum(case when periodo = @w_periodo_ini and corte = @w_corte_ini then saldo      else 0 end),0),
          lm_saldo_ini_me = isnull(sum(case when periodo = @w_periodo_ini and corte = @w_corte_ini then saldo_me   else 0 end),0),
          lm_saldo_fin    = isnull(sum(case when periodo = @w_periodo_fin and corte = @w_corte_fin then saldo      else 0 end),0),
          lm_saldo_fin_me = isnull(sum(case when periodo = @w_periodo_fin and corte = @w_corte_fin then saldo_me   else 0 end),0),
          lm_saldo_pro    = isnull(sum(case when corte between @w_corte_1 and @w_corte_fin then saldo              else 0 end),0) / (@w_corte_fin - @w_corte_1 + 1), 
          lm_saldo_pro_me = isnull(sum(case when corte between @w_corte_1 and @w_corte_fin then saldo_me           else 0 end),0) / (@w_corte_fin - @w_corte_1 + 1), 
          lm_debito       = isnull(sum(case when periodo = @w_periodo_fin and corte = @w_corte_fin then debito     else 0 end),0) -
                            isnull(sum(case when periodo = @w_periodo_ini and corte = @w_corte_ini then debito     else 0 end),0),
          lm_debito_me    = isnull(sum(case when periodo = @w_periodo_fin and corte = @w_corte_fin then debito_me  else 0 end),0) -
                            isnull(sum(case when periodo = @w_periodo_ini and corte = @w_corte_ini then debito_me  else 0 end),0),
          lm_credito      = isnull(sum(case when periodo = @w_periodo_fin and corte = @w_corte_fin then credito    else 0 end),0) -
                            isnull(sum(case when periodo = @w_periodo_ini and corte = @w_corte_ini then credito    else 0 end),0),
          lm_credito_me   = isnull(sum(case when periodo = @w_periodo_fin and corte = @w_corte_fin then credito_me else 0 end),0) -
                            isnull(sum(case when periodo = @w_periodo_ini and corte = @w_corte_ini then credito_me else 0 end),0),
          lm_user         = @s_user,
          lm_date         = @s_date,
          0
          from #saldos, cb_cuenta
          where cuenta     = cu_cuenta
          and   cu_empresa = @i_empresa
          and   cu_nivel_cuenta  <= @i_nivel_cuenta
          group by oficina, cuenta, cu_nombre
          order by oficina, cuenta, cu_nombre
   end    
   else    
   begin   
          insert into #cb_libromov_mayba
          select          
          lm_oficina      = @i_oficina,    
          lm_area         = @i_area,  
          lm_cuenta       = cuenta,       
          lm_nombre       = cu_nombre,
          lm_saldo_ini    = isnull(sum(case when periodo = @w_periodo_ini and corte = @w_corte_ini then saldo      else 0 end),0),
          lm_saldo_ini_me = isnull(sum(case when periodo = @w_periodo_ini and corte = @w_corte_ini then saldo_me   else 0 end),0),
          lm_saldo_fin    = isnull(sum(case when periodo = @w_periodo_fin and corte = @w_corte_fin then saldo      else 0 end),0),
          lm_saldo_fin_me = isnull(sum(case when periodo = @w_periodo_fin and corte = @w_corte_fin then saldo_me   else 0 end),0),
          lm_saldo_pro    = isnull(sum(case when corte between @w_corte_1 and @w_corte_fin then saldo              else 0 end),0) / (@w_corte_fin - @w_corte_1 + 1), 
          lm_saldo_pro_me = isnull(sum(case when corte between @w_corte_1 and @w_corte_fin then saldo_me           else 0 end),0) / (@w_corte_fin - @w_corte_1 + 1), 
          lm_debito       = isnull(sum(case when periodo = @w_periodo_fin and corte = @w_corte_fin then debito     else 0 end),0) -
                            isnull(sum(case when periodo = @w_periodo_ini and corte = @w_corte_ini then debito     else 0 end),0),
          lm_debito_me    = isnull(sum(case when periodo = @w_periodo_fin and corte = @w_corte_fin then debito_me  else 0 end),0) -
                            isnull(sum(case when periodo = @w_periodo_ini and corte = @w_corte_ini then debito_me  else 0 end),0),
          lm_credito      = isnull(sum(case when periodo = @w_periodo_fin and corte = @w_corte_fin then credito    else 0 end),0) -
                            isnull(sum(case when periodo = @w_periodo_ini and corte = @w_corte_ini then credito    else 0 end),0),
          lm_credito_me   = isnull(sum(case when periodo = @w_periodo_fin and corte = @w_corte_fin then credito_me else 0 end),0) -
                            isnull(sum(case when periodo = @w_periodo_ini and corte = @w_corte_ini then credito_me else 0 end),0),
          lm_user         = @s_user,
          lm_date         = @s_date,
          0
          from #saldos, cb_cuenta
          where cuenta     = cu_cuenta
          and   cu_empresa = @i_empresa
          and   cu_nivel_cuenta  <= @i_nivel_cuenta
          group by  cuenta, cu_nombre
          order by  cuenta, cu_nombre
   end   
   
   select @w_cont = 0
   update #cb_libromov_mayba  
   set   lm_secuencial = @w_cont,
         @w_cont       = @w_cont + 1
   where  lm_user         = @s_user
   and    lm_date         = @s_date
   
   
   insert into cb_libromov_mayba(
   lm_oficina      ,   lm_area        ,	lm_cuenta      ,
   lm_nombre       ,   lm_saldo_ini   ,	lm_saldo_ini_me,
   lm_saldo_fin    ,   lm_saldo_fin_me,	lm_saldo_pro   ,
   lm_saldo_pro_me ,   lm_debito      , lm_debito_me   ,
   lm_credito      ,   lm_credito_me  ,	lm_user        ,
   lm_date         ,   lm_secuencial  )       
   select 
   lm_oficina      ,   lm_area        ,	lm_cuenta      ,
   lm_nombre       ,   lm_saldo_ini   ,	lm_saldo_ini_me,
   lm_saldo_fin    ,   lm_saldo_fin_me,	lm_saldo_pro   ,
   lm_saldo_pro_me ,   lm_debito      , lm_debito_me   ,
   lm_credito      ,   lm_credito_me  ,	lm_user        ,
   lm_date         ,   lm_secuencial         
   from #cb_libromov_mayba
   
   
   
   commit tran
end

return 0
ERROR:

   exec cobis..sp_cerror
        @t_debug    = @t_debug,
        @t_file     = @t_file,
        @t_from     = @w_sp_name,
        @i_num      = @w_error
        
   return @w_error
go



