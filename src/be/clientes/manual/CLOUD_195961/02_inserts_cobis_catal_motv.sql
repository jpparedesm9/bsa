/************************************************************************/
/*    ARCHIVO:         02_inserts_cobis_catal_motv.sql                  */
/*    NOMBRE LOGICO:   inserts_cobis_catal_motv.sql                     */
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
/*   Script de inserción de registros para paso de catálogo a fileshare */
/************************************************************************/
/*                            MODIFICACIONES                            */
/*      FECHA           AUTOR                   RAZON                   */
/*      01/02/2023      Daniel Berrio           Emision Inicial         */
/************************************************************************/

use cobis
GO

if exists(select 1 from sysobjects
           where name = 'cl_principal_notificador')
begin

TRUNCATE TABLE cl_principal_notificador

INSERT INTO cl_principal_notificador (pn_nemonico, pn_work_folder, pn_source_folder, pn_username, pn_password, pn_host, pn_port, pn_timeout, pn_key_path, pn_authentication_type, pn_type)
VALUES ('COPYBTI', 'D:\\WorkFolder\\', 'C:\\Cobis\\vbatch\\', null, null, null, null, null, null, null, 'BDD')

INSERT INTO cl_principal_notificador (pn_nemonico, pn_work_folder, pn_source_folder, pn_username, pn_password, pn_host, pn_port, pn_timeout, pn_key_path, pn_authentication_type, pn_type)
VALUES ('CHARITS', 'D:\\WorkFolder\\', null, 'prtrcobi', null, '180.186.172.143', 22, 60000, 'C:\\Notificador\\notification\\keys\\Santander-FileServer.ppk', 'PRIVATE_KEY', 'INTERNET')

end
go

--COBIS_CATAL_MOTV

if not exists(select * from cobis..cl_detalle_notificador where dn_nemonico = 'COPYBTI' AND dn_report_name = 'COBIS_CATAL_MOTV.txt')
begin
    INSERT INTO dbo.cl_detalle_notificador (
    dn_nemonico, dn_report_name, dn_work_folder, 
    dn_source_folder, dn_destination_folder, dn_upload_path,
    dn_file_name_upload, dn_remote_upload_path, dn_retry_upload, 
    dn_to_upload_extract, dn_download_path, dn_download_file_pattern, 
    dn_remote_download_path, dn_remote_download_history_path, dn_retry_download, 
    dn_to_download_extract)
    VALUES ('COPYBTI','COBIS_CATAL_MOTV.txt','D:\\WorkFolder\\CC\\','C:\\Cobis\\vbatch\\regulatorios\\listados\\regulatorios{PPD:ddMMyyyy}b\\','\\\\strcbkprodweb02\\WorkFolder\\CC\\', null, null, null, null, null, null, null, null, null, null, null)
end

if not exists(select * from cobis..cl_detalle_notificador where dn_nemonico = 'CHARITS' AND dn_report_name = 'COBIS_CATAL_MOTV.txt')
begin
    INSERT INTO dbo.cl_detalle_notificador (
    dn_nemonico, dn_report_name, dn_work_folder, 
    dn_source_folder, dn_destination_folder, dn_upload_path, 
    dn_file_name_upload, dn_remote_upload_path, dn_retry_upload, 
    dn_to_upload_extract, dn_download_path, dn_download_file_pattern, 
    dn_remote_download_path, dn_remote_download_history_path, dn_retry_download, 
    dn_to_download_extract)
    VALUES ('CHARITS','COBIS_CATAL_MOTV.txt','D:\\WorkFolder\\CC\\',null,null, '\\planCOBIS\\procesos\\interfaces\\ODS\\', 'COBIS_CATAL_MOTV.txt', '/planCOBIS/procesos/interfaces/ODS', 3, 0, null, null, null, null, null, null)
end

go

