/************************************************************************/
/*  Archivo:                sp_qr_ns_traspaso.sp                        */
/*  Stored procedure:       sp_qr_ns_traspaso                           */
/*  Base de Datos:          cobis                                       */
/*  Producto:               Clientes                                    */
/*  Disenado por:           P. Ortiz                                    */
/*  Fecha de Documentacion: 09/Ago/2018                                 */
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
/* de traspasos, además permite insertarlas para su envio               */
/************************************************************************/
/*          MODIFICACIONES                                              */
/*  FECHA       AUTOR                   RAZON                           */
/*09/Agi/2018  P. Ortiz              Emision Inicial                    */
/* **********************************************************************/

USE cobis
GO


IF OBJECT_ID ('dbo.sp_qr_ns_traspaso') IS NOT NULL
	DROP PROCEDURE dbo.sp_qr_ns_traspaso
GO

create proc sp_qr_ns_traspaso (	
	@i_operacion		char(1),
	@i_codigo 			int 	= null,
	@i_estado			char(1) = null,
	@i_solicitud		int     = null
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
    @w_nombre_completo  varchar(255),
    @w_nombre_niega     varchar(255),
    @w_entes            varchar(255) = ''
       
select @w_sp_name = 'sp_qr_ns_traspaso'

--Consulta
if @i_operacion = 'S'
begin
    
	select @w_entes = @w_entes + convert(varchar,cs_ente) + '; '
    from cobis..cl_solicitud_traspaso, cl_cli_sol_traspaso
    where st_solicitud = cs_solicitud
    and st_solicitud = @i_solicitud
    
    select @w_entes = substring(@w_entes,0,len(@w_entes))
    
	select distinct nt_codigo,
			st_solicitud,
			isnull(fu_nombre, ''),
            isnull(@w_entes, ''),
            'esGrupo' = (case st_es_grupo when 'S' then 'Grupo' else 'Prospecto/Cliente' end),
            isnull(st_razon_rechazo,''),
            isnull((select fu_nombre from cobis..cl_funcionario where fu_funcionario  = nt_oficial_niega), ''),
            nt_correo,
            convert(varchar(10),fp_fecha,103)
    from cobis..cl_ns_traspaso, cobis..cl_solicitud_traspaso, cl_cli_sol_traspaso,
    		cobis..cl_funcionario, cobis..cc_oficial,cobis..ba_fecha_proceso
    where st_solicitud = cs_solicitud
    and nt_traspaso_id = st_solicitud
    and oc_oficial = oc_funcionario
    and fu_login  = st_usuario
    and st_solicitud = @i_solicitud
    and nt_codigo = @i_codigo
    
end

--Consulta
if @i_operacion = 'Q'
begin
	
	select nt_codigo,
		   nt_traspaso_id
	  from cl_ns_traspaso
	 where nt_estado = 'P' --Pendiente
	 
	 update cl_ns_traspaso
	   set nt_estado 	= 'E' --En Proceso
	 where nt_estado 	= 'P'
     
	if @@rowcount = 0
	begin 
		return 1
	end

end

--Actualiza estado
if @i_operacion = 'U'
begin
	update cl_ns_traspaso
	   set nt_estado 		= @i_estado
	 where nt_codigo 		= @i_codigo
 
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

