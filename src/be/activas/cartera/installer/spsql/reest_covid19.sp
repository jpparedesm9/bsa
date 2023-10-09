/************************************************************************/
/*   Archivo                 :    reest_covid19.sp                      */
/*   Stored procedure        :    sp_reestructuracion_covid19           */
/*   Base de datos           :    cob_cartera                           */
/*   Producto                :    Cartera                               */
/*   Disenado por            :    ANDY GONZALEZ                         */
/*   Fecha de escritura      :    MAYO  2020                            */
/************************************************************************/
/*                           IMPORTANTE                                 */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'MACOSA'.                                                          */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de MACOSA o su representante.                */
/************************************************************************/  
/*                            PROPOSITO                                 */
/*   Realiza la reestructuracion de una operacion respetando las        */
/*   cuotas vencidas por pandemia                                       */
/************************************************************************/  

use cob_cartera
go

if exists (select 1 from sysobjects where name = 'sp_reestructuracion_covid19')
   drop proc sp_reestructuracion_covid19
go



create proc sp_reestructuracion_covid19(
   @i_banco                  cuenta       = null,
   @i_cuotas_adicionales     int          = 0,
   @o_msg                    varchar(255) = null out ,
   @o_error                  int          = null out
) as 

declare 
@w_plazo           int,
@w_monto           money,
@w_error           int ,
@w_est_vigente     int,
@w_est_vencido     int,
@w_est_cancelado   int,
@w_est_suspenso    int,
@w_est_diferido    int,
@w_est_novigente   int,
@w_fecha_proceso   datetime, 
@w_periodo_int     int,
@w_tdividendo      catalogo,
@w_tplazo          catalogo,       
@w_cuota_vig       int,
@w_operacionca     int,       
@w_dias            int,
@w_oficina         int,
@w_fecha_ini       datetime,
@w_secuencial_ioc  int,
@w_fecha_ult_proceso datetime,
@w_dividendo_vig   int,
@w_existe_espera   char(1)

select @w_existe_espera = 'N'

select @w_fecha_proceso = fp_fecha 
from cobis..ba_fecha_proceso

--- ESTADOS DE CARTERA 
exec @w_error = sp_estados_cca
@o_est_vigente    = @w_est_vigente   out,
@o_est_vencido    = @w_est_vencido   out,
@o_est_cancelado  = @w_est_cancelado out,
@o_est_suspenso   = @w_est_suspenso  out,
@o_est_diferido   = @w_est_diferido  out,
@o_est_novigente  = @w_est_novigente out                       

if @w_error <> 0 goto ERROR_FIN

select 
@w_operacionca          = op_operacion,
@w_oficina              = op_oficina,
@w_periodo_int          = op_periodo_int,
@w_tdividendo           = op_tdividendo, 
@w_tplazo               = op_tplazo,
@w_plazo                = op_plazo,
@w_fecha_ult_proceso    = op_fecha_ult_proceso
from  ca_operacion
where op_banco = @i_banco
and op_estado in (@w_est_vigente,@w_est_vencido)
 
if @@rowcount = 0 begin 
   select 
   @o_msg = 'ERROR: NO EXISTE PRESTAMO: '+@i_banco,
   @o_error = 70000
   GOTO ERROR_FIN
end 

--SELECCIONAMOS CUOTA VIGENTE 

select 
@w_cuota_vig = di_dividendo ,
@w_fecha_ini = di_fecha_ini
from ca_dividendo 
where di_operacion = @w_operacionca
and   di_estado    = @w_est_vigente

if @@rowcount = 0 begin 
   select 
   @o_msg   = 'ERROR: NO EXISTE CUOTA VIGENTE PRESTAMO: '+@i_banco,
   @o_error = 70000
   GOTO ERROR_FIN
end 

select operacion = de_operacion, secuencial = max(de_secuencial)
into #ultimo_desplazamiento
from ca_desplazamiento
where de_operacion = @w_operacionca
and de_estado = 'A'   
group by de_operacion 

if exists ( select 1
            from ca_desplazamiento, #ultimo_desplazamiento
            where de_operacion  = @w_operacionca
            and   de_operacion  = operacion
            and   de_secuencial = secuencial
            and   de_fecha_fin < @w_fecha_ult_proceso )
begin
   select 
   @o_msg   = 'ERROR: NO SE PUEDE REESTRUCTURAR UNA OPERACION FUERA DEL PERIODO DE DESPLAZAMIENTO: '+@i_banco,
   @o_error = 70000
   GOTO ERROR_FIN
end   

--LLEVAMOS A DIAS LAS CUOTAS ADICIONALES 

select @w_dias = @i_cuotas_adicionales * td_factor 
from ca_tdividendo 
where td_tdividendo = @w_tdividendo 

-- SE SUMAN LOS DIAS DE PLAZO DE LA OPERACION  A LAS CUOTAS ADICIONALES 
select @w_dias = @w_dias + @w_plazo*td_factor
from ca_tdividendo 
where td_tdividendo = @w_tplazo

--DETERMINAMOS EL PLAZO TOTAL EN SEMANAS
select @w_dias = @w_dias - (@w_cuota_vig-1)*td_factor
from ca_tdividendo 
where td_tdividendo = @w_tdividendo

select @w_plazo = @w_dias/td_factor
from ca_tdividendo 
where td_tdividendo = @w_tplazo


--CALCULAMOS EL MONTO DEL PRESTAMOS
select @w_monto =  sum(am_cuota-am_pagado) 
from ca_amortizacion 
where am_operacion = @w_operacionca
and am_dividendo   >=@w_cuota_vig
and am_concepto    = 'CAP'

if isnull(@w_monto,0) <= 0 begin 

   select 
   @o_msg   = 'ERROR: NO EXISTE MONTO DE CAPITAL A REESTRUCTURAR OP: '+@i_banco,
   @o_error = 70000
   GOTO ERROR_FIN

end 
--CREACION EN TABLAS TEMPORALES 


/*********************************************************************************************/
/*  Rubros desplazamiento                                                                 */
/*********************************************************************************************/   


if exists (select 1 
           from ca_amortizacion
           where am_operacion = @w_operacionca
           and am_dividendo   >= @w_cuota_vig
           and am_concepto    like '%ESPERA%' 
           and am_acumulado   > 0 )
begin

  select @w_existe_espera = 'S'

  select 
  operacion_a = am_operacion,
  dividendo_a = am_dividendo, 
  concepto_a  = am_concepto , 
  estado_a    = am_estado   ,
  cuota_a     = am_cuota    ,
  gracia_a    = am_gracia   ,
  pagado_a    = am_pagado   ,
  acumulado_a = am_acumulado 
  into #rubros_desplazamiento_pagos
  from ca_amortizacion
  where am_operacion = @w_operacionca
  and am_dividendo   >= @w_cuota_vig
  and am_concepto   in ('INT_ESPERA', 'IVA_ESPERA', 'SEGAD') 
  and am_acumulado   > 0
  
end

/*********************************************************************************************/
/* Fin Rubros desplazamiento                                                                 */
/*********************************************************************************************/   



exec @w_error = cob_cartera..sp_reestructuracion_cca
@s_user              = 'reest_covid19',
@s_date              = @w_fecha_proceso,
@s_ofi               = @w_oficina,
@s_term              = 'batch-reest',
@i_bloquear_salida   = 'S',
@i_paso              = 'S', 
@i_banco             = @i_banco,
@i_plazo             = @w_plazo,
@i_monto             = @w_monto,
@i_tplazo            = @w_tplazo,
@i_tdividendo        = @w_tdividendo,
@i_fecha_ult_proceso = @w_fecha_ini, 
@i_fecha_ini         = @w_fecha_ini,
@i_pago              = 'N',
@i_batch             = 'S'
       
if @w_error <> 0 begin 
   select 
   @o_msg   = 'ERROR: EN LA SIMULACION DE LA REESTRUCTURACION: '+@i_banco,
   @o_error = 70001
   goto ERROR_FIN
end 



--PASO A DEFINITIVAS 

exec @w_error = cob_cartera..sp_reestructuracion_cca
@s_user              = 'reest_covid19',
@s_date              = @w_fecha_proceso,
@s_ofi               = @w_oficina,
@s_term              = 'batch-reest',
@i_paso              = 'D', 
@i_banco             = @i_banco,
@i_respetar_vencidas = 'S'
       
	   
if @w_error <> 0 begin 
   select 
   @o_msg   = 'ERROR: EN LA CREACION DE LA REESTRUCTURACION: '+@i_banco,
   @o_error = 70002
   goto ERROR_FIN
end 


  
exec @w_error = cob_cartera..sp_reestructuracion_cca
@s_user             = 'reest_covid19',
@s_date             = @w_fecha_proceso,
@s_ofi              = @w_oficina,
@s_term             = 'batch-reest',
@i_paso             = 'T', --BORRA TEMPORALES
@i_banco            = @i_banco 


if @w_error <> 0 begin 
   select 
   @o_msg   = 'ERROR: EN EL BORRADO DE TEMPORALES '+@i_banco,
   @o_error = 70003
   goto ERROR_FIN
end 

/*********************************************************************************************/
/*  Rubros desplazamiento                                                                 */
/*********************************************************************************************/   

if @w_existe_espera = 'S'
begin

  update ca_amortizacion set
  am_acumulado = case when am_acumulado > acumulado_a then am_acumulado else acumulado_a end ,
  am_pagado    = pagado_a
  from #rubros_desplazamiento_pagos
  where am_operacion = operacion_a
  and   am_dividendo = dividendo_a
  and   am_concepto  = concepto_a
  
  delete ca_amortizacion
  where am_operacion = @w_operacionca
  and am_concepto    = 'SEGAD'
  
  insert into ca_amortizacion (
  am_operacion, am_dividendo, am_concepto, am_estado, 
  am_periodo  , am_cuota    , am_gracia  , am_pagado, 
  am_acumulado, am_secuencia)
  select 
  operacion_a , dividendo_a , concepto_a , estado_a ,
  1           , cuota_a     , gracia_a   , pagado_a ,
  acumulado_a , 1 
  from #rubros_desplazamiento_pagos
  where concepto_a  = 'SEGAD'
  
  
end

/*********************************************************************************************/
/* Fin Rubros desplazamiento                                                                 */
/*********************************************************************************************/   


  
  
return 0 


ERROR_FIN: 

if exists (select 1 from ca_operacion_tmp where opt_banco = @i_banco ) begin 

   exec @w_error = cob_cartera..sp_reestructuracion_cca
   @s_user             = 'reest_covid19',
   @s_date             = @w_fecha_proceso,
   @s_ofi              = @w_oficina,
   @s_term             = 'batch-reest',
   @i_paso             = 'T', --BORRA TEMPORALES
   @i_banco            = @i_banco

end  

return @w_error


go

