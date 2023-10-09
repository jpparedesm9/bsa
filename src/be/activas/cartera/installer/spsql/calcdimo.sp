/************************************************************************/
/*   Archivo:               calcdimo.sp                                 */
/*   Stored procedure:      sp_calculo_diario_mora                      */
/*   Base de datos:         cob_cartera                                 */
/*   Producto:              Cartera                                     */
/*   Disenado por:          Marcelo Poveda                              */
/*   Fecha de escritura:    Ene. 1998                                   */
/************************************************************************/
/*                             IMPORTANTE                               */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'MACOSA'.                                                          */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de MACOSA o su representante.                */
/*                              PROPOSITO                               */
/*   Procedimiento que realiza el calculo diario de intereses de mora   */
/************************************************************************/
/*                              CAMBIOS                                 */
/*   FECHA             AUTOR             CAMBIO                         */
/*  OCT-2010         Elcira Pelaez    Quitar llamado  Diferidos NR059   */
/*  MAR-2011         Elcira Pelaez    Poner control para que retorne 0  */
/*                                    si no hay div. Vencidos           */
/*  ENE-2013         Luis Guzman      CCA 409 Interes Mora Seguros      */
/*  SEP-30_2015      Elcira Pelaez    Optimizacion                      */
/*  ABR-2020         AGO              Desplazamiento de cuotas          */
/************************************************************************/
use cob_cartera
go


if exists (select 1 from sysobjects where name = 'sp_calculo_diario_mora')
   drop proc sp_calculo_diario_mora
go

create proc sp_calculo_diario_mora
   @s_user               login,
   @s_term               varchar(30),
   @s_date               datetime,
   @s_ofi                smallint,
   @i_en_linea           char(1),
   @i_toperacion         catalogo,
   @i_banco              cuenta,
   @i_operacionca        int,
   @i_moneda             smallint,
   @i_dias_anio          smallint,
   @i_sector             catalogo,
   @i_oficina            smallint,
   @i_fecha_liq          datetime,
   @i_fecha_ini          datetime,
   @i_fecha_proceso      datetime,
   @i_tdividendo         catalogo,
   @i_clausula_aplicada  char(1),
   @i_base_calculo       char(1) = 'R',
   @i_dias_interes       smallint,
   @i_tipo               char(1) = null,
   @i_gerente            smallint,
   @i_cotizacion         float,
   @i_num_dec            tinyint,
   @i_num_dec_mn         tinyint = 0,
   @i_est_suspenso       tinyint,
   @i_est_vencido        tinyint,
   @i_parametro_intfac   catalogo,
   @i_parametro_intant   catalogo,
   @i_ciudad_op          int,
   @i_ciudad_nacional    int = 99999,
   @i_concepto_int       catalogo,
   @i_codigo_tmm         catalogo,
   @i_codigo_tmmex       catalogo,
   @i_parametro_mora     catalogo,
   @i_moneda_nacional    smallint,
   @i_moneda_uvr         smallint,
   @i_periodo_anual      char(1),
   @i_tasa_maxima_efa    float,
   @i_tasa_corriente_efa float,
   @i_tasa_corriente_nom float,
   @i_tasa_icte          catalogo,
   @i_modalidad          char(1),
   @i_concepto_cap       catalogo = 'CAP'

as
declare
   @w_secuencial        int,
   @w_error             int,
   @w_sp_name           descripcion,
   @w_monto_mora        money,
   @w_mora_acumulada    money,
   @w_dias_calc         int,
   @w_valor_calc        float,
   @w_codvalor          int,
   @w_di_dividendo      int,
   @w_di_gracia_disp    smallint,
   @w_di_fecha_ven      datetime,
   @w_di_gracia         smallint,
   @w_ro_concepto       catalogo,
   @w_ro_porcentaje     float,
   @w_am_estado         tinyint,
   @w_am_secuencia      tinyint,
   @w_am_periodo        tinyint,
   @w_dtr_monto         float,
   @w_max_dividendo     int,
   @w_dias_dividendo    int,
   @w_fecultpro         datetime,
   @w_dividendo         smallint,
   @w_tasa_equivalente  char(1),
   @w_min_div_vencido   smallint,
   @w_max_div_vencido   smallint,
   @w_sig_dividendo     smallint,
   @w_toperacion        catalogo,
   @w_monto_mn          money,
   @w_estado_op         tinyint,
   @w_estado            tinyint,
   @w_dias_feriados     int,
   @w_reestructuracion  char(1),
   @w_calificacion      char(1),
   @w_dias_mora_retro   int,
   @w_mora_retroactiva  char(1),
   @w_primera_vez       int,
   @w_ms_trn            datetime,
   @w_clase_cartera     catalogo,
   @w_op_tdividendo     char(1),
   @w_op_periodo_int    int,
   @w_dias_int          int,
   -- CALCULO DE LA MORA ACUMULADA (PARA EL CALCULO RETROACTIVO)
   @w_retr_dia          int,
   @w_retr_monto        float,
   @w_retr_val_cal      float,
   @w_retr_valor_mora   float,
   @w_ro_valor          money,
   @w_ciudad            int,
   @w_siguiente_dia     datetime,
   @w_op_monto          money,     -- FCP 10/OCT/2005 REQ 389
   @w_dias_calculados   char,
   @w_dias_anio_mora    smallint,
   @w_fecha_sig         datetime,
   @w_dia_fin           int,
   @w_op_moneda         smallint,
   @w_op_naturaleza     char(1),
   @w_tiene_seguro      char(1),
   @w_banco             cuenta,
   @w_max_fecha         datetime,
   @w_ro_referencial    varchar(55),
   @w_monto_seg_mora    money,
   @w_tramite           int,
   @w_max_sec           int,
   @w_tasa_maxima_mora  float,
   @w_oficina_op        int,
   @w_tipo_amortizacion varchar(10)

   
/* INCIAR VARIABLES DE TRABAJO */
select 
@w_dias_calculados = 'N',
@w_tiene_seguro    = 'N',
@w_monto_seg_mora  = 0


-- SELECCION DE RANGO DE DIVIDENDOS VENCIDOS
select 
@w_min_div_vencido = isnull(min(di_dividendo),0),
@w_max_div_vencido = isnull(max(di_dividendo),0)
from   ca_dividendo
where  di_operacion = @i_operacionca
and    di_estado    = @i_est_vencido

if @w_min_div_vencido = 0 return 0

if @i_moneda = 2 select @i_num_dec_mn = 2 -- PARA MEJORAR LA PRECISION DE UVR

--- DATOS DE LA OPERACION
select 
@w_banco            = op_banco,                            -- REQ 089 - ACUERDOS DE PAGO - 01/DIC/2010
@w_fecultpro        = op_fecha_ult_proceso,
@w_tasa_equivalente = op_usar_tequivalente,
@w_toperacion       = op_toperacion,
@w_estado_op        = op_estado,
@w_reestructuracion = isnull(op_reestructuracion, ''),
@w_calificacion     = isnull(op_calificacion, ''),
@w_mora_retroactiva = op_mora_retroactiva,
@w_clase_cartera    = op_clase,
@w_op_tdividendo    = op_tdividendo,
@w_op_monto         = op_monto,     
@w_op_periodo_int   = op_periodo_int,
@w_op_naturaleza    = op_naturaleza,
@w_op_moneda        = op_moneda,
@w_tramite          = op_tramite,
@w_oficina_op       = op_oficina,
@w_tipo_amortizacion = op_tipo_amortizacion 
from   ca_operacion
where  op_operacion = @i_operacionca

if @@rowcount = 0 begin 
  PRINT 'calcdimo.sp No existe Operacion para este calculo Revisar'
  return  701049
end

if @w_tipo_amortizacion = 'ROTATIVA' return 0

--CONTROL PARA EVITAR EL DEVENGAMIENTO DE MORA DURANTE EL PERIODO DE DESPLAZAMIENTO
if exists ( select 1 from ca_desplazamiento where de_operacion = @i_operacionca 
                     and de_fecha_ini <=@w_fecultpro   
					 and de_fecha_fin > @w_fecultpro
                     and de_estado = 'A') return 0

/* CIUDAD DE LA OFICINA DE LA OPERACION */
select @w_ciudad  = of_ciudad
from   cobis..cl_oficina
where  of_oficina = @i_oficina

--OCT-24-2006 DEF:
if @w_op_naturaleza = 'A'
begin
   if not exists (select 1 from   ca_rubro_op
                  where  ro_operacion = @i_operacionca
                  and    ro_tipo_rubro = 'M')
   begin
      --Insertar el rubro Mora en la tabla de rubros
      insert into ca_rubro_op
            (ro_operacion,             ro_concepto,                ro_tipo_rubro,
             ro_fpago,                 ro_prioridad,               ro_paga_mora,
             ro_provisiona,            ro_signo,                   ro_factor,
             ro_referencial,           ro_signo_reajuste,          ro_factor_reajuste,
             ro_referencial_reajuste,  ro_valor,                   ro_porcentaje,
             ro_gracia,                ro_porcentaje_aux,          ro_principal,
             ro_porcentaje_efa,        ro_concepto_asociado,       ro_garantia,
             ro_tipo_puntos, 	        ro_saldo_op,  	            ro_saldo_por_desem,
             ro_base_calculo,          ro_num_dec,                 ro_tipo_garantia,       
             ro_nro_garantia,          ro_porcentaje_cobertura,    ro_valor_garantia,
             ro_tperiodo,              ro_periodo,                 ro_saldo_insoluto,
             ro_porcentaje_cobrar,     ro_iva_siempre)
      select @i_operacionca,           ru_concepto,                 ru_tipo_rubro,
             ru_fpago,                  ru_prioridad,                ru_paga_mora,
             'S',                       '+',                          0,
             ru_referencial,            '+',                           0,
             null,                      0,                             0,
             0,                         0,                          ru_principal,
             null,                      ru_concepto_asociado,        0,     
             null,                      'N',                         'N', 
             0,                         @i_num_dec,                  ru_tipo_garantia,   
             null,                     'N',                         'N',
             null,                      null,                'N',
             0,                         ru_iva_siempre
      from   ca_rubro
      where  ru_toperacion = @w_toperacion
      and    ru_moneda     = @w_op_moneda
      and    ru_tipo_rubro =  'M' 
      and    ru_concepto = 'IMO'
      
      if @@error <> 0 return 710562
            
   end
   
end


	
-- XMA NR-501
select @w_dias_anio_mora = dt_dias_anio_mora
from ca_default_toperacion
where dt_toperacion = @w_toperacion
and   dt_moneda     = @i_moneda

if @w_dias_anio_mora is null  or @w_dias_anio_mora = 0
   select @w_dias_anio_mora = 365

-- VARIABLES DE TRABAJO
select 
@w_sp_name        = 'sp_calculo_diario_mora',
@i_base_calculo   = 'E',
@w_am_secuencia   = 1,
@w_am_estado      = 1,
@w_primera_vez    = 1,
@w_secuencial     = null

create table #ca_rubro_imo_tmp_1(
ro_operacion          int      null,
ro_concepto           catalogo null,
ro_porcentaje         float    null,
ro_tipo_rubro         char(1)  null,
ro_provisiona         char(1)  null,
ro_fpago              char(1)  null,
ro_concepto_asociado  char(1)  null,
ro_valor              money    null,
ro_num_dec            tinyint  null,
ro_referencial        varchar(10)
)

delete #ca_rubro_imo_tmp_1 where ro_operacion = @i_operacionca

-- CARGA TABLA TEMPORAL DE TRABAJO
insert into #ca_rubro_imo_tmp_1
select 
ro_operacion,         ro_concepto,    ro_porcentaje,
ro_tipo_rubro,        ro_provisiona,  ro_fpago,
ro_concepto_asociado, ro_valor,       ro_num_dec,
ro_referencial
from   ca_rubro_op
where  ro_operacion  = @i_operacionca
and    ro_tipo_rubro = 'M'

if @@rowcount = 0 return 0 -- Si operacion no tiene rubros tipo mora SALIR


/* OTORGAR DIAS DE GRACIA AUTOMATICO EN CASO DE VENCIMIENTO EN FERIADO */   
if @w_mora_retroactiva = 'S' begin
	  
   if exists (select 1 from cobis..cl_dias_feriados
   where df_ciudad in (@w_ciudad, @i_ciudad_nacional)  --si es feriado local o nacional
   and   df_fecha   = @i_fecha_proceso)
   begin
   
      update ca_dividendo set    
      di_gracia      = di_gracia + 1,
	  di_gracia_disp = 1
      where  di_operacion   = @i_operacionca
	  and    di_gracia_disp = 0
            
      if @@error <> 0  return 705043	
   	
   end

end

   	
select @w_dias_int = @w_op_periodo_int * td_factor
from   ca_tdividendo
where  td_tdividendo = @w_op_tdividendo

if @w_estado_op = @i_est_suspenso
   select @w_estado = @i_est_suspenso
else
   if @w_estado_op = 4
      select @w_estado = 4
   else
      select @w_estado = @i_est_vencido

	  
/* LAZO PARA PROCESAR TODOS LOS RUBROS DE MORA */
while 1 = 1  begin

   select top 1                                   -- CCA 409
   @w_ro_concepto    = ro_concepto,
   @w_ro_porcentaje  = ro_porcentaje,
   @w_ro_referencial = ro_referencial
   from   #ca_rubro_imo_tmp_1
   where  ro_operacion = @i_operacionca

   if @@rowcount = 0 break
           
   select @w_max_fecha = max(vr_fecha_vig)
   from   ca_valor_referencial with (nolock)
   where  vr_tipo       = @w_ro_referencial
   and    vr_fecha_vig <= @w_fecultpro
            
   select @w_max_sec = max(vr_secuencial)
   from   ca_valor_referencial with (nolock)
   where  vr_tipo      = @w_ro_referencial
   and    vr_fecha_vig = @w_max_fecha
            
   select @w_tasa_maxima_mora = vr_valor
   from   ca_valor_referencial with (nolock)
   where  vr_tipo       = @w_ro_referencial
   and    vr_fecha_vig  = @w_max_fecha
   and    vr_secuencial = @w_max_sec
   
   -- CONSULTAR TASA DE MORA POR RUBRO Y DIVIDENDO
   exec @w_error = sp_consulta_tasa_mora
   @i_operacionca        = @i_operacionca,
   @i_dividendo          = @w_max_div_vencido, 
   @i_concepto           = @w_ro_concepto,
   @i_sector             = @i_sector,
   @i_fecha              = @i_fecha_proceso,
   @i_dias_anio          = @w_dias_anio_mora, 
   @i_base_calculo       = @i_base_calculo,
   @i_clase_cartera      = @w_clase_cartera,
   @i_tasa_maxima_efa    = @w_tasa_maxima_mora,
   @i_tasa_corriente_efa = @i_tasa_corriente_efa,
   @i_tasa_corriente_nom = @i_tasa_corriente_nom,
   @i_op_tdividendo      = @w_op_tdividendo,
   @i_op_periodo_int     = @w_op_periodo_int,
   @i_modalidad          = @i_modalidad,
   @i_tasa_icte          = @i_tasa_icte,
   @i_dias               = @w_dias_int,
   @o_tasa               = @w_ro_porcentaje out

   if @w_error <> 0 return @w_error

   select @w_sig_dividendo = @w_min_div_vencido

   /* LAZO PARA PROCESAR TODAS LAS CUOTAS DE ESTE RUBRO DE MORA */
   while @w_sig_dividendo <= @w_max_div_vencido   begin
   
      select 
	  @w_di_dividendo   = di_dividendo,
      @w_di_gracia_disp = di_gracia_disp,
      @w_di_fecha_ven   = di_fecha_ven,
      @w_di_gracia      = di_gracia
      from   ca_dividendo
      where  di_operacion  = @i_operacionca
      and    di_dividendo  = @w_sig_dividendo

	     
      -- NUMERO DE DIAS DE CALCULO
      select @w_dias_calc = 1
	  
      if @w_mora_retroactiva = 'S' begin
	     if @w_di_gracia_disp = 0 select @w_dias_calc = @w_di_gracia + 1
		 if @w_di_gracia_disp > 0 goto NEXTDIVIDENDO
      end
   

	  /* DETERMINAR EL VALOR SOBRE EL CUAL SE COBRA LA MORA */
      select @w_monto_mora = isnull(sum( ((am_acumulado + am_gracia - am_pagado)+abs(am_acumulado + am_gracia - am_pagado))/2 ),0)
      from   ca_rubro_op, ca_amortizacion
      where  ro_operacion =  @i_operacionca
      and    ro_paga_mora = 'S'
      and    am_operacion = ro_operacion
      and    am_dividendo = @w_di_dividendo + charindex('A', ro_fpago)
	  
	  select 
	  @w_valor_calc     = 0,
      @w_monto_mora     =  isnull(@w_monto_mora,0)
                         
      if @w_monto_mora > 0 begin
	  
            select @w_mora_acumulada = isnull(sum(am_acumulado - am_pagado), 0)
            from   ca_amortizacion
            where  am_operacion = @i_operacionca
            and    am_dividendo = @w_di_dividendo
            and    am_concepto  = @w_ro_concepto
            
            select @w_am_secuencia = isnull(max(am_secuencia),1)
            from   ca_amortizacion
            where  am_operacion    = @i_operacionca
            and    am_dividendo    = @w_di_dividendo
            and    am_concepto     = @w_ro_concepto
         
            select 
			@w_am_estado  = am_estado,
			@w_am_periodo = am_periodo
            from   ca_amortizacion
            where  am_operacion = @i_operacionca
            and    am_dividendo = @w_di_dividendo
            and    am_concepto  = @w_ro_concepto
            and    am_secuencia = @w_am_secuencia
         
            if @@rowcount = 0 begin
			
               insert ca_amortizacion(
			   am_operacion,   am_dividendo,      am_concepto,
               am_estado,      am_periodo,        am_cuota,
               am_gracia,      am_pagado,         am_acumulado,
               am_secuencia )
               values(
			   @i_operacionca, @w_di_dividendo,   @w_ro_concepto,
               @w_estado,      0,                 0,
               0,              0,                 0,
               1)
            
               if @@error <> 0 return 703079
            
               select 
			   @w_am_estado    = @w_estado,
               @w_am_periodo   = 0
			   
            end

         
            if (@w_monto_mora <> 0) begin
             
               if @w_ro_porcentaje > 0 begin
                              
                  select 
				  @w_retr_dia        = 0,
                  @w_retr_monto      = @w_monto_mora,
                  @w_retr_valor_mora = 0
                              
                  -- ESTE CICLO ES NECESARIO PARA PODER CALCULAR LA MORA DE FORMA EXPONENCIAL (CON LA TASA EFECTIVA)
                  -- VA ACUMULANDO EL CALCULO DE CADA DIA COMO SI FUERA EL CALCULO DIARIO Y APLICA PARA GENERAR MORA
                  -- RETROACTIVA
               
                  while @w_retr_dia < @w_dias_calc begin
				  
                     exec @w_error = sp_calc_intereses
                     @tasa           = @w_ro_porcentaje,
                     @monto          = @w_retr_monto,
                     @dias_anio      = @w_dias_anio_mora,      ---XMA NR501  ANTES  365,
                     @num_dias       = 1,
                     @causacion      = 'E', -- SIGNIFICA EXPONENCIAL (LA TASA ES EFECTIVA) 
                     @causacion_acum = @w_mora_acumulada, --0,
                     @intereses      = @w_retr_val_cal out
                  
                     if @w_error <> 0 return @w_error

                     select 
					 @w_retr_dia        = @w_retr_dia + 1,
                     @w_retr_valor_mora = @w_retr_valor_mora + round(@w_retr_val_cal, @i_num_dec),
                     @w_retr_monto      = @w_retr_monto + round(@w_retr_val_cal, @i_num_dec)
                  
                  end

                  select @w_valor_calc = @w_retr_valor_mora

			   end
            
               select @w_valor_calc   = round(@w_valor_calc, @i_num_dec)
            end
         
            select @w_valor_calc = isnull(@w_valor_calc, 0)
         
            select @w_codvalor = co_codigo * 1000 + @w_am_estado * 10 + 0
            from   ca_concepto
            where  co_concepto = @w_ro_concepto
         
            if @w_valor_calc <> 0 begin

               /* Insertar en tabla de transacciones de PRV */
               insert into ca_transaccion_prv with (rowlock)(
               tp_fecha_mov,        tp_operacion,        tp_fecha_ref,
               tp_secuencial_ref,   tp_estado,           tp_dividendo,
               tp_concepto,         tp_codvalor,         tp_monto,
               tp_secuencia,		tp_ofi_oper)
               values(
               @s_date,             @i_operacionca,      @i_fecha_proceso,
               0,                   'ING',               @w_di_dividendo,
               @w_ro_concepto,      @w_codvalor,         @w_valor_calc,
               @w_am_secuencia,		@w_oficina_op)     
            
               if @@error <> 0 return 708165       
            
               if @w_valor_calc < 0 begin
                 print 'calcdimo   VALOR NEGATIVO ' + cast(@w_valor_calc as varchar) 
                 return 710299
               end

               update ca_amortizacion
               set    am_cuota      = @w_valor_calc  +  am_acumulado,
                      am_acumulado  = @w_valor_calc  +  am_acumulado
               where  am_operacion = @i_operacionca
               and    am_dividendo = @w_di_dividendo
               and    am_concepto  = @w_ro_concepto
               and    am_secuencia = @w_am_secuencia
            
               if @@error <> 0 return 705050
           
               ---PARA VERIFICAR SOBRE QUE BASE SE COBRA LA MORA
               update ca_rubro_op
               set    ro_base_calculo = @w_monto_mora
               where  ro_operacion = @i_operacionca
               and    ro_concepto  = @w_ro_concepto
            
                     
               select @w_valor_calc = 0
            end  -- @w_valor_calc <> 0
      end
   
      NEXTDIVIDENDO:
      select @w_sig_dividendo = @w_sig_dividendo + 1
	  
   end -- WHILE
   
   delete #ca_rubro_imo_tmp_1
   where  ro_operacion  = @i_operacionca
   and    ro_concepto   = @w_ro_concepto   

end

/* DESCONTAR LOS DIAS DE GRACIA DE MORA */	 
update ca_dividendo set    
di_gracia_disp = di_gracia_disp - 1
where  di_operacion    = @i_operacionca
and    di_dividendo    = @w_sig_dividendo	
and    di_gracia_disp >= 0

if @@error <> 0  return 705043	


delete #ca_rubro_imo_tmp_1
where  ro_operacion = @i_operacionca

return 0


go
