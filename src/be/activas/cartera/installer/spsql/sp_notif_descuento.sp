/************************************************************************/
/*  Archivo:                sp_qr_ns_notif_descuento.sp                       */
/*  Stored procedure:       sp_qr_ns_notif_descuento                          */
/*  Base de Datos:          cob_cartera                                 */
/*  Producto:               Cartera                                     */
/*  Disenado por:           PRO                                         */
/*  Fecha de Documentacion: 21/Jul/2019                                 */
/************************************************************************/
/*                           IMPORTANTE                                 */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'MACOSA'.                                                          */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de MACOSA o su representante.                */
/************************************************************************/
/*          				PROPOSITO                                   */
/* Este procedimiento consulta los datos de operaciones a notificar	'S'	*/
/* Procesa la notificacion al presidente del grupo						*/
/*                                                                      */
/*                         MODIFICACIONES                               */
/*  FECHA              AUTOR            RAZON                           */
/* 21/Jul/2019       PRO             	Emision Inicial                 */
/* 11/Feb/2021       ACH             	Caso #153921, estado integrante */
/************************************************************************/

use cob_cartera
go

if exists(select 1 from sysobjects where name ='sp_qr_ns_notif_descuento')
	drop proc sp_qr_ns_notif_descuento
go

create proc [dbo].[sp_qr_ns_notif_descuento](		
	@i_opcion			char(1)			= 'S',	
	@i_operacion_padre	int				= null
)
as
declare 
@w_sp_name       		varchar(32),
@w_grupo				int,
@w_presidente			int,
@w_mail_to				varchar(50),
@w_body 				varchar(255),
@w_error 				int,
@w_monto				money,
@w_tasa_op				float,
@w_nombre				varchar(50),
@w_apellido				varchar(50),
@w_nombre_grupo			varchar(30)


if(@i_opcion = 'S')
begin
	select 	en_nombre,
			p_p_apellido,
			dd_monto
	from cobis..cl_ente,
		cob_cartera..ca_devolucion_descuento
	where 	dd_ente				= en_ente
	and 	dd_operacion_padre  = @i_operacion_padre	
end

if(@i_opcion = 'Q')
begin
	select 	dd_operacion,			
			(select gr_nombre from cobis..cl_grupo where gr_grupo = dd_grupo),
			(select top 1 di_descripcion from cobis..cl_direccion where di_ente in (select cg_ente
																					from cobis..cl_cliente_grupo
																					where cg_grupo = dd_grupo
																					and cg_rol = 'P' and cg_estado = 'V') and di_tipo='CE')-- Cs#153921
	from cob_cartera..ca_devolucion_descuento
	where dd_estado_notifica	= 'I'
	and dd_estado_pago 			= 'P'
	and dd_tipo					= 'P'
end

if(@i_opcion = 'U')
begin	
	update cob_cartera..ca_devolucion_descuento
	set dd_estado_notifica = 'P'
	where dd_operacion_padre = @i_operacion_padre
	
	update cob_cartera..ca_devolucion_descuento
	set dd_estado_notifica = 'P'
	where dd_operacion = @i_operacion_padre
	
end

return 0
go
