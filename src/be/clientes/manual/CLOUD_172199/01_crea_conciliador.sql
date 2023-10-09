/************************************************************************/
/*    ARCHIVO:         01_crea_conciliador.sql                          */
/*    NOMBRE LOGICO:   crea_conciliador.sql                             */
/*    PRODUCTO:        REGULATORIOS                                     */
/************************************************************************/
/*                     IMPORTANTE                                       */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de COBISCorp.                                                       */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como    */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus    */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.   */
/*  Este programa esta protegido por la ley de   derechos de autor      */
/*  y por las    convenciones  internacionales   de  propiedad inte-    */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir        */
/*  penalmente a los autores de cualquier   infraccion.                 */
/************************************************************************/
/*                     PROPOSITO                                        */
/*   Script de creacion de tablas para conciliador contable             */
/************************************************************************/
/*                            MODIFICACIONES                            */
/*      FECHA           AUTOR                   RAZON                   */
/*      05/04/2022      Daniel Berrio           Emision Inicial         */
/************************************************************************/


use cobis
GO

if exists(select 1 from sysobjects
           where name = 'cl_principal_notificador')
   drop table cl_principal_notificador
go


create table cl_principal_notificador
(
	pn_nemonico 			varchar(15),
	pn_work_folder 			varchar(255),
	pn_source_folder 		varchar(255),
	pn_username 			varchar(50),
	pn_password 			varchar(50),
	pn_host 				varchar(25),
	pn_port 				int,
	pn_timeout 				int,
	pn_key_path 			varchar(255),
	pn_authentication_type 	varchar(15),
	pn_type 				varchar(15)
)
go

if exists(select 1 from sysobjects
           where name = 'cl_detalle_notificador')
   drop table cl_detalle_notificador
go


create table cl_detalle_notificador
(
	dn_nemonico 					varchar(15),
	dn_report_name	 				varchar(50),
	dn_work_folder 					varchar(255),
	dn_source_folder 				varchar(255),
	dn_destination_folder 			varchar(255),
	dn_upload_path 					varchar(255),
	dn_file_name_upload 			varchar(50),
	dn_remote_upload_path 			varchar(255),
	dn_retry_upload 				varchar(50),
	dn_to_upload_extract 			varchar(50),
	dn_download_path 				varchar(255),
	dn_download_file_pattern 		varchar(50),
	dn_remote_download_path 		varchar(255),
	dn_remote_download_history_path varchar(255),
	dn_retry_download 				varchar(50),
	dn_to_download_extract 			varchar(50)
)
go

if exists(select 1 from sysobjects
           where name = 'cl_log_notificador')
   drop table cl_log_notificador
go


create table cl_log_notificador
(
	ln_nemonico 					varchar(15),
	ln_report_name	 				varchar(50),
	ln_generation_date	 			DATETIME,
	ln_gen_process_date				DATETIME,
	ln_upload_date 					DATETIME,
	ln_copy_date 					DATETIME,
	ln_report_pattern				varchar(50),
	ln_status						varchar(10)
)
go
