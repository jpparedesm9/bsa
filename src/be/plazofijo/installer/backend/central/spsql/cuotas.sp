/*cuotas.sp*/
/************************************************************************/
/*      Archivo:                cuotas.sp                               */
/*      Stored procedure:       sp_cuotas                               */
/*      Base de datos:          cob_pfijo                               */
/*      Producto:               Plazo Fijo                              */
/*      Disenado por:           N. Silva                                */
/*      Fecha de documentacion: Dic/10/2002                             */
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
/*      Este programa genera en una tabla todas las cuotas correspon-   */
/*      dientes a una operacion de renta periodica dada. Para las poli- */
/*      zas al vencimiento se registran el interes total a ganar, impues*/
/*      to y capital.                                                   */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA      AUTOR              RAZON                             */
/*      10-Dic-02  B. Cristella       Obtencion de Nro.Cuota            */
/*                                    Fecha de Corte y Tasa por Operac. */
/*      14-Ago_04  P. Morales         Mapeo cuotas por bloques          */ 
/*       6-Sep_08  S. Mora            Ajuste de decimales en cuota final*/
/*      11-Ene_17  J. Salazar         DPF-H94952  MANEJO RETENCIONES MX */
/************************************************************************/

use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'sp_cuotas')
   drop proc sp_cuotas
go

create proc sp_cuotas 
     @s_ssn                   int             = NULL,
     @s_sesn                  int             = NULL,     -- GAL 01/SEP/2009 - CSQL
     @s_user                  login           = NULL,
     @s_term                  varchar(30)     = NULL,
     @s_date                  datetime        = NULL,
     @s_srv                   varchar(30)     = NULL,
     @s_lsrv                  varchar(30)     = NULL,
     @s_ofi                   smallint        = NULL,
     @s_rol                   smallint        = NULL,
     @t_debug                 char(1)         = 'N',
     @t_file                  varchar(10)     = NULL,
     @t_from                  varchar(32)     = NULL,
     @t_trn                   smallint        = NULL,
     @i_en_linea              char(1)         = 'S',
     @i_tipo                  char(1)         = NULL,
     @i_op_ente               int             = NULL,
     @i_op_operacion          int             = NULL,
     @i_op_fecha_valor        datetime        = NULL,
     @i_op_oficina            smallint        = NULL,
     @i_op_fecha_ven          datetime        = NULL,
     @i_op_monto              money           = NULL,
     @i_op_tasa               float           = NULL,
     @i_op_tcapitalizacion    char(1)         = NULL,
     @i_op_fpago              catalogo        = NULL,
     @i_op_ppago              catalogo        = NULL,
     @i_op_base_calculo       smallint        = NULL,
     @i_op_retienimp          char(1)         = NULL,
     @i_op_moneda             tinyint         = NULL,
     @i_op_num_dias           smallint        = NULL,
     @i_cuota                 tinyint         = NULL,
     @i_int_estimado          money           = NULL,
     @i_tot_int_estimado      money           = NULL,
     @i_tot_int_pagados       money           = NULL,
     @i_op_fecha_creacion     datetime        = NULL,
     @i_op_dias_reales        char(1)         = NULL,
     @i_elimina_cuota         char(1)         = 'S',
     @i_contador              int             = NULL,
     @i_camb_fpago            char(1)         = NULL,
     @i_int_ganado            money           = NULL,
     @i_op_fecha_pg_int       datetime        = NULL,
     @i_modifica              char(1)         = 'N',
     @i_op_anio_comercial     char(1)         = NULL,     -- GAL 01/SEP/2009 - CSQL
     @i_param1                varchar(255)    = NULL,     -- Parametro 1
     @i_param2                varchar(255)    = NULL,     -- Parametro 2 
     @i_param3                varchar(255)    = NULL,     -- Parametro 3 
     @i_param4                varchar(255)    = NULL,     -- Parametro 4 
     @i_param5                varchar(255)    = NULL,     -- Parametro 5 
     @i_param6                varchar(255)    = NULL,     -- Parametro 6 
     @i_param7                varchar(255)    = NULL,     -- Parametro 7 
     @i_param8                varchar(255)    = NULL,     -- Parametro 8 
     @i_param9                varchar(255)    = NULL,     -- Parametro 9 
     @i_param10               varchar(255)    = NULL,     -- Parametro 10
     @i_param11               varchar(255)    = NULL,     -- Parametro 11
     @i_param12               varchar(255)    = NULL      -- Parametro 12
with encryption
as
declare   @w_sp_name              descripcion,
          @w_return               int,
          @w_usadeci              char(1),
          @w_numdeci              tinyint,
          @w_factor               smallint,
          @w_nro_cuotas           int,
          @w_cuotas_completas     smallint,
          @w_retencion            money,   
          @w_fecha_creacion       datetime,
          @w_fecha_cuota          datetime,
          @w_fecha_pg_int         datetime,  
          @w_fecha_pg_int_t       datetime,
          @w_int_estimado         decimal(30,16),
          @w_total_int_estimado   money,
          @w_total_int_estimado_c money,
          @w_contador             int,
          @w_pp_factor_en_meses   int,
          @w_pp_factor_en_dias    smallint,
          @w_num_dias             int,
          @w_num_factor           int,
          @w_fecha_pg_int_sig     datetime,
          @w_dias_dif             int,
          @w_op_fecha_valor       datetime,
          @w_td_dias_reales       char(1),
          @w_cont                 int,
          @w_cadena               varchar(255),   -- registro de proceso 
          @w_parametro            tinyint,        -- contador numero de campos 
          @w_posicion             smallint,       -- posicion del separador 
          @w_token                varchar(255),   -- campo de proceso
          @w_cod_corresp          catalogo,
          @w_op_estado            char(1),
          @w_op_tcapitalizacion   char(1),
          @w_op_dia_pago          tinyint,        -- GAR GB-DP00120
          @w_plazo_calc           int,
          @w_plazo_total          int,
          @w_vencimiento          char(1),
          @w_int_estimado1        money,
          -- NYM DOF00015 ICA
          @w_retienimp            char(1),
          @w_ret_ica              char(1),
          @w_tasa_retencion       float,   
          @w_tasa_ica             float,   
          @w_base_ret             money,   
          @w_base_ica             money,
          @w_impuesto             money,
          @w_imp_ica              money,
          @w_decimal_imp          tinyint,
          -- NYM DPF00015 ICA
          @w_min_numdias_cuota    smallint            -- GAL 07/SEP/2009 - RVVUNICA

select @w_sp_name = 'sp_cuotas'
select @w_fecha_creacion = @s_date
select @w_vencimiento = 'N'
select @w_total_int_estimado_c = 0

select @w_min_numdias_cuota = pa_smallint          -- GAL 04/SEP/2009 - RVVUNICA
from cobis..cl_parametro
where pa_nemonico = 'MINDCU'
and   pa_producto = 'PFI'

/*---------------------------------*/
/* Verificar codigo de transaccion */
/*---------------------------------*/
if @t_trn not in (14146,14166)
begin
   exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name, 
        @i_num   = 141040
   return 141040
end

----------------------------------
-- Proceso de ejecucion de cuotas
----------------------------------
if (@t_trn = 14146)
begin
   select @w_plazo_calc  = 0
   -------------------------------------------------------------------
   -- Primero se deben borrar los registros existentes
   -------------------------------------------------------------------
   set rowcount 1
   if exists (select cu_operacion from pf_cuotas where cu_operacion = @i_op_operacion) 
          and @i_elimina_cuota = 'S'
   begin
     set rowcount 0
     delete pf_cuotas
     where cu_operacion = @i_op_operacion    
   end

   ---------------------------------------
   -- Validacion de parametros de entrada
   ---------------------------------------
   if @i_op_ente = 0 and @i_tipo <> 'D'
   begin
      print 'Nro de cliente no puede ser cero.' 
      return 10
   end

   if @i_op_operacion is null
   begin
      print 'Nro de operacion no puede ser nulo.' 
      return 20
   end

   if @i_op_monto = 0 and @i_tipo <> 'D'
   begin
      print 'Monto debe ser mayor que cero.' 
      return 30
   end

   if @i_op_tasa = 0 and @i_tipo <> 'D'
   begin
      print 'Tasa debe ser mayor que cero.' 
      return 40
   end

   if @i_op_num_dias = 0 and @i_tipo <> 'D'
   begin
      print 'Plazo debe ser mayor que cero.' 
      return 50
   end

   if datediff(dd, @i_op_fecha_valor, @i_op_fecha_ven) <= 0
   begin      
      print 'Fecha de activacion debe ser anterior a la fecha de vencimiento.' 
      return 60
   end

   if @i_op_retienimp is null and @i_tipo <> 'D'
   begin
      print 'Indicador de retencion no puede ser nulo.' 
      return 70
   end

   if @i_op_moneda is null
   begin
      print 'Codigo de moneda no puede ser nulo.' 
      return 80
   end

   if not exists ( select * from cobis..cl_moneda
                    where mo_moneda = @i_op_moneda )
   begin
      print 'Codigo de moneda no existe.' 
      return 90
   end

   if @i_op_oficina is null and @i_tipo <> 'D'
   begin
      print 'Codigo de oficina no puede ser nulo.' 
      return 100
   end

   if not exists ( select * from cobis..cl_oficina
                    where of_oficina = @i_op_oficina )
   begin
      print 'Codigo de oficina no existe.' 
      return 200
   end

     ------------------------------------
     -- Encuentra parametro de decimales
     ------------------------------------
     select @w_usadeci = mo_decimales
     from cobis..cl_moneda
     where mo_moneda = @i_op_moneda

     if @w_usadeci = 'S'
     begin
          select @w_numdeci = isnull (pa_tinyint,0)
          from cobis..cl_parametro
          where pa_nemonico = 'DCI'
               and pa_producto = 'PFI'
     end
     else
          select @w_numdeci = 0

     ------------------------------------------- 
     -- Obtener el Factor de Conversion en Meses
     -------------------------------------------
     select    @w_pp_factor_en_meses = pp_factor_en_meses,
               @w_pp_factor_en_dias  = pp_factor_dias 
     from cob_pfijo..pf_ppago
     where pp_codigo = @i_op_ppago and pp_estado = 'A'   

     ----------------------------------------------------
     -- Asignar la fecha valor para el calculo de fechas
     ----------------------------------------------------
     select    @w_op_tcapitalizacion    = op_tcapitalizacion,
               @w_op_dia_pago           = op_dia_pago,    -- GAR GB-DP00120
               @w_td_dias_reales        = op_dias_reales, -- GAR GB-DP00120
               @w_op_fecha_valor        = op_fecha_valor,
               @w_total_int_estimado_c  = op_total_int_estimado
     from pf_operacion
     where op_operacion = @i_op_operacion

     if @i_op_dias_reales is not null
          select @w_td_dias_reales = @i_op_dias_reales

     if @i_op_fpago = 'PRA' 
          select @w_fecha_pg_int = '01/01/1900'
     else
     begin
          select @w_fecha_pg_int     = @i_op_fecha_valor
          select @w_fecha_pg_int_sig = @w_fecha_pg_int
     end

     ----------------------------------------------------------------
     -- obtener el numero de dias en los periodos de pago homogeneos
     ----------------------------------------------------------------
     if @i_op_fpago in ('PER','PRA')
     begin
          select @w_factor = pp_factor_en_meses * 30
          from pf_ppago
          where pp_codigo = @i_op_ppago
          
          if @@rowcount = 0
          begin
               if @i_en_linea  = 'S'
               begin   
                    /**  ERROR : NO existe periodicidad de pago  **/
                    exec cobis..sp_cerror
                         @t_debug = @t_debug,
                         @t_file  = @t_file,
                         @t_from  = @w_sp_name,
                         @i_num   = 141071
                    return 141071
               end
               else
                    return    141071
          end

          if @w_factor = 0
          begin
               print 'Factor debe ser mayor que cero.' 
               return 300
          end

          -------------------------------
          -- obtener nro total de cuotas
          -------------------------------
          select @w_nro_cuotas = @i_op_num_dias / @w_factor  
          
          ------------------------------------------------------
          -- Procesar todas las fechas del P.Fijo hasta su Vto.
          -- para obtener: Nro.Cuota
          --               Fecha de Pago del Interes
          --               Valor de la Cuota
          --               Valor del Capital
          ------------------------------------------------------      
          select @w_contador = 1

          --CVA Nov-04-05 Para cuando cambia a mayor el plazo desde mantenimiento
          if @i_contador is not null
               select @w_contador = @i_contador
      
          ---------------------------------------------------------------------------------
          --Calcula el total de interes estimado PARA EL CASO DE OPERACIONES AL VENCIMIENTO
          ---------------------------------------------------------------------------------
          if @w_td_dias_reales = 'S' 
          begin
               select @w_total_int_estimado = round((@i_op_monto*@i_op_tasa*datediff(dd,@i_op_fecha_valor, @i_op_fecha_ven)/(@i_op_base_calculo*100)), @w_numdeci) 
          end
          else
          begin
          
               /* INICIO - GAL 07/SEP/2009 - RVVUNICA
               exec sp_fecha_comercial
                    @i_fecha_inicial   = @i_op_fecha_valor, 
                    @i_fecha_ultima    = @i_op_fecha_ven, 
                    @o_dias            = @w_plazo_total out 
               */
               exec sp_funcion_1                      
                  @i_operacion = 'DIFE30',
                  @i_fechai   = @i_op_fecha_valor,
                  @i_fechaf   = @i_op_fecha_ven,
                  @i_dia_pago = @w_op_dia_pago,
                  @o_dias     = @w_plazo_total  out
               -- FIN - GAL 07/SEP/2009 - RVVUNICA
          
               select @w_total_int_estimado = round((@i_op_monto*@i_op_tasa*@w_plazo_total/(@i_op_base_calculo*100)), @w_numdeci) 
          end

          if  @i_camb_fpago = 'S' 
          begin
               select @w_total_int_estimado = @i_tot_int_estimado
          end

          if @i_camb_fpago = 'S' and @i_tot_int_pagados > 0
          begin
               select @w_total_int_estimado = @i_tot_int_estimado - @i_tot_int_pagados
          end
           
           
          if @i_op_tcapitalizacion = 'S'                                    --*-*
          begin
               select @w_total_int_estimado = @i_tot_int_estimado           --*-*
          end
          
          --CVA Feb-07-06 Dias transcurridos de cuotas pagadas utilizado para mantenimientos
          select @w_plazo_calc = sum(cu_num_dias)
          from pf_cuotas
          where cu_operacion = @i_op_operacion
          and   cu_estado    = 'P'    
                
          if @@rowcount = 0
               select @w_plazo_calc = 0

          --------------------------
          -- Grabar fechas y cuotas
          --------------------------
          while @i_op_fecha_ven > @w_fecha_pg_int_sig      --- @w_contador <= @w_nro_cuotas
          begin 
               -----------------------------------------------------------------------------
               -- Obtener numero de dias para obtener la siguiente fecha de pago de interes
               -----------------------------------------------------------------------------
               select @w_num_dias   = (@w_pp_factor_en_meses*30)
               select @w_num_factor = @w_pp_factor_en_dias --(@w_pp_factor_en_meses*30)
               
               if @w_fecha_pg_int <> '01/01/1900'
               begin             
                    select  @w_fecha_pg_int_sig  = dateadd(dd,@w_pp_factor_en_dias, @w_fecha_pg_int_sig) 
                    
                    ----------------------------------------------------------------------
                    -- Para incluir la proxima fecha de pago definida por el usuario GAR GB-DP00120
                    ----------------------------------------------------------------------
                    exec sp_dia_pago 
                         @i_fecha               = @w_fecha_pg_int_sig,
                         @i_dia_pago            = @w_op_dia_pago,
                         @o_fecha_proximo_pago  = @w_fecha_pg_int_sig out

                    --CVA ene-10-06 para que tome la fecha de proximo pago definida por fecha
                    --              valor superior a periodo de pago en mantenimiento
                    if @i_op_fecha_pg_int is not null
                    begin
                         select @w_fecha_pg_int_sig = @i_op_fecha_pg_int 
                         select @i_op_fecha_pg_int  = null   
                    end
               end
               else
                    select @w_fecha_pg_int_sig = @i_op_fecha_valor

               --*-* AQUI FALTA CONSIDERAR CUOTAS PARA AÑO FINANCIERO (360 DIAS) OOOJOOO!!

               select @w_dias_dif = datediff(dd,@w_fecha_pg_int_sig,@i_op_fecha_ven)
               select @w_num_dias = datediff(dd,@w_fecha_pg_int,@w_fecha_pg_int_sig)

               if isnull(@w_td_dias_reales,'N') = 'N' and @i_op_fpago = 'PER'
               begin 
                    ---------------------------------------------------------------------
                    -- Para incluir la proxima fecha de pago definida por el usuario GAR GB-DP00120
                    ----------------------------------------------------------------------
                    exec sp_dia_pago 
                         @i_fecha               = @w_fecha_pg_int_sig,
                         @i_dia_pago            = @w_op_dia_pago,
                         @o_fecha_proximo_pago  = @w_fecha_pg_int_sig out

                    ------------------------------       
                    -- Calculo de plazo comercial
                    ------------------------------
                    /* INICIO - GAL 07/SEP/2009 - RVVUNICA
                    exec sp_fecha_comercial
                         @i_fecha_inicial   = @w_fecha_pg_int, 
                         @i_fecha_ultima    = @w_fecha_pg_int_sig, 
                         @o_dias            = @w_num_dias out 
                    */
                    exec sp_funcion_1                      
                       @i_operacion = 'DIFE30',
                       @i_fechai   = @w_fecha_pg_int,
                       @i_fechaf   = @w_fecha_pg_int_sig,
                       @i_dia_pago = @w_op_dia_pago,
                       @o_dias     = @w_num_dias  out
                    -- FIN - GAL 07/SEP/2009 - RVVUNICA
                  
                    /*
                    -------------------------------------------------
                    -- Evaluacion para cuotas finales al vencimiento
                    -------------------------------------------------      
                    select @w_plazo_total = datediff(dd,@w_op_fecha_valor,@i_op_fecha_ven)
               
                    select @w_plazo_calc  = @w_plazo_calc + @w_num_dias
                    select @w_dias_dif    = @w_plazo_total - @w_plazo_calc
               
                    -----------------------------------------
                    -- Ajuste de cuotas en dias comerciales
                    -----------------------------------------
                    if (@w_dias_dif > 0 and @w_dias_dif < @w_num_factor)
                    begin
                         select @w_vencimiento = 'S'
                         select @w_fecha_pg_int_sig = @i_op_fecha_ven
                         
                         if @w_dias_dif < @w_min_numdias_cuota
                              select @w_num_dias = @w_dias_dif + 30
                         else
                              select @w_num_dias = @w_dias_dif
                    end 

                    -------------------------------------------------------------------------
                    -- Control para cuando los d­as segun la fecha fijada son menores que 30
                    -------------------------------------------------------------------------
                    if @w_num_dias < 30 and @w_vencimiento = 'N'
                    begin
                         select @w_plazo_calc  = @w_plazo_calc - @w_num_dias
                         select @w_num_dias = 30
                         select @w_plazo_calc  = @w_plazo_calc + @w_num_dias
                    end
                    */
               end

               -- INICIO - GAL 29/SEP/2009 - RVVUNICA               
               if @i_op_fpago = 'PER'
               begin
                  if isnull(@w_td_dias_reales,'N') = 'S'
                  begin
                     if @w_dias_dif > 0 and @w_dias_dif < @w_min_numdias_cuota
                     begin
                        select @w_fecha_pg_int_sig = @i_op_fecha_ven
                        select @w_num_dias     = datediff(dd,@w_fecha_pg_int,@i_op_fecha_ven)      
                     end 
                  end
                  else
                  begin
                     if @w_dias_dif > 0 and @w_dias_dif < @w_min_numdias_cuota
                     begin
                        select @w_fecha_pg_int_sig = @i_op_fecha_ven
                        
                        exec sp_funcion_1                      
                           @i_operacion = 'DIFE30',
                           @i_fechai    = @w_fecha_pg_int,
                           @i_fechaf    = @w_fecha_pg_int_sig,
                           @i_dia_pago  = @w_op_dia_pago,
                           @o_dias      = @w_num_dias  out
                     end 
                  end
               end

               if @w_dias_dif < 0
               begin
                  select @w_fecha_pg_int_sig = @i_op_fecha_ven
                  
                  if isnull(@w_td_dias_reales,'N') = 'S'
                  begin
                     select @w_num_dias = datediff(dd,@w_fecha_pg_int,@i_op_fecha_ven)
                  end
                  else
                  begin
                     exec sp_funcion_1
                        @i_operacion = 'DIFE30',
                        @i_fechai    = @w_fecha_pg_int,
                        @i_fechaf    = @i_op_fecha_ven,
                        @i_dia_pago  = @w_op_dia_pago,
                        @o_dias      = @w_num_dias  out
                  end                  
               end      
               -- FIN - GAL 29/SEP/2009 - RVVUNICA
               
               ---------------------------------  
               -- Calculo de intereses original
               ---------------------------------       
               exec sp_calc_intereses
                    @tasa        = @i_op_tasa,
                    @monto       = @i_op_monto,
                    @dias_anio   = @i_op_base_calculo,
                    @num_dias    = @w_num_dias,
                    @intereses   = @w_int_estimado out

               select @w_int_estimado = round(@w_int_estimado,@w_numdeci)

               --Si cambia de frecuencia por mantenimiento el DPF, de VEN a PER, entonces
               --la primera cuota es igual a lo estimado + ganado       
               if  @i_camb_fpago = 'S' or  @i_int_ganado > 0
                    select @w_int_estimado = @i_int_estimado

               --Solo para la primera cuota que considere estos valores
               select @i_camb_fpago = 'N', @i_int_ganado = 0
     
               -- INICIO - GAL 07/SEP/2009 - RVVUNICA
               exec @w_return = cob_pfijo..sp_aplica_impuestos
                  @s_ofi              = @s_ofi,
                  @t_debug            = @t_debug,
                  @i_ente             = @i_op_ente,
                  @i_plazo            = @i_op_num_dias,
                  @i_capital          = @i_op_monto,
                  @i_interes          = @w_int_estimado,
                  @i_base_calculo     = @i_op_base_calculo,
                  @o_retienimp        = @w_retienimp      out,
                  @o_tasa_retencion   = @w_tasa_retencion out,
                  @o_valor_retencion  = @w_impuesto       out   

               if @w_return <> 0
               begin
                  if @i_en_linea  = 'S'
                  begin 
                     exec cobis..sp_cerror
                        @t_debug = @t_debug,
                        @t_file  = @t_file,
                        @t_from  = @w_sp_name,
                        @i_num   = @w_return
                  end
                     
                  return @w_return
               end

               select @w_retencion = isnull(@w_impuesto, 0)
               -- FIN - GAL 07/SEP/2009 - RVVUNICA
               

--print 'cuotas.sp cuota %1!, fecha_pago %2!, @w_int_estimado %3!, @w_fecha_pg_int %4!', @w_contador,@w_fecha_pg_int_sig, @w_int_estimado, @w_fecha_pg_int

               if @w_int_estimado < 0 
                        select @w_int_estimado = 0

               ------------------------------------------------------
               -- Insertar en la pf_cuota
               ------------------------------------------------------
               --I. CVA Oct-27-06 Para cuando el plazo no es valido para el periodo de pago
               if @w_int_estimado is null
               begin
                    if @i_en_linea  = 'S'
                    begin
                                rollback tran          
                                exec cobis..sp_cerror 
                              @t_debug = @t_debug,
                              @t_file  = @t_file,
                              @t_from  = @w_sp_name,
                              @i_num   = 143063        
                    end  
                    else
                            return 143063                 
               end                  
               
               insert into pf_cuotas
                    (cu_ente           , cu_operacion   , cu_cuota          , cu_fecha_ult_pago,
                    cu_fecha_pago      , cu_valor_cuota , cu_retencion      , cu_capital,
                    cu_fecha_crea      , cu_moneda      , cu_oficina        , cu_num_dias,
                    cu_tasa            , cu_ppago       , cu_base_calculo   , cu_estado,
                    cu_retenido        , cu_valor_neto)
               values (@i_op_ente      , @i_op_operacion, @w_contador       , @w_fecha_pg_int,
                    @w_fecha_pg_int_sig, @w_int_estimado, @w_retencion      , @i_op_monto,
                    @w_fecha_creacion  , @i_op_moneda   , @i_op_oficina     , @w_num_dias,
                    @i_op_tasa         , @i_op_ppago    , @i_op_base_calculo, 'V',
                    'N'                , @w_int_estimado - isnull(@w_retencion,0))                    -- GAL 07/SEP/2009 - RVVUNICA
               if @@error <> 0
               begin
                    if @i_en_linea  = 'S'
                    begin
                         rollback tran
     
                         exec cobis..sp_cerror 
                         @t_debug = @t_debug,
                         @t_file  = @t_file,
                         @t_from  = @w_sp_name,
                         @i_num   = 143063         --CVA May-15-06        
                    end  
                    else
                            return 143063             --CVA May-15-06    
               end
              
               --------------- 
               -- Nro de Cuota
               ---------------
               select @w_fecha_pg_int = @w_fecha_pg_int_sig
               select @w_contador = @w_contador + 1
         
               ------------------------------------------------
               -- Nuevo valor para capitalizacion de intereses
               ------------------------------------------------
               if @w_op_tcapitalizacion = 'S' 
               begin
                    select @i_op_monto = @i_op_monto + @w_int_estimado - @w_retencion           -- GAL 07/SEP/2009 - RVVUNICA
               end
--     print '@i_op_fecha_ven %1!, @w_fecha_pg_int_sig %2!', @i_op_fecha_ven, @w_fecha_pg_int_sig
          end           

          ---------------------------------------------------------------------
          -- Control final para ajustar la cuota al total de interes estimado
          ---------------------------------------------------------------------
          select @w_int_estimado1 = isnull(round(@w_total_int_estimado, @w_numdeci), 0)  - isnull((select sum(cu_valor_cuota)                 -- GAL 01/SEP/2009 - RVVUNICA - ANTES SIN isnull
                                                                                                   from pf_cuotas    
                                                                                                   where cu_ente      = @i_op_ente
                                                                                                   and   cu_operacion = @i_op_operacion), 0) 

          if @w_int_estimado1 <> 0
          begin
               update cob_pfijo..pf_cuotas
               set cu_valor_cuota = cu_valor_cuota + @w_int_estimado1
               where cu_operacion = @i_op_operacion
               and   cu_ente      = @i_op_ente
               and   cu_cuota     = (select max(cu_cuota)
                                     from cob_pfijo..pf_cuotas
                                     where cu_operacion = @i_op_operacion
                                     and   cu_ente      = @i_op_ente     )
          end
     end  /* PER */        
end  /* @t_trn = 14146 */


if @i_tipo = 'D' and (@t_trn = 14166)
begin
     -------------------------------------
     -- Eliminaci+n de la tabla de cuotas
     -------------------------------------
     delete cob_pfijo..pf_cuotas 
     where cu_operacion = @i_op_operacion

     if @@error <> 0
     begin
          exec cobis..sp_cerror 
               @t_debug = @t_debug,
               @t_file = @t_file,
               @t_from = @w_sp_name,
               @i_num = 143046           
          return 143046
     end  
end

----------------------------------
-- Inserta en la tabla pf_cuotas
---------------------------------
if (@t_trn = 14166) and @i_tipo <> 'D' and @i_op_fpago = 'PER' 
begin
     if @i_op_ente = 0
     begin
          print 'Nro de cliente no puede ser cero.' 
          return 11
     end

     if @i_op_operacion is null
     begin
          print 'Nro de operacion no puede ser nulo.' 
          return 12
     end

     if @i_op_monto = 0
     begin
          print 'Monto debe ser mayor que cero.' 
          return 13
     end

     if @i_op_tasa = 0
     begin
          print 'Tasa debe ser mayor que cero.' 
          return 14
     end

     if @i_op_num_dias = 0
     begin
          print 'Plazo debe ser mayor que cero.' 
          return 15
     end

     if datediff(dd, @i_op_fecha_valor, @i_op_fecha_ven) <= 0
     begin
          print 'Fecha de activacion debe ser anterior a la fecha de vencimiento.' 
          return 16
     end

     if @i_op_moneda is null
     begin
          print 'Codigo de moneda no puede ser nulo.' 
          return 17
     end

     if not exists ( select * from cobis..cl_moneda where mo_moneda = @i_op_moneda )
     begin
          print 'Codigo de moneda no existe.' 
          return 18
     end

     if @i_op_oficina is null
     begin
          print 'Codigo de oficina no puede ser nulo.' 
          return 19
     end

     select @w_cont = 1
     
     ----------------------------------
     -- Lazo para proceso de registros
     ----------------------------------
     while @w_cont <= 12
     begin
        if @w_cont = 1
            select @w_cadena = @i_param1
        else
        if @w_cont = 2
            select @w_cadena = @i_param2
        else
        if @w_cont = 3
            select @w_cadena = @i_param3   
        else
        if @w_cont = 4
            select @w_cadena = @i_param4
        else
        if @w_cont = 5
            select @w_cadena = @i_param5
        else
        if @w_cont = 6
            select @w_cadena = @i_param6
        else
        if @w_cont = 7
            select @w_cadena = @i_param7
        else
        if @w_cont = 8
            select @w_cadena = @i_param8
        else
        if @w_cont = 9
            select @w_cadena = @i_param9
        else
        if @w_cont = 10
            select @w_cadena = @i_param10
        else
        if @w_cont = 11
            select @w_cadena = @i_param11
        else
        if @w_cont = 12
            select @w_cadena = @i_param12

        ------------------------------------
        -- si la cadena es no nula procesar
        ------------------------------------
        if @w_cadena is not null
        begin
            select @w_parametro = 0
            while @w_parametro < 9     /* 9 columnas del grid */
            begin
                select @w_parametro = @w_parametro +  1
                select @w_posicion = charindex('@', @w_cadena)
                select @w_token = substring(@w_cadena, 1, @w_posicion-1)
               
                if @w_parametro = 1
                    select @i_cuota = convert(tinyint,@w_token)
                if @w_parametro = 2
                    select @i_op_fecha_valor = @w_token
                if @w_parametro = 3
                    select @i_op_fecha_ven = @w_token
                if @w_parametro = 4
                    select @i_op_monto = convert(float, @w_token)
                if @w_parametro = 5
                    select @i_int_estimado = convert(float, @w_token)
                if @w_parametro = 6
                    select @i_op_ppago = @w_token
                if @w_parametro = 7
                    select @i_op_num_dias = convert(smallint, @w_token)
                if @w_parametro = 8
                    select @w_op_estado =  @w_token
                
                select @w_cadena = substring(@w_cadena, @w_posicion + 1, datalength(rtrim(@w_cadena)))
            end
     
            ----------------------------------------------------
            -- Insertar en la tabla el registro 
            ----------------------------------------------------
            begin tran
               insert into pf_cuotas
                    (cu_ente             , cu_operacion      , cu_cuota     , cu_fecha_ult_pago,
                    cu_fecha_pago       , cu_valor_cuota    , cu_retencion , cu_capital,
                    cu_fecha_crea       , cu_moneda         , cu_oficina   , cu_num_dias,
                    cu_ppago            , cu_base_calculo   , cu_tasa      , cu_estado,
                    cu_retenido         , cu_valor_neto) 
               values (@i_op_ente          , @i_op_operacion   , @i_cuota     , @i_op_fecha_valor,
                    @i_op_fecha_ven     , @i_int_estimado   , 0            , @i_op_monto,
                    @i_op_fecha_creacion, @i_op_moneda      , @i_op_oficina, @i_op_num_dias,
                    @i_op_ppago         , @i_op_base_calculo, @i_op_tasa   , @w_op_estado,
                    'N'                 , (@i_int_estimado - isnull(@w_retencion,0))) 
               if @@error <> 0
               begin
                    exec cobis..sp_cerror 
                         @t_debug = @t_debug,
                         @t_file = @t_file,
                         @t_from = @w_sp_name,
                         @i_num = 143046
                    return 143046
               end
            commit tran
        end    /* fin del if -cadena no nula- */
        select @w_cont = @w_cont + 1
    end  /* fin del while -numero de registros a procesar- */
end  /* @t_trn = 14166 */

return 0
go

