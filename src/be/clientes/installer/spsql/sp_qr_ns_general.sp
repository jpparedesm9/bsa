/************************************************************************/
/*  Archivo:                sp_qr_ns_general.sp                         */
/*  Stored procedure:       sp_qr_ns_general                            */
/*  Base de Datos:          cobis                                       */
/*  Producto:               Credito                                     */
/*  Disenado por:           P. Ortiz                                    */
/*  Fecha de Documentacion: 04/Sep/2017                                 */
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
/* Procedure que permite consultar el estado de una notificación        */
/* general y actualizarlo                                               */
/************************************************************************/
/*          MODIFICACIONES                                              */
/*  FECHA       AUTOR                   RAZON                           */
/*  23/Ago/2017 P. Ortiz             Emision Inicial                    */
/* **********************************************************************/

USE cobis
GO


IF OBJECT_ID ('dbo.sp_qr_ns_general') IS NOT NULL
	DROP PROCEDURE dbo.sp_qr_ns_general
GO

create proc sp_qr_ns_general (	
	@i_operacion		char(1),
	@i_codigo 			int 	= null,
	@i_estado			char(1) = null
)
AS


--Consulta
if @i_operacion = 'Q'
begin
	
	select nge_codigo
	  from cl_ns_generales_estado
	 where nge_estado = 'P' --Pendiente
	 
	 update cl_ns_generales_estado
	   set nge_estado 	= 'E' --En Proceso
	 where nge_estado 	= 'P'
     
	if @@rowcount = 0
	begin 
		return 1
	end

end

--Actualiza estado
if @i_operacion = 'U'
begin
	update cl_ns_generales_estado
	   set nge_estado 	= @i_estado
	 where nge_codigo 	= @i_codigo
 
end
return 0


GO

