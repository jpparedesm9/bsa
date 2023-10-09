   /*estimint.sp*/
/************************************************************************/
/*      Archivo:                estimint.sp                             */
/*      Stored procedure:       sp_estima_int                           */
/*      Base de datos:          cobis                                   */
/*      Producto:               Plazo Fijo                              */
/*      Disenado por:           Nidia Silva                             */
/*      Fecha de documentacion: 24-May-2005                             */
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
/*      Este script crea la funcion que realiza la estimacion de        */
/*      los intereses que han de ser generados por la operacion         */
/*                                                                      */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA      AUTOR              RAZON                             */
/************************************************************************/
/*      24-May-2005  G. Arboleda      Emision Inicial                   */
/*      17-May-06    Clotilde Vargas  Depositos escalonados             */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS ON
go

SET QUOTED_IDENTIFIER ON
go

if exists ( select 1 from sysobjects where type ='P' and name = 'sp_estima_int')
   drop proc sp_estima_int
go

create proc sp_estima_int( 
   @s_ssn                  int           = NULL,
   @s_user                 login         = NULL,
   @s_sesn                 int           = NULL,
   @s_term                 varchar(30)   = NULL,
   @s_date                 datetime      = NULL,
   @s_srv                  varchar(30)   = NULL,
   @s_lsrv                 varchar(30)   = NULL,
   @s_ofi                  smallint      = NULL,
   @s_rol                  smallint      = NULL,
   @t_debug                char(1)       = 'N',
   @t_file                 varchar(10)   = NULL,
   @t_from                 varchar(32)   = NULL,
   @t_trn                  smallint      = NULL,

   @i_cambia_dia_pago      char(1)       = 'S',
   @i_dias_reales          char(1)       = 'S',
   @i_fecha_inicio         datetime,
   @i_fecha_final          datetime,
   @i_dia_pago             tinyint,
   @i_monto                money,
   @i_tasa                 float,
   @i_fpago                catalogo,
   @i_ppago                catalogo,
   @i_dias_anio            smallint,
   @i_moneda               money,             
   @i_tcapitalizacion      char(1)       = 'N',
   @i_migra                char(1)       = 'N',
   @i_int_pagados          money         = 0,
   --Parametros para Escalonados
   @i_op_operacion         int           = NULL,
   @i_calc_mod             char(1)       = 'N',
   -- INI NYM DPF00015 ICA
   @i_retienimp            char(1)       = 'N',
   @i_tasa1                decimal(30,6) = 0,
   @i_ret_ica              char(1)       = 'N',
   @i_tasa_ica             decimal(30,6) = NULL,
   @i_numdeci_imp          tinyint       = 2,
   @i_batch                char(1)       = NULL,         -- GAL 01/SEP/2009 - CSQL  
   @i_simulacion           char(1)       = NULL,         -- GAL 01/SEP/2009 - CSQL
   @i_ente                 int           = NULL,         -- GAL 01/SEP/2009 - CSQL
   @i_tasa_imp             float         = NULL,         -- GAL 01/SEP/2009 - CSQL
   @i_modifica             char(1)       = NULL,         -- GAL 01/SEP/2009 - CSQL
   @i_toperacion           catalogo      = NULL,         -- GAL 01/SEP/2009 - CSQL
   @i_periodo_tasa         smallint      = NULL,         -- GAL 01/SEP/2009 - CSQL
   @i_modalidad_tasa       char(1)       = NULL,         -- GAL 01/SEP/2009 - CSQL
   @i_descr_tasa           descripcion   = NULL,         -- GAL 01/SEP/2009 - CSQL
   @i_mnemonico_tasa       catalogo      = NULL,         -- GAL 01/SEP/2009 - CSQL
   @i_tipo_plazo           varchar(5)    = NULL,         -- GAL 01/SEP/2009 - CSQL
   @i_en_linea             char(1)       = NULL,         -- GAL 01/SEP/2009 - CSQL
   @o_tot_impuesto_pg_ve   money         = NULL out,
   -- FIN NYM DPF00015 ICA
   @o_fecha_prox_pg        datetime      = NULL out,
   @o_fecha_real_pg        datetime      = NULL out,
   @o_int_pg_pp            money         = NULL out,
   @o_int_pg_ve            money         = NULL out,
   @o_num_pagos            smallint      = NULL out,
   @o_tot_int_est_neto     money         = NULL out      -- NYM DPF00015 ICA
)
with encryption
as
declare 
    @w_sp_name            varchar(30),
    @w_num_meses          int,
    @w_usadeci            char(1), --29-Abr-99 capitalizacion xca B063
    @w_numdeci            tinyint, --29-Abr-99 capitalizacion xca B063
    @w_aux_fech_prox_pago datetime,
    @w_fecha_medio        datetime,
    @w_num_pago           int,
    @w_interes_total      money,
    @w_monto              money,
    @w_fecha_inicial      datetime,
    @w_fecha_inicio       datetime,
    @w_interes            money,
    @w_contpagos          int,
    @w_num_dias_periodo   int,
    @w_residuo            int,
    @w_aux_fech_ant_pago  datetime,
    @w_calcula_dia_pago   char(1),
    @w_dias_a_pagar       int,  --+-+
    @w_dias_esc           int,
    @w_factor_dias        smallint,  --CVA May-09-06 
    @w_cont               int,  --CVA May-09-06 
    @w_di_mes             char(2),
    @w_di_anio            char(4),
    @w_di_dias            char(2),
    @w_di_mes_int         int,
    @w_di_anio_int        int,
    @w_di_dias_int        int,
    @w_dias_orig          int,
    @w_tasa               float,
    @w_operador           char(1),    
    @w_spread             float,     
    @w_tasa_max           float, 
    @w_tasa_min           float, 
    @w_plazo_dif_C        int,
    @w_plazo_C            int,
    @w_plazo_2            int,
    @w_plazo_3            int,
    @w_cuantos            tinyint,
    @w_pos                tinyint,
    @w_escalonado         char(1),
    @w_siguiente          tinyint,
    @w_avance             tinyint,
    @w_dif_periodo1       int,
    @w_dif_periodo2       int,
    @w_dif_periodo3       int,
    @w_fecha_siguiente    datetime,

    @w_tasa_2             float,
    @w_tasa_3             float,
    @w_tasa_act           float,
    @w_trans_act          int,
    @w_valor_tasa_var     float,
    @w_return             int,
    @w_fecha_cambio       datetime,
    @w_dias_trans         int,
    @w_op_fecha_valor     datetime,
    @w_monto1             money,     /* CVA Mar-22-07 */
    --INI NYM DPF00015 ICA
    @w_interes_neto_aux   money,
    @w_impuesto           decimal(30,6),
    @w_impuesto_ica       decimal(30,6),
    @w_monto_aux          money,
    @w_imp_per_1          money,
    @w_acum_impuestos     money,
    --FIN NYM DPF00015 ICA
    @w_interes_neto       money,
    @w_dias_cuota         smallint, -- GAL 07/SEP/2009 - RVVUNICA
    @w_min_numdias_cuota  smallint,  -- GAL 07/SEP/2009 - RVVUNICA
    @w_fecha_temp         datetime,
    @w_retienimp          char(1), 
    @w_tasa_ret  decimal(30,6)
    

select  
   @w_sp_name           = 'sp_estima_int',
   @w_monto1            = 0,
   @w_acum_impuestos    = 0

select @w_monto1 = @i_monto
 
select @w_usadeci = mo_decimales
from cobis..cl_moneda
where mo_moneda = @i_moneda
if @w_usadeci = 'S'
begin
   select @w_numdeci = isnull(pa_tinyint,0)
   from cobis..cl_parametro
   where pa_nemonico = 'DCI' 
   and   pa_producto = 'PFI'
end
else
   select @w_numdeci = 0    

select @w_min_numdias_cuota = pa_smallint          -- GAL 04/SEP/2009 - RVVUNICA
from cobis..cl_parametro
where pa_nemonico = 'MINDCU'
and   pa_producto = 'PFI'
   
if @i_fpago = 'PER'
begin
	-----------------------------------
	-- Calculo para pagos peri¢dicos
	-----------------------------------
	select @w_num_meses    = pp_factor_en_meses,
	  @w_factor_dias  = pp_factor_dias  --CVA May-09-06
	from pf_ppago
	where ltrim(rtrim(pp_codigo)) = ltrim(rtrim(@i_ppago))
	
	select @w_aux_fech_prox_pago  = @i_fecha_inicio 
	
	select @w_num_pago = 1
	
	--print 'Estimaint 1 @w_num_meses %1! , @w_factor_dias %2! , @w_aux_fech_prox_pago %3! i_fecha_final %4! ',@w_num_meses, @w_factor_dias, @w_aux_fech_prox_pago, @i_fecha_final
	---------------------------
	-- Numero de pagos
	---------------------------
	while @w_aux_fech_prox_pago <  @i_fecha_final
	begin
		select @w_aux_fech_ant_pago   = @w_aux_fech_prox_pago   

		-- INICIO - GAL 12/SEP/2009 - RVVUNICA
		if @i_cambia_dia_pago = 'S'
		begin         
			if @i_dias_reales = 'S'                                                                
				select @w_aux_fech_prox_pago = dateadd(dd, @w_factor_dias, @w_aux_fech_prox_pago)
			else
				exec sp_funcion_1 
					@i_operacion = 'SUMDIA',
					@i_fechai    = @w_aux_fech_prox_pago,
					@i_dias      = @w_factor_dias,
					@i_dia_pago  = @i_dia_pago,
					@i_batch = 0,	--*-*
					@o_fecha     = @w_aux_fech_prox_pago out
			
			exec sp_dia_pago 
				@i_fecha               = @w_aux_fech_prox_pago, 
				@i_dia_pago            = @i_dia_pago,     
				@o_fecha_proximo_pago  = @w_aux_fech_prox_pago out
			-- FIN - GAL 12/SEP/2009 - RVVUNICA
		end --cambia dia pago
		else
			select @w_aux_fech_prox_pago = dateadd(mm, @w_num_meses, @w_aux_fech_prox_pago)

--print 'estimint2 @w_aux_fech_prox_pago' + cast(@w_aux_fech_prox_pago as varchar) + '@s_date' + cast(@s_date as varchar) 

		-- CVA Ene-31-06
		if @w_aux_fech_prox_pago > @i_fecha_final
			select @w_aux_fech_prox_pago  = @i_fecha_final

		--CVA Ene-10-05 Proxima fecha de pago mayor a fecha de sistema
		if @s_date is not null
		begin
      			while 1 = 1 --@w_aux_fech_prox_pago <= @s_date                  -- GAL 07/SEP/2009 - RVVUNICA
			begin      
				-- INICIO - GAL 12/SEP/2009 - RVVUNICA
				if @i_dias_reales = 'S'
					select @w_dias_cuota = datediff(dd, @w_aux_fech_ant_pago, @w_aux_fech_prox_pago)
				else
					exec sp_funcion_1 
						@i_operacion = 'DIFE30',
						@i_fechai    = @w_aux_fech_ant_pago,
						@i_fechaf    = @w_aux_fech_prox_pago,
						@i_dia_pago  = @i_dia_pago,
						@i_batch = 0,	--*-*
						@o_dias      = @w_dias_cuota out  

--print 'estiminXXX @w_aux_fech_ant_pago' + cast(@w_aux_fech_ant_pago as varchar) + '@w_aux_fech_prox_pago' + cast(@w_aux_fech_prox_pago as varchar) + '@w_dias_cuota' + cast(@w_dias_cuota as varchar) 
--print 'estimin GGGG @s_date' + cast(@s_date as varchar) + '@w_aux_fech_prox_pago' + cast(@w_aux_fech_prox_pago as varchar) + '@w_min_numdias_cuota' + cast(@w_min_numdias_cuota as varchar) 
               
				if @w_aux_fech_prox_pago > @s_date  and  @w_dias_cuota >= @w_min_numdias_cuota
				begin
---*-*-*print 'estimin KKKK @s_date' + cast(@s_date as varchar) + '@w_aux_fech_prox_pago' + cast(@w_aux_fech_prox_pago as varchar) + '@w_dias_cuota' + cast(@w_dias_cuota as varchar) 					
					break
				end
               
				if @i_cambia_dia_pago = 'S'
				begin
					if @i_dias_reales = 'S' 
						select @w_aux_fech_prox_pago = dateadd(dd, @w_factor_dias, @w_aux_fech_prox_pago)
					else
						exec sp_funcion_1 
							@i_operacion = 'SUMDIA',
							@i_fechai    = @w_aux_fech_prox_pago,
							@i_dias      = @w_factor_dias,
							@i_dia_pago  = @i_dia_pago,
							@i_batch = 0,	--*-*
							@o_fecha     = @w_aux_fech_prox_pago out
				end
				else
					select @w_aux_fech_prox_pago  = dateadd(mm, @w_num_meses , @w_aux_fech_prox_pago)                     

				exec sp_dia_pago 
					@i_fecha               = @w_aux_fech_prox_pago, 
					@i_dia_pago            = @i_dia_pago,                 
					@o_fecha_proximo_pago  = @w_aux_fech_prox_pago out
					-- FIN - GAL 12/SEP/2009 - RVVUNICA
			end
		end      
   
		if @w_num_pago = 1 
		begin
			select @o_fecha_prox_pg = @w_aux_fech_prox_pago  

			if @i_dias_reales = 'S' 
				select @w_fecha_temp = dateadd(dd, @w_factor_dias, @w_aux_fech_prox_pago)
			else
				exec sp_funcion_1 
					@i_operacion = 'SUMDIA',
					@i_fechai    = @w_aux_fech_prox_pago,
					@i_dias      = @w_factor_dias,
					@i_dia_pago  = @i_dia_pago,
					@i_batch = 0,	--*-*
					@o_fecha     = @w_fecha_temp out

			if @i_dias_reales = 'S'         
				select @w_residuo = datediff(dd, @w_aux_fech_prox_pago, @i_fecha_final)
			else
			exec sp_funcion_1 
				@i_operacion  = 'DIFE30',
				@i_fechai     = @w_aux_fech_prox_pago,
				@i_fechaf     = @i_fecha_final,
				@i_dia_pago   = @i_dia_pago,
				@i_batch = 0,	--*-*
				@o_dias       = @w_residuo out  
			
--print 'EXTIMMM...  w_aux_fech_prox_pago'+cast(@w_aux_fech_prox_pago as varchar)+'@i_fecha_final'+cast(@i_fecha_final as varchar)+'@w_residuo'+cast(@w_residuo as varchar) + '@o_fecha_prox_pg:'+ cast(@o_fecha_prox_pg as varchar)
			if @w_fecha_temp >=  @i_fecha_final and @w_residuo <= @w_min_numdias_cuota and @i_batch = 'C'
			begin
				select @w_aux_fech_prox_pago    = @i_fecha_final
				select @o_fecha_prox_pg 	= @w_aux_fech_prox_pago  
			end			
--print 'EXTIKKKKKKKKK...  w_aux_fech_prox_pago'+cast(@w_aux_fech_prox_pago as varchar)+'@i_fecha_final'+cast(@i_fecha_final as varchar)+'@w_residuo'+cast(@w_residuo as varchar) + '@o_fecha_prox_pg:'+ cast(@o_fecha_prox_pg as varchar)
		end			

		if @w_aux_fech_prox_pago <  @i_fecha_final
		begin
			select @w_num_pago = @w_num_pago + 1
			select @w_residuo = 0
		end
		else
		begin
			if @i_dias_reales = 'S'         
				select @w_residuo = datediff(dd, @w_aux_fech_ant_pago, @i_fecha_final)
			else
			exec sp_funcion_1 
				@i_operacion  = 'DIFE30',
				@i_fechai     = @w_aux_fech_ant_pago,
				@i_fechaf     = @i_fecha_final,
				@i_dia_pago   = @i_dia_pago,
				@i_batch = 0,	--*-*
				@o_dias       = @w_residuo out  
      
			if @w_residuo <= @w_min_numdias_cuota
				select @w_num_pago = @w_num_pago - 1
		end
	end -- WHILE

	select @o_num_pagos = @w_num_pago
	
	if @i_dias_reales = 'S'
		select @w_dias_a_pagar = datediff(dd,@i_fecha_inicio, @o_fecha_prox_pg)
	else
	exec sp_funcion_1   
		@i_operacion  = 'DIFE30',
		@i_fechai     = @i_fecha_inicio,
		@i_fechaf     = @o_fecha_prox_pg,
		@i_dia_pago   = @i_dia_pago,
		@i_batch = 0,	--*-*
		@o_dias       = @w_dias_a_pagar out   

	select @w_dias_trans = datediff(dd,@i_fecha_inicio,@o_fecha_prox_pg)


--print 'estimint 4 @w_dias_a_pagar' + cast(@w_dias_a_pagar as varchar) + '@o_fecha_prox_pg' + cast(@o_fecha_prox_pg as varchar)
      
   
	select @o_int_pg_pp = round(@w_monto1 * @i_tasa * @w_dias_a_pagar/(@i_dias_anio*100), @w_numdeci)
--print ' estimaint 5 @w_monto1 %1! , @i_tasa %2! , @w_dias_a_pagar %3! , @i_dias_anio %4! ',@w_monto1, @i_tasa, @w_dias_a_pagar, @i_dias_anio

--print 'ESTIM.... @w_monto1:' + cast(@w_monto1 as varchar) + ' @i_tasa:'+ cast(@i_tasa as varchar) + ' @i_dias_anio:'+ cast(@i_dias_anio as varchar)


end
else
begin
   -----------------------------------
   --Calculo para pagos al vencimiento
   -----------------------------------
   if @i_dias_reales = 'S'
      select @w_dias_a_pagar = datediff(dd,@i_fecha_inicio, @i_fecha_final)
   else
      exec sp_funcion_1 
         @i_operacion = 'DIFE30',
         @i_fechai    = @i_fecha_inicio,
         @i_fechaf    = @i_fecha_final,
         @i_dia_pago  = @i_dia_pago,
         @i_batch = 0,	--*-*
         @o_dias      = @w_dias_a_pagar out   
   
   select @o_fecha_prox_pg = @i_fecha_final
   select @o_num_pagos = 1

   select @o_int_pg_pp = round(@i_monto*@i_tasa*@w_dias_a_pagar/(@i_dias_anio*100), @w_numdeci)
end

select @o_fecha_real_pg = @o_fecha_prox_pg

if @i_dias_reales = 'S'
   select @w_dias_a_pagar = datediff(dd,@i_fecha_inicio, @i_fecha_final)
else
   exec sp_funcion_1 
      @i_operacion  = 'DIFE30',
      @i_fechai     = @i_fecha_inicio,
      @i_fechaf     = @i_fecha_final,
      @i_dia_pago   = @i_dia_pago,
      @i_batch = 0,	--*-*
      @o_dias       = @w_dias_a_pagar out   

select @o_int_pg_ve = round(@i_monto*@i_tasa*@w_dias_a_pagar/(@i_dias_anio*100), @w_numdeci)        -- GAL 14/SEP/2009 - RVVUNICA - redondeo

--print '@o_int_pg_ve %1! , @i_monto %2! , @i_tasa %3! , @w_dias_a_pagar %4! ', @o_int_pg_ve, @i_monto, @i_tasa, @w_dias_a_pagar
------------------------------
-- Control para capitalizaci¢n
-------------------------------  
--*-*select @w_monto = @i_monto

if @i_migra = 'N'
begin
   select @w_monto              = @i_monto + @o_int_pg_pp               --*-*
   select @w_interes_total      = @o_int_pg_pp
   select @w_fecha_inicio       = @o_fecha_prox_pg
   select @w_aux_fech_prox_pago = @o_fecha_prox_pg 

   exec sp_aplica_impuestos
       @s_ofi                  = @s_ofi,
       @s_date                 = @s_date,
       @t_debug                = @t_debug,
       @i_ente                 = @i_ente,
       @i_plazo                = @w_dias_a_pagar,
       @i_capital              = @i_monto,
       @i_interes              = @o_int_pg_ve,
       @i_base_calculo         = @i_dias_anio,
       @o_retienimp            = @w_retienimp out,
       @o_tasa_retencion       = @w_tasa_ret out,
       @o_valor_retencion      = @w_impuesto out

   select @o_tot_int_est_neto   = @o_int_pg_ve - @w_impuesto
   select @o_tot_impuesto_pg_ve = @w_impuesto
   --FIN NYM DPF00015 ICA
end

if @i_migra = 'S'
begin 
   select @w_monto              = @i_monto                              --*-*
   select @w_interes_total      = @i_int_pagados   --@o_int_pg_pp
   select @w_fecha_inicio       = @o_fecha_prox_pg
   select @w_aux_fech_prox_pago = @o_fecha_prox_pg
end
select @w_contpagos = 2, @w_interes = 0

--print 'antes de: %1!', @o_int_pg_ve

if @i_tcapitalizacion = 'S'	-- ********************************************************************************************************
begin
   select @w_fecha_inicial = @w_fecha_inicio

      exec sp_aplica_impuestos
       @s_ofi                  = @s_ofi,
       @s_date                 = @s_date,
       @t_debug                = @t_debug,
       @i_ente                 = @i_ente,
       @i_plazo                = @w_dias_a_pagar,
       @i_capital              = @i_monto,
       @i_interes              = @o_int_pg_pp,
       @i_base_calculo         = @i_dias_anio,
       @o_retienimp            = @w_retienimp out,
       @o_tasa_retencion       = @w_tasa_ret out,
       @o_valor_retencion      = @w_impuesto out
   
         
   select @w_monto         = @w_monto - @w_impuesto
   select @w_interes_neto  = @w_interes_total - @w_impuesto
   -- FIN - GAL 02/SEP/2009 - RVVUNICA
   
   while (@o_num_pagos >= @w_contpagos)
   begin

      -- INICIO - GAL 12/SEP/2009 - RVVUNICA
      if @i_cambia_dia_pago = 'S'
      begin
         if @i_dias_reales = 'S'                                                                
            select @w_aux_fech_prox_pago = dateadd(dd, @w_factor_dias, @w_aux_fech_prox_pago)
         else
            exec sp_funcion_1 
               @i_operacion = 'SUMDIA',
               @i_fechai    = @w_aux_fech_prox_pago,
               @i_dias      = @w_factor_dias,
               @i_dia_pago  = @i_dia_pago,
               @i_batch = 0,	--*-*
               @o_fecha     = @w_aux_fech_prox_pago out

      end
      else
         select @w_aux_fech_prox_pago = dateadd(mm, @w_num_meses, @w_aux_fech_prox_pago)
         
      exec sp_dia_pago 
         @i_fecha               = @w_aux_fech_prox_pago, 
         @i_dia_pago            = @i_dia_pago,     
         @o_fecha_proximo_pago  = @w_aux_fech_prox_pago out
      
      /*      
      if @i_cambia_dia_pago = 'S'
         select @w_aux_fech_prox_pago = dateadd(dd,@w_factor_dias,@w_aux_fech_prox_pago)
      else
         select @w_aux_fech_prox_pago = dateadd(mm,@w_num_meses,@w_aux_fech_prox_pago)
      
      select @w_num_dias_periodo = datediff(dd,@w_fecha_inicio, @w_aux_fech_prox_pago)
      
      -- Gar Considerar el dia de pago
      if @i_cambia_dia_pago = 'S'
      begin
         exec sp_dia_pago 
            @i_fecha               = @w_aux_fech_prox_pago,
            @i_dia_pago            = @i_dia_pago,
            @o_fecha_proximo_pago  = @w_aux_fech_prox_pago out

         select @w_num_dias_periodo = datediff(dd,@w_fecha_inicio, @w_aux_fech_prox_pago)
      end
      */
      -- FIN - GAL 12/SEP/2009 - RVVUNICA
                
      if @i_dias_reales = 'S'
         select @w_num_dias_periodo = datediff(dd, @w_fecha_inicio, @w_aux_fech_prox_pago)
      else
         exec sp_funcion_1 @i_operacion   = 'DIFE30',
            @i_fechai    = @w_fecha_inicio,
            @i_fechaf    = @w_aux_fech_prox_pago,
            @i_dia_pago  = @i_dia_pago,
            @i_batch = 0,	--*-*
            @o_dias      = @w_num_dias_periodo out                  
                      
      select @w_fecha_inicio = @w_aux_fech_prox_pago

      if @w_contpagos = @o_num_pagos
         if @w_residuo <= @w_min_numdias_cuota
            select @w_num_dias_periodo = @w_num_dias_periodo + @w_residuo
         else
            select @w_num_dias_periodo = @w_residuo
            
      -- INTERES ESTIMADO POR PERIODO
      select @w_interes       = round(((@w_monto * @i_tasa * @w_num_dias_periodo)/(@i_dias_anio * 100)), @w_numdeci)
      select @w_fecha_inicial = @w_aux_fech_prox_pago
            
            
      exec sp_aplica_impuestos
       @s_ofi                  = @s_ofi,
       @s_date                 = @s_date,
       @t_debug                = @t_debug,
       @i_ente                 = @i_ente,
       @i_plazo                = @w_dias_a_pagar,
       @i_capital              = @i_monto,
       @i_interes              = @w_interes,
       @i_base_calculo         = @i_dias_anio,
       @o_retienimp            = @w_retienimp out,
       @o_tasa_retencion       = @w_tasa_ret out,
       @o_valor_retencion      = @w_impuesto out
            
      --FIN NYM DPF00015 ICA
      select @w_interes_total  = @w_interes_total + @w_interes
      select @w_monto          = @w_monto + @w_interes - @w_impuesto
      select @w_interes_neto   = @w_interes_neto + @w_interes - @w_impuesto

      select @w_acum_impuestos = @w_acum_impuestos   + @w_impuesto
      --FIN NYM DPF00015 ICA
      select @w_contpagos  = @w_contpagos + 1
   end --while pagos

   select @o_int_pg_ve          = isnull(@w_interes_total, 0)
   select @o_tot_impuesto_pg_ve = isnull(@w_acum_impuestos, 0)   --NYM DPF00015 ICA
   select @o_tot_int_est_neto   = isnull(@w_interes_neto, 0)   --@w_monto_aux - @i_monto  --NYM DPF00015 ICA  -- GAL 02/SEP/2009 - RVVUNICA
end

return 0
go 
