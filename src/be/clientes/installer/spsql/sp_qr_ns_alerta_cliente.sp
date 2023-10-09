/************************************************************************/
/*  Archivo:                sp_qr_ns_alerta_cliente.sp                  */
/*  Stored procedure:       sp_qr_ns_alerta_cliente                     */
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

USE cobis
GO


IF OBJECT_ID ('dbo.sp_qr_ns_alerta_cliente') IS NOT NULL
	DROP PROCEDURE dbo.sp_qr_ns_alerta_cliente
GO

create proc sp_qr_ns_alerta_cliente (	
	@i_operacion		char(1),
	@i_codigo 			int 	= null,
	@i_estado			char(1) = null,
	@i_cliente			int     = null
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
       
select @w_sp_name = 'sp_qr_ns_alerta_cliente'

--Insercion
if @i_operacion = 'S'
begin
    
    SELECT  nar_codigo,
            convert(varchar(10),nar_cliente),
            nar_nombre,
            nar_tipo_lista,
            convert(varchar(10),nar_fecha_proceso,103),
            nar_correo
    FROM cobis..cl_ns_alertas_riesgo
    WHERE nar_codigo = @i_codigo
    
end
--Insercion
if @i_operacion = 'I'
begin
	
	begin tran
    
    declare @tipoAlertas as table 
    (
    	idTipoAlerta        varchar(2) 
    )
    
    
    /* Extraigo fecha de proceso */
    SELECT @w_fecha_proceso = fp_fecha FROM cobis..ba_fecha_proceso
    
    if exists (SELECT 1 FROM cobis..cl_ns_alertas_riesgo WHERE nar_cliente = @i_cliente
                    AND nar_fecha_proceso = @w_fecha_proceso )
    begin
        commit tran
        goto fin
    end
    
    /* Extraccion de Datos para Insertar */
    select @w_nombre_completo = isnull(en_nombre,'')+ ' ' +isnull(p_s_nombre,'')+ ' ' +isnull(p_p_apellido,'') +' ' +isnull(p_s_apellido,'')
    FROM cobis..cl_ente
    WHERE en_ente = @i_cliente
    
    /* Coicidencias de alertas */
    select @w_alertas = ''
    select @w_id_alerta = 0
	while 1 = 1
	begin
    
        SELECT TOP 1 @w_id_alerta    = ar_id_alerta,
                @w_tipo_alerta  = ar_tipo_lista
        FROM cobis..cl_alertas_riesgo 
        WHERE ar_ente = @i_cliente
        AND ar_id_alerta > @w_id_alerta
        ORDER BY ar_id_alerta asc
        
        IF @@ROWCOUNT = 0
              BREAK
        
        if NOT EXISTS (SELECT * FROM @tipoAlertas WHERE idTipoAlerta = @w_tipo_alerta)
        begin
            
            INSERT INTO @tipoAlertas VALUES (@w_tipo_alerta)
            
            select @w_alertas = @w_alertas + isnull(upper(valor) + ', ', '') 
            FROM cobis..cl_catalogo WHERE tabla = (SELECT codigo 
                        FROM cobis..cl_tabla WHERE tabla = 'cl_alertas_tlista')
            AND codigo = @w_tipo_alerta
            
        end
        
    end
    
    select @w_alertas = substring(@w_alertas,0,len(@w_alertas))
    
    select @w_oficial = 0
	while 1 = 1
	begin
        
        SELECT TOP 1 @w_oficial  = codigo,
                @w_correo   = valor  
        FROM cobis..cl_catalogo WHERE tabla = (SELECT codigo 
                        FROM cobis..cl_tabla WHERE tabla = 'cl_correos_normativo')
        and codigo > @w_oficial
        order by codigo asc
        IF @@rowcount = 0
              break
        
        PRINT 'El oficial es '
        PRINT @w_oficial
        
        exec @w_num_error = cobis..sp_cseqnos
        @t_debug     = 'N',
        @t_file      = null,
        @t_from      = @w_sp_name,
        @i_tabla     = 'cl_ns_alertas_riesgo',
        @o_siguiente = @w_codigo out
        
        if @w_num_error <> 0
        begin
            select @w_num_error = 2101007 --NO EXISTE TABLA EN TABLA DE SECUENCIALES
            goto errores
        end
	
        if exists (select 1 from cobis..cl_ns_alertas_riesgo 
        			where nar_codigo = @w_codigo)
        begin
        	select @w_num_error = 710001 --ERROR EN LA ISERCION DEL REGISTRO  
             goto errores
        end
        
        insert into cobis..cl_ns_alertas_riesgo(
        		nar_codigo,             nar_cliente,            nar_nombre,             nar_tipo_lista,
        		nar_fecha_proceso,      nar_correo,             nar_estado)
        values(
        		@w_codigo,              @i_cliente,             @w_nombre_completo,     @w_alertas,
        		@w_fecha_proceso,       @w_correo,              'P') --Estado Pendiente
        if @@error <> 0
        begin 
            select @w_num_error = 710001 --ERROR EN LA ISERCION DEL REGISTRO 
            goto errores
        end
        
    end
    
    commit tran
    goto fin

end

--Consulta
if @i_operacion = 'Q'
begin
	
	select nar_codigo,
		   nar_cliente
	  from cl_ns_alertas_riesgo
	 where nar_estado = 'P' --Pendiente
	 
	 update cl_ns_alertas_riesgo
	   set nar_estado 	= 'E' --En Proceso
	 where nar_estado 	= 'P'
     
	if @@rowcount = 0
	begin 
		return 1
	end

end

--Actualiza estado
if @i_operacion = 'U'
begin
	update cl_ns_alertas_riesgo
	   set nar_estado 		= @i_estado
	 where nar_codigo 		= @i_codigo
 
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

