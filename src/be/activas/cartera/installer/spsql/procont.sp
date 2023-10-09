
/************************************************************************/
/*  Archivo:              procont.sp                                    */
/*  Stored procedure:     sp_proceso_condonacion_tmp                    */
/*  Base de datos:        cob_cartera                                   */
/*  Producto:             Credito y Cartera                             */
/*  Disenado por:         Dario Cumbal                                  */  
/*  Fecha de escritura:   Junio 11 de 2020                              */ 
/************************************************************************/
/*              IMPORTANTE                                              */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  'MACOSA'                                                            */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier alteracion o agregado hecho por alguno de sus             */
/*  usuarios sin el debido consentimiento por escrito de la             */
/*  Presidencia Ejecutiva de MACOSA o su representante.                 */
/************************************************************************/  
/*              PROPOSITO                                               */
/*  Procedimiento que realiza el abono de los rubros condonados         */
/*  de Cartera de desplazamiento                                        */
/*                               CAMBIOS                                */
/*      FECHA              AUTOR          CAMBIO                        */
/*    11/06/2020           D. Cumbal      Cambios Condonacion Rubros    */
/*                                        de desplazamiento             */
/*    10/07/2020           D. Cumbal      Cambio Pago Fecha Valor       */
/************************************************************************/  


use cob_cartera
go

if exists (select 1 from sysobjects where name = 'sp_proceso_condonacion_tmp')
   drop proc sp_proceso_condonacion_tmp
go

create proc sp_proceso_condonacion_tmp
@i_banco                cuenta       = null,
@i_fecha_valor          datetime     = null,
@t_debug                char(1)      = 'N',
@t_file                 varchar(14)  = null
as 
declare 
@w_operacion     int  ,
@w_monto         money,
@w_saldo_cuota   money,
@w_saldo         money,
@w_banco         cuenta,
@w_error         int,
@w_fecha_proceso datetime,
@w_oficina       int,
@w_pagado        money,
@w_porcentaje    float,
@w_monto_pago    money,
@w_secuencial    int  ,
@w_concepto      catalogo,
@w_moneda_op     int,
@w_num_dec       int,
@w_beneficiario  varchar(50),
@w_user          login,
@w_msg           varchar(255),
@w_sp_name       varchar(32),
@w_est_vigente   int,
@w_est_vencido   int,
@w_est_cancelado int,
@w_est_castigado int,
@w_est_suspenso  int,
@w_fecha_pago    datetime

select @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso

select @w_fecha_pago = isnull(@i_fecha_valor, @w_fecha_proceso)
   
select @w_porcentaje = pa_float from cobis..cl_parametro where pa_nemonico = 'POCODE'

select 
@w_moneda_op    = 0,
@w_beneficiario = 'CONDONACION RUBRO DESPLAZAMIENTO',
@w_user         = 'usrcond',
@w_sp_name      = 'sp_proceso_condonacion_tmp'

-- LECTURA DE DECIMALES
exec  sp_decimales
      @i_moneda       = @w_moneda_op,
      @o_decimales    = @w_num_dec out
      
/* ESTADOS DE CARTERA */
exec @w_error = sp_estados_cca
@o_est_vigente    = @w_est_vigente   out,
@o_est_vencido    = @w_est_vencido   out,
@o_est_cancelado  = @w_est_cancelado out,
@o_est_castigado  = @w_est_castigado out,
@o_est_suspenso   = @w_est_suspenso  out    




if not exists (select 1 from ca_desplazamiento where de_banco = @i_banco and   de_archivo <>'WORKFLOW' and de_estado = 'A')
begin
   select @w_error = 720331,
	      @w_msg   = 'OPERACION NO FUE DESPLAZADA: '+ @i_banco
   goto ERROR_PROCESO
end  

  

if object_id('tempdb..#valores_interes_espera') is not null  
   drop table tempdb..#valores_interes_espera
     
create table #valores_interes_espera(
secuencial    int   identity ,
op_banco      cuenta,
am_operacion  int   ,
op_oficina    int   ,
am_concepto   catalogo,
cuota         money ,
saldo_cuota   money ,
saldo         money ,
pagado        money 
)


insert into #valores_interes_espera(
op_banco,
am_operacion,
op_oficina,
am_concepto,
cuota,
saldo_cuota,
saldo,
pagado)
select op_banco, 
am_operacion, 
op_oficina, 
am_concepto,
cuota = sum(am_cuota), 
saldo_cuota = sum(am_cuota - am_pagado), 
saldo = sum(am_acumulado - am_pagado),
pagado = sum(am_pagado)
from cob_cartera..ca_operacion,
     cob_cartera..ca_amortizacion
where op_estado    in (@w_est_vigente, @w_est_vencido)
and   op_operacion = am_operacion
and   am_concepto  like '%ESPERA%'
and   op_banco     =  @i_banco --1048285
group by op_banco, am_operacion, op_oficina, am_concepto

if not exists (select 1 from #valores_interes_espera)
begin
   select @w_error = 720331,
	         @w_msg   = 'OPERACION NO TIENE RUBROS A CONDONAR: '+ @i_banco   
   goto ERROR_PROCESO
end  


if exists (select 1
                   from cob_cartera..ca_operacion,
                        cob_cartera..ca_abono,
                        cob_cartera..ca_abono_det
                   where op_banco          = @i_banco
                   and   ab_operacion      = op_operacion
                   and   ab_operacion      = abd_operacion
                   and   ab_secuencial_ing = abd_secuencial_ing
                   and   ab_estado         in ('A', 'NA', 'ING')
                   and   abd_tipo          = 'CON'
                   and   abd_concepto      in ('INT_ESPERA', 'IVA_ESPERA'))
begin
   select @w_error = 720331,
	      @w_msg   = 'YA CUENTA CON PAGO CONDONADO -  REVERSE EL ACTUAL : '+ @i_banco   
   goto ERROR_PROCESO
end  
            

select @w_secuencial = 0
while 1 = 1
begin
  select top 1
  @w_secuencial  = secuencial,
  @w_banco       = op_banco,
  @w_operacion   = am_operacion,
  @w_concepto    = am_concepto,
  @w_monto       = cuota,
  @w_saldo_cuota = saldo_cuota,
  @w_saldo       = saldo,
  @w_oficina     = op_oficina,
  @w_pagado      = pagado
  from #valores_interes_espera
  where secuencial > @w_secuencial
  order by secuencial
  
  if @@rowcount = 0 break
  
  select @w_monto_pago = round(@w_saldo_cuota * @w_porcentaje,@w_num_dec)
  
  if @t_debug = 'S'
  begin
     select
     'operacion'    = @w_operacion,
     'monto'        = @w_monto    ,
     'saldo_cuota'  = @w_saldo_cuota,
     'saldo'        = @w_saldo,
     'banco'        = @w_banco,
     'w_oficina'    = @w_oficina,
     'w_concepto'   = @w_concepto,
     'w_monto_pago' = @w_monto_pago
     
     select 'PRV ANTES PAGO', @w_concepto, tp_monto = sum(tp_monto)
     from ca_transaccion_prv
     where tp_operacion = @w_operacion
     and   tp_concepto  = @w_concepto
     
     select 'ANTES PAGO', @w_concepto, cuota = sum(am_cuota), 'Pagado' = sum(am_pagado), 'Acumulado' = sum(am_acumulado)
     from ca_amortizacion
     where am_operacion = @w_operacion
     and   am_concepto  = @w_concepto
     
  
     select 'ANTES PAGO', * from ca_amortizacion where am_operacion = @w_operacion and   am_concepto  = @w_concepto
  end
  
  exec @w_error = cob_cartera..sp_ing_detabono 
  @i_accion          = 'I'  ,
  @i_encerar         = 'S'  ,
  @i_tipo            = 'CON',
  @i_concepto        = @w_concepto,
  @i_cuenta          = '' ,
  @i_moneda          = 0,
  @i_beneficiario    = @w_beneficiario,
  @i_monto_mpg       = @w_monto_pago  ,
  @i_monto_mop       = @w_monto_pago  ,
  @i_monto_mn        = @w_monto_pago  ,
  @i_cotizacion_mpg  = 1       ,
  @i_cotizacion_mop  = 1       ,
  @i_tcotizacion_mpg = 'COT'   ,
  @i_tcotizacion_mop = 'COT'   ,
  @i_no_cheque       = 0       ,
  @i_inscripcion     = 0       ,
  @i_carga           = 0       ,
  @i_banco           = @w_banco,
  @i_porcentaje      = 50.0,
  @s_user            = @w_user ,
  @s_date            = @w_fecha_proceso,
  @s_term            = 'consola',
  @s_sesn            = @w_operacion
  
  if @w_error<>0 begin
      select @w_msg   = 'ERROR INGRESO DETALLE ABONO OPERACION: '+ @i_banco   
      goto ERROR_PROCESO  
  end 

 
 
  exec @w_error = cob_cartera..sp_ing_abono 
  @i_accion            = 'I'             ,
  @i_banco             = @w_banco        ,
  @i_tipo              = 'PAG'           ,
  @i_fecha_vig         = @w_fecha_pago   ,
  @i_ejecutar          = 'S'             ,
  @i_retencion         = 0  ,
  @i_cuota_completa    = 'N',
  @i_anticipado        = 'S',
  @i_tipo_reduccion    = 'N',
  @i_proyectado        = 'P',
  @i_tipo_aplicacion   = 'D',
  @i_prioridades       = '30;10;20;15;15;20;12',
  @i_tasa_prepago      = 84.0,
  @i_verifica_tasas    = 'S',
  @i_calcula_devolucion= 'N',
  @i_cancela           = 'N',
  @i_solo_capital      = 'N',
  @o_secuencial_ing    = 0,
  @s_srv               = 'CTSSRV',
  @s_user              = @w_user,
  @s_term              = 'consola',
  @s_ofi               = @w_oficina,
  @s_rol               = 29,
  @s_ssn               = 7112455,
  @s_date              = @w_fecha_proceso,
  @s_sesn              = @w_operacion
  
  
  
  if @w_error<>0 begin
      select @w_msg   = 'ERROR INGRESO ABONO OPERACION: '+ @i_banco   
      goto ERROR_PROCESO  
  end 
   
  if @t_debug = 'S'
  begin
     select 'PRV DESPUES PAGO', @w_concepto, tp_monto = sum(tp_monto)
     from ca_transaccion_prv
     where tp_operacion = @w_operacion
     and   tp_concepto  = @w_concepto
     
     select 'DESPUES PAGO', @w_concepto, am_cuota = sum(am_cuota), 'Pagado' = sum(am_pagado), 'Acumulado' = sum(am_acumulado)
     from ca_amortizacion
     where am_operacion = @w_operacion
     and   am_concepto  = @w_concepto
     
     select 'DESPUES PAGO', * from ca_amortizacion where am_operacion = @w_operacion and   am_concepto  = @w_concepto
  end
  
  
end 

drop table #valores_interes_espera

return 0




ERROR_PROCESO:
print '@i_banco:' + @i_banco
print'Num error'+ convert(varchar(50),@w_error) + ' ' + @w_msg

return 1
go
