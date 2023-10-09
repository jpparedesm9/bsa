/*************************************************************************/
/*   Archivo:              sp_cambio_fecha_fut.sp                        */
/*   Stored procedure:     sp_cambio_fecha_fut.sp            	    	 */
/*   Base de datos:        cob_cartera		                             */
/*   Producto:             clientes                                  	 */
/*   Disenado por:         ACH                                           */
/*   Fecha de escritura:   Enero 2023                                    */
/*************************************************************************/
/*                              IMPORTANTE                               */
/*   Este programa es parte de los paquetes bancarios propiedad de       */
/*   'COBIS'.                                                            */
/*   Su uso no autorizado queda expresamente prohibido asi como          */
/*   cualquier alteracion o agregado hecho por alguno de sus             */
/*   usuarios sin el debido consentimiento por escrito de la             */
/*   Presidencia Ejecutiva de COBIS o su representante legal.            */
/*************************************************************************/
/*                               PROPOSITO                               */
/* ERR#200870 Lote 12 Cartera - Operaciones a futuro. Val. Prod. bancario*/
/*************************************************************************/
/*                             MODIFICACION                              */
/*    FECHA        AUTOR        RAZON                                    */
/*  01/03/2023     D.Cumbal     Ajuste Proceso eliminacion               */
/*************************************************************************/
use cob_cartera
go

if exists(select 1 from sysobjects where name = 'sp_cambio_fecha_fut')
    drop proc sp_cambio_fecha_fut
go

create proc sp_cambio_fecha_fut (
   @i_param1 datetime
)
as
declare 
@w_sp_name				   varchar(100),
@w_operacion_real          int, 
@w_operacion_ficticia      int,
@w_fecha_proceso           datetime,
----
@w_error                   int,
@w_msg                     varchar(256),
@i_fecha_proceso           datetime

select @w_sp_name = 'sp_cambio_fecha_fut'

if @i_param1 is null 
    select @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso
else
    select @w_fecha_proceso = @i_param1

--select @w_fecha_proceso = dateadd(dd, 1, @w_fecha_proceso)

truncate table ca_operacion_proy

select cliente_f = op_cliente,
       operacion_ficticia = op_operacion
into #operacion_ficticia
from ca_operacion
where op_fecha_ult_proceso >= @w_fecha_proceso
and op_toperacion = 'REVOLVENTE' 
and op_operacion < 0

select cliente_r = op_cliente,
       operacion_real = max(op_operacion)
into #operacion_real
from ca_operacion, #operacion_ficticia
where op_cliente = cliente_f
and op_toperacion = 'REVOLVENTE'
and op_operacion > 0
group by op_cliente

insert into ca_operacion_proy
select operacion_real,
       operacion_ficticia
from #operacion_ficticia, #operacion_real
where cliente_f = cliente_r

select op_operacion_real, op_ficticia
into #operaciones_procesar     
from ca_operacion_proy

select @w_operacion_real = 0
while 1=1
begin    
    select top 1
    @w_operacion_real  = op_operacion_real
    from #operaciones_procesar
    order by op_operacion_real asc
    
    if @@rowcount = 0
    break
        
    exec cob_cartera..sp_copia_ficticia
    @i_operacion          = 'D',
    @i_operacionca        = @w_operacion_real,
    @o_operacion_ficticia = @w_operacion_ficticia out
    
    delete from #operaciones_procesar where op_operacion_real = @w_operacion_real		
end
print 'Fin ' +  @w_sp_name

return 0

ERROR:

exec sp_errorlog 
@i_fecha     = @w_fecha_proceso,
@i_error     = @w_error, 
@i_usuario   = 'sa', 
@i_tran      = 7999,
@i_tran_name = @w_sp_name,
@i_cuenta    = 'Masivo',
@i_anexo     = @w_msg,
@i_rollback  = 'S'

return @w_error
go
