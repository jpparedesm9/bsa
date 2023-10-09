/************************************************************************/
/*      Archivo:                cr_errbat.sp                            */
/*      Stored procedure:       sp_error_batch                          */
/*      Base de datos:          cob_credito                             */
/*      Producto:               Credito                                 */
/*      Disenado por:           Juan Jose Lam                           */
/*      Fecha de documentacion: 24/Oct/94                               */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      "MACOSA".							*/
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/************************************************************************/  
/*                              PROPOSITO                               */
/*      Este script crea los procedimientos para las inserciones        */
/*      de errores generados por los procesos diarios del batch         */
/*                                                                      */
/************************************************************************/  
/*                              MODIFICACIONES                          */
/*      FECHA      AUTOR              RAZON                             */
/*      24-Oct-94  Juan Lam           Creacion                          */
/*                                                                      */
/************************************************************************/

use cob_credito
go

if exists (select name from sysobjects where id = object_id('sp_error_batch'))
	drop proc sp_error_batch
go
create proc sp_error_batch
        @i_fecha                datetime,
        @i_error                int,
        @i_programa             varchar(32),
        @i_producto             tinyint = null,
        @i_operacion            cuenta = null, 
        @i_descripcion          varchar(200) = null        
as
declare 
@w_aux         int,
@w_err_msg     varchar(200)


select @w_aux = @@trancount

while @@trancount > 0 rollback

select @w_err_msg = mensaje
  from cobis..cl_errores
 where numero = @i_error 

select @w_err_msg     = isnull(@i_descripcion,@w_err_msg)

insert into cr_errorlog (
			er_fecha_proc,		er_error,			er_usuario, 
			er_tran,			er_cuenta,			er_descripcion )
values (	@i_fecha,			@i_error,			'batch',
			@i_producto,		@i_operacion,		@w_err_msg     )	
/*
insert into cr_errores_sib (
			es_programa,		es_descripcion,		es_error, 
			es_producto,		es_operacion,		es_fecha)
values	 (  @i_programa,		@w_err_msg,			@i_error, 
			@i_producto,		@i_operacion,		@i_fecha)
*/

while @@trancount < @w_aux begin tran

return
go