/************************************************************************/
/*   Archivo:              camopex.sp                                   */
/*   Stored procedure:     sp_cambio_estado_op_ext                      */
/*   Base de datos:        cob_cartera                                  */
/*   Producto:             Credito y Cartera                            */
/*   Disenado por:         Fabian de la Torre                           */
/*   Fecha de escritura:   12/09/1996                                   */
/************************************************************************/
/*                               IMPORTANTE                             */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'MACOSA'                                                           */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de MACOSA o su representante.                */
/************************************************************************/
/*                                PROPOSITO                             */
/*   Maneja los cambios de estado de las operaciones: invocado desde FE */
/************************************************************************/
/*                              CAMBIOS                                 */
/*      FECHA          AUTOR            CAMBIO                          */
/*      DIC-07-2016    Raul Altamirano  Emision Inicial - Version MX    */
/************************************************************************/

use cob_cartera
go

if exists (select 1 from sysobjects where name = 'sp_cambio_estado_op_ext')
   drop proc sp_cambio_estado_op_ext
go

create proc sp_cambio_estado_op_ext
(  @s_user        varchar(14),
   @s_term        varchar(30),
   @s_date        datetime,
   @s_ofi         smallint,
   @s_ssn         int      = null,
   @s_sesn        int    = null,
   @s_srv         varchar(30) = null,
   @s_lsrv        varchar(30) = null,
   @s_rol         smallint = null,
   @s_org         char(1) = null,
   @i_banco       cuenta,
   @i_estado_fin  descripcion --solo para tipo de cambio manual
)

as declare 
   @w_sp_name           descripcion,
   @w_error             int,
   @w_operacionca       int,
   @w_estado_ini        int,
   @w_estado_fin        int,
   @w_est_anulado       int,
   @w_tipo_cambio       char(1),
   @w_tramite           int,
   @w_tipo_tramite      char(1)


--CARGAR VARIABLES DE TRABAJO
select @w_sp_name        = 'sp_cambio_estado_op_ext',
       @w_tipo_cambio    = 'M'

	   
exec @w_error  = sp_estados_cca
@o_est_anulado = @w_est_anulado out	   


select @w_operacionca      = op_operacion,
       @w_estado_ini       = op_estado,
	   @w_tramite          = isnull(op_tramite, 0)
from   ca_operacion
where  op_banco = @i_banco


begin tran


select @w_estado_fin = es_codigo
from   ca_estado
where  es_descripcion = @i_estado_fin


exec @w_error = sp_cambio_estado_op
	@s_user          = @s_user,
	@s_term          = @s_term,
	@s_date          = @s_date,
	@s_ofi           = @s_ofi,
	@i_banco         = @i_banco,
	@i_fecha_proceso = @s_date,
	@i_estado_ini    = @w_estado_ini,
	@i_estado_fin    = @w_estado_fin,
	@i_tipo_cambio   = @w_tipo_cambio,
	@i_front_end     = 'S',
	@i_en_linea      = 'S'

if @w_error != 0
begin
  select @w_error = @w_error
  goto ERROR
end


select @w_estado_fin = op_estado
from   ca_operacion
where  op_operacion = @w_operacionca

if @@rowcount = 0
begin
   select @w_error = 701025
   goto ERROR
end


if @w_estado_fin = @w_est_anulado 
begin 
   if @w_tramite <> 0
   begin
      select @w_tipo_tramite = tr_tipo
      from   cob_credito..cr_tramite
      where  tr_tramite = @w_tramite
      
      exec @w_error = cob_credito..sp_rechazo
           @s_ofi       = @s_ofi,
           @s_ssn       = @s_ssn,
           @s_user      = @s_user,
           @s_term      = @s_term,
           @s_date      = @s_date,
           @i_tramite   = @w_tramite,
           @i_tipo_tramite = @w_tipo_tramite,
           @i_producto  = 'CCA',
           @i_tipo_causal = 'X'
       
      if @w_error != 0
      begin
         select @w_error = @w_error
         goto ERROR
      end

      if exists (select 1 from cob_credito..cr_op_renovar
                 where or_tramite = @w_tramite)
      begin
         update cob_credito..cr_op_renovar
         set   or_finalizo_renovacion = 'Z'
         where or_tramite = @w_tramite
		 
         if @@error != 0
         begin
           select @w_error = 705075
           goto ERROR
         end		 
		 
      end
   end
end


commit tran

return 0

ERROR:
   rollback tran
   exec cobis..sp_cerror
        @t_debug  = 'N',
        @t_file   = null,
        @t_from   = @w_sp_name,
        @i_num    = @w_error
   
   return @w_error

go
