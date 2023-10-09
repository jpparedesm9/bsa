/************************************************************************/
/*      Archivo:                bt_inttv.sp                             */
/*      Stored procedure:       sp_calcula_int_tasavar                  */
/*      Base de datos:          cob_pfijo                               */
/*      Producto:               Plazo Fijo                              */
/*      Disenado por:           N. Silva                                */
/*      Fecha de documentacion: Feb/12/2004                             */
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
/*      Este programa calcula los intereses para tasas variables        */
/*      periodicos y flotante.                                          */
/*                                                                      */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR              RAZON                        */
/*      20/09/2009     Y. Martinez     Emision inicial                  */
/*      07/11/2014     Andres Diab     REQ455 Incluir Tipo Producto en  */
/*                                     consulta de tasa referencia      */
/*      10/01/2017     Jorge Salazar   DPF-H94952 MANEJO RETENCIONES MX */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'sp_calcula_int_tasavar')
   drop proc sp_calcula_int_tasavar
go

create proc sp_calcula_int_tasavar (
@s_ssn                  int             = NULL,
@s_org                  char(1)         = NULL,
@s_sesn                 int             = NULL,
@s_user                 login           = NULL,
@s_term                 varchar(30)     = NULL,
@s_date                 datetime        = NULL,
@s_srv                  varchar(30)     = NULL,
@s_lsrv                 varchar(30)     = NULL,
@t_debug                char(1)         = 'N',
@t_file                 varchar(10)     = NULL,
@t_from                 varchar(32)     = NULL,
@t_trn                  smallint = NULL,
@i_operacion            char(1),
@i_fecha_proceso        datetime,
@i_op_operacion         int
)
with encryption
as
declare
@w_sp_name                    descripcion,
@w_return                     int,
@w_fecha_anterior             datetime,
@w_fecha_proceso              datetime,
@w_op_operacion               int,
@w_op_monto                   money,
@w_op_fecha_pg_int            datetime,
@w_op_fecha_ult_pg_int        datetime,
@w_op_base_calculo            smallint,
@w_op_monto_pg_int            money,
@w_op_num_dias                int,
@w_op_toperacion              catalogo,
@w_op_moneda                  smallint,
@w_op_spread                  float,
@w_op_operador                char(1),
@w_operador                   char(1),
@w_spread                     float,
@w_op_mnemonico_tasa          catalogo,
@w_op_tasa                    float,
@w_op_historia                int,
@w_valor_tasa_var             float,
@w_tasavar_orig               float,    --xca 18-Oct-2005
@w_error                      int,
@w_op_num_banco               cuenta,
@w_op_fpago                   catalogo,
@w_op_tipo_tasa_var           char(1),
@w_int_estimado               money,
@w_op_fecha_ven               datetime,
@w_total_int_estimado         money,
@w_op_int_ganado              money,
@w_op_total_int_ganado        money,
@w_cu_cuota                   int,
@w_cu_capital                 money,
@w_cu_fecha_ult_pago          datetime,
@w_cu_fecha_pago              datetime,
@w_cu_tasa                    float,
@w_cu_ppago                   catalogo,
@w_cu_base_calculo            smallint,
@w_valor_cuota                money,
@w_spread_vig                 float,
@w_spread_ajust               float,    --xca 18-Oct-2005
@w_fecha_rev                  datetime,
@w_cu_estado                  char(1),
@w_op_tipo_plazo              catalogo, --xca 18-Oct-2005
@w_op_int_estimado            money,
@w_op_total_int_estimado      money,
@w_tasa_max                   float,      --xca 18-Oct-2005
@w_tasa_min                   float,      --xca 18-Oct-2005
@w_tv_tipo_plazo_min          catalogo,       --xca 18-Oct-2005
@w_tv_tipo_plazo_max          catalogo,       --xca 18-Oct-2005
@w_tipo_plazo_act             int,            --xca 18-Oct-2005
@w_tipo_plazo_new             int,            --xca 18-Oct-2005
@w_val_convert                catalogo,       --xca 18-Oct-2005
@w_tipo_plazo_let             char(1),        --xca 18-Oct-2005
@w_op_pignorado               char(1),        --xca 18-Oct-2005
@w_pi_cuenta                  cuenta,         --xca 18-Oct-2005
@w_pi_producto                catalogo,       --xca 18-Oct-2005
@w_op_toperacion_let          char(1),        --xca 18-Oct-2005
@w_fecha_revi_oper            datetime,       --xca 18-Oct-2005
@w_op_tcapitalizacion         char(1),
@w_op_fecha_valor             datetime,
@w_dif_dias                   int,
@w_dif_dias_ayer              int,
@w_td_tipo_deposito           int,
@w_pl_mnemonico               catalogo,
@w_pl_mnemonico_ayer          catalogo,
@w_mo_mnemonico               catalogo,
@w_numdeci                    tinyint,
@w_usadeci                    char(1),
@w_op_total_int_pagados       money,
@w_op_fecha_crea              datetime,
@w_monto_ant                  money,
@w_suma_det_pago              money,
@w_mensaje                    varchar(240),
@w_monto_new                  money,      --+-+
@w_codigo                     varchar(20),
@w_modifica                   char(1),
@w_fecha_cambio               datetime,
@w_tasa_sgte                  float,
@w_cuantos                    tinyint,
@w_total_int_estimado_cambio  money,
@w_mnemonico_tasa_var         varchar(20),
@w_tasa_base                  float,
@w_num_meses                  int,
@w_ppago                      catalogo,
@w_op_modalidad_tasa          char(1),
@w_op_descr_tasa              descripcion,
@w_base_calculo               smallint,
@w_op_dias_reales             char(1),
@w_op_dia_pago                tinyint,
@w_op_periodo_tasa            smallint,
@w_op_oficina                 int,
@w_tasa_efectiva_conver       float,
@w_tasa_new_vigente           float,
@w_total_int_estim            money,
@w_fecha_pg_int_new           datetime,
@w_int_estim_new              money ,
@w_num_pagos                  int,
@w_aux                        varchar(25),
-- INICIO - GAL 29/SEP/2009 - RVVUNICA
@w_op_ente                    int,
@w_retienimp                  char(1),
@w_ret_ica                    char(1),
@w_tasa_retencion             float,
@w_tasa_ica                   float,
@w_retencion                  money,
@w_impuesto                   money,
@w_imp_ica                    money,
@w_decimal_imp                tinyint,
@w_tran_abierta               char(1),
@w_sum_cuotas                 money,   --*-*
-- FIN - GAL 29/SEP/2009 - RVVUNICA
@w_conc0                      float,
@w_conc1                      float, 
@w_puntos                     float,
@w_operador_tmp               char(1),
@w_spread_tmp                 float,
@w_op_spread_tmp              char(1),
@w_fecha_p                    datetime,
@w_oficina_x_tasa             smallint   --REQ455 Variable para cambio de oficina por tasa de referencia de día anterior.


select
   @w_sp_name = 'sp_calcula_int_tasavar',
   @w_mensaje = '',
   @w_codigo  = '',
   @w_tran_abierta = 'N',
   @w_sum_cuotas = 0


create table #ca_operacion_aux (
op_operacion         int,
op_banco             varchar(24),
op_toperacion        varchar(10),
op_moneda            tinyint,
op_oficina           int,
op_fecha_ult_proceso datetime ,
op_dias_anio         int,
op_estado            int,
op_sector            varchar(10),
op_cliente           int,
op_fecha_liq         datetime,
op_fecha_ini         datetime ,
op_cuota_menor       char(1),
op_tipo              char(1),
op_saldo             money,     -- LuisG 04.06.2001
op_fecha_fin         datetime,   -- LuisG 04.06.2001
op_base_calculo      char(1) , --lre version estandar 05/06/2001
op_periodo_int       smallint, --lre version estandar 05/06/2001
op_tdividendo        varchar(10)  --lre version estandar 05/06/2001
)

create table #ca_abonos (
ab_secuencial_ing    int,
ab_dias_retencion    int         null,
ab_estado            varchar(10) null,
ab_cuota_completa    char(1)     null
)


CREATE TABLE #det_cus_garantias (            --LIM 01/FEB/2006
       garantia                varchar(64)     NOT NULL,
       tipo                    varchar(64)     NOT NULL,
       tasa                    float           NULL,
       cuenta                  varchar(24)     NULL)


CREATE TABLE #det_oper_relacion (            --LIM 01/FEB/2006
       op_garantia                varchar(64)     NOT NULL,
       op_tramite                 int             NOT NULL,
       op_tipo                    char(1)         NOT NULL,
       op_toperacion              varchar(10)         NULL,
       op_producto                varchar(10)         NULL,
       op_tasa_asoc               char(1)             NULL,
       op_cuenta                  varchar(24)         NULL)

/* ALMACENA LAS DIFERENCIAS DE INTERES EN LOS REAJUSTES */
create table #interes_proyectado (           --LIM 01/FEB/2006
concepto        varchar(10),
valor           money
)

--select @t_debug = 'S'


--print 'CALINTASAVAR ---------' + cast(@i_op_operacion as varchar)

if @i_operacion = 'U'
begin
   select @w_monto_ant = 0

   select @w_fecha_proceso  = @i_fecha_proceso --Fecha proceso real

   select @i_fecha_proceso  = dateadd(dd,1,@i_fecha_proceso) --Fecha proceso de calculo

   declare cursor_pf_tasa_variable cursor for
   select op_operacion        , op_monto             , op_fecha_pg_int,
          op_fecha_ult_pg_int , op_base_calculo      , op_monto_pg_int,
          op_toperacion       , op_moneda            , op_mnemonico_tasa,
          op_num_banco        , op_fpago             , op_int_ganado,
          op_total_int_ganados, op_num_dias          , op_spread,
          op_operador         , op_tipo_tasa_var     , op_tasa,
          op_historia         , op_tipo_plazo        , op_pignorado,
          op_tcapitalizacion  , op_fecha_valor       , op_total_int_pagados,
          op_fecha_crea       , op_fecha_ven         , op_tipo_plazo,
          op_int_estimado     , op_total_int_estimado, op_mnemonico_tasa,
          op_ppago            , op_modalidad_tasa    , op_descr_tasa,
          op_base_calculo     , op_dias_reales       , op_oficina,
          op_dia_pago         , op_periodo_tasa      , op_fecha_ult_pg_int,
          op_ente  	      , op_puntos                                                                    -- GAL 29/SEP/2009 - RVVUNICA
   from pf_operacion
   where op_tipo_tasa_var    in ('P')
   and   op_tasa_variable     = 'S'
   and   op_estado            = 'ACT'
   and   op_operacion         = @i_op_operacion
   and   @w_fecha_proceso  < op_fecha_ven

   open cursor_pf_tasa_variable
   fetch cursor_pf_tasa_variable into
          @w_op_operacion       , @w_op_monto        , @w_op_fecha_pg_int,
          @w_op_fecha_ult_pg_int, @w_op_base_calculo , @w_op_monto_pg_int,
          @w_op_toperacion      , @w_op_moneda       , @w_op_mnemonico_tasa,
          @w_op_num_banco       , @w_op_fpago        , @w_op_int_ganado,
          @w_op_total_int_ganado, @w_op_num_dias     , @w_op_spread,
          @w_op_operador        , @w_op_tipo_tasa_var, @w_op_tasa,
          @w_op_historia        , @w_op_tipo_plazo   , @w_op_pignorado,
          @w_op_tcapitalizacion , @w_op_fecha_valor  , @w_op_total_int_pagados,
          @w_op_fecha_crea      , @w_op_fecha_ven    , @w_pl_mnemonico,
          @w_op_int_estimado    , @w_op_total_int_estimado, @w_mnemonico_tasa_var,
          @w_ppago              , @w_op_modalidad_tasa,@w_op_descr_tasa,
          @w_base_calculo       , @w_op_dias_reales  , @w_op_oficina,
          @w_op_dia_pago        , @w_op_periodo_tasa , @w_op_fecha_ult_pg_int,
          @w_op_ente            , @w_puntos                                                   -- GAL 29/SEP/2009 - RVVUNICA

   while @@fetch_status = 0
   begin


   if @@trancount = 0 begin --SI YA SE INICIO LA TRANSACCION EN PROGRAMA PADRE NO DEBE INICIARSE OTRA
      begin tran
      select @w_tran_abierta = 'S'
   end

      select   @w_modifica = 'N',
         @w_cuantos = 0,
         @w_total_int_estimado_cambio = 0

      ----------------------------------
      -- Decimales para la moneda
      ----------------------------------
      select @w_usadeci = mo_decimales
      from  cobis..cl_moneda
      where mo_moneda = @w_op_moneda
      if @w_usadeci = 'S'
      begin
         select @w_numdeci = isnull (pa_tinyint,2)
         from  cobis..cl_parametro
         where pa_nemonico = 'DCI'
         and   pa_producto = 'PFI'
      end
      else
         select @w_numdeci = 0

--print 'w_fecha_proceso' + cast(@w_fecha_proceso as varchar)
--print '@w_op_mnemonico_tasa' + cast(@w_op_mnemonico_tasa as varchar)

      --REQ455 Se debe utilizar la oficina del producto en caso de tasas variables que consultan la referencia del dia anterior. 
      if exists(select 1 from cobis..cl_tabla t, cobis..cl_catalogo c
                where t.tabla = 'pf_tasa_dia_ant'
                and   t.codigo = c.tabla
                and   c.codigo = @w_op_mnemonico_tasa
                and   c.estado = 'V')      
         select @w_oficina_x_tasa = @w_op_oficina
      else
         select @w_oficina_x_tasa = NULL
         
      exec @w_return = cob_pfijo..sp_cons_tasa_var
         @t_trn          = 14416,
         @s_ofi          = @w_oficina_x_tasa,
         @i_operacion    = 'Q',
         @i_tipo         = 'N',
         @i_cod_tasa_ref = @w_op_mnemonico_tasa,  -- Cod. tasa referencial de la tabla de operaciones
         @i_fecha        = @w_fecha_proceso,      -- Fecha de consulta
         @i_moneda       = @w_op_moneda,          -- Moneda de la negociacion
         @i_batch        = 'S',
         @i_toperacion   = @w_op_toperacion,      -- REQ455 Tipo Producto para buscar tasa IBR dia anterior
         @o_valor_ref    = @w_valor_tasa_var out -- valor tasa referencial

      if @w_return <> 0
      begin
         select
            @w_error   = @w_return,
            @w_mensaje = 'Error en busqueda tasa referencial'

         goto ERROR
      end
      
      select @w_tasa_base = @w_valor_tasa_var


--print '@w_valor_tasa_var ' + cast (@w_valor_tasa_var as varchar)

      select @w_spread       = @w_op_spread
      select @w_operador  = @w_op_operador

if @t_debug = 'S' print 'w_op_monto_pg_int ' + cast (@w_op_monto_pg_int as varchar)
if @t_debug = 'S' print 'w_op_num_dias ' + cast (@w_op_num_dias as varchar)
if @t_debug = 'S' print 'w_op_toperacion ' + cast (@w_op_toperacion as varchar)
if @t_debug = 'S' print 'w_op_moneda ' + cast (@w_op_moneda as varchar)
if @t_debug = 'S' print 'w_op_tipo_plazo ' + cast (@w_op_tipo_plazo as varchar)
if @t_debug = 'S' print 'w_mnemonico_tasa_var ' + cast (@w_mnemonico_tasa_var as varchar)
      ------------------------------------------------------------
      -- Proceso para tomar el valor del operador y del spread a
      -- considerar para el calculo del valor real de la tasa a
      -- negociar. 12-Abr-2000 Tasa Variable.
      ------------------------------------------------------------
      exec @w_return = cob_pfijo..sp_tasa_variable
         @t_trn             = 14415,
         @i_operacion       = 'Q',
         @i_tipo            = 'E',
         @i_monto           = @w_op_monto_pg_int,
         @i_plazo           = @w_op_num_dias,
         @i_mnemonico_prod  = @w_op_toperacion,
         @i_moneda          = @w_op_moneda,
         @i_batch           = 'S',
         @i_tipo_plazo      = @w_op_tipo_plazo,         -- xca 18-Oct-2005
         @i_mnemonico_tasa  = @w_mnemonico_tasa_var,  -- xca 18-Oct-2005
         @o_operador        = @w_op_operador  out,              -- operador (+/-)
         @o_spread_vigente  = @w_op_spread out,                -- valor spread vigente
         @o_tasa_max        = @w_tasa_max out,          -- xca 18-Oct-2005
         @o_tasa_min        = @w_tasa_min out               -- xca 18-Oct-2005

      if @w_return <> 0
      begin
         select @w_mensaje = 'Error recibido por sp_tasa_variable'
         select @w_error = @w_return
         goto ERROR
      end

select @t_debug = 'S'


if @t_debug = 'S' print 'w_op_operador ' + cast (@w_op_operador as varchar)
if @t_debug = 'S' print 'w_op_spread ' + cast (@w_op_spread as varchar)
if @t_debug = 'S' print '@w_puntos ' + cast (@w_puntos as varchar)
if @t_debug = 'S' print '@w_operador ' + cast (@w_operador as varchar)

	  --NYM INC 44213
	  if isnull(@w_puntos,0) >= 0 or isnull(@w_op_spread,0) >= 0 begin
	     select @w_conc0 = isnull(@w_operador,'+') + convert(varchar(100),isnull(@w_puntos,0))
if @t_debug = 'S' print '@w_conc0 ' + cast (@w_conc0 as varchar)
	     select @w_conc1 = isnull(@w_op_operador,'+') + convert(varchar(100),isnull(@w_op_spread,0))
if @t_debug = 'S' print '@w_conc1 ' + cast (@w_conc1 as varchar)
	     select @w_op_spread = convert(float,@w_conc0 ) + convert(float,@w_conc1)
	     
   select @w_operador_tmp  = @w_operador
   select @w_spread_tmp    = @w_op_spread
   select @w_op_spread_tmp = @w_op_operador

	     if @w_op_spread  > 0
		    select @w_op_operador = '+'
	     else
		   select @w_op_operador = '-'

	     select @w_op_spread = abs(@w_op_spread )
      end


      -------------------------------------------------------------------
      -- Proceso para validar que el valor de la tasa no pase la tasa_max
      -- ni se encuentre por debajo de la minima. 18-Oct-2005
      --------------------------------------------------------------------
      select @w_tasavar_orig = @w_valor_tasa_var


      ------------------------------
      -- Tomar valor para num_meses
      ------------------------------
      select @w_num_meses = pp_factor_en_meses
        from pf_ppago
       where pp_codigo = @w_ppago

      if @w_ppago = 'NNN'
      begin
         select @w_num_meses = 1
      end

if @t_debug = 'S' print 'w_op_toperacion ' + cast (@w_op_toperacion as varchar)
if @t_debug = 'S' print 'w_valor_tasa_var ' + cast (@w_valor_tasa_var as varchar)
if @t_debug = 'S' print 'w_op_periodo_tasa ' + cast (@w_op_periodo_tasa as varchar)
if @t_debug = 'S' print 'w_op_modalidad_tasa ' + cast (@w_op_modalidad_tasa as varchar)
if @t_debug = 'S' print 'w_op_descr_tasa ' + cast (@w_op_descr_tasa as varchar)
if @t_debug = 'S' print 'w_op_operador ' + cast (@w_op_operador as varchar)
if @t_debug = 'S' print 'w_op_spread ' + cast (@w_op_spread as varchar)
if @t_debug = 'S' print 'w_base_calculo ' + cast (@w_base_calculo as varchar)
if @t_debug = 'S' print 'w_op_fpago ' + cast (@w_op_fpago as varchar)
if @t_debug = 'S' print 'w_num_meses ' + cast (@w_num_meses as varchar)

      --------------------------------------------
      -- Proceso para Calculo de la tasa variable
      --------------------------------------------
      exec @w_return = cob_pfijo..sp_calcula_tasa_var
         @t_trn            = 14948,
         @i_toperacion     = @w_op_toperacion,
         @i_vr_tasa_var    = @w_valor_tasa_var,
         @i_periodo_tasa   = @w_op_periodo_tasa,
         @i_modalidad_tasa = @w_op_modalidad_tasa, -- en la IPC no aplica
         @i_descr_tasa     = @w_op_descr_tasa,
         @i_mnemonico_tasa = @w_mnemonico_tasa_var,
         @i_operador       = @w_op_operador,
         @i_spread         = @w_op_spread,
         @i_base_calculo   = @w_base_calculo,
         @i_modalidad_prod = @w_op_fpago,
         @i_per_pago       = @w_num_meses,
         @i_en_linea       = 'N',
         @i_moneda         = @w_op_moneda,
         @i_monto          = @w_op_monto_pg_int,
         --@i_inicio_periodo = 'S',     --CVA Jun-20-06 Para que obtenga la tasa del primer rango del periodo
         @o_tasa_EA        = @w_tasa_efectiva_conver out, /* valor tasa efect */
         @o_tasa_nom_reexp = @w_tasa_new_vigente out /* valor tasa nominal */

      if @w_return <> 0
      begin
         select @w_mensaje = 'Error recibido por sp_calcula_tasa_var'
         print '@w_return' + cast(@w_return as varchar) + @w_mensaje
         select @w_error = @w_return
         goto ERROR
      end

      select @w_tasa_new_vigente = round(@w_tasa_new_vigente , 4)
      select @w_tasa_efectiva_conver = round(@w_tasa_efectiva_conver,4)

if @t_debug = 'S' print ' clacinttvar efectiva ' + cast(@w_tasa_efectiva_conver as varchar) + ', Nominal : ' + cast(@w_tasa_new_vigente as varchar)


if @t_debug = 'S' print 'OOOOOOOOO clacinttvar w_op_fecha_ult_pg_int ' + cast(@w_op_fecha_ult_pg_int as varchar) + ', w_op_fecha_pg_int : ' + cast(@w_op_fecha_pg_int as varchar) + ', w_op_monto_pg_int : ' + cast(@w_op_monto_pg_int as varchar)

      if @w_op_fpago in('PER') --CVA Jul-05-06 Para escalonados que busque el total en base a los cambios de fecha
      begin
         -- INICIO - GAL 07/SEP/2009 - RVVUNICA
         exec @w_return = sp_aplica_impuestos
         @s_ofi              = @w_op_oficina,
         @t_debug            = @t_debug,
         @i_operacion        = 'T',
         @i_ente             = @w_op_ente,
         @i_plazo            = @w_op_num_dias,
         @i_capital          = @w_op_monto_pg_int,
         @i_interes          = @w_int_estim_new,
         @i_base_calculo     = @w_base_calculo,
         @o_retienimp        = @w_retienimp      out,
         @o_tasa_retencion   = @w_tasa_retencion out,
         @o_valor_retencion  = @w_impuesto       out

         if @w_return <> 0
            return @w_return
         -- FIN - GAL 07/SEP/2009 - RVVUNICA

if @t_debug = 'S' print 'AAAAAAA clacinttvar w_op_fecha_ven ' + cast(@w_op_fecha_ven as varchar) + ', w_op_fecha_pg_int : ' + cast(@w_op_fecha_pg_int as varchar) + ', w_op_monto_pg_int : ' + cast(@w_op_monto_pg_int as varchar)
if @t_debug = 'S' print 'BBBBBBB clacinttvar w_fecha_proceso ' + cast(@w_fecha_proceso as varchar) + ', w_tasa_new_vigente : ' + cast(@w_tasa_new_vigente as varchar) + ', w_op_dia_pago : ' + cast(@w_op_dia_pago as varchar)

         exec sp_estima_int
            @i_fecha_inicio    = @w_op_fecha_ult_pg_int,
            @s_ofi             = @w_op_oficina,
            @s_date            = null,
            @i_fecha_final     = @w_op_fecha_ven , --@w_op_fecha_pg_int,
            @i_monto           = @w_op_monto_pg_int,
            @i_tasa            = @w_tasa_new_vigente,
            @i_tcapitalizacion = @w_op_tcapitalizacion,
            @i_fpago           = @w_op_fpago,
            @i_ppago           = @w_ppago,
            @i_dias_anio       = @w_base_calculo,
            @i_dia_pago        = @w_op_dia_pago,
            @i_batch           = 'C',  --*-*
            @i_moneda          = @w_op_moneda,          --15-may-98 capitalizacion
            @i_dias_reales     = @w_op_dias_reales,
            --I. CVA Jul-04-06 Parametros para escalonado
            @i_op_operacion    = @w_op_operacion,
            @i_toperacion      = @w_op_toperacion,
            @i_periodo_tasa    = @w_op_periodo_tasa,       -- cobis..te_pizarra..pi_periodo
            @i_modalidad_tasa  = @w_op_modalidad_tasa,     -- cobis..te_pizarra..pi_modalidad, en la IPC no aplica
            @i_descr_tasa      = @w_op_descr_tasa,
            @i_mnemonico_tasa  = @w_mnemonico_tasa_var,     -- DTF, TCC, IPC, PRIME, ESC
            @i_tipo_plazo      = @w_op_tipo_plazo,
            @i_en_linea        = 'N',
            --F. CVA Jul-04-06 Parametros para escalonado
            -- INICIO - GAL 29/SEP/2009 - RVVUNICA
            @i_retienimp       = @w_retienimp,
            @i_tasa1           = @w_tasa_retencion,
            @i_ret_ica         = @w_ret_ica,
            @i_tasa_ica        = @w_tasa_ica,
            -- FIN - GAL 29/SEP/2009 - RVVUNICA
            @o_fecha_prox_pg   = @w_fecha_pg_int_new out,
            @o_int_pg_ve       = @w_total_int_estim out,
            @o_int_pg_pp       = @w_int_estim_new out,
            @o_num_pagos       = @w_num_pagos out
      end -- Fin fpago = 'PER', 'PRA'

         exec @w_return = sp_aplica_impuestos
         @s_ofi              = @w_op_oficina,
         @t_debug            = @t_debug,
         @i_ente             = @w_op_ente,
         @i_plazo            = @w_op_num_dias,
         @i_capital          = @w_op_monto_pg_int,
         @i_interes          = @w_int_estim_new,
         @i_base_calculo     = @w_base_calculo,
         @o_retienimp        = @w_retienimp      out,
         @o_tasa_retencion   = @w_tasa_retencion out,
         @o_valor_retencion  = @w_impuesto       out
         if @w_return <> 0
            return @w_return
      
      select @w_sum_cuotas = sum(cu_valor_cuota)
      from pf_cuotas
      where cu_operacion = @w_op_operacion
      and cu_fecha_pago between @w_op_fecha_valor and @w_op_fecha_ult_pg_int

      select @w_total_int_estim =  @w_total_int_estim + @w_sum_cuotas

if @t_debug = 'S' print 'PPPPPPPP clacinttvar w_int_estim_new ' + cast(@w_int_estim_new as varchar) + ', w_total_int_estim : ' + cast(@w_total_int_estim as varchar) + ', w_sum_cuotas : ' + cast(@w_sum_cuotas as varchar)

      update pf_operacion set
         op_int_estimado         = @w_int_estim_new,
         op_total_int_estimado   = @w_total_int_estim,
         op_tasa                 = @w_tasa_new_vigente,
         op_tasa_efectiva        = @w_tasa_efectiva_conver,
         op_tasa_mer             = @w_tasavar_orig,
         op_historia             = (@w_op_historia + 1),
         op_spread               = @w_spread,
         op_fecha_mod            = @i_fecha_proceso
      where op_operacion = @w_op_operacion

      if @@error <> 0
      begin
         select @w_error = 145001,@w_mensaje = 'Error en actualizacion operacion'
         goto ERROR
      end
      
      select @w_fecha_p = fp_fecha
      from cobis..ba_fecha_proceso

      insert into cob_pfijo..pf_tasa_var_p (
      pt_fecha,             pt_operacion,          pt_trn,
      pt_puntos,            pt_operador_puntos,    pt_spread,
      pt_operador_spread,   pt_tasa_nominal,       pt_tasa_efectiva,
      pf_tasa_ref)
      values (
      @w_fecha_p,           @w_op_operacion,       14905,
      @w_puntos,            @w_operador_tmp,       @w_spread_tmp,
      @w_op_spread_tmp,     @w_tasa_new_vigente,   @w_tasa_efectiva_conver,
      @w_tasavar_orig)
      
      if @@error <> 0
      begin
         select @w_error = 145001,@w_mensaje = 'Error en insercion en operacion pf_tasa_var_p'
         goto ERROR
      end

      -- Actualizacion de cuotas
      if @w_op_fpago = 'PER'
      begin
         select @w_retencion = isnull(@w_impuesto + @w_imp_ica, 0)


         -- Actualizacion de la cuota con el nuevo valor de interes estimado
         update pf_cuotas
         set cu_valor_cuota = @w_int_estim_new,
             cu_valor_neto  = @w_int_estim_new - @w_retencion,                   -- GAL 29/SEP/2009 - RVVUNICA
             cu_retencion   = @w_retencion,                                      -- GAL 29/SEP/2009 - RVVUNICA
             cu_tasa        = @w_valor_tasa_var
         where cu_operacion  = @w_op_operacion
         and   cu_fecha_pago = @w_op_fecha_pg_int

         if @@error <> 0
         begin
            select @w_error = 145001,@w_mensaje ='Error al actualizar cuotas...'
            goto ERROR
         end

         if @w_op_tcapitalizacion = 'S'
            select @w_monto_new = @w_op_monto_pg_int + @w_int_estim_new - @w_retencion
         else
            select @w_monto_new = @w_op_monto_pg_int

         ------------------------------------------------------
         -- Generacion de nuevo archivo de cuotas por operacion (02/23/2004)
         ------------------------------------------------------
         exec @w_return = sp_actualiza_cuota
            @s_ssn                  = @s_ssn,
            @s_user                 = @s_user,
            @s_ofi                  = @w_op_oficina,
            @s_date                 = @s_date,
            @t_trn                  = 14146,
            @s_srv                  = @s_srv,
            @s_term                 = @s_term,
            @t_file                 = @t_file,
            @t_from                 = @w_sp_name,
            @t_debug                = @t_debug,
            @i_monto                = @w_monto_new,   --para el caso de que el monto deba sumarse al
                                                      --interes debido a que el DPF capitaliza intereses
            @i_fecha_proceso        = @w_op_fecha_pg_int,
            @i_op_operacion         = @w_op_operacion,
            @i_modifica             = @w_modifica
         if @w_return <> 0
         begin
            --select @w_return = @w_return
            select @w_error = @w_return,@w_mensaje ='Error al actualizar cuotas.2..'
            goto ERROR
         end



         --print 'Llama a sp_cuotas -> monto_new: '+ cast( @w_monto_new as varchar)+', @w_op_fecha_pg_int: '
          --+ cast( @w_op_fecha_pg_int as varchar)

      end   --if @w_op_fpago = 'PER'

      if @w_op_tcapitalizacion <> 'S'
      begin
         --------------------------------
         -- Actualizacion de pf_det_pago
         --------------------------------
         update   cob_pfijo..pf_det_pago
         set dp_monto = round(((isnull(dp_porcentaje,100) / 100) * @w_int_estim_new), @w_numdeci)
         where dp_operacion = @w_op_operacion
         and   dp_estado_xren = 'N'
         and   dp_estado = 'I'
         if @@error <> 0
         begin
            select @w_error = 145037,@w_mensaje = 'Error en actualizacion detalle de pago'
            goto ERROR
         end

         select @w_suma_det_pago = sum(dp_monto)
         from  cob_pfijo..pf_det_pago
         where dp_operacion   = @w_op_operacion
         and   dp_estado_xren = 'N'
         and   dp_estado      = 'I'


         if @w_int_estim_new <> isnull(@w_suma_det_pago, @w_int_estim_new)
         begin
            update   pf_det_pago
            set   dp_monto = dp_monto + (@w_int_estim_new - @w_suma_det_pago)
            where dp_operacion   = @w_op_operacion
            and   dp_estado_xren = 'N'
            and   dp_estado   = 'I'
            and   dp_secuencia   = (select max(dp_secuencia)
                                    from  pf_det_pago
                                    where dp_operacion   = @w_op_operacion
                                    and   dp_estado_xren = 'N'
                                    and   dp_estado   = 'I')
            if @@error <> 0
            begin
               select @w_error = 145037,@w_mensaje = 'Error en actualizacion detalle de pago diferencia'
               goto ERROR
            end
         end
      end

      select @w_aux = 'CAMBIO AUTOMATICO DE TASA : ' + cast(@w_op_tasa as varchar(25))
      -------------------------------------------
      -- Almacenar la historia de la transaccion
      -------------------------------------------
      insert pf_historia(
      hi_operacion        , hi_secuencial , hi_fecha,      hi_trn_code,
      hi_valor            , hi_funcionario, hi_oficina,    hi_observacion,
      hi_fecha_crea       , hi_fecha_mod  , hi_tasa)
      values(
      @w_op_operacion     , @w_op_historia, @s_date,       @t_trn,
      @w_valor_tasa_var   , @s_user       , @w_op_oficina, @w_aux,
      @s_date             , @s_date       , @w_tasa_new_vigente)

      if @@error <> 0
      begin
         select @w_error = 143006,@w_mensaje = 'Error en insercion de historico'
         goto ERROR
      end



SIGUIENTE:
      fetch cursor_pf_tasa_variable into
         @w_op_operacion       , @w_op_monto             , @w_op_fecha_pg_int,
         @w_op_fecha_ult_pg_int, @w_op_base_calculo      , @w_op_monto_pg_int,
         @w_op_toperacion      , @w_op_moneda            , @w_op_mnemonico_tasa,
         @w_op_num_banco       , @w_op_fpago             , @w_op_int_ganado,
         @w_op_total_int_ganado, @w_op_num_dias          , @w_op_spread,
         @w_op_operador        , @w_op_tipo_tasa_var     , @w_op_tasa,
         @w_op_historia        , @w_op_tipo_plazo        , @w_op_pignorado,
         @w_op_tcapitalizacion , @w_op_fecha_valor       , @w_op_total_int_pagados,
         @w_op_fecha_crea      , @w_op_fecha_ven         , @w_pl_mnemonico,
         @w_op_int_estimado    , @w_op_total_int_estimado, @w_mnemonico_tasa_var,
         @w_ppago              , @w_op_modalidad_tasa    , @w_op_descr_tasa,
         @w_base_calculo       , @w_op_dias_reales       , @w_op_oficina,
         @w_op_dia_pago        , @w_op_periodo_tasa      , @w_op_fecha_ult_pg_int,
         @w_op_ente            , @w_puntos                                                         -- GAL 29/SEP/2009 - RVVUNICA

   end --while @@fetch_status =  0

   if @@fetch_status = -2
   begin
      close cursor_pf_tasa_variable
      deallocate cursor_pf_tasa_variable
      raiserror ('200001 - Fallo lectura del cursor 1', 16, 1)
      return 0
   end

--print 'CALINTASAVAR @@FETCH_STATUS '+ cast(@@FETCH_STATUS as varchar)

   close cursor_pf_tasa_variable
   deallocate cursor_pf_tasa_variable

--print 'HACE ROLLBACK..........'
--rollback tran

   if @w_tran_abierta = 'S' begin
      commit tran    --*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*
      select @w_tran_abierta = 'N'
   end


end

return 0

ERROR:
   if @w_tran_abierta = 'S'
      rollback tran

      exec sp_errorlog
           @i_fecha     = @s_date,
           @i_error     = @w_error,
           @i_usuario   = @s_user,
           @i_tran      = @t_trn,
           @i_cuenta    = @w_op_num_banco,
           @s_date      = @s_date,
           @i_descripcion = @w_mensaje,
           @i_cta_pagrec  = @w_codigo

      GOTO SIGUIENTE
go
