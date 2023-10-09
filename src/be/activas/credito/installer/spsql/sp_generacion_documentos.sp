/*************************************************************************/
/*   Archivo:            sp_generacion_documentos.sp                     */
/*   Stored procedure:   sp_generacion_documentos                        */
/*   Base de datos:      cob_credito                                     */
/*   Producto:           Originacion                                     */
/*   Disenado por:       SRO                                             */
/*   Fecha de escritura: 17/11/2022	                                     */
/*************************************************************************/
/*                               IMPORTANTE                              */
/*   Este programa es parte de los paquetes bancarios propiedad de       */
/*   "MACOSA", representantes exclusivos para el Ecuador de NCR          */
/*   Su uso no autorizado queda expresamente prohibido asi como          */
/*   cualquier acion o agregado hecho por alguno de sus                  */
/*   usuarios sin el debido consentimiento por escrito de la             */
/*   Presidencia Ejecutiva de MACOSA o su representante.                 */
/*************************************************************************/
/*                               PROPOSITO                               */
/*   Este procedimiento almacenado, tanquea la tabla de generacion o     */
/*   descarga de documentos en una actividad automatica                  */
/*************************************************************************/
/*                               MODIFICACIONES                          */
/*   FECHA       AUTOR                       RAZON                       */
/* 21/11/2022    KVI      Version Inicial                                */
/*                        Req.197007 Flujo B2B Grupal Paperless Fase 1   */
/* 31/01/2023    KVI      R.201311 Tanqueo tabla pant. reimpresion de doc*/
/*************************************************************************/
use cob_credito 
go

if object_id ('sp_generacion_documentos') is not null
   drop procedure sp_generacion_documentos
go

create procedure sp_generacion_documentos
(
   @s_ssn            int           = null,
   @s_ofi            smallint,
   @s_user           login,
   @s_date           datetime,
   @s_srv            varchar(30)   = null,
   @s_term           descripcion   = null,
   @s_rol            smallint      = null,
   @s_lsrv           varchar(30)   = null,
   @s_sesn           int           = null,
   @s_org            char(1)       = null,
   @s_org_err        int           = null,
   @s_error          int           = null,
   @s_sev            tinyint       = null,
   @s_msg            descripcion   = null,
   @t_rty            char(1)       = null,
   @t_trn            int           = null,
   @t_debug          char(1)       = 'N',
   @t_file           varchar(14)   = null,
   @t_from           varchar(30)   = null,
   --variables
   @i_id_inst_proc   int,    --codigo de instancia del proceso
   @i_id_inst_act    int,
   @i_id_empresa     int,
   @i_etapa_flujo    varchar(10)  = 'FIN',-- LGU 2017-07-13: para ver en que momento se ccrea el DES y LIQ del prestamo
                                          -- (1) IMP: impresion: solo crear OP hijas
                                          -- (2) FIN: al final del flujo: crea DES y LIQ de OP hijas
   @i_fecha_ini      datetime     = null, -- para crear las operaciones hijas
   @o_id_resultado   smallint out
)
as
declare
@w_error                  int,
@w_tramite                int,
@w_grupo                  int,          
@w_product_type	          varchar(50),
@w_grupal                 char(1),
@w_banco                  varchar(30),
@w_anterior               varchar(24), 
@w_canal                  int,
@w_cliente                int,
@w_correo                 varchar(64),
@w_tipo_seguro            varchar(16),
@w_id_inst_act            int,
@w_documento              int -- R.201311


------------------------------------
---   TANQUEO TABLA ARCHIVOS     ---
------------------------------------
/* Obtengo el numero de prestamo*/
select @w_tramite      = io_campo_3,
       @w_grupo        = io_campo_1,
	   @w_product_type = io_campo_4	   
from   cob_workflow..wf_inst_proceso 
where  io_id_inst_proc = @i_id_inst_proc

select @w_grupal = tr_grupal
from   cob_credito..cr_tramite
where  tr_tramite = @w_tramite

if @w_grupal = 'S'
begin
	select @w_anterior = null, @w_canal = null, @w_banco = NULL
	
	/* Obtengo el numero de prestamo*/
	select @w_banco   = tg_referencia_grupal
	from    cob_credito..cr_tramite_grupal
	where  tg_tramite = @w_tramite	
	
    select @w_anterior = op_anterior from cob_cartera..ca_operacion where op_banco = @w_banco
    select @w_canal = ca_canal from cobis..cl_canal where ca_nombre = 'web'
  
    if @w_anterior is null 
    begin
        print 'LA OPERACION ' + @w_product_type + ':'+ @w_banco + ' GRUPO:' + convert(varchar,@w_grupo) + ' NO ES UNA RENOVACION'
    
	    select @w_cliente = 0
        while 1 = 1
        begin
	    
	        select top 1 @w_cliente = cg_ente from cobis..cl_cliente_grupo 
	        where cg_grupo = @w_grupo
	        and cg_ente > @w_cliente
	        and cg_estado = 'V'
 	        order by cg_ente
 	    
 	        if @@rowcount = 0
 	            break
 	    
 	        select top 1 @w_correo = di_descripcion
 	        from cobis..cl_direccion
 	        where di_ente = @w_cliente
 	        and di_tipo = 'CE' 	
			
			select @w_tipo_seguro = se_tipo_seguro from cob_cartera..ca_seguro_externo where se_banco = @w_banco and se_cliente = @w_cliente
 	    
   	        if @w_correo is not null
	        begin 
	            if not exists (select 1 from cob_credito..cr_cli_reporte_on_boarding where co_tramite = @w_tramite and co_ente = @w_cliente)
                begin
	    	        print 'TANQUEO CLIENTE:' + convert(varchar,@w_cliente) + ' -OPERACION ' + @w_product_type + ':' + @w_banco + ' -TRAMITE:' + convert(varchar,@w_tramite) + ' -SEGURO:' + @w_tipo_seguro
	    		
              	    insert into cob_credito..cr_cli_reporte_on_boarding( 
	    	  	        co_ente, 
              	        co_buc,           co_banco,         co_tramite,      co_email,        co_est_zip,      
              		    co_fecha_zip,     co_est_envio,     co_fecha_envio,  co_ruta_zip,     co_estd_clv_co,
						co_fecha_reg)
                    select 
	    		        @w_cliente, 
              	        en_banco,         @w_banco,         @w_tramite,      @w_correo,       'P',
                        null,             null,             null,            null,             null,
						getdate()
                    from cobis..cl_ente
                    where en_ente = @w_cliente
              
                    if @@rowcount = 0  
	    		    begin
                        print 'ERROR: NO SE PUDO TANQUEAR LA OPERACION ' + @w_product_type + ' SECCION REPORTES 1 en sp_generacion_documentos' + ' CLIENTE:' + convert(varchar,@w_cliente)
                    end
	    		
                    insert into cob_credito..cr_cli_reporte_on_boarding_det( 
	    		        cod_ente,
              	        cod_buc,              cod_banco,             cod_tramite,         cod_cod_documento, 
              	        cod_est_gen,                                                      cod_fecha_gen,         
              		    cod_enviar_correo,                                                cod_ruta_gen, 
	    			    cod_est_des_alfresco,                                             cod_canal,
						cod_id_inst_proc,     cod_grupo,             cod_carpeta,   	  
						cod_nombre_doc, 	  cod_codigo_tipo_doc,   
						cod_est_carga_alfresco, 
						cod_est_eliminar_doc,                                             cod_id_inst_act,
						cod_cod_tipo_doc_cstmr,                      cod_grp_unif,        cod_orden_unif,
						cod_fecha_reg)													    
                    select 
	    		        co_ente,                                     
                        co_buc,               co_banco,              co_tramite,          ra_cod_documento,
                        case when ra_est_gen = 'S'          then 'P' else null end,       null,
                        case when ra_est_envio = 'S'        then 'S' else 'N'  end,       null,
	    			    case when ra_est_des_alfresco = 'S' then 'P' else null end,       ra_canal,
						@i_id_inst_proc,      @w_grupo,              ra_carpeta,         
						null, 				  ra_codigo_tipo_doc,
						case when ra_est_carga_alfresco = 'S' then 'P' else null end,
						case when ra_est_eliminar_doc = 'S'   then 'P' else null end,     null,
						ra_cod_tipo_doc_cstmr,                       ra_grp_unif,         ra_orden_unif,
						getdate()
                    from cob_credito..cr_cli_reporte_on_boarding, cob_credito..cr_reporte_on_boarding 
              	    where co_tramite = @w_tramite
	    		    and co_ente = @w_cliente
	    		    and ra_toperacion = @w_product_type
	    		    and ra_canal = @w_canal	
                    and ra_estado = 'V'	

                    if @@rowcount = 0
	    		    begin
              	        print 'ERROR: NO SE PUDO TANQUEAR LA OPERACION ' + @w_product_type + ' SECCION REPORTES 2 en sp_generacion_documentos' + ' CLIENTE:' + convert(varchar,@w_cliente)
                    end					
					
					select @w_id_inst_act = ia_id_inst_act
					from cob_workflow..wf_inst_actividad
					where ia_id_inst_proc = @i_id_inst_proc
					and   ia_codigo_act   = 6 -- Actividad: APROBAR PRÉSTAMO
					
					update cob_credito..cr_cli_reporte_on_boarding_det
					set cod_id_inst_act = @w_id_inst_act 
					where cod_id_inst_proc = @i_id_inst_proc
					and   cod_ente = @w_cliente
					
					update cob_credito..cr_cli_reporte_on_boarding_det
					set cod_nombre_doc = convert(varchar,cod_id_inst_act) + '_P_'+ ltrim(rtrim(isnull(td_nombre_tipo_doc,''))) + '.pdf' 
					from cob_workflow..wf_tipo_documento
					where cod_codigo_tipo_doc = td_codigo_tipo_doc
					and   cod_id_inst_proc = @i_id_inst_proc
					and   cod_ente = @w_cliente
					and   cod_carpeta = 'Inbox'
					
					update cob_credito..cr_cli_reporte_on_boarding_det
					set cod_nombre_doc = ltrim(rtrim(isnull(cod_cod_tipo_doc_cstmr,''))) + '.pdf'
					where cod_id_inst_proc = @i_id_inst_proc
					and   cod_ente = @w_cliente
					and   cod_carpeta = 'Customer'        
                    					
					if @w_tipo_seguro = 'NINGUNO'
					begin
					    delete from cob_credito..cr_cli_reporte_on_boarding_det
					    where cod_id_inst_proc = @i_id_inst_proc
					    and   cod_ente = @w_cliente
						and   cod_cod_documento in (126,127,128)					
					end
					
					if @w_tipo_seguro = 'BASICO'
					begin
					    delete from cob_credito..cr_cli_reporte_on_boarding_det
					    where cod_id_inst_proc = @i_id_inst_proc
					    and   cod_ente = @w_cliente
						and   cod_cod_documento in (127)
					end	

 			        if @w_tipo_seguro != 'NINGUNO' -- R.201311
					begin					    
					    -- Id documento Certificado de Consentimiento
					    select @w_documento = id_documento
						from cob_credito..cr_imp_documento
						where id_toperacion = @w_product_type
						and id_mnemonico = 'CERCON'
						
						if not exists (select 1 from cob_credito..cr_documento where do_tramite  = @w_tramite and do_documento = @w_documento)
						begin
					        print 'TANQUEO REIMPRESION -TRAMITE: ' + convert(varchar,@w_tramite) + ' -DOCUMENTO: ' + convert(varchar,@w_documento)
					        exec @w_error = cob_credito..sp_documento                              
                                 @s_srv       = @s_srv,
                                 @s_user      = @s_user,
                                 @s_term      = @s_term ,
                                 @s_ofi       = @s_ofi,
                                 @s_rol       = @s_rol,
                                 @s_ssn       = @s_ssn,
                                 @s_lsrv      = @s_lsrv ,
                                 @s_date      = @s_date,
                                 @s_sesn      = @s_sesn,
                                 @s_org       = @s_org,
                                 @t_trn       = 21034,
							     @i_operacion = 'I',
                                 @i_tramite   = @w_tramite,
                                 @i_documento = @w_documento
                            
                            if @w_error <> 0
                            begin
                                print 'ERROR: NO SE PUDO TANQUEAR REIMPRESION -TRAMITE: ' + convert(varchar,@w_tramite) + ' -DOCUMENTO: ' + convert(varchar,@w_documento)
                            end							
                        end 							 
                             							 
					end		
                end 		
	        end
	        else
	        begin
	            print '[DEBUG:] No se encontro destinatario - TRAMITE: '+ convert(VARCHAR(10),@w_tramite) + ' INSTANCIA_PROCESO: ' + convert(varchar(10),@i_id_inst_proc) + ' CLIENTE: ' + convert(varchar(10),@w_cliente)
	        end	
        end
    end
    else
    begin
        print 'LA OPERACION ' + @w_product_type + ':'+ @w_banco + ' GRUPO:' + convert(varchar,@w_grupo) + ' ES UNA RENOVACION'
    end  
end

select @o_id_resultado = 1 --OK

return 0

ERROR:
    return @w_error
GO