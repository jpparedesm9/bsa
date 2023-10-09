/************************************************************************/
/*  Archivo:                sp_ins_observacion_wf.sp                    */
/*  Stored procedure:       sp_ins_observacion_wf                       */
/*  Base de Datos:          cob_workflow                                */
/*  Producto:               Credito                                     */
/*  Disenado por:           P. Ortiz                                    */
/*  Fecha de Documentacion: 10/Jul/2017                                 */
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
/* Inserta un observaciones a las tablas wf_observaciones y wf_ob_lineas*/
/************************************************************************/
/*          MODIFICACIONES                                              */
/*  FECHA       AUTOR                   RAZON                           */
/*  10/Jul/2017 P. Ortiz             Emision Inicial                    */
/*  17/Ago/2017 P. Ortiz             Corregir Funcionalidad             */
/*  17/Ago/2017 P. Ortiz             Se cambia el campo de guardado     */
/* **********************************************************************/
USE cob_workflow
GO

if exists(select 1 from sysobjects where name ='sp_ins_observacion_wf')
	drop proc sp_ins_observacion_wf
GO


CREATE PROC sp_ins_observacion_wf
		(@s_ssn        int         = null,
	     @s_ofi        smallint,
	     @s_user       login,
         @s_date       datetime,
	     @s_srv		   varchar(30) = null,
	     @s_term	   descripcion = null,
	     @s_rol		   smallint    = null,
	     @s_lsrv	   varchar(30) = null,
	     @s_sesn	   int 	       = null,
	     @s_org		   char(1)     = NULL,
		 @s_org_err    int 	       = null,
         @s_error      int 	       = null,
         @s_sev        tinyint     = null,
         @s_msg        descripcion = null,
         @t_rty        char(1)     = null,
         @t_trn        int         = null,
         @t_debug      char(1)     = 'N',
         @t_file       varchar(14) = null,
         @t_from       varchar(30)  = null,
         --variables
		 @i_id_inst_proc int,    --codigo de instancia del proceso
		 @i_id_inst_act  int,    
	   	 @i_id_empresa   int, 
		 @o_id_resultado  smallint  out
		 )
AS
DECLARE @w_error            int,
        @w_sp_name       	varchar(32),
        @w_tramite       	int,
        @w_return        	int,
        ---var variables	
        --@w_asig_actividad 	int,
        --@w_valor_ant      	varchar(255),
        --@w_valor_nuevo    	varchar(255),
        @w_grupo            int,
        @w_ente             INT,
        @w_comentario		varchar(255),
        @w_proceso			varchar(5),
        @w_nemonico         varchar(255),
        @w_usuario			varchar(64),
        @w_cliente          INT,
        @w_asig_act         INT,
        @w_nombre           varchar(64),
        @w_rfc              varchar(50),
        @w_tipo				VARCHAR(1),
        @w_numero           int
       

select @w_sp_name = 'sp_ins_observacion_wf'

SELECT @w_tramite    = convert(int,io_campo_3),
       @w_nemonico    = convert(VARCHAR(20),io_campo_4),
       @w_asig_act   = convert(int,io_campo_2)
FROM cob_workflow..wf_inst_proceso
where io_id_inst_proc = @i_id_inst_proc

-- Seteo de variables
SELECT @w_proceso	=	pa_int	-- Codigo de la categoria de la observacion
FROM cobis..cl_parametro
WHERE pa_nemonico = 'OAA'


select @w_tramite = isnull(@w_tramite,0)

if @w_tramite = 0 return 0
	
	SELECT 	@w_cliente = tr_cliente,
			@w_tipo    = tr_grupal
	FROM cob_credito..cr_tramite 
	WHERE tr_tramite = @w_tramite
	
	IF @w_tipo = 'S'
    BEGIN
    	
    	SELECT 	@w_nombre  = gr_nombre
		FROM cobis..cl_grupo 
		WHERE gr_grupo = @w_cliente
    	
    	SET @w_comentario = 'Código Grupo: ' + convert(VARCHAR(20), @w_cliente) + ' - Nombre Grupo: ' + @w_nombre + ', está reportado en LISTAS NEGRAS o el estado en el BURÓ es MALO, por favor revisar.'
    END           
    ELSE
    BEGIN
    	
    	SELECT  @w_nombre  = en_nombre + ' ' + p_p_apellido,
			    @w_rfc     = en_rfc
		FROM cobis..cl_ente WHERE en_ente = @w_cliente
    	
    	SET @w_comentario = 'Código: ' + convert(VARCHAR(20), @w_cliente) + ' - Nombre: ' + @w_nombre + ' con RFC ' + @w_rfc + ', está reportado en LISTAS NEGRAS o el estado en el BURÓ es MALO, por favor revisar.'
    END
    
    
    SELECT TOP 1 @w_numero = ob_numero FROM cob_workflow..wf_observaciones 
    WHERE ob_id_asig_act = @w_asig_act
    order by ob_numero desc
    
    if (@w_numero IS NOT null)
    begin
    	SELECT @w_numero = @w_numero + 1 --aumento en uno el maximo
    end
    else
    begin
    	SELECT @w_numero = 1
    end
    
    SELECT @w_usuario = fu_nombre FROM cobis..cl_funcionario WHERE fu_login = @s_user
    
    INSERT INTO cob_workflow..wf_observaciones (ob_id_asig_act, ob_numero, ob_fecha, ob_categoria, ob_lineas, ob_oficial, ob_ejecutivo)
	VALUES (@w_asig_act, @w_numero, getdate(), @w_proceso, 1, @s_user, @w_usuario)
	
	INSERT INTO cob_workflow..wf_ob_lineas (ol_id_asig_act, ol_observacion, ol_linea, ol_texto)
	VALUES (@w_asig_act, @w_numero, 1, @w_comentario)

	IF exists(select 1 from cob_workflow..wf_observaciones WHERE ob_id_asig_act = @w_asig_act)
	BEGIN
		select @o_id_resultado = 1 --Ok
		--PRINT 'Se inserto el comentario POV'
	END
	ELSE
	BEGIN
		select @o_id_resultado = 2 -- devolver
		--PRINT 'NO se inserto el comentario POV'
	END
	
return 0
GO

