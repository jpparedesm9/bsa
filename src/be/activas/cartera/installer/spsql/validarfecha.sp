/************************************************************************/
/*   Archivo:                 validarfecha.sp                         */
/*   Stored procedure:        sp_validar_fecha            */
/*   Base de Datos:           cob_cartera                               */
/*   Producto:                Cartera                                   */
/*   Disenado por:            Yecid  Martinez                           */
/*   Fecha de Documentacion:  Sep. 2010                                 */
/************************************************************************/
/*                               IMPORTANTE                             */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'MACOSA'.                                                          */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier autorizacion o agregado hecho por alguno de sus          */
/*   usuario sin el debido consentimiento por escrito de la             */
/*   Presidencia Ejecutiva de MACOSA o su representante                 */
/************************************************************************/
/*                                PROPOSITO                             */
/*   Ejecutar fecha valor en baja intensidad segun esquema 7x24	        */
/************************************************************************/

use cob_cartera
go

if exists(select 1 from sysobjects where name = 'sp_validar_fecha')
   drop proc sp_validar_fecha
go

create proc sp_validar_fecha
   @s_user                  varchar(14),
   @s_term                  varchar(30),
   @s_date                  datetime,
   @s_ofi                   smallint,
   @i_operacionca           int,
   @i_debug                 char(1)   = 'N' 
as
declare
   @w_sp_name        varchar(32),
   @w_fecha_ult_proceso     datetime,
   @w_banco                 char(24),
   @w_error                 int,
   @w_msg                   varchar(134),
   @w_fecha_proceso         datetime,
   @w_op_estado             int

-- FECHA DE CIERRE
select 
@w_fecha_proceso   = convert(varchar(10),fc_fecha_cierre,101)
from   cobis..ba_fecha_cierre with (nolock)
where  fc_producto = 7
   
-- CAPTURA NOMBRE DE STORED PROCEDURE
select @w_sp_name = 'sp_validar_fecha'
select @w_op_estado = 0


if @i_debug = 'S' print 'Ejecutando sp: ' + @w_sp_name +  ' @w_fecha_proceso: ' + cast(@w_fecha_proceso as varchar)


-- CONSULTO MAESTRO      
select  
@w_fecha_ult_proceso = convert(varchar(10),op_fecha_ult_proceso,101),
@w_banco             = op_banco,
@w_op_estado         = isnull(op_estado,0)
from ca_operacion,
     ca_estado
where op_operacion = @i_operacionca
and   op_estado    = es_codigo 
and   es_procesa   = 'S'

if @@rowcount <= 0 or @w_op_estado = 0
  return 0

if @i_debug = 'S' print 'Ejecutando sp: ' + @w_sp_name +  ' @w_fecha_ult_proceso: ' + cast(@w_fecha_ult_proceso as varchar)


-- EJECUTO FECHA VALOR SOLO SI LA OPERACION TIENE FECHA VALOR HACIA ADELANTE
if DATEDIFF(dd,@w_fecha_proceso ,@w_fecha_ult_proceso) <> 0 begin

   if not exists ( select  1
                   from    ca_en_fecha_valor
                   where   bi_operacion = @i_operacionca) begin      		
   
      exec @w_error = sp_fecha_valor 
      @s_date              = @s_date,
      @s_user              = @s_user,
      @s_term              = @s_term,
      @i_fecha_valor       = @w_fecha_proceso,
      @i_banco             = @w_banco,
      @i_operacion         = 'F',
      @i_observacion       = 'fecha valor baja intensidad', 
      @i_observacion_corto = 'Recaudo', 
      @i_en_linea          = 'N'
      
      if @w_error != 0 
           return @w_error

      if @i_debug = 'S' print 'Ejecutando sp: ' + @w_sp_name +  ' @i_operacionca: ' + cast(@i_operacionca as  varchar)

   end
end


set rowcount 0

return 0

go
   
   
   
