/************************************************************************/
/*  Archivo:                sp_qr_ns_rechaza_lcr.sp                     */
/*  Stored procedure:       sp_qr_ns_rechaza_lcr                        */
/*  Base de Datos:          cobis                                       */
/*  Producto:               Clientes                                    */
/*  Disenado por:           P. Ortiz                                    */
/*  Fecha de Documentacion: 04/Jun/2017                                 */
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
/* de alertas de riesgo, además permite insertarlas                     */
/************************************************************************/
/*          MODIFICACIONES                                              */
/*  FECHA       AUTOR                   RAZON                           */
/*04/Jun/2018  P. Ortiz              Emision Inicial                    */
/* **********************************************************************/

USE cob_credito
GO


IF OBJECT_ID ('dbo.sp_qr_ns_rechaza_lcr') IS NOT NULL
	DROP PROCEDURE dbo.sp_qr_ns_rechaza_lcr
GO

create proc sp_qr_ns_rechaza_lcr (	
	@i_operacion		char(1),
	@i_tramite 			int 	= null,
	@i_estado			char(1) = null
)
AS
declare
    @w_sp_name          varchar(20),
    @w_num_error        int,
    @w_codigo           int,
    @w_oficial          int,
    @w_correo           varchar(64),
    @w_id_alerta        int,
    @w_tipo_alerta      varchar(2),
    @w_alertas          varchar(100),
    @w_fecha_proceso    datetime,  
    @w_nombre_completo  varchar(255)
       
select @w_sp_name = 'sp_qr_ns_rechaza_lcr'

--Insercion
if @i_operacion = 'S'
begin
    
    SELECT  nl_tramite,
			convert(varchar(10),nl_fecha_reg,103),
			nl_cliente,
			nl_nombre           ,
			nl_apellido_paterno ,
			nl_apellido_materno ,
			nl_correo           ,
			nl_observaciones    ,
			nl_estado           
    FROM cob_credito..cr_ns_rechaza_lcr
    WHERE nl_tramite = @i_tramite
    
end

--Consulta
if @i_operacion = 'Q'
begin
	
	select nl_tramite,
		   nl_cliente
	  from cr_ns_rechaza_lcr
	 where nl_estado = 'P' --Pendiente
	 
	 update cr_ns_rechaza_lcr
	   set nl_estado 	= 'E' --En Proceso
	 where nl_estado 	= 'P'
     
	if @@rowcount = 0
	begin 
		return 1
	end

end

--Actualiza estado
if @i_operacion = 'U'
begin
	update cr_ns_rechaza_lcr
	   set nl_estado 		= @i_estado
	 where nl_tramite 		= @i_tramite
 
end


--Control errores
errores:
   exec cobis..sp_cerror
        @t_debug = 'N',
        @t_file  = null,
        @t_from  = @w_sp_name,
        @i_num   = @w_num_error
   return @w_num_error
fin:
   return 0


go

