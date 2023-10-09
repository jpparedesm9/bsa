/************************************************************************/
/*   Archivo:             cb_solre_ej.sp                                */
/*   Stored procedure:    sp_gen_sol_rep_ej                             */
/*   Base de datos:       cob_conta                                     */
/*   Producto:            Contabilidad                                  */
/*   Disenado por:        Raul Altamirano Mendez                        */
/*   Fecha de escritura:  Septiembre.2017.                              */
/************************************************************************/
/*                              IMPORTANTE                              */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'MACOSA'.                                                          */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de MACOSA o su representante.                */
/************************************************************************/
/*                              PROPOSITO                               */
/************************************************************************/
/*                               MODIFICACIONES                         */
/*  FECHA              AUTOR          CAMBIO                            */
/************************************************************************/

use cob_conta
go

if exists (select 1 from sysobjects where name = 'sp_gen_sol_rep_ej')
   drop proc sp_gen_sol_rep_ej
go

create proc sp_gen_sol_rep_ej
(
	@i_param1       datetime    = null
)
as 
declare	
@w_error			int,
@w_return			int,
@w_mensaje          varchar(150),
@w_fecha_proceso	datetime,
@w_sp_name			varchar(30),
@w_msg              varchar(255) 

select @w_sp_name = 'sp_gen_sol_rep_ej'

select @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso


truncate table cb_solicitud_reportes_reg

if @@error != 0
begin
   select @w_error = 609316
   goto ERROR_PROCESO
end


insert into cb_solicitud_reportes_reg
(
 sr_fecha, 
 sr_reporte, 
 sr_mes, 
 sr_anio, 
 sr_status)
select 
 @w_fecha_proceso, 
 lr_reporte, 
 datepart(MM, @i_param1), 
 datepart(YYYY, @i_param1), 
 'I' 
from  cb_listado_reportes_reg
where lr_estado = 'V'

if @@error != 0
begin
   select @w_error = 609317
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

