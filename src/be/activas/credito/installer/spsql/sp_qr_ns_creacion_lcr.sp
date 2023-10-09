/************************************************************************/
/*  Archivo:                sp_qr_ns_creacion_lcr.sp                    */
/*  Stored procedure:       sp_qr_ns_creacion_lcr                       */
/*  Base de Datos:          cob_credito                                 */
/*  Producto:               Credito                                     */
/*  Disenado por:           E. Báez                                     */
/*  Fecha de Documentacion: 16/Nov/2017                                 */
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
/*  Envio de notificaciones para creacion de LCR                        */
/************************************************************************/
/*          MODIFICACIONES                                              */
/*  FECHA         AUTOR                   RAZON                         */
/* 16/Nov/2018   E. Báez              Emision Inicial                   */
/* **********************************************************************/

use cob_credito
go

if exists(select 1 from sysobjects where name ='sp_qr_ns_creacion_lcr')
	drop proc sp_qr_ns_creacion_lcr
GO

create proc sp_qr_ns_creacion_lcr (	
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
       
select @w_sp_name = 'sp_qr_ns_creacion_lcr'

--Insercion
if @i_operacion = 'S'
begin
    
    SELECT  nc_tramite,
			convert(varchar(10),nc_fecha_reg,103) as nc_fecha_reg,
			nc_cliente,
			isnull(nc_nombre, '') ,
			isnull(nc_apellido_paterno, '') ,
			isnull(nc_apellido_materno, '') ,
			nc_correo    ,
            isnull(nc_digito, '') ,
			nc_estado           
    FROM cob_credito..cr_ns_creacion_lcr
    WHERE nc_tramite = @i_tramite

end

--Consulta
if @i_operacion = 'Q'
begin
	
	select nc_tramite,
		   nc_cliente
	  from cob_credito..cr_ns_creacion_lcr
	 where nc_estado = 'P' --Pendiente
	 
	 update cob_credito..cr_ns_creacion_lcr
	   set nc_estado 	= 'E' --En Proceso
	 where nc_estado 	= 'P'
     
	if @@rowcount = 0
	begin 
		return 1
	end

end

--Actualiza estado
if @i_operacion = 'U'
begin
	update cob_credito..cr_ns_creacion_lcr
	   set nc_estado 		= @i_estado
	 where nc_tramite 		= @i_tramite
 
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

