/************************************************************************/
/*      Archivo:                c_canback.sp                            */
/*      Stored procedure:       sp_calculo_canback                      */
/*      Base de datos:          cob_pfijo                               */
/*      Producto:               Plazo Fijo                              */
/*      Disenado por:           N. Silva                                */
/*      Fecha de documentacion: 25-Jul-2005                             */
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
/*      Realiza el recalculo de intereses en el caso de cancelaciones,  */
/*      con fecha valor.                                                */
/************************************************************************/
/*                                                                      */
/*                              MODIFICACIONES                          */
/*      FECHA        AUTOR             RAZON                            */  
/*      25-Jul-2005  N. Silva          Emision Inicial                  */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'sp_calculo_canback')
   drop proc sp_calculo_canback
go

create proc sp_calculo_canback (
@s_ssn                  int             = NULL,
@s_user                 login           = NULL,
@s_sesn                 int             = NULL,
@s_term                 varchar(30)     = NULL,
@s_date                 datetime        = NULL,
@s_srv                  varchar(30)     = NULL,
@s_lsrv                 varchar(30)     = NULL,
@s_ofi                  smallint        = NULL,
@s_rol                  smallint        = NULL,
@t_debug                char(1)         = 'N',
@t_file                 varchar(10)     = NULL,
@t_from                 varchar(32)     = NULL,
@t_trn                  smallint        = NULL,
@i_num_banco            cuenta          = NULL,
@i_fecha_ven_back       datetime        = NULL,
@i_formato_fecha        int             = 0,
@i_backend              char(1)         = 'N',
/** Variables para cancelacion desde Cartera **/
@i_cliente              int             = NULL,
@i_retienimp            char(1)         = 'N')
with encryption
as
declare 
   @w_sp_name                      varchar(32),
   @w_return                       int,
   @w_tipo_plazo                   catalogo,
   @w_tipo_monto                   catalogo,
   @w_base_calculo                 smallint,
   @w_moneda                       tinyint,
   @w_num_dias                     smallint,
   @w_monto                        money,
   @w_impuesto                     money,
   @w_tasa                         float,
   @w_tasa1                        float,                  
   @w_int_estimado                 money,
   @w_total_int_estimado           money,
   @w_num_pagos                    smallint,
   @w_ppago                        char(3),
   @w_fpago                        char(3),
   @w_retienimp                    char(1),
   @w_tcapitalizacion              char(1),
   @w_dia_pago                     tinyint,
   @w_fecha_valor                  datetime,
   @w_fecha_real_pg                datetime,
   @w_fecha_ven                    datetime,
   @w_fecha_ven1                   datetime,
   @w_fecha_pg_int                 datetime,
   @w_numdeci                      tinyint,
   @w_usadeci                      char(1),
   @w_td_dias_reales               char(1),                  -- Fechas de Corte segun calendario
   @w_int_ganado                   money,
   @w_total_int_ganado             money,
/* Variables obtenidas de pf_operacion */
   @w_op_moneda                    int,
   @w_op_fecha_ult_pg_int          datetime,
   @w_op_toperacion                catalogo,
   @w_op_anio_comercial            char(1),
   @w_op_tipo_monto                catalogo,
   @w_op_monto                     money,
   @w_op_tipo_plazo                catalogo,
   @w_op_tasa_variable             char(1),
   @w_op_ppago                     catalogo,
   @w_op_retienimp                 char(1),
   @w_op_tasa                      float,
   @w_op_mnemonico_tasa            catalogo,
   @w_op_operacion                 int,
   @w_mm_fecha_aplicacion          datetime,
   @w_op_int_pagado                money,
   @w_op_total_int_pagado          money,
   @w_op_fecha_valor               datetime,

/* Variables para incremento pf_incre_op */
   @w_io_monto                     money,
   @w_io_int_ganado                money,
   @w_io_fecha_aplicacion          datetime,
   @w_ajuste                       money,
   @w_incremento                   char(1),
   @w_moneda_pg                    char(2),
   @w_periodo_tasa                 smallint,
   @w_modalidad_tasa               char(1),
   @w_descr_tasa                   descripcion,
   @w_mnemonico_tasa               catalogo,
   @w_fecha_ren                    datetime,
   @w_op_renovaciones              int ,
   @w_td_tipo_deposito		   int

select @w_sp_name            = 'sp_calculo_canback'

/*-----------------------------------*/
/*  Verificar codigo de transaccion  */
/*-----------------------------------*/
if @t_trn <> 14768
begin
   exec cobis..sp_cerror
        @t_debug     = @t_debug,
        @t_file      = @t_file,   
        @t_from      = @w_sp_name,
        @i_num       = 141004
   return 141004
end
select @w_incremento = 'N'
select @w_op_operacion        = op_operacion,
       @w_op_moneda           = op_moneda, 
       @w_op_fecha_ult_pg_int = op_fecha_ult_pg_int, 
       @w_op_toperacion       = op_toperacion,
       @w_op_anio_comercial   = op_anio_comercial,
       @w_op_tipo_monto       = op_tipo_monto,
       @w_op_monto            = op_monto,
       @w_op_tipo_plazo       = op_tipo_plazo,
       @w_op_tasa_variable    = op_tasa_variable,
       @w_op_ppago            = op_ppago,
       @w_op_retienimp        = op_retienimp,
       @w_op_tasa             = op_tasa,
       @w_op_int_pagado       = op_int_pagados,
       @w_op_total_int_pagado = op_total_int_pagados,
       @w_op_mnemonico_tasa   = op_mnemonico_tasa,
       @w_op_fecha_valor      = @w_op_fecha_valor,
       @w_base_calculo        = op_base_calculo,
       @w_tcapitalizacion     = op_tcapitalizacion,
       @w_int_ganado          = op_int_ganado,           --*-*
       @w_fpago               = op_fpago,
       @w_td_dias_reales      = isnull(op_dias_reales,'N'),
       @w_op_renovaciones     = op_renovaciones,
       @w_fecha_ren           = op_fecha_valor
  from pf_operacion
 where op_num_banco = @i_num_banco

if @@rowcount = 0
begin
   exec cobis..sp_cerror
        @t_debug     = @t_debug,
        @t_file      = @t_file,
        @t_from      = @w_sp_name,
        @i_num       = 141112
   return 1
end

-------------------------------
-- Inicializacion de Variables
-------------------------------
Select @w_moneda             = @w_op_moneda,
       @w_monto              = @w_op_monto,
       @w_tasa               = @w_op_tasa,
       @w_ppago              = @w_op_ppago,
       @w_retienimp          = @w_op_retienimp

-------------------------------------------------------------------------------------------------------
-- Calculo de Numero de dias entre la fecha de ultimo pago de intereses y la fecha real de cancelacion
-------------------------------------------------------------------------------------------------------
select @w_num_dias           = datediff(dd,@w_op_fecha_ult_pg_int,@s_date)

---------------------------------------------------------------------------------------------------------
-- Control para que el back_value solo se realice desde la fecha de ultimo pago de intereses en adelante
---------------------------------------------------------------------------------------------------------

if @w_op_fecha_ult_pg_int > @i_fecha_ven_back
begin
   exec cobis..sp_cerror
        @t_debug     = @t_debug,
        @t_file      = @t_file,   
        @t_from      = @w_sp_name,
        @i_num       = 141196
   return 141196
end

---------------------------------------------------------------------------------------------------------
-- Control para que el back_value solo se realice si no se han hecho transacciones que afecten al movimiento
---------------------------------------------------------------------------------------------------------
if exists(select 1 from pf_mov_monet
           where mm_operacion = @w_op_operacion
             and mm_tran in (14155,14989,14990)
          and mm_fecha_aplicacion > @i_fecha_ven_back)
begin
/*Error*/
    exec cobis..sp_cerror
        @t_debug     = @t_debug,
        @t_file      = @t_file,   
        @t_from      = @w_sp_name,
        @i_num       = 141196
   return 141196 
end
else
   select @w_mm_fecha_aplicacion = max(mm_fecha_aplicacion)
   from pf_mov_monet
   where mm_operacion = @w_op_operacion
      and mm_tran not in (14155,14905,14989,14990)
     and mm_fecha_aplicacion > @i_fecha_ven_back


--print 'calcanbak w_mm_fecha_aplicacion %1! ', @w_mm_fecha_aplicacion
   
------------------------------------
-- Encuentra parametro de decimales
------------------------------------
select @w_usadeci = mo_decimales
  from cobis..cl_moneda
 where mo_moneda = @w_op_moneda
if @w_usadeci = 'S'
begin
   select @w_numdeci = isnull (pa_tinyint,0)
     from cobis..cl_parametro
  
   where pa_nemonico = 'DCI'
      and pa_producto = 'PFI'
end
else
   select @w_numdeci = 0 

---------------------------------------------------------
-- Obtenere el nemonico de Tipo de Monto y Tipo de Plazo
---------------------------------------------------------
select @w_tipo_monto = @w_op_tipo_monto
select @w_tipo_plazo = @w_op_tipo_plazo

-----------------------------------
-- Verificar existencia de pf_tasa
-----------------------------------
if @w_op_tasa_variable = 'N'
begin
   if not exists ( select 1 from cob_pfijo..pf_tasa 
                    where  ta_tipo_deposito = @w_op_toperacion 
                      and  ta_moneda       = @w_op_moneda
                      and  ta_tipo_monto   = @w_tipo_monto
                      and  ta_tipo_plazo   = @w_tipo_plazo)
   begin
      exec cobis..sp_cerror  
           @t_debug = @t_debug,
           @t_file  = @t_file,
           @t_from  = @w_sp_name,
           @i_num   = 141055
      return 141055
  end
end --@w_op_tasa_variable = 'N'

--------------------------------------------------------
-- Verificar existencia de pf_tasa_variable 
--------------------------------------------------------
if @w_op_tasa_variable = 'S'
begin
   if not exists ( select 1 from pf_tasa_variable
                    where tv_mnemonico_prod = @w_op_toperacion 
                      and tv_moneda         = @w_op_moneda
                      and  tv_mnemonico_tasa  = @w_op_mnemonico_tasa)
   begin
     exec cobis..sp_cerror 
           @t_debug=@t_debug,
           @t_file=@t_file,
           @t_from=@w_sp_name,   
           @i_num = 141155
      return 141155
   end
end

-------------------
-- Verificar ppago
-------------------
if @w_fpago = 'PER' 
begin
   if @w_op_ppago is null
   begin
      exec cobis..sp_cerror 
           @t_debug = @t_debug,
           @t_file  = @t_file,
           @t_from  = @w_sp_name,
           @i_num   = 141072
      return 1
   end
   else
      if not exists (select pp_codigo from
                        pf_ppago where pp_codigo = @w_op_ppago)
      begin
         exec cobis..sp_cerror 
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 141071
         return 141071
      end
end

---------------------------------------------------------------------------------------
-- Estimacion de intereses y fechas, estimar proxima fecha de pago e intereses a pagar
---------------------------------------------------------------------------------------
select @w_fecha_valor = convert(datetime,convert(varchar,@w_op_fecha_ult_pg_int,101))
select @w_dia_pago = datepart(dd,@w_fecha_valor)


if @w_td_dias_reales = 'S' 
   select @w_fecha_ven = dateadd(dd,@w_num_dias,@w_fecha_valor) 
else
begin
   ------------------------------------------------------------------
   -- Proceso para tomar la fecha de vencimiento comercial 03/dic/98
   ------------------------------------------------------------------
   exec sp_funcion_1 
      @i_operacion = 'SUMDIA',
      @i_fechai   = @w_fecha_valor,        
      @i_dias     = @w_num_dias,
      @i_dia_pago = @w_dia_pago, --*-*
      @o_fecha    = @w_fecha_ven out 
end



select @w_td_tipo_deposito = td_tipo_deposito 
from cob_pfijo..pf_tipo_deposito
where  td_mnemonico = @w_op_toperacion
                   
-------------------------------------------------------------------------
-- Verificar que la fecha de Vencimiento Back-Value sea un dia Laborable
-------------------------------------------------------------------------
exec sp_primer_dia_labor
     @t_debug       = @t_debug, 
     @t_file        = @t_file,
     @t_from        = @w_sp_name,
     @i_fecha       = @i_fecha_ven_back,
     @s_ofi         = @s_ofi,
     @i_tipo_deposito =  @w_td_tipo_deposito , 
     @o_fecha_labor = @i_fecha_ven_back out

----------------------------------
-- Validacion de Fecha Back Value
----------------------------------
if @w_fecha_ven1 < @w_fecha_valor
begin
   Print 'La fecha de Cancelacion no puede ser menor que la fecha de Ultimo pago de Intereses'
   exec cobis..sp_cerror
        @t_debug     = @t_debug,
        @t_file      = @t_file,   
        @t_from      = @w_sp_name,
        @i_num       = 149016
   return 149016
end

-----------------------------------------------------------------------
-- Recalculo de intereses desde la fecha de Incremento a la Back-Value
-----------------------------------------------------------------------
select @w_fecha_ven1= @i_fecha_ven_back


--if @w_td_dias_reales = 'S'                                               GAL 14/SEP/2009 - RVVUNICA
--begin
   exec sp_estima_int
      @i_fecha_inicio    = @w_fecha_valor,
      @s_ofi             = @s_ofi,
      @s_date            = @s_date,
      @i_fecha_final     = @w_fecha_ven1,
      @i_monto           = @w_monto,
      @i_tasa            = @w_tasa,      
      @i_tcapitalizacion = @w_tcapitalizacion,
      @i_fpago           = 'VEN',
      @i_ppago           = 'NNN',
      @i_dias_anio       = @w_base_calculo,
      @i_dia_pago        = @w_dia_pago,
      @i_batch           = 'S',   --CVA Jul-12-06
      @i_retienimp       = @i_retienimp,         -- Capitalizacion
      @i_moneda          = @w_moneda,            -- Capitalizacion
      @i_simulacion      = 'S',                  -- Capitalizacion
      -- @i_diahabil        = 'S',               GAL 01/SEP/2009 - CSQL
      @i_dias_reales     = @w_td_dias_reales,
      --I. CVA Jul-12-06 cambios para escalonado
      @i_op_operacion    = @w_op_operacion,
      @i_toperacion      = @w_op_toperacion,               
      @i_periodo_tasa    = @w_periodo_tasa,       -- cobis..te_pizarra..pi_periodo
      @i_modalidad_tasa  = @w_modalidad_tasa,     -- cobis..te_pizarra..pi_modalidad, en la IPC no aplica 
      @i_descr_tasa      = @w_descr_tasa,
      @i_mnemonico_tasa  = @w_mnemonico_tasa,     -- DTF, TCC, IPC, PRIME, ESC
      @i_tipo_plazo      = @w_tipo_plazo, 
      @i_en_linea        = 'S',  
      --I. CVA Jul-12-06 cambios para escalonado
      @o_fecha_prox_pg   = @w_fecha_pg_int out,
      @o_fecha_real_pg   = @w_fecha_real_pg out,
      @o_int_pg_pp       = @w_int_estimado out,
      @o_int_pg_ve       = @w_total_int_estimado out,
      @o_num_pagos       = @w_num_pagos out
/*end                                                                         GAL 14/SEP/2009 - RVVUNICA
else -- Fecha Comercial
begin

   exec sp_estima_int_com  
      @i_fecha_inicio    = @w_fecha_valor,
      @s_ofi             = @s_ofi, 
      @s_date            = @s_date,
      @i_fecha_final     = @w_fecha_ven1,
      @i_monto           = @w_monto,
      @i_tasa            = @w_tasa,
      @i_tcapitalizacion = @w_tcapitalizacion,
      @i_fpago           = 'VEN',
      @i_ppago           = 'NNN',
      @i_dias_anio       = @w_base_calculo,
      @i_dia_pago        = @w_dia_pago,
      @i_batch           = 1,
      @i_retienimp       = @w_retienimp,      -- Capitalizacion
      @i_moneda          = @w_moneda,         -- Capitalizacion
      @i_simulacion      = 'S',               -- Capitalizacion
      @i_num_dias        = @w_num_dias,       -- Fechas comerciales
      @o_fecha_prox_pg   = @w_fecha_pg_int out,
      @o_fecha_real_pg   = @w_fecha_real_pg out,
      @o_int_pg_pp       = @w_int_estimado out,
      @o_int_pg_ve       = @w_total_int_estimado  out,
      @o_num_pagos       = @w_num_pagos out
end
*/

------------------------------------------------------------------------------------------------
-- Obtiene interés ganado a la fecha
------------------------------------------------------------------------------------------------
select @w_total_int_ganado = sum(pd_valor) - @w_op_int_pagado 
from pf_prov_dia
where pd_operacion = @w_op_operacion 
and (pd_fecha_proceso >= @w_op_fecha_ult_pg_int and pd_fecha_proceso < @i_fecha_ven_back)

--------------------------------------------------------------
-- Paso de datos de Cancelacion con fecha valor al Front_End
--------------------------------------------------------------
select  'Interes ganado'           = isnull(round(@w_int_ganado,@w_numdeci),0),
        'Total interes ganado'     = isnull(round(@w_total_int_ganado,@w_numdeci),0),
        'Valor de impuesto'        = 0,
        'Fecha de pago de interes' = convert(varchar,@w_fecha_pg_int,@i_formato_fecha),     
        'Dia de pago'              = convert(varchar(3),@w_dia_pago) + ' DE CADA MES',        
        'Numero de pagos'          = isnull(@w_num_pagos,0),
        'Fecha valor de canc'      = convert(varchar,@i_fecha_ven_back,@i_formato_fecha)

return 0
go
