/************************************************************************/
/*      Archivo:                detcondfirmas.sp                        */
/*      Stored procedure:       sp_det_cond_firmas_tmp                  */
/*      Base de datos:          cobis                                   */
/*      Producto:               Plazo Fijo                              */
/*      Disenado por:           Ximena Cartagena                        */
/*      Fecha de documentacion: 30-Mar-2005                             */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      'MACOSA', representantes exclusivos para el Ecuador de la       */
/*      'NCR CORPORATION'.                                              */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/*                              PROPOSITO                               */
/*      Este programa procesa las transacciones de INSERT y DELETE      */
/*      a la tabla temporal de detalles de condicion                    */
/*      'pf_det_condicion_tmp'.                                         */
/*                                                                      */
/*                              MODIFICACIONES                          */
/*      FECHA      AUTOR              RAZON                             */
/*      30-Mar-05  Ximena Cartagena   Creacion                          */
/*                                                                      */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'sp_det_cond_firmas_tmp')
   drop proc sp_det_cond_firmas_tmp
go

create proc sp_det_cond_firmas_tmp (
@s_ssn                  int             = NULL,
@s_user                 login           = NULL,
@s_sesn                 int             = NULL,
@s_term                 varchar(30)     = NULL,
@s_date                 datetime        = NULL,
@s_srv                  varchar(30)     = NULL,
@s_lsrv                 varchar(30)     = NULL,
@s_ofi                  smallint        = NULL,
@s_rol                  smallint        = NULL,
@t_debug                char(1)         = 'N',
@t_file                 varchar(10)     = NULL,
@t_from                 varchar(32)     = NULL,
@t_trn                  smallint        = NULL,
@i_operacion            char(1)	      = 'I',
@i_cuenta               cuenta          = NULL,
@i_condicion            tinyint         = NULL,
@i_descondi             char(1)         = NULL,
@i_ente                 int             = NULL)
with encryption
as
declare
@w_sp_name              varchar(32),
@w_operacionpf          int,
@w_condicion            tinyint,
@w_ente                 int

select @w_sp_name = 'sp_det_cond_firmas_tmp'


/**  VERIFICAR CODIGO DE TRANSACCION PARA INSERT  **/
if (@i_operacion = 'I') and ( @t_trn <> 14164 ) or
   (@i_operacion = 'D') and ( @t_trn <> 14347 )
begin
	/**  ERROR : CODIGO DE TRANSACCION PARA INSERT NO VALIDO  **/
	exec cobis..sp_cerror
		@t_debug = @t_debug,
         	@t_file  = @t_file,
         	@t_from  = @w_sp_name,
         	@i_num   = 141040
      	return 1
end


	/**  INSERCION DE DETALLE DE CONDICIONES EN TABLA TEMPORAL  **/
If @i_operacion = 'I'
begin
	select	@w_operacionpf = ot_operacion
	from	pf_operacion_tmp
	where	ot_num_banco = @i_cuenta

	if @@rowcount = 0 
	begin
		exec cobis..sp_cerror
			@t_debug = @t_debug,
         		@t_file  = @t_file,
         		@t_from  = @w_sp_name,
         		@i_num   = 141051
      		return 1
   	end
		
	begin tran

	insert pf_det_condfirmas_tmp
                (di_operacion,	di_condicion,	di_ente,
                 di_fecha_crea,	di_fecha_mod,	di_usuario,
                 di_sesion,	di_descondi)
	values (@w_operacionpf,	@i_condicion,	@i_ente,
		@s_date,	@s_date,	@s_user,
                @s_sesn,	@i_descondi)
  
         /**  VERIFICAR SI SE INSERTO CORRECTAMENTE  **/
	if @@error <> 0
	begin
               /**  ERROR : NO SE PUDO INSERTAR DETALLE DE CONDICION  ***/
               exec cobis..sp_cerror
                  @t_debug = @t_debug,
                  @t_file  = @t_file,
                  @t_from  = @w_sp_name,
                  @i_num   = 143029
               return 1
	end

	commit tran
	return 0
end

	/**  ELIMINACION DE DETALLE DE CONDICIONES  **/

If @i_operacion = 'D'
begin
	begin tran
        /**  ELIMINAR EL DETALLE DE CONDICION  **/
        delete	from pf_det_condfirmas_tmp
        where	di_usuario   = @s_user
        and	di_sesion    = @s_sesn

	commit tran
      	return 0
end         
go
