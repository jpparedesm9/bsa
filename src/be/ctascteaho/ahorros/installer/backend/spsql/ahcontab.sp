/************************************************************************/
/*  Archivo           : ahcontab.sp                                     */
/*  Stored procedure  : sp_ah_generacion_contabilidad                   */
/*  Base de datos     : cob_ahorros                                     */
/*  Producto          : Cuentas de Ahorro                               */
/*  Disenado por      : O. Ligua                                        */
/*  Fecha de escritura: 04-Sep-2003                                     */
/************************************************************************/
/*                              IMPORTANTE                              */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de COBISCorp.                                                       */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como    */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus    */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.   */
/*  Este programa esta protegido por la ley de   derechos de autor      */
/*  y por las    convenciones  internacionales   de  propiedad inte-    */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir        */
/*  penalmente a los autores de cualquier   infraccion.                 */
/************************************************************************/
/*                              PROPOSITO                               */
/*  Este programa realiza la generacion masiva comprobantes contable    */
/************************************************************************/
/*                          MODIFICACIONES                              */
/*  FECHA      AUTOR             RAZON                                  */
/*  04-09-03   O. Ligua          Emisión Inicial                        */
/*  02-05-16   Ignacio Yupa      Migración a CEN                        */
/************************************************************************/

use cob_ahorros
go

if exists (select 1
			from sysobjects
			where name = 'sp_ah_generacion_contabilidad')
	drop proc sp_ah_generacion_contabilidad
go

set ANSI_NULLS off
GO

set QUOTED_IDENTIFIER off
GO

create proc sp_ah_generacion_contabilidad
(
	@t_show_version bit = 0,
	@i_param1       tinyint --Filial
)
as
declare
	@w_return      int,
	@w_sp_name     varchar(30),
	@w_mensaje_err varchar(100)

select @w_sp_name = 'sp_ah_generacion_contabilidad'
  
---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
if @t_show_version = 1
begin
	print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
	return 0
end

exec @w_return = cob_conta..sp_sasiento_val
	@i_operacion = 'V',---(Validaciones)
	@i_empresa   = @i_param1,
	@i_producto  = 4 -- Ahorros
  
if @w_return <> 0
begin
	select @w_mensaje_err = mensaje
		from cobis..cl_errores
		where numero = @w_return

	if @w_mensaje_err = null
		select @w_mensaje_err = ' ERROR: en Validacion Masiva '

	print ' ERROR: en Validacion Masiva '
	exec cobis..sp_cerror
		@i_num = 353016
	return 353016
end

/******************************************************************/
/****       Actualiza registros Errorneos en tabla RE_TOTAL       ***/
/******************************************************************/
begin tran

print '****Inicia Actualizacion Error-Cta.Cte. ****'
	update cob_remesas..re_trn_contable
		set tc_estado = 'ERR',
			tc_mensaje = ec_mensaje,
			tc_comprobante = ec_comprobante
		from cob_ccontable..cco_error_conaut,
			cob_remesas..re_trn_contable
		where  ec_empresa	= @i_param1
		and ec_producto		= 4
		and tc_fecha		= ec_fecha_conta
		and tc_producto		= ec_producto
		and tc_comprobante	= ec_comprobante

if @@error <> 0
begin
	print ' ERROR: No actualizo la tabla re_total Ctacte'
	exec cobis..sp_cerror
		@i_num = 203035
	return 203035
end

commit tran
return 0

go

