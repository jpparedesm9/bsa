/************************************************************************/
/*  Archivo:                sp_cre_vigente_wf.sp                        */
/*  Stored procedure:       sp_cre_vigente_wf                           */
/*  Base de Datos:          cob_workflow                                */
/*  Producto:               Credito                                     */
/*  Disenado por:           P. Ortiz                                    */
/*  Fecha de Documentacion: 30/Jun/2017                                 */
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
/* Procedure tarea automática, Retorna error si el credito actual se    */
/* encuentra activo                                                     */
/************************************************************************/
/*          MODIFICACIONES                                              */
/*  FECHA       AUTOR                   RAZON                           */
/*  30/May/2017 P. Ortiz             Emision Inicial                    */
/*  03/Jul/2017 P. Ortiz             Modificacion para flujo Individual */
/* **********************************************************************/
USE cob_workflow
GO

if exists(select 1 from sysobjects where name ='sp_cre_vigente_wf')
	drop proc sp_cre_vigente_wf
GO


CREATE PROC sp_cre_vigente_wf
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
        @w_ente             int,
        @w_ttramite         varchar(255)
        

select @w_sp_name = 'sp_cre_vigente_wf'

SELECT @w_grupo   = convert(int,io_campo_1),
	   @w_tramite = convert(int,io_campo_3),
	   @w_ttramite = io_campo_4
FROM cob_workflow..wf_inst_proceso
where io_id_inst_proc = @i_id_inst_proc

select @w_tramite = isnull(@w_tramite,0)

if @w_tramite = 0 return 0

if @w_ttramite = 'GRUPAL'
begin
    
	SELECT @w_ente = 0
	WHILE 1 = 1
	BEGIN
	   
		SELECT TOP 1 @w_ente = cg_ente FROM cobis..cl_cliente_grupo 
		WHERE cg_grupo = @w_grupo
		AND cg_ente > @w_ente
		ORDER BY cg_ente ASC
		
		IF @@ROWCOUNT = 0
		  BREAK
		
		IF EXISTS(SELECT 1 FROM cob_cartera..ca_operacion AS d
		      WHERE d.op_cliente = @w_ente 
		      AND d.op_estado IN (SELECT es_codigo FROM cob_cartera..ca_estado WHERE es_procesa = 'S')
		      )
		BEGIN
		 PRINT 'Error: un cliente tiene un credito activo'
		 select @o_id_resultado = 2 -- devolver
		 BREAK
		end
		ELSE
		begin
		   select @o_id_resultado = 1 --Ok
		end
	   
	END
end
else
begin
	
	SELECT @w_ente = @w_grupo
	
	IF EXISTS(SELECT 1 FROM cob_cartera..ca_operacion AS d
	      WHERE d.op_cliente = @w_ente 
	      AND d.op_estado IN (SELECT es_codigo FROM cob_cartera..ca_estado WHERE es_procesa = 'S')
	      )
	BEGIN
	 PRINT 'Error: El cliente tiene un credito activo'
	 select @o_id_resultado = 2 -- devolver
	end
	ELSE
	begin
	   select @o_id_resultado = 1 --Ok
	end
	
end

return 0
GO

