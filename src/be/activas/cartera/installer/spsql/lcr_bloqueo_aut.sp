/* ********************************************************************* */
/*      Archivo:                lcr_bloqueo_automatico                   */
/*      Stored procedure:       lcr_bloqueo_automatico                   */
/*      Base de datos:          cob_cartera                              */
/*      Producto:               Cartera                                  */
/*      Disenado por:           Andy Gonzalez                            */
/*      Fecha de escritura:     01/10/2018                               */
/* ********************************************************************* */
/*                              IMPORTANTE                               */
/*      Este programa es parte de los paquetes bancarios propiedad de    */
/*      "MACOSA", representantes exclusivos para el Ecuador de la        */
/*      "NCR CORPORATION".                                               */
/*      Su uso no autorizado queda expresamente prohibido asi como       */
/*      cualquier alteracion o agregado hecho por alguno de sus          */
/*      usuarios sin el debido consentimiento por escrito de la          */
/*      Presidencia Ejecutiva de MACOSA o su representante.              */
/* ********************************************************************* */
/*                              PROPOSITO                                */
/*    FECHA                 AUTOR                 RAZON                  */
/*  Bloqueo masivos de las LCR                                           */
/*   23/09/2019             D. Cumbal             #126168                */
/* ********************************************************************* */

use cob_cartera 
go

if exists(select 1 from sysobjects where name ='sp_lcr_bloqueo_aut')
	drop proc sp_lcr_bloqueo_aut
go

create proc sp_lcr_bloqueo_aut

as 
declare 
@w_dias_bloqueo  int, 
@w_fecha_proceso datetime,
@w_est_vigente   int ,
@w_error         int,
@w_msg           varchar(255) ,
@w_operacion     int,  
@w_banco         cuenta ,
@w_oficina       int,
@w_sp_name       descripcion 
 


select @w_dias_bloqueo = pa_int
from   cobis..cl_parametro with (nolock)
where  pa_nemonico = 'LCRBLQ'
and    pa_producto = 'CCA'

select @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso 


select @w_dias_bloqueo= isnull(@w_dias_bloqueo, 90) 




--estados cca
exec @w_error        = sp_estados_cca
@o_est_vigente       = @w_est_vigente    out  


--SELECCIONAR LCR SIN BLQOUEO , Y QUE ESTEN EN VIGENCIA, y  CON SALDO 0 
select distinct 
operacion = op_operacion,
banco     = op_banco,
oficina   = op_oficina,
fecha     = op_fecha_ini
into #lcr_operaciones 
from ca_operacion 
where op_tipo_amortizacion = 'ROTATIVA'
and @w_fecha_proceso between op_fecha_ini and op_fecha_fin 

if @@error <> 0 begin
   select 
   @w_error =@w_error,
   @w_msg   = 'ERROR: AL INSERTAR LCR EN TEMPORAL'
   goto ERROR
end

delete #lcr_operaciones
from  ca_lcr_bloqueo 
where operacion    = lb_operacion 
and   lb_bloqueo   = 'S'

--TRANSACCIONES DE MAS DE 90 DIAS SIN MOVIMIENTO CON RESPECTO A LA FECHA PROCESO 
select
tx_operacion = operacion,
tx_fecha     = max(tr_fecha_mov)      
into #lcr_transacciones
from #lcr_operaciones, ca_transaccion  
where  operacion = tr_operacion
and   tr_estado  <> 'RV'
and   tr_tran in ('PAG', 'DES' ) 
and   tr_secuencial >0 
group by operacion

if @@error <> 0 begin
   select 
   @w_error =@w_error,
   @w_msg   = 'ERROR: AL INSERTAR LCR EN TEMPORAL'
   goto ERROR
end

update #lcr_operaciones set
fecha = tx_fecha
from #lcr_transacciones
where tx_operacion = operacion


select
@w_operacion = 0, 
@w_banco     = '',
@w_oficina   = 0

while (1=1) begin 


   select top 1
   @w_operacion = operacion,
   @w_banco     = banco,
   @w_oficina   = oficina   
   from  #lcr_operaciones
   where  operacion >@w_operacion
   and    datediff(dd,fecha,@w_fecha_proceso) >=  @w_dias_bloqueo
   order by operacion
   
   if @@rowcount = 0 break
   
   exec @w_error =  sp_lcr_bloquear
   @s_user            = 'usrbatch',
   @s_term            = 'batch',
   @s_date            = @w_fecha_proceso,
   @s_ofi             = @w_oficina,
   @i_operacion       ='I',  
   @i_bloqueo         ='S',
   @i_banco           = @w_banco 
         
   if @w_error <> 0 begin
	  select  @w_error = 'Error al ejecutar sp_lcr_bloquear' +  @w_banco 
	  goto  ERROR_CURSOR 
   end
   
   goto SIGUIENTE_LCR
   
   ERROR_CURSOR:
   exec sp_errorlog 
   @i_fecha     = @w_fecha_proceso,
   @i_error     = @w_error, 
   @i_usuario   = 'usrbatch', 
   @i_tran      = 7999,
   @i_tran_name = @w_sp_name,
   @i_cuenta    = @w_banco,
   @i_anexo     = @w_msg
   
   
   
   SIGUIENTE_LCR:
end

return  0

ERROR:
exec sp_errorlog 
@i_fecha     = @w_fecha_proceso,
@i_error     = @w_error, 
@i_usuario   = 'sa', 
@i_tran      = 7999,
@i_tran_name = @w_sp_name,
@i_cuenta    = 'Masivo',
@i_anexo     = @w_msg

return @w_error

go