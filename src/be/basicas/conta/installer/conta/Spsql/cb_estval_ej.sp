/************************************************************************/
/*   Archivo:             cb_estval_ej.sp                               */
/*   Stored procedure:    sp_est_val_conta_ej                           */
/*   Base de datos:       cob_conta                                     */
/*   Producto:            Contabilidad                                  */
/*   Disenado por:        Raul Altamirano Mendez                        */
/*   Fecha de escritura:  Octubre.2017                                  */
/************************************************************************/
/*                              IMPORTANTE                              */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'COBIS'.                                                           */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de 'COBIS' o su representante.               */
/************************************************************************/
/*                              PROPOSITO                               */
/************************************************************************/
/*                               MODIFICACIONES                         */
/*  FECHA              AUTOR          CAMBIO                            */
/************************************************************************/

use cob_conta
go

if exists (select 1 from sysobjects where name = 'sp_est_val_conta_ej')
   drop proc sp_est_val_conta_ej
go

create proc sp_est_val_conta_ej

as 
declare	
@w_error			int,
@w_return			int,
@w_mensaje          varchar(150),
@w_fecha_proceso	datetime,
@w_sp_name			varchar(30),
@w_msg              varchar(255)


select @w_sp_name = 'sp_est_val_conta_ej'

select @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso


select @w_mensaje = 'Actualizacion de Estadisticas Comprobantes'

UPDATE STATISTICS cob_conta_tercero..ct_scomprobante_tmp

if @@error != 0
begin
   select @w_error = @@error
   goto ERROR_PROCESO
end

select @w_mensaje = 'Actualizacion de Estadisticas Asientos'

UPDATE STATISTICS cob_conta_tercero..ct_sasiento_tmp

if @@error != 0
begin
   select @w_error = @@error
   goto ERROR_PROCESO
end


return 0

ERROR_PROCESO:

select @w_msg = mensaje
from  cobis..cl_errores with (nolock)
where numero = @w_error
set transaction isolation level read uncommitted

select @w_msg = isnull(@w_msg, @w_mensaje)

exec @w_return       = cob_conta_super..sp_errorlog
     @i_operacion    = 'I',
     @i_fecha_fin    = @w_fecha_proceso,
     @i_origen_error = @w_error,
     @i_fuente       = @w_sp_name,
     @i_descrp_error = @w_msg

return @w_error

go

