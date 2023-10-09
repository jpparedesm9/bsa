/************************************************************************/
/*  Archivo:                sp_cons_soli_cli.sp                         */
/*  Stored procedure:       sp_cons_soli_cli                            */
/*  Base de Datos:          cob_credito                                 */
/*  Producto:               Credito                                     */
/*  Disenado por:           --------                                    */
/*  Fecha de Documentacion: 29/Jun/2017                                 */
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
/* Realiza consultas de los clientes para generar la reimpresión de     */
/* documentos                                                           */
/************************************************************************/
/*          MODIFICACIONES                                              */
/*  FECHA       AUTOR                   RAZON                           */
/*  08/Jul/2017 P. Ortiz             Emision Inicial                    */
/* **********************************************************************/
USE cob_credito
GO

if exists(select 1 from sysobjects where name ='sp_cons_soli_cli')
	drop proc sp_cons_soli_cli
GO


CREATE proc sp_cons_soli_cli(
        @t_debug    char(1) = 'N',
        @t_file         varchar(14) = null,
        @i_operacion char,
        @i_tramite   int = null,
        @i_login     varchar(50)=null,
        @t_trn       int = null,
        @i_cliente   int = null,
        @i_oficial   int = NULL,
        @i_tipo_tramite varchar(3) = null,
        @i_id_inst_proc   int = NULL,
        @i_codigo_alterno varchar(50) = NULL,
        @i_nemonico       varchar(50) = NULL,
        @i_claimant       varchar(20) = NULL,
        @i_group          CHAR(1) = 'N'
)
as
declare @w_cod_oficial int,
        @w_sp_name     varchar(50),
        @w_tramite     INT,
        @w_tipo_tramite VARCHAR(3),
		@w_consulta VARCHAR(2500),
		@w_consulta_condiciones_pt1 VARCHAR(250),
		@w_consulta_condiciones_pt2 VARCHAR(250),
		@w_order_by VARCHAR(250),
		@w_nemonico_gestrec varchar(10),
		@w_nemonico_fl VARCHAR(10),
		@w_is_grupal  CHAR(1) = 'N'


select @w_sp_name = 'sp_cons_soli_cli'

SET @w_consulta_condiciones_pt1 = ''
SET @w_consulta_condiciones_pt2 = ''
SET @w_order_by = ''

SELECT @w_nemonico_gestrec = pa_char
FROM cobis..cl_parametro WHERE pa_nemonico = 'GESTRE'
AND pa_producto = 'CRM'



 if @i_operacion = 'S'
 BEGIN

   if @t_trn = 22555
   		BEGIN
			IF @i_nemonico is null and @i_codigo_alterno is not null
			BEGIN
				select @i_nemonico = pr_nemonico
				  from cob_workflow..wf_inst_proceso
		    inner join cob_workflow..wf_proceso on io_codigo_proc = pr_codigo_proceso
			     where io_codigo_alterno = @i_codigo_alterno
			END
			
   			/*IF  @w_nemonico_gestrec <> @i_nemonico
	   			 BEGIN*/
	   		
	   		SELECT @w_nemonico_fl = pr_nemonico
		    FROM cob_workflow..wf_proceso 
	   	    WHERE pr_codigo_proceso = @i_tipo_tramite

				    
	   	     	    
	   	   SELECT @w_is_grupal = tr_grupal
	   	   FROM  cob_credito..cr_tramite 
	   	   WHERE tr_tramite = @i_id_inst_proc
	   	    
		   
		    IF EXISTS (SELECT 1  WHERE @w_nemonico_fl IN (SELECT C.codigo FROM cobis..cl_tabla T, cobis..cl_catalogo C WHERE T.tabla = 'cr_flujo_grp' AND C.tabla = T.codigo))
		    OR @w_is_grupal = 'S' OR   @i_group  = 'S'
			BEGIN
		       SET @w_consulta =  'SELECT "C¢digoSolicitud"= io_id_inst_proc, "C¢digoAlterno"= io_codigo_alterno,"C¢digoCrdito"=tr_tramite,"TipoFlujo"= tr_tipo,'+
		            ' "Deudor Principal"= de_cliente,"Nombre Deudor"= gr_nombre, "Monto Propuesto"= tr_monto, "Moneda Propuesta"=tr_moneda,'+
		            ' "C¢digo Ciudad"= tr_ciudad from cob_credito..cr_tramite,cob_credito..cr_deudores,cob_workflow..wf_inst_proceso,cobis..cl_grupo'
		            
		       SET @w_consulta_condiciones_pt1 = ' where de_tramite = tr_tramite and de_cliente = gr_grupo and io_campo_3 = tr_tramite and io_estado <> ''CAN'' and de_rol = ''G'''
		    END           
		    ELSE
		    BEGIN
		    	SET @w_consulta =  'SELECT "C¢digoSolicitud"= io_id_inst_proc, "C¢digoAlterno"= io_codigo_alterno,"C¢digoCr‚dito"=tr_tramite,"TipoFlujo"= tr_tipo,'+
		            ' "Deudor Principal"= de_cliente,"Nombre Deudor"= en_nomlar, "Monto Propuesto"= tr_monto, "Moneda Propuesta"=tr_moneda,'+
		            ' "C¢digo Ciudad"= tr_ciudad from cob_credito..cr_tramite,cob_credito..cr_deudores,cob_workflow..wf_inst_proceso,cobis..cl_ente'
		            
				SET @w_consulta_condiciones_pt1 = ' where de_tramite = tr_tramite and de_cliente = en_ente and io_campo_3 = tr_tramite and io_estado <> ''CAN'' and de_rol = ''D'''
		    END
		    

			    


			    PRINT @i_tipo_tramite
			    IF @i_tipo_tramite IS not null
					BEGIN
					PRINT 'pasa aca 1'
						select @w_consulta_condiciones_pt2 = ' and io_codigo_proc = '+ '''' + @i_tipo_tramite + ''''
					END
				ELSE
					BEGIN
					PRINT 'pasa aca 2'
						IF (@i_cliente = NULL and @i_id_inst_proc  = NULL and @i_codigo_alterno = NULL)
							BEGIN
							-- No existe datos
							exec cobis..sp_cerror
							@t_debug     = @t_debug,
							@t_file     = @t_file,
							@t_from     = @w_sp_name,
							@i_num     = 101001
							END

					END

				IF ((@i_cliente is not null) and (@i_id_inst_proc is null) and (@i_codigo_alterno is null))
					BEGIN
						SET @w_consulta_condiciones_pt1 = @w_consulta_condiciones_pt1 + ' and de_cliente = '+ '''' + convert(VARCHAR(10),@i_cliente) + ''''
			        END


				IF ((@i_cliente is not null) and (@i_id_inst_proc  is not null) and (@i_codigo_alterno is null))
					BEGIN
						SET @w_consulta_condiciones_pt1 = @w_consulta_condiciones_pt1 + ' and de_cliente = '+ '''' + convert(VARCHAR(10),@i_cliente) + ''' and io_campo_3 = '+ '''' + convert(VARCHAR(15),@i_id_inst_proc) + ''''
			        END


				IF ((@i_cliente is null) and (@i_id_inst_proc is not null) and (@i_codigo_alterno is null))
					BEGIN
						SET @w_consulta_condiciones_pt1 = @w_consulta_condiciones_pt1 + ' and io_campo_3 = '+ '''' + convert(VARCHAR(15),@i_id_inst_proc) + ''''
					END

				IF ((@i_cliente is null) and (@i_id_inst_proc is null) and (@i_codigo_alterno is not null))
					BEGIN
						SET @w_consulta_condiciones_pt1 = @w_consulta_condiciones_pt1 + ' and io_codigo_alterno = '+ '''' + @i_codigo_alterno + ''''
			        END

				IF ((@i_cliente is not null) and (@i_id_inst_proc is null) and (@i_codigo_alterno is not null))
					BEGIN
						SET @w_consulta_condiciones_pt1 = @w_consulta_condiciones_pt1 + ' and de_cliente = '+ '''' + convert(VARCHAR(10),@i_cliente) + ''' and io_codigo_alterno = '+ '''' + @i_codigo_alterno + ''''
					END

				IF ((@i_cliente is not null) and (@i_id_inst_proc  is not null) and (@i_codigo_alterno is not null))
					BEGIN
						SET @w_consulta_condiciones_pt1 = @w_consulta_condiciones_pt1 + ' and de_cliente = '+ '''' + convert(VARCHAR(10),@i_cliente) + ''' and io_campo_3 = '+ '''' + convert(VARCHAR(15),@i_id_inst_proc) + ''' and io_codigo_alterno = '+ '''' + @i_codigo_alterno + ''''
					END

				IF ((@i_cliente is null) and (@i_id_inst_proc  is not null) and (@i_codigo_alterno is not null))
					BEGIN
						SET @w_consulta_condiciones_pt1 = @w_consulta_condiciones_pt1 + ' and io_campo_3 = '+ '''' + convert(VARCHAR(15),@i_id_inst_proc) + ''' and io_codigo_alterno = '+ '''' + @i_codigo_alterno + ''''
					END
				SET @w_order_by = ' ORDER BY tr_tipo, tr_tramite'

				EXEC (@w_consulta + @w_consulta_condiciones_pt1 + @w_consulta_condiciones_pt2 + @w_order_by)
				PRINT @w_consulta
			  --	END
		   --	ELSE
		   /*		BEGIN -- Gestion de reclamos

					PRINT 'entro al else'
					
					--Se eliminaron bases de datos no usadas para Santander
					SELECT 'C¢digo Solicitud' = ip.io_id_inst_proc,
					'C¢digo Alterno'= ip.io_codigo_alterno,
					'Tipo Flujo'= 'C',
					'C¢digo Ciudad'= 0,
					'ente' = en.en_ente
					FROM cob_workflow..wf_inst_proceso ip 
					JOIN cob_workflow..wf_proceso fp ON (fp.pr_codigo_proceso = ip.io_codigo_proc AND fp.pr_nemonico= @w_nemonico_gestrec)
					LEFT JOIN cobis..cl_ente en ON (en.en_ente = @i_cliente OR @i_cliente = null) 
					WHERE (ip.io_id_inst_proc = @i_id_inst_proc OR @i_id_inst_proc = null)
					AND (ip.io_codigo_alterno LIKE '%'+@i_codigo_alterno+'%' OR @i_codigo_alterno = null)
					ORDER BY pr_codigo_proceso*/
					
					/*SELECT
					'C¢digo Solicitud' = ip.io_id_inst_proc,
					'C¢digo Alterno'= ip.io_codigo_alterno,
					'C¢digo Cr‚dito'=cr.cr_id,
					'Tipo Flujo'= 'C',
					'Deudor Principal'= CASE WHEN cr.cr_claimant_id <> NULL THEN cr.cr_claimant_id ELSE en.en_ente END,
					'Nombre Deudor'= CASE WHEN cr.cr_claimant_id <> NULL THEN cc.cc_first_name +' '+cc.cc_last_name+' '+cc.cc_mother_last_name ELSE en.en_nomlar END,
					'Monto Propuesto'= cr.cr_amount,
					'Moneda Propuesta'=cr.cr_currency,
					'C¢digo Ciudad'= 0
					FROM cob_crm..crm_claim_request cr
					JOIN cob_workflow..wf_inst_proceso ip ON (cr.cr_id = ip.io_campo_3)
					JOIN cob_workflow..wf_proceso fp ON (fp.pr_codigo_proceso = ip.io_codigo_proc AND fp.pr_nemonico= @w_nemonico_gestrec)
					LEFT JOIN cob_crm..crm_claimant cc ON (cr.cr_claimant_id = cc.cc_id)
					LEFT JOIN cobis..cl_ente en ON (cr.cr_customer_id = en.en_ente)
					WHERE (ip.io_id_inst_proc = @i_id_inst_proc OR @i_id_inst_proc = null)
					AND (ip.io_codigo_alterno LIKE '%'+@i_codigo_alterno+'%' OR @i_codigo_alterno = null)
					AND (cr.cr_customer_id = @i_cliente OR @i_cliente = null)
					AND (cc.cc_identification_number LIKE '%'+@i_claimant+'%' OR @i_claimant = null )
					ORDER BY pr_codigo_proceso*/
			--	END

       	END
    ELSE
		BEGIN
	         --No existe transaccion
	          exec cobis..sp_cerror
	          @t_debug     = @t_debug,
	          @t_file     = @t_file,
	          @t_from     = @w_sp_name,
	          @i_num     = 151051
	        return 1
	     END


 END --END operacion S


return 0

go

