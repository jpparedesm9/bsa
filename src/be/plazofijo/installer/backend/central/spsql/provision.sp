/*bt_prov.sp */
/************************************************************************/
/*      Archivo:                bt_prov.sp                              */
/*      Stored procedure:       sp_provision                            */
/*      Base de datos:          cob_pfijo                               */
/*      Producto:               Plazo Fijo                              */
/*      Disenado por:           Ricardo Alvarez                         */
/*      Fecha de documentacion: 24-Feb-2004                             */
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
/*      Este script crea los procedimientos para los calculos diarios   */
/*      de intereses del Modulo de Plazo Fijo.                          */
/*      La provision de dias feriados se realiza el ult dia laborable   */
/*      previo al feriado                                               */
/*                              MODIFICACIONES                          */
/*      FECHA      AUTOR              RAZON                             */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists ( select 1 from sysobjects where name = 'sp_provision' and type = 'P')
   drop proc sp_provision
go

create proc sp_provision (
@s_ssn                  int             = NULL,
@s_user                 login           = NULL,
@s_term                 varchar(30)     = NULL,
@s_date                 datetime        = NULL,
@s_srv                  varchar(30)     = NULL,
@s_lsrv                 varchar(30)     = NULL,
@s_ofi                  smallint        = NULL,
@s_rol                  smallint        = NULL,
@t_debug                char(1)         = 'N',
@t_file                 varchar(10)     = NULL,
@t_from                 varchar(32)     = NULL,
@t_trn                  int             = 14926,
@i_dias_interes         int             = 1,
@i_fecha_proceso        datetime,
@i_tipo                 char(1)         = 'N',
@i_tipo_act             char(1)         = 'N',
@i_fecha_corrida        datetime        = NULL,
@i_fecha_laborable      datetime        = NULL,
@i_oficina              int             = NULL,
@o_fecha_contable       datetime        = NULL out)
with encryption
as
declare   
@w_sp_name                    descripcion,
@w_descripcion                descripcion,
@w_return                     int,
@w_numdeci                    tinyint,
@w_usadeci                    char(1),
@w_fecha_hoy                  datetime,
@w_fecha                      datetime,
@w_fecha_siguiente            datetime,
@w_ult_fecha_calculo          datetime,
@w_tot_intereses              float,
@w_interes_ini                float,
@w_interes_fin                float,
@w_intereses_dia              float,
@w_money                      money,
@w_error                      int,
@w_cont                       tinyint,
@w_int_neto                   money,    
@w_impto_retenido             money,
@w_op_int_ganado              money, 
@w_op_int_pagados             money,
@w_op_total_int_pagados       money,
@w_dif_fecha                  int,      
@w_diferencia                 float,    
@w_dias                       int,      -- Dias para la oficina desde la ultima fecha de calculo hasta el siguiente dia habil       
@w_num_meses                  tinyint,

/** VARIABLES PARA PF_OPERACION **/
@w_op_int_provision           float,
@w_op_producto                tinyint,
@w_op_oficina                 smallint, 
@w_op_ult_fecha_calculo       datetime,
@w_op_fecha_valor             datetime, 
@w_op_fecha_mod               datetime, 
@w_op_fecha_ven               datetime, 
@w_op_fecha_pg_int            datetime, --CVA Oct-13-05
@w_op_fecha_ult_pg_int        datetime, --+-+
@w_op_fecha_ult_pago_int_ant  datetime,  --CVA May-08-06
@w_op_total_int_ganados       money,    
@w_op_num_banco               cuenta,
@w_op_operacion               int,
@w_op_base_calculo            smallint,
@w_op_tasa                    float,
@w_op_monto                   money,
@w_op_monto_pg_int            money,
@w_op_estado                  catalogo,
@w_op_fpago                   catalogo,
@w_op_ppago                   catalogo,
@w_op_toperacion_ant          catalogo,
@w_op_toperacion              catalogo,
@w_op_tplazo                  catalogo,
@w_op_residuo                 float,
@w_op_moneda                  tinyint,
@w_op_tcapitalizacion         char(1),  
@w_op_int_estimado            money,    
@w_op_retienimp               char(1),  
@w_op_impuesto                float,    
@w_op_total_int_estimado      money, 
@w_op_ente                    int,  
@w_op_num_dias                int,
@w_op_tasa_variable           char(1),
@w_op_mnemonico_tasa          catalogo,
@w_op_ult_fecha_calven        datetime,
/** VARIABLES PARA PF_RETENCION **/
@w_mes_curso                  int,      -- Cambios  para Contabilizacion de acrue ASB
@w_mes_fin                    int,      -- Cambios  para Contabilizacion de acrue ASB
@w_mes_corrida                int,      -- Cambios  para Contabilizacion de acrue ASB
@w_operador                   char(1),
@w_fecha_ult_calculo          datetime,
@w_anio_fin                   int,
@w_dias_ini                   int,
@w_dias_fin                   int,
@w_op_ente_ant                int,
@w_op_oficina_ant             smallint,
@w_op_moneda_ant              tinyint,
@w_spread                     float,
@w_valor_tasa_var             float,
@w_ult_fecha_calven           datetime,
@w_td_tipo_tasa_var           char(1),
@w_op_prov_pendiente          float,
@w_ult_dia_mes_pago           tinyint,  --*-*
@o_comprobante                int,      --*-*
@w_dias_reales                char(1),  --*-*
@w_dia_pago                   tinyint,  --*-*
@w_ult_fech_periodo           int, --*-*
@w_intereses_1_dia            decimal(30,16),          --*-*
@w_acumulado_int_prov         decimal(30,16),          --*-*
@w_intereses_n_dia            decimal(30,16),          --*-*
@w_resto                      decimal(30,16),          --*-*
@w_ult_provision              int,      --*-*
@w_inicia_grupo               int,      --*-*
@w_fecha_contable             datetime, --*-*
@w_fecha_cont                 datetime, --+-+
@w_ciu                        int,      --*-*
@w_ciudad_feriados            smallint,   
@w_siguiente_dia              datetime, --*-*
@w_anterior_dia               datetime, --*-*     
@w_ciudad                     int,      --*-*
@w_tipo                       char(1),  --*-*
@w_fpago                      catalogo, --CVA Oct-13-05
@w_dif                        int,
@w_factor                     int,
@w_suma                       money,
@w_cont_ter                   char(1),
@w_contabilizar               char(1),
@w_debug                      char(1),
@w_contador                   int,
@w_fecha_actual               varchar(10),
@w_dia_ant_ven                datetime

select @w_debug = 'N'
select @w_contador = 0

------------------------------------------------------------------------------
-- Asignacion nombre de stored procedure e inicializacion de nuevas variables
------------------------------------------------------------------------------
select    @w_sp_name      = 'sp_provision'
select    @w_fecha        = convert(datetime, convert(varchar,@i_fecha_proceso,101))
select    @w_fecha_hoy    = @w_fecha,
          @w_inicia_grupo = 0,     --Para determinar que se debe iniciar otro grupo => begin tran
          @w_dif          = 0,
          @w_fecha_actual = convert(varchar(10),getdate(),101)

if @s_date is null
   select @s_date = fp_fecha from cobis..ba_fecha_proceso

-- Obtiene parametro para contabilizacion de terceros
select @w_cont_ter = isnull(pa_char,'N') from cobis..cl_parametro
where pa_nemonico = 'CTE'  and pa_tipo = 'C'    and pa_producto = 'PFI'

select @w_fecha_siguiente     = dateadd(dd,@i_dias_interes,@w_fecha_hoy)   --+-+ Por defecto deberia ser 1 dia. 
select @w_dias                = @i_dias_interes
select @w_tot_intereses       = 0

select @w_ciudad_feriados = pa_smallint
from cobis..cl_parametro
where pa_producto = 'ADM'
and   pa_nemonico = 'CIUN'

/******************************************************************************************************************/
--*-*Busca numero de dias de calculo por operacion => llenar tabla temporal de dias de calculo a considerar por dia
--*-*                                    de ejecucion de batch
create table #dias_calc_x_fecha_pf
(ciudad             int       null,
 fecha_contable     datetime  null
)

declare dias_calculo cursor for
select    of_ciudad
from cobis..cl_oficina
for read only
open dias_calculo
fetch dias_calculo into @w_ciu

while @@fetch_status = 0
begin
     
   --Busca dia siguiente habil para ciudad
   select @w_siguiente_dia = dateadd(day,1,@w_fecha_hoy) 
   while exists(select 1 from cobis..cl_dias_feriados
           where df_fecha  =  @w_siguiente_dia
             and df_ciudad =  @w_ciudad_feriados) 
   begin
        select @w_siguiente_dia = dateadd(day,1,@w_siguiente_dia)
   end -- WHILE
   
   --Busca hacia atras el dia anterior habil
   select @w_anterior_dia = dateadd(day,-1,@w_fecha_hoy) 
   while exists(select 1 from cobis..cl_dias_feriados
           where df_fecha  =  @w_anterior_dia
             and df_ciudad =  @w_ciudad_feriados) 
   begin
        select @w_anterior_dia = dateadd(day,-1,@w_anterior_dia)
   end -- WHILE        

   --*-*Si es feriado el dia de ejecucion => evaluar
   if exists(select 1 from cobis..cl_dias_feriados
           where df_fecha  =  @w_fecha_hoy
             and df_ciudad =  @w_ciudad_feriados) 
   begin
        --Preguntar si paso por un fin de mes iendo hacia adelante
        if datepart(mm,@w_fecha_hoy) < datepart(mm,@w_siguiente_dia)     
        begin
             --*-*=> Toma el ultimo dia habil anterior
             select @w_fecha_contable = @w_anterior_dia
        end
        else --No paso por fin de mes
        begin
             --Preguntar si paso por un fin de mes iendo hacia atras
             if datepart(mm,@w_fecha_hoy) > datepart(mm,@w_anterior_dia) or (datepart(yy,@w_fecha_hoy) > datepart(yy,@w_anterior_dia))
                  select @w_fecha_contable = @w_siguiente_dia
             else -- => Estoy dentro del mes
                  select @w_fecha_contable = @w_anterior_dia
        end
   end
   else
        select @w_fecha_contable = @w_fecha_hoy

   select @o_fecha_contable = @w_fecha_contable
   
   --Graba dias calculo para ciudad
   insert into #dias_calc_x_fecha_pf
   values (@w_ciu, @w_fecha_contable) 
   
   fetch dias_calculo into @w_ciu
end

if @@fetch_status = -2
begin
   close dias_calculo
   deallocate dias_calculo
   raiserror ('200001 - Fallo lectura del cursor dias_calculo', 16, 1)
   return 1
end



close dias_calculo
deallocate dias_calculo
/****************************************************************************************************************/

-- Acceso y declaracion de cursor sobre pf_operacion 
select @w_cont = 0

select
op_num_banco,            op_operacion,                 op_base_calculo,
op_tasa,                 op_fpago,                     op_tipo_plazo,
op_monto,                op_residuo,                   op_monto_pg_int,
op_producto,             op_estado,                    op_ult_fecha_calculo,
op_fecha_valor,          op_fecha_ven,                 op_moneda,
op_oficina,              op_toperacion,                op_int_provision,
op_total_int_ganados,    op_fecha_mod,                 op_tcapitalizacion,   
op_int_estimado      ,   op_retienimp,                 op_impuesto,          
op_total_int_estimado,   op_ente,                      op_ult_fecha_calven,
                op_int_ganado,                op_fecha_pg_int,
op_dias_reales,          op_dia_pago,                  op_fecha_ult_pg_int,
op_ppago,                op_fecha_ult_pago_int_ant,    op_int_pagados,
op_total_int_pagados,    op_acumulado = (select sum(isnull(pd_valor_calc,0))
                          from cob_pfijo..pf_prov_dia 
                          where pd_operacion = O.op_operacion
                          and   pd_fecha_proceso between isnull(O.op_fecha_ult_pg_int, '01/01/1900') and @w_fecha_hoy)  
into #operacion
from cob_pfijo..pf_operacion   O
where op_fecha_valor                            <= @w_fecha_hoy
and   isnull(op_ult_fecha_calculo,'01/01/1900') <  @w_fecha_hoy
and   isnull(op_ult_fecha_calculo,'01/01/1900') <  op_fecha_ven               --*-rrrr*-*-*-
and   op_estado                                 =  'ACT'
and   isnull(op_ult_fecha_calven,'01/01/1900')  <  @w_fecha_hoy
order by op_oficina, op_moneda, op_toperacion

create index idx1 on #operacion(op_operacion)

while 1 = 1 begin

   select top 1
   @w_op_num_banco          = op_num_banco        , @w_op_operacion              = op_operacion            , @w_op_base_calculo       = op_base_calculo,
   @w_op_tasa               = op_tasa             , @w_op_fpago                  = op_fpago                , @w_op_tplazo             = op_tipo_plazo,
   @w_op_monto              = op_monto            , @w_op_residuo                = op_residuo              , @w_op_monto_pg_int       = op_monto_pg_int,
   @w_op_producto           = op_producto         , @w_op_estado                 = op_estado               , @w_op_ult_fecha_calculo  = op_ult_fecha_calculo,
   @w_op_fecha_valor        = op_fecha_valor      , @w_op_fecha_ven              = op_fecha_ven            , @w_op_moneda             = op_moneda,
   @w_op_oficina            = op_oficina          , @w_op_toperacion             = op_toperacion           , @w_op_int_provision      = op_int_provision,
   @w_op_total_int_ganados  = op_total_int_ganados, @w_op_fecha_mod              = op_fecha_mod            , @w_op_tcapitalizacion    = op_tcapitalizacion,
   @w_op_int_estimado       = op_int_estimado     , @w_op_retienimp              = op_retienimp            , @w_op_impuesto           = op_impuesto,
   @w_op_total_int_estimado = op_total_int_estimado,@w_op_ente                   = op_ente                 , @w_op_ult_fecha_calven   = op_ult_fecha_calven,
   @w_op_int_ganado         = op_int_ganado       , @w_op_fecha_pg_int           = op_fecha_pg_int,
   @w_dias_reales           = op_dias_reales,       @w_dia_pago                  = op_dia_pago             , @w_op_fecha_ult_pg_int  = op_fecha_ult_pg_int,
   @w_op_ppago              = op_ppago,             @w_op_fecha_ult_pago_int_ant = op_fecha_ult_pago_int_ant, @w_op_int_pagados        = op_int_pagados,
   @w_op_total_int_pagados  = op_total_int_pagados, @w_acumulado_int_prov        = op_acumulado
   from #operacion

   if @@rowcount = 0 break
   
   select @w_fpago = @w_op_fpago
   
   delete #operacion
   where op_operacion = @w_op_operacion
   
   select @w_op_retienimp = 'N' --CVA Oct-13-05
   select @w_contabilizar = 'S' -- GAL 01/SEP/2009 - RVVUNICA 

   select @w_usadeci = mo_decimales
   from cobis..cl_moneda
   where mo_moneda = @w_op_moneda
   
   if @w_usadeci = 'S'
   begin
      select @w_numdeci = isnull (pa_tinyint,0)
      from cobis..cl_parametro
      where pa_nemonico = 'DCI'
      and   pa_producto = 'PFI'
   end
   else
      select @w_numdeci = 0
   
   -- Inicializacion de Variables 
   if @w_cont = 0
   begin
      select    @w_op_oficina_ant    = @w_op_oficina,
                @w_op_moneda_ant     = @w_op_moneda,
                @w_op_toperacion_ant = @w_op_toperacion, 
                @w_op_ente_ant       = 0
      select    @w_cont              = 1,
                @w_inicia_grupo      = 1
                
      if @w_cont_ter = 'N' 
         select @w_op_ente = @w_op_ente_ant                    
   end
   
   if @w_inicia_grupo = 1
   begin
      if @w_debug = 'S' begin
         print '**************HACE BEGIN TRAN CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC'     
      end 
      begin tran     --*-*-*-*-*-*-*--*-*-*-*-*-*-*--*-*-*-*-*-*-*--*-*-*-*-*-*-*--*-*-*-*-*-*-*--*-*-*-*-*-*-*--*-*-*-*-*-*-*--*-*-*-*-*-*-*
      select @w_inicia_grupo = 0
   end

     --*-* Inicializacion de varriables de montos
   select    @w_money            = @w_op_monto_pg_int,
             @w_intereses_dia    = 0,
             @w_diferencia       = 0,
             @w_intereses_1_dia  = 0,
             @w_intereses_n_dia  = 0  
   
   if @w_op_ult_fecha_calculo <> '01/01/1900'  -- reg antiguo
        select @w_ult_fecha_calculo= @w_op_ult_fecha_calculo
   else
        select @w_ult_fecha_calculo= dateadd(dd,-1,@w_op_fecha_valor)

   if @w_debug = 'S' begin
      print '@w_op_num_banco ' + cast(@w_op_num_banco  as varchar)
      print '@w_ult_fecha_calculo' + cast(@w_ult_fecha_calculo as varchar)
      print '@w_op_fpago' + cast(@w_op_fpago as varchar)
   end

   if @w_dias_reales = 'N'
   begin
      exec sp_funcion_1 
      @i_operacion = 'DIFE30',
      @i_fechai      = @w_ult_fecha_calculo,    
      @i_fechaf      = @w_fecha_hoy,       
      @i_dia_pago    = @w_dia_pago,         
      @i_batch       = 0,                --*-*                         
      @o_dias        = @w_dias out  
   
      if @w_debug = 'S' begin
         print '@w_dias ' + cast(@w_dias  as varchar)
         print '@w_op_fecha_valor ' + cast(@w_op_fecha_valor  as varchar)
         print '@s_date ' + cast(@s_date as varchar)
      end   


      --*-*Si es un 31 no debe provisionar
      if (datepart(dd,@w_fecha_hoy) = 31)  --*-*
           select @w_dias = 0

      if (datepart(dd,@w_fecha_hoy) = 31)  and datediff ( dd, convert(varchar(10),@w_op_fecha_valor,101), convert(varchar(10),@s_date,101) ) = 0         --*-*
           select @w_dias = 1

      if @w_debug = 'S' begin
        print '@w_dias ' + cast(@w_dias  as varchar)
      end  


      --*-*Si es febrero provisiona los dias que le faltan para cumplir 30 dias
      select @w_ult_dia_mes_pago = datepart(dd,dateadd(dd,datepart(dd,dateadd(mm,1,@w_fecha_hoy))*(-1),dateadd(mm,1,@w_fecha_hoy)))

      if datepart(mm,@w_fecha_hoy) = 2 and datepart(dd,@w_fecha_hoy) = @w_ult_dia_mes_pago
           select @w_dias = 30 - @w_ult_dia_mes_pago  + 1

      --*-*Si es marzo 1 debe provisionar solo un dia
      if datepart(mm,@w_fecha_hoy) = 3 and datepart(dd,@w_fecha_hoy) = 1
           select @w_dias = 1  
           
   end
   else begin
      select @w_dias      = datediff(dd,@w_ult_fecha_calculo,@w_fecha_hoy)
   end
   
   select @w_ult_provision       = datediff(dd,@w_fecha_hoy,@w_op_fecha_ven)
   select @w_ult_fech_periodo    = datediff(dd,@w_fecha_hoy,@w_op_fecha_pg_int)
   
   if @w_debug = 'S' begin
      print '@w_dias' + cast(@w_dias as varchar)
      print '@w_ult_provision' + cast(@w_ult_provision as varchar)
      print '@w_ult_fech_periodo' + cast(@w_ult_fech_periodo as varchar)
   end
     
   if @w_dias > 0           --*-*rrrr*-*-*no deberia ir esto porque si hoy fue el dia de pago => ya no debe ajustar  or @w_ult_fech_periodo = 0 or @w_ult_provision = 0 
   begin                     
      -- Calculo de intereses
      exec sp_calc_intereses 
      @monto     = @w_money,
      @dias_anio = @w_op_base_calculo,
      @tasa      = @w_op_tasa,
      @num_dias  = 1,
      @intereses = @w_intereses_1_dia out  
      
      select @w_intereses_n_dia = @w_intereses_1_dia * @w_dias  --provision considerando todos los decimales
      select @w_intereses_dia   = round(@w_intereses_1_dia,@w_numdeci) * @w_dias                

      if @w_debug = 'S' begin
        print '@w_acumulado_int_prov' + cast(@w_acumulado_int_prov as varchar)
        print '@w_acumulado_int_prov' + cast(@w_acumulado_int_prov as varchar) + ' w_intereses_n_dia ' + cast(@w_intereses_n_dia as varchar) + ' w_op_int_ganado ' + cast(@w_op_int_ganado as varchar)
        print '@w_intereses_dia' + cast(@w_intereses_dia as varchar)      
        end
      
      select @w_resto = (@w_acumulado_int_prov + @w_intereses_n_dia) - (@w_op_int_ganado + @w_intereses_dia)

      if @w_debug = 'S' begin
         print '@w_resto' + cast(@w_resto as varchar)
      end

      if ABS(round(@w_resto,@w_numdeci)) >= 0.01 begin
         --si la diferencia es > 0.01 entones sumar la diferencia al int acruado dia
         select @w_intereses_dia = @w_intereses_dia + round(@w_resto,@w_numdeci)
      end

      if @w_debug = 'S' begin
         print 'dias:' + cast(@w_dias as varchar)+ 'w_intereses_1_dia:' + cast(@w_intereses_1_dia as varchar)
         print 'w_ult_fech_periodo:' + cast(@w_ult_fech_periodo as varchar)
         print 'w_op_int_ganado:' + cast(@w_op_int_ganado as varchar)
         print 'w_op_int_estimado:' + cast(@w_op_int_estimado as varchar)
         print 'w_op_total_int_ganados:' + cast(@w_op_total_int_ganados as varchar)
         print 'w_op_total_int_estimado:' + cast(@w_op_total_int_estimado as varchar)
         
      end
      
      --Ultimo dia del periodo de pago y no ultimo dia de provision
      if @w_ult_fech_periodo = 1 and @w_ult_provision <> 1 
      begin
         select @w_op_int_ganado = @w_op_int_ganado + @w_intereses_dia 
      
         if @w_op_int_ganado < @w_op_int_estimado
         begin
              select @w_diferencia    = @w_op_int_estimado - @w_op_int_ganado
              select @w_intereses_dia = @w_intereses_dia + @w_diferencia
         end
      
         if @w_op_int_ganado > @w_op_int_estimado
         begin
              select @w_diferencia    = @w_op_int_ganado - @w_op_int_estimado 
              select @w_intereses_dia = @w_intereses_dia - @w_diferencia
         end  
      
         --*-*Si es la ultima provision que se ajusta 
         select @w_dias = 1
      end 

      if @w_ult_provision = 1  /* ultima provision */
      begin               
         select @w_op_total_int_ganados = @w_op_total_int_ganados + isnull(@w_intereses_dia,0)
         
         if @w_op_total_int_ganados < @w_op_total_int_estimado
         begin
            select @w_diferencia    = @w_op_total_int_estimado - @w_op_total_int_ganados
            select @w_intereses_dia = @w_intereses_dia + @w_diferencia
         end

         if @w_op_total_int_ganados > @w_op_total_int_estimado
         begin
            select @w_diferencia    = @w_op_total_int_ganados - @w_op_total_int_estimado 
            select @w_intereses_dia = @w_intereses_dia - @w_diferencia
         end

         --*-*Si es la ultima provision que se ajusta 
         select @w_dias = 1
      end
   end
     
   select @w_op_int_provision = 0

   if @w_debug = 'S' begin
      print 'PROVISION..... @w_intereses_dia:' + cast(@w_intereses_dia as varchar)     
   end
     
   if abs(@w_intereses_dia) > 0
   begin	--*-*-*-*-*-*-*-*
      if @w_debug = 'S' begin
         print 'DIAS:' + cast(@w_dias as varchar)
      end
      select @w_op_int_provision = round(@w_intereses_dia / isnull(@w_dias,1), @w_numdeci )         

      if @w_debug = 'S' begin
         print '@w_intereses_dia:' + cast(@w_intereses_dia as varchar)
         print '@w_dias:' + cast(@w_dias as varchar)
         print '@w_op_int_provision:' + cast(@w_op_int_provision as varchar)
      end
      
      --+-+Inserta registro de provision para la operacion
      insert into pf_prov_dia
           values (@w_fecha, @w_op_operacion, @w_op_oficina, @w_op_toperacion, @w_money, @w_op_tasa, @w_op_base_calculo, @w_intereses_dia, @w_intereses_n_dia)
      if @@error <> 0
      begin
         print 'XXXXXXXXXXXXXX ROLLBACK bt_prov.sp ERROR INSERTA PROV DIA'
         rollback tran
         exec sp_errorlog 
              @i_fecha       = @s_date, 
              @i_error       = 145001,
              @i_usuario     = @s_user,
              @i_tran        = 14926,
              @i_descricion  = @w_op_num_banco
         select    @w_tot_intereses = 0,
                   @w_intereses_dia = 0     --*-* Para que no se meta a contabilizar el grupo
         select    @w_inicia_grupo  = 1
         
         select @w_contabilizar = 'N'             -- GAL 01/SEP/2009 - RVVUNICA - EN CASO DE ERROR EN REGISTRO 
                                                  -- DE LA PROVISION NO SE REVISA SI ES TIEMPO DE CONTABILIZAR
         goto SIGUIENTE
      end
       
       -- Actualizacion de la operacion con nueva provision
      update pf_operacion 
      set  op_int_ganado         = op_int_ganado + @w_intereses_dia,
           op_int_provision      = @w_op_int_provision,
           op_total_int_ganados  = op_total_int_ganados + @w_intereses_dia,
           op_fecha_mod          = @s_date,
           op_ult_fecha_calculo  = @w_fecha_hoy
      where op_operacion = @w_op_operacion
      if @@rowcount <> 1
      begin
         print 'YYYYYYYYYY  ROLLBACK bt_prov.sp ERROR ACTUALIZACION REGISTRO '
         rollback tran
         exec sp_errorlog 
              @i_fecha       = @s_date, 
              @i_error       = 145001,
              @i_usuario     = @s_user,
              @i_tran        = 14926,
              @i_descricion  = @w_op_num_banco
         select    @w_tot_intereses = 0,
                   @w_intereses_dia = 0     --*-* Para que no se meta a contabilizar el grupo
         select    @w_inicia_grupo  = 1
  
         
         select @w_contabilizar = 'N'             -- GAL 01/SEP/2009 - RVVUNICA - EN CASO DE ERROR EN REGISTRO 
                                                  -- DE LA PROVISION NO SE REVISA SI ES TIEMPO DE CONTABILIZAR
         goto SIGUIENTE
      end
  end	--*-*-*-*-*-*-*-*               
     
     
     -- Lee el siguiente registro
     
     if @w_cont_ter = 'S' 
        goto CONTABILIZA
     
     if @w_cont_ter = 'N' 
        select @w_op_ente = @w_op_ente_ant

CONTABILIZA:

     select @w_contador = count(1)
     from #operacion
     
     if @w_contabilizar = 'S'   -- GAL 01/SEP/2009 - RVVUNICA - VALIDA LAS CONDICIONES DE CONTABILIZACION EN CASO 
     begin                      -- QUE NO HAYA HABIDO ERRORES        
     	select @w_tot_intereses = @w_tot_intereses + @w_intereses_dia
     	
        --*-* Genera comprobante contable de provision
        if (@w_op_oficina_ant <> @w_op_oficina) or (@w_op_moneda_ant <> @w_op_moneda) 
            or (@w_op_toperacion_ant <> @w_op_toperacion) or (@w_op_ente <> @w_op_ente_ant)
            or (@w_op_oficina IS  NULL) or (@w_contador > 0)          -- CONDICION DE HABER LLEGADO AL ULTIMO REGISTRO
        begin
             if abs(@w_tot_intereses) > 0
             begin
                  if @w_cont_ter = 'N' 
                  begin
                        if @w_tot_intereses > 0
                             select    @w_descripcion = 'PROV'  + @w_op_toperacion_ant + '-' 
                                                                + convert(varchar(4),@w_op_oficina_ant) + '-'
                                                                + convert(varchar(2),@w_op_moneda_ant),
                                       @w_tipo = 'N'
                        else
                             select    @w_descripcion = 'AMO'   + @w_op_toperacion_ant + '-' 
                                                                + convert(varchar(4),@w_op_oficina_ant) + '-'
                                                                + convert(varchar(2),@w_op_moneda_ant),
                                       @w_tipo = 'R'
                  end
                  else
                  begin
                        if @w_tot_intereses > 0
                             select    @w_descripcion = 'PROV'  + '-' + @w_op_num_banco,
                                       @w_tipo = 'N'
                        else
                             select    @w_descripcion = 'AMO'   + '-' + @w_op_num_banco,
                                       @w_tipo = 'R'
                  end
                                             
        
                  --Busca fecha para generar comprobante contable
                  select @w_fecha_cont = isnull(fecha_contable,'01/01/1900')
                  from cobis..cl_oficina, #dias_calc_x_fecha_pf
                  where of_ciudad  = ciudad
                  and   of_oficina = @w_op_oficina_ant
        
                  exec @w_return = cob_pfijo..sp_aplica_conta
                       @s_ssn           = @s_ssn,
                       @s_date          = @s_date,
                       @s_user          = @s_user,
                       @s_term          = @s_term,
                       @s_ofi           = @s_ofi,
                       @t_debug         = @t_debug,
                       @t_file          = @t_file,
                       @t_from          = @t_from,
                       @t_trn           = 14937,
                       @i_empresa       = 1,
                       @i_fecha         = @w_fecha_cont,
                       @i_tran          = 14926,
                       @i_producto      = 14,   /* op_producto de pf_operacion */
                       @i_oficina_oper  = @w_op_oficina_ant,
                       @i_oficina       = @w_op_oficina_ant, 
                       @i_toperacion    = @w_op_toperacion_ant,/*op_toperacion de pf_operacion */
                       @i_tplazo        = NULL, /* Nemonico del tipo de plazo */ 
                       @i_operacionpf   = @w_op_operacion,     /* op_operacion de pf_operacion*/
                       @i_estado        = NULL,
                       @i_valor         = @w_tot_intereses, 
                       @i_moneda        = @w_op_moneda_ant, 
                       @i_afectacion    = 'N',  /* N=Normal,  R=Reverso  */
                       @i_descripcion   = @w_descripcion,
                       @i_codval        = '18',           /* Codigo de valor para el detalle */ --cambia el tipo de dato a varchar
                       @i_movmonet      = '1',
                       @i_ente          = @w_op_ente,
                       @i_debcred       = '1',           /* Si es debito = 1 o credito = 2 */ 
                       @o_comprobante   = @o_comprobante out
                  if @w_return <> 0
                  begin
                     print 'PPPPPPPPPPP   ROLLBACK bt_prov.sp ERROR INSERTA PROV DIA'
                     rollback tran --calc_diario_int
                     exec sp_errorlog 
                            @i_fecha       = @s_date, 
                            @i_error       = 143041,
                            @i_usuario     = @s_user,
                            @i_tran        = 14926,
                            @i_descripcion = @w_descripcion
                  end  
                  else 
                  begin
                     if @w_debug = 'S' begin
                        print 'HACE COMMIT XXXXXXXXXXXXXXXXXXXXXXXXXXXX'
                     end
                       commit tran
                  end
                  
                  select @w_inicia_grupo = 1                -- GAL 01/SEP/2009 - RVVUNICA - SE DEBE REABRIR LA TRANSACCION
             end
             else --Si es = 0
             begin
                  if isnull(@w_tot_intereses,0) <= 0
                  begin
                     print 'ROLL BACK FFFFFFFFFFFFFFFFFFFFFFFFFFFFF'
                     rollback tran            
/*                       
                       exec sp_errorlog 
                            @i_fecha       = @s_date,  
                            @i_error       = 141012,
                            @i_usuario     = @s_user,
                            @i_tran        = 14926,
                            @i_descripcion = 'Interes = 0',
                            @i_cuenta      = @w_op_num_banco
*/                   if @w_debug = 'S' begin
                        print 'INTERES 0 para operacion:' + @w_op_num_banco
                     end
                     select @w_inicia_grupo = 1          -- GAL 01/SEP/2009 - RVVUNICA - SE DEBE REABRIR LA TRANSACCION
                  end
             end
             
             -- Reinicializacion de variables
             select    @w_op_oficina_ant     = @w_op_oficina,
                       @w_op_moneda_ant      = @w_op_moneda,
                       @w_op_toperacion_ant  = @w_op_toperacion,
                       @w_op_ente_ant        = 0
             select    @w_tot_intereses = 0,
                       @w_intereses_dia = 0
        
             if @w_cont_ter = 'N' 
                  select @w_op_ente = @w_op_ente_ant
        end
        
        if @w_cont_ter = 'S'
        begin
           goto SIGUIENTE
           
        end
     end
     
SIGUIENTE:

end /*while cursor_operacion*/

if @@trancount > 0 --SI YA SE INICIO LA TRANSACCION EN PROGRAMA PADRE NO DEBE INICIARSE OTRA
begin
   if @w_debug = 'S' begin
      print 'HACE COMMIT PORQUE QUEDO ABIERTA UNA TRX'
   end
	 commit tran
end

drop table #dias_calc_x_fecha_pf

if @w_debug = 'S' 
begin
print 'SE VA!!......................'
end

return 0
go


