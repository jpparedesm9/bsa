/************************************************************************/
/*    ARCHIVO:         02_crea_conciliador.sql                          */
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
begin

TRUNCATE TABLE cl_principal_notificador

INSERT INTO cl_principal_notificador (pn_nemonico, pn_work_folder, pn_source_folder, pn_username, pn_password, pn_host, pn_port, pn_timeout, pn_key_path, pn_authentication_type, pn_type)
VALUES ('COPYBTI', 'D:\\WorkFolder\\', 'C:\\Cobis\\vbatch\\', null, null, null, null, null, null, null, 'BDD')

INSERT INTO cl_principal_notificador (pn_nemonico, pn_work_folder, pn_source_folder, pn_username, pn_password, pn_host, pn_port, pn_timeout, pn_key_path, pn_authentication_type, pn_type)
VALUES ('CHARITS', 'D:\\WorkFolder\\', null, 'gctrcobi', null, '107.119.145.79', 22, 60000, 'D:\\Notificador-CER1\\notification\\keys\\SFTPFilesharePREPROD.ppk', 'PRIVATE_KEY', 'INTERNET')

end
go

if exists(select 1 from sysobjects
           where name = 'cl_detalle_notificador')
begin

TRUNCATE TABLE dbo.cl_detalle_notificador
--S1DQ0140_COBIS_D_

INSERT INTO dbo.cl_detalle_notificador (
dn_nemonico, dn_report_name, dn_work_folder, 
dn_source_folder, dn_destination_folder, dn_upload_path,
dn_file_name_upload, dn_remote_upload_path, dn_retry_upload, 
dn_to_upload_extract, dn_download_path, dn_download_file_pattern, 
dn_remote_download_path, dn_remote_download_history_path, dn_retry_download, 
dn_to_download_extract)
VALUES ('COPYBTI','S1DQ0140_COBIS_D_{PPD:yyyyMMdd}.txt','D:\\WorkFolder\\CC\\','C:\\Cobis\\vbatch\\regulatorios\\listados\\','\\\\10.160.38.4\\WorkFolder\\CER1\\CC\\', null, null, null, null, null, null, null, null, null, null, null)

INSERT INTO dbo.cl_detalle_notificador (
dn_nemonico, dn_report_name, dn_work_folder, 
dn_source_folder, dn_destination_folder, dn_upload_path, 
dn_file_name_upload, dn_remote_upload_path, dn_retry_upload, 
dn_to_upload_extract, dn_download_path, dn_download_file_pattern, 
dn_remote_download_path, dn_remote_download_history_path, dn_retry_download, 
dn_to_download_extract)
VALUES ('CHARITS','S1DQ0140_COBIS_D_{PPD:yyyyMMdd}.txt','D:\\WorkFolder\\CER1\\CC\\',null,null, '\\planCOBIS\\procesos\\interfaces\\ODS\\', 'S1DQ0140_COBIS_D_????????.txt', '/planCOBIS/procesos/interfaces/ODS', 3, 0, null, null, null, null, null, null)

--Estructura_COBIS_D_

INSERT INTO dbo.cl_detalle_notificador (
dn_nemonico, dn_report_name, dn_work_folder, 
dn_source_folder, dn_destination_folder, dn_upload_path,
dn_file_name_upload, dn_remote_upload_path, dn_retry_upload, 
dn_to_upload_extract, dn_download_path, dn_download_file_pattern, 
dn_remote_download_path, dn_remote_download_history_path, dn_retry_download, 
dn_to_download_extract)
VALUES ('COPYBTI','Estructura_COBIS_D_{PPD:yyyyMMdd}.txt','D:\\WorkFolder\\CC\\','C:\\Cobis\\vbatch\\regulatorios\\listados\\','\\\\10.160.38.4\\WorkFolder\\CER1\\CC\\', null, null, null, null, null, null, null, null, null, null, null)

INSERT INTO dbo.cl_detalle_notificador (
dn_nemonico, dn_report_name, dn_work_folder, 
dn_source_folder, dn_destination_folder, dn_upload_path, 
dn_file_name_upload, dn_remote_upload_path, dn_retry_upload, 
dn_to_upload_extract, dn_download_path, dn_download_file_pattern, 
dn_remote_download_path, dn_remote_download_history_path, dn_retry_download, 
dn_to_download_extract)
VALUES ('CHARITS','Estructura_COBIS_D_{PPD:yyyyMMdd}.txt','D:\\WorkFolder\\CER1\\CC\\',null,null, '\\planCOBIS\\procesos\\interfaces\\ODS\\', 'Estructura_COBIS_D_????????.txt', '/planCOBIS/procesos/interfaces/ODS', 3, 0, null, null, null, null, null, null)

--COBIS_CUENTA

INSERT INTO dbo.cl_detalle_notificador (
dn_nemonico, dn_report_name, dn_work_folder, 
dn_source_folder, dn_destination_folder, dn_upload_path,
dn_file_name_upload, dn_remote_upload_path, dn_retry_upload, 
dn_to_upload_extract, dn_download_path, dn_download_file_pattern, 
dn_remote_download_path, dn_remote_download_history_path, dn_retry_download, 
dn_to_download_extract)
VALUES ('COPYBTI','COBIS_CUENTA.txt','D:\\WorkFolder\\CC\\','C:\\Cobis\\vbatch\\regulatorios\\listados\\','\\\\10.160.38.4\\WorkFolder\\CER1\\CC\\', null, null, null, null, null, null, null, null, null, null, null)

INSERT INTO dbo.cl_detalle_notificador (
dn_nemonico, dn_report_name, dn_work_folder, 
dn_source_folder, dn_destination_folder, dn_upload_path, 
dn_file_name_upload, dn_remote_upload_path, dn_retry_upload, 
dn_to_upload_extract, dn_download_path, dn_download_file_pattern, 
dn_remote_download_path, dn_remote_download_history_path, dn_retry_download, 
dn_to_download_extract)
VALUES ('CHARITS','COBIS_CUENTA.txt','D:\\WorkFolder\\CER1\\CC\\',null,null, '\\planCOBIS\\procesos\\interfaces\\CONCO\\', 'COBIS_CUENTA.txt', '/planCOBIS/procesos/interfaces/CONCO', 3, 0, null, null, null, null, null, null)

--COBIS_CENTRO

INSERT INTO dbo.cl_detalle_notificador (
dn_nemonico, dn_report_name, dn_work_folder, 
dn_source_folder, dn_destination_folder, dn_upload_path,
dn_file_name_upload, dn_remote_upload_path, dn_retry_upload, 
dn_to_upload_extract, dn_download_path, dn_download_file_pattern, 
dn_remote_download_path, dn_remote_download_history_path, dn_retry_download, 
dn_to_download_extract)
VALUES ('COPYBTI','COBIS_CENTRO.txt','D:\\WorkFolder\\CC\\','C:\\Cobis\\vbatch\\regulatorios\\listados\\','\\\\10.160.38.4\\WorkFolder\\CER1\\CC\\', null, null, null, null, null, null, null, null, null, null, null)

INSERT INTO dbo.cl_detalle_notificador (
dn_nemonico, dn_report_name, dn_work_folder, 
dn_source_folder, dn_destination_folder, dn_upload_path, 
dn_file_name_upload, dn_remote_upload_path, dn_retry_upload, 
dn_to_upload_extract, dn_download_path, dn_download_file_pattern, 
dn_remote_download_path, dn_remote_download_history_path, dn_retry_download, 
dn_to_download_extract)
VALUES ('CHARITS','COBIS_CENTRO.txt','D:\\WorkFolder\\CER1\\CC\\',null,null, '\\planCOBIS\\procesos\\interfaces\\CONCO\\', 'COBIS_CENTRO.txt', '/planCOBIS/procesos/interfaces/CONCO', 3, 0, null, null, null, null, null, null)

--COBIS_EMPRESA

INSERT INTO dbo.cl_detalle_notificador (
dn_nemonico, dn_report_name, dn_work_folder, 
dn_source_folder, dn_destination_folder, dn_upload_path,
dn_file_name_upload, dn_remote_upload_path, dn_retry_upload, 
dn_to_upload_extract, dn_download_path, dn_download_file_pattern, 
dn_remote_download_path, dn_remote_download_history_path, dn_retry_download, 
dn_to_download_extract)
VALUES ('COPYBTI','COBIS_EMPRESA.txt','D:\\WorkFolder\\CC\\','C:\\Cobis\\vbatch\\regulatorios\\listados\\','\\\\10.160.38.4\\WorkFolder\\CER1\\CC\\', null, null, null, null, null, null, null, null, null, null, null)

INSERT INTO dbo.cl_detalle_notificador (
dn_nemonico, dn_report_name, dn_work_folder, 
dn_source_folder, dn_destination_folder, dn_upload_path, 
dn_file_name_upload, dn_remote_upload_path, dn_retry_upload, 
dn_to_upload_extract, dn_download_path, dn_download_file_pattern, 
dn_remote_download_path, dn_remote_download_history_path, dn_retry_download, 
dn_to_download_extract)
VALUES ('CHARITS','COBIS_EMPRESA.txt','D:\\WorkFolder\\CER1\\CC\\',null,null, '\\planCOBIS\\procesos\\interfaces\\CONCO\\', 'COBIS_EMPRESA.txt', '/planCOBIS/procesos/interfaces/CONCO', 3, 0, null, null, null, null, null, null)

--COBIS_CLACON_D_

INSERT INTO dbo.cl_detalle_notificador (
dn_nemonico, dn_report_name, dn_work_folder, 
dn_source_folder, dn_destination_folder, dn_upload_path,
dn_file_name_upload, dn_remote_upload_path, dn_retry_upload, 
dn_to_upload_extract, dn_download_path, dn_download_file_pattern, 
dn_remote_download_path, dn_remote_download_history_path, dn_retry_download, 
dn_to_download_extract)
VALUES ('COPYBTI','COBIS_CLACON_D_{PPD:yyyyMMdd}.txt','D:\\WorkFolder\\CC\\','C:\\Cobis\\vbatch\\regulatorios\\listados\\','\\\\10.160.38.4\\WorkFolder\\CER1\\CC\\', null, null, null, null, null, null, null, null, null, null, null)

INSERT INTO dbo.cl_detalle_notificador (
dn_nemonico, dn_report_name, dn_work_folder, 
dn_source_folder, dn_destination_folder, dn_upload_path, 
dn_file_name_upload, dn_remote_upload_path, dn_retry_upload, 
dn_to_upload_extract, dn_download_path, dn_download_file_pattern, 
dn_remote_download_path, dn_remote_download_history_path, dn_retry_download, 
dn_to_download_extract)
VALUES ('CHARITS','COBIS_CLACON_D_{PPD:yyyyMMdd}.txt','D:\\WorkFolder\\CER1\\CC\\',null,null, '\\planCOBIS\\procesos\\interfaces\\ODS\\', 'COBIS_CLACON_D_????????.txt', '/planCOBIS/procesos/interfaces/ODS', 3, 0, null, null, null, null, null, null)

--COBIS_SO_

INSERT INTO dbo.cl_detalle_notificador (
dn_nemonico, dn_report_name, dn_work_folder, 
dn_source_folder, dn_destination_folder, dn_upload_path,
dn_file_name_upload, dn_remote_upload_path, dn_retry_upload, 
dn_to_upload_extract, dn_download_path, dn_download_file_pattern, 
dn_remote_download_path, dn_remote_download_history_path, dn_retry_download, 
dn_to_download_extract)
VALUES ('COPYBTI','COBIS_SO_{PPD:yyyyMMdd}.txt','D:\\WorkFolder\\CC\\','C:\\Cobis\\vbatch\\regulatorios\\listados\\','\\\\10.160.38.4\\WorkFolder\\CER1\\CC\\', null, null, null, null, null, null, null, null, null, null, null)

INSERT INTO dbo.cl_detalle_notificador (
dn_nemonico, dn_report_name, dn_work_folder, 
dn_source_folder, dn_destination_folder, dn_upload_path, 
dn_file_name_upload, dn_remote_upload_path, dn_retry_upload, 
dn_to_upload_extract, dn_download_path, dn_download_file_pattern, 
dn_remote_download_path, dn_remote_download_history_path, dn_retry_download, 
dn_to_download_extract)
VALUES ('CHARITS','COBIS_SO_{PPD:yyyyMMdd}.txt','D:\\WorkFolder\\CER1\\CC\\',null,null, '\\planCOBIS\\procesos\\interfaces\\CONCO\\', 'COBIS_SO_????????.txt', '/planCOBIS/procesos/interfaces/CONCO', 3, 0, null, null, null, null, null, null)

--COBIS_MOV_

INSERT INTO dbo.cl_detalle_notificador (
dn_nemonico, dn_report_name, dn_work_folder, 
dn_source_folder, dn_destination_folder, dn_upload_path,
dn_file_name_upload, dn_remote_upload_path, dn_retry_upload, 
dn_to_upload_extract, dn_download_path, dn_download_file_pattern, 
dn_remote_download_path, dn_remote_download_history_path, dn_retry_download, 
dn_to_download_extract)
VALUES ('COPYBTI','COBIS_MOV_{PPD:yyyyMMdd}.txt','D:\\WorkFolder\\CC\\','C:\\Cobis\\vbatch\\regulatorios\\listados\\','\\\\10.160.38.4\\WorkFolder\\CER1\\CC\\', null, null, null, null, null, null, null, null, null, null, null)

INSERT INTO dbo.cl_detalle_notificador (
dn_nemonico, dn_report_name, dn_work_folder, 
dn_source_folder, dn_destination_folder, dn_upload_path, 
dn_file_name_upload, dn_remote_upload_path, dn_retry_upload, 
dn_to_upload_extract, dn_download_path, dn_download_file_pattern, 
dn_remote_download_path, dn_remote_download_history_path, dn_retry_download, 
dn_to_download_extract)
VALUES ('CHARITS','COBIS_MOV_{PPD:yyyyMMdd}.txt','D:\\WorkFolder\\CER1\\CC\\',null,null, '\\planCOBIS\\procesos\\interfaces\\CONCO\\', 'COBIS_MOV_????????.txt', '/planCOBIS/procesos/interfaces/CONCO', 3, 0, null, null, null, null, null, null)

--COBIS_SM_

INSERT INTO dbo.cl_detalle_notificador (
dn_nemonico, dn_report_name, dn_work_folder, 
dn_source_folder, dn_destination_folder, dn_upload_path,
dn_file_name_upload, dn_remote_upload_path, dn_retry_upload, 
dn_to_upload_extract, dn_download_path, dn_download_file_pattern, 
dn_remote_download_path, dn_remote_download_history_path, dn_retry_download, 
dn_to_download_extract)
VALUES ('COPYBTI','COBIS_SM_{PPD:yyyyMMdd}.txt','D:\\WorkFolder\\CC\\','C:\\Cobis\\vbatch\\regulatorios\\listados\\','\\\\10.160.38.4\\WorkFolder\\CER1\\CC\\', null, null, null, null, null, null, null, null, null, null, null)

INSERT INTO dbo.cl_detalle_notificador (
dn_nemonico, dn_report_name, dn_work_folder, 
dn_source_folder, dn_destination_folder, dn_upload_path, 
dn_file_name_upload, dn_remote_upload_path, dn_retry_upload, 
dn_to_upload_extract, dn_download_path, dn_download_file_pattern, 
dn_remote_download_path, dn_remote_download_history_path, dn_retry_download, 
dn_to_download_extract)
VALUES ('CHARITS','COBIS_SM_{PPD:yyyyMMdd}.txt','D:\\WorkFolder\\CER1\\CC\\',null,null, '\\planCOBIS\\procesos\\interfaces\\CONCO\\', 'COBIS_SM_????????.txt', '/planCOBIS/procesos/interfaces/CONCO', 3, 0, null, null, null, null, null, null)

--COBIS_SDOLAR_

INSERT INTO dbo.cl_detalle_notificador (
dn_nemonico, dn_report_name, dn_work_folder, 
dn_source_folder, dn_destination_folder, dn_upload_path,
dn_file_name_upload, dn_remote_upload_path, dn_retry_upload, 
dn_to_upload_extract, dn_download_path, dn_download_file_pattern, 
dn_remote_download_path, dn_remote_download_history_path, dn_retry_download, 
dn_to_download_extract)
VALUES ('COPYBTI','COBIS_SDOLAR_{PPD:yyyyMMdd}.txt','D:\\WorkFolder\\CC\\','C:\\Cobis\\vbatch\\regulatorios\\listados\\','\\\\10.160.38.4\\WorkFolder\\CER1\\CC\\', null, null, null, null, null, null, null, null, null, null, null)

INSERT INTO dbo.cl_detalle_notificador (
dn_nemonico, dn_report_name, dn_work_folder, 
dn_source_folder, dn_destination_folder, dn_upload_path, 
dn_file_name_upload, dn_remote_upload_path, dn_retry_upload, 
dn_to_upload_extract, dn_download_path, dn_download_file_pattern, 
dn_remote_download_path, dn_remote_download_history_path, dn_retry_download, 
dn_to_download_extract)
VALUES ('CHARITS','COBIS_SDOLAR_{PPD:yyyyMMdd}.txt','D:\\WorkFolder\\CER1\\CC\\',null,null, '\\planCOBIS\\procesos\\interfaces\\CONCO\\', 'COBIS_SDOLAR_????????.txt', '/planCOBIS/procesos/interfaces/CONCO', 3, 0, null, null, null, null, null, null)

--COBIS_MOVLAR_

INSERT INTO dbo.cl_detalle_notificador (
dn_nemonico, dn_report_name, dn_work_folder, 
dn_source_folder, dn_destination_folder, dn_upload_path,
dn_file_name_upload, dn_remote_upload_path, dn_retry_upload, 
dn_to_upload_extract, dn_download_path, dn_download_file_pattern, 
dn_remote_download_path, dn_remote_download_history_path, dn_retry_download, 
dn_to_download_extract)
VALUES ('COPYBTI','COBIS_MOVLAR_{PPD:yyyyMMdd}.txt','D:\\WorkFolder\\CC\\','C:\\Cobis\\vbatch\\regulatorios\\listados\\','\\\\10.160.38.4\\WorkFolder\\CER1\\CC\\', null, null, null, null, null, null, null, null, null, null, null)

INSERT INTO dbo.cl_detalle_notificador (
dn_nemonico, dn_report_name, dn_work_folder, 
dn_source_folder, dn_destination_folder, dn_upload_path, 
dn_file_name_upload, dn_remote_upload_path, dn_retry_upload, 
dn_to_upload_extract, dn_download_path, dn_download_file_pattern, 
dn_remote_download_path, dn_remote_download_history_path, dn_retry_download, 
dn_to_download_extract)
VALUES ('CHARITS','COBIS_MOVLAR_{PPD:yyyyMMdd}.txt','D:\\WorkFolder\\CER1\\CC\\',null,null, '\\planCOBIS\\procesos\\interfaces\\CONCO\\', 'COBIS_MOVLAR_????????.txt', '/planCOBIS/procesos/interfaces/CONCO', 3, 0, null, null, null, null, null, null)

end
go

