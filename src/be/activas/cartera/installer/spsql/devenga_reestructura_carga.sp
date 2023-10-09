/*************************************************************/
/*   ARCHIVO:         	devenga_reestructura_carga.sp        */
/*   NOMBRE LOGICO:   	sp_devenga_reest_carga.sp            */
/*   PRODUCTO:        		CARTERA                          */
/*************************************************************/
/*                     IMPORTANTE                            */
/*   Esta aplicacion es parte de los  paquetes bancarios     */
/*   propiedad de MACOSA S.A.                                */
/*   Su uso no autorizado queda  expresamente  prohibido     */
/*   asi como cualquier alteracion o agregado hecho  por     */
/*   alguno de sus usuarios sin el debido consentimiento     */
/*   por escrito de MACOSA.                                  */
/*   Este programa esta protegido por la ley de derechos     */
/*   de autor y por las convenciones  internacionales de     */
/*   propiedad intelectual.  Su uso  no  autorizado dara     */
/*   derecho a MACOSA para obtener ordenes  de secuestro     */
/*   o  retencion  y  para  perseguir  penalmente a  los     */
/*   autores de cualquier infraccion.                        */
/*************************************************************/
/*                     PROPOSITO                             */
/*   Devengar archivo para Reestructuracion de               */
/*   operacones desplazadas.                                 */
/*************************************************************/
/*                     MODIFICACIONES                        */
/*   FECHA         AUTOR               RAZON                 */
/*   22-Mayo-2020  D. Cumbal           Emision Inicial.      */
/*************************************************************/
use cob_cartera
go

IF OBJECT_ID ('dbo.sp_devenga_reest_carga') IS NOT NULL
	DROP PROCEDURE dbo.sp_devenga_reest_carga
GO

create proc sp_devenga_reest_carga (	
	@i_param1		  datetime     = null,--Fecha
	@i_param2         varchar(255) = null,--Nombre del archivo
	@t_show_version   bit	       = 0,
	@t_debug          char(1)      = 'N',
    @t_file           varchar(14)  = null

)
as

declare 
@w_s_app           varchar(255),
@w_sp_name         varchar(32),
@w_archivo         varchar(255),
@w_archivo_ruta    varchar(255),
@w_error           int,
@w_o_error         int,
@w_existe_arch     int,
@w_msg             varchar(255),
@w_archivo_format  varchar(255),
@w_comando         varchar(6000),
@w_command         nvarchar(MAX),
@w_fecha_proceso   datetime,
@w_banco           varchar(24),
@w_cliente         int,
@w_cuotas          int,
@w_query           varchar(6000),
@w_estado          char(1),
@w_num_dec         int,
@w_operacion       int,
@w_fecha_inicio    datetime,
@w_dias_aplaza     int,
@w_dias_transcu    int,
@w_moneda          int,
@w_interes         money,
@w_valor_prov      money,
@w_valor_acum      money

if @t_show_version = 1
begin
    print 'Stored procedure sp_reestructuracion_carga, Version 1.0.0'
    return 0
end


-- VALIDA SI EL ARCHIVO FUE PROCESADO
if not exists(select 1 from ca_reestructuracion_archivo where ra_archivo = @i_param2 and ra_estado = 'P') 
begin	
   select @w_error = 720331,
	      @w_msg   = 'ARCHIVO '+@i_param2+' NO TIENE OPERACIONES A DEVENGAR'    
   goto ERROR_PROCESO
end

select @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso

select @w_s_app = pa_char
from   cobis..cl_parametro
where  pa_producto = 'ADM'
and    pa_nemonico = 'S_APP'


select @w_banco=''

exec sp_decimales
@i_moneda       = 0,
@o_decimales    = @w_num_dec out

while(1=1)begin

   select @w_error=null, @w_o_error=null, @w_msg=null
   
   select top 1
   @w_banco   = ra_banco,   
   @w_cliente = ra_cliente, 
   @w_cuotas  = ra_cuotas
   from ca_reestructuracion_archivo
   where  ra_archivo = @i_param2
   and   ra_banco    > @w_banco
   and   ra_estado   = 'P'
   order by ra_banco asc
   if @@rowcount=0 break
   
   select 
   @w_operacion    = de_operacion,
   @w_fecha_inicio = de_fecha_ini,
   @w_dias_aplaza  = datediff(dd,de_fecha_ini,de_fecha_fin),
   @w_dias_transcu = datediff(dd,de_fecha_ini,@w_fecha_proceso),
   @w_moneda       = op_moneda
   from ca_desplazamiento,
        ca_operacion
   where de_banco     = @w_banco
   and   de_operacion = op_operacion
   and   de_estado    = 'A'
   and   op_estado in (1,2)
   
   
   if not exists(select 1 from cob_cartera..ca_amortizacion where am_operacion = @w_operacion and am_concepto = 'INT_ESPERA')
   begin
      select @w_msg = @w_banco + 'Operacion Sin Rubros Desplazamiento'
      print  @w_msg
      
      goto Siguiente
   end   
   
   select @w_valor_acum = sum(am_acumulado),
          @w_interes    = sum(am_cuota)
   from cob_cartera..ca_amortizacion 
   where am_operacion = @w_operacion 
   and am_concepto = 'INT_ESPERA'
   
   select @w_valor_prov = round((@w_interes * @w_dias_transcu) /@w_dias_aplaza, @w_num_dec)
   select @w_valor_prov = @w_valor_prov - @w_valor_acum
   
   select @w_valor_prov = round((@w_interes * @w_dias_transcu) /@w_dias_aplaza, @w_num_dec)
   select @w_valor_prov = @w_valor_prov - @w_valor_acum
      
 
   if @w_valor_prov <= 0 
   begin
      
      select @w_msg = 'Operacion Devengado: ' + convert(varchar,@w_operacion) + ' @w_valor_prov:' + convert(varchar,@w_valor_prov)
      print @w_msg
      goto Siguiente
   end
   
   print '@w_operacion:' + convert(varchar,@w_operacion) + ' @w_dias_aplaza:'+ convert(varchar,@w_dias_aplaza) + ' @w_dias_transcu: ' + convert(varchar,@w_dias_transcu)
   print '@w_interes:' + convert(varchar,@w_interes) +' @w_valor_prov: ' + convert(varchar,@w_valor_prov) + ' @w_valor_acum:' + convert(varchar,@w_valor_acum)
    
  
   exec  @w_error = sp_calculo_diario_int_des
         @s_user               = 'usrbatch',
         @s_term               = 'CTSSRV',
         @s_date               = @w_fecha_proceso,
         @i_fecha_proceso      = @w_fecha_proceso,
         @i_operacionca        = @w_operacion,
         @i_monto_int          = @w_valor_prov
 
   
   if @w_error!=0 begin
      exec sp_errorlog 
      @i_fecha       = @w_fecha_proceso,
      @i_error       = @w_error, 
      @i_usuario     = 'usrbatch', 
      @i_tran        = 7999,
      @i_tran_name   = @w_sp_name,
      @i_cuenta      = @w_banco,
      @i_rollback    = 'N',
      @i_descripcion = @w_msg
   end
   
   
   Siguiente: 
   if @w_msg is not null
   begin
      exec sp_errorlog 
      @i_fecha       = @w_fecha_proceso,
      @i_error       = @w_error, 
      @i_usuario     = 'usrbatch', 
      @i_tran        = 7999,
      @i_tran_name   = @w_sp_name,
      @i_cuenta      = @w_banco,
      @i_rollback    = 'N',
      @i_descripcion = @w_msg
   
   end
	
end--fin while 


return 0

ERROR_PROCESO:
print'Num error'+ convert(varchar(50),@w_error)
select @w_msg = isnull(@w_msg, 'ERROR GENERAL DEL PROCESO')
exec cobis..sp_cerror
@t_debug = @t_debug,
@t_file  = @t_file, 
@t_from  = @w_sp_name,
@i_num   = @w_error,
@i_msg	= @w_msg
return 1
go

