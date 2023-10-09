/************************************************************************/
/*      Archivo:                desplazamiento.sp                       */
/*      Stored procedure:       sp_desplazamiento                       */
/*      Base de datos:          cob_cartera                             */
/*      Producto:               Cartera                                 */
/*      Disenado por:           Andy Gonzalez                           */
/*      Fecha de escritura:     Febrero 2001                            */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      'MACOSA'                                                        */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/************************************************************************/
/*                              PROPOSITO                               */
/*      Realiza el desplazmiento de cuotas de la Operacion              */
/*      cuotas prorrogadas.                                             */
/*                            ACTUALIZACIONES                           */
/*      FECHA            AUTOR          MODIFICACION                    */
/*    MAY-12-2020       ANDY GONZALEZ      REQ 138837 DESPLAZAMIENTO F2 */
/*    JUN-18-2020       ACH                CAMBIO TEMPORAL              */
/*    Jun-29-2020       DCU                Req. 141555                  */
/*    Ene-01-2020       DCU                Req. 140073                  */
/************************************************************************/


use cob_cartera
go

if exists (select 1 from sysobjects where name = 'sp_desplazamiento')
   drop proc sp_desplazamiento
go

create proc sp_desplazamiento
(  
  @i_banco            cuenta,
  @i_cliente          int,
  @i_fecha_valor      datetime,
  @i_cuotas           int,
  @i_archivo          varchar(255),
  @i_oper_nueva       char(1)      = 'N',
  @i_genera_int_esp   char(1)      = 'S',        --PARA PRUEBAS DE DESPLAZAMIENTO CON O SIN GENERAR RUBROS 
  @i_cuota_vencida    char(1)      = 'N',
  @o_msg              varchar(65)  = null out,
  @o_error            int          = null out  

)

as declare 
@w_fecha_proceso         datetime, 
@w_diario                char(1),
@w_operacionca           int,
@w_cliente               int, 
@w_estado       		 int,
@w_toperacion    		 varchar(24),
@w_moneda        	 	 int,
@w_fecha_ult_proceso     datetime,
@w_oficina               int,
@w_tdividendo            catalogo,
@w_periodo_int           int,
@w_oficial               int,
@w_tasa                  float,
@w_est_cancelado         int,
@w_est_castigado         int,
@w_est_novigente         int,
@w_est_vencido           int,
@w_di_fecha_ini          datetime,
@w_di_fecha_ven          datetime ,
@w_di_dividendo          int ,
@w_dias_cuota            int,
@w_error      			 int ,
@w_per_cuotas            int ,
@w_frecuencia            char(1),
@w_dias_causados         int,
@w_fecha_fin             datetime ,
@w_fecha_ini             datetime ,
@w_secuencial            int ,
@w_commit                char(1),
@w_int_dsp               money,
@w_est_vigente           int ,
@w_num_dec               int ,
@w_di_dividendo_ini      int,
@w_di_dividendo_fin      int,
@w_num_cuotas_espera     int,
@w_int_espera            money,
@w_concepto_esp          catalogo,
@w_monto_espera          money,
@w_total_int_esp         money,
@w_diferencia            money,
@w_secuencial_ioc        int ,
@w_dividendo             int ,
@w_actualizar_op         char(1),
@w_max_vigente           int,
@w_cap_dsp_tmp           money, -- es temporal
@w_monto_tmp             money, -- es temporal
@w_fecha_valor           datetime,
@w_dividendo_desp        int,
@w_fecha_ven             datetime,
@w_temporales            char(1)

select @w_actualizar_op = 'S'

--VALIDACIONES 
if @i_oper_nueva = 'S' begin
   delete ca_desplazamiento where de_banco = @i_banco
   if @@error <> 0 begin
      select 
      @o_msg   = 'ERROR AL ELIMINAR EL REGISTRO DE DESPLAZAMIENTO',
      @o_error =  700001
      GOTO ERROR_FIN
   end 
end

--- ESTADOS DE CARTERA 
exec  sp_estados_cca
@o_est_cancelado  = @w_est_cancelado out,
@o_est_castigado  = @w_est_castigado out,
@o_est_vigente    = @w_est_vigente   out,
@o_est_novigente  = @w_est_novigente out,
@o_est_vencido    = @w_est_vencido   out      


select 
@w_fecha_proceso = fp_fecha
from cobis..ba_fecha_proceso 

if @i_oper_nueva = 'N' and @i_fecha_valor > @w_fecha_proceso begin 
   select 
   @o_msg   = 'ERROR: NO SE PERMITEN INICIOS DE DESPLAZAMIENTO EN EL FUTURO',
   @o_error =  700001
   GOTO ERROR_FIN
end


if @i_oper_nueva = 'N'  
begin
   select 
   @w_operacionca       = op_operacion,
   @w_cliente           = op_cliente, 
   @w_estado            = op_estado,
   @w_toperacion        = op_toperacion,
   @w_moneda            = op_moneda ,
   @w_fecha_ult_proceso = op_fecha_ult_proceso,
   @w_oficina           = op_oficina,
   @w_tdividendo        = op_tdividendo,
   @w_periodo_int       = op_periodo_int,
   @w_oficial           = op_oficial,
   @w_monto_tmp         = op_monto
   from ca_operacion 
   where op_banco = @i_banco

   if @@rowcount = 0 begin 
      select 
      @o_msg   = 'ERROR: NO EXISTE OPERACION',
      @o_error =  700001
      GOTO ERROR_FIN
   end 
   
   --ACHP ini tmp *
   select @w_cap_dsp_tmp = sum(am_cuota) 
   from ca_amortizacion
   where am_operacion = @w_operacionca
   and   am_concepto  = 'CAP'

   if( @w_cap_dsp_tmp = 0 or @w_monto_tmp = 0) return 0
   --ACHP fin tmp *
   select @w_tasa = isnull(ro_porcentaje/100,0) 
   from ca_rubro_op
   where ro_operacion = @w_operacionca
   and ro_concepto    = 'INT' 
   
end
else
begin
   select 
   @w_operacionca       = opt_operacion,
   @w_cliente           = opt_cliente, 
   @w_estado            = opt_estado,
   @w_toperacion        = opt_toperacion,
   @w_moneda            = opt_moneda ,
   @w_fecha_ult_proceso = opt_fecha_ult_proceso,
   @w_oficina           = opt_oficina,
   @w_tdividendo        = opt_tdividendo,
   @w_periodo_int       = opt_periodo_int,
   @w_oficial           = opt_oficial,
   @w_monto_tmp         = opt_monto
   from ca_operacion_tmp
   where opt_banco = @i_banco

   if @@rowcount = 0 begin 
      select 
      @o_msg   = 'ERROR: NO EXISTE OPERACION',
      @o_error =  700001
      GOTO ERROR_FIN
   end 
   
   --ACHP ini tmp *
   select @w_cap_dsp_tmp = sum(amt_cuota) 
   from ca_amortizacion_tmp 
   where amt_operacion = @w_operacionca
   and   amt_concepto  = 'CAP'

   if( @w_cap_dsp_tmp = 0 or @w_monto_tmp = 0) return 0
   --ACHP fin tmp *
   
   select @w_tasa = isnull(rot_porcentaje/100,0) 
   from ca_rubro_op_tmp 
   where rot_operacion = @w_operacionca
   and rot_concepto    = 'INT' 

end

select @w_concepto_esp = ru_concepto
from   ca_rubro 
where ru_toperacion = @w_toperacion
and   ru_concepto   = 'INT_ESPERA'

if @@rowcount = 0 begin 
   select 
   @o_msg   = 'ERROR: NO EXISTE RUBRO ESPERA',
   @o_error =  700001
   GOTO ERROR_FIN
end 

---NUMERO DE DECIMALES 
exec sp_decimales
@i_moneda       = @w_moneda,
@o_decimales    = @w_num_dec out


if exists (select 1 from ca_desplazamiento 
           where de_operacion = @w_operacionca 
		   and @i_fecha_valor >= de_fecha_ini 
		   and @i_fecha_valor < de_fecha_fin 
		   and de_estado <> 'R') and  @i_archivo  not in ( 'BATCH', 'REEST')  begin 
   select 
   @o_msg   = 'ERROR: PRESTAMO CON DESPLAZAMIENTO EN CURSO',
   @o_error =  700001
   GOTO ERROR_FIN
end 

if @w_cliente <>@i_cliente begin 
   select 
   @o_msg   = 'ERROR: EL CLIENTE NO COINCIDE CON LA OPERACION',
   @o_error =  700001
   GOTO ERROR_FIN
end 

--LLEVAR A FECHA VALOR EL PRESTAMO
if @i_oper_nueva = 'N' and (@i_fecha_valor <> @w_fecha_ult_proceso) and @i_archivo not in ('REEST') begin 

	
   exec @w_error  = sp_fecha_valor 
   @s_date        = @w_fecha_proceso,
   @s_user        = 'usrbatch',
   @s_term        = 'consola',
   @t_trn         = 7049,
   @i_fecha_mov   = @w_fecha_proceso,
   @i_fecha_valor = @i_fecha_valor,
   @i_banco       = @i_banco,
   @i_secuencial  = 1,
   @s_ofi         = @w_oficina,
   @i_operacion   = 'F'
   
   if @w_error <> 0 begin    
      select 
      @o_msg   = 'ERROR: ERROR AL LLEVAR EL PRESTAMO A FECHA PROCESO',
      @o_error =  700001
      GOTO ERROR_FIN 
   end 
   
   
   select 
   @w_estado            = op_estado
   from ca_operacion 
   where op_banco = @i_banco
   
   if @@rowcount = 0 begin 
      select 
      @o_msg   = 'ERROR: NO EXISTE OPERACION',
      @o_error =  700001
      GOTO ERROR_FIN
   end 
   
end 

if @w_estado in ( @w_est_castigado, @w_est_cancelado) begin 
   select 
   @o_msg   = 'ERROR: EL ESTADO DE LA OPERACION NO PERMITE DESPLAZAMIENTOS',
   @o_error =  700001
   GOTO ERROR_FIN
end 
	

if @i_oper_nueva = 'N' begin
   select @w_dividendo_desp = 0
   
   if @i_cuota_vencida = 'S'
   begin
      
      select @w_fecha_ven = de_fecha_fin 
      from ca_desplazamiento 
      where de_operacion = @w_operacionca 
      and   de_estado    = 'A'
      order by de_fecha_ini desc
                 
      select @w_dividendo_desp = di_dividendo
      from ca_dividendo
      where di_operacion = @w_operacionca
      and   di_fecha_ven = @w_fecha_ven
      and   di_estado   in (@w_est_vigente, @w_est_vencido)
      
      if @w_dividendo_desp is null or @w_dividendo_desp = 0
          select @w_dividendo_desp = di_dividendo
          from ca_dividendo
          where di_operacion = @w_operacionca
          and  di_estado     = @w_est_vigente       
   end
   else
      select @w_dividendo_desp = di_dividendo
      from ca_dividendo
      where di_operacion = @w_operacionca
      and  di_estado     = @w_est_vigente 
   
   
   select 
   @w_di_fecha_ini  = di_fecha_ini ,
   @w_di_fecha_ven  = di_fecha_ven ,
   @w_di_dividendo  = di_dividendo ,
   @w_dias_cuota    = datediff(dd,di_fecha_ini, di_fecha_ven) 
   from ca_dividendo 
   where di_operacion  = @w_operacionca
   and  di_dividendo   = @w_dividendo_desp
   
   if @@rowcount  = 0 begin 
      select 
      @o_msg   = 'ERROR: NO EXISTEN CUOTAS A DESPLAZAR',
      @o_error =  700001
      GOTO ERROR_FIN
   end 
   
end else begin

   select 
   @w_di_fecha_ini  = dit_fecha_ini ,
   @w_di_fecha_ven  = dit_fecha_ven ,
   @w_di_dividendo  = dit_dividendo ,
   @w_dias_cuota    = datediff(dd,dit_fecha_ini, dit_fecha_ven) 
   from ca_dividendo_tmp 
   where dit_operacion   = @w_operacionca
   and   dit_dividendo   = 1  
   
   if @@rowcount  = 0 begin 
      select 
      @o_msg   = 'ERROR: NO EXISTEN CUOTAS A DESPLAZAR',
      @o_error =  700001
      GOTO ERROR_FIN
   end 

end
	

--REGISTRAR OPERACION EN LA TABLA DE DESPLAZAMIENTO 

select 
@w_per_cuotas = @w_periodo_int * td_factor 
from cob_cartera..ca_tdividendo 
where td_tdividendo = @w_tdividendo


if (@w_per_cuotas%30 =0) select @w_frecuencia = 'M'
else select @w_frecuencia = 'D'


if @i_archivo not in ( 'BATCH', 'REEST') begin 

   
   select @w_dias_causados = datediff( dd, @w_di_fecha_ini,@i_fecha_valor)
   
   if @w_dias_causados < 0 select @w_dias_causados = 0 
  
   if @w_frecuencia = 'D' begin 
   
      select @w_fecha_fin = dateadd(dd,  (@i_cuotas*@w_per_cuotas)- (@w_dias_cuota-@w_dias_causados), @w_di_fecha_ven)
	                                                 
   end else begin
   
      select @w_fecha_fin = dateadd(mm,(@i_cuotas*@w_per_cuotas/30), @w_di_fecha_ven)
	  
	  select @w_fecha_fin = dateadd(dd, (@w_dias_causados-@w_dias_cuota),@w_di_fecha_ven)
   
   end 
   
   select @w_fecha_ini = @i_fecha_valor
   
   insert into ca_desplazamiento ( 
   de_operacion		,de_banco	    ,de_cuotas  ,	    
   de_fecha_ini	    ,de_fecha_fin	,de_archivo ,      
   de_int_dsp	    ,de_fecha_real	,de_estado	,    
   de_secuencial    ,de_dividendo_vig) values ( 
   @w_operacionca   ,@i_banco 	     ,@i_cuotas  , 
   @w_fecha_ini     ,@w_fecha_fin    ,@i_archivo ,
   0                ,getdate()       , 'I'       ,
   0                ,@w_di_dividendo)
   
   if @@error <> 0 begin 
      select 
      @o_msg   = 'ERROR: ERROR AL INSERTAR REGISTRO EL DESPLAZAMIENTO',
      @o_error =  700001
      GOTO ERROR_FIN  
   end 

end 

if  @i_archivo = 'BATCH' begin 

   select 
   @w_fecha_ini = de_fecha_ini,
   @w_fecha_fin = de_fecha_fin
   from ca_desplazamiento
   where de_operacion = @w_operacionca
   and   de_estado = 'I'
   and   de_fecha_ini = @i_fecha_valor
   
   if @@error <> 0 begin 
      select 
      @o_msg   = 'ERROR: NO EXISTE OPERACION EN ESTADO INGRESADO',
      @o_error =  700001
      GOTO ERROR_FIN  
   end 
 
end 

if  @i_archivo = 'REEST' begin   
   
   
   select  @w_max_vigente = max(de_dividendo_vig)
   from ca_desplazamiento
   where de_operacion = @w_operacionca
   and   de_estado = 'A'

   select   
   @w_fecha_ini = min(de_fecha_ini), 
   @w_fecha_fin = max(de_fecha_fin),
   @i_cuotas    = sum(de_cuotas)
   from ca_desplazamiento
   where de_operacion     = @w_operacionca
   and   de_estado        = 'A'
   and   de_dividendo_vig = @w_max_vigente
    
   
   if @@error <> 0 begin 
      select 
      @o_msg   = 'ERROR: NO EXISTE OPERACION EN ESTADO INGRESADO',
      @o_error =  700001
      GOTO ERROR_FIN  
   end 
   
   if exists (SELECT 1 FROM cob_cartera..ca_dividendo 
              WHERE di_operacion = @w_operacionca AND di_dividendo =@w_max_vigente AND di_estado = @w_est_cancelado) begin
      select @w_actualizar_op = 'N'
   end  

end 


--NUEVA TRANSACCION DE       DSP 
exec @w_secuencial  = sp_gen_sec
@i_operacion        = @w_operacionca


--INICIO ATOMICIDAD
if @@trancount = 0 begin  
   select @w_commit = 'S'
   begin tran 
end
   

if @i_oper_nueva = 'N'  and  @i_archivo <> 'REEST' begin
   
   -- OBTENER RESPALDO ANTES DE la DSP
   exec @w_error  = sp_historial
   @i_operacionca  = @w_operacionca,
   @i_secuencial   = @w_secuencial  

   
   -- INSERCION DE CABECERA CONTABLE DE CARTERA  (REVISAR FV)
   insert into ca_transaccion  with (rowlock)(
   tr_fecha_mov,         tr_toperacion,     tr_moneda,
   tr_operacion,         tr_tran,           tr_secuencial,
   tr_en_linea,          tr_banco,          tr_dias_calc,
   tr_ofi_oper,          tr_ofi_usu,        tr_usuario,
   tr_terminal,          tr_fecha_ref,      tr_secuencial_ref,
   tr_estado,            tr_gerente,        tr_gar_admisible,
   tr_reestructuracion,  tr_calificacion,   tr_observacion,
   tr_fecha_cont,        tr_comprobante)
   values(
   @w_fecha_proceso,    @w_toperacion,        @w_moneda,
   @w_operacionca,      'DSP',                @w_secuencial,
   'N',                 @i_banco,             0,
   @w_oficina,          @w_oficina,           'usrbatch-dsp',
   'consola-dsp',       @i_fecha_valor,      0, 
   'ING',               @w_oficial,           '',
   'N',                 '',                   @i_archivo,
   @w_fecha_proceso,                 0)
   
   if @@error <> 0 begin
     select 
     @o_error = 710001,
     @o_msg   = 'ERROR AL CREAR LA TRANSACCION DSP'
     goto ERROR_FIN
   end
   
end

if @i_oper_nueva = 'N' 
begin
   update ca_operacion set 
   op_fecha_fin = case @w_frecuencia when 'M' then dateadd(mm,  (@i_cuotas*@w_per_cuotas/30),op_fecha_fin) else dateadd(dd,(@i_cuotas*@w_per_cuotas), op_fecha_fin) end 
   where op_operacion = @w_operacionca 
   and  @w_actualizar_op = 'S' 

   if @@error <> 0 begin 
      select 
      @o_error = 710002,
      @o_msg   = 'ERROR AL ACTUALIZAR FECHA FIN CA_OPERACION'
      goto ERROR_FIN
   end
   
   --ACTUALIZACION DE LA FECHA DE VENCIMIENTO DE LA CUOTA EN QUE SE APLICA EL DESPLAZAMIENTO
   update ca_dividendo set 
   di_fecha_ven =  case @w_frecuencia when 'M' then dateadd(mm,(@i_cuotas*@w_per_cuotas/30),di_fecha_ven) else dateadd(dd,(@i_cuotas*@w_per_cuotas), di_fecha_ven) end 
   where di_operacion = @w_operacionca 
   and   di_dividendo = @w_di_dividendo
   and  @w_actualizar_op = 'S'
   if @@error <> 0 begin 
      select 
      @o_error = 710002,
      @o_msg   = 'ERROR AL ACTUALIZAR FECHA FIN CA_DIVIDENDO'
      goto ERROR_FIN
   end 
   
   --ACTUALIZACION DE LA FECHA DE INICIO Y VENCIMIENTO DE LAS CUOTAS POSTERIORES AL DIVIDENDO EN QUE SE APLICA EL DESPLAZAMIENTO
   update ca_dividendo set 
   di_fecha_ini =  case @w_frecuencia when 'M' then dateadd(mm, (@i_cuotas*@w_per_cuotas/30),di_fecha_ini) else dateadd(dd,(@i_cuotas*@w_per_cuotas), di_fecha_ini) end, 
   di_fecha_ven =  case @w_frecuencia when 'M' then dateadd(mm, (@i_cuotas*@w_per_cuotas/30),di_fecha_ven) else dateadd(dd,(@i_cuotas*@w_per_cuotas), di_fecha_ven) end 
   where di_operacion = @w_operacionca 
   and   di_dividendo > @w_di_dividendo
   and  @w_actualizar_op = 'S'
   
   if @@error <> 0 begin 
      select 
      @o_error = 710002,
      @o_msg   = 'ERROR AL ACTUALIZAR FECHA FIN CA_DIVIDENDO'
      goto ERROR_FIN
   end 
   
   --ACTUALIZACION DE LA FECHA DE INICIO Y VENCIMIENTO DE LAS CUOTAS POSTERIORES AL DIVIDENDO EN QUE SE APLICA EL DESPLAZAMIENTO
   update ca_dividendo set 
   di_dias_cuota =  datediff(dd, di_fecha_ini,di_fecha_ven)
   where di_operacion = @w_operacionca 
   and   di_dividendo >= @w_di_dividendo
   and  @w_actualizar_op = 'S'
   
   if @@error <> 0 begin 
      select 
      @o_error = 710002,
      @o_msg   = 'ERROR AL ACTUALIZAR DIAS CUOTA CA_DIVIDENDO'
      goto ERROR_FIN
   end
   
   select @w_int_dsp = round(isnull(sum(am_cuota -am_pagado)*@w_tasa*datediff(dd,@w_fecha_ini,@w_fecha_fin)/360 ,0),@w_num_dec) 
   from ca_amortizacion 
   where am_operacion = @w_operacionca
   and   am_concepto  = 'CAP' 
   and   am_dividendo >= @w_di_dividendo
end
else
begin
   update ca_operacion_tmp set 
   opt_fecha_fin = case @w_frecuencia when 'M' then dateadd(mm,  (@i_cuotas*@w_per_cuotas/30),opt_fecha_fin) else dateadd(dd,(@i_cuotas*@w_per_cuotas), opt_fecha_fin) end 
   where opt_operacion = @w_operacionca 
   and  @w_actualizar_op = 'S' 

   if @@error <> 0 begin 
      select 
      @o_error = 710002,
      @o_msg   = 'ERROR AL ACTUALIZAR FECHA FIN CA_OPERACION'
      goto ERROR_FIN
   end
   
    --ACTUALIZACION DE LA FECHA DE VENCIMIENTO DE LA CUOTA EN QUE SE APLICA EL DESPLAZAMIENTO
   update ca_dividendo_tmp set 
   dit_fecha_ven =  case @w_frecuencia when 'M' then dateadd(mm,(@i_cuotas*@w_per_cuotas/30),dit_fecha_ven) else dateadd(dd,(@i_cuotas*@w_per_cuotas), dit_fecha_ven) end 
   where dit_operacion = @w_operacionca 
   and   dit_dividendo = @w_di_dividendo
   and  @w_actualizar_op = 'S'
   if @@error <> 0 begin 
      select 
      @o_error = 710002,
      @o_msg   = 'ERROR AL ACTUALIZAR FECHA FIN CA_DIVIDENDO'
      goto ERROR_FIN
   end
   
   --ACTUALIZACION DE LA FECHA DE INICIO Y VENCIMIENTO DE LAS CUOTAS POSTERIORES AL DIVIDENDO EN QUE SE APLICA EL DESPLAZAMIENTO
   update ca_dividendo_tmp set 
   dit_fecha_ini =  case @w_frecuencia when 'M' then dateadd(mm, (@i_cuotas*@w_per_cuotas/30),dit_fecha_ini) else dateadd(dd,(@i_cuotas*@w_per_cuotas), dit_fecha_ini) end, 
   dit_fecha_ven =  case @w_frecuencia when 'M' then dateadd(mm, (@i_cuotas*@w_per_cuotas/30),dit_fecha_ven) else dateadd(dd,(@i_cuotas*@w_per_cuotas), dit_fecha_ven) end 
   where dit_operacion = @w_operacionca 
   and   dit_dividendo > @w_di_dividendo
   and  @w_actualizar_op = 'S'
   
   if @@error <> 0 begin 
      select 
      @o_error = 710002,
      @o_msg   = 'ERROR AL ACTUALIZAR FECHA FIN CA_DIVIDENDO'
      goto ERROR_FIN
   end 
   
   --ACTUALIZACION DE LA FECHA DE INICIO Y VENCIMIENTO DE LAS CUOTAS POSTERIORES AL DIVIDENDO EN QUE SE APLICA EL DESPLAZAMIENTO
   update ca_dividendo_tmp set 
   dit_dias_cuota =  datediff(dd, dit_fecha_ini,dit_fecha_ven)
   where dit_operacion = @w_operacionca 
   and   dit_dividendo >= @w_di_dividendo
   and  @w_actualizar_op = 'S'
    
   if @@error <> 0 begin 
      select 
      @o_error = 710002,
      @o_msg   = 'ERROR AL ACTUALIZAR DIAS CUOTA CA_DIVIDENDO'
      goto ERROR_FIN
   end 
   
   select @w_int_dsp = round(isnull(sum(amt_cuota -amt_pagado)*@w_tasa*datediff(dd,@w_fecha_ini,@w_fecha_fin)/360 ,0),@w_num_dec) 
   from ca_amortizacion_tmp
   where amt_operacion = @w_operacionca
   and   amt_concepto  = 'CAP' 
   and   amt_dividendo >= @w_di_dividendo

end


update ca_desplazamiento set 
de_int_dsp    = @w_int_dsp,
de_estado     = 'A',
de_secuencial = @w_secuencial
where de_operacion   = @w_operacionca
and   de_estado      = 'I'
and   de_fecha_ini   = @i_fecha_valor

if @@error <> 0 begin
  select 
  @o_error = 710002,
  @o_msg   = 'ERROR AL ACTUALIZAR REGISTRO DE DSP'
  goto ERROR_FIN
end




if @i_genera_int_esp = 'S' begin --BANDERA PARA GENERAR RUBROS POR DEFECTO EN S
   if @i_oper_nueva = 'N' 
   begin
      --DIVIDENDO NO VIGENTE FINAL
      select @w_di_dividendo_fin = max(di_dividendo) 
      from ca_dividendo 
      where di_operacion = @w_operacionca
      
      select @w_temporales = 'N'
   end
   else
   begin
      --DIVIDENDO NO VIGENTE FINAL
      select @w_di_dividendo_fin = max(dit_dividendo) 
      from ca_dividendo_tmp 
      where dit_operacion = @w_operacionca 
      
      select @w_temporales = 'S'     
   end
   
   --SE CAPTURAL VALOR DE INTERES ESPERA 
   select @w_int_espera = sum(de_int_dsp)
   from ca_desplazamiento
   where de_operacion  = @w_operacionca
   and   de_estado     = 'A'
   and   @i_fecha_valor >= de_fecha_ini 
   and   @i_fecha_valor < de_fecha_fin 
   --and   @i_fecha_valor between de_fecha_ini and de_fecha_fin 
     
   if isnull(@w_int_espera ,0) = 0 begin
     select 
     @o_error = 710002,
     @o_msg   = 'ERROR: EL VALOR DEL INT ESPERA ES 0'
     goto ERROR_FIN
   end 

   select @w_dividendo = @w_di_dividendo
      
   select @w_monto_espera = round(@w_int_espera/(@w_di_dividendo_fin -@w_dividendo +1),@w_num_dec)
   
   while @w_dividendo <= @w_di_dividendo_fin  begin 
   
      if (@w_dividendo = @w_di_dividendo_fin)  select @w_monto_espera = @w_int_espera -(@w_monto_espera*(@w_di_dividendo_fin-@w_di_dividendo))
    
      exec @w_error     = sp_otros_cargos
      @s_date           = @w_fecha_proceso,
      @s_user           = 'usrbatch-dsp',
      @s_term           = 'consola-dsp',
      @s_ofi            = @w_oficina,
      @i_banco          = @i_banco,
      @i_moneda         = @w_moneda, 
      @i_operacion      = 'I',
      @i_toperacion     = @w_toperacion,
      @i_desde_batch    = 'N',   
      @i_en_linea       = 'N',
      @i_tipo_rubro     = 'O',
      @i_concepto       = @w_concepto_esp , 
      @i_monto          = @w_monto_espera,      
      @i_div_desde      = @w_dividendo,      
      @i_div_hasta      = @w_dividendo,
      @i_generar_trn    = 'N',
      @i_comentario     = 'GENERADO POR: sp_desplazamiento',
      @i_temporal       =  @w_temporales
      
      
      if @w_error <> 0 begin     
           select 
           @o_msg   = 'ERROR: ERROR AL INGRESAR LOS INTERESES DE ESPERA',
           @o_error =  700001
           GOTO ERROR_FIN 
      end 
      
      
      select 
      @w_dividendo = @w_dividendo +1
      
   
   end 
 
end 


if @w_commit = 'S' begin 
   select @w_commit = 'N'
   commit tran
end

 
return 0

ERROR_FIN:

if @w_commit = 'S'begin 
   select @w_commit = 'N'
   rollback tran    
end 

select @w_error= @o_error

return @w_error

GO