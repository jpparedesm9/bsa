/************************************************************************/
/*  Archivo:                sp_reintento_envio_doc_autoonboarding.sp    */
/*  Stored procedure:       sp_reintento_envio_doc_autoonboarding       */
/*  Base de Datos:          cob_credito                                 */
/*  Producto:               Credito                                     */
/*  Disenado por:           A. LLandan                                  */
/*  Fecha de Documentacion: 05/Ene/2023                                 */
/************************************************************************/
/*          IMPORTANTE                                                  */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  "COBOSCORP",representantes exclusivos para el Ecuador de la         */
/*  AT&T                                                                */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier autorizacion o agregado hecho por alguno de sus           */
/*  usuario sin el debido consentimiento por escrito de la              */
/*  Presidencia Ejecutiva de COBISCORP o su representante               */
/************************************************************************/
/*          PROPOSITO                                                   */
/*  Consulta de archivos que poseen estado de error en la carga a       */
/*  alfresco                                                            */
/************************************************************************/
/*          MODIFICACIONES                                              */
/*  FECHA         AUTOR                   RAZON                         */
/* 05/Ene/2023  A. LLandan    Emision Inicial                           */
/* **********************************************************************/


use cob_credito
go

if exists (select 1 from sysobjects
            where name = 'sp_reintento_envio_doc_autoonboarding')
begin
  drop proc sp_reintento_envio_doc_autoonboarding
end
GO


CREATE PROCEDURE [dbo].[sp_reintento_envio_doc_autoonboarding] (
	@i_operacion		   char(1),              -- 1
	@i_ente                int = null,           -- 2
	@i_estado			   char(1) = null,       -- 3
	@i_cod_documento       varchar(10) = null,   -- 4
	@i_banco               varchar(24) = null,   -- 5
	@i_ruta_nombre_archivo varchar(200) = null,  -- 6
	@i_modo                int,                  -- 7
	@i_estado_terminado    char(1)          -- 8
	
)
AS	
declare 
    @w_fecha_proceso    datetime,
    @w_extesion varchar(10) = '.pdf',
    @w_text_final_nombre varchar(10)

select @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso
SELECT @w_text_final_nombre = ra_nombre_archivo_term from cr_reporte_on_boarding

--Consulta
if @i_operacion = 'Q'
begin
	
	if (@i_modo = 1) begin
	    
        select cod_ente,          -- 1
	           cod_buc,           -- 2
	    	   cod_banco,         -- 3
	    	   cod_tramite,       -- 4
	    	   cod_cod_documento,  -- 5
	    	   'nombre_archivo' = ra_nombre_archivo_presentar,   -- 6
	    	   getdate(),  -- 7
	    	   'nombre_archivo_jasper' = ra_nombre_archivo_jasper,   -- 8
	    	   'ruta_archivo_gen' = cod_ruta_gen, -- 9
	    	   cod_enviar_correo,                 -- 10
			   'text_final_nombre' =  ra_nombre_archivo_term, -- 11
			   'descarga_alfresco' =  ra_est_des_alfresco,     -- 12
			   cod_grupo,		-- 13
			   cod_id_inst_proc,-- 14
			   cod_nombre_doc,	-- 15	   
			   cod_carpeta,     -- 16
			   ra_toperacion,   -- 17
			   ra_est_carga_alfresco,   -- 18
			   ra_cod_tipo_doc_cstmr,   -- 19
			   ra_grp_unif,     -- 20
               cod_id_inst_act,      --21
               cod_codigo_tipo_doc      --22
	    from cob_credito..cr_cli_reporte_on_boarding_det, cob_credito..cr_reporte_on_boarding
	    where (cod_est_gen = @i_estado_terminado
		and cod_est_carga_alfresco = @i_estado)
		and cod_cod_documento = ra_cod_documento
		order by cod_ente, cod_orden_unif
		
	end	  
	
end
     
return 0

GO

