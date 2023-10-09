/************************************************************************/
/*  Archivo:                sp_estado_gen_report_auto_boarding.sp       */
/*  Stored procedure:       sp_estado_gen_report_auto_boarding.sp       */
/*  Base de Datos:          cob_credito                                 */
/*  Producto:               Credito                                     */
/*  Disenado por:           ACHP                                        */
/*  Fecha de Documentacion: 07/03/2022                                  */
/************************************************************************/
/*                           IMPORTANTE                                 */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  "MACOSA",representantes exclusivos para el Ecuador de la            */
/*  AT&T                                                                */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier autorizacion o agregado hecho por alguno de sus           */
/*  usuario sin el debido consentimiento por escrito de la              */
/*  Presidencia Ejecutiva de MACOSA o su representante                  */
/************************************************************************/
/*                            PROPOSITO                                 */
/* Permite insertar la informacion requerida para los reportes Auto on  */
/* boarding y se puede saber si un correo fue generado o no para su envio*/
/* #168293 Flujo de originación Auto onboarding\CLOUD_168293_reportes   */
/************************************************************************/
/*                          MODIFICACIONES                              */
/*   FECHA       AUTOR                   RAZON                          */
/* 07/03/2022     ACH      Emision Inicial                              */
/* 10/11/2022     ACH      R#196073 Envio de documentos digitales       */ 
/* 20/01/2023     AIN      R#197007 Limitar envio por parametro         */
/* 26/01/2023     KVI      E#201454 Inbox-Grupal Update doc.Comunes     */
/* 27/03/2023     KVI      E#205205 Orden por fecha registro            */
/* **********************************************************************/

use cob_credito
go

if exists(select 1 from sysobjects where name ='sp_estado_gen_report_auto_boarding')
	drop proc sp_estado_gen_report_auto_boarding
go

create proc sp_estado_gen_report_auto_boarding (
	@i_operacion		   char(1),              -- 1
	@i_ente                int = null,           -- 2
	@i_estado			   char(1) = null,       -- 3
	@i_cod_documento       varchar(10) = null,   -- 4
	@i_banco               varchar(24) = null,   -- 5
	@i_ruta_nombre_archivo varchar(200) = null,  -- 6
	@i_modo                int,                  -- 7
	@i_toperacion          varchar(24)           -- 8
)
AS	
declare 
    @w_fecha_proceso    datetime,
    @w_extesion varchar(10) = '.pdf',
    @w_text_final_nombre varchar(10),
	@w_cantida_documento tinyint,
	@w_carpeta           varchar(10), -- E#201454
	@w_toperacion        varchar(10)  -- E#201454
	

select @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso
SELECT @w_text_final_nombre = ra_nombre_archivo_term from cr_reporte_on_boarding

select @w_cantida_documento = pa_tinyint from cobis..cl_parametro where pa_nemonico = 'CDOGEN' and pa_producto = 'CRE'


--Consulta
if @i_operacion = 'Q'
begin
	-- Padre-principal
	if (@i_modo = 1) begin
	
		select co_banco as 'banco', min(co_fecha_reg) as 'fecha_min' -- E#205205
        into #operaciones_tmp
        from  cob_credito..cr_cli_reporte_on_boarding  
        where co_est_zip = 'P'
		and co_fecha_reg is not null -- E#205205
		group by co_banco            -- E#205205

        select top (isnull(@w_cantida_documento,3)) *
        into #operaciones_report
        from #operaciones_tmp 
		order by fecha_min asc -- E#205205
		
		----------------------------------------------------------------------------------------
		select cod_ente, cod_buc, cod_banco, cod_tramite into #clientes
		from cr_reporte_on_boarding, cr_cli_reporte_on_boarding_det, #operaciones_report
		where ra_estado='V'
		and banco = cod_banco		 
		and ra_toperacion = isnull(@i_toperacion,ra_toperacion)
		and ra_cod_documento = cod_cod_documento
		and (cod_est_gen = @i_estado or cod_est_des_alfresco = @i_estado)
		group by cod_ente,cod_buc,cod_banco,cod_tramite
        -------------------------------------------------------------------------------------------

	    select co_ente,          -- 1
	           co_buc,           -- 2
	    	   co_banco,         -- 3
	    	   co_email,         -- 4
	    	   co_ruta_zip,      -- 5
			   @w_fecha_proceso, -- 6
			   upper(en_nombre) + upper(isnull(p_s_nombre, '')) + upper(p_p_apellido) + upper(isnull(p_s_apellido,'')) -- 7
			   -- @w_text_final_nombre
	    from cr_cli_reporte_on_boarding, cobis..cl_ente, #clientes
	    where co_ente = en_ente		
		-- -----
		and cod_ente   = co_ente
		and cod_banco  = co_banco
		and cod_buc    = co_buc		
		and cod_tramite= co_tramite
		-- -----		
		and co_est_zip = @i_estado -- P=Pendiente, T=Terminado
	    order by co_banco

	end
	-- Hija-detalle
	if (@i_modo = 2) begin
	    select cod_ente,          -- 1
	           cod_buc,           -- 2
	    	   cod_banco,         -- 3
	    	   cod_tramite,       -- 4
	    	   cod_cod_documento,  -- 5
	    	   'nombre_archivo' = ra_nombre_archivo_presentar,   -- 6
	    	   @w_fecha_proceso,  -- 7
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
	    from cr_cli_reporte_on_boarding_det, cr_reporte_on_boarding
	    where cod_ente = @i_ente
		and cod_banco  = @i_banco
		and cod_cod_documento = ra_cod_documento
		and (cod_est_gen = @i_estado or cod_est_des_alfresco = @i_estado)		
		order by cod_ente, cod_orden_unif
	end	
	
end

--Actualiza estado hija
if @i_operacion = 'U'
begin
    -- Inicio E#201454
    select @w_carpeta = ra_carpeta,
	       @w_toperacion = ra_toperacion
	from cob_credito..cr_reporte_on_boarding
	where ra_cod_documento = @i_cod_documento
	-- Fin E#201454
		   
	-- Padre-principal
	if (@i_modo = 1) begin
	    update cr_cli_reporte_on_boarding set
               co_est_zip = @i_estado,
	    	   co_ruta_zip = @i_ruta_nombre_archivo,--zip
	    	   co_fecha_zip = getdate()
	     where co_ente = @i_ente
	     and co_banco = @i_banco
	end
	
    -- Hija-detalle
	if (@i_modo = 2) begin
	    if @w_toperacion = 'GRUPAL' and @w_carpeta = 'Inbox' -- E#201454
		begin 
		    update cr_cli_reporte_on_boarding_det set
                   cod_est_gen = @i_estado,
	    	       cod_ruta_gen = @i_ruta_nombre_archivo + @w_extesion, --pdf
	    	       cod_fecha_gen = getdate()
	        where cod_cod_documento = @i_cod_documento
	        and cod_banco = @i_banco
		end
        else 
        begin 
	        update cr_cli_reporte_on_boarding_det set
                   cod_est_gen = @i_estado,
	    	       cod_ruta_gen = @i_ruta_nombre_archivo + @w_extesion, --pdf
	    	       cod_fecha_gen = getdate()
	        where cod_ente = @i_ente
	        and cod_cod_documento = @i_cod_documento
	        and cod_banco = @i_banco
	    end
	end

    -- Padre-envio
	if (@i_modo = 3) begin
	    update cr_cli_reporte_on_boarding set
               co_est_envio = @i_estado,
	    	   co_fecha_envio = getdate()
	     where co_ente = @i_ente
	     and co_banco = @i_banco
	end	
	
	if (@i_modo = 4) begin
	    update cr_cli_reporte_on_boarding_det set
               cod_est_gen = @i_estado,
               cod_est_des_alfresco = @i_estado,
	    	   cod_ruta_gen = @i_ruta_nombre_archivo, --pdf
	    	   cod_fecha_gen = getdate()
	     where cod_ente = @i_ente
	     and cod_cod_documento = @i_cod_documento
	     and cod_banco = @i_banco
	end	

    if (@i_modo = 5) begin
	    if @w_toperacion = 'GRUPAL' and @w_carpeta = 'Inbox' -- E#201454
		begin 
		    update cr_cli_reporte_on_boarding_det set
                   cod_est_carga_alfresco = @i_estado,
                   cod_ruta_gen = @i_ruta_nombre_archivo --pdf
            where cod_cod_documento = @i_cod_documento
	        and cod_banco = @i_banco
		end
        else 
        begin 
            update cr_cli_reporte_on_boarding_det set
                   cod_est_carga_alfresco = @i_estado,
                   cod_ruta_gen = @i_ruta_nombre_archivo --pdf
            where cod_ente = @i_ente
	        and cod_cod_documento = @i_cod_documento
	        and cod_banco = @i_banco
        end
    end
end

return 0

go

