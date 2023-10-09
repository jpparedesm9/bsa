/************************************************************************/
/*   Archivo:             calcdint.sp                                   */
/*   Stored procedure:    sp_calculo_diario_int                         */
/*   Base de datos:       cob_cartera                                   */
/*   Producto:            Cartera                                       */
/*   Disenado por:        Fabian de la Torre                            */
/*   Fecha de escritura:  Ene. 1998                                     */
/************************************************************************/
/*                                IMPORTANTE                            */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'MACOSA'.                                                          */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de MACOSA o su representante.                */
/************************************************************************/
/*                                 PROPOSITO                            */
/*   Procedimiento que realiza el calculo diario de intereses.          */
/*                              CAMBIOS                                 */
/************************************************************************/
/*      FECHA             AUTOR         CAMBIO                          */
/*      JUN-09-2010       ELcira Pelaez Causacion Pasivas  igual a las  */
/*                                      activas                         */
/*      OCT-2010         Elcira Pelaez  Quitar llamado a Diferidos NR059*/
/*      ABR-2020         AGO            Desplazamiento de cuotas        */
/*      Jun-2020         DCU            Caso:141499 - Control desplaza  */
/*      19/01/2022       DCU            Caso:170130 - IFRS              */
/************************************************************************/
use cob_cartera
go

if exists (select 1 from sysobjects where name = 'sp_calculo_diario_int')
   drop proc sp_calculo_diario_int
go

create proc sp_calculo_diario_int
   @s_user                login,
   @s_term                varchar(30),
   @s_date                datetime,
   @s_ofi                 smallint,
   @i_en_linea            char(1),
   @i_toperacion          catalogo,
   @i_banco               cuenta,
   @i_operacionca         int,
   @i_moneda              smallint,
   @i_dias_anio           smallint,
   @i_sector              catalogo,
   @i_oficina             smallint,
   @i_fecha_liq           datetime,
   @i_fecha_ini           datetime,
   @i_fecha_proceso       datetime,
   @i_tdividendo          catalogo,
   @i_clausula_aplicada   char(1),
   @i_base_calculo        char(1) = 'R',
   @i_dias_interes        smallint,
   @i_tipo                char(1) = null, -- TIPO DE OPERACION (de ca_operacion.op_tipo)
   @i_gerente             smallint,
   @i_cotizacion          money   = null,
   @i_parametros_llamada  char = 'N',
   @i_parametro_int       catalogo = null,
   @i_moneda_nacional     tinyint  = 0,
   @i_concepto_cap        catalogo = null,
   @i_num_dec             smallint = null,
   @i_causacion           char(1)  = null,
   @i_fecultpro           datetime = null,
   @i_gar_admisible       char(1)  = null,
   @i_reestructuracion    char(1)  = null,
   @i_calificacion        char(1)  = null,
   @i_num_dec_mn          tinyint  = 0
as
declare
   @w_error                   int,
   @w_saldo_cap               money,
   @w_dias_calc               tinyint,
   @w_valor_calc              float,
   @w_codvalor                int,
   @w_di_dividendo            smallint,
   @w_di_fecha_ini            datetime,
   @w_di_fecha_ven            datetime,
   @w_di_estado               tinyint,
   @w_ro_concepto             catalogo,
   @w_ro_porcentaje           float,
   @w_ro_porcentaje_efa       float,
   @w_ro_tipo_rubro           char(1),
   @w_ro_fpago                char(1),
   @w_ro_provisiona           char(1),
   @w_est_vigente             tinyint,
   @w_est_vencido             tinyint,
   @w_est_cancelado           tinyint,
   @w_am_cap_pagado           money,
   @w_am_cuota                money,
   @w_am_acumulado            float,
   @w_am_estado               tinyint,
   @w_am_secuencia            tinyint,
   @w_am_pagado               money,
   @w_monto_prv               money,
   @w_concepto_asociado       catalogo,
   @w_detalle_nuevo           char(1),
   @w_mora_clausula           money,
   @w_dias_dividendo          int,
   @w_causacion_acum          float,
   @w_diasdif                 int,
   @w_moneda_nac              smallint,
   @w_monto_mn                money,
   @w_cot_mn                  money,
   @w_concepto_original       catalogo, ---EPB:MAY-06-2002 para asignar simepre INT 
   @w_moneda_uvr              tinyint,
   @w_count                   int,
   @w_ro_valor                money,
   @w_op_monto                money,    -- FCP 10/OCT/2005 REQ 389
   @w_fecha_sigiente          datetime,
   @w_ajus_esp                char(1),
   @w_op_sector               catalogo,  -- JBQ REQ0XX MAR/09
   @w_va_tlu                  float,
   @w_param_tlu_mn            varchar(30),
   @w_sec_tlu                 int,
   @w_fec_tlu                 datetime,
   @w_tasa                    float,
   @w_tasa_equivalente        char(1),
   @w_gracia_int              smallint,            -- REQ 175: PEQUEÑA EMPRESA
   @w_dist_gracia             char(1),             -- REQ 175: PEQUEÑA EMPRESA
   @w_capitalizado            money,               -- REQ 175: PEQUEÑA EMPRESA
   @w_banco                   cuenta,              -- REQ 089: ACUERDOS DE PAGO - 01/DIC/2010
   @w_fult_proceso            datetime,            -- REQ 089: ACUERDOS DE PAGO - 01/DIC/2010   
   @w_oficina_op              int,
   @w_tipo_amortizacion       varchar(10),
   @w_est_etapa2              int,
   @w_est_castigado           int,
   @w_est_suspenso            int,
   @w_est_novigente           int,
   @w_estado_op               int

--VARIABLES DE TRABAJO
/*select 
@w_est_vigente    = 1,
@w_est_vencido    = 2,
@w_est_cancelado  = 3*/

/* ESTADOS DE CARTERA */
exec @w_error = sp_estados_cca
@o_est_novigente  = @w_est_novigente out,
@o_est_vigente    = @w_est_vigente   out,
@o_est_vencido    = @w_est_vencido   out,
@o_est_cancelado  = @w_est_cancelado out,
@o_est_suspenso   = @w_est_suspenso  out,
@o_est_castigado  = @w_est_castigado out,
@o_est_etapa2     = @w_est_etapa2    out 


--CODIGO DE LA MONEDA UVR
select @w_moneda_uvr = pa_tinyint
from   cobis..cl_parametro
where  pa_producto = 'CCA'
and    pa_nemonico = 'MUVR'

if @@rowcount = 0 begin
   select @w_error = 710256
end


select 
@w_banco             = op_banco,                      -- REQ 089: ACUERDOS DE PAGO - 01/DIC/2010
@w_op_monto          = op_monto,                         
@w_op_sector         = op_sector,
@w_tasa_equivalente  = op_usar_tequivalente,
@w_gracia_int        = op_gracia_int,                 -- REQ 175: PEQUEÑA EMPRESA
@w_dist_gracia       = op_dist_gracia,                -- REQ 175: PEQUEÑA EMPRESA
@w_fult_proceso      = op_fecha_ult_proceso,          -- REQ 089: ACUERDOS DE PAGO - 01/DIC/2010
@w_oficina_op        = op_oficina,
@w_tipo_amortizacion = op_tipo_amortizacion,
@w_estado_op         = op_estado
from   ca_operacion
where  op_operacion = @i_operacionca

if @w_tipo_amortizacion = 'ROTATIVA' return 0

--CONTROL PARA EVITAR EL DEVENGAMIENTO DE INTERESES DURANTE EL PERIODO DE DESPLAZAMIENTO
if exists ( select 1 from ca_desplazamiento where de_operacion = @i_operacionca 
                     and de_fecha_ini <=@w_fult_proceso   
					 and de_fecha_fin > @w_fult_proceso
                     and de_estado = 'A') return 0

-- REQ 089: ACUERDOS DE PAGO - EN ACUERDOS DE CANCELACION LA OPERACION DEJA DE DEVENGAR INTERESES - 30/NOV/2010
if exists (select 1
from cob_credito..cr_acuerdo
where ac_banco              = @w_banco
and   ac_estado             = 'V'                         -- NO ANULADOS
and   ac_tacuerdo           = 'P'                         -- PRECANCELACION
and   @w_fult_proceso between ac_fecha_ingreso and ac_fecha_proy)
   return 0

-- REQ 175: PEQUEÑA EMPRESA - CALCULAR EL MONTO CAPITALIZADO
select @w_capitalizado =  isnull(sum(isnull(ro_base_calculo, 0)),0)
from   ca_rubro_op
where  ro_operacion  = @i_operacionca
and    ro_tipo_rubro = 'C'
   

--Parametro general de Intereses
if @i_parametros_llamada = 'N' begin
   select 
   @i_parametro_int = pa_char
   from   cobis..cl_parametro
   where  pa_producto = 'CCA'
   and    pa_nemonico = 'INT'
   if @@rowcount = 0
      return  701059
         
   -- CODIGO DE LA MONEDA LOCAL
   select 
   @i_moneda_nacional = pa_tinyint
   from   cobis..cl_parametro
   where  pa_producto = 'ADM'
   and    pa_nemonico = 'MLO'
   if @@rowcount = 0
      return  708174
   
   select 
   @i_concepto_cap = ro_concepto
   from   ca_rubro_op
   where  ro_operacion  = @i_operacionca
   and    ro_tipo_rubro = 'C'
   
   -- DATOS DE LA OPERACION
   select 
   @i_causacion         = op_causacion,
   @i_fecultpro         = op_fecha_ult_proceso,
   @i_gar_admisible     = isnull(op_gar_admisible, ''),
   @i_reestructuracion  = isnull(op_reestructuracion, ''),  
   @i_calificacion      = isnull(op_calificacion, '')      
   from   ca_operacion
   where  op_operacion = @i_operacionca
end

if @i_cotizacion is null and @i_moneda = @i_moneda_nacional
   select @i_cotizacion = 1.00

select @w_di_dividendo = di_dividendo,
       @w_di_fecha_ini = di_fecha_ini,
       @w_di_fecha_ven = di_fecha_ven,
       @w_di_estado    = di_estado
from   ca_dividendo
where  di_operacion  = @i_operacionca
and    di_estado     = @w_est_vigente
and    di_fecha_ini  <= @i_fecha_proceso   ---EPB:ene-02-2002

select @w_count = @@rowcount

if (@w_count > 0) and (@w_di_estado = @w_est_vigente) begin -- CUOTA VIGENTE ENCONTRADA
   
   -- DIAS DE CALCULO, FECHA DE INICIO Y ULTIMO PROCESO, DIAS ACUMULADOS
   -- FQ 2003-abr-1 ES INCLUYE UNA FECHA DE INICIO PARA EL CALCULO DE INTERES
   if @i_base_calculo = 'E' begin
      exec @w_error   = sp_dias_cuota_360
      @i_fecha_ini    = @w_di_fecha_ini,
      @i_fecha_fin    = @i_fecultpro,
      @o_dias         = @w_diasdif out
      if @w_error != 0 return @w_error
     
   end
   ELSE  begin
      select @w_diasdif       = datediff(dd, @w_di_fecha_ini, @i_fecultpro)
   end
   
   -- MANEJO DE DECIMALES PARA LA MONEDA DE LA OPERACION
   if @i_parametros_llamada = 'N' begin
      exec @w_error   = sp_decimales
      @i_moneda       = @i_moneda,
      @o_decimales    = @i_num_dec out,
      @o_mon_nacional = @w_moneda_nac out,
      @o_dec_nacional = @i_num_dec_mn out
      
      if @w_error <> 0  return @w_error
   end
   
   select @w_param_tlu_mn = pa_char 
   from   cobis..cl_parametro
   where  pa_nemonico = 'TLU' --TASA LIMITE USURA   ..antes..IBC INTERES BANCARIO CORRIENTE
   and    pa_producto = 'CCA'

   select @w_fec_tlu     = max(vr_fecha_vig)
   from ca_valor_referencial
   where vr_tipo         = @w_param_tlu_mn +cast(@w_op_sector as varchar)
   and   vr_fecha_vig   <= @i_fecha_proceso
   
   select @w_sec_tlu     = max(vr_secuencial)
   from ca_valor_referencial
   where vr_tipo         = @w_param_tlu_mn +cast(@w_op_sector as varchar)
   and vr_fecha_vig      = @w_fec_tlu
   
   select @w_va_tlu = vr_valor
   from ca_valor_referencial
   where vr_tipo      = @w_param_tlu_mn +cast(@w_op_sector as varchar)
   and  vr_fecha_vig  = @w_fec_tlu
   and  vr_secuencial = @w_sec_tlu

   if @i_moneda = 2
      select @i_num_dec_mn = 2 -- PARA PRECISION DE MONEDA NACIONAL PARA UVR
   

   -- NUMERO DE DIAS DE CALCULO
   select @w_dias_calc = 1
   
   
   -- DETERMINAR EL SALDO DE CAPITAL
   if @i_tipo != 'D' -- DISTINTO DE FACTORING
   begin -- NORMAL
      select 
      @w_saldo_cap = sum(am_cuota + am_gracia - am_pagado)
      from   ca_dividendo, ca_amortizacion
      where  di_operacion  = @i_operacionca
      and    di_dividendo >= @w_di_dividendo -- MEJOR
      and    am_operacion  = @i_operacionca
      and    am_dividendo  = di_dividendo
      and    am_concepto   = @i_concepto_cap
      
      -- REQ 175: PEQUEÑA EMPRESA - TENER EN CUENTA QUE SI EXISTE GRACIA DE INTERES EXISTE GRACIA DE CAPITAL
      if @w_dist_gracia = 'C' and @w_di_dividendo <= @w_gracia_int
         select @w_saldo_cap = @w_saldo_cap - isnull(@w_capitalizado, 0)         
   end
   
   -- VERIFICAR PAGOS PARA AJUSTAR ULTIMA PROVISION
   select @w_am_cap_pagado = sum(am_pagado)
   from   ca_amortizacion
   where  am_operacion  = @i_operacionca
   and    am_dividendo  = @w_di_dividendo
   and    am_concepto   = @i_concepto_cap
   
   -- CARGA TABLA TEMPORAL DE TRABAJO
   delete #ca_rubro_int_tmp
   where  ro_operacion = @i_operacionca
   
   insert #ca_rubro_int_tmp
   select ro_operacion,         ro_concepto,    ro_porcentaje,
          ro_tipo_rubro,        ro_provisiona,  ro_fpago,
          ro_concepto_asociado, ro_valor,       ro_num_dec,
          ro_porcentaje_efa
   from   ca_rubro_op
   where  ro_operacion   = @i_operacionca
   and    ro_tipo_rubro != 'M'
   and    ro_provisiona  = 'S'
   and    ro_concepto    not like '%ESPERA%'
    
   -- PARA CADA UNO DE LOS RUBROS ....
   declare cursor_rubro cursor
   for select ro_concepto,   ro_porcentaje,  ro_tipo_rubro,
              ro_provisiona, ro_fpago,       ro_concepto_asociado,
              ro_valor,      ro_porcentaje_efa
       from   #ca_rubro_int_tmp
       where  ro_operacion = @i_operacionca
       for read only
   
   open    cursor_rubro
   
   fetch   cursor_rubro
   into    @w_ro_concepto,   @w_ro_porcentaje, @w_ro_tipo_rubro,
           @w_ro_provisiona, @w_ro_fpago,      @w_concepto_asociado,
           @w_mora_clausula, @w_ro_porcentaje_efa
   
   while   @@fetch_status = 0 --CURSOR RUBROS
   begin
      if (@@fetch_status = -1)
      begin
         return 708999
      end
      
      exec @w_error = sp_consulta_tasas
      @i_operacionca     = @i_operacionca,
      @i_dividendo       = @w_di_dividendo,
      @i_concepto        = @w_ro_concepto,
      @i_sector          = @w_op_sector,
      @i_fecha           = @i_fecha_proceso,
      @i_equivalente     = @w_tasa_equivalente,
      @i_tasa_efa_actual = @w_ro_porcentaje_efa,
      @o_tasa            = @w_tasa out
        
      if @w_error <> 0 begin
         goto NEXTRUBRO
      end
      
      select @w_valor_calc   = 0,
             @w_am_secuencia = 0
      
      select 
      @w_am_secuencia = isnull(max(am_secuencia),1)
      from   ca_amortizacion
      where  am_operacion    = @i_operacionca
      and    am_dividendo    = @w_di_dividendo
      and    am_concepto     = @w_ro_concepto
      
      select 
      @w_am_cuota     = am_cuota,
      @w_am_acumulado = am_acumulado,
      @w_am_pagado    = am_pagado,
      @w_am_estado    = am_estado
      from   ca_amortizacion
      where  am_operacion    = @i_operacionca
      and    am_dividendo    = @w_di_dividendo
      and    am_concepto     = @w_ro_concepto
      and    am_secuencia    = @w_am_secuencia
      
      if @@rowcount = 0
      begin
         print 'calcdint.sp dividendo  ' + cast(@w_di_dividendo as varchar) +' concepto: '+ cast(@w_ro_concepto as varchar) +'  secuencia: '+ cast(@w_am_secuencia as varchar)
         return 701120
      end
      
      if @w_am_estado = @w_est_cancelado
         goto NEXTRUBRO
      
      select @w_codvalor = co_codigo * 1000 + case when @w_estado_op = @w_est_etapa2 then @w_est_etapa2 else @w_am_estado end * 10 + 0
      from   ca_concepto
      where  co_concepto    = @w_ro_concepto
      
      
      if @w_ro_tipo_rubro = 'I' 
      begin
         if @w_am_cuota = @w_am_acumulado -- YA TERMINO DE CAUSAR
            goto NEXTRUBRO
         
         if @i_fecha_proceso = dateadd(dd, -1, @w_di_fecha_ven)
            select @w_valor_calc = @w_am_cuota - @w_am_acumulado
         else begin
            if @i_base_calculo  = 'E'  --COMERCIAL
            begin
               exec @w_error   = sp_base_calculo
               @i_fecha_proceso = @i_fecha_proceso,
               @o_dias_calc     = @w_dias_calc out
            end
            
            -- TIPO DE CAUSACION INDICA SI ES (L)INEAL o (E)XPONENCIAL (interes sobre interes)
            if @i_causacion = 'E' -- EXPONENCIAL
            begin  
               select @w_ro_porcentaje = @w_ro_porcentaje_efa
               
               -- CALCULO DE CAUSACION ACUMULADA
               -- FQ - ESTOS SELECTS SOLO SE REQUIEREN PARA CAUSACION EXPONENCIAL (LA MINORIA)
               select @w_causacion_acum = isnull(am_acumulado - am_pagado ,0)  ---EPB:MAY-10-2002
               from   ca_amortizacion
               where  am_operacion = @i_operacionca
               and    am_dividendo = @w_di_dividendo
               and    am_concepto  = @w_ro_concepto
               
               exec @w_error = sp_calc_intereses -- DE UN DIA EXPONENCIAL
               @tasa           = @w_ro_porcentaje,
               @monto          = @w_saldo_cap,
               @dias_anio      = 360,
               @num_dias       = @w_diasdif,
               @causacion      = @i_causacion,
               @causacion_acum = @w_causacion_acum,
               @intereses      = @w_valor_calc out
                  
               if @w_error <> 0 return @w_error

            end
            ELSE -- LINEAL
            begin
                  if @w_ro_porcentaje > @w_va_tlu
                     select @w_ro_porcentaje =@w_va_tlu
                  /***
                  exec @w_error = sp_calc_intereses
                       @tasa           = @w_ro_porcentaje,
                       @monto          = @w_saldo_cap,
                       @dias_anio      = 360,
                       @num_dias       = @w_dias_calc,
                       @causacion      = @i_causacion,
                       @causacion_acum = 0, -- SI NO VA A USAR ESTA VARIABLE ES MEJOR NO PASARLA, POR CLARIDAD
                       @intereses      = @w_valor_calc out
                   ***/
--///////////////////////////////////////////////////////////////////
-- LGU para que calcule intereses segun los dias reales del dividendo
-- cuando se mueve la fecha de vencimiento por los feriados.
                   exec sp_calculo_30_360
                   @i_fecha_ini    = @w_di_fecha_ini,
                   @i_fecha_ven    = @w_di_fecha_ven,
                   @i_dias_interes = @i_dias_interes,
                   @o_dias_int     = @w_dias_dividendo out
                    
				   -- CONSIDERAR LO DIAS DE LA CUOTA PODRIAN SUFRIR DESPLAZAMIENTO
                   select @w_dias_dividendo = @w_dias_dividendo-isnull(sum(datediff(dd,de_fecha_ini,de_fecha_fin)),0)
                   from ca_desplazamiento 
                   where de_operacion =  @i_operacionca
                   and   de_estado = 'A'
                   and de_fecha_ini >= @w_di_fecha_ini
                   and de_fecha_fin <= @w_di_fecha_ven
	
                   select @w_valor_calc=(@w_am_cuota /@w_dias_dividendo) * @w_dias_calc   
                  
--//////////////////////////////////////////////////////////////////
            end 
            
            if @w_am_cuota > @w_am_acumulado -- AJUSTE AL VALOR DE am_cuota
            begin
               if @w_am_acumulado + @w_valor_calc > @w_am_cuota
                  select @w_valor_calc = @w_am_cuota - @w_am_acumulado
            end
            
            if @i_fecha_proceso = dateadd(dd,-1,@w_di_fecha_ven)
            and @w_am_cuota < 0 -- NEGATIVO?
            and @w_am_cap_pagado = 0
            and @w_am_cuota      > @w_am_acumulado
               select @w_valor_calc = @w_am_cuota 
         end
      end --Tipo 'I'
      
      if @w_ro_tipo_rubro != 'I'
      BEGIN
         if @i_fecha_proceso = dateadd(dd, -1, @w_di_fecha_ven)
       -----  and @w_am_cap_pagado >= 0   -- LGU: XQ ES PRODUCTO DE ABON EXTRA
       -----  and @w_dias_calc     > 0    -- LGU: SIEMPRE > 0
         and @w_am_cuota      >= @w_am_acumulado
         begin
             select @w_valor_calc = @w_am_cuota - @w_am_acumulado
         end
		 else begin
            if @i_base_calculo = 'E'
            begin
               exec sp_calculo_30_360
               @i_fecha_ini    = @w_di_fecha_ini,
               @i_fecha_ven    = @w_di_fecha_ven,
               @i_dias_interes = @i_dias_interes,
               @o_dias_int     = @w_dias_dividendo out
				
               select @w_valor_calc=(@w_am_cuota /@w_dias_dividendo) * @w_dias_calc   
            end 
			ELSE
               select @w_valor_calc = (@w_am_cuota /datediff(dd, @w_di_fecha_ini, @w_di_fecha_ven)) * @w_dias_calc
         end 
		 if @w_am_acumulado + @w_valor_calc >= @w_am_cuota  select @w_valor_calc = @w_am_cuota - @w_am_acumulado
      end --Diferente tipo 'I'
      
     select @w_valor_calc = round(@w_valor_calc, @i_num_dec)
      
      if @w_ro_fpago = 'P'
      begin
         select @w_monto_prv = @w_am_pagado - @w_am_acumulado
         select @w_monto_prv = (abs(@w_monto_prv) + @w_monto_prv)/ 2
         select @w_monto_prv = @w_valor_calc - @w_monto_prv
         select @w_monto_prv = (abs(@w_monto_prv) + @w_monto_prv)/ 2
         select @w_valor_calc = @w_monto_prv
      end 
      
      if @w_ro_fpago = 'A' ---PARA INTERES ANTICIPADO
      begin
         if @w_am_pagado = @w_am_cuota 
            select @w_monto_prv = @w_valor_calc
         else
         begin
            select @w_monto_prv = @w_am_pagado - @w_am_acumulado
            select @w_monto_prv = (abs(@w_monto_prv) + @w_monto_prv)/ 2
            select @w_monto_prv = @w_valor_calc - @w_monto_prv
            select @w_monto_prv = (abs(@w_monto_prv) + abs(@w_monto_prv))/ 2
            select @w_valor_calc = @w_monto_prv
         end
      end 
      
      -- CONTABILIZAR PROVISIONES NORMALES
      ----Inicio bloque a Validar  EPB:MAY-06-2002
      
      select @w_concepto_original = @w_ro_concepto,   ---EPB:MAY-06-2002
             @w_monto_prv = isnull(@w_monto_prv, 0)
      
      if isnull(@w_monto_prv, 0) <> 0
      begin
         
         if @w_ro_fpago = 'A' and @w_ro_tipo_rubro = 'I' 
            select @w_ro_concepto = @i_parametro_int   ---EPB:MAY-06-2002
         
         if @i_moneda = @w_moneda_uvr and @w_ro_tipo_rubro = 'I'
         begin
            select @w_ro_valor = ro_valor
            from   ca_rubro_op
            where  ro_operacion = @i_operacionca
            and    ro_concepto = @w_ro_concepto
         end
         ELSE
         begin
            select @w_ro_valor = 0
         end
         
         -- COTIZACION MONEDA
         select @w_monto_mn = round(@w_monto_prv * @i_cotizacion - @w_ro_valor, @i_num_dec_mn),
                @w_cot_mn   = @i_cotizacion
         
         -- EL PROXIMO AJUSTE
         if @i_moneda = @w_moneda_uvr and @w_ro_tipo_rubro = 'I'
         begin
            select @w_ro_valor = @w_monto_mn - round(@w_monto_prv * @i_cotizacion - @w_ro_valor, @i_num_dec_mn)
            
            update ca_rubro_op
            set    ro_valor = @w_ro_valor
            where  ro_operacion = @i_operacionca
            and    ro_concepto  = @w_ro_concepto
         end
         
         select @w_ro_concepto = @w_concepto_original  --EPB:MAY-06-2002
      end   --@w_monto_prv <> 0
      
      ---- Fin Inicio bloque a Validar  EPB:MAY-06-2002
      
      -- ACTUALIZAR CA_AMORTIZACION
      if isnull(@w_valor_calc, 0) <> 0  begin
	     /* Insertar en tabla de transacciones de PRV */
         insert into ca_transaccion_prv with (rowlock) (
         tp_fecha_mov,        tp_operacion,        tp_fecha_ref,
         tp_secuencial_ref,   tp_estado,           tp_dividendo,
         tp_concepto,         tp_codvalor,         tp_monto,
         tp_secuencia,        tp_comprobante,      tp_ofi_oper)
         values (
         @s_date,             @i_operacionca,      @i_fecha_proceso,
         0,                   'ING',               @w_di_dividendo,
         @w_ro_concepto,      @w_codvalor,         @w_valor_calc,
         @w_am_secuencia,     0,                   @w_oficina_op)
         
         if @@error != 0 return 708165
	  
         update ca_amortizacion
         set    am_acumulado  = @w_valor_calc  +  am_acumulado
         where  am_operacion = @i_operacionca
         and    am_dividendo = @w_di_dividendo
         and    am_concepto  = @w_ro_concepto
         and    am_secuencia = @w_am_secuencia
         
         if @@error != 0  return 705050
      end
      
      NEXTRUBRO:
      fetch cursor_rubro
      into  @w_ro_concepto,   @w_ro_porcentaje,   @w_ro_tipo_rubro,
            @w_ro_provisiona, @w_ro_fpago,        @w_concepto_asociado,
            @w_mora_clausula, @w_ro_porcentaje_efa
   end -- CURSOR RUBROS
   
   close cursor_rubro
   deallocate cursor_rubro
   
   delete #ca_rubro_int_tmp
   where  ro_operacion = @i_operacionca
   
   update ca_operacion
   set    op_fecha_ult_causacion = @i_fecha_proceso
   where  op_operacion = @i_operacionca
end -- BLOQUE DE LA CUOTA VIGENTE

return 0

go
