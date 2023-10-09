/*************************************************************************/
/*   Archivo:              sp_conciliador.sp                             */
/*   Stored procedure:     sp_conciliador                                */
/*   Base de datos:        cob_conta_super                               */
/*   Producto:             Regulatorios                                  */
/*   Disenado por:         Dario Cumbal - Daniel Berrio                  */
/*   Fecha de escritura:   Abril 2022                                    */
/*************************************************************************/
/*                                  IMPORTANTE                           */
/*   Este programa es parte de los paquetes bancarios propiedad de       */
/*   'COBIS'.                                                            */
/*   Su uso no autorizado queda expresamente prohibido asi como          */
/*   cualquier alteracion o agregado hecho por alguno de sus             */
/*   usuarios sin el debido consentimiento por escrito de la             */
/*   Presidencia Ejecutiva de COBIS o su representante legal.            */
/*************************************************************************/
/*                                   PROPOSITO                           */
/*   Consulta tablas de conciliador de acuerdo a la operación ingresada  */
/*                                                                       */
/*       Parametros de Entrada                                           */
/*			Tipo de operacion (C) Consulta                               */
/*                            (A) Actualizacion de estado a Terminado    */
/*                            (E) Actualizacion de estado a Error        */
/*                                                                       */
/*			Tipo de registros (C)Copia (U)Carga                          */
/*************************************************************************/
/*                             MODIFICACION                              */
/*    FECHA                 AUTOR                 RAZON                  */
/*    04/Abril/2022          DBM              emision inicial            */
/*************************************************************************/


USE [cobis]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID ('dbo.sp_conciliador') IS NOT NULL
	DROP PROCEDURE dbo.sp_conciliador
GO

CREATE proc [dbo].[sp_conciliador](
   @i_tipo_operacion char(1),
   @i_tipo_registros char(1),
   @i_nombre_archivo varchar(50) = null
)
AS

DECLARE
@w_error				  int,
@w_fecha_reciente         DATETIME

SELECT @w_fecha_reciente = MAX(ln_gen_process_date) FROM cobis..cl_log_notificador

if @i_tipo_operacion != 'C' and @i_tipo_operacion != 'A' and @i_tipo_operacion != 'E'
begin
   select 
   @w_error = 70203
   print 'ERROR: OPERACIÓN NO VÁLIDA'
   return 1
END


if @i_tipo_registros != 'C' and @i_tipo_registros != 'U'
begin
   select 
   @w_error = 70203
   print 'ERROR: OPERACIÓN NO VÁLIDA'
   return 1
END

IF OBJECT_ID('dbo.cl_detalle_notificador') IS NOT NULL
BEGIN
	IF @i_tipo_operacion = 'C'
	BEGIN
		IF @i_tipo_registros = 'C'
		BEGIN
			SELECT ln_nemonico,	ln_report_name,	ln_generation_date,
			ln_gen_process_date,ln_upload_date,ln_copy_date,
			ln_status,pn_work_folder,pn_source_folder,
			pn_username,pn_password,pn_host,
			pn_port,pn_timeout,pn_key_path,
			pn_authentication_type,pn_type,dn_report_name,
			dn_work_folder,dn_source_folder,dn_destination_folder,
			dn_upload_path,dn_file_name_upload,dn_remote_upload_path,
			ISNULL(dn_retry_upload,0),ISNULL(dn_to_upload_extract,0),dn_download_path,
			dn_download_file_pattern,dn_remote_download_path,dn_remote_download_history_path,
			ISNULL(dn_retry_download,0),ISNULL(dn_to_download_extract,0)
			FROM cobis..cl_log_notificador, cobis..cl_principal_notificador, cobis..cl_detalle_notificador
			WHERE pn_nemonico = dn_nemonico
			AND ln_nemonico = pn_nemonico
			AND pn_nemonico = 'COPYBTI'
			AND ln_report_pattern = dn_report_name
			AND ln_status IS NULL
		END
		IF @i_tipo_registros = 'U'
		BEGIN
			SELECT ln_nemonico,	ln_report_name,	ln_generation_date,
			ln_gen_process_date,ln_upload_date,ln_copy_date,
			ln_status,pn_work_folder,pn_source_folder,
			pn_username,pn_password,pn_host,
			pn_port,pn_timeout,pn_key_path,
			pn_authentication_type,pn_type,dn_report_name,
			dn_work_folder,dn_source_folder,dn_destination_folder,
			dn_upload_path,dn_file_name_upload,dn_remote_upload_path,
			ISNULL(dn_retry_upload,0),ISNULL(dn_to_upload_extract,0),dn_download_path,
			dn_download_file_pattern,dn_remote_download_path,dn_remote_download_history_path,
			ISNULL(dn_retry_download,0),ISNULL(dn_to_download_extract,0)
			FROM cobis..cl_log_notificador, cobis..cl_principal_notificador, cobis..cl_detalle_notificador
			WHERE pn_nemonico = dn_nemonico
			AND ln_nemonico = pn_nemonico
			AND pn_nemonico = 'CHARITS'
			AND ln_report_pattern = dn_report_name
			AND (ln_status = 'E' OR ln_status IS NULL)
			AND ln_gen_process_date = @w_fecha_reciente
		END
	END
	IF @i_tipo_operacion = 'A'
	BEGIN
		IF @i_tipo_registros = 'C'
		BEGIN
			UPDATE cobis..cl_log_notificador
			SET
			ln_status = 'T',
			ln_copy_date = GETDATE()
			WHERE ln_nemonico = 'COPYBTI'
			AND ln_report_name = @i_nombre_archivo
			AND ln_status is null 
		END
		IF @i_tipo_registros = 'U'
		BEGIN
			UPDATE cobis..cl_log_notificador
			SET
			ln_status = 'T',
			ln_upload_date = GETDATE()
			WHERE ln_nemonico = 'CHARITS'
			AND ln_report_name = @i_nombre_archivo
			AND ln_status is null 
		END
	END
	IF @i_tipo_operacion = 'E'
	BEGIN
		IF @i_tipo_registros = 'C'
		BEGIN
			UPDATE cobis..cl_log_notificador
			SET
			ln_status = 'E',
			ln_copy_date = GETDATE()
			WHERE ln_nemonico = 'COPYBTI'
			AND ln_report_name = @i_nombre_archivo
			AND ln_status is null 
		END
		IF @i_tipo_registros = 'U'
		BEGIN
			UPDATE cobis..cl_log_notificador
			SET
			ln_status = 'E',
			ln_upload_date = GETDATE()
			WHERE ln_nemonico = 'CHARITS'
			AND ln_report_name = @i_nombre_archivo
			AND ln_status is null 
		END
	END
		RETURN
END
