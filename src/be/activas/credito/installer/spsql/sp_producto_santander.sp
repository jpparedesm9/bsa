/************************************************************************/
/*  Archivo:                sp_producto_santander.sp                    */
/*  Stored procedure:       sp_producto_santander                       */
/*  Base de Datos:          cob_credito                                 */
/*  Producto:               Credito                                     */
/*  Disenado por:           Nelson Trujillo                             */
/*  Fecha de Documentacion: 10/MAY/2018                                 */
/************************************************************************/
/*          IMPORTANTE                                                  */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  "MACOSA",representantes exclusivos para el Ecuador de la            */
/*  AT&T                                                                */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier autorizacion o agregado hecho por alguno de sus           */
/*  usuario sin el debido consentimiento por escrito de la              */
/*  Presidencia Ejecutiva de MACOSA o su representante                  */
/************************************************************************/
/*          PROPOSITO                                                   */
/*    Operacion I Realiza registro de producto Santander                */
/*    Operacion D elimina productos registrados Santander               */
/*                                                                      */
/************************************************************************/
/*          MODIFICACIONES                                              */
/*  FECHA       AUTOR                   RAZON                           */
/* 10/MAY/2018	ntrujillo           Emisión inicial                     */
/* **********************************************************************/
USE cob_credito
GO

if exists(select 1 from sysobjects where name ='sp_producto_santander')
	drop proc sp_producto_santander
GO


CREATE proc sp_producto_santander
	@s_ssn int 									= null,
	@s_user login 								= null,
	@s_sesn int 								= null,
	@s_term varchar(30) 						= null,
	@s_date datetime 							= null,
	@s_srv varchar(30) 							= null,
	@s_lsrv varchar(30) 						= null,
	@s_ofi smallint 							= null,
	@s_servicio int 							= null,
	@s_cliente int 								= null,
	@s_rol smallint 							= null,
	@s_culture varchar(10) 						= null,
	@s_org char(1) 								= null, 
	@t_rty char(1) 								= null,
    @t_trn smallint 							= null,
    @t_debug char(1) 							= 'N',
    @t_file varchar(14) 						= null,
    @t_from varchar(30) 						= null,
    @t_show_version bit 						= 0,	
	@i_buc varchar(8)							= null,
	@i_codigo_producto varchar(2)				= null,
	@i_codigo_subproducto varchar(4) 			= null,
	@i_estado char(1)							= null,
	@i_codigo_moneda varchar(3)					= null,	
	@i_numero_contrato varchar(50)				= null,
	@i_ente int,		
	@i_operacion char(1)
AS
BEGIN
	DECLARE @w_sp_name varchar(50),
			@w_message varchar(250)
	
	 set @w_sp_name = 'sp_producto_santander'

  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '1.0.0.0'
    return 0
  end

	IF @i_operacion = 'I' 
	BEGIN
	
		insert into cobis..cl_producto_santander (pr_ente, 
													pr_buc, 
													pr_numero_contrato, 
													pr_codigo_producto, 
													pr_codigo_subproducto, 
													pr_estado, 
													pr_codigo_moneda, 
													pr_fecha_consulta)
											values (@i_ente, 
											@i_buc, 
											@i_numero_contrato, 
											@i_codigo_producto, 
											@i_codigo_subproducto, 
											@i_estado, 
											@i_codigo_moneda, 
											getDate())
		
	
		IF @@ERROR <> 0
		BEGIN
			SET @w_message = 'Error al insertar cuenta'
			GOTO ERROR
		END
		
	END
	
	IF @i_operacion = 'D' 
	BEGIN
		
			
		delete from cobis..cl_producto_santander
		where pr_ente = @i_ente
				
	
		IF @@ERROR <> 0
		BEGIN
			SET @w_message = 'Error al eliminar cuentas'
			GOTO ERROR
		END
		
	END


	RETURN 0

	ERROR:
		EXEC cobis..sp_cerror
			@t_from  = @w_sp_name,
			@i_num   = 999,
			@i_msg   = @w_message
		RETURN 1

END
GO

