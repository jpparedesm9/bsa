/************************************************************************/
/*      Archivo:                u_modint.sp                             */
/*      Stored procedure:       sp_modifica_interes                     */
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
/*      Este programa modifica de la tabla pf_operacion todos los       */
/*      campos asociados a pagos periodicos, y de la tabla pf_det_pago  */
/*      el interes real a pagar.                                        */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA         AUTOR              RAZON                          */
/*      12-Feb-2004   Patricia Morales   Emision Inicial                */
/*      02-Jun-2004   N. Silva           Correcciones                   */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'sp_modifica_interes')
   drop proc sp_modifica_interes
go

create proc sp_modifica_interes(
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
   @t_trn                  smallint,
   @i_operacion            char(1),
   @i_op_fpago             catalogo        = 'PER',
   @i_op_operacion         int,
   @i_fecha_proceso        datetime,
   @i_tipo                 tinyint,
   @i_cu_cuota             integer         = NULL,
   @i_retiene_impuesto     char(1)         = 'N',
   @i_penalizacion         money           = 0,
   @i_en_linea             char(1)         = 'S',   --CVA Oct-15-05
   @i_valor_capitalizar    money
)
with encryption
as
declare @w_sp_name              descripcion,
        @w_return               tinyint,
        @w_cu_valor_cuota       money,
        @w_cu_valor_cuota_t     money, --CVA Oct-25-05
        @w_cu_fecha_pago        datetime,
        @w_cu_fecha_ult_pago    datetime,
        @w_cu_ppago             catalogo,
        @w_cu_cuota             int,
        @w_total_valor_cuota    money,
        @w_total_plazo          int,
        @w_cu_base_calculo      int,
        @w_cu_fecha_ven         datetime,
        @w_dp_secuencia_update  int,
        @w_tasa_imp             float,
        @w_dp_porcentaje        float,
        @w_numdeci              smallint,
        @w_dp_monto_bruto       money,
        @w_imp_retenido         money,
        @w_dp_monto_neto        money,
        @w_historia             int,
        @w_usadeci              char(1),
        @w_cu_moneda            tinyint,
        /* Variables de pf_operacion */
        @w_op_monto_pg_int      money,
        @w_op_monto             money,
        @w_op_tcapitalizacion   char(1),
        @w_op_int_ganado        money,
        @w_res_cuota            money,
        @w_estado               char(1),
        @w_cambioper            char(1),
        @w_interes_ven          money,
        @w_op_fpago             catalogo,
        @w_registros    int,     --+-+
        @w_cont_reg     int,     --+-+
        @w_acumula_valor   money    --+-+

select @w_sp_name = 'sp_modifica_interes'


/*---------------------------------*/
/* Verificar codigo de transaccion */
/*---------------------------------*/
if @t_trn <> 14167
begin
   exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name, 
        @i_num   = 141040
   return 1
end

----------------------------
-- Obtener tasa de impuesto
----------------------------

select @w_tasa_imp = pa_float
from cobis..cl_parametro
where pa_producto='PFI'
  and pa_nemonico = 'IMP'
if @@rowcount = 0
begin
    exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name, 
        @i_num   = 141140
    return 141040
end

--------------------------------------------------------------
-- Control de Cambio de paso de periodicas pagadas a vencidas
--------------------------------------------------------------
select @w_cambioper = 'S' 
if not exists(select 1
            from cob_pfijo..pf_cuotas
           where cu_operacion = @i_op_operacion
             and cu_estado = 'P') and @i_op_fpago = 'VEN'
   select @w_cambioper = 'N'       

if @i_operacion = 'U'
begin
   select @w_historia           = op_historia,
          @w_op_monto_pg_int    = op_monto_pg_int,
          @w_op_monto           = op_monto,
          @w_op_tcapitalizacion = op_tcapitalizacion,
          @w_op_fpago           = op_fpago
     from pf_operacion
    where op_operacion = @i_op_operacion
end

if @i_operacion = 'U' and @i_op_fpago = 'PER' and @w_cambioper = 'S' 
begin
   ----------------------------------------------
   -- Obtener valor de la primera cuota vigente 
   -- y la base de calculo
   ----------------------------------------------
   if @i_tipo = 1
   begin
      select   @w_cu_valor_cuota    = cu_valor_cuota,
         @w_cu_fecha_pago     = cu_fecha_pago,
         @w_cu_ppago          = cu_ppago,
         @w_cu_base_calculo   = cu_base_calculo,
         @w_cu_moneda         = cu_moneda,
         @w_cu_fecha_ult_pago = @w_cu_fecha_ult_pago
      from pf_cuotas
      where cu_operacion       = @i_op_operacion
         and cu_fecha_pago     >= @i_fecha_proceso
         and cu_fecha_ult_pago <= @i_fecha_proceso
         and cu_estado = 'V'
   end
   else
   begin
      if @w_op_fpago = 'PER'
      begin
         select @w_cu_valor_cuota    = cu_valor_cuota,
            @w_cu_fecha_pago     = cu_fecha_pago,
            @w_cu_ppago          = cu_ppago,
            @w_cu_base_calculo   = cu_base_calculo,
            @w_cu_moneda         = cu_moneda,
            @w_cu_fecha_ult_pago = cu_fecha_ult_pago,
            @w_cu_cuota           = cu_cuota,
            @w_op_int_ganado      = op_int_ganado,
            @w_res_cuota          = round(((op_monto*op_tasa*datediff(dd,@s_date,cu_fecha_pago))/(op_base_calculo*100.00)), @w_numdeci)         -- GAL 31/AGO/2009 - RVVUNICA
         from cob_pfijo..pf_cuotas,
         cob_pfijo..pf_operacion
         where cu_operacion = @i_op_operacion
            and cu_operacion = op_operacion
            and cu_fecha_ult_pago = op_fecha_ult_pg_int
            --and cu_fecha_pago <= op_fecha_pg_int
            and cu_estado = 'V'
      end
      else
      begin
         select   @w_cu_valor_cuota    = cu_valor_cuota,
            @w_cu_fecha_pago     = cu_fecha_pago,
            @w_cu_ppago          = cu_ppago,
            @w_cu_base_calculo   = cu_base_calculo,
            @w_cu_moneda         = cu_moneda,
            @w_cu_fecha_ult_pago = cu_fecha_ult_pago,
            @w_cu_cuota           = cu_cuota,
            @w_op_int_ganado      = op_int_ganado,
            @w_res_cuota          = round(((op_monto*op_tasa*datediff(dd,@s_date,cu_fecha_pago))/(op_base_calculo*100.00)), @w_numdeci)         -- GAL 31/AGO/2009 - RVVUNICA
         from cob_pfijo..pf_cuotas,
         cob_pfijo..pf_operacion
         where cu_operacion = @i_op_operacion
            and cu_operacion = op_operacion
            and cu_cuota = 1
            --and cu_fecha_pago <= op_fecha_pg_int
            and cu_estado = 'V'
      end
   end
   
   if @@rowcount = 0
   begin
      exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name, 
         @i_num   = 710039
      return 710039
   end

   ----------------------------
   -- Obtener numero de decimales
   ----------------------------
   select @w_usadeci  = mo_decimales
   from cobis..cl_moneda
   where mo_moneda = @w_cu_moneda
   if @w_usadeci = 'S'
   begin
      select @w_numdeci = isnull (pa_tinyint,0)
      from cobis..cl_parametro
      where pa_nemonico = 'DCI'
      and pa_producto = 'PFI'
   end
   else
      select @w_numdeci = 0

   --------------------------------------------
   -- Calculo del nuevo interes total estimado
   --------------------------------------------
   select   @w_total_valor_cuota = sum(cu_valor_cuota), 
      @w_total_plazo       = sum(cu_num_dias)
   from pf_cuotas
   where cu_operacion = @i_op_operacion

   --print 'sum_cuota %1!', @w_total_valor_cuota
   -------------------------------------------------------
   -- Calculo de la fecha de vencimiento 
   -------------------------------------------------------
   select @w_cu_fecha_ven = max(cu_fecha_pago)
   from pf_cuotas
   where cu_operacion = @i_op_operacion  

   begin tran  --*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
   
   if @i_tipo = 1
   begin
      -------------------------------------------------
      -- Actualizacion de pf_operacion con los nuevos
      -- valores de intereses estimado
      -- en pago de intereses
      -------------------------------------------------
      if @w_op_tcapitalizacion = 'S'  --CVA Mar-21-06
         select @w_op_monto = @w_op_monto + isnull(@i_valor_capitalizar,0)

      update pf_operacion
      set   op_int_estimado       = @w_cu_valor_cuota,
         op_ppago              = @w_cu_ppago,
         op_fecha_ven          = @w_cu_fecha_ven,
         op_base_calculo       = @w_cu_base_calculo,
         op_num_dias           = @w_total_plazo,
         op_total_int_estimado = @w_total_valor_cuota,
         op_fecha_mod          = @s_date,
         op_fecha_ult_pg_int   = op_fecha_pg_int,
         op_fecha_pg_int       = @w_cu_fecha_pago,
         op_historia           = (@w_historia + 1),
         op_monto              = @w_op_monto, 
         op_monto_pg_int       = @w_op_monto  --CVA Mar-21-06
      where op_operacion       = @i_op_operacion
      if @@error <> 0
      begin
         exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name, 
            @i_num   = 145001
         return 145001
      end
      
      select @w_estado = 'P'
   end
   
   if @i_tipo = 2
   begin
      --print 'total_cuota %1!, ganado %2!, @w_res_cuota %3!, @w_cu_valor_cuota %4! ', @w_total_valor_cuota,@w_op_int_ganado,@w_res_cuota,@w_cu_valor_cuota
      select @w_total_valor_cuota  = @w_total_valor_cuota + @w_op_int_ganado + @w_res_cuota - @w_cu_valor_cuota

      --print 'totalestimado %1!', @w_total_valor_cuota
      -------------------------------------------------
      -- Actualizacion de pf_operacion con los nuevos
      -- valores de intereses estimado
      -- en modificacion de cuotas
      -------------------------------------------------
      update pf_operacion set 
         op_int_estimado       = round((@w_op_int_ganado + @w_res_cuota), @w_numdeci),         -- GAL 31/AGO/2009 - RVVUNICA
         op_ppago              = @w_cu_ppago,
         op_fecha_ven          = @w_cu_fecha_ven,
         op_base_calculo       = @w_cu_base_calculo,
         op_num_dias           = @w_total_plazo,
         op_total_int_estimado = @w_total_valor_cuota,
         op_fecha_mod          = @s_date,
         op_fecha_ult_pg_int   = @w_cu_fecha_ult_pago,
         op_fecha_pg_int       = @w_cu_fecha_pago,
         op_historia           = (@w_historia + 1),
         op_fpago              = 'PER'
      where op_operacion       = @i_op_operacion
      if @@error <> 0
      begin
         exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name, 
            @i_num   = 145001
         return 145001
      end
      -----------------------    
      -- Insercion historico
      -----------------------
      insert pf_historia
         (hi_operacion        ,hi_secuencial ,hi_fecha  ,hi_trn_code   ,
         hi_valor            ,hi_funcionario,hi_oficina,hi_observacion,
         hi_fecha_crea       ,hi_fecha_mod  )
      values
         (@i_op_operacion     ,@w_historia   ,@s_date   ,@t_trn        ,
         @w_total_valor_cuota,@s_user       ,@s_ofi    ,'AJUSTE DE CUOTAS, FECHA VEN, BASE CALCULO FPAGO PER',
         @s_date             ,@s_date       )
      if @@error <> 0
      begin
         exec cobis..sp_cerror 
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name, 
            @i_num   = 143006
         return 1
      end

      --print 'cuota tabla %1!, @w_op_int_ganado %2!, @w_res_cuota %3!, date %4!', @w_cu_valor_cuota, @w_op_int_ganado, @w_res_cuota, @s_date
      select @w_estado = 'V'
      select @w_cu_valor_cuota = round((@w_op_int_ganado + @w_res_cuota), @w_numdeci)         -- GAL 31/AGO/2009 - RVVUNICA
      --print 'cuota resultado %1!', @w_cu_valor_cuota
   end

   ----------------------------------------
   -- Modificacion del estado de la cuota
   ----------------------------------------
   --print 'actualizar @i_cu_cuota %1!, @i_op_operacion %2!, @w_cu_valor_cuota %3!', @i_cu_cuota, @i_op_operacion, @w_cu_valor_cuota          
   set rowcount 1
   update pf_cuotas 
   set   cu_retencion   = 0,
      cu_estado      = @w_estado
   where cu_operacion    = @i_op_operacion
      and cu_cuota       = @i_cu_cuota
   if @@error <> 0
   begin
      exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name, 
         @i_num   = 145001
      return 145001
   end

   set rowcount 0

   -------------------------------------
   -- Actualizacion de detalle de pagos
   ------------------------------------- 
   select @w_registros = count(1) from pf_det_pago       --+-+
   where dp_operacion = @i_op_operacion
      and dp_tipo        = 'INT'
      and dp_estado_xren = 'N'
      and dp_estado      = 'I' 

--print 'REGISTROS DE PAGO:%1!',@w_registros
      
   select   @w_cont_reg = 0,
      @w_acumula_valor = 0             --+-+
   
        declare cursor_pf_det_pago cursor
   for select  dp_porcentaje,
         dp_secuencia
   from pf_det_pago
   where dp_operacion = @i_op_operacion
      and dp_tipo        = 'INT'
      and dp_estado_xren = 'N'
      and dp_estado      = 'I' 

   open cursor_pf_det_pago
   fetch cursor_pf_det_pago into
               @w_dp_porcentaje,
               @w_dp_secuencia_update

   while @@fetch_status <> -1
   begin
      if @@fetch_status = -2
      begin
         close cursor_pf_det_pago
         deallocate cursor_pf_det_pago
         raiserror ('200001 - Fallo lectura del cursor ', 16, 1)
         return 0
      end 

      --------------------------------------------------------------------------------
      -- Proceso incrementado por PER y tasa variable obtener el valor del capital de 
      -- pf_cuotas, ultimo periodo agregar condicion para PRA
      --------------------------------------------------------------------------------
      --print 'det_pago @w_cu_valor_cuota %1!, @w_numdeci %2!, @w_dp_porcentaje %3!', @w_cu_valor_cuota, @w_numdeci, @w_dp_porcentaje
      select @w_cont_reg = @w_cont_reg + 1      --+-+      
--print 'Num REg:%1!,w_acumula_valor:%2!',@w_cont_reg,@w_acumula_valor
      if @w_cont_reg = @w_registros
         select @w_dp_monto_bruto = @w_cu_valor_cuota - @w_acumula_valor
      else
         select @w_dp_monto_bruto = round(((@w_cu_valor_cuota*@w_dp_porcentaje)/100), @w_numdeci)
      ---------------------------------------------------------
      -- Proceso para tomar el porcentaje de impto retenido de
      -- cada registro con respecto al total                  
      ---------------------------------------------------------
      if @i_retiene_impuesto = 'S'
         select @w_imp_retenido = round(((@w_dp_monto_bruto * @w_tasa_imp) /100), @w_numdeci)
      else
         select @w_imp_retenido = 0

      select @w_dp_monto_neto = @w_dp_monto_bruto - @w_imp_retenido  

      --print 'actualiza det_pago %1!, @w_dp_secuencia_update %2!', @w_dp_monto_neto, @w_dp_secuencia_update
      ---------------------------------------
      -- Proceso para actualizar pf_det_pago
      -- SEGUNDO UPDATE pf_det_pago por PER 
      ---------------------------------------
--print 'secuencia %1!, @w_dp_monto_neto %2!', @w_dp_secuencia_update, @w_dp_monto_neto
            
      if @w_dp_monto_neto > 0
      begin                  
         update pf_det_pago 
         set   dp_monto      = @w_dp_monto_neto,
            dp_fecha_mod  = @i_fecha_proceso
         where dp_operacion  = @i_op_operacion
            and dp_tipo        = 'INT'
            and dp_estado_xren = 'N' 
            and dp_estado      = 'I'
            and dp_secuencia   = @w_dp_secuencia_update
         if @@error <> 0
         begin
            exec cobis..sp_cerror
               @t_debug = @t_debug,
               @t_file  = @t_file,
               @t_from  = @w_sp_name, 
               @i_num   = 145037
            return 145037
         end
      end                  

      select @w_acumula_valor = @w_acumula_valor + @w_dp_monto_neto  --+-+

      /* Acceso al siguientte registro del cursor */
      fetch cursor_pf_det_pago into
                  @w_dp_porcentaje,
                  @w_dp_secuencia_update
   end  -- del while
   close cursor_pf_det_pago
   deallocate  cursor_pf_det_pago  
   
   commit tran --*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
end

-------------------------------------------------------------
-- Control para operaciones con forma de pago al vencimiento
-------------------------------------------------------------
if @i_op_fpago = 'VEN'
begin
   -------------------------------------------------
   -- Actualizacion de pf_operacion con los nuevos
   -- valores de intereses estimado
   -- en modificacion de cuotas
   -------------------------------------------------
   update pf_operacion set   
      op_int_estimado       = round((op_int_ganado + ((op_monto*op_tasa*datediff(dd,@s_date,op_fecha_ven))/convert(money,(op_base_calculo*100)))), @w_numdeci),         -- GAL 31/AGO/2009 - RVVUNICA
      op_ppago              = 'NNN',
      op_total_int_estimado = round((op_total_int_ganados + ((op_monto*op_tasa*datediff(dd,@s_date,op_fecha_ven))/convert(money,(op_base_calculo*100)))), @w_numdeci),         -- GAL 31/AGO/2009 - RVVUNICA
      op_fecha_mod          = @s_date,
      op_fecha_pg_int       = op_fecha_ven,
      op_historia           = (@w_historia + 1),
      op_fpago              = 'VEN'
   where op_operacion          = @i_op_operacion 
   if @@error <> 0
   begin
      exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name, 
         @i_num   = 145037
      return 145037
   end

   --------------------------------------------------------------------------------------------
   -- Actualizaci¢n de la tabla pf_det_pago para operaciones periodicas que pasaron a vencidas
   --------------------------------------------------------------------------------------------
   select @w_interes_ven = op_int_estimado
   from cob_pfijo..pf_operacion
   where op_operacion = @i_op_operacion

   ---------------------------------------
   -- Guardar la historia de la operacion
   ---------------------------------------
   update cob_pfijo..pf_det_pago
   set   dp_monto = ((@w_interes_ven*dp_porcentaje)/convert(money,100.0)),
      dp_tipo  = 'INTV'
   where dp_operacion = @i_op_operacion
      and dp_estado = 'I'
      and dp_estado_xren = 'N'

   -----------------------    
   -- Insercion historico
   -----------------------
   insert pf_historia
      (hi_operacion        ,hi_secuencial ,hi_fecha  ,hi_trn_code   ,
      hi_valor            ,hi_funcionario,hi_oficina,hi_observacion,
      hi_fecha_crea       ,hi_fecha_mod  )
   values
      (@i_op_operacion     ,@w_historia   ,@s_date   ,@t_trn        ,
      @w_interes_ven      ,@s_user       ,@s_ofi    ,'AJUSTE DE CUOTAS, FECHA VEN, BASE CALCULO FPAGO VEN',
      @s_date             ,@s_date       )
   if @@error <> 0
   begin
      exec cobis..sp_cerror 
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name, 
         @i_num   = 143006
      return 1
   end

end
return 0
go




