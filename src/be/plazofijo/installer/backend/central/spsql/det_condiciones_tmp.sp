/************************************************************************/
/*      Archivo:                dcondtmp.sp                             */
/*      Stored procedure:       sp_det_condiciones_tmp                  */
/*      Base de datos:          cobis                                   */
/*      Producto:               Plazo Fijo                              */
/*      Disenado por:           Myriam Davila / Juan Jose Lam           */
/*      Fecha de documentacion: 19-Nov-1994                             */
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
/*      19-Nov-94  Ricardo Valencia   Creacion                          */
/*      24-Ago-95  Carolina Alvarado  Grabacion # operacion en tabla    */
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

if exists (select 1 from sysobjects where name = 'sp_det_condiciones_tmp')
   drop proc sp_det_condiciones_tmp
go

create proc sp_det_condiciones_tmp (
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
@i_ente                 int             = NULL)
with encryption
as
declare
@w_sp_name              varchar(32),
@w_operacionpf          int,
@w_condicion            tinyint,
@w_ente                 int

select @w_sp_name = 'sp_det_condiciones_tmp'


/**  VERIFICAR CODIGO DE TRANSACCION PARA INSERT  **/
if ( @i_operacion = 'I' ) and ( @t_trn <> 14129 ) or
   ( @i_operacion = 'C' ) and ( @t_trn <> 14129 ) or
   ( @i_operacion = 'U' ) and ( @t_trn <> 14129 ) --endoso 05/22/2000
begin
	/**  ERROR : CODIGO DE TRANSACCION PARA INSERT NO VALIDO  **/
	exec cobis..sp_cerror
		@t_debug = @t_debug,
         	@t_file  = @t_file,
         	@t_from  = @w_sp_name,
         	@i_num   = 141040
      	return 1
end

/**  VERIFICAR CODIGO DE TRANSACCION PARA DELETE  **/
if ( @i_operacion = 'D' ) and ( @t_trn <> 14329 ) or
   ( @i_operacion = 'D' ) and ( @t_trn <> 14329 )   
begin
      /**  ERROR : CODIGO DE TRANSACCION PARA DELETE NO VALIDO  **/
      exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 141039
      return 1
   end

	/**  CONVERSION DEL NUMERO DE CUENTA AL NUMERO DE OPERACION  **/
if @i_operacion = 'I'
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
end

if @i_operacion in ('C','U')
begin
	select	@w_operacionpf = op_operacion
	from	pf_operacion
	where	op_num_banco = @i_cuenta

	if @@rowcount = 0
   	begin
      		exec cobis..sp_cerror
         		@t_debug = @t_debug,
         		@t_file  = @t_file,
         		@t_from  = @w_sp_name,
         		@i_num   = 141051
      		return 1
   	end
end
 
	/**  INSERCION DE DETALLE DE CONDICIONES EN TABLA TEMPORAL  **/
If @i_operacion in ('I','C','U')
begin
	/**  VERIFICAR EXISTENCIA DEL BENEFICIARIO  **/
	if not exists ( select 1 
        	        from	pf_beneficiario_tmp
                	where	bt_operacion = @w_operacionpf
	                and	bt_ente          = @i_ente  )
			and	@i_operacion = 'I'
	begin
	      /**  ERROR : BENEFICIARIO NO EXISTE  **/
	      exec cobis..sp_cerror
        	@t_debug = @t_debug,
	        @t_file  = @t_file,
        	@t_from  = @w_sp_name,
	        @i_num   = 141044
	      return 1
	end
   
	begin tran
	insert pf_det_condicion_tmp 
                (dt_operacion,   dt_condicion, dt_ente,
                 dt_fecha_crea,  dt_fecha_mod, dt_usuario,
                 dt_sesion)
	values (@w_operacionpf, @i_condicion, @i_ente,
                 @s_date,        @s_date,      @s_user,
                 @s_sesn)
  
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
        delete	from pf_det_condicion_tmp
        where	dt_usuario   = @s_user
        and	dt_sesion    = @s_sesn

	commit tran
      	return 0
end         
go 
