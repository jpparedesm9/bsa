/************************************************************************/
/*   Stored procedure:     sp_errorlog                                  */
/*   Base de datos:        cob_ahorros                                  */
/************************************************************************/
/*                                  IMPORTANTE                          */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'COBISCorp'                                                        */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de COBISCorp o su representante.             */
/************************************************************************/
/*                            PROPOSITO                                 */
/************************************************************************/
 
use cob_ahorros
go
 
if exists (select 1 from sysobjects where name = 'sp_errorlog')
   drop proc sp_errorlog
go
 
create proc sp_errorlog (
@i_fecha        datetime     =  null,
@i_error        int,
@i_usuario      login,
@i_tran         int,
@i_cuenta       varchar(24)  =  null,
@i_descripcion  mensaje      =  null,
@i_cta_pagrec   varchar(24)  =  null,
@i_programa     varchar(24)  = null,
@i_rollback     char(1)      = 'N'
)
as
declare @w_aux                  int,        
        @w_err_msg              varchar(255)

select @w_aux = @@trancount

if @i_rollback = 'S'
   while @@trancount > 0 rollback
   
if @i_descripcion is null
   select @i_descripcion = mensaje
   from cobis..cl_errores with (nolock)
   where numero = @i_error 
   set transaction isolation level read uncommitted   
   
insert ah_errorlog (er_fecha_proc, er_error, er_usuario, er_tran, er_cuenta, er_descripcion, er_cta_pagrec, er_programa)
            values (@i_fecha     , @i_error, @i_usuario, @i_tran, @i_cuenta, @i_descripcion, @i_cta_pagrec, @i_programa)

if @i_rollback = 'S'                    
   while @@trancount < @w_aux begin tran

return 0
go
 